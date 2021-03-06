display.setStatusBar(display.HiddenStatusBar)

display.setDefault("anchorX", 0)
display.setDefault("anchorY", 0)

local widget = require "widget"

local sndStatus = "stop"
local snd = audio.loadSound("snd.mp3")
local sndChannel = nil

-- 1. 버튼 생성 Begin --
local playBtn = widget.newButton({label="Play", width=60})
playBtn.x, playBtn.y = 40, 100

local stopBtn = widget.newButton({label="Stop", width=60})
stopBtn.x, stopBtn.y = 140, 100
-- 1. 버튼 생성 End --

-- 2. 함수 정의 Begin --
-- 재생
local function play()
	playBtn:setLabel("Pause")

	if sndStatus == "stop" then
		sndChannel = audio.play(snd)
	elseif sndStatus == "pause" then
		audio.resume(sndChannel)
	end
end

-- 일시 정지
local function pause()
	playBtn:setLabel("Play")
	
	sndStatus = "pause"
	audio.pause(sndChannel)
end

-- 중지
local function stop()
	sndStatus = "stop"
	audio.stop()
	
	playBtn:setLabel("Play")
end
-- 2. 함수 정의 End --

-- 3. 버튼 세팅 Begin --
function on_Play(e)
	if playBtn:getLabel() == "Play" then
		play()
	else
		pause()
	end
end
playBtn:addEventListener("tap", on_Play)

function on_Stop(e)
	stop()
end
stopBtn:addEventListener("tap", on_Stop)
-- 3. 버튼 세팅 End --

-- 4. 음량 조절 슬라이더 Begin --
local function sliderListener(e)
    audio.setVolume(e.value * 0.01)
end

local slider = widget.newSlider
{
    top = 150,
    left = 40,
    width = 150,
    value = audio.getVolume() * 100,
    listener = sliderListener
}
-- 4. 음량 조절 슬라이더 End --