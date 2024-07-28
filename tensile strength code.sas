/*ID: Identifier for each sample
Formulation: Type of formulation(e.g., different ratios or additives)
Thickness: Thickness of the plastic sample
Temperature: Temperature during the experiment
Humidity:Humidity during the experiment
TensileStrength:Measured tensile strength of the plastic*/

ODS PDF FILE="/home/u63929176/tensile strenght.PDF";

/* Example dataset */
data tensile_strength;
    input ID $ Formulation $ Thickness Temperature Humidity TensileStrength;
    datalines;
    1 F1 0.5 25 60 12.5
    2 F1 0.6 25 60 14.0
    3 F1 0.7 25 60 13.8
    4 F2 0.5 30 55 15.2
    5 F2 0.6 30 55 16.0
    6 F2 0.7 30 55 15.5
    7 F3 0.5 35 50 14.8
    8 F3 0.6 35 50 15.0
    9 F3 0.7 35 50 14.5
    10 F4 0.5 25 70 12.0
    11 F4 0.6 25 70 12.3
    12 F4 0.7 25 70 12.2
    ;
run;

/* Perform analysis of variance (ANOVA) to determine factors affecting tensile strength*/


/* If you want to include interactions */
proc glm data=tensile_strength;
    class Formulation;
    model TensileStrength = Formulation Thickness Temperature Humidity Thickness*Temperature Thickness*Humidity Temperature*Humidity;
    means Formulation / tukey; /* Post-hoc test to compare means */
run;

/* Regression analysis to understand the relationship between variables */
proc reg data=tensile_strength;
    model TensileStrength = Thickness Temperature Humidity;
run;

/* Summary statistics */
proc means data=tensile_strength n mean stddev min max;
    var Thickness Temperature Humidity TensileStrength;
run;

/* Visualization */
proc sgplot data=tensile_strength;
    scatter x=Thickness y=TensileStrength / group=Formulation;
    reg x=Thickness y=TensileStrength / group=Formulation;
run;
proc glm data=tensile_strength;
    class Formulation; /* Assuming formulation is the main factor */
    model TensileStrength = Formulation Thickness humidity temperature ;
    means Formulation / tukey; /* Post-hoc test to compare means */
run;
ODS PDF CLOSE;

 /*Dataset Creation: The data tensile_strength; block creates a dataset with different variables related to the plastic samples.
 ANOVA: proc anova tests the effect of different formulations and other factors on tensile strength.
 GLM: proc glm is used if you want to examine interactions between variables.
 Regression Analysis: proc reg helps in understanding the relationship betweentensile strength and other continuous variables 
 Summary Statistics: proc means provides descriptive statistics for the dataset.
 Visualization: proc sgplot visualizes the relationship between thickness 
 and tensile strength, with different formulations represented by colors.
 This code will help you analyze the impact of different variables on the tensile strength of your biodegradable 
 plastic and determine which factors are significant.*/

proc export data= WORK.tensile_strenght
        outfile="/home/u63929176/tensile strenght.xlsx"
        dbms=xlsx ;
run;        
