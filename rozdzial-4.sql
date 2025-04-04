-- Zadanie 1
select min(placa_pod) as minimum,
       max(placa_pod) as maksimum,
       max(placa_pod) - min(placa_pod) as roznica
  from pracownicy;

-- Zadanie 2
select etat,
       avg(placa_pod) as srednia
  from pracownicy
 group by etat
 order by srednia desc;

-- Zadanie 3

select count(*) as profesorowie
  from pracownicy
 where etat = 'PROFESOR';

-- Zadanie 4

select id_zesp,
       sum(placa_pod) + sum(placa_dod) as sumaryczne_place
  from pracownicy
 group by id_zesp
 order by id_zesp;

-- Zadanie 5
select max(sum(placa_pod) + sum(placa_dod)) as maks_sum_placa
  from pracownicy
 group by id_zesp;

-- Zadanie 6
select id_szefa,
       min(placa_pod) as minimalna
  from pracownicy
 where id_szefa is not null
 group by id_szefa
 order by minimalna desc;

-- Zadanie 7
select id_zesp,
       count(*) as ilu_pracuje
  from pracownicy
 group by id_zesp
 order by ilu_pracuje desc;

-- Zadanie 8
select id_zesp,
       count(*) as ilu_pracuje
  from pracownicy
 group by id_zesp
having count(*) > 3
 order by ilu_pracuje desc;

-- Zadanie 9
select id_prac,
       count(*)
  from pracownicy
 group by id_prac
having count(*) > 1;

-- Zadanie 10
select etat,
       avg(placa_pod) as srednia,
       count(*) as liczba
  from pracownicy
 where extract(year from zatrudniony) <= 1990
 group by etat;

-- Zadanie 11
select id_zesp,
       etat,
       round(avg(placa_pod + coalesce(
          placa_dod,
          0
       ))) as srednia,
       round(max(placa_pod + coalesce(
          placa_dod,
          0
       ))) as maksymalna
  from pracownicy
 where etat in ( 'ASYSTENT',
                 'PROFESOR' )
 group by id_zesp,
          etat
 order by id_zesp,
          etat;

-- Zadanie 12
select extract(year from zatrudniony) as rok,
       count(*) as ilu_pracownikow
  from pracownicy
 group by extract(year from zatrudniony)
 order by rok;

-- Zadanie 13
select length(nazwisko) as "Ile liter",
       count(*) as "W ilu nazwiskach"
  from pracownicy
 group by length(nazwisko)
 order by "Ile liter";

-- Zadanie 14
select count(*) as "Ile nazwisk z A"
  from pracownicy
 where instr(
   nazwisko,
   'A',
   1,
   1
) + instr(
   nazwisko,
   'a',
   1,
   1
) > 0;

-- Zadanie 15
select count(
   case
      when(instr(
         nazwisko,
         'A',
         1,
         1
      ) + instr(
         nazwisko,
         'a',
         1,
         1
      )) > 0 then
         1
      else
         null
   end
) as "Ile nazwisk z A",
       count(
          case
             when(instr(
                nazwisko,
                'E',
                1,
                1
             ) + instr(
                nazwisko,
                'e',
                1,
                1
             )) > 0 then
                1
             else
                null
          end
       ) as "Ile nazwisk z E"
  from pracownicy;

-- Zadanie 16
select id_zesp as zespol,
       count(
          case
             when(etat = 'PROFESOR') then
                1
             else
                null
          end
       ) as "L_PROFESOROW",
       count(
          case
             when(etat = 'ADIUNKT') then
                1
             else
                null
          end
       ) as "L_ADIUNKTOW",
       count(
          case
             when(etat = 'ASYSTENT') then
                1
             else
                null
          end
       ) as "L_ASYSTENTOW",
       count(
          case
             when(etat not in('PROFESOR',
                              'ADIUNKT',
                              'ASYSTENT')) then
                1
             else
                null
          end
       ) as "L_POZOSTALYCH",
       count(*) as "WSZYSCY"
  from pracownicy
 group by id_zesp
 order by zespol;

-- Zadanie 17
select id_zesp,
       sum(placa_pod) as suma_plac,
       listagg(nazwisko
               || ':'
               || placa_pod,
               ';') within group(
        order by nazwisko) as pracownicy
  from pracownicy
 group by id_zesp
 order by id_zesp;