/* UCL DSS SQL Workshop

Author: Philip Wilkinson, Head of Science (21/22)

contact: philip.wilkinson.19@ucl.ac.uk

Date: 10 Aug 2021

Proudly presented by the UCL Data Science Society

Acknowledgement: The content of this workshop is inspired by W3 schools SQL content that can
be found here: https://www.w3schools.com/sql/default.asp */


/* Welcome to UCL DSS SQL workshop

This workshop will ocver the basics of SQL querying including being able to
select and load data from SQL, extracting summary measures from data
and grouping, joining and ordering data

SQL stands for structured query language and is the primary language that
data scientists would use to extract and load data. SQL is primary used as 
a relational data store to store large amounts of data that can be served
through to any analytical processes that we use.

We have already seen that we can send data to SQL to Python. In some cases
this is how it is done. It can be loaded through Python into SQL tables and 
databases as is often the case. It can also be loaded manually into SQL 
but this is a more complicated process that you can learn and understand in your
spare time if you so wish

The first thing to note is that we have created two tables by pushing the data
from Python. While we can easily analyse this in Python as you will see in later workshops
for now, we can see how we can manipulate the data and extract insights 
using SQL language

An important note before we start however is that we can comment in SQL
just like we would with Python using #. However if you want longer text to be commented
out just like this. This you can use the notation that we have at the beginning and at the end
*/

/*
The first thing to make sure is that we se the UCL_DSS_db as our default schema
I will show you this during the workshop

Once this has been set as the default schema, we can then query any tables that we have
in this database. We primarily do this using the SELECT notation, where we specify which table
we want the information from using the FROM statement. An example of this can be seen below: */

SELECT * FROM single_table;

/* What this statement does is that the * means all columns, which we select from the single_table
table that we have access to. This essentially returns all the data that the table contains. 
Of course, this has little use for us, especially if it is a big table. We can set a limit on this query
so that only 100 items are returned using the LIMIT statement.
*/

SELECT * 
FROM single_table
LIMIT 100;

/* As we can see, this limits the informaion returned to only 100 rows and this is important, especially
when performing complicated analysis first time as you don't want to wait for a long time then to only find 
out that you have performed the wrong analysis... been there ... done that...

The next thing is to then select only a certain number of columns from the dataset. For this, we may focus only
on the shows air date, the categroy of the question and the value of the question. We do this by specifying the
columns that we want to extract from the dataset in the select statement. Note how `` are used to denote some
columns because there is either a space in the name or the name als equates with an SQL function or statement
 */

SELECT `Air Date`,Category, `Value` 
FROM single_table
LIMIT 100;

/*We can then limit this further by specifying a condition that we want to examine. For example,
we can see that there are several different categories available in the dataset, what if we wanted to
only look at questions where the category was History? We can do that using the WHERE statement*/

SELECT `Air Date`, Category, `Value` 
from single_table 
WHERE Category = "HISTORY"
LIMIT 100;

/*We can see from this that there are many questions over time that have category history. We can improve this 
query by using similar notation as in Python by combing there where clause with OR, AND and NOT. For example,
what about where the category is History and teh value is 200? */

SELECT `Air Date`, Category, `Value`
FROM single_table
WHERE Category = "HISTORY"
AND `Value` = 200
LIMIT 100;

/*Alongside this we can also use the same operators as in Python for comparison in the WHERE statements,
including: >, <, >=, <=. For example if we wanted to instead check where the category was history
but the value was greater than 200 we would use */

SELECT `Air Date`, Category, `Value`
FROM single_table
WHERE Category = "HISTORY"
AND `Value` > 200
LIMIT 100;


/* This is the basics of querying from the data. Can you perform some similar queries on the double_table 
table? 

Extract the first 100 rows from the double table of the show number, air date and category

Extract the first 100 rows from the double table of the category, question and answer where
the category was History

Extract the first 100 rows from the double table of show date, category, question, answer
and value where the Answer was "Milan" 

Extract the first 100 rows for the double table of Air Date, Question and Answer where the Air date was after 
"2012-10-01"*/

/* Now that we know the basics of querying the Data we can perform some summary statistics
and some more complicated queries. 

One of the more useful functions in terms of this is the DISTINCT statement. This will essentially
extract only unique values from the dataset. For example we can extract only distinct categories from
the dataset as follows: */

SELECT DISTINCT Category
FROM single_table
LIMIT 100;

/*As we can see there are many different categories, potentially many more than 100. We can check how many
there actually are using the COUNT summary statistic measure as follows */

SELECT COUNT(DISTINCT CATEGORY)
FROM single_table;

/* This tells us that there are 15,115 distinct categories in the single table alone! That is a lot
of categories to be able to choose from and learn! Can you image trying to learn that many categories?

Of course, there are also many other summary statistics we can use such as average, sum, max and min 
as part of SQL queries. We can see examples of these as follows: */

SELECT AVG(`VALUE`)
FROM single_table;

SELECT MIN(`VALUE`)
FROM single_table;

SELECT MAX(`VALUE`) 
FROM single_table;

/* The issue with this is that we are only using this to get summary measures of the entire dataset
which is useful and all but is rather limited. We can instead use this to get data about different groups
by using the GROUP BY statement in conjunction with the aggregate functions. For example. If we wanted to find
the avg value for different categories, or the average value for a specific air date */

SELECT Category, AVG(`Value`)
FROM single_table
GROUP BY Category
LIMIT 100;

SELECT `Air Date`, AVG(`Value`)
FROM single_table
GROUP BY `Air Date`
LIMIT 100;

/* We can see what this doing, but in the way that the data is currently returned we don't really
get too much information from the results. This is because we don't have any order to the data. Sure, we are
getting the average value by category by what about which category has teh highest average value? What date 
has the highest minimum value? We can do that using the ORDER BY statement which can be used to order
the columns that we want. We add DESC or ASC to the end of that to state whether we want the top 100
or the bottom 100 as follows */

SELECT Category, AVG(`Value`)
FROM single_table
GROUP BY Category
ORDER BY AVG(`Value`) DESC
LIMIT 10;

SELECT `Air Date`, AVG(`Value`) AS avg_value
FROM single_table
GROUP BY `Air Date`
ORDER BY `Air Date` ASC
LIMIT 100;

/* This provides us with much more useful information than what we would have had normally if we just
used the GROUP BY function. 

As part of this, you may have noticed I used the AS statement, which allows you to rename a column
to something that is muh easier to understand or call later on. This is something small
but can save you a lot of time when using complicated joins or other things

Finally, the last thing we will look at is the join. This can be used to join two tables together 
based on values in the left, right, both or neither table. An example of this here is a left
join, which uses all the information from the left table and only the joined information from the right table.
An example of this is where we join the left table with the right table on the basis of matching
categories as follows */

SELECT a.`Air Date`, a.`Show Number`, b.`Air Date`, b.`Show Number`
FROM single_table a
LEFT JOIN double_table b
on a.`index` = b.`index`
LIMIT 100;

/* Which creates a poor example in this case as the indexes do not align properly 
in terns of the air dates and show numbers, but could be used in tables where different information is 
shown. For example if you have a customer name in a sales table which shows the sales information and
theoir address stored in another table to avoid duplication, you can join the tables on the customers
name to show all information in a single line instead of multiple tables

More information on this can be found here: https://www.w3schools.com/sql/sql_join.asp */

/* With this in mind therefore can you perform the following searches:

How many distinct show numbers are there in the single_table and double_table? Is there a difference? What do 
you think this means?

What is the average value of question in the double_table? How is that different to the single table?

What are the least 10 episodes in the double table for average value?

What is the average value for the latest 10 shows, and the average value of the earliest 10 shows from 
the double table? What do you think that says?
Is this trend also seen in for the single_table?

What the average value for questions in the single_table which have the answer = "MILAN"?

Which category from either the double or the single table has the highest average value? 
Which category has the lowest average value?

Which episode has the most questions in the double table?

What answer appears the most in the single or the double table?

Can you order the Questions in the single and double table by alphabetical order?

Can you order the Answers in the single and double table by alphabetical order? */

