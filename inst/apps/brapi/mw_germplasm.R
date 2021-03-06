
process_germplasm <- function(req, res, err){
  germplasmDbId <- as.integer(basename(req$path))

  germplasm_search$result$data = germplasm_search_list(germplasmDbId)
  germplasm_search$metadata = list(pagination = NULL, status = NULL,
                                   datafiles = list())

  if(is.null(germplasm_search$result$data)){
    res$set_status(404)
    germplasm_search$metadata <- brapi_status(100, "No matching results!")
  }
  res$set_header("Access-Control-Allow-Methods", "GET")
  res$json(germplasm_search)

}


mw_germplasm <<-
  collector() %>%
  get("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    #res$set_status(501)
    process_germplasm(req, res, err)
  }) %>%
  put("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  post("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  }) %>%
  delete("/brapi/v1/germplasm/[a-zA-Z0-9]{1,12}[/]?", function(req, res, err){
    res$set_status(405)
  })
