create database movieprime;
use movieprime;

CREATE TABLE USER (
  userID varchar(20)
, userPassword varchar(64)
, userEmail varchar(50)
, userEmailHash varchar(64)
, userEmailChecked boolean
);
ALTER TABLE USER ADD PRIMARY KEY (userID);

CREATE TABLE MOVIE(
  movieTitle varchar(100)
, moviePreview varchar(1000)
, comeoutDate date
, moviePoster varchar(100)
, movieContent varchar(1000)
);
ALTER TABLE MOVIE ADD PRIMARY KEY (movieTitle);

CREATE TABLE POST(
  postID int PRIMARY KEY AUTO_INCREMENT
, userID varchar(20)
, movieTitle varchar(100)
, postTitle varchar(50)
, postContent varchar(1000)
, movieTotalScore int
, spoiler boolean
, likeCount int
);
ALTER TABLE POST ADD foreign key(userID) references USER(userID);
ALTER TABLE POST ADD foreign key(movieTitle) references MOVIE(movieTitle);

CREATE TABLE FREEPOST(
  postID int PRIMARY KEY AUTO_INCREMENT
, userID varchar(20)
, postTitle varchar(50)
, postContent varchar(1000)
);
ALTER TABLE FREEPOST ADD foreign key(userID) references USER(userID);

CREATE TABLE LIKEY(	
  userID varchar(20)
, postID int
, userIP varchar(50)
);
ALTER TABLE LIKEY ADD PRIMARY KEY (userID, postID);
ALTER TABLE LIKEY ADD foreign key(userID) references USER(userID) on delete cascade;
ALTER TABLE LIKEY ADD foreign key(postID) references POST(postID);

