% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/phenoCropVal.R
\name{phenoCropVal}
\alias{phenoCropVal}
\title{phenoCropVal}
\usage{
phenoCropVal(x, y, z)
}
\arguments{
\item{x}{A \emph{matrix} or \emph{data.frame}.}

\item{y}{A \emph{character} vector.}

\item{z}{A \emph{character} vector.}
}
\value{
A \emph{list} containing a set of reference profiles for each unique class in \emph{y}.
}
\description{
Spatially explicit and phenology driven validation scheme for cropland mapping.
}
\details{
{For each unique class in \emph{y}, the function iterates through each unique element in \emph{z} 
and keeps it for validation. Then, it calls \code{\link{analyseTS}} to derive reference profiles for each 
unique class in \emph{y} and uses them to classify the validation samples using \code{\link{phenoCropClass}}. 
The final output consists of:
\itemize{
 \item{\emph{sample.validation} - A \emph{logical} vector with the same length of \emph{x} where TRUE means it was correctly classified.}
 \item{\emph{predicted.class} - A \emph{character} vector with the predicted classes for each sample.}
 \item{\emph{sample.count} - A \emph{numeric} vector with the number of non-NA used for validation per sample.}
 \item{\emph{sample.r2} - A \emph{numeric} vector with the r2 value between the target sample and the selected class profile.}
 \item{\emph{class.accuracy} - A \emph{data.frame} with sample count per class, precision, recall and F1-scores per unique class in \emph{y}.}}}
}
\examples{
{

require(raster)
require(fieldRS)

# read raster data
r <- brick(system.file("extdata", "ndvi.tif", package="fieldRS"))

# read field data
data(fieldData)

# read reference profiles
data(referenceProfiles)

# read time series
data(fieldDataTS)
fieldDataTS <- as.data.frame(fieldDataTS$weighted.mean)

# read info. on sample spatial grouping
data(fieldDataCluster)

# derive validation results
cropVal <- phenoCropVal(fieldDataTS, fieldData$crop, fieldDataCluster$region.id)

# plot accuracy results
cropVal$accuracy.plot

# plot correctly classified polygons in red
plot(fieldData)
plot(fieldData[cropVal$sample.validation,], col="red", add=TRUE)

}
}
\seealso{
\code{\link{extractTS}} \code{\link{phenoCropClass}}
}
