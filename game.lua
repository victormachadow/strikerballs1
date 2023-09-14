local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight


--vari√°veis globais

local storyboard = require( "storyboard" )
local widget = require( "widget" )
local scene = storyboard.newScene()


local physics = require("physics")
physics.start()
physics.setGravity(0,0)
local textScore
local score = 0
local groupBalls
local balls = {}
local group
local player
local point
local timerCont
local timerLoop
local count
local type
local timeText
local timerRespawn



function spawnBalls()


bolax = math.random( 0 , 200 )
bolay = math.random( 0 , 400 )

--bolax = centerX
--bolay = centerY

 type =  math.random( 0 , 6 )

if ( type == 0 ) then 
ball = display.newImage( "balloon.png", bolax, bolay )
ball.point = math.random( 0 , 5 )
print("b0")
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
  end

if ( type == 1 ) then 
ball = display.newImage( "balloon_yellow.png", bolax ,bolay )
ball.point = math.random( 5 , 10 )
print("b1")
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
 end

if ( type == 2 ) then 
ball = display.newImage( "balloon_green.png", bolax, bolay )
print("b2")
ball.point = math.random( 10 , 15 )
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
 end

if ( type == 3 ) then 
ball = display.newImage( "balloon_orange.png", bolax, bolay )
print("b3")
ball.point = math.random( 20 , 25 )
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
 end

if ( type == 4 ) then 
ball = display.newImage( "balloon_purple.png", bolax , bolay )
print("b4")
ball.point = math.random( 15 , 20 )
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
 end

if ( type == 5 ) then 
ball = display.newImage( "balloon_blood.png", bolax , bolay)
print("b5")
ball.point = math.random( 20 , 25 )
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
end

if ( type == 6 ) then
 ball = display.newImage( "balloon_blood.png", bolax , bolay)
 print("b6")
ball.point = math.random( 20 , 25 )
physics.addBody( ball , "dynamic", { density = 0 , friction = 0.3 , bounce = 0.8 , radius = 12 })
return ball
 end


return ball

end



function scene:createScene( event )
   group = self.view
   groupBalls = display.newGroup()
  
local bkg = display.newImage( "stripes.png", centerX, centerY ) 
 --local barra = display.newImage( "beam_long.png", 0, 0 ) 
 group:insert(bkg)
 
timeText = display.newText( "0", display.contentCenterX + 100, 25, native.systemFontBold, 26 )
timeText:setFillColor( 0 , 0, 0 )
group:insert(timeText) 
  

 
 
 -------------- Floor------------------------------
 local borderBottom = display.newRect( 0, 470, 700, 20 )
borderBottom:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )
group:insert(borderBottom)

 --display.newRect( x, y, width, height ) 
  
local borderTop1 = display.newRect( 0, 0, 300, 20 )
borderTop1:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderTop1, "static", borderBodyElement )
group:insert(borderTop1) 

local borderTop2 = display.newRect( 350 ,0 , 300, 20 )
borderTop2:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderTop2, "static", borderBodyElement )
group:insert(borderTop2) 
 
 
 
 local borderLeft = display.newRect( 0, 20, 20, 900 )
borderLeft:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderLeft, "static", borderBodyElement )
group:insert(borderLeft)

local borderRight = display.newRect( _W , 20, 20, 900 )
borderRight:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderRight, "static", borderBodyElement )
group:insert(borderRight)
 
player = display.newCircle(100,display.contentCenterY+100, 15)
physics.addBody( player , "dynamic", { density = 1.0 , friction = 0.3 , bounce = 0.2 , radius = 12 })
player:setFillColor(  black )
player:addEventListener("touch", playerTouched )
group:insert(player)
 
 
 
 for i = 0, 6 do 
 local circ = spawnBalls()
 groupBalls:insert(circ) -- Display group da cena vai inserindo as bolas criadas
 --balls[i] = circ -- Sao tambem armazenadas num array para manipulacao das mesmas , quando a cena for deletada as bolas tambem ser√£o ;p

end

  
textScore = display.newText( "0", display.contentCenterX - 100, 25, native.systemFontBold, 26 )
textScore:setFillColor( 0 , 0, 0 )
group:insert(textScore)  
  
  
end


------ l√≥gica do jogo -------

 local function respawn()
   
    
    player:setLinearVelocity( 0 , 0 ) 
    player.x= 100
    player.y = display.contentCenterY+100
    
  
    
      
end


local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        --print( "Button was pressed and released" )
        groupBalls:removeSelf()
        storyboard.gotoScene( "menu" )
        storyboard.purgeScene( "game" ) 
       
        
    end
end




function pontua(v)

 
--print(v)
score = score + v
textScore.text = score

end


function getTam() -- Pega numero de bolas em campo

cont = 0
for k,v in pairs( groupBalls ) do
     cont = cont + 1
end

return cont
end



function displayButton()
-- print("botao")
--player:removeEventListener( "touch" ,  playerTouched )
 if ( timerRespawn ~=nil ) then timer.cancel( timerRespawn ) end
  timer.cancel( timerLoop )
  restart = widget.newButton
{
   
    id = "restarrt",
    label = "restart",
    onEvent = handleButtonEvent
}
restart.x = display.contentCenterX
restart.y = display.contentCenterY
group:insert( restart )

end



function update2()

--percorrendo arraygrupo
for i=groupBalls.numChildren,1, -1 do 
    if( groupBalls[i].y < -15 ) then 
    pontua(groupBalls[i].point)
    print(groupBalls[i].point)
    display.remove(groupBalls[i])
    end
end 



 --[[for k, v in ipairs(groupBalls) do
 
if( v.y < -15 ) then  
pontua( v.point )
--table.remove( groupBalls , index )
   
end
end
--]]

if(player.y < -15 ) then 
timerRespawn = timer.performWithDelay(2000, respawn , 1)
end

--print(timeText.text)
--print(getTam())

if ( tonumber( timeText.text ) == 100 ) then displayButton() end

if ( tonumber( timeText.text ) == 10 or tonumber( timeText.text ) == 50 or tonumber( timeText.text ) == 70 or tonumber( timeText.text ) == 100 )-- Tempo onde as bolas ser√£o 
then   --print("okks")
if ( groupBalls.numChildren <= 8 )  then -- Checa o limite de bolas no campo
numBalls = math.random(0 , 3) -- Adiciona um numero randomico de bolas

-- Adiciona as bolas em ciclo

for i = 1, numBalls do 
   local circ = spawnBalls()
   --table.insert( balls , circ )
 groupBalls:insert(circ)
 --balls[i] = circ 
end

end

end
--]]

end



---------- Inserindo as bolas-----------------








local function text( event )
		 

	timeText.text = event.count
    --print(event.count)
	
end




function scene:enterScene( event )
  group = self.view
  storyboard.removeScene("menu")
  --print("ok")
  timerCont = timer.performWithDelay( 1000 , text , 100 )
  timerLoop = timer.performWithDelay( 1 , update2 , -1 )

 
   --timerloop = timer.performWithDelay(1, update, -1)-- Aqui checa se a bola j√° saiu.
 

   --code here executes every time the scene is entered regardless
   --of it's creation state.
end







function playerTouched(event)
 if ( event.phase=="began" or event.phase == "moved" ) then
 -- Tentar isso tambem if(event.phase == "began" or event.phase == "moved") then
 display.getCurrentStage():setFocus(player)
 player:setLinearVelocity(0,0)
 
 elseif event.phase == "ended" then
 
 player:applyLinearImpulse(((event.xStart - event.x)/10) , ((event.yStart - event.y)/10 ) , player.x , player.y )
 display.getCurrentStage():setFocus(nil)
 
 end
 
 end








function scene:exitScene( event )
score = 0

storyboard.purgeAll() 
print("opa")
storyboard.removeAll()
   --local group = self.view
 timer.cancel( timerCont )
  
   --balls = nil
 

   --code here executes every time someone leaves the scene
end



function scene:destroyScene( event )
   local group = self.view

   --code here only executes if the scene is being purged or removed
end

function scene:overlayEnded( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayEnded", scene )


return scene


--[[


FunÁ„o respons·vel por fazer o contador zerar sempre
que a contagem atingir certo valor

function text:timer( event )
  
  local count = event.count

  print( "Table listener called " .. count .. " time(s)" )
  self.text = count

  if count >= 20 then
    timer.cancel( event.source ) -- after the 20th iteration, cancel timer
    --text.text = "0"
    --timerID = timer.performWithDelay( timeDelay, text, 50 )
  end
end





]]

