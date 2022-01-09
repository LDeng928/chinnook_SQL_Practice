/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/
-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE
--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT artists.Name
FROM artists
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId
WHERE albums.ArtistId IS NULL
GROUP BY artists.Name

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
SELECT artists.Name FROM genres
JOIN tracks ON tracks.GenreId = genres.GenreId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE genres.Name = 'Latin'
GROUP BY artists.Name


/* TASK III
Which video track has the longest length?
*/
SELECT Name, MAX(Milliseconds) FROM tracks

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
SELECT * FROM customers
JOIN employees ON employees.EmployeeId = customers.SupportRepId
WHERE customers.City = (
  SELECT employees.City FROM employees
  WHERE ReportsTo IS NULL
)


/* TASK V
Find the managers of employees supporting Brazilian customers.
*/
SELECT sup.FirstName, sup.LastName
FROM employees sup
JOIN employees sub ON sup.EmployeeId = sub.ReportsTo
WHERE sub.EmployeeId = (
  SELECT SupportRepId
  FROM customers
  WHERE Country = 'Brazil'
);

SELECT SupportRepId
FROM customers
WHERE Country = 'Brazil';

SELECT * FROM employees

/* TASK VI
Which playlists have no Latin tracks?
*/
SELECT genres.Name, playlists.Name FROM playlist_track
JOIN playlists ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON tracks.TrackId = playlist_track.TrackId
JOIN genres ON tracks.GenreId = genres.GenreId
WHERE genres.Name != 'Latin'
GROUP BY genres.Name