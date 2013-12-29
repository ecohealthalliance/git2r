## git2r, R bindings to the libgit2 library.
## Copyright (C) 2013  Stefan Widgren
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, version 2 of the License.
##
## git2r is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

##' Class \code{"reference"}
##'
##' S4 class to handle a git reference
##' @section Slots:
##' \describe{
##'   \item{name}{
##'     The full name of the reference.
##'   }
##'   \item{type}{
##'     Type of the reference, either direct (GIT_REF_OID == 1) or
##'     symbolic (GIT_REF_SYMBOLIC == 2)
##'   }
##'   \item{hex}{
##'     40 char hexadecimal string
##'   }
##'   \item{target}{
##'     :TODO:DOCUMENTATION:
##'   }
##'   \item{shorthand}{
##'     The reference's short name
##'   }
##' }
##' @name reference-class
##' @aliases show,reference-method
##' @docType class
##' @keywords classes
##' @section Methods:
##' \describe{
##'   \item{show}{\code{signature(object = "reference")}}
##' }
##' @keywords methods
##' @export
setClass('reference',
         slots=c(name='character',
                 type='integer',
                 hex='character',
                 target='character',
                 shorthand='character'),
         prototype=list(hex=NA_character_,
                        target=NA_character_))

##' Get all references that can be found in a repository.
##'
##' @name references-methods
##' @aliases references
##' @aliases references-methods
##' @aliases references,repository-method
##' @docType methods
##' @param object The repository \code{object}.
##' @return Character vector with references
##' @keywords methods
##' @export
##' \dontrun{
##' ## Open an existing repository
##' repo <- repository('path/to/git2r')
##'
##' ## List all references in repository
##' references(repo)
##' }
##'

setGeneric('references',
           signature = 'object',
           function(object) standardGeneric('references'))

setMethod('references',
          signature(object = 'repository'),
          function (object)
          {
              .Call('references', object)
          }
)

setMethod('show',
          signature(object = 'reference'),
          function (object)
          {
              if(identical(object@type, 1L)) {
                  cat(sprintf("[%s] %s\n",
                              substr(object@hex, 1 , 6),
                              object@shorthand))
              } else if(identical(object@type, 2L)) {
                  cat(sprintf("%s => %s\n",
                              object@name,
                              object@target))
              } else {
                  stop("Unexpected reference type")
              }
          }
)
