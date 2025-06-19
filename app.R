# app.R

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(DT)
library(wordcloud)
library(tm)

# Load and clean data
apple_reviews <- read.csv("app_store_music_reviews.csv", stringsAsFactors = FALSE)

apple_reviews <- apple_reviews %>%
  filter(!is.na(app) & !is.na(review) & review != "") %>%
  mutate(date = as.POSIXct(date, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
         year = year(date),
         month = month(date, label = TRUE, abbr = TRUE),
         month_year = format(date, "%Y-%m"))

# ---------------- UI ----------------
ui <- fluidPage(
  tags$style(HTML("
    body {
      background-color: #f5f5f5;
    }
    .well {
      background-color: #ffffff;
    }
    .tabbable > .nav > li > a {
      background-color: #e3e3e3;
      color: #000;
      font-weight: bold;
    }
    .tabbable > .nav > li[class=active] > a {
      background-color: #cccccc !important;
      color: #000 !important;
    }
    .form-control, .selectize-input {
      background-color: #ffffff;
    }
    .dataTables_wrapper {
      background-color: #ffffff;
    }
  ")),
  
  titlePanel("🎵 Apple Music App Reviews Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_app", "Choose App:",
                  choices = unique(apple_reviews$app),
                  selected = "Apple Music", multiple = TRUE),
      selectInput("selected_country", "Choose Country:",
                  choices = unique(apple_reviews$country),
                  selected = "US", multiple = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Rating Distribution", plotlyOutput("ratingPlot")),
        tabPanel("Review Table", DTOutput("reviewTable")),
        tabPanel("Monthly Trend", plotlyOutput("timeTrend")),
        tabPanel("More Insights",
                 fluidRow(
                   column(6, plotlyOutput("avgRatingApp")),
                   column(6, plotlyOutput("topCountries"))
                 ),
                 fluidRow(
                   column(6, plotOutput("wordCloud")),
                   column(6, plotlyOutput("monthlyAvgRating"))
                 )
        )
      )
    )
  )
)

# ---------------- Server ----------------
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    apple_reviews %>%
      filter(app %in% input$selected_app,
             country %in% input$selected_country)
  })
  
  output$ratingPlot <- renderPlotly({
    data <- filtered_data()
    p <- ggplot(data, aes(x = factor(rating))) +
      geom_bar(fill = "steelblue") +
      labs(title = "Rating Distribution", x = "Rating", y = "Count")
    ggplotly(p)
  })
  
  output$reviewTable <- renderDT({
    datatable(filtered_data() %>% select(app, country, title, review, rating, date),
              options = list(pageLength = 10), filter = "top")
  })
  
  output$timeTrend <- renderPlotly({
    data <- filtered_data() %>%
      count(year, month) %>%
      mutate(month_year = paste(month, year))
    
    p <- ggplot(data, aes(x = month_year, y = n, group = 1)) +
      geom_line(color = "tomato") +
      labs(title = "Review Frequency Over Time", x = "Month-Year", y = "Number of Reviews") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    ggplotly(p)
  })
  
  output$avgRatingApp <- renderPlotly({
    data <- filtered_data() %>%
      group_by(app) %>%
      summarise(avg_rating = round(mean(rating), 2))
    
    p <- ggplot(data, aes(x = reorder(app, -avg_rating), y = avg_rating, fill = app)) +
      geom_col() +
      labs(title = "Average Rating by App", x = "App", y = "Average Rating") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$topCountries <- renderPlotly({
    data <- apple_reviews %>%
      count(country) %>%
      arrange(desc(n)) %>%
      top_n(10)
    
    p <- ggplot(data, aes(x = reorder(country, n), y = n, fill = country)) +
      geom_col() +
      coord_flip() +
      labs(title = "Top Countries by Number of Reviews", x = "Country", y = "Count") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$wordCloud <- renderPlot({
    titles <- tolower(filtered_data()$title)
    titles <- removePunctuation(titles)
    titles <- removeWords(titles, stopwords("en"))
    wordcloud(titles, max.words = 100, colors = brewer.pal(8, "Dark2"))
  })
  
  output$monthlyAvgRating <- renderPlotly({
    data <- filtered_data() %>%
      group_by(month_year) %>%
      summarise(avg_rating = mean(rating)) %>%
      arrange(month_year)
    
    p <- ggplot(data, aes(x = month_year, y = avg_rating, group = 1)) +
      geom_line(color = "darkgreen") +
      geom_point() +
      labs(title = "Monthly Average Rating", x = "Month-Year", y = "Avg Rating") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    ggplotly(p)
  })
}

shinyApp(ui, server)
