library(DBI)
library(odbc)
library(dplyr)

# Create connection string
driver <- "SQL Server"
server <- "localhost\\SQLEXPRESS"
db <- "RDatabase"


con <- dbConnect(odbc(), 
                 Driver = driver , 
                 Server = server , 
                 Database = db, 
                 Trusted_Connection = "True")

## Create data frame with 80 columns and 10 Million Rows
#dat <- do.call(data.frame, replicate(80, rep(1, 20000000), simplify=FALSE))


massive_data <- data.frame(Test=rnorm(50000000, 500, 2))
massive_data <- cbind(massive_data, rep(massive_data, 10))


# Write back to database
system.time(odbc::dbWriteTable(con, Id(schema = "data", 
                                       table = "bigish_data"), 
                   massive_data, append = FALSE, overwrite = TRUE))
# Tweak overwrite to FALSE and append to TRUE for an append query




