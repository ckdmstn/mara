-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 음악
start = audio.loadStream( "music/forest.mp3" )
startCh = audio.play( start, { channel=10, loops=0} )


function scene:create( event )
	local sceneGroup = self.view
    
	
    local background = display.newImage("img/startBG.png")
    background.x, background.y = display.contentWidth/2, display.contentHeight/2

    local function goNewGame( event )
    	composer.gotoScene("opening_1")
    end

    local start = display.newImage("img/newGame.png")
    start.x, start.y = 1140, 185

    start:addEventListener("tap", goNewGame)


    local function goHelp( event )
    	local helpOver = display.newImageRect("img/help_over.png", display.contentWidth, display.contentHeight)
		helpOver.x, helpOver.y = display.contentWidth/2, display.contentHeight/2
		
		local function closeHelp()
			helpOver.alpha = 0
		end

		helpOver:addEventListener("tap", closeHelp)
    end

    local help = display.newImage("img/help.png")
    help.x, help.y = 1140, 300

    help:addEventListener("tap", goHelp)
    


    sceneGroup:insert( background )
    sceneGroup:insert( start )
    sceneGroup:insert( help )
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
		composer.removeScene("start")
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