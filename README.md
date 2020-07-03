## CleaningCourseProject README
the file "run_analysis.R" is the file that clean the data. it has 5 steps
# Step 1: join trainig and test data
in this step, first the code download the .zip file that contains the info. Then, unzip the file and read for the train and test data the files subject,X and y and bind the columns of these three files. The next step is bind the two dataframes ("testdata"" and "traindata") by the rows with the rbind() function in the new data frame called "fulldata".

# Step 2: Extract only measurements of mean and standard deviation
To achive this, first the names of all the columns are extracted in the variable "names". Then with the grep() fuction I look for the position of the "mean()" and "std()" characters. With that positions I extract the colums that corresponds with them and save the new data frame with the name "data2".

#Step 3: Use descriptive actiivity names
First, I read the activity names from the file "activity_labels.txt" and save it in the variable "anames". The a make a "for" cycle that goes for every row of the activity column and replace the number with the correspondet name.

#Step 4: apropiate variables names
In this step I extract the names of columns in the variable "currnames". Then I make some transformations using. First i change all the labels to lower case. Then with the sub() function I make the following changes: 
*change the initial "t" for "time" and add a blank space
*change the initial "f" for "frequency" and add a blank space
*change the dash "-" for a blank space
*eliminate the parenthesis after mean and std
*change "mag" for magnitude
Finally, add the new labels to the dataframe

# Step 5: create a new data frame that shows the mean of all variables by activity and by subject
to accomplish this step I used the "dplyr" package. I group the data by activity and then by subject with the group_by() function and save the changes in a new data frame called "data4". Then I apply the mean function to all the columns with the summarize_all() function and save the result in the variable called "newtable". Finally I change the class of the variable "newtable" to data frame, because the summarize_all() function changed the class to "tibble".

