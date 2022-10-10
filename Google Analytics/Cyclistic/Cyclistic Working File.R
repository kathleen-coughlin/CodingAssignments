library(tidyverse)
library(lubridate)
library(scales)
library(urbnthemes)

set_urbn_defaults(style = "print")
setwd("~/R Programs") # Set working directory

all_trips <- read.csv("Exported_combined_trips.csv") # Import data set
all_trips <- select(all_trips, -X) # Remove column of row numbers
all_trips <- subset(all_trips, start_station_name != "HQ QR") # Remove rows where bikes were taken out of circulation
all_trips <- select(all_trips, -c(start_station_name, start_station_id, end_station_name, end_station_id, rideable_type, start_lat, start_lng, end_lat, end_lng))

str(all_trips)
head(all_trips, 10)
nrow(all_trips)

str(all_trips)
colnames(all_trips)

# "ride_id"  - char
# "rideable_type" -char
# "started_at" -char
# "ended_at" -char
# "start_station_name" -char
# "start_station_id"  -char
# "end_station_name" -char
# "end_station_id" -char
# "start_lat"  - num
# "start_lng"  - num  
# "end_lat" - num
# "end_lng"  - num    
# "member_casual" -char   

# Extract date information
    # Ex: 2022-02-07 15:47:40 UTC

# The way I did it with str_sub from stringr
all_trips <- all_trips %>%
    mutate(year_started = str_sub(started_at, 1, 4), 
        month_started = str_sub(started_at, 6, 7), 
           day_started = str_sub(started_at, 9, 10), 
           hour_started = str_sub(started_at, 12, 13))


# The way they suggested using as.Date from lubridate but not extracting hour correctly :(
#all_trips$date <- as.Date(all_trips$started_at)
#all_trips$year_started <- format(as.Date(all_trips$date), "%Y")
#all_trips$month_started <- format(as.Date(all_trips$date), "%m")
#all_trips$day_started <- format(as.Date(all_trips$date), "%d")
#all_trips$hour_started <- format(as.Date(all_trips$date), "%H")
all_trips$day_of_week <- format(as.Date(all_trips$started_at), "%A")
all_trips$day_of_week <- ordered(all_trips$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Y, M, D, & H cols to numeric 
convert_cols <- c('year_started', 'month_started', 'day_started', 'hour_started')
all_trips[convert_cols] <- lapply(all_trips[convert_cols], as.numeric)


# Time of day factor column
hour_bucket_labels <- c("Between midnight and 3am", "Between 3am and 6am", "Between 6am and 9am", "Between 9am and 12pm", "Between 12pm and 3pm", "Between 3pm and 6pm", "Between 6pm and 9pm","Between 9pm and midnight")
all_trips$time_of_day_bucket <- cut(as.numeric(all_trips$hour_started), 8, labels = hour_bucket_labels, ordered_result=TRUE)


# Season factor column
all_trips <- all_trips %>%
    mutate(season_bucket = case_when(
        month_started %in% 3:5 ~ "Spring", 
        month_started %in% 6:8 ~ "Summer",
        month_started %in% 9:11 ~ "Fall", 
        TRUE ~ "Winter")
    )
all_trips$season_bucket <- ordered(all_trips$season_bucket, levels = c("Spring", "Summer", "Fall", "Winter"))


##### Too inefficient :( 
#n_trips <- nrow(all_trips)

#all_trips$time_of_day_bucket <- all_trips$time_of_day_bucket %>%
 #   as.character(
  #      for (i in 1:n_trips)
    #     if(all_trips$hour_started[i] <3){
    # all_trips$time_of_day_bucket[i]= "Between midnight and 3am"
    #   } else if (all_trips$hour_started[i] <6){ 
    #        all_trips$time_of_day_bucket[i] ="Between 6am and 9am"
    #    } else if (all_trips$hour_started[i] <9){ 
    #        all_trips$time_of_day_bucket[i] ="Between 6am and 9am"       
    #    } else if (all_trips$hour_started[i] <12){
    #        all_trips$time_of_day_bucket[i] ="Between 9am and 12pm"     
    #    } else if (all_trips$hour_started[i] <15){
    #        all_trips$time_of_day_bucket[i] ="Between 12pm and 3pm"            
    #    } else if (all_trips$hour_started[i] <18){
    #        all_trips$time_of_day_bucket[i] ="Between 3pm and 6pm"          
    #    } else if (all_trips$hour_started[i] <21){
    #        all_trips$time_of_day_bucket[i] ="Between 6pm and 9pm"            
    #    } else {all_trips$time_of_day_bucket[i] ="Between 9pm and midnight"})

#all_trips$time_of_day_bucket <- ordered(all_trips$time_of_day_bucket, levels = c("Between midnight and 3am", "Between 3am and 6am", "Between 6am and 9am", "Between 9am and 12pm", "Between 12pm and 3pm", "Between 3pm and 6pm", "Between 6pm and 9pm","Between 9pm and midnight"))

# Ride length column

#all_trips$ride_length <- as.numeric(
#    as.character(
#        difftime(all_trips$ended_at, all_trips$started_at)
#        )
#    )
#all_trips$ride_length <- all_trips$ride_length / 60 # Convert to minutes 

all_trips$ride_length <- round(                  # round the result of difftime function, converted to numeric
    as.numeric(                                  # change from difftime to numeric
        difftime(all_trips$ended_at, all_trips$started_at),  #calculate the time difference
        units="mins"),                           # set unit to minutes
    0                                            # specifies round with 0 decimal places (whole number of minutes)
)

all_trips <- subset(all_trips, ride_length>0) # Remove rows where ride length <0



# Statistics they wanted me to use
#aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = mean)
#aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = median)
#aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = max)
#aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = min)
#aggregate(all_trips$ride_length ~ all_trips$member_casual + all_trips$day_of_week, FUN = mean)

#My tibbles which combine mean/median
## Returns a tibble of the mean and median ride lengths for members vs. casual riders
all_trips %>%          
    group_by(member_casual) %>%  
    summarise(mean = mean(ride_length), median = median(ride_length))

## Returns a tibble of the mean and median ride lengths for members vs. casual riders by day of the week
all_trips %>%          
    group_by(day_of_week, member_casual) %>%  
    summarise(mean = mean(ride_length), median = median(ride_length))

## Returns a tibble of the mean and median ride lengths for members vs. casual riders by the season
all_trips %>% 
    group_by(season_bucket, member_casual) %>%  
    summarise(mean = mean(ride_length), median = median(ride_length))


##Time of day
table(all_trips$time_of_day_bucket, all_trips$member_casual) # Counts
prop.table(table(all_trips$time_of_day_bucket, all_trips$member_casual)) # Proportions
prop.table(table(all_trips$time_of_day_bucket, all_trips$member_casual), margin=2) # Proportions by column (member_casual)

replace(table(all_trips$time_of_day_bucket, all_trips$member_casual), TRUE, sprintf("%.1f%%",prop.table(table(all_trips$time_of_day_bucket, all_trips$member_casual),2)*100))


##Seasonal
prop.table(table(all_trips$season_bucket, all_trips$member_casual), margin=2) # Proportions by column (member_casual)
replace(table(all_trips$season_bucket, all_trips$member_casual), TRUE, sprintf("%.1f%%",prop.table(table(all_trips$season_bucket, all_trips$member_casual),2)*100))
# Season prop table as df
season_df <- as.data.frame(prop.table(table(all_trips$season_bucket, all_trips$member_casual), margin=2)) # Proportions by column (member_casual)
colnames(season_df) <- c("season_bucket", "member_casual", "pct_rides")
season_df$pct_rides <- as.numeric(season_df$pct_rides) * 100


#Quantile table for ride length & member type
#aggregate(all_trips$ride_length ~ all_trips$member_casual, FUN = quantile)


# Quantiles for ride_length by membership

quant_df <- all_trips %>%
    group_by(member_casual) %>%
    summarise(
        quant25=quantile(ride_length, probs=0.25), 
        quant75=quantile(ride_length, probs=0.75)
        )
quant_df <- as.data.frame(quant_df)

#
ggplot(quant_df, aes(color=member_casual))+
    geom_segment(aes(x=member_casual, xend=member_casual, y=quant25, yend=quant75), size=40)+
    labs(title="Ride Length", subtitle = "The length in minutes of the middle 50% of trips for each type of rider", caption="July 2021 to June 2022")+
    scale_x_discrete(name="Type of Rider",
                     labels = c("member" = "Annual Members", 
                                "casual" = "Casual Riders"))+
    scale_y_continuous(name="Ride Length (minutes)",
                       limits=c(0, 30))+
    geom_text(aes(x=member_casual, y=quant25, label=quant25), color="black", size=3, vjust=1.5)+
    geom_text(aes(x=member_casual, y=quant75, label=quant75), color="black", size=3, vjust = -0.5)+
    theme(legend.position="none", axis.text=element_text(size=8), axis.title=element_text(size=10), axis.line.x = element_line(linetype="blank"))





# <- table %>%
 #   tibble() %>%
  #  group_by(member_casual, season_bucket) %>%
   # summarise(n()) %>%
#    gt(rowname_col = "member_casual") %>%
 #   tab_header(title="Rides by Season", subtitle="June 2021 to July 2022") %>%
  #  summary_rows(group=TRUE, columns=, fns="mean") %>%
   # fmt_percent(columns=col_name, decimals=1)


#gt(season_df, groupname_col="member_casual") %>% 
 #   tab_header(title="Seasonal Ride Trends", subtitle="June 2021 to July 2022") %>% 
  #  fmt_number(columns = pct_rides, decimals=1) %>% cols_label(pct_rides="Percent of Rides", season_bucket="")




# Plots

#Bar chart of total rides by type
ggplot(all_trips)+
    geom_bar(aes(x=member_casual, fill=member_casual)) + 
    labs(title="Number of Cyclstic Bike Rentals in the Past 12 months", subtitle="June 2021 to July 2022", x="Rider Type", y="Number of Trips") +
    geom_text(aes(x=member_casual, label = format(..count.., big.mark = ",")), stat = "count", vjust = 1.5, size=4, fontface="bold") +
    scale_y_continuous(labels = comma) +
    scale_x_discrete(labels = c("member" = "Annual Members", 
                                "casual" = "Casual Riders"))+
    theme(legend.position="none", axis.text.x=element_text(size=8), axis.title=element_text(size=10), axis.line.x = element_line(linetype="blank"))


# Hour prop table as df
hourdf <- as.data.frame(prop.table(table(all_trips$hour, all_trips$member_casual), margin=2))
colnames(hourdf) <- c("hour", "member_casual", "pct_ridership")
hourdf$hour <-as.numeric(hourdf$hour)
hourdf$pct_ridership <- as.numeric(hourdf$pct_ridership) * 100
# Line graph from hourdf
ggplot(data=hourdf, aes(x=hour, y=pct_ridership, group=member_casual)) +
    geom_line(aes(color=member_casual), lwd=1.2) + 
    scale_y_continuous(
        breaks= c(0, 3, 6, 9),
        labels= c("0%", "3%", "6%", "9%"), 
        name="Percent of Rides") +
    scale_color_discrete(labels = c("member" = "Annual Members", 
                                "casual" = "Casual Riders"))+
    labs(title="Time of Day Each Type of Rider Rents", subtitle="The percentage of the groups' total rides each hour", caption="June 2021 to July 2022", x="Hour of the Day", color="Type of Rider") +
    theme(axis.text.x=element_text(size=8), axis.title=element_text(size=10))


## Bar chart, hour buckets, rider type 
ggplot(data=all_trips) + 
    geom_bar(aes(x=time_of_day_bucket, fill=member_casual), stat="count", width=0.7, position="dodge") +
    scale_x_discrete(labels = c("Between midnight and 3am" = "12-3am", 
                                "Between 3am and 6am" = "3-6am", 
                                "Between 6am and 9am" = "6-9am", 
                                "Between 9am and 12pm" = "9am-12pm", 
                                "Between 12pm and 3pm" = "12-3pm", 
                                "Between 3pm and 6pm" = "3-6pm", 
                                "Between 6pm and 9pm" = "6-9pm",
                                "Between 9pm and midnight" = "9pm-12am")) +
    scale_y_continuous(
        breaks= c(0, 200000, 400000, 600000, 800000),
        labels= c("0", "200K", "400K", "600K", "800K"),
        name="Number of Rides")+
    labs(title="Trips Throughout the Day", subtitle="The total number of rides by casual riders and annual members", caption="June 2021 to July 2022", x="Time of Day", color="Type of Rider") +
    scale_fill_discrete(labels = c("member" = "Annual Members", 
                                    "casual" = "Casual Riders"))+
    theme(axis.text.x=element_text(size=8), axis.title=element_text(size=10))


## Bar chart, day_of_week buckets, rider type count 
ggplot(data=all_trips) + 
    geom_bar(aes(x=day_of_week, fill=member_casual), stat="count", width=0.7, position="dodge") + 
    scale_y_continuous(
        breaks= c(0, 100000, 200000, 300000, 400000),
        labels= c("0", "100K", "200K", "300K", "400K"), 
        name="Number of Trips") +
    scale_fill_discrete(labels = c("member" = "Annual Members", 
                                   "casual" = "Casual Riders"))+
    labs(title="Rentals Each Day of the Week", x="Day of the Week", subtitle="The total number of trips taken each day of the week", caption="June 2021 to July 2022") +
    theme(axis.title=element_text(size=10))



## Bar chart, season buckets, rider type count 
ggplot(data=all_trips) + 
    geom_bar(aes(x=season_bucket, fill=member_casual), stat="count", width=0.7, position="dodge") + 
    scale_y_continuous(
        breaks= c(0, 300000, 600000, 900000, 1200000),
        labels= c("0", "300K", "600K", "900K", "1.2M"), 
        name="Number of Trips") +
    scale_fill_discrete(labels = c("member" = "Annual Members", 
                                   "casual" = "Casual Riders"))+
    labs(title="Seasonal Bike Rentals", x="Season", subtitle="The total number of trips taken by members and casual riders each season", caption="June 2021 to July 2022") +
    theme(axis.title=element_text(size=10))


## Bar chart, day_of_week buckets, rider type, average trip duration
ggplot(data=all_trips, aes(x=day_of_week, y=ride_length, group=member_casual, fill=member_casual)) + 
    stat_summary_bin(fun="mean", geom="bar", position="dodge") +
    geom_text(aes(label=ride_length), position=position_dodge(width=0.9), vjust=-0.25) +
    labs(title="Rider Membership by Day of Week", x="Day of the Week", y="Average Ride Length (minutes)", fill="Type of Rider")  
    
## Line chart, trips per hour, rider type 
ggplot(data=all_trips) +
    geom_line(aes(x=hour_started, color=member_casual), lwd=1.2, stat="count") +
    guides(size="none") +
    scale_y_continuous(
        breaks= c(0, 30000, 60000, 90000, 120000, 150000, 180000, 210000),
        labels= c("0", "30K", "60K", "90K", "120K", "150K", "180K", "210K"), 
        name="Number of Trips") +
    labs(title="Member vs. Casual Bike Rentals Throughout the Day", x="Hour of the Day", color="Type of Rider") +
    facet_grid(~season_bucket)



#### Export an aggregated CSV
counts <- aggregate(all_trips$ride_length ~ all_trips$member_casual + all_trips$day_of_week, FUN = mean)
write.csv(counts, file = '~/Desktop/Divvy_Exercise/avg_ride_length.csv')
