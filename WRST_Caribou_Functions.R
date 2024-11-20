# Install and load the necessary packages
# install.packages("DBI")
# install.packages("odbc")
library(DBI)
library(odbc)
library(tidyverse)


# Function to get a database connection 
# Example: DBConnection = GetDatabaseConnection(SqlServer,Database) 
GetDataBaseConnection = function(SqlServer,Database){
  # Create a connection to the SQL Server database
  Connection = dbConnect(odbc::odbc(),Driver="SQL Server",Server=SqlServer,Database=Database,Trusted_Connection = "Yes")
  return(Connection)
}

# Example: Summaries = GetCensusSurveySummaries(GetDatabaseConnection(SqlServer,Database))
GetCensusSurveySummaries = function(DatabaseConnection){
  tryCatch({
    # SQL query
    Sql = "SELECT * FROM Summary_Census"
    DF = dbGetQuery(DatabaseConnection, Sql)
    return(DF)
  }, warning = function(w) {
    # Handle warnings
    message("Warning: ", conditionMessage(w))
    return(NA)
  }, error = function(e) {
    # Handle errors
    message("Error: ", conditionMessage(e))
    return(NA)
  })
}






