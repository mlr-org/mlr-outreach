library(mlr3)
library(mlr3spatial)
library(terra, exclude = "resample") # avoid overriding `mlr3::resample()`
library(sf)
library(stars)
library(mapview)

# load sample points and create task ------------------------------------------#
leipzig_vector = read_sf(system.file("extdata", "leipzig_points.gpkg",
  package = "mlr3spatial"), stringsAsFactors = TRUE)

# create land cover task
task = as_task_classif_st(leipzig_vector, target = "land_cover")
task
task$data()
task$levels()

# create lrn and train it -------------------------------------------------#
lrn = lrn("classif.svm")

# train the model
lrn$train(task)

### Load raster file for prediction -------------------------------------------#
# load raster file
leipzig_raster = rast(system.file("extdata",
 "leipzig_raster.tif", package = "mlr3spatial"))

?leipzig

leipzig_raster_stars = st_as_stars(leipzig_raster)
# {mapview} does not support `SpatRaster` objects yet, coercing to `stars` first
mapview(leipzig_raster_stars, band = 8) # NDVI

### Predict -------------------------------------------------------------------#
# create prediction task
task_predict = as_task_unsupervised(leipzig_raster)

# predict land cover map
land_cover_pred = predict_spatial(task_predict, lrn)

### Visualize -----------------------------------------------------------------#
plot(land_cover_pred, col = c("#440154FF", "#443A83FF", "#31688EFF",
  "#21908CFF", "#35B779FF", "#8FD744FF", "#FDE725FF"))
