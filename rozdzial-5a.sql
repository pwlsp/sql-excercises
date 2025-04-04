-- Zadanie 1
select nazwisko,
       etat,
       p.id_zesp,
       nazwa
  from pracownicy p
 inner join zespoly z
on p.id_zesp = z.id_zesp
 order by nazwisko;

-- Zadanie 2
select nazwisko,
       etat,
       p.id_zesp,
       nazwa
  from pracownicy p
 inner join zespoly z
on p.id_zesp = z.id_zesp
 where adres = 'PIOTROWO 3A'
 order by nazwisko;

-- Zadanie 3
select p.nazwisko,
       p.etat,
       p.placa_pod,
       e.placa_min,
       e.placa_max
  from pracownicy p
 inner join etaty e
on p.etat = e.nazwa
 order by p.etat,
          nazwisko;

-- Zadanie 4
select p.nazwisko,
       p.etat,
       p.placa_pod,
       e.placa_min,
       e.placa_max,
       case
          when ( e.placa_min <= p.placa_pod )
             and ( p.placa_pod <= e.placa_max ) then
             'OK'
          else
             'NIE'
       end as czy_pensja_ok
  from pracownicy p
 inner join etaty e
on p.etat = e.nazwa
 order by p.etat,
          nazwisko;

-- Zadanie 5
select *
  from pracownicy p
 inner join etaty e
on p.etat = e.nazwa
 where ( e.placa_min > p.placa_pod )
    or ( p.placa_pod > e.placa_max )
 order by p.etat,
          nazwisko;

-- Zadanie 6
select pracownicy.nazwisko,
       pracownicy.placa_pod,
       pracownicy.etat,
       etaty.nazwa as kat_plac,
       etaty.placa_min,
       etaty.placa_max
  from pracownicy
 inner join etaty
on placa_pod between placa_min and placa_max
 order by pracownicy.nazwisko,
          kat_plac;

-- Zadanie 7
select pracownicy.nazwisko,
       pracownicy.placa_pod,
       pracownicy.etat,
       etaty.nazwa as kat_plac,
       etaty.placa_min,
       etaty.placa_max
  from pracownicy
 inner join etaty
on placa_pod between placa_min and placa_max
 where etaty.nazwa = 'SEKRETARKA'
 order by pracownicy.nazwisko,
          kat_plac;

-- Zadanie 8
select p.nazwisko as pracownik,
       p.id_prac,
       s.nazwisko as szef,
       p.id_szefa
  from pracownicy p
 inner join pracownicy s
on p.id_szefa = s.id_prac
 order by p.nazwisko;

-- Zadanie 9
select p.nazwisko as pracownik,
       to_char(
          p.zatrudniony,
          'yyyy.mm.dd'
       ) as prac_zatrudniony,
       s.nazwisko as szef,
       to_char(
          s.zatrudniony,
          'yyyy.mm.dd'
       ) as szef_zatrudniony,
       extract(year from(p.zatrudniony - s.zatrudniony) year to month) as lata
  from pracownicy p
 inner join pracownicy s
on p.id_szefa = s.id_prac
 where extract(year from(p.zatrudniony - s.zatrudniony) year to month) <= 10
 order by prac_zatrudniony,
          p.nazwisko;

-- Zadanie 10
select z.nazwa,
       count(*) as liczba,
       avg(p.placa_pod) as srednia_placa
  from pracownicy p
 inner join zespoly z
on p.id_zesp = z.id_zesp
 group by z.nazwa
 order by z.nazwa;

-- Zadanie 11
select z.nazwa,
       count(*),
       case
          when count(*) < 3 then
             'maly'
          when count(*) > 3
             and count(*) < 6 then
             'sredni'
          else
             'duzy'
       end as etykieta
  from pracownicy p
 inner join zespoly z
on p.id_zesp = z.id_zesp
 group by z.nazwa
 order by z.nazwa;