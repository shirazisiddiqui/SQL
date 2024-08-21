#1.	Write a query to display the movie title, movie year, and movie genre for all movies sorted by movie genre in ascending order, then sorted by movie year in descending order within genre. 

Select Movie_Name, Movie_Year, Movie_Genre 
From Movie 
order by Movie_Genre, Movie_Year desc;

#2.	Write a query to display the movie number, movie title, and price code for all movies with a title that starts with the letter “R”. 

Select Movie_Num, Movie_Name, Price_Code 
From Movie 
Where Movie_Name Like ‘R%’;

#3.	Write a query to display the movie title, movie year, and movie cost for all movies that contain the word “hope” anywhere in the title. Sort the results in ascending order by title. 

Select Movie_Name, Movie_Year, Movie_Cost  From Movie 
Where Movie_Name Like ‘%hope’ or Movie_Name Like ‘%Hope%’
Order by Movie_Name;

#4.	Write a query to display the movie number, movie title, movie cost, and movie genre for all movies that are either action or comedy movies and that have a cost that is less than $50. Sort the results in ascending order by genre. 

Select Movie_Num, Movie_Name, Movie_Cost, Movie_Genre 
From Movie 
Where Movie_Genre IN (‘ACTION’,’ COMEDY’) 
And Movie_Cost < 50 
Order by Movie_Genre;

#5.	Write a query to display the movie genre and the number of movies in each genre. 
 
 Select Movie_Genre, Count(*) as “No_of_Movies”
 From Movie 
 Group by Movie_Genre;

#6.	Write a query to display the movie genre and average cost of movies in each genre. 
              
              Select Movie_Genre, Avg(Movie_Cost) as “Avg_Cost”
              From Movie 
              Group by Movie_Genre;

#7.	Write a query to display the movie title, movie genre, price description, and price rental fee for all movies with a price code. 
             
             Select M.Movie_Name, M.Movie_Genre ,P.Price_Description, P.Price_Rentfee          
             From Movie M, Price P 
             Where M.Price_code = P.Price_code
             And P.Price_code is not null;
 
#8.	Write a query to display the movie genre and average price rental fee for movies in each genre that have a price. 
             
             Select M.Movie_Genre , Avg(P.Price_Rentfee) as “Avg_Price_Rentfee”
             From Movie M, Price P 
             Where M.Price_code = P.Price_code
             And P.Price_code is not null
             Group by M.Movie_Genre; 

#9.	Write a query to display the movie title, movie year, and the movie cost divided by the price rental fee for each movie that has a price to determine the number of rentals it will take to break even on the purchase of the movie.
            
            Select M.Movie_Name, M.Movie_Year, M.Movie_Cost/P.Price_Rentfee 
            From Movie M, Price P 
            Where M.Price_code = P.Price_code
            And P.Price_code is not null; 

#10.	Write a query to display the movie title and movie year for all movies that have a price code. 
            
            Select Movie_Name, Movie_Year 
            From Movie 
            Where Price_code is not null;

#11.	Write a query to display the movie number, movie title, and movie year for all movies that do not have a video. 
       
       Select M.Movie_Num, M.Movie_Name, M.Movie_Year 
       From Movie M 
       Left Join VIDEO V
       On M.Movie_Num=V.Movie_Num 
       Where V.Movie_Num is null;

#12.	Write a query to display the movie title, movie year, and movie cost for all movies that have a cost between $44.99 and $49.99. 
       
       Select Movie_Name, Movie_Year, Movie_Cost 
       From Movie 
       Where Movie_Cost  between 44.99 and 49.99;

#13.	Write a query to display the movie title, movie year, price description, and price rental fee for all movies that are in the genres Family, Comedy, or Drama. 
       
       Select M.Movie_Name, M. Movie_Year ,P.Price_Description, P.Price_Rentfee         
       From Movie M, Price P 
       Where M.Price_code = P.Price_code 
       And Movie_Genre IN (‘FAMILY’,’ COMEDY’,’ DRAMA’); 
#14.	Write a query to display the membership number, first name, last name, and balance of the memberships that have a rental. 
   
   Select Distinct MS.Mem_Num, MS.Mem_Fname, MS.Mem_Lname, MS.Mem_Balance 
   From  Membership MS , Rental R 
   Where MS. Mem_Num = R.Mem_Num
   And   R.Rent_Num is not null;

#15.	Write a query to display the minimum balance, maximum balance, and average balance for memberships that have a rental. 
  
  Select Min(MS.Mem_Balance) as “Minimum_Balance”, 
             Max(MS.Mem_Balance) as “Maximum_Balance”, 
             Avg(MS.Mem_Balance) as “Average_Balance”
  From  Membership MS , Rental R 
  Where MS.Mem_Num = R.Mem_Num 
  And   R.Rent_Num is not null;   

#16.	Write a query to display the rental number, rental date, video number, movie title, due date, and return date for all videos that were returned after the due date. Sort the results by rental number and movie title. 

Select R.Rent_Num, R.Rent_Date, V.Vid_Num , M.Movie_Name, DR.Detail_Duedate, DR.Detail_Returndate 
From Rental R, VIDEO V, MOVIE M, DETAILRENTAL DR 
Where M.Movie_Num= V.Movie_Num 
and R.Rent_Num = DR.Rent_Num 
and V. Vid_Num = DR.Vid_Num 
and  DR.Detail_Returndate > DR.Detail_Duedate 
order by R.Rent_Num, M.Movie_Name;

#17.	Write a query to display the rental number, rental date, video number, movie title, due date, return date, detail fee, and number of days past the due date that the video was returned for each video that was returned after the due date. Sort the results by rental number and movie title. 

Select R.Rent_Num, R.Rent_Date, V.Vid_Num , M.Movie_Name, 
DR.Detail_Duedate, DR.Detail_Returndate, DR. Detail_Fee , 
(DR.Detail_Returndate-DR.Detail_Duedate) as “No_Days_Pastdue”
From Rental R, VIDEO V, MOVIE M, DETAILRENTAL DR 
Where M.Movie_Num= V.Movie_Num 
and R.Rent_Num = DR.Rent_Num 
and V. Vid_Num = DR.Vid_Num 
and DR.Detail_Returndate > DR.Detail_Duedate 
order by R.Rent_Num, M.Movie_Name;

#18.	Write a query to display the rental number, rental date, movie title, and detail fee for each movie that was returned on or before the due date. 
 
 Select R.Rent_Num, R.Rent_Date, M.Movie_Name, DR. Detail_Fee
 From Rental R, MOVIE M, DETAILRENTAL DR , VIDEO V
 Where M.Movie_Num= V.Movie_Num
 and R.Rent_Num = DR.Rent_Num
 and V. Vid_Num = DR.Vid_Num 
 and  DR.Detail_Returndate <= DR.Detail_Duedate;

#19.	Write a query to display the membership number, last name, and total rental fees earned from that membership. The total rental fee is the sum of all of the detail fees (without the late fees) from all movies that the membership has rented. 

Select MS.Mem_Num, MS.Mem_Lname, Sum(DR.Detail_Fee) as “Total_Rental_Fees”
From  Membership MS , Rental R , DETAILRENTAL DR 
Where MS.Mem_Num = R.Mem_Num 
and R.Rent_Num= DR. Rent_Num 
Group by MS.Mem_Num, MS.Mem_Lname;


#20.	Write a query to display the movie number, movie genre, average movie cost of movies in that genre, movie cost of that individual movie, and the percentage difference between the average movie cost and the individual movie cost. 

Select M.Movie_Num, M.Movie_Genre, AG.AVG_Cost as “Avg_movie_cost”, M.Movie_Cost, ((M.Movie_Cost- AG.AVG_Cost)/AG.AVG_Cost*100) as “Percent_Diff” 
From Movie M, (Select Movie_Genre, Avg(Movie_Cost) as AVG_Cost From Movie group by   Movie_Genre) AG 
Where  M.Movie_Genre= AG.Movie_Genre;

