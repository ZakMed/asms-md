use asms

go
drop proc insertUser
go
create proc insertUser
@name nvarchar(20),
@password nvarchar(20)
as
insert users(name, password) values(@name, @password)
select @@identity


go
drop proc getRolesByUserId
go
create proc getRolesByUserId
@id bigint
as
select r.id, r.name from roles r inner join usersroles ur on r.id = ur.roleId inner join users u on u.id = ur.userId where u.id = @id


go
drop proc getUsersCountByNamePassword
go
create proc getUsersCountByNamePassword
@name nvarchar(20),
@password nvarchar(20)
as
select count(*) from users where name = @name and password = @password

go
drop proc getUsersCountByName
go
create proc getUsersCountByName
@name nvarchar(20)
as
select count(*) from users where name = @name

go
drop proc assignRole
go
create proc assignRole
@userId bigint,
@roleId int
as
insert usersroles values(@userId, @roleId)

go
drop proc getRoles
go
create proc getRoles
as
select id, name from roles

go
drop proc updatePassword
go
create proc updatePassword
@id bigint,
@password nvarchar(20)
as
update users set password = @password where id = @id

go
drop proc clearRoles
go
create proc clearRoles
@id bigint
as
delete from usersroles where userid = @id

go
drop proc getUserByNamePass
go
create proc getUserByNamePass
@name nvarchar(20),
@password nvarchar(20)
as
select * from users where @name = name 
and @password COLLATE Latin1_General_CS_AS = password COLLATE Latin1_General_CS_AS


/************* fieldset *********************/
go
drop proc getFieldsByFieldsetId
go
create proc getFieldsByFieldsetId
@id int
as
select f.* from fields f inner join fieldsetsfields ff on f.id = ff.fieldId
where ff.fieldsetId = @id 

go
drop proc getUnassignedFieldsByFieldsetId
go
create proc getUnassignedFieldsByFieldsetId
@id int
as
select * from fields f
where f.id not in (select ff.fieldId from fieldsetsfields ff where ff.fieldsetId = @id)

go
drop proc assignField
go
create proc assignField
@fieldId int,
@fieldsetId int
as
insert fieldsetsfields values(@fieldsetId, @fieldId)

go
drop proc unassignField
go
create proc unassignField
@fieldId int,
@fieldsetId int
as
delete from fieldsetsfields 
where @fieldId = fieldId and @fieldsetId = fieldsetId

go
drop proc changeFieldsetState
go
create proc changeFieldsetState
@id int,
@stateId int
as
update fieldsets set stateId = @stateId where id = @id

go
drop proc activateFieldset
go
create proc activateFieldset
@id int
as
begin tran
update fieldsets set stateId = 6 where stateId = 5
update fieldsets set stateId = 5 where id = @id
commit

/********************************  measureset  ******************************/
go
drop proc getAssignedMeasures
go
create proc getAssignedMeasures
@measuresetId int
as
select m.* from measures m inner join measuresetsmeasures msm on m.id = msm.measureId
where msm.measuresetId = @measuresetId

go
drop proc getUnassignedMeasures
go
create proc getUnassignedMeasures
@measuresetId int
as
select m.* from measures m
where m.id not in (select msm.measureId from measuresetsmeasures msm where msm.measuresetId = @measuresetId)

go
drop proc assignMeasure
go 
create proc assignMeasure
@measureId int,
@measuresetId int
as
insert measuresetsmeasures values(@measuresetId, @measureId)

go
drop proc unassignMeasure 
go
create proc unassignMeasure 
@measureId int,
@measuresetId int
as
delete from measuresetsmeasures where measureId = @measureId and measuresetId = @measuresetId

go
drop proc changeMeasuresetState
go
create proc changeMeasuresetState
@id int,
@stateId int
as
update measuresets set stateId = @stateId where id = @id

go
drop proc activateMeasureset
go
create proc activateMeasureset
@id int
as
begin tran
update measuresets set stateId = 3 where stateId = 2
update measuresets set stateId = 2 where id = @id
commit

go
drop proc getMeasures
go
create proc getMeasures
as
select m.* from measures m inner join measuresetsmeasures msm on m.id = msm.measureId
inner join measuresets ms on msm.measuresetId = ms.id 
where ms.stateId = 2

/**************************** dossier **************************/

go
drop proc changeDossierState
go
create proc changeDossierState
@id int,
@stateId int
as
update dossiers set stateid = @stateId where id = @id


go
drop proc getRankedDossiers
go
create proc getRankedDossiers
@measuresetId int,
@measureId int,
@month int
as
select sum(cv.value) as value, d.id, d.amountRequested
from dossiers d left join coefficientvalues cv on d.id = cv.dossierId
where
d.measureId = @measureId
and d.measuresetId = @measuresetId
and month(d.dateReg) = @month
and d.stateId = 3
and d.disqualified = 0
group by d.Id, d.amountRequested

go
drop proc getDossiers
go
create proc getDossiers
@measuresetId int,
@measureId int,
@month int,
@stateId int = null
as
select d.* from dossiers d
where 
d.measureId = @measureId
and d.measuresetId = @measuresetId
and MONTH(d.dateReg) >= @month
and (d.stateId = @stateId or @stateId = null)
and d.disqualified = 0

go
drop proc getUsedMeasureIds
go
create proc getUsedMeasureIds
@month DateTime
as
select distinct d.measureId from dossiers d
where YEAR(d.dateReg) = YEAR(@month)
and MONTH(d.dateReg) = MONTH(@month)

go
drop proc getIndicatorValues
go 
create proc getIndicatorValues
@measureId int,
@month DateTime
as
select d.id as dossierId, iv.indicatorId, iv.value from measures m
inner join dossiers d on d.measureId = m.id
inner join indicatorvalues iv on iv.dossierId = d.id
where 
m.id = @measureId
and year(d.dateReg) = year(@month)
and MONTH(d.dateReg) = MONTH(@month)
and d.stateId = 2


go
use master