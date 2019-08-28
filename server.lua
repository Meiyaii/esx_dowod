ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local katb = false
local kata = false
local katc = false
local jestb = 'nil'
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			name = identity['name'],
			job = identity['job'],
			job_grade = identity['job_grade'],
			grade = identity['grade'],
			insuranceDate = identity['insuranceDate'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
            phone_number = identity['phone_number'],
			grade_label = identity['grade_label'],
			label = identity['label'],
			grade_salary = identity['grade_salary']

		}
	else
		return nil
	end
end
function getlicenseB(source)
	local identifier = GetPlayerIdentifiers(source)[1]

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive'

    })


	if result[1] ~= nil then

katb = true
jestb = '~h~~g~B ~s~'
	else
		jestb = '~h~~r~B ~s~'
	end
end
function getlicenseA(source)
	local identifier = GetPlayerIdentifiers(source)[1]

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive_bike'

    })


	if result[1] ~= nil then

kata = true
jesta = '~h~~g~A ~s~'
	else
				jesta = '~h~~r~A ~s~'
	end
end
function getlicenseC(source)
	local identifier = GetPlayerIdentifiers(source)[1]

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'drive_truck'

    })


	if result[1] ~= nil then

katc = true
jestc = '~h~~g~C~n~ ~s~'
	else
				jestc = '~h~~r~C ~n~~s~'
	end
end

function getlicenseW(source)
	local identifier = GetPlayerIdentifiers(source)[1]

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = identifier,
      ['@type'] = 'weapon'

    })


	if result[1] ~= nil then


jestw = '~g~Tak~n~ ~s~'
	else
				jestw = '~r~Nie~n~ ~s~'
	end
end

function getUbezpieczenie(source)
	local xPlayer = ESX.GetPlayerFromId(source)
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
				insuranceDate = result[1].ubezpieczenie
				if insuranceDate > 0 then
					insuranceDate = "Posiada"
				else
					insuranceDate = "Nie Posiada"
				end
				return insuranceDate
end

ESX.RegisterServerCallback('esx_phone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)

RegisterServerEvent('esx_dowod:dajitem')
AddEventHandler('esx_dowod:dajitem', function()
local XPlayer = ESX.GetPlayerFromId(source)

local qtty = XPlayer.getInventoryItem('dowod').count
if qtty > 1 then
	XPlayer.removeInventoryItem('dowod', 1)

elseif qtty < 1 then
	XPlayer.addInventoryItem('dowod', 1)
end
end)
RegisterServerEvent('esx_dowod:dajwiz')
AddEventHandler('esx_dowod:dajwiz', function()
local XPlayer = ESX.GetPlayerFromId(source)

local qtty = XPlayer.getInventoryItem('wizytowka').count
if qtty > 1 then
	XPlayer.removeInventoryItem('wizytowka', 1)

elseif qtty < 1 then
	XPlayer.addInventoryItem('wizytowka', 1)
end
end)
ESX.RegisterUsableItem('wizytowka', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

        local name = getIdentity(source)
		local job = xPlayer.job

	TriggerClientEvent('esx:dowod_wiz', -1,_source,  '~h~'..name.firstname..' '..name.lastname, 'Numer telefonu: ~b~'..name.phone_number..'~w~~n~Praca: ~b~'..job.grade_label..'~n~~w~Pensja: ~b~'..job.grade_salary..'$')

end)

ESX.RegisterUsableItem('dowod', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

          local lickaB = getlicenseB(source)
          local lickaA = getlicenseA(source)
          local lickaC = getlicenseC(source)
          local lickaW = getlicenseW(source)
					local ubezpieczenie = getUbezpieczenie(source)

          local name = getIdentity(source)



	TriggerClientEvent('esx:dowod_pokazdowod', -1,_source,  '~h~'..name.firstname..' '..name.lastname,name.dateofbirth..' '..name.sex,'Ubezpieczenie: '..ubezpieczenie..'~n~Licencja Na Bron: '..jestw.. 'Prawo Jazdy Kat: '..jesta..' '..jestb..' '..jestc)
--TriggerClientEvent('esx:dowod_pokaz', _source)
	--TriggerClientEvent('esx:dowod_pokazdowod', target, '~h~'..name.firstname..' '..name.lastname,name.dateofbirth,'Licencja Na Bron: '..jestw.. 'Prawo Jazdy Kat: '..jesta..' '..jestb..' '..jestc)
end)
