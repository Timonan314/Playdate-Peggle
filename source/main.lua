--editor things
import "CoreLibs/graphics"
local gfx = playdate.graphics
local pd = playdate

-- parabola renderer stuff
local quadxstrech = 0

function playdate.update()
    gfx.clear()
    gfx.drawCircleAtPoint(200,30,20)
    local quadCount = 1
    local quadx = 200
    local quady = 30
    gfx.drawText(tostring(quadxstrech),5,5)
    while quadCount < 50 do
        quadxstrech = (pd.getCrankPosition()-180)
        if quadxstrech == 0 then
            gfx.drawLine(quadx,quady,quadx,quady+(240-30))
            quadCount += 1
        elseif quadxstrech > 0 then
            gfx.drawLine(quadx, quady, quadx + quadCount, (quadCount^2)/quadxstrech + quady)
            quadx = quadx + quadCount
            quady = (quadCount^2)/quadxstrech + quady
            quadCount += 1
        elseif quadxstrech < 0 then
            gfx.drawLine(quadx, quady, quadx - quadCount, -((quadCount^2)/quadxstrech) + quady)
            quadx = quadx - quadCount
            quady = -((quadCount^2)/quadxstrech) + quady
            quadCount += 1
        end
    end
end

function pd.rightButtonDown()
    quadxstrech += 1
end


function pd.leftButtonDown()
    quadxstrech -= 1
end