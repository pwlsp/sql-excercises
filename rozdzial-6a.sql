-- Zadanie 1

select nazwisko,
       etat,
       id_zesp
  from pracownicy
 where id_zesp = (
   select id_zesp
     from pracownicy
    where nazwisko = 'BRZEZINSKI'
)
 order by nazwisko;

-- Zadanie 2

select pracownicy.nazwisko,
       pracownicy.etat,
       zespoly.nazwa
  from pracownicy
natural join zespoly
 where id_zesp = (
   select id_zesp
     from pracownicy
    where nazwisko = 'BRZEZINSKI'
)
 order by nazwisko;

-- Zadanie 3

-- INSERT INTO pracownicy(id_prac, nazwisko, etat, zatrudniony)
-- VALUES ((SELECT max(id_prac) + 1 FROM pracownicy),
-- 'WOLNY', 'ASYSTENT', DATE '1968-07-01');

select nazwisko,
       etat,
       to_char(
          zatrudniony,
          'RRRR/MM/DD'
       ) as zatrudniony
  from pracownicy
 where to_char(
      zatrudniony,
      'RRRR/MM/DD'
   ) = (
      select min(to_char(
         zatrudniony,
         'RRRR/MM/DD'
      ))
        from pracownicy
       where etat = 'PROFESOR'
   )
   and etat = 'PROFESOR';

-- Zadanie 4

select nazwisko,
       to_char(
          zatrudniony,
          'RRRR/MM/DD'
       ) as zatrudniony,
       id_zesp
  from pracownicy
 where ( zatrudniony,
         id_zesp ) in (
   select max(zatrudniony),
          id_zesp
     from pracownicy
    where id_zesp is not null
    group by id_zesp
);

-- Zadanie 5
select id_zesp,
       nazwa,
       adres
  from zespoly
 where id_zesp not in (
   select id_zesp
     from pracownicy
    where id_zesp is not null
    group by id_zesp
);

-- Zadanie 6

-- DELETE FROM pracownicy
-- WHERE nazwisko = 'WOLNY';

select nazwisko
  from pracownicy
 where id_prac not in (
   select id_szefa
     from pracownicy
    where etat = 'STAZYSTA'
)
   and etat = 'PROFESOR';

-- Zadanie 7

select id_zesp,
       sum(placa_pod) as suma_plac
  from pracownicy
having sum(placa_pod) = (
   select max(suma_plac)
     from (
      select sum(placa_pod) as suma_plac
        from pracownicy
       group by id_zesp
   )
)
 group by id_zesp;

-- Zadanie 8

select z.nazwa,
       sum(p.placa_pod) as suma_plac
  from pracownicy p
 inner join zespoly z
on p.id_zesp = z.id_zesp
having sum(p.placa_pod) = (
   select max(suma_plac)
     from (
      select sum(placa_pod) as suma_plac
        from pracownicy
       group by id_zesp
   )
)
 group by z.nazwa;

-- Zadanie 9
select z.nazwa,
       count(*) as ilu_pracownikow
  from pracownicy p
natural inner join zespoly z
having count(*) > (
   select count(*)
     from pracownicy p
   natural inner join zespoly z
    where z.nazwa = 'ADMINISTRACJA'
)
 group by z.nazwa
 order by z.nazwa;

-- Zadanie 10

select etat
  from pracownicy
having count(*) = (
   select max(ile) as max
     from (
      select etat,
             count(*) as ile
        from pracownicy
       group by etat
   )
)
 group by etat
 order by etat;

-- Zadanie 11
select etat,
       listagg(nazwisko,
               ',') within group(
        order by nazwisko) as pracownicy
  from pracownicy
natural inner join (
   select etat
     from pracownicy
   having count(*) = (
      select max(ile) as max
        from (
         select etat,
                count(*) as ile
           from pracownicy
          group by etat
      )
   )
    group by etat
    order by etat
)
 group by etat;

-- Zadanie 12
select p.nazwisko as pracownik,
       s.nazwisko as szef
  from pracownicy p
 inner join pracownicy s
on p.id_szefa = s.id_prac
 where s.placa_pod - p.placa_pod = (
   select min(roznica_plac)
     from (
      select p.id_prac,
             p.id_szefa,
             s.placa_pod - p.placa_pod as roznica_plac
        from pracownicy p
       inner join pracownicy s
      on p.id_szefa = s.id_prac
   )
);