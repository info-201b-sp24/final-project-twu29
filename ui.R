library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(bslib)

intro_tab <- tabPanel("Introduction",
              titlePanel("Introduction"),
              mainPanel(
                imageOutput("myImage"),
                h3(tags$b("Authors"), class = "section-header"),
                uiOutput("authors"),
                h3(tags$b("Date"), class = "section-header"),
                uiOutput("date"),
                h3(tags$b("Abstract"), class = "section-header"),
                uiOutput("abstract"),
                h3(tags$b("Keywords"), class = "section-header"),
                uiOutput("keywords"),
                p("Sleep Quality, Lifestyle and Sleep, Stress Level, Age-Related Sleep Patterns", class = "section-text"),
                h3(tags$b("Introduction"), class = "section-header"),
                uiOutput("introduction1"),
                uiOutput("introduction2"),
                h3(tags$b("Related Work"), class = "section-header"),
                uiOutput("relatedwork1"),
                uiOutput("relatedwork2"),
                h3(tags$b("The Dataset"), class = "section-header"),
                h5("Where did you find the data? Please include a link to the data source?"),
                uiOutput("dataset"),
                h5("Who collected the data?"),
                uiOutput("dataset2"),
                h5("How was the data collected or generated? "),
                uiOutput("dataset3"),
                h5("Why was the data collected?"),
                uiOutput("dataset4"),
                h5("How many observations (rows) are in your data?"),
                uiOutput("dataset5"),
                h5("How many features (columns) are in the data?"),
                uiOutput("dataset6"),
                h5("What, if any, ethical questions or questions of power do you need to consider when working with this data?"),
                uiOutput("dataset7"),
                h5("What are possible limitations or problems with this data?"),
                uiOutput("datset8"),
                h3(tags$b("Implications"), class = "section-header"),
                uiOutput("implications"),
                h3(tags$b("Limitations & Challenges", class = "section-header")),
                uiOutput("challenges"),
                h3(tags$b("Summary Information"), class = "section-header"),
                uiOutput("summary"),
                )
              )

viz1_tab <- tabPanel("Age", 
              titlePanel("Analyzing Sleep Quality Across Genders and Age Groups"),
              sidebarLayout(
                sidebarPanel(fluidRow(column(11, sliderInput("ageRange", 
                                                 label = h3("Select Age Range"), 
                                                 min = 27, max = 59, 
                                                 value = c(27, 59)))
                                      ), 
                             ), 
  
                 mainPanel(
                  plotlyOutput("myPlot"),
                  h3("Purpose"),
                  textOutput("purpose")
                  )
                )
             )
viz2_tab <- tabPanel("Physical Activity",
                     titlePanel("Impact of Daily Physical Activity Level on Sleep Quality"),
                     sidebarLayout(
                       sidebarPanel(
                         selectInput("gender", "Select Gender:", choices = c("Both", "Male", "Female"))
                       ),
                       mainPanel(
                         plotlyOutput("scatterPlot"),
                         h3("Purpose"),
                         textOutput("purpose3")
                       )
                      )
                     )

viz3_tab <- tabPanel("Sleep Disorders",
                     titlePanel("Sleep Quality and Disorders Analysis"),
                     sidebarLayout(
                       sidebarPanel(fluidRow(column(3, checkboxGroupInput("sleepDisorders",
                                                                          label = h4("Select Sleep Disorders"),
                                                 choices = c("Insomnia", "None", "Sleep Apnea"),
                                                 selected = c("Insomnia", "None", "Sleep Apnea")))
                                             ),
                                    ),
                      mainPanel(
                        plotlyOutput("myPlot2"),
                        
                        h3("Purpose"),
                        textOutput("purpose2")
                       )
                     )
                     )

summary_tab <- tabPanel("Conclusion",
                        titlePanel("Conclusion and Summary Takeaways"),
                        mainPanel(
                          h4(tags$b("Analysis: Do gender and age affect sleep quality?"), class = "section-header"),
                          p("Our analysis of the effects of gender and age on sleep quality yielded distinct patterns of influence by these factors. Visualization of Sleep Quality Across Gender and Age Groups shows that sleep quality changes with age in male and female, but in different ways. For female, sleep quality tends to be more consistent but declines in their thirties and fifties, possibly due to hormonal changes and life stages such as menopause. In contrast, male's sleep quality fluctuates more. There is a significant decline in sleep quality in their early thirties and a significant decline in their late forties to early fifties. The possible reasons for the flusctuation of male's sleep quality can be marriage and work, marriage could bring more pressure to male, and children could also be be very pressure. These findings suggest that sex-specific factors and age-related changes play a crucial role in determining sleep quality. Understanding these differences can help health professionals provide advice and interventions tailored to an individual's age and gender. For example, addressing hormonal changes in midlife female or lifestyle adjustments in midlife male could improve sleep outcomes. In summary, gender and age can significantly affect sleep quality. Recognizing and addressing these differences through personalized strategies can enhance sleep health and help improve overall health."),
                          h4(tags$b("Analysis: The impact of people’s daily physical activity on sleep quality"), class = "section-header"),
                          p("Our analysis strongly supports the positive impact of daily physical activity on sleep quality. The visualization of Impact of Daily Physical Activity Level on Sleep Quality shows that as the level of physical activity increases, the sleep quality score shows a clear upward trend. This suggests that people who engage in more physical activity tend to get better sleep.  Even moderate levels of physical activity (40-60 minutes per day) can significantly improve sleep quality, such as jumping rope, brisk walking, jogging, etc. At the same time, this finding also highlights the potential of physical activity as a non-pharmacological intervention for sleep problems. At the same time, regular physical activity not only reduces stress, promotes relaxation, and helps regulate day and night, these benefits are also very helpful in improving sleep quality. And these benefits are consistent with health guidelines recommending at least 150 minutes of moderate-intensity aerobic activity per week. In summary, daily physical activity can indeed significantly improve sleep quality.  We can also see that physical activity has many positive effects on sleep, including not only physical and psychological aspects, but also better helping the body's metabolism and regulating day and night.  So we encourage everyone to engage in regular physical activity, which can help individuals get better sleep, thereby contributing to overall health and quality of life."),
                          h4(tags$b("Analysis: Does Sleep Quality Affect the Occurrence of Sleep Disorders?"), class = "section-header"),
                          p("Our analysis demonstrates a strong relationship between sleep quality and the occurrence of sleep disorders. Our visualization of Sleep Disorders and Sleep Quality Score shows that people with poor sleep quality are more likely to suffer from conditions such as insomnia and sleep apnea. We divided sleep quality into several levels: People with high sleep quality scores (8-10) mostly did not have sleep disorders, while people with medium (5-7) and low sleep quality scores (1-4) showed signs of these disorders. The prevalence is higher. This clear correlation suggests that sleep quality can cause sleep disorders, or that sleep disorders can seriously affect sleep quality. Therefore, poor sleep quality can be both a symptom and a cause of these diseases. I think the bidirectional relationship between sleep quality and sleep disorders is particularly concerning because it creates a vicious cycle. Poor sleep quality can exacerbate the symptoms of a sleep disorder, and the presence of a sleep disorder can cause further worsening of sleep quality, and I think this cycle may be difficult to break without appropriate medical intervention. In summary, sleep quality is very important in the occurrence and severity of sleep disorders. By understanding the complex relationship between sleep quality and sleep disorders, we recommend lifestyle changes to regulate sleep quality, such as maintaining a regular sleep schedule, reducing caffeine, alcohol, and nicotine intake, and creating a restful sleep environment, as well as timely promotion of high sleep quality through medical and lifestyle interventions to improve individual health and quality of life. This analysis has important implications for both individuals and health care providers."),
                          h4(tags$b("Most Important Insight")),
                          p("The most important insight from our analysis is the clear, positive impact of physical activity on sleep quality. Regular exercise, even at a moderate level, can have a big impact on a person's sleep quality.  This simple yet effective strategy can significantly improve your sleep health. Our findings indicate that higher levels of physical activity are consistently associated with better sleep, regardless of age and gender.  Encouraging physical activity can help people get better sleep and improve their overall health and quality of life. Our analysis also shows that various types of physical activity can improve sleep quality.  Whether it is aerobic exercise such as jogging, swimming, cycling, or anaerobic exercise, it can have a positive impact on sleep.  Data shows that people who stay active tend to fall asleep faster, experience fewer disturbances during the night, and enjoy deeper, more restorative sleep. Additionally, the benefits of regular exercise, including releasing hormones in the body and boosting metabolism, can help reduce stress and anxiety, which are key factors in sleep disorders. Physical activity promotes relaxation and helps regulate circadian rhythms, making it easier to maintain a consistent sleep schedule. It can also improve overall physical health, help maintain a healthy weight, and reduce the risk of problems like insomnia and sleep apnea.  Health professionals should emphasize the importance of physical activity for sleep health as part of a comprehensive treatment plan for patients with sleep problems. In summary, the most important insight from our study is that physical activity has a significant positive impact on sleep quality. Promoting regular exercise can help people get better sleep and improve overall health.  This finding illustrates the need to combine physical activity with other lifestyle changes to promote optimal sleep health."),
                          h4(tags$b("Broader Implications")),
                          p("The broader impact of promoting physical activity on improving sleep quality is significant, and poor sleep quality is also significantly linked to a variety of diseases, including cardiovascular disease and mental health disorders, which not only cause physical discomfort but it will also reduce overall happiness. By enhance physical activity as a means of improving sleep quality, we can contribute to reducing the burden of these health problems and improving public health. Public health campaigns, health care providers, and educational institutions should emphasize the importance of regular physical activity to improve sleep quality and overall health.")
                        )
                    )

ui <- navbarPage(theme =  bs_theme(
                bg = "#202123", fg = "pink", primary = "#FFFFFF", 
                base_font = font_google("Space Mono"),
                code_font = font_google("Space Mono")),
                "The Impact of Lifestyle Factors on Sleep Quality",
                 intro_tab,
                 viz1_tab,
                 viz2_tab,
                 viz3_tab,
                 summary_tab)


