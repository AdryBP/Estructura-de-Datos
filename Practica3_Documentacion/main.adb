-- Práctica 3 - Estructura de Datos - 2020/2021.
-- Autores: Adrián Bennasar Polzin y Álvaro Bueno López.

with destacion;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Main is

   package estacion is new destacion;
   use estacion;

   mi_estacion: cTrenes;

   codigoTren: tcodigo;

   -- Declaraciones usadas para generar códigos y pesos aleatorios.
   subtype randRange is Integer range 1..9999999;
   subtype randWeightRange is Integer range 100..2000;
   package Rand_Int is new Ada.Numerics.Discrete_Random(randRange);
   package Rand_Weight is new Ada.Numerics.Discrete_Random(randWeightRange);

   gen1: Rand_Int.Generator;
   gen2: Rand_Weight.Generator;
   num: randRange;
   weight: randWeightRange;
   codigoRandom: tcodigo;

   numLocomotoras: Integer;
   numVagones: Integer;
begin

   -----------------------------------------------------------------------------
   --        SECUENCIA DE INSTRUCCIONES QUE NO PROVOCA ERRORES
   -----------------------------------------------------------------------------

   numLocomotoras:= 100;
   numVagones:= 1000;

   -- Preparamos las estructuras de datos que forman la estación.
   vacio(mi_estacion);

   -- Generamos algunas locomotoras para disponer de locomotoras libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   for iteracion in 1..numLocomotoras loop
      Rand_Int.reset(gen1);
      num:= Rand_Int.random(gen1);
      case num is
         when 1..9 => codigoRandom:= tcodigo("L000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 10..99 => codigoRandom:= tcodigo("L00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 100..999 => codigoRandom:= tcodigo("L0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 1000..9999 => codigoRandom:= tcodigo("L000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 10000..99999 => codigoRandom:= tcodigo("L00" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 100000..999999 => codigoRandom:= tcodigo("L0" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 1000000..9999999 => codigoRandom:= tcodigo("L" & Trim(Integer'Image(num), Ada.Strings.Left));
      end case;
      aparcaLocomotora(mi_estacion, codigoRandom);
   end loop;

   -- Generamos algunos vagones para disponer de vagones libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   for iteracion in 1..numVagones loop
      Rand_Int.reset(gen1);
      num:= Rand_Int.random(gen1);
      case num is
         when 1..9 => codigoRandom:= tcodigo("V000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 10..99 => codigoRandom:= tcodigo("V00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 100..999 => codigoRandom:= tcodigo("V0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 1000..9999 => codigoRandom:= tcodigo("V000" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 10000..99999 => codigoRandom:= tcodigo("V00" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 100000..999999 => codigoRandom:= tcodigo("V0" & Trim(Integer'Image(num), Ada.Strings.Left));
         when 1000000..9999999 => codigoRandom:= tcodigo("V" & Trim(Integer'Image(num), Ada.Strings.Left));
      end case;
      weight:= Rand_Weight.random(gen2);
      aparcaVagon(mi_estacion, codigoRandom, weight);
   end loop;

   -- Creamos algunos trenes.
   creaTren(mi_estacion, codigoTren, 5);
   creaTren(mi_estacion, codigoTren, 4);
   creaTren(mi_estacion, codigoTren, 10);

   Put_Line("---------------------------------------------------------------------");
   Put_Line("                       CONSULTA DE UN TREN                      ");
   Put_Line("---------------------------------------------------------------------");
   New_Line;

   -- Consultamos un tren dado su codigo.
   consultaTren(mi_estacion, codigoTren);

   Put_Line("---------------------------------------------------------------------");
   Put_Line("                      LISTADO DE TRENES CREADOS                      ");
   Put_Line("---------------------------------------------------------------------");
   New_Line;

   -- Listamos todos los trenes creados.
   listarTrenes(mi_estacion);

   Put_Line("---------------------------------------------------------------------");
   Put_Line("                      DESMANTELAMIENTO DE UN TREN                      ");
   Put_Line("---------------------------------------------------------------------");
   New_Line;

   -- Desmantelamos un tren (se desmantelará el de menor peso carga máxima).
   desmantelarTren(mi_estacion);

   -- Se añade un print para poner una linea discontinua entre el primer listado
   -- de trenes y el listado tras el desmantelamiento.
   Put_Line("---------------------------------------------------------------------");
   Put_Line("                       LISTADO TRAS DESMANTELAR                      ");
   Put_Line("---------------------------------------------------------------------");
   New_Line;

   -- Listamos los trenes de nuevo para ver si se ha eliminado el que tenia el
   -- menor peso de carga máxima.
   listarTrenes(mi_estacion);

   -----------------------------------------------------------------------
   -- SECUENCIA DE INSTRUCCIONES QUE PROVOCA EL ERROR locomotoras_agotadas
   -----------------------------------------------------------------------

   --numLocomotoras:= 5;
   --numVagones:= 1000;

   -- Preparamos las estructuras de datos que forman la estación.
   --vacio(mi_estacion);

   -- Generamos algunas locomotoras para disponer de locomotoras libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numLocomotoras loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("L000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("L00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("L0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("L000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("L00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("L0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("L" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --aparcaLocomotora(mi_estacion, codigoRandom);
   --end loop;

   -- Generamos algunos vagones para disponer de vagones libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numVagones loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("V000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("V00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("V0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("V000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("V00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("V0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("V" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --weight:= Rand_Weight.random(gen2);
      --aparcaVagon(mi_estacion, codigoRandom, weight);
   --end loop;

   -- Creamos mas trenes de los que locomotoras libres hay (6 trenes vs 5 locomotoras).
   --creaTren(mi_estacion, codigoTren, 5);
   --creaTren(mi_estacion, codigoTren, 5);
   --creaTren(mi_estacion, codigoTren, 5);
   --creaTren(mi_estacion, codigoTren, 5);
   --creaTren(mi_estacion, codigoTren, 5);
   --creaTren(mi_estacion, codigoTren, 5);

   -------------------------------------------------------------------
   -- SECUENCIA DE INSTRUCCIONES QUE PROVOCA EL ERROR vagones_agotados
   -------------------------------------------------------------------

   --numLocomotoras:= 100;
   --numVagones:= 5;

   -- Preparamos las estructuras de datos que forman la estación.
   --vacio(mi_estacion);

   -- Generamos algunas locomotoras para disponer de locomotoras libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numLocomotoras loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("L000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("L00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("L0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("L000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("L00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("L0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("L" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --aparcaLocomotora(mi_estacion, codigoRandom);
   --end loop;

   -- Generamos algunos vagones para disponer de vagones libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numVagones loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("V000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("V00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("V0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("V000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("V00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("V0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("V" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --weight:= Rand_Weight.random(gen2);
      --aparcaVagon(mi_estacion, codigoRandom, weight);
   --end loop;

   -- Creamos dos trenes usando un total de 7 vagones, mientras que solo hay 5 libres aparcados.
   --creaTren(mi_estacion, codigoTren, 3);
   --creaTren(mi_estacion, codigoTren, 4);

   ------------------------------------------------------------------------------------------
   -- SECUENCIA DE INSTRUCCIONES QUE PROVOCA EL ERROR tren_no_existe al ejecutar consultaTren
   ------------------------------------------------------------------------------------------

   --numLocomotoras:= 100;
   --numVagones:= 1000;

   -- Preparamos las estructuras de datos que forman la estación.
   --vacio(mi_estacion);

   -- Generamos algunas locomotoras para disponer de locomotoras libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numLocomotoras loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("L000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("L00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("L0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("L000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("L00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("L0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("L" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --aparcaLocomotora(mi_estacion, codigoRandom);
   --end loop;

   -- Generamos algunos vagones para disponer de vagones libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numVagones loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("V000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("V00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("V0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("V000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("V00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("V0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("V" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --weight:= Rand_Weight.random(gen2);
      --aparcaVagon(mi_estacion, codigoRandom, weight);
   --end loop;

   -- Se ejecuta desmantelaTren sin haver creado trenes previamente.
   --consultaTren(mi_estacion, "T0000001");

   ---------------------------------------------------------------------------------------------
   -- SECUENCIA DE INSTRUCCIONES QUE PROVOCA EL ERROR tren_no_existe al ejecutar desmantelarTren
   ---------------------------------------------------------------------------------------------

   --numLocomotoras:= 100;
   --numVagones:= 1000;

   -- Preparamos las estructuras de datos que forman la estación.
   --vacio(mi_estacion);

   -- Generamos algunas locomotoras para disponer de locomotoras libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numLocomotoras loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("L000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("L00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("L0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("L000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("L00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("L0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("L" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --aparcaLocomotora(mi_estacion, codigoRandom);
   --end loop;

   -- Generamos algunos vagones para disponer de vagones libres. Cada vez
   -- que se genera una locomotora se le asgigna un código generado aleatoriamente.
   --for iteracion in 1..numVagones loop
      --Rand_Int.reset(gen1);
      --num:= Rand_Int.random(gen1);
      --case num is
         --when 1..9 => codigoRandom:= tcodigo("V000000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10..99 => codigoRandom:= tcodigo("V00000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100..999 => codigoRandom:= tcodigo("V0000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000..9999 => codigoRandom:= tcodigo("V000" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 10000..99999 => codigoRandom:= tcodigo("V00" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 100000..999999 => codigoRandom:= tcodigo("V0" & Trim(Integer'Image(num), Ada.Strings.Left));
         --when 1000000..9999999 => codigoRandom:= tcodigo("V" & Trim(Integer'Image(num), Ada.Strings.Left));
      --end case;
      --weight:= Rand_Weight.random(gen2);
      --aparcaVagon(mi_estacion, codigoRandom, weight);
   --end loop;

   -- Se ejecuta desmantelaTren sin haver creado trenes previamente.
   --desmantelarTren(mi_estacion);

end Main;
