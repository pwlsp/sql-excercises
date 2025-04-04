-- INSERT INTO pracownicy(id_prac, nazwisko)
-- VALUES ((SELECT max(id_prac) + 1 FROM pracownicy), 'WOLNY');

-- Zadanie 1

select pracownicy.nazwisko,
       pracownicy.id_zesp,
       zespoly.nazwa
  from pracownicy
  left outer join zespoly
on pracownicy.id_zesp = zespoly.id_zesp
 order by pracownicy.nazwisko;

-- Zadanie 2

select zespoly.nazwa,
       zespoly.id_zesp,
       case
          when pracownicy.nazwisko is null then
             'brak pracownikow'
          else
             pracownicy.nazwisko
       end as nazwisko
  from zespoly
  left outer join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
 order by zespoly.nazwa;

-- Zadanie 3

select case
          when zespoly.nazwa is null then
             'brak zespolu'
          else
             zespoly.nazwa
       end as zespol,
       case
          when pracownicy.nazwisko is null then
             'brak pracownikow'
          else
             pracownicy.nazwisko
       end as nazwisko
  from zespoly
  full outer join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
 order by zespol nulls last;

-- DELETE FROM pracownicy
-- WHERE nazwisko = 'WOLNY';

-- Zadanie 4

select zespoly.nazwa as zespol,
       count(pracownicy.id_prac) as liczba,
       sum(pracownicy.placa_pod)
  from zespoly
  left outer join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
 group by zespoly.nazwa
 order by zespol;

-- Zadanie 5

select zespoly.nazwa
  from zespoly
  left outer join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
 where pracownicy.id_prac is null
 group by zespoly.nazwa
 order by zespoly.nazwa;

-- Zadanie 6

select a.nazwisko as pracownik,
       a.id_prac,
       b.nazwisko,
       a.id_szefa
  from pracownicy a
  left outer join pracownicy b
on a.id_szefa = b.id_prac
 order by a.nazwisko;

-- Zadanie 7

select b.nazwisko as pracownik,
       count(a.id_prac) as liczba_podwladnych
  from pracownicy a
 right outer join pracownicy b
on a.id_szefa = b.id_prac
 group by b.nazwisko
 order by b.nazwisko;

-- Zadanie 8

select a.nazwisko,
       a.etat,
       a.placa_pod,
       z.nazwa,
       b.nazwisko as szef
  from pracownicy a
  left outer join pracownicy b
on a.id_szefa = b.id_prac
  left outer join zespoly z
on a.id_zesp = z.id_zesp
 order by a.nazwisko;

-- Zadanie 9

select pracownicy.nazwisko,
       zespoly.nazwa
  from pracownicy
 cross join zespoly
 order by pracownicy.nazwisko,
          zespoly.nazwa;

-- Zadanie 10

select count(*)
  from pracownicy
 cross join zespoly
 cross join etaty;

-- Zadanie 11

select etat
  from pracownicy
 where extract(year from zatrudniony) = 1992
intersect
select etat
  from pracownicy
 where extract(year from zatrudniony) = 1992;

-- Zadanie 12

select id_zesp
  from zespoly
except
select id_zesp
  from pracownicy;

-- Zadanie 13
select b.id_zesp,
       a.nazwa
  from zespoly a
 inner join (
   select id_zesp
     from zespoly
   except
   select id_zesp
     from pracownicy
) b
on a.id_zesp = b.id_zesp;

-- Zadanie 14

select nazwisko,
       placa_pod,
       'Ponizej 480 zlotych' as prog
  from pracownicy
 where placa_pod < 480
union
select nazwisko,
       placa_pod,
       'Dokladnie 480 zlotych' as prog
  from pracownicy
 where placa_pod = 480
union
select nazwisko,
       placa_pod,
       'Powyzej 480 zlotych' as prog
  from pracownicy
 where placa_pod > 480
 order by placa_pod;