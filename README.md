# RFAmadogram
Functions to compute the RFA-madogram and some existing packages required for clustering and visualization in RFAmadogram.R

Precipitation data are stored in "df_pr_cmip56_yearmax.rds". Annual maxima daily precipitation are stored in a dataframe with columns : "institute"  "model"      "experiment" "run"    "year"  "1"          "2"          "3"          "4"          "5" ...
where each number corresponds to a grid point. The grid point are provided in the same order as in the dataframe of the coordinate file "df_lonlat.rds".


For more details on the gridded data, see Multi-model errors and emergence times in climate
attribution studies, Naveau, Thao : https://hal.archives-ouvertes.fr/hal-03312878
