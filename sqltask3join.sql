create database MovieManagement


	create table Genres(
	id int Primary key identity(1,1),
	Name nvarchar(50) Not Null unique,
	) 

	create table Movies(
	id int Primary key identity(1,1),
	Name nvarchar(50) Not Null,
	releaseDate Date not null,
	Imdb decimal(4,2) not null,
	GenreId int foreign key references genres(Id)
	)

	Create Table Actors (
	id int Primary key identity(1,1),
	Name nvarchar(50) Not Null,
	Surname nvarchar(50) Not Null,
	
	)

	Create table ActorMovies(
	id int Primary key identity(1,1),
	ActorId int foreign key references Actors(Id),
	movieId int foreign key references Movies(Id)
	)

	INSERT INTO Genres (Name)
VALUES ('Action'),
       ('Drama'),
       ('Comedy'),
       ('Horror');

	   INSERT INTO Movies (Name, releaseDate, Imdb, GenreId)
VALUES ('The Dark Knight', '2008-07-18', 9.0, 1),    
       ('Inception', '2010-07-16', 8.8, 1),        
       ('The Shawshank Redemption', '1994-10-14', 9.3, 2), 
       ('Pulp Fiction', '1994-10-14', 8.9, 3),
	   ('Check', '2026-12-01', 10.00, 2),
	   ('Movie', '2024-10-10', 5.00, 2),
	   ('Value', '2022-07-18', 9.0, 1), 
	   ('Perfect', '2021-07-01', 6.0, 3);

	   INSERT INTO Actors (Name, Surname)
VALUES ('Leonardo', 'DiCaprio'),
       ('Tom', 'Hanks'),
       ('Brad', 'Pitt'),
       ('Morgan', 'Freeman');
	   INSERT INTO ActorMovies (ActorId, MovieId)
VALUES (1, 2),   
       (1, 4),   
       (2, 4),  
       (3, 3),   
       (4, 4);   

--a. En cox rol oynayan aktyorlarin siyahisi
select top 2 Actors.Name, Actors.Surname ,count (ActorId) from Actors
inner join ActorMovies on ActorMovies.ActorId=Actors.Id
group by Actors.Name, Actors.Surname

--b. Her janrdan nece dene movie olmmagi
select genres.name,movies.genreId,count(genreId) as count_Movie_Per_Genre from genres
inner join movies on movies.GenreId=genres.Id
group by genres.name,genreid
order by genreId asc
--c. Release tarixi gozlenilen kinolar ve ne vaxt release olunacagi
select * from Movies 
where releaseDate>GETDATE()

--d. Son 5 ilde release olan kinolarin ortalama IMDB-si

select avg(Imdb) as average_imdb from Movies
where movies.releaseDate between DATEADD(year,-5,getdate()) and getdate()

--e. 1 den cox kinoda oynayan aktyorlarin siyahisi
select actors.name,actors.surname,count(actormovies.ActorId) as Movies_Of_Actors from actors
inner join actormovies on actormovies.actorid=actors.id
group by actors.name,actors.surname
having count(actormovies.ActorId)>1