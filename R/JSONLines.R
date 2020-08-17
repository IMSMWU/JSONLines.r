#' Setup JSONLines
#'
#' First time setup to initialize Julia and the JSONLines package
#' 
#' @param ... Parameters passed to JuliaCall::julia_setup
#' 
#' @examples 
#' 
#' \donttest{
#' 
#' JSONLines::JSONLines_setup()
#' 
#' }
#' @export
JSONLines_setup <- function(...) {
  julia <- JuliaCall::julia_setup(...)
  JuliaCall::julia_install_package_if_needed("https://github.com/danielw2904/JSONLines.jl")
  JuliaCall::julia_install_package_if_needed("DataFrames")
  JuliaCall::julia_install_package_if_needed("RCall")
  JuliaCall::julia_library("JSONLines")
  JuliaCall::julia_library("DataFrames")
  JuliaCall::julia_library("RCall")
}

#' Read a JSONLines file
#' 
#' @param path Path to JSONLines file
#' @param nrows Number of rows to load
#' @param skip Number of rows to skip before loading
#' 
#' @export
readfile <- function(path, nrows = .Machine$integer.max, skip = 0){
  JuliaCall::julia_assign("jpath", path)
  JuliaCall::julia_assign("jnrows", as.integer(nrows))
  JuliaCall::julia_assign("jskip", as.integer(skip))
  JuliaCall::julia_eval("using JSONLines, DataFrames, RCall")
  JuliaCall::julia_eval("tab = JSONLines.readfile(jpath; nrows = jnrows, skip = jskip) |> DataFrame!")
  return(JuliaCall::julia_eval("robject(tab)"))
}

#' Write a JSONLines file
#' 
#' @param x the data.frame to be written
#' @param file character string naming a file
#' 
#' @export
writefile <- function(x, file){
  JuliaCall::julia_assign("data", x)
  JuliaCall::julia_assign("path", file)
  JuliaCall::julia_eval("using JSONLines")
  JuliaCall::julia_eval("writefile(path, data)")
}
  