pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--particle sim
--by andrew phifer


function initParticle(x, y, speed, initVx, initVy, mass, pColor) --create a partcle table
    local output = {}
    output[1] = x --x position
    output[2] = y --y position
    output[3] = initVx --initial x velocity
    output[4] = initVy --initial y velocity
    output[5] = speed --speed of the particle
    output[5] = mass --mass of the particle
    output[6] = pColor --particle color
    return output
end


function createForceVector(force, dX, dY, dVar, fVar, maxV) --create a complex force vector
    local output = {}
    output[1] = force --in newtons
    output[2] = dX --x component of the force vector, -1 to 1
    output[3] = dY --y component of the force vector, -1 to 1
    output[4] = dVar --frame to frame variance range of the direction of the vector, from 0 to 1
    output[5] = fVar --frame to frame variance range of the force itself, 0 to 1
    output[6] = maxV --the max speed that the force can accelerate an object to, in meters per second.  useful for simulating stuff like wind
    return output
end


function sumTable(inputTable)
    local output = 0
    
    for x in all(inputTable) do
        output += x
    end

    return output
end


function sliceTable(inputTable, index)
    local output = {}

    for x in all(inputTable) do
        add(output, x[index])
    end

    return output
end


function sumVectors(vectorList)   
    --calculate average of variance figures
    local newDVar = sumTable(sliceTable(vectorList, 4)) / #vectorList
    local newFVar = sumTable(sliceTable(vectorList, 5)) / #vectorList
    --multiply vector directional components by the force / magnitude
    --sum all resultant components
    local sumDX = sumTable(foreach(vectorList, sumX))
    local sumDY = sumTable(foreach(vectorList, sumY))
    local sumMVDX = sumTable(foreach(vectorList, sumMVX))
    local sumMVDY = sumTable(foreach(vectorList, sumMVY))
    --find the magnitude / force of the new vector
    local newForce = sqrt((sumDX ^ 2) + (sumDY ^ 2))
    local newMaxV = sqrt((sumMVDX ^ 2) + (sumMVDY ^ 2))
    --normalize the new vector components 
    local newDX = sumDX / newForce
    local newDY = sumDY / newForce    
    local output = createForceVector(newForce, newDX, newDY, newDVar, newFVar, newMaxV)

    return output
end


function generateEffectiveVectorList(wind, gravity, repulsors, attractors)
    output = {}
    vList = {wind, gravity}
    
    --import repulsors
    for element in all(repulsors) do
        add(output, element)
    end

    --import attractors
    for element in all(repulsors) do
        add(output, element)
    end

    return output
end


function vectorComponentsFromDirection(direction)
    local newX = cos(direction)
    local newY = sin(direction)
    return newX, newY
end


function generateEffectiveForceVector(inputVectorList)
    output = {}
    newVector = sumVectors(inputVectorList)
    --generate brownian vector from new vector
end


function stepParticle(particle, forceVector) --step the particle forwards in time
    --generate brownian vector from wind vector
    local timestep = 0.1
    newVY = particle[4] + (2 * forceVector[3] * timestep)
    newVX = particle[3] + (2 * forceVector[2] * timestep)
    newSpeed = sqrt((newVX ^ 2) + (newVY ^ 2))
    if newSpeed > forceVector
    local newY = particle[2] + (newVY * timestep)    
    local newX = particle[1] + (newVX * timestep)
end


function _init()
    scroll = 0
    sumX = (function(v1) return (v1[1] * v1[2]) end)
    sumY = (function(v1) return (v1[1] * v1[3]) end)
    sumMVX = (function(v1) return (v1[6] * v1[2]) end)
    sumMVY = (function(v1) return (v1[6] * v1[3]) end)
    sumBrownX = (function(v1) return ((1 + rnd(v1[4])) * v1[2]) end)
    sumBrownY = (function(v1) return ((1 + rnd(v1[4])) * v1[3]) end)
    wind = createForceVector(2, 1, 0, 0.2, 0.1, 10)
    gravity = createForceVector(9.81, 0, -1, 0, 0, 99999)
    repulsors = {}
    attractors = {}
    vectorList = generateEffectiveVectorList(wind, gravity, repulsors, attractors)
    particleList = {}
end


function _update()

end


function _draw()
    cls()
    scroll += 1
    scroll = scroll % 8
    camera(scroll, 0)
    map(0, 0, 0, 0, 20, 20)
end

__gfx__
00000000bab009004343444300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333bb3bb6444446400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700333333330344644400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700043433a340044446400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000444434446644434400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700444444440434446400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000644464043446444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000446446406446443400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
