--editor things
import "CoreLibs/graphics"
import "CoreLibs/sprites"
local gfx = playdate.graphics
local pd = playdate

-- General
local gameState = "aim"
local ballSpawned = false

-- ball output stuff
local outputDist = 30
local outputX = 200 + outputDist
local outputY = 0
local outputYoffset = -30
local outputXoffset = 0
local gravity = 9.8
function playdate.update()
    gfx.clear()
    gfx.drawCircleAtPoint(200,30,20)



    local quadCount = 1
    local quadx = 200
    local quady = 30

    -- to add a circle where the ball will come from, based on the crank position, and a distance from a centre point

    local centerX = 200
    local centerY = 30
    if (pd.getCrankPosition()) >= 80 and pd.getCrankPosition() <= 280 then
        outputYoffset = -(outputDist*math.sin(math.rad(90 - pd.getCrankPosition())))
        outputXoffset = (outputDist*math.cos(math.rad(90 - pd.getCrankPosition())))
        outputY = centerY+outputYoffset
        outputX = centerX+outputXoffset
    else
        outputYoffset = -(outputDist*math.sin(math.rad(90 - 280)))
        outputY = centerY+outputYoffset
        if (pd.getCrankPosition()) >= 280 then
            outputXoffset = (outputDist*math.cos(math.rad(90 - 280)))
            outputX = centerX+outputXoffset
        else
            outputXoffset = (outputDist*math.cos(math.rad(90 - 80)))
            outputX = centerX+outputXoffset
        end
        local outputImagYoffset = -(outputDist*math.sin(math.rad(90 - pd.getCrankPosition())))
        local outputImagXoffset = (outputDist*math.cos(math.rad(90 - pd.getCrankPosition())))
        local outputImagY = centerY+outputImagYoffset
        local outputImagX = centerX+outputImagXoffset
        gfx.drawCircleAtPoint(outputImagX, outputImagY, 5)
    end
    gfx.fillCircleAtPoint(outputX, outputY, 5)

    local segments = 0
    while segments < 50 do
        gfx.drawLine(outputX,outputY, outputX+outputXoffset/2, outputY+outputYoffset/2)
        outputX += outputXoffset/2
        outputY += outputYoffset/2
        outputYoffset += gravity/2
        segments += 1
    end

    if playdate.buttonIsPressed(pd.kButtonB) and gameState == "aim" then
        gameState = "shoot"
        ballSpawned = true
    end
end
