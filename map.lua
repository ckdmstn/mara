-----------------------------------------------------------------------------------------
--
-- map.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- 변수 받기
local score = composer.getVariable("money", money)
local textScore = composer.getVariable("textScore")
print(score)
local currentstage = composer.getVariable("currentstage", currentstage)
local stage

-- 음악

    audio.stop( counterCh ) -- 스테이지 노래 끄기
    map = audio.loadStream( "music/levelup.mp3" ) -- 카운터배경
    mapCh = audio.play( map, { channel=2, loops=0, fadein=4000 } )
    --audio.play( map, { channel=2, loops=0, fadein=4000 } )


-- CUI 요소 선언
local background
local talkBG
local road = {}
local truck = {}
local spot = {}
local kimbap = {}
local btn = {}
local text = {}



function scene:create(event)
    local sceneGroup = self.view

    -- 배경화면
    background = display.newImageRect("img/mapImage.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth/2, display.contentHeight/2
    talkBG = display.newImageRect("img/talk_20.png", 1150, 260)
    talkBG.x, talkBG.y = display.contentWidth/2, 592

    -- 빈 스테이지 표시
    for i = 1, 5, 1 do
        spot[i] = display.newImageRect("img/spot.png", 140, 140)
        spot[i].x, spot[i].y = display.contentWidth/2 - 267 -267.564216 + (267.564216 * (i-1)) , display.contentHeight/2 - 2
    end

    -- 김밥 스탬프
    for i = 1, 5, 1 do
        kimbap[i] = display.newImageRect("img/mapkimbap.png", 130, 130)
        kimbap[i].x, kimbap[i].y = display.contentWidth/2 - 267 -267.564216 + (267.564216 * (i-1)) , display.contentHeight/2 - 2
        kimbap[i].alpha = 0
    end

    -- 트럭
    truck[1] = display.newImageRect("img/maptruck.png", 200, 120)
    truck[1].x, truck[1].y = kimbap[1].x, display.contentHeight/2-80
    truck[1].alpha = 1

    -- 도로
    for i = 1, 4, 1 do
        road[i] = display.newImageRect("img/road.png", 270, 70)
        road[i].x, road[i].y = kimbap[i].x + 135, display.contentHeight/2
        road[i].alpha = 0
    end

    -- 텍스트
    text[1] = display.newText("dd", display.contentWidth/2, 570, "굴림")
    text[1].text = string.format("와! %d원이나 벌었어.\n내 꿈에 더 가까워지고 있군.", score)
    
    text[2] = display.newText("dd", display.contentWidth/2 + 50, 590, "굴림")
    text[2].text = string.format("이런...\n오늘은 조금 목표와 멀어진 기분이야.\n다시 한번 시도해보자", score)

    for i = 1, 2, 1 do 
        text[i]:setFillColor(0)
        text[i].size = 50
        text[i].alpha = 0 
    end


    -- [[ 함수 ]]
    local function moveScene()
        for i = 1, 2, 1 do text[i].alpha = 0 end

        if stage == 1 then
            composer.removeScene("counter")
            composer.gotoScene("counter")
        elseif stage == 2 then
            composer.removeScene("counter2")
            composer.setVariable("score", score)
            composer.gotoScene("counter2")
        elseif stage == 3 then
            composer.removeScene("counter3")
            composer.setVariable("score", score)
            composer.gotoScene("counter3")
        elseif stage == 4 then
            composer.removeScene("counter4")
            composer.setVariable("score", score)
            composer.gotoScene("counter4")
        elseif stage == 5 then
            composer.removeScene("counter5")
            composer.setVariable("score", score)
            composer.gotoScene("counter5")
        elseif stage == 6 then
            composer.setVariable("score", score)
            composer.gotoScene("ending")
        end
    end

    local function inputEvent(event)
        print("버튼 눌림: inputEvent")
        if event.target.name == "C" then
            moveScene()
        end
    end

    local function stageResult()
        print("stageResult 함수 실행")
        if currentstage == 1 then -- 스테이지1: 초등학교
            kimbap[1].alpha = 1
            
            if score > 3300 then -- 스테이지1 성공
                text[1].alpha = 1
                transition.to(road[1], {time = 300, alpha = 1})
                transition.to(kimbap[2], {time = 2500, alpha = 1})
                transition.to(truck[1], {time = 3000, x = kimbap[1].x + 267})
                stage = 2
            else -- 스테이지1 실패
                text[2].alpha = 1
                stage = 1
            end

        elseif currentstage == 2 then -- 스테이지2: 중학교
            truck[1].x = kimbap[2].x
            for i = 1, currentstage, 1 do kimbap[i].alpha = 1 end
            road[1].alpha = 1

            if score > 10000 then -- 스테이지2 성공
                text[1].alpha = 1
                transition.to(road[2], {time = 300, alpha = 1})
                transition.to(kimbap[3], {time = 2500, alpha = 1})
                transition.to(truck[1], {time = 3000, x = kimbap[2].x + 267})
                stage = 3
            else -- 스테이지2 실패
                text[2].alpha = 1
                stage = 2
            end

        elseif currentstage == 3 then -- 스테이지3: 고등학교
            print("스테이지3")
            truck[1].x = kimbap[3].x
            for i = 1, currentstage, 1 do kimbap[i].alpha = 1 end
            for i = 1, currentstage - 1, 1 do road[i].alpha = 1 end
            
            if score > 20000 then -- 스테이지3 성공
                text[1].alpha = 1
                transition.to(road[3], {time = 300, alpha = 1})
                transition.to(kimbap[4], {time = 2500, alpha = 1})
                transition.to(truck[1], {time = 3000, x = kimbap[3].x + 267})
                stage = 4
            else -- 스테이지4 실패
                text[2].alpha = 1
                stage = 3
            end
        
        elseif currentstage == 4 then -- 스테이지4: 대학교
            truck[1].x = kimbap[4].x
            for i = 1, currentstage, 1 do kimbap[i].alpha = 1 end
            for i = 1, currentstage - 1, 1 do road[i].alpha = 1 end
            
            if score > 35000 then -- 스테이지4 성공
                text[1].alpha = 1
                transition.to(road[4], {time = 300, alpha = 1})
                transition.to(kimbap[5], {time = 2500, alpha = 1})
                transition.to(truck[1], {time = 3000, x = kimbap[4].x + 267})
                stage = 5
            else -- 스테이지4 실패
                text[2].alpha = 1
                stage = 4
            end

        elseif currentstage == 5 then -- 스테이지5: 회사
            truck[1].x = kimbap[5].x
            for i = 1, currentstage, 1 do kimbap[i].alpha = 1 end
            for i = 1, currentstage - 1, 1 do road[i].alpha = 1 end

            if score > 53000 then -- 스테이지5 성공
                text[1].alpha = 1
                stage = 6
                timer.performWithDelay(1000, moveScene)
            else
                text[2].alpha = 1
                stage = 5
            end
        end
    end


    -- [[ 버튼 ]]
    btn[1] = widget.newButton({ 
        defaultFile = "img/continuing.png", overFile = "img/continuing.png", 
        width = 150, height = 100, onPress = inputEvent 
    })
    btn[1].x, btn[1].y =  display.contentWidth-150, 120
    btn[1].name = "C"

    
    -- [[ 초기화 ]]
    stageResult()


    -- [[ 장면 삽입 ]]
    sceneGroup:insert(background)
    sceneGroup:insert(talkBG)
    for i = 1, 4, 1 do sceneGroup:insert(road[i]) end
    for i = 1, 5, 1 do sceneGroup:insert(spot[i]) end
    for i = 1, 5, 1 do sceneGroup:insert(kimbap[i]) end
    sceneGroup:insert(truck[1])
    sceneGroup:insert(btn[1])
    for i = 1, 2, 1 do sceneGroup:insert(text[i]) end

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        -- e.g. start timers, begin animation, play audio, etc.
    end   
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        composer.removeScene("map")
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene