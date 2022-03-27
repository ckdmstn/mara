-----------------------------------------------------------------------------------------
--
-- cook5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 음악
local calcIGMusic = audio.loadStream( "music/calcIG.wav" )
local delAllMusic = audio.loadStream( "music/trashcan.wav" )
local makeKimbapMusic = audio.loadStream( "music/makeKimbap.mp3" )

-- GUI
local background -- 주방화면
local leftUI = {} -- 1: 금액표시창, 2:금액표시
local rightUI = {} -- 1:화면전환
local gameUI = {} -- 1:김밥말기, 2:버리기, 3:김밥을 쌀 수 없습니다.
local IG = {} -- 밥, 김, 달걀, 단무지, 햄
local usedIG = {} -- 밥, 김, 달걀, 단무지, 햄
local kimbap = {} -- 1:꼬마김밥, 2:다른김밥



function scene:create( event )
	local sceneGroup = self.view
    
    background = display.newImageRect("img/kitchen5.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth/2, display.contentHeight/2

    rightUI[1] = display.newImageRect("img/back_arrow.png", 70, 70)
    rightUI[1].x, rightUI[1].y = display.contentWidth - 190, 50
    
    leftUI[1] = display.newImageRect("img/money.png", 350, 60)
	leftUI[1].x, leftUI[1].y = 200, 100
	leftUI[2] = display.newText("0원", 180, 107, "굴림")
	leftUI[2].text = string.format("%d원", money)
	leftUI[2].size = 30
    leftUI[2]:setFillColor(0)
    
    gameUI[1] = display.newImageRect("img/ok.png", 80, 80)
    gameUI[1].x, gameUI[1].y = display.contentWidth/2 + 180, display.contentHeight- 60
    gameUI[2] = display.newImageRect("img/trashcan.png", 80, 80)
    gameUI[2].x, gameUI[2].y = display.contentWidth/2 + 280, display.contentHeight- 60
    gameUI[3] = display.newImageRect("img/warning1.png", 500, 300)
    gameUI[3].x, gameUI[3].y = display.contentWidth/2 + 35, display.contentHeight/2 + 40
    gameUI[3].alpha = 0

    -- 진열된 재료
    IG[1] = display.newImageRect("img/rice1.png", 260, 85)
    IG[1].x, IG[1].y = 805, 40
    IG[1].name = 1
    IG[2] = display.newImageRect("img/seaweed1.png", 260, 95)
    IG[3] = display.newImageRect("img/pickledradish1.png", 260, 95)
    IG[4] = display.newImageRect("img/egg1.png", 260, 95)
    IG[5] = display.newImageRect("img/ham1.png", 260, 95)
    IG[6] = display.newImageRect("img/kimchi.png", 260, 95)
    IG[7] = display.newImageRect("img/tuna.png", 260, 95)
    IG[8] = display.newImageRect("img/shrimp.png", 260, 95)
    IG[9] = display.newImageRect("img/bulgogi.png", 260, 95)
    for i = 2, 5, 1 do
        IG[i].x, IG[i].y = 130, display.contentHeight-45 - (i-2)*145
        IG[i].name = i
    end
    for i = 6, 9, 1 do
        IG[i].x, IG[i].y = 1150, display.contentHeight-45 - (i-6)*150
        IG[i].name = i
    end
    
    -- 사용 재료
    usedIG[1] = display.newImageRect("img/rice2.png", 455, 350)
    usedIG[1].x, usedIG[1].y = display.contentWidth/2 + 35, display.contentHeight/2 + 40
    usedIG[2] = display.newImageRect("img/seaweed.png", 530, 400)
    usedIG[2].x, usedIG[2].y = display.contentWidth/2 + 35, display.contentHeight/2 + 40
    usedIG[3] = display.newImageRect("img/pickledradish2.png", 450, 40)
    usedIG[4] = display.newImageRect("img/egg2.png", 430, 30)
    usedIG[5] = display.newImageRect("img/ham2.png", 430, 30)
    usedIG[6] = display.newImageRect("img/kimchi2.png", 430, 50)
    usedIG[7] = display.newImageRect("img/tuna2.png", 430, 50)
    usedIG[8] = display.newImageRect("img/shrimp2.png", 430, 50)
    usedIG[9] = display.newImageRect("img/bulgogi2.png", 430, 50)
    for i = 3, 9, 1 do usedIG[i].x, usedIG[i].y = display.contentWidth/2 + 35, 550 - 20 * (i - 1) end -- 재료 위치
    for i = 1, 9, 1 do usedIG[i].alpha = 0 end -- 숨김처리

    -- 완성된 김밥
    kimbap[1] = display.newImageRect("img/kimbap1.png", 500, 150)
    kimbap[2] = display.newImageRect("img/kimbap2.png", 500, 150)
    kimbap[3] = display.newImageRect("img/kimbap3.png", 500, 150)
    kimbap[4] = display.newImageRect("img/kimbap4.png", 500, 150)
    kimbap[5] = display.newImageRect("img/kimbap5.png", 500, 150)
    for i = 1, 5, 1 do
        kimbap[i].x, kimbap[i].y = display.contentWidth/2 + 35, display.contentHeight/2 + 40
        kimbap[i].alpha = 0
        kimbap[i].name = i
    end
    
    
    
    -- [[함수]]
    local function playCalcIGMusic()
        local calcIGMusicChannel = audio.play( calcIGMusic, { channel=4, loops=0} )    
    end

    local function playDelAllMusic()
        local delAllMusicChannel = audio.play(delAllMusic, {channel = 4, loops=0})
    end

    local function playMakeKimbapMusic()
        local makeKimbapMusicChannel = audio.play(makeKimbapMusic, {channel = 4, loops = 0})
    end

    local function toCounter() -- 카운터화면으로 이동
        composer.gotoScene("counter5")
    end
    
    local function putIG(event) -- 재료 쓰기
        usedIG[event.target.name].alpha = 1
    end

    function calcCounter()
        leftUI[2].text = string.format("%d원", money)
    end

    function calcIG() -- 재료 계산
        playCalcIGMusic()
        money = money - 80
        leftUI[2].text = string.format("%d원", money)
        calcCook() -- cook에서 계산하는 것들이 counter에서도 적용이 되게
    end
    
    local function delAll() -- 조리대 위 음식 모두 삭제
        playDelAllMusic()

        gameUI[3].alpha = 0
        for i = 1, 5, 1 do kimbap[i].alpha = 0 end
        for i = 1, 9, 1 do usedIG[i].alpha = 0 end
        for i = 1, 9, 1 do 
            IG[i]:addEventListener("tap", putIG) 
            IG[i]:addEventListener("tap", calcIG) 
        end
    end
    

    local function makeKimbap()
        playMakeKimbapMusic()

        for i = 1, 9, 1 do -- 일단 김밥을 말면 재료를 놓지도, 재료소진으로 인한 가격소진도 없음
            IG[i]:removeEventListener("tap", putIG) 
            IG[i]:removeEventListener("tap", calcIG)
        end 

        -- 꼬마김밥: 김, 밥, 달걀, 단무지, 햄
        if (usedIG[1].alpha == 1 and usedIG[2].alpha == 1 and usedIG[3].alpha == 1 and usedIG[4].alpha == 1 and usedIG[5].alpha == 1 and usedIG[6].alpha == 0 and usedIG[7].alpha == 0 and usedIG[8].alpha == 0 and usedIG[9].alpha == 0) then
            for i = 1, 8, 1 do usedIG[i].alpha = 0 end
            kimbap[1].alpha = 1
            kimbap[1]:addEventListener("tap", putKimbap)
            kimbap[1]:addEventListener("tap", toCounter)
            kimbap[1]:addEventListener("tap", delAll)
        elseif (usedIG[1].alpha == 1 and usedIG[2].alpha == 1 and usedIG[3].alpha == 1 and usedIG[4].alpha == 1 and usedIG[5].alpha == 1 and usedIG[6].alpha == 1 and usedIG[7].alpha == 0 and usedIG[8].alpha == 0 and usedIG[9].alpha == 0) then
            for i = 1, 8, 1 do usedIG[i].alpha = 0 end
            kimbap[2].alpha = 1
            kimbap[2]:addEventListener("tap", putKimbap)
            kimbap[2]:addEventListener("tap", toCounter)
            kimbap[2]:addEventListener("tap", delAll)
        elseif (usedIG[1].alpha == 1 and usedIG[2].alpha == 1 and usedIG[3].alpha == 1 and usedIG[4].alpha == 1 and usedIG[5].alpha == 1 and usedIG[6].alpha == 0 and usedIG[7].alpha == 1 and usedIG[8].alpha == 0 and usedIG[9].alpha == 0) then
            for i = 1, 8, 1 do usedIG[i].alpha = 0 end
            kimbap[3].alpha = 1
            kimbap[3]:addEventListener("tap", putKimbap)
            kimbap[3]:addEventListener("tap", toCounter)
            kimbap[3]:addEventListener("tap", delAll)
        elseif (usedIG[1].alpha == 1 and usedIG[2].alpha == 1 and usedIG[3].alpha == 1 and usedIG[4].alpha == 1 and usedIG[5].alpha == 1 and usedIG[6].alpha == 0 and usedIG[7].alpha == 0 and usedIG[8].alpha == 1 and usedIG[9].alpha == 0) then
            for i = 1, 8, 1 do usedIG[i].alpha = 0 end
            kimbap[4].alpha = 1
            kimbap[4]:addEventListener("tap", putKimbap)
            kimbap[4]:addEventListener("tap", toCounter)
            kimbap[4]:addEventListener("tap", delAll)
        elseif (usedIG[1].alpha == 1 and usedIG[2].alpha == 1 and usedIG[3].alpha == 1 and usedIG[4].alpha == 1 and usedIG[5].alpha == 1 and usedIG[6].alpha == 0 and usedIG[7].alpha == 0 and usedIG[8].alpha == 0 and usedIG[9].alpha == 1) then
            for i = 1, 9, 1 do usedIG[i].alpha = 0 end
            kimbap[5].alpha = 1
            kimbap[5]:addEventListener("tap", putKimbap)
            kimbap[5]:addEventListener("tap", toCounter)
            kimbap[5]:addEventListener("tap", delAll)
        else
            for i = 1, 9, 1 do usedIG[i].alpha = 0 end
            gameUI[3].alpha = 1
        end 
    end


    -- 이벤트 등록
    rightUI[1]:addEventListener("tap", toCounter)
    for i = 1, 9, 1 do IG[i]:addEventListener("tap", putIG) end
    for i = 1, 9, 1 do IG[i]:addEventListener("tap", calcIG) end
    gameUI[1]:addEventListener("tap", makeKimbap)
    gameUI[2]:addEventListener("tap", delAll)


    -- 장면 삽입
    sceneGroup:insert(background)
    sceneGroup:insert(rightUI[1])
    for i = 1, 2, 1 do sceneGroup:insert(leftUI[i]) end
    for i = 1, 9, 1 do sceneGroup:insert(IG[i]) end
    sceneGroup:insert(usedIG[2])
    sceneGroup:insert(usedIG[1])
    for i = 3, 9, 1 do sceneGroup:insert(usedIG[i]) end
    for i = 1, 3, 1 do sceneGroup:insert(gameUI[i]) end
    for i = 1, 5, 1 do sceneGroup:insert(kimbap[i]) end
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
		composer.removeScene("cook5")
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