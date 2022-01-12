# log file with sink

my_log <- file("my_log.doc") # File name of output log
sink(my_log, append = TRUE, type = "output") # Writing console output to log file
sink(my_log, append = TRUE, type = "message")

factorial(5)
sqrt(81)
abs(-5)
abs(c(-1:5))
sign(-5)
sign(5)
sin(45)
cos(90)
pi

closeAllConnections() # Close connection to log file

# output with sink
fit <- lm(Petal.Length ~ Sepal.Length, data = iris)

sink(file = "lm_output.doc")
summary(fit)
fit
sink(file = NULL)

# csv with sink
sink("iris.csv")  # Create empty csv file
iris              # Print data
sink()            # Close connection to file

# sink with commands

library(TeachingDemos)

txtStart("test.doc")

fit <- lm(Petal.Length ~ Sepal.Length, data = iris)
fit
summary(fit)
head(iris)

txtStop()

# capture.output

file1 <- capture.output(summary(fit))
file2 <- capture.output(fit)

cat("model özeti",file1,file="model.doc",sep="\n",append = TRUE)
cat("model",file2,file="model.doc",sep="\n",append = TRUE)

