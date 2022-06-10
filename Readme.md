<h1 align="center"> McDonald's Snack Rating </h1>

<h2> Summary </h2> 
___________________
<p> This project </p>
<p align="center">
    <a href= "#About">About </a> *
    <a href= "#Requirements">Requirements </a> *
    <a href= "#Problem">Problem </a> *
    <a href= "#Solution">Solution </a> *
    <a href= "#Method">Method </a> *
    <a href= "#Visualization">Visualization </a> *
    <a href= "#Conclusion">Conclusion </a> *
</p>

# About
<p> Let's learn some ways of sorting algorithms from cluster analysis. </p>

# Requirements
<p> I recommend downloading the R cran installer https://cran.r-project.org/ and later the RStudio software https://www.rstudio.com/products/rstudio/download/ to run the scripts below and view the interactions. </p>

# Problem
<p> I need to identify which McDonald's snacks have the same caloric amount in common to tell my friends who have a strict diet. </p>

# Solution
<p> Create an algorithm capable of generating groups that are homogeneous among themselves and heterogeneous among groups. </p>

# Method
<p> hierarchical: The approaches will be used: “Euclidean distance” using “single” . </p>
<p> unhierarchical: The approaches will be used: kMeans . </p>

# Visualization
<p> hierarchical: cluster dendrogram. </p>
<p> unhierarchical: cluster kmeans. </p>

# Conclusion
<p> hierarchical method: Groups 2 and 4 have snacks with the highest amount of caloric intake, having high levels of trans fat, cholesterol and saturated fat. Thus, in a regulated diet these groups of snacks should be avoided.</p>
<p> unhierarchical method: Groups 3 and 4 have snacks with the highest amount of caloric intake, having high levels of trans fat, cholesterol and saturated fat. Thus, in a regulated diet these groups of snacks should be avoided.</p>
<p> Note. There is no right or wrong when choosing hierarchical and non-hierarchical methods as the researcher needs to understand the context of the problem and choose the best technique according to the business need. </p>