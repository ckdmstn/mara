-----------------------------------------------------------------------------------------
--
-- opening_3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local UI = {}
local tmr = {}

function scene:create( event )
	local sceneGroup = self.view


    UI[0] = {}

    UI[0][1] = display.newImage("img/skip.png")
    UI[0][1].x, UI[0][1].y = 1200, 40

    UI[0][2] = display.newRect(640, 360, 1280, 720)
    UI[0][2]:setFillColor(1)
    UI[0][2].alpha = 0

    local function goGame( event )
        transition.to(UI[0][2], {alpha = 1})
            local function gotoGame( event )
                Runtime:removeEventListener("key", keyEvent)
                composer.removeScene("opening_3")
                composer.gotoScene("counter")
            end
            tmr[0] = timer.performWithDelay(1500, gotoGame, 1)
    end
    UI[0][1]:addEventListener("tap", goGame)

    --=========

    UI[1] = {}

    UI[1][1] = display.newImage("img/opening2_BG.png")
    UI[1][1].x, UI[1][1].y = display.contentWidth/2, display.contentHeight/2


    UI[1][2] = display.newImage("img/opening_kimbap.png")
    UI[1][2].x, UI[1][2].y = 900, 300
    UI[1][2].alpha = 0

    UI[1][3] = display.newImage("img/talk_eat.png")
    UI[1][3].x, UI[1][3].y = display.contentWidth/2, 592
    UI[1][3].alpha = 0

    UI[1][4] = display.newImage("img/talk_o0o.png")
    UI[1][4].x, UI[1][4].y = display.contentWidth/2, 592
    UI[1][4].alpha = 0

    UI[1][5] = display.newImage("img/talk_smile.png")
    UI[1][5].x, UI[1][5].y = display.contentWidth/2, 592
    UI[1][5].alpha = 0

    UI[1][6] = display.newText("(냠냠)", 355, 530)
    UI[1][6]:setFillColor(0)
    UI[1][6].size = 30
    UI[1][6].alpha = 0

    UI[1][7] = display.newText("헉! 뭐야! 너무 맛있잖아!", 535, 530)
    UI[1][7]:setFillColor(0)
    UI[1][7].size = 30
    UI[1][7].alpha = 0

    UI[1][8] = display.newText("애들한테도 달려가서 하나씩 나눠줬다.", 533, 580)
    UI[1][8]:setFillColor(0)
    UI[1][8].size = 30
    UI[1][8].alpha = 0

    UI[1][9] = display.newText("혼자 먹기엔 너무너무 맛있는 김밥이었다.", 550, 630)
    UI[1][9]:setFillColor(0)
    UI[1][9].size = 30
    UI[1][9].alpha = 0

    UI[1][10] = display.newText("애들도 완전 부러워해서 기분이 좋았다!", 538, 680)
    UI[1][10]:setFillColor(0)
    UI[1][10].size = 30
    UI[1][10].alpha = 0

    --=========

    UI[2] = display.newImage("img/talk_next.png")
    UI[2].x, UI[2].y = 1130, 680
    UI[2].alpha = 0

    --=========

    transition.to(UI[1][2], {alpha = 1})

    local function S3_1( event )
        UI[1][3].alpha = 1
        local function S3_1_2( event )
            UI[1][6].alpha = 1
        end
        tmr[2] = timer.performWithDelay(300, S3_1_2, 1)
    end
    tmr[1] = timer.performWithDelay(1000, S3_1, 1)

    local function S3_2( event )
        UI[1][3].alpha = 0
        UI[1][4].alpha = 1
        UI[1][7].alpha = 1
    end
    tmr[3] = timer.performWithDelay(3000, S3_2, 1)

    local function S3_3( event )
        UI[1][4].alpha = 0
        UI[1][5].alpha = 1
        UI[1][8].alpha = 1
    end
    tmr[4] = timer.performWithDelay(4500, S3_3, 1)

    local function S3_4( event )
        UI[1][9].alpha = 1
    end
    tmr[5] = timer.performWithDelay(6000, S3_4, 1)

    local function S3_5( event )
        UI[1][10].alpha = 1
    end
    tmr[6] = timer.performWithDelay(7500, S3_5, 1)

    --=========

    local function nextScene( event )
        UI[2].alpha = 1
        local function keyEvent( event )
            if event.keyName == "space" then
                Runtime:removeEventListener("key", keyEvent)
                composer.removeScene("opening_3")
                composer.gotoScene("opening_4")
            end
        end
        Runtime:addEventListener("key", keyEvent)
    end
    tmr[6] = timer.performWithDelay(9000, nextScene, 1)

    --=========

    for i = 1, 10, 1 do sceneGroup:insert(UI[1][i]) end
    sceneGroup:insert(UI[2])
    for i = 1, 2, 1 do sceneGroup:insert(UI[0][i]) end


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("opening_3")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene