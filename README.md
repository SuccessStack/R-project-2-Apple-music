# 🎧 Global App Reviews Analysis & Dashboard (Apple Music Focus)

Welcome to the **Apple Music App Reviews Dashboard** — an interactive data exploration project that analyzes user reviews and rating trends across leading music streaming apps. Built with R Shiny, this dashboard helps uncover key insights from public user sentiment, app ratings, and country-level trends.

This project provides stakeholders and data enthusiasts with an intuitive and engaging interface to understand global perceptions of apps like **Apple Music, Spotify, Deezer, and SoundCloud**.

---

## 🎯 Project Objective

This project was created to:

- Analyze app reviews and ratings for Apple Music and competitors
- Identify countries with the most and least engagement
- Visualize how user ratings vary over time
- Examine how different apps compare in user perception
- Provide a dynamic dashboard interface using R Shiny

---

## 📁 Dataset Description

**Source:** Public Apple Music review dataset (CSV)

### Fields include:

- `app`: Name of the music app (e.g., Apple Music, Spotify)
- `country`: Country where the review was submitted
- `title`: Review headline/title
- `review`: Full review text
- `rating`: Numeric rating (1 to 5 stars)
- `date`: Date of review submission

---

## 🔍 Key Questions Addressed

### 🟢 What are the most reviewed music apps by country?

- **Apple Music** and **Spotify** receive the majority of reviews across most countries.
- The **United States**, **Mexico**, and **India** have the highest number of submitted reviews.
- Countries like **France**, **Brazil**, and **Germany** follow closely behind.

### 🟡 How do user ratings differ between apps?

- **Spotify** shows a higher concentration of 5-star reviews, indicating strong brand loyalty.
- **Apple Music** reviews are more mixed, with both high and low ratings frequent.
- **Deezer** and **SoundCloud** tend to receive more polarized feedback (1 or 5 stars).

### 🔴 Which countries leave the most 1-star vs. 5-star ratings?

- The **United States** has both the **highest number of 5-star and 1-star reviews**, reflecting a broad range of user experiences.
- **Mexico** and **Brazil** also show a high proportion of **extreme ratings**.
- **European countries** tend to cluster around moderate scores (3–4 stars).

### 🟠 How has public perception changed over time?

- Reviews **peaked in early 2025**, possibly due to new feature launches or app updates.
- The **monthly average rating** remained fairly stable but showed dips during product updates.
- **Rating spikes** align with promotional campaigns and seasonal usage.

### 🟣 What are the most common themes in review titles?

Based on word cloud analysis:
- Positive words like `"great"`, `"love"`, `"awesome"` dominate 5-star titles.
- Negative themes include `"crash"`, `"bug"`, `"ads"`, `"subscription"`.
- Frequent topics include `"music"`, `"playlist"`, `"download"`, `"offline"`.

### 🔵 Which countries show higher satisfaction levels overall?

- **Portugal**, **UAE**, and **Germany** show consistently **high average ratings** (above 4.3).
- **India**, **Mexico**, and parts of **South America** have more diverse and lower ratings.
- **Country-level averages** suggest cultural and infrastructure influences on app satisfaction.

---

## 📌 Tools & Technologies

- **R** – primary programming language
- **Shiny** – for building the interactive dashboard
- **dplyr / tidyr / lubridate** – for data cleaning and transformation
- **ggplot2 / plotly** – for visual analytics
- **DT** – for rendering searchable review tables
- **tm / wordcloud** – for basic text analysis

---

## 📊 Dashboard Features

- 📍 **Rating Distribution** — Bar chart of ratings from 1 to 5 stars
- 🌎 **Country Filter** — Focus on specific nations
- 🕐 **Time Trends** — See how reviews evolve monthly
- 🧠 **Review Word Cloud** — Highlights common words in titles
- 🌐 **Top Countries Chart** — Countries with the most reviews
- 🎵 **App Comparison** — Compare average ratings across apps
- 📈 **Monthly Avg Rating Line Chart** — Visualize sentiment shifts

---

## 💡 Methodology

- **Data Cleaning** — Filtered out blanks, formatted dates
- **Feature Engineering** — Extracted month/year from review dates
- **Aggregations** — Summarized by app, country, and rating
- **Visualization** — Created reactive, interactive plots
- **Text Mining** — Tokenized review titles to form a word cloud

---

## 📈 How to Use the Dashboard

1. Clone or download this repository  
2. Open `app.R` in **RStudio** or any R environment  
3. Install required packages (if not already installed):

```r
install.packages(c("shiny", "dplyr", "ggplot2", "plotly", "lubridate", "DT", "tm", "wordcloud"))
