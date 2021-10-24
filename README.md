# Case-Study-1

Midterm Project DDS

Author: Joaquin Dominguez

## Abstract

## Purpose
The purpose of this project is to investigate the relationship between multiple variables within the beers.csv and breweries.csv data sets and report insightful findings.

## Contents of Repository

Folders are divided by "Code" and "Presentation. 

"Code" folder contains all coding files used in the process of and as a product of this data analysis. Within this folder, "R_code" contains the final rmd file, as well as the R script file that was used as a notebook. Next, the "Rmd_knit" folder contains the knitted version of the rmd file in "R_Code" in pdf and html format. The "tables" folder contains the tables used throughout the analyses, the reference of which can be found in the rmd file under "R_code."

The "Presentation" folder contains all files used during the seven-minute presentation of the analysis. "Reporting Our Insights" holds the ppt slides used during the presentation. "Tableau_Workbook" holds a URL for the Tableau Workbook created during analysis and used during the presentation thereof. "Video" holds the URL for the video recording of the presentation. 

## Summary of Findings
We found that alcohol by volume (ABV) and the international bitterness units (IBU) are important to consider in the context of beers. They also appear to be significant metrics by which to distinguish styles of beer, such as IPAs and Ales. By running a correlation test, we found ABV and IBU to have a Pearson's Correlation R of .67, indicating a medium to strong positive linear relationship. Further exploring this relationship, we created a knn model (internal validation) with an accuracy of 87% -- this high accuracy is reflective of the distinctness of IPA and Ale groups by ABV and IBU metrics. A Welch's t-test for both of these metrics and groups confirmed this position, both returning a p-value of <.0001. It is important to note that more data is needed to explore the causal relationship of ABV and IBU.

Additionally, we created multiple Naive-Bayes models that can be used to predict preference of beer style by geography (city or state).

Data was also scraped from a website to create a map of top-rated beers by state. All visualizations of these findings were created in a Tableau workbook ("Presentation" --> "Tableau_Workbook").

## Conclusion
 ABV and IBU are one of many factors that can be analyzed in the make-up of a beer. Although not exhaustive, they can serve to help us analyze distributions, trends, and even create predictions that may serve a variety of purposes. In this analysis, we've highlighted the importance of ABV and IBU and provide insights with regard to what it could provide. By using statistical analyses 

Additionally, we created machine learning models (knn and Naive-Bayes) to predict preferences of Style by Geography (City or State). We visualized that data through a tableau workbook (listed under Presentation folder). These models have potential to be used for R&D and marketing strategies.
