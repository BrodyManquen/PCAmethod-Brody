#
#  ggscreeplot.r
#
#  Copyright 2011 Vincent Q. Vu.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#' Screeplot for Principal Components
#'
#' Produces scree plots (Cattell, 1966) of the variance proportions explained by each dimension against dimension number from
#' various PCA-like dimension reduction techniques.
#'
#' @param pcobj   an object returned by \code{\link[stats]{prcomp}}, \code{\link[stats]{princomp}},
#'                \code{\link[FactoMineR]{PCA}}, \code{\link[ade4]{dudi.pca}}, or \code{\link[MASS]{lda}}
#' @param type    the type of scree plot, one of \code{c('pev', 'cev')}.
#'                \code{'pev'} plots the proportion of explained variance, i.e. the eigenvalues divided by the trace.
#'                \code{'cev'} plots the cumulative proportion of explained variance, i.e. the partial sum of the first k eigenvalues divided by the trace.
#' @param size    point size
#' @param shape   shape of the points. Default: 19, a filled circle.
#' @param color   color for points and line. Default: \code{"black"}.
#' @param linetype type of line
#' @param linewidth width of line
#'
#' @import ggplot2
#' @returns A ggplot2 object with the aesthetics \code{x = PC, y = yvar}
#' @export
#' @references
#' Cattell, R. B. (1966). The Scree Test For The Number Of Factors. \emph{Multivariate Behavioral Research}, 1, 245–276.
#' @examples
#' library(ggplot2)
#' data(iris)
#' iris.pca <- prcomp(~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
#'                    data=iris,
#'                    scale. = TRUE)
#' print(ggscreeplot(iris.pca))
#'
#' # show horizontal lines for 80, 90% of cumulative variance
#' ggscreeplot(iris.pca, type = "cev") +
#'   geom_hline(yintercept = c(0.8, 0.9), color = "blue")
#'
#' # Make a fancy screeplot, highlighting the scree starting at component 4
#' data(iris)
#' iris.pca <-
#'   iris |>
#'   dplyr::select(where(is.numeric)) |>
#'   prcomp(scale. = TRUE)
#'
#' (iris.eig <- iris.pca |>
#'    broom::tidy(matrix = "eigenvalues"))
#'
#' ggscreeplot(iris.pca) +
#'   stat_smooth(data = iris.eig |> dplyr::filter(PC>=4),
#'               aes(x=PC, y=percent), method = "lm",
#'               se = FALSE,
#'               fullrange = TRUE)
#'
ggscreeplot <- function(pcobj,
                        type = c('pev', 'cev'),
                        size = 4,
                        shape = 19,
                        color = "black",
                        linetype = 1,
                        linewidth = 1)
{
  # Recover the SVD from a PCA-like object
  if(inherits(pcobj, 'prcomp')){
    nobs.factor <- sqrt(nrow(pcobj$x) - 1)
    d <- pcobj$sdev
  } else if(inherits(pcobj, 'princomp')) {
    nobs.factor <- sqrt(pcobj$n.obs)
    d <- pcobj$sdev
  } else if(inherits(pcobj, 'PCA')) {
    nobs.factor <- sqrt(nrow(pcobj$call$X))
    d <- unlist(sqrt(pcobj$eig)[1])
  } else if(inherits(pcobj, "lda")) {
    d <- pcobj$svd
  } else if(inherits(pcobj, 'pca') & inherits(pcobj, 'dudi')){
    d <- sqrt(pcobj$eig)
  }
  else {
    stop('Expected a object of class "prcomp", "princomp", "PCA", c("pca", "dudi") or "lda"')
  }

  type <- match.arg(type)
  dsq <- d^2
  yvar <- switch(type,
                 pev = dsq / sum(dsq),
                 cev = cumsum(dsq) / sum(dsq))

  yvar.lab <- switch(type,
                     pev = 'Proportion of explained variance',
                     cev = 'Cumulative proportion of explained variance')

  PC <- NULL
  df <- data.frame(PC = 1:length(d), yvar = yvar)

  ggplot(data = df, aes(x = PC, y = yvar)) +
    xlab('Principal component number') +
    ylab(yvar.lab) +
    geom_point(size = size, shape = shape, color = color) +
    geom_path(linetype = linetype, linewidth = linewidth, color = color)
}
