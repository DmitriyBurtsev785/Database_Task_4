--количество исполнителей в каждом жанре;

SELECT genre_id, count(singer_id) FROM singergenre
GROUP BY genre_id
ORDER BY count(genre_id) DESC;



--количество треков, вошедших в альбомы 2019-2020 годов;

select count(*) from compilation c 
join trackcompilation t on c.id = t.compilation_id 
where year_of_issue between 2019 and 2020


--средняя продолжительность треков по каждому альбому;

select album_id, AVG(duration) from track t 
group by album_id
order by avg(duration) desc ; 

select a.name, avg(t.duration) from album a 
join track t on a.id = t.album_id 
group  by a."name" 
order by avg(t.duration) desc;


--все исполнители, которые не выпустили альбомы в 2020 году;

select s.name from singer s 
join singeralbum s2 on s.id = s2.singer_id
join album a on s2.album_id = a.id
where year_of_issue < 2020;


--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);

select distinct c.name from compilation c 
join trackcompilation t ON c.id = t.compilation_id
join track t2 on t.track_id = t2.id
join album a on t2.album_id = a.id
join singeralbum s on a.id = s.album_id
join singer s2 on s.singer_id = s2.id
where s2.name like 'Сплин'; 



--название альбомов, в которых присутствуют исполнители более 1 жанра;

select distinct a.name, count(g.id) from album a 
join singeralbum s on s.album_id = a.id 
join singer s2 on s.singer_id = s2.id 
join singergenre s3 on s2.id = s3.singer_id 
join genre g on s3.genre_id = g.id
group by a.name
having count(g.id) > 1;




--наименование треков, которые не входят в сборники;

select t.name from track t 
full join trackcompilation t2 ON t.id = t2.track_id
group  by t."name", t2.compilation_id
having  t2.compilation_id IS NULL;


--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);


select s.name, t.duration from singer s
join singeralbum s2 on s2.singer_id = s.id
join album a on s2.album_id = a.id
join track t on a.id = t.album_id
WHERE t.duration = (SELECT Min(duration) FROM track);



--название альбомов, содержащих наименьшее количество треков. 

select i.eee, min(mycount)
from (
select t2.album_id as eee, count(*) mycount 
from track t2
group by t2.album_id
order by mycount
limit 1
) i
group by i.mycount, i.eee
having i.mycount = min(mycount); 




