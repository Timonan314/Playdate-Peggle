--editor things
import "CoreLibs/graphics"
local gfx = playdate.graphics
local pd = playdate

-- parabola renderer stuff
local quadxstrech = 0

-- ball output stuff
local sourceDist = 30
local sourceX = 200 + sourceDist
local sourceY = 0

function playdate.update()
    gfx.clear()
    gfx.drawCircleAtPoint(200,30,20)



    local quadCount = 1
    local quadx = 200
    local quady = 30

    -- to add a circle where the ball will come from, based on the crank position, and a distance from a centre point

    local centerX = 200
    local centerY = 30

    if (pd.getCrankPosition()) >= 90 and pd.getCrankPosition() <= 270 then
        sourceY = centerY-(sourceDist*math.sin(math.rad(90 - pd.getCrankPosition())))
        sourceX = centerX+(sourceDist*math.cos(math.rad(90 - pd.getCrankPosition())))
        gfx.fillCircleAtPoint(sourceX, sourceY, 5)
    else
        gfx.fillCircleAtPoint(sourceX, centerY, 5)
        local sourceImagY = centerY-(sourceDist*math.sin(math.rad(90 - pd.getCrankPosition())))
        local sourceImagX = centerX+(sourceDist*math.cos(math.rad(90 - pd.getCrankPosition())))
        gfx.drawCircleAtPoint(sourceImagX, sourceImagY, 5)
    end


end

function pd.rightButtonDown()
    quadxstrech += 1
end


function pd.leftButtonDown()
    quadxstrech -= 1
end