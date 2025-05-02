-- Zadanie 1
select *
  from zespoly z
 where z.id_zesp not in (
   select id_zesp
     from pracownicy
    where id_zesp = z.id_zesp
);

-- Zadanie 2 
select p.nazwisko,
       p.placa_pod,
       p.etat
  from pracownicy p
 where p.placa_pod > (
   select avg(p2.placa_pod)
     from pracownicy p2
    where p2.etat = p.etat
)
 order by p.placa_pod desc;

-- Zadanie 3
select nazwisko,
       placa_pod
  from pracownicy p
 where p.placa_pod > (
   select placa_pod * 0.75
     from pracownicy
    where p.id_szefa = id_prac
);

-- Zadanie 4
select nazwisko
  from pracownicy p
 where not exists (
   select *
     from pracownicy
    where etat = 'STAZYSTA'
      and p.id_prac = id_szefa
)
   and etat = 'PROFESOR';

-- Zadanie 5 (źle, poniżej jest dobrze)
select z.nazwa,
       sum(p.placa_pod) as suma
  from pracownicy p
natural join zespoly z
having sum(p.placa_pod) = (
   select max(suma)
     from (
      select sum(placa_pod) as suma
        from pracownicy
       group by id_zesp
   )
)
 group by z.nazwa;

-- Zadanie 5 (dobrze)
select z.nazwa,
       suma
  from (
   select max(suma) as suma
     from (
      select sum(placa_pod) as suma
        from pracownicy
       group by id_zesp
   )
)
natural join (
   select id_zesp,
          sum(placa_pod) as suma
     from pracownicy
    group by id_zesp
)
natural join zespoly z;

-- Zadanie 6
select p.nazwisko,
       p.placa_pod
  from pracownicy p
 where (
   select count(p2.id_prac)
     from pracownicy p2
    where p2.placa_pod > p.placa_pod
) < 3
 order by p.placa_pod desc;

-- Zadanie 7 ver. I
select nazwisko,
       placa_pod,
       placa_pod - (
          select avg(placa_pod)
            from pracownicy u
           where u.id_zesp = p.id_zesp
           group by id_zesp
       ) as roznica
  from pracownicy p
 order by nazwisko;

-- Zadanie 7 ver. II
select nazwisko,
       placa_pod,
       placa_pod - srednia as roznica
  from (
   select id_zesp,
          avg(placa_pod) as srednia
     from pracownicy
    group by id_zesp
)
natural join pracownicy
 order by nazwisko;

-- Zadanie 8 ver. I
select nazwisko,
       placa_pod,
       roznica
  from (
   select nazwisko,
          placa_pod,
          placa_pod - (
             select avg(placa_pod)
               from pracownicy u
              where u.id_zesp = p.id_zesp
              group by id_zesp
          ) as roznica
     from pracownicy p
    order by nazwisko
)
 where roznica > 0;

-- Zadanie 8 ver. II
select nazwisko,
       placa_pod,
       placa_pod - srednia as roznica
  from (
   select id_zesp,
          avg(placa_pod) as srednia
     from pracownicy
    group by id_zesp
)
natural join pracownicy
 where placa_pod - srednia > 0
 order by nazwisko;

-- Zadanie 9
select nazwisko,
       (
          select count(*)
            from pracownicy r
           where r.id_szefa = p.id_prac
           group by id_szefa
       ) as podwladni
  from pracownicy p
natural join zespoly z
 where etat = 'PROFESOR'
   and adres like 'PIOTROWO%'
 order by podwladni desc;

-- Zadanie 10
-- SELECT NAZWA, AVG(PLACA_POD) AS SREDNIA_W_ZESPOLE, SREDNIA_OGOLNA
-- FROM ZESPOLY z NATURAL LEFT JOIN (SELECT ID_ZESP, PLACA_POD, (SELECT ROUND(AVG(PLACA_POD),2) FROM PRACOWNICY) AS SREDNIA_OGOLNA FROM PRACOWNICY) p
-- GROUP BY NAZWA
-- ORDER BY NAZWA
-- ;
-- SELECT NAZWA, AVG(PLACA_POD) AS SREDNIA_W_ZESPOLE, (SELECT ROUND(AVG(PLACA_POD),2) FROM PRACOWNICY) AS SREDNIA_OGOLNA
-- FROM ZESPOLY z NATURAL LEFT JOIN PRACOWNICY p
-- GROUP BY NAZWA
-- ORDER BY NAZWA
-- ;
-- SELECT NAZWA, SREDNIA_W_ZESPOLE, SREDNIA_OGOLNA,
--     CASE
--         WHEN SREDNIA_W_ZESPOLE >= SREDNIA_OGOLNA THEN ':)'
--         WHEN SREDNIA_W_ZESPOLE < SREDNIA_OGOLNA THEN ':('
--         ELSE '???'
--     END AS NASTROJE
-- FROM
--     (SELECT NAZWA, AVG(PLACA_POD) AS SREDNIA_W_ZESPOLE, (SELECT ROUND(AVG(PLACA_POD),2) FROM PRACOWNICY) AS SREDNIA_OGOLNA
--     FROM ZESPOLY z NATURAL LEFT JOIN PRACOWNICY p
--     GROUP BY NAZWA)
-- ORDER BY NAZWA
-- ;
select z.nazwa,
       avg(p.placa_pod) as srednia_w_zespole,
       (
          select round(
             avg(placa_pod),
             2
          )
            from pracownicy
       ) as srednia_ogolna,
       case
          when avg(p.placa_pod) is null then
             '???'
          when avg(p.placa_pod) >= (
             select avg(placa_pod)
               from pracownicy
          ) then
             ':)'
          when avg(p.placa_pod) < (
             select avg(placa_pod)
               from pracownicy
          ) then
             ':('
       end as nastroje
  from zespoly z
natural left join pracownicy p
 group by z.nazwa
 order by z.nazwa;

-- Zadanie 11
select *
  from etaty e
 order by (
   select count(p.id_prac)
     from pracownicy p
    where p.etat = e.nazwa
) desc,
          nazwa;