library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(bslib)

server <- function(input, output) {
  
  bs_themer()
  
  output$myImage <- renderImage({
    filename <- normalizePath(file.path('sleep_quality.png'))
    list(src = filename,
         alt = paste("myImage", input$n))
  }, deleteFile = FALSE)
  
  output$range <- renderPrint({ input$ageRange })
  
  sleep_dataset <- read_csv("Sleep_health_and_lifestyle_dataset.csv")
  
  output$myPlot <- renderPlotly({
    sleep_dataset <- sleep_dataset %>%
      filter((Age >= input$ageRange[1] & Age <= input$ageRange[2]))
    
    sleep_dataset <- sleep_dataset %>%
      group_by(Gender, Age) %>%
      summarize(`Average Sleep Quality` = mean(`Quality of Sleep`)) %>%
      ungroup()
    
    plot <- ggplot(sleep_dataset, aes(x = Age, y = `Average Sleep Quality`, color = Gender)) +
      geom_line() +
      labs(title = "Sleep Quality Comparison by Gender and Age",
           x = "Age", y = "Sleep Quality")
    
    ggplotly(plot)
  })
  
  output$purpose <- renderText({
    "The purpose of this chart is to reveal a comparison of the average quality of sleep for women and men of different ages (27 to 59). The red line represents women and the blue line represents men. Based on this chart, I believe that there is no direct correlation between age and gender and quality of sleep. there is no overall average quality of sleep for one gender that is higher than the other, also quality of sleep does not increase or decrease with age. The lowest average sleep quality score for men is 4.8 at age 28 and the lowest average sleep quality score for women is 4 at age 34."
  })
  
  output$selectedDisorders <- renderPrint({ input$sleepDisorders })
  
  output$myPlot2 <- renderPlotly({
    filtered_dataset <-  sleep_dataset %>%
      filter(`Sleep Disorder` %in% input$sleepDisorders)
    
    plot <- ggplot(filtered_dataset, aes(x = `Quality of Sleep`, fill = `Sleep Disorder`)) +
      geom_histogram(bins = 13, position = "dodge", alpha = 0.8) +
      labs(title = "Sleep Disorders and Sleep Quality Score", x = "Quality of Sleep", y = "Count")
    ggplotly(plot)
  })
  
  output$purpose2 <- renderText({
    "The purpose of this chart is to visualize the relationship between sleep disorders and sleep quality. In the high sleep quality scores, 8 to 10, the percentage of those without sleep disorders is very high, which explains that observers without sleep disorders usually have better sleep quality. And in the medium sleep quality score which is 5 to 7, the percentage of those without sleep disorders is still very high, but these observations are usually accompanied by some Insomnia and Sleep Apnea. And in the low sleep quality scores, which are 1 to 4, the proportion of Insomnia and Sleep Apnea sufferers increased significantly. This graph illustrates that Sleep Apnea and Insomnia are two sleeping disorders that can seriously affect sleep quality. Its distribution in the population is usually found in those with low sleep quality scores, which suggests that these two sleeping disorders prevented the studied individuals from having a better quality of sleep."
  })
  
  filteredData <- reactive({
    if (input$gender == "Both") {
      sleep_dataset
    } else {
      sleep_dataset %>% filter(Gender == input$gender)
    }
  })
  
  output$scatterPlot <- renderPlotly({
    plot <- ggplot(filteredData(), aes(x = `Physical Activity Level`, y = `Quality of Sleep`)) +
      geom_point(aes(color = `Physical Activity Level`)) +
      scale_color_gradient(low = "lightblue", high = "darkblue") +
      geom_smooth(method = "lm", se = FALSE, color = "black") +
      labs(
        title = "Impact of Daily Physical Activity Level on Sleep Quality",
        x = "Physical Activity Level (minutes/day)",
        y = "Sleep Quality",
        color = "Physical Activity Level")
    ggplotly(plot)
  })
  
  output$purpose3 <- renderText({
    "The main purpose of this chart is to reveal the correlation between physical activity level and sleep quality. In Chart 2, the graph shows the effect of daily physical activity levels（in minutes per day), on perceived sleep quality, according to. Scattered pot showed that there was a positive correlation between daily physical activity level and sleep quality, that is, more physical activity. It usually represents a higher quality of sleep. The recreation line means that the positive correlation is very significant, and its data distribution represents the distribution of sleep quality under different activity levels, which further supports the positive effect of physical activity on sleep quality. This graph shows the positive impact of daily physical activity levels on sleep quality."
  })
  
  output$authors <- renderText ({
    "Xiaoyuan Ye (xiaoyy27@uw.edu), Alley Wu (twu29@uw.edu), Sijia Wu (sw278@uw.edu)"})
  
  output$date <- renderText({"Spring 2024"})
  
  output$abstract <- renderText({
    "With the development of the times, the quality of sleep among modern individuals is affected by many factors. As for which factors affect it is a debatable question. This is important because understanding the sleep differences of people can better help us promote the improvement of sleep quality. Accordingly, we plan to build a project to examine the database and study the correlation between sleep quality and gender, stress level, physical activity, and age."
  })
  
  output$keywords <- renderText({"Sleep Quality, Lifestyle and Sleep, Stress Level, Age-Related Sleep Patterns"})
  
  output$introduction1 <- renderText({"Our project explores the correlation between various factors and sleep quality and disease. We are particularly interested in understanding how gender, stress levels, physical activity, and age influence sleep quality and the occurrence of sleep disorders. We will analyze three research questions: Does gender and age affect sleep quality? Does people’s daily physical activity have an impact on sleep quality? Does sleep quality affect the occurrence of sleep disorders?"})
  output$introduction2 <- renderText({"We believe these three questions are essential because sleep plays a critical role in human beings’ health. Every individual needs sleep to obtain energy and keep the body’s functions functioning properly. Lack of sleep may affect our bodies’s metabolism and endocrine system. Moreover, sleep not only affects people's physical health but also plays a vital role in people's mental health. Lack of sleep can prevent people from regulating their emotions and concentrating well, and can also affect people's memory and learning abilities. By understanding the factors that influence sleep quality, researchers and scientists can implement and design targeted treatments to help individuals improve sleep quality and reduce the risk of sleep disorders. We want to know what factors will mainly affect sleep quality."})
  output$relatedwork1 <- renderText({"There are many studies on sleep quality around the world, We would like to further study the performance of sleep in different groups of people and how it is affected by factors such as sleep quality and gender, stress level, physical activity, and age. Based on this goal, we found the following related articles. In the paper Age and gender effects on the Prevalence of Poor Sleep Quality in the Adult Population, it is shown that women's sleep quality is more likely to deteriorate over time. women's sleep quality is more likely to deteriorate over time. Based on the information provided by National Libray Medicine(NLM), While short bursts of exercise have a minimal effect on sleep, for adults, a regular and consistent exercise program can be beneficial to the quality and length of sleep by stimulating an increase in melatonin and by reducing stress and improving mood, all factors that can be effective in reducing and avoiding sleep order. Moreover, according to AMERICAN PSYCHOLOGICAL ASSOCIATION in the article Are Teens Adopting Adults' Stress Habits? stress and sleep quality go both ways, and for adolescents, lack of adequate sleep can lead to a variety of health and psychological problems, and they are more likely to be affected by stress than adults. “Millennials and Gen Xers are also more likely to report feeling sad or depressed because of stress (Millennials: 47 percent; Gen Xers: 42 percent; Boomers: 29 percent). percent; Boomers: 29 percent; Matures: 15 percent)”(American Psychological Association)."})
  output$relatedwork2 <- renderText({"Citation: J. J. Madrid-Valero, J. M. Martínez-Selva, B. R. do Couto, J. F. Sánchez-Romera, and J. R. Ordoñana, “Age and gender effects on the prevalence of poor sleep quality in the adult population,” Gaceta Sanitaria, https://www.scielosp.org/article/gs/2017.v31n1/18-22/en/?uid=680b54f39b (accessed Apr. 30, 2024). ”M. A. Alnawwar et al., “The effect of physical activity on sleep quality and sleep disorder: A systematic review,” Cureus, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10503965/ (accessed Apr. 30, 2024). American Psychological Association, Stress in America™: Are Teens Adopting Adults’ Stress Habits? Feb. 2014. [Online]. Available: https://www.apa.org/news/press/releases/stress/2013/sleep#:~:text=On%20average%2C%20adults%20with%20lower,enough%20sleep%20(79%20percent%20vs. (Accessed: 30-Apr-2024)."})
  
  output$dataset <- renderText({"We found these data in Google Datasets. It's from a website called Kaggle. The URL to the webset: https://www.kaggle.com/datasets/uom190346a/sleep-health-and-lifestyle-dataset?resource=download"})
  output$dataset2 <- renderText({"The data was updated by LAKSIKA THARMALINGAM."})
  output$dataset3 <- renderText({"The data was synthetic by Laksika Tharmalingam for illustrative purpose. She states that it does not originate from any specific individual or external source."})
  output$dataset4 <- renderText({"The reason that the data were collected is because Laksika wants to illustrate the relationships between gender, age, occupation, sleep duration, quality of sleep, physical activity level, stress levels, BMI category, blood pressure, heart rate, daily steps, and the presence or absence of sleep disorders."})
  output$dataset5 <- renderText({"There are 374 rows in our data."})
  output$dataset6 <- renderText({"There are 12 columns in our data."})
  output$dataset7 <- renderText({"There is no ethical questions or questions of power we need to consider when we working with this data."})
  output$dataset8 <- renderText({"There are a few possible limitations with this data. First, this data was synthetic by the author which means these data may have an impact on the final results we expect. Because this dataset involves information about sleep quality, physical activity, and stress levels that are often subjectively provided by the participants for whom the data was collected, it may be subject to biases such as recall bias or social desirability bias. They may not remember accurately or may deliberately change their responses, or they may provide factors that are too subjective. At the same time, there have been some problems with the sampling method. It appears that the representativeness of this data set depends on how participants were selected, rather than the random sampling method, which could introduce selection bias and cause the results to fall short of expectations. In more specific, the limitations of this dataset mainly stem from its synthetic nature. This means that the data is artificially constructed rather than collected from real-world observations, potentially affecting the reliability and applicability of insights derived from this dataset to actual populations. Additionally, questions related to self-reported data such as sleep quality, physical activity, and stress levels are also important. These subjective measurements can introduce biases such as recall bias (where participants may not remember past events accurately) and social desirability bias (which occurs when participants modify their responses to appear more favorable). Additionally, there are concerns about the sampling method used to generate this dataset. The lack of random sampling may lead to selection bias that distorts the representativeness of the data set and may lead to conclusions that do not withstand scrutiny or wider application. All these factors combined may seriously affect the conclusions drawn from analyzes using this dataset, and results need to be interpreted with caution and consideration of their implications for real-world scenarios."})
  
  output$implications <- renderText({"Although our dataset was not created by technologists, designers, and policymakers. But if the Sleep Health and Lifestyle Dataset research questions are effectively answered, the implications for technologists, designers, and policymakers could be widespread and impactful. For technologists, these findings could lead to the development of advanced algorithms that could improve the accuracy and personalization of sleep-tracking devices. These insights can be used to tailor recommendations for improving sleep based on individual lifestyle factors such as physical activity and stress levels. At the same time, designers can use this data to create more intuitive interfaces for health monitoring devices, making them easier to use and more attractive to viewers. This could include features that provide actionable insights based on a user's specific sleep patterns and health data. For policymakers, comprehensive analyzes can inform public health guidelines aimed at improving population sleep hygiene. This could lead to initiatives aimed at promoting regular physical activity, stress management and healthier sleep habits. Additionally, understanding the prevalence and impact of sleep disorders can help inform health policy and resource allocation to support sleep health programs. These combined efforts can promote a healthier population, lower health care costs, and increase overall productivity and well-being."})
  
  output$challenges <- renderText({"We believe our team may encounter several challenges and limitations. The results of our final analysis cannot be directly used in medical research because these datasets are synthetic and designed for educational purposes. However, the dataset is very similar to a data set with real medical results, so it can be used as our own reference. Additionally, while there were no missing data or outliers in the dataset, we did not know the definition criteria for several variables, such as how stress levels were judged. Each person's definition of stress level can be very different. While some people experience a lot of stress and that person feels like their stress level only counts as a 2, the same stress level might count as a 6 for someone else. Furthermore, because the data in the dataset are synthetic rather than collected through a set of experiments, our final results cannot directly indicate that a variable has a causal effect on sleep quality. Finally, since none of our team members are very familiar with R, the analysis methods we use may not be the most efficient and best."})
  
  output$summary <- renderText({"According to the dataset, participants averaged 6.8 hours of sleep per night, with a median of 7 hours, a standard deviation of 1.5 hours, and a range of sleep duration from 4 hours to 9 hours. Participants averaged 45 days of physical activity per day, with a median of 40 minutes and a standard division of 20. The average stress level was 5.5, the median was 6 to 30, the division was 2, and the stress level ranged from 1 to 10. The most common sleep disorders, according to participant data, are insomnia and sleep apnea, which are more common in middle-aged and elderly people. According to the data, there is a very strong correlation between sleep quality and sleep duration, which is 0.88, while there is a negative correlation between stress level and sleep quality, which is -0.9. The correlation between physical activity level and perceived sleep quality was small (0.19). From the data of these studies, it can be found that longer sleep time, less stress levels, younger age, or higher levels of physical activity can positively affect sleep quality."})
}
