-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local defaultField

-- 음악
audio.stop( mapCh )  -- 맵 노래 끄기
audio.stop( counterCh )  -- 맵 노래 끄기
local ending = audio.loadStream("music/ending.wav")
local endingCh = audio.play(ending, { channel=23, loops=0, fadein=2000 })

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect( "img/ending.png", display.contentWidth, display.contentHeight )
	background.alpha = 1
    background.x = display.contentWidth/2
    background.y = display.contentHeight/2

    local e = display.newImageRect("img/end.png", 436, 160)
    e.x, e.y = 1090, 610

    local truck = display.newImageRect("img/maptruck.png", 427, 251)
    truck.alpha = 1
    truck.x = display.contentWidth/2-300
    truck.y = display.contentHeight/2+200

    --[[local bbong = display.newImageRect("endingImage/bbong.png", 93, 91)
    bbong.alpha = 1
    bbong.x = truck.x-250
    bbong.y = truck.y + 80]]

    local endText = display.newText(" ", display.contentWidth/2, display.contentHeight/2)
    endText.size = 200
    endText:setFillColor(0)

    local contract_BG = display.newImageRect("img/contract_BG.png", display.contentWidth, display.contentHeight)
    contract_BG.x = display.contentWidth/2
    contract_BG.y = display.contentHeight/2
    contract_BG.alpha = 1

    local building = {}
    building[1] = display.newImageRect("img/building1.png", 428- 170, 441-170)
    building[1].name = 1
    building[1].x, building[1].y = display.contentWidth/2 - 420 , display.contentHeight/2 +30
    building[2] = display.newImageRect("img/building2.png", 428- 170, 441-170)
    building[2].x, building[2].y = display.contentWidth/2 - 410 + 400 + 10 , display.contentHeight/2 + 30
    building[2].name = 2
    building[3] = display.newImageRect("img/building3.png", 428- 170, 441-170)
    building[3].x, building[3].y = display.contentWidth/2 - 410 + 400 * 2 + 20, display.contentHeight/2 + 30
    building[3].name = 3

    --간판
    local board = display.newImageRect("img/board.png", 385-100, 231-100)
    board.alpha = 0
    board.x = display.contentWidth/2
    board.y = display.contentHeight/2

    --[[마라
    local mara = display.newImageRect("endingImage/mara.png", 105, 105)
    mara.alpha = 0
    mara.x = display.contentWidth/2
    mara.y = display.contentHeight/2]]

    for i=1, 3, 1 do
        building[i].alpha = 1
    end

    local contract = display.newImageRect("img/contract.png", 271, 204)
    contract.alpha = 0
    contract.x = display.contentWidth/2
    contract.y = display.contentHeight/2



    function contractOne(event)
        -- body
        if event.target == building[1] then--다른거 선택 막음
            targetIndex = 1
            building[2]:removeEventListener("tap", contractOne)
            building[3]:removeEventListener("tap", contractOne)
        end
        if event.target == building[2] then
            targetIndex = 2
            building[1]:removeEventListener("tap", contractOne)
            building[3]:removeEventListener("tap", contractOne)
        end
        if event.target == building[3] then
            targetIndex = 3
            building[1]:removeEventListener("tap", contractOne)
            building[2]:removeEventListener("tap", contractOne)
        end

        contract.x, contract.y = event.target.x, event.target.y
        contract.alpha =1

        defaultField = native.newTextField(display.contentWidth/2, 640, 400, 100)
        defaultField.align = 4
        local index = 1
        index = event.target.name

		local function textListener ( event )
			if event.phase == "submitted" then
				--local text = display.newText(event.target.text, display.contentWidth, display.contentHeight)
				--event.target.text = ""
				display.remove(defaultField)
				contract_BG.alpha = 0
				contract.alpha =0
				local square = display.newRect( display.contentWidth/2, display.contentHeight/2, 
					display.contentWidth, display.contentHeight )
                square:setFillColor(1)
                transition.fadeOut( square, { time=3000 } )
                for i=1, 3, 1 do
                    building[i].alpha = 0
                end
                building[index].x, building[index].y = display.contentWidth - 225, display.contentHeight - 236
            
                building[index].width = 300
                building[index].height = 300
                building[index].alpha =1
                
                board.alpha = 1
                board.width, board.height = 385-100, 231-100
                board.x, board.y = building[index].x, building[index].y-180

                --[[mara.alpha = 1
                mara.x, mara.y = board.x + 120, board.y+20]]

                local Btext = display.newText( event.target.text, board.x-10, board.y-15, "배달의민족 한나체 pro", 60 )
                Btext:setFillColor(0)
                Btext.align =  "center"

                local num = 10
                function scaleUP(event)
                    -- body
                    truck.width, truck.height = truck.width + num, truck.height + num
                    --bbong.width, bbong.height = bbong.width + num, bbong.height + num
                end
                function scaleDW(event)
                    -- body
                    truck.width, truck.height = truck.width - num , truck.height - num
                    --bbong.width, bbong.height = bbong.width - num , bbong.height - num
                end

                timer.performWithDelay( 1000, scaleUP, 4)
                timer.performWithDelay( 1100, scaleDW, 4)

                local function MoveTruck( event )
                    transition.to(truck, {x = 1500})
                end
                timer.performWithDelay(3500, MoveTruck, 1)

                sceneGroup:insert(background)
                sceneGroup:insert(building[index])
                sceneGroup:insert(truck)
			end   	
		end
		defaultField:addEventListener("userInput", textListener)
		building[targetIndex]:removeEventListener("tap", contractOne)--마지막에 빌딩 눌러 도장안찍히도록
		
    end

    building[1]:addEventListener("tap", contractOne)
    building[2]:addEventListener("tap", contractOne)
    building[3]:addEventListener("tap", contractOne)

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
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
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