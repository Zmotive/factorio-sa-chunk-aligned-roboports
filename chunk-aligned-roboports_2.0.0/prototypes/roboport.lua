local enableRoboportResize = settings.startup["marximus-chunk-aligned-roboport-enable"].value

local BASE_ROBOPORT_LOGISTIC_RADIUS = 32		-- vanilla default: 25
local BASE_ROBOPORT_CONSTRUCTION_RADIUS = 64    -- vanilla default: 55

local function rescaleRoboportEntity(entity, newLogisticRadius, newConstructionRadius)
  	if enableRoboportResize == true then
        entity.logistics_radius = newLogisticRadius
        entity.construction_radius = newConstructionRadius
	end
end

local function rescaleRoboport(name, newLogisticRadius, newConstructionRadius)
    local entity = data.raw["roboport"][name]
    rescaleRoboportEntity(entity, newLogisticRadius, newConstructionRadius)
end

local function rescaleIfFound(name, newLogisticRadius, newConstructionRadius)
    if data.raw['roboport'][name] then
        rescaleRoboport(name, newLogisticRadius, newConstructionRadius)
    end
end

rescaleIfFound("roboport",      BASE_ROBOPORT_LOGISTIC_RADIUS    ,      BASE_ROBOPORT_CONSTRUCTION_RADIUS)
rescaleIfFound("robotower",     BASE_ROBOPORT_LOGISTIC_RADIUS / 2,      0)

if mods['Krastorio2'] then
    -- default sizes are
    -- small:    18,  34 =>  16,  32
    -- vanilla:  25,  55 =>  32,  64
    -- large:   100, 200 => 128, 256
    local function rescaleKrastorioRoboport(name, newLogisticRadius, newConstructionRadius)
        local entity = data.raw["roboport"][name]
        local oldNormalLogisticRadius = entity.logistics_radius
        local oldNormalConstructionRadius = entity.construction_radius
        rescaleRoboportEntity(entity, newLogisticRadius, newConstructionRadius)
    
        local logisticEntity = data.raw["roboport"][name .. '-logistic-mode']
        local constructionEntity = data.raw["roboport"][name .. '-construction-mode']
        logisticEntity.logistics_radius = logisticEntity.logistics_radius * entity.logistics_radius / oldNormalLogisticRadius
        logisticEntity.construction_radius = logisticEntity.construction_radius * entity.construction_radius / oldNormalConstructionRadius
        constructionEntity.logistics_radius = constructionEntity.logistics_radius * entity.logistics_radius / oldNormalLogisticRadius
        constructionEntity.construction_radius = constructionEntity.construction_radius * entity.construction_radius / oldNormalConstructionRadius
    end
    rescaleKrastorioRoboport('kr-small-roboport',   BASE_ROBOPORT_LOGISTIC_RADIUS / 2,  BASE_ROBOPORT_CONSTRUCTION_RADIUS / 2)
    rescaleKrastorioRoboport('roboport',            BASE_ROBOPORT_LOGISTIC_RADIUS    ,  BASE_ROBOPORT_CONSTRUCTION_RADIUS    )
    rescaleKrastorioRoboport('kr-large-roboport',   BASE_ROBOPORT_LOGISTIC_RADIUS * 4,  BASE_ROBOPORT_CONSTRUCTION_RADIUS * 4)
end

-- DyWorld
-- default sizes are
-- T1:  30,  55 =>  32,  64
-- T2:  70, 110 =>  96, 128
-- T3: 160. 220 => 192, 256
rescaleIfFound("roboport-1",        BASE_ROBOPORT_LOGISTIC_RADIUS    ,      BASE_ROBOPORT_CONSTRUCTION_RADIUS    )
rescaleIfFound("roboport-2",        BASE_ROBOPORT_LOGISTIC_RADIUS * 3,      BASE_ROBOPORT_CONSTRUCTION_RADIUS * 2)
rescaleIfFound("roboport-3",        BASE_ROBOPORT_LOGISTIC_RADIUS * 6,      BASE_ROBOPORT_CONSTRUCTION_RADIUS * 3)

-- Bobs
rescaleIfFound("bob-roboport",      BASE_ROBOPORT_LOGISTIC_RADIUS    ,      BASE_ROBOPORT_CONSTRUCTION_RADIUS    )
rescaleIfFound("bob-roboport-1",    BASE_ROBOPORT_LOGISTIC_RADIUS    ,      BASE_ROBOPORT_CONSTRUCTION_RADIUS    )
rescaleIfFound("bob-roboport-2",    BASE_ROBOPORT_LOGISTIC_RADIUS * 2,      BASE_ROBOPORT_CONSTRUCTION_RADIUS * 2)
rescaleIfFound("bob-roboport-3",    BASE_ROBOPORT_LOGISTIC_RADIUS * 3,      BASE_ROBOPORT_CONSTRUCTION_RADIUS * 3)
rescaleIfFound("bob-roboport-4",    BASE_ROBOPORT_LOGISTIC_RADIUS * 4,      BASE_ROBOPORT_CONSTRUCTION_RADIUS * 4)

rescaleIfFound("bob-logistic-zone-expander",    BASE_ROBOPORT_LOGISTIC_RADIUS / 2,      0)
rescaleIfFound("bob-logistic-zone-expander-2",  BASE_ROBOPORT_LOGISTIC_RADIUS    ,      0)
rescaleIfFound("bob-logistic-zone-expander-3",  BASE_ROBOPORT_LOGISTIC_RADIUS * 3,      0)
rescaleIfFound("bob-logistic-zone-expander-4",  BASE_ROBOPORT_LOGISTIC_RADIUS * 4,      0)
