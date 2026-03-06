local enablePowerpoleResize = settings.startup["marximus-chunk-aligned-powerpole-enable"].value
local enableSubstationResize = settings.startup["marximus-chunk-aligned-substation-enable"].value

local BASE_POWERPOLE_WIRE_REACH = 32       -- vanilla default: 30
local BASE_POWERPOLE_SUPPLY_REACH = 2      -- vanilla default: 2
local BASE_SUBSTATION_WIRE_REACH = 16      -- vanilla default: 18
local BASE_SUBSTATION_SUPPLY_REACH = 8     -- vanilla default: 9

local function rescalePoleEntity(entity, newReach, newSupplyRadius)
    -- enforce maximum to prevent issues
    if newReach > 64 then 
        newReach = 64 
    end
    if enablePowerpoleResize == true then
        entity.maximum_wire_distance = newReach
    end
    if enableSubstationResize == true then
        entity.supply_area_distance = newSupplyRadius
    end
end

local function rescalePole(name, newReach, newSupplyRadius)
    local entity = data.raw['electric-pole'][name]
    rescalePoleEntity(entity, newReach, newSupplyRadius)
end

local function rescaleIfFound(name, newReach, newSupplyRadius)
    if data.raw['electric-pole'][name] then
        rescalePole(name, newReach, newSupplyRadius)
    end
end

-- big pole
rescaleIfFound('big-electric-pole',         BASE_POWERPOLE_WIRE_REACH         ,     BASE_POWERPOLE_SUPPLY_REACH          )
rescaleIfFound('big-electric-pole-2',       BASE_POWERPOLE_WIRE_REACH * 10 / 8,     BASE_POWERPOLE_SUPPLY_REACH          )
rescaleIfFound('big-electric-pole-3',       BASE_POWERPOLE_WIRE_REACH * 12 / 8,     BASE_POWERPOLE_SUPPLY_REACH          )
rescaleIfFound('big-electric-pole-4',       BASE_POWERPOLE_WIRE_REACH * 16 / 8,     BASE_POWERPOLE_SUPPLY_REACH          )

-- Cargoships
rescaleIfFound('floating-electric-pole',    BASE_POWERPOLE_WIRE_REACH          ,    0                                    )

-- substation
rescaleIfFound('substation',                BASE_SUBSTATION_WIRE_REACH         ,    BASE_SUBSTATION_SUPPLY_REACH         )
rescaleIfFound('substation-2',              BASE_SUBSTATION_WIRE_REACH * 10 / 8,    BASE_SUBSTATION_SUPPLY_REACH * 10 / 8)
rescaleIfFound('substation-3',              BASE_SUBSTATION_WIRE_REACH * 12 / 8,    BASE_SUBSTATION_SUPPLY_REACH * 12 / 8)
rescaleIfFound('substation-4',              BASE_SUBSTATION_WIRE_REACH * 16 / 8,    BASE_SUBSTATION_SUPPLY_REACH * 16 / 8)
