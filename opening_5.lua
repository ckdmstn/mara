-----------------------------------------------------------------------------------------
--
-- opening_5.lua
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
                composer.removeScene("opening_5")
                composer.gotoScene("counter")
            end
            tmr[0] = timer.performWithDelay(1500, gotoGame, 1)
    end
    UI[0][1]:addEventListener("tap", goGame)

    --=========

    UI[1] = {}

    UI[1][1] = display.newRect(640, 360, 1280, 720)
    UI[1][1]:setFillColor(1)
    UI[1][1].alpha = 0

    UI[1][2] = display.newImage("img/opening3_BG.png")
    UI[1][2].x, UI[1][2].y = display.contentWidth/2, display.contentHeight/2
    UI[1][2].alpha = 0

    UI[1][3] = display.newImage("img/talk_20.png")
    UI[1][3].x, UI[1][3].y = display.contentWidth/2, 592
    UI[1][3].alpha = 0

    UI[1][4] = display.newText("그때 이후로 그 김밥을 샀던 포장마차를 보지 못했다.", 597, 530)
    UI[1][4]:setFillColor(0)
    UI[1][4].size = 30
    UI[1][4].alpha = 0

    UI[1][5] = display.newText("아직도 김밥을 먹을 때면 그때 먹었던 맛이 떠올라 김밥을 끝까지 먹을 수 없었다.", 752, 580)
    UI[1][5]:setFillColor(0)
    UI[1][5].size = 30
    UI[1][5].alpha = 0

    UI[1][6] = display.newText("그래서 결심했다.", 397, 630)
    UI[1][6]:setFillColor(0)
    UI[1][6].size = 30
    UI[1][6].alpha = 0

    UI[1][7] = display.newText("외로움도 잊게 만들어 줬던 최고의 김밥을 내가 직접 만들기로 말이다!", 692, 680)
    UI[1][7]:setFillColor(0)
    UI[1][7].size = 30
    UI[1][7].alpha = 0

    UI[1][8] = display.newRect(640, 360, 1280, 720)
    UI[1][8]:setFillColor(1)
    UI[1][8].alpha = 0

    --=========

    UI[2] = display.newImage("img/talk_next.png")
    UI[2].x, UI[2].y = 1130, 680
    UI[2].alpha = 0

    --=========

    transition.to(UI[1][1], {alpha = 1})

    local function S5_1( event )
        transition.to(UI[1][2], {alpha = 1})
    end
    tmr[1] = timer.performWithDelay(2000, S5_1, 1)

    local function S5_2( event )
        UI[1][3].alpha = 1
    end
    tmr[2] = timer.performWithDelay(3500, S5_2, 1)

    local function S5_3( event )
        UI[1][4].alpha = 1
    end
    tmr[3] = timer.performWithDelay(4000, S5_3, 1)

    local function S5_4( event )
        UI[1][5].alpha = 1
    end
    tmr[4] = timer.performWithDelay(6000, S5_4, 1)

    local function S5_5( event )
        UI[1][6].alpha = 1
    end
    tmr[5] = timer.performWithDelay(8000, S5_5, 1)

    local function S5_6( event )
        UI[1][7].alpha = 1
    end
    tmr[6] = timer.performWithDelay(9500, S5_6, 1)

    --=========

    local function nextScene( event )
        UI[2].alpha = 1
        local function keyEvent( event )
            if event.keyName == "space" then
                Runtime:removeEventListener("key", keyEvent)
                transition.to(UI[0][2], {alpha = 1})
                local function Game( event )
                    composer.removeScene("opening_5")
                    composer.gotoScene("counter")
                end
                tmr[8] = timer.performWithDelay(1500, Game, 1)
            end
        end
        Runtime:addEventListener("key", keyEvent)
    end
    tmr[7] = timer.performWithDelay(11500, nextScene, 1)

    --=========

    for i = 1, 8, 1 do sceneGroup:insert(UI[1][i]) end
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
		composer.removeScene("opening_5")
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