# Load required packages
library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Values Over 10 Iterations"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Iterations", accept = ".txt")
    ),
    mainPanel(
      plotOutput("plot")
    ) 
  )
)

# Define server
server <- function(input, output) {
  
  TxtConvertedInCsv = pd.read_csv ("./scorestats.txt",sep='/s+', header = None, index_col=False, usecols='Iteration', 'avg. EXECUTED', "avg. WORST",	"avg. AVG",	"avg. BEST")
  data.to_csv ("./scorestats.csv", index=None)
  
  data <- read.table("./scorestats.txt",  header = TRUE) # Read TXT file
  data                               # Print data in RStudio
  dir("./scorestats.txt")
  
  
  # Read data from CSV file
  data <- reactive({
    file <- input$file
    if (is.null(file)) {
      return(NULL)
    }
    read.csv(file$datapath, sep="\t", header=TRUE)
  })
  
  # Create plot
  output$plot <- renderPlot({
    data <- data()
    if (is.null(data)) {
      return(NULL)
    }
    ggplot(data, aes(x=ITERATION)) +
      geom_line(aes(y=`avg. EXECUTED`), color="red") +
      geom_line(aes(y=`avg. WORST`), color="blue") +
      geom_line(aes(y=`avg. AVG`), color="green") +
      geom_line(aes(y=`avg. BEST`), color="purple") +
      labs(x="Iteration", y="Value", color="Metric") +
      theme_minimal()
  })
}

# Run app
shinyApp(ui, server)
# This code will create an R Shiny app with a file input widget in the sidebar, where you can select the CSV file containing the data. Once a file is selected, the app will read the data and create a line plot with four lines representing the four different metrics over the 10 iterations.





