# create rounded avatars using imagemagick
library(magrittr)
list.files("2019_whyr_warsaw/slides/avatars/", pattern = ".jpg", full.names = TRUE) %>%
  file.remove()

# michel
system2("magick", args = c("https://avatars1.githubusercontent.com/u/1260920",
                           "-vignette",
                           "1x1",
                           "2019_whyr_warsaw/slides/avatars/michel.jpg")
)

# bernd
system2("magick", args = c("https://avatars1.githubusercontent.com/u/1225974",
                           "-vignette",
                           "1x1",
                           "2019_whyr_warsaw/slides/avatars/bernd.jpg")
)
# jakob
system2("magick", args = c("https://avatars1.githubusercontent.com/u/1888623",
                           "-vignette",
                           "1x1",
                           "2019_whyr_warsaw/slides/avatars/jakob.jpg")
)
# patrick
system2("magick", args = c("https://avatars1.githubusercontent.com/u/8430564",
                           "-vignette",
                           "1x1",
                           "2019_whyr_warsaw/slides/avatars/patrick.jpg")
)

# martin
system2("magick", args = c("https://avatars1.githubusercontent.com/u/15801081",
                           "-vignette",
                           "1x1",
                           "2019_whyr_warsaw/slides/avatars/martin.jpg")
)
