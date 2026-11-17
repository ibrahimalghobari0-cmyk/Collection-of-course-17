

select * from VehicleDetails
where Year between 1950 and 2000;

select count(Vehicle_Display_Name) from VehicleDetails
where Year between 1950 and 2000;

select count(*) as make from VehicleDetails
where Year between 1950 and 2000;

select Makes.Make ,count( Makes.Make ) NumberofVeicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 where(VehicleDetails.Year between 1950 and 2000)
 group by  Makes.Make
 order by NumberofVeicles desc;

 
 
 select Makes.Make ,count( * ) NumberofVeicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 where(VehicleDetails.Year between 1950 and 2000)
 group by  Makes.Make
 order by NumberofVeicles desc;


 
select  top 3 Makes.Make ,count( Makes.Make) NumberofVeicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 where(VehicleDetails.Year between 1950 and 2000 ) 
 group by  Makes.Make
 having (count(Makes.Make)>12000)
 order by NumberofVeicles desc;


 select * from (
 select  Makes.Make ,count( Makes.Make) NumberofVeicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 where(VehicleDetails.Year between 1950 and 2000 ) 
 group by  Makes.Make

 )R1
 where NumberofVeicles>12000;


 
 --using the cast to convert into float
 --problem7
 --to use a subname that we create inside the select we must put that whole query inside another one to be subquery so the rule you can't use the name inside tha main query
select * ,cast(NumberofVeicles as float)/cast(Totalvehicles as float) as perc from( 
 select Makes.Make ,count( * ) NumberofVeicles,(select count(*) from VehicleDetails) as Totalvehicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 where(VehicleDetails.Year between 1950 and 2000)
 group by  Makes.Make
)R1


 order by NumberofVeicles desc;


SELECT Makes.Make, FuelTypes.FuelTypeName ,count(*) as NumberofVehicles
FROM     VehicleDetails INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID INNER JOIN
                  FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID

where(VehicleDetails.Year between 1950 and 2000)

	group by Makes.Make,FuelTypes.FuelTypeName
       order by Makes.Make




--problem9 get all vehicles that runs with GAS
SELECT  VehicleDetails.*,
                 FuelTypes.FuelTypeName
FROM     FuelTypes INNER JOIN
                  VehicleDetails ON FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID 
				
	where(FuelTypes.FuelTypeName=N'GAS');



	--Problem 10 get all makes that runs with GAS
	SELECT  distinct Makes.Make,
                 FuelTypes.FuelTypeName
FROM     VehicleDetails INNER JOIN
                  FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID inner join 
				  Makes on Makes.MakeID=VehicleDetails.MakeID
				  where(FuelTypes.FuelTypeName=N'GAS');

--problem 11 
--Get Total Makes that runs with GAS
select count(*) as TotalMakeRunONGAs 
from(
	SELECT  distinct Makes.Make,
                 FuelTypes.FuelTypeName
FROM     VehicleDetails INNER JOIN
                  FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID inner join 
				  Makes on Makes.MakeID=VehicleDetails.MakeID
				  where(FuelTypes.FuelTypeName=N'GAS'))R1

--problem12
--count vehicles ny make and order them by numberfovehicles
select Makes.Make ,count( Makes.Make ) NumberofVehicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 group by  Makes.Make
 having (count(*)>20000)

 order by NumberofVehicles desc;




 --problem13
 --GET all Makes/Count of vehicles that Mantufacttures more than 20K vehicles
select Makes.Make ,count( Makes.Make ) NumberofVehicles
from VehicleDetails inner join Makes
 on VehicleDetails.MakeID=Makes.MakeID
 group by  Makes.Make
  having (Count(*)>20000)

 order by NumberofVehicles desc;


  --problem14
  --get all makes with make starts with B
  select Makes.Make
  from Makes 
  WHERE Makes.Make like'B%';



  
  --problem15
  --get all makes with make ends with W
  select Makes.Make
  from Makes 
  WHERE Makes.Make like'%W';


   --problem16
   --get all makes that manufacutres DRIVEtypename=FWD
SELECT distinct Makes.Make, DriveTypes.DriveTypeName
FROM     DriveTypes INNER JOIN
                  VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID

				  where(DriveTypes.DriveTypeName='FWD')

--problem17
   --get Total makes that manufacutres DRIVEtypename=FWD
   select count(*) MakesWithFWS from(
SELECT distinct Makes.Make, DriveTypes.DriveTypeName
FROM     DriveTypes INNER JOIN
                  VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID
	  where(DriveTypes.DriveTypeName='FWD')
				  )R1


--problem18 
--get Total Vehicles per DriveTypeName per Make and order them per maeks asc then per totoal desc 
SELECT  distinct Makes.Make, DriveTypes.DriveTypeName, Count(*)Total
FROM     VehicleDetails INNER JOIN
                  DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID

	group by Makes.Make,DriveTypes.DriveTypeName
	
	order by Makes.Make asc,Total desc;



--problem19
--get Total Vehicles per DriveTypeName per Make and order them per maeks asc then per totoal desc and filter only results with total >10,000
SELECT  distinct Makes.Make, DriveTypes.DriveTypeName, Count(*)Total
FROM     VehicleDetails INNER JOIN
                  DriveTypes ON VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID

	group by Makes.Make,DriveTypes.DriveTypeName
	having Count(*)>10000
	order by Makes.Make asc,Total desc;



--	problem 20
--get all Veicles that number of doors is not specified
select * from VehicleDetails
where NumDoors is null


--	problem 22
--get total Veicles that number of doors is not specified


 select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
where NumDoors is Null;



--	problem 23
--get percentage fo vehicles that has no doors specified
select (

   cast(
   ( select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
where NumDoors is Null ) as float)
/
cast( (select count( *) from VehicleDetails) as float)
)
as PrecofNospecifiedDoors


--problem23
--Get makeid ,make submodelName,for all vehicles that have submodelname 'Elite'
SELECT distinct VehicleDetails.MakeID, Makes.Make, SubModels.SubModelName
FROM     VehicleDetails INNER JOIN
                  SubModels ON VehicleDetails.SubModelID = SubModels.SubModelID INNER JOIN
                  Makes ON VehicleDetails.MakeID = Makes.MakeID

			where(SubModels.SubModelName='Elite')



--problem24
--get all vehicles that have Engines>3 litres and have only 2 doors
	select  * from VehicleDetails
	where Engine_Liter_Display>3 and NumDoors=2;


--problem25
--get make vehicles that engine contains 'OHV' and have cylinder=4
SELECT Makes.Make, VehicleDetails.*
FROM     Makes INNER JOIN
                  VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID

			where (VehicleDetails.Engine_Cylinders=4) and (VehicleDetails.Engine like'%OHV%');





--problem26
--get vehicles that their body is 'sport Utility' and year=2020
SELECT VehicleDetails.*, Bodies.BodyName
FROM     Bodies INNER JOIN
                  VehicleDetails ON Bodies.BodyID = VehicleDetails.BodyID

			where Bodies.BodyName='Sport Utility' and VehicleDetails.Year=2020




--problem27
--get vehicles that their body is coupe or hachback or sedan
SELECT VehicleDetails.*, Bodies.BodyName
FROM     Bodies INNER JOIN
                  VehicleDetails ON Bodies.BodyID = VehicleDetails.BodyID

			where Bodies.BodyName in('Coupe','Hachback','Sedan');





--problem28
--get vehicles that their body is coupe or hachback or sedan and manufactured in year 2008 or 2020 or 2021
SELECT VehicleDetails.*, Bodies.BodyName
FROM     Bodies INNER JOIN
                  VehicleDetails ON Bodies.BodyID = VehicleDetails.BodyID

			where Bodies.BodyName in('Coupe','Hachback','Sedan') and VehicleDetails.Year in(2008,2020,2021);


--problem 29
--return fount=1 if there is any vehicle made in year 1950
select found=1 
where 
exists (

select top 1 * from VehicleDetails where year=1950)


--problem 30
--get all vehicl_display_name,Numdoors and add extra columns to descrive numbe or doors by words and if doo is nul display not set
select  Vehicle_Display_Name ,NumDoors ,ExtraColumns =
case 
  when  NumDoors=0 then 'Zero Doors' 
  when  NumDoors=1 then 'One Door' 
  when  NumDoors=2 then 'Two Doors' 
  when  NumDoors=4 then 'Four Doors'
  when  NumDoors=5 then 'Five Doors'
  when  NumDoors=6 then 'Six Doors'
  when  NumDoors=8 then 'Eight Doors'
  when  NumDoors=3 then 'Three Doors'
  when  NumDoors is null then 'Not Set'
  else 'Unknown'
  end 
  from VehicleDetails;
  

--problem 31
--get all Vehicle_Display_Name ,year and add extra column to calculate the age of the car then sort the results by age desc
 select Vehicle_Display_Name,Year ,Age=Year(GetDAte())-VehicleDetails.Year
 from VehicleDetails
 order  by age desc


 --problem 32
--get all Vehicle_Display_Name ,year and add extra column to calculate the age of the car then sort the results by age desc and their age is between 15 amd 25
 
 select * from(
 select Vehicle_Display_Name,Year ,Age=Year(GetDAte())-VehicleDetails.Year
 from VehicleDetails)R1
 where   Age between 15 and 25


 --problem 33
 --get minimum enginecc and maximum and average 
 select  Minimum=Min(Engine_CC),Maximum=Max(Engine_CC),Average=Avg(Engine_CC)
 from VehicleDetails


 
 --problem 34
 --get all vehicles that have the  minimum enginecc
 select  VehicleDetails.Vehicle_Display_Name
 from VehicleDetails

 where Engine_CC= (
 select 
 Minimum=Min(Engine_CC)
 from VehicleDetails
 )

 
 --problem 35
 --get all vehicles that have the  Maximum enginecc
 select  VehicleDetails.Vehicle_Display_Name,VehicleDetails.Engine_CC
 from VehicleDetails

 where Engine_CC= (
 select 
 Maximum=max(Engine_CC)
 from VehicleDetails
 )


  --problem 36
 --get all vehicles that have Engine_cc below average
 select  VehicleDetails.Vehicle_Display_Name,VehicleDetails.Engine_CC
 from VehicleDetails

 where Engine_CC< (
 select 
 average=avg(Engine_CC)
 from VehicleDetails
 )

 
  --problem 37
 --get all vehicles that have Engine_cc below average

 select Count(*) as numberofVehiclesAboveAverage from(
 select  VehicleDetails.Vehicle_Display_Name,VehicleDetails.Engine_CC
 from VehicleDetails

 where Engine_CC> (
 select 
 Maximum=avg(Engine_CC)
 from VehicleDetails
 ))R1


 --problem38
 --get all unique engine_cc and sort them desc
 select  Distinct Engine_CC from VehicleDetails
 order by Engine_CC desc


 --problem39
 --get all vehicles that has one of the max 3 engine cc
 select VehicleDetails.* from VehicleDetails
 where Engine_CC in(
 select distinct top 3 Engine_CC from VehicleDetails
 order by Engine_CC desc

 )

 --problem 41
 --get all makes that manufactures one of the max 3 engine cc
SELECT  distinct Makes.Make
FROM     Makes INNER JOIN
                  VehicleDetails ON Makes.MakeID = VehicleDetails.MakeID

	 where Engine_CC in(
 select distinct top 3 Engine_CC from VehicleDetails
 order by Engine_CC desc

 )
 order by Make


  --problem 42
 --geta table of unique engine css and calculate tax per engine cc
 select Engine_CC ,Tax=
 case 
 when Engine_CC between 0 and 1000 then 100
 when Engine_CC between 1001 and 2000 then 200
 when Engine_CC between 2001 and 4000 then 300
 when Engine_CC between 4001 and 7000 then 400
 when Engine_CC between 6001 and 8000 then 500
 when Engine_CC >8001 then 600
 else 0
 end
 from (
 select distinct Engine_CC from VehicleDetails)R1
 order by Engine_CC 



 --problem43 
 --get make and total Number of Doors Manufactured per make
SELECT Makes.Make, sum(VehicleDetails.NumDoors) as totalNumberofDoorsManufacturedperMake
FROM     VehicleDetails INNER JOIN
                  Makes ON Makes.MakeID = VehicleDetails.MakeID
	group by Makes.Make
	order by totalNumberofDoorsManufacturedperMake desc



--problem44
 --get make and total Number of Doors Manufactured by 'Ford'
SELECT Makes.Make, sum(VehicleDetails.NumDoors) as totalNumberofDoorsManufacturedperMake
FROM     VehicleDetails INNER JOIN
                  Makes ON Makes.MakeID = VehicleDetails.MakeID
				where Makes.Make='Ford'
	group by Makes.Make
	order by totalNumberofDoorsManufacturedperMake desc


--problem45
--Get Number of models per Make
SELECT Makes.Make,Count(*) as NumberofModerlsperMake

FROM     Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID
group by Makes.Make
order by NumberofModerlsperMake desc


--problem46
--Get the highest 3 manufacturers that make the highest number of models
SELECT top 3 Makes.Make,Count(*) as NumberofModerlsperMake

FROM     Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID
group by Makes.Make
order by NumberofModerlsperMake desc



--problem47
--Get the highest   the highest number of models manufactured
select Max(NumberofModerlsperMake) as highestNumberofModels
from(
SELECT  Makes.Make,Count(*) as NumberofModerlsperMake

FROM     Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID
group by Makes.Make)R1





--problem48
--Get the highest   manufactureers manufactured the highest number of models

SELECT  Makes.Make,Count(*) as NumberofModerlsperMake

FROM     Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID
group by Makes.Make
having count(*)=(
select max(NumberofModels) as maxNumberofModels
from(

select MakeID,count(*) as NumberofModels 
from MakeModels 
group by MakeID)R1)


--problem49
--Get the Lowest   manufactureers manufactured the highest number of models

SELECT  Makes.Make,Count(*) as NumberofModerlsperMake

FROM     Makes INNER JOIN
                  MakeModels ON Makes.MakeID = MakeModels.MakeID
group by Makes.Make
having count(*)=(
select min(NumberofModels) as maxNumberofModels
from(

select MakeID,count(*) as NumberofModels 
from MakeModels 
group by MakeID)R1)



--problem50
--get the fuel types each time the result should be showed in random order
--Nothe that the NewID() function will generate Guid for each row

select * from FuelTypes
order by NewID();