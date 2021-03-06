require "/scripts/vore/npcvore.lua"

animFlag = false

animTimer = 0
capacity = 4
duration = 120
playerLines = {}

playerLines[1] = {	"...Enjoy a snake's gut...",
					"...You'll feed me for a week...",
					"...Another successful hunt... Now digest...",
					"...Hush... Food must be silent...",
					"...Nutritious..."
}

playerLines[2] = {	"...Enough to last me two weeks...",
					"...Thank the Deity... for these meals...",
					"...The great Quetzalcoatl must be pleased with me...",
					"...First the fur and feathers... then the meat... lastly the bones... such a fine treat..."
}

playerLines[3] = {	"...This will last me... three lovely weeks...",
					"...I must praise the great Quetzalcoatl More...",
					"...So much food... so much... enjoyment...",
					"...'I'm not food' you say?... Hush... don't lie to me... I only eat food..."

}

playerLines[4] = {	"...Praise the great Quetzalcoatl... Praise the snake god...",
					"...may the great Quetzalcoatl feast on your souls...",
					"...This will last me a long month...",
					"...Food for me... do not cry... do not beg... for you are all food... for me..."
}

playerLines["eat"] = {	"...Where food belongs...",
						"...It will be a rough trip...",
						"...Enough waiting... I must eat...",
						"...Your last use...",
						"...Food... as you always have been..."
}

playerLines["exit"] = {	"...The great Quetzalcoatl will not like this...",
						"...You forced yourself out... I must strengthen my grip...",
						"...You won't escape... this is just... temporary...",
						"...Enjoy your freedom while it lasts... my prey..."
}

function dress()
end

function initHook()

	index = npc.getItemSlot("legs").parameters.colorIndex
	
	head = {
		name = "nagahead",
		parameters = {
					colorIndex = index
	}}
	
	chest = {
		name = "nagachest",
		parameters = {
					colorIndex = index
	}}
	
	legs = {
		name = "nagalegs",
		parameters = {
					colorIndex = index
	}}

	headbelly1 = {
		name = "nagaheadbelly1",
		parameters = {
					colorIndex = index
	}}
	headbelly2 = {
		name = "nagaheadbelly2",
		parameters = {
					colorIndex = index
	}}
	headbelly3 = {
		name = "nagaheadbelly3",
		parameters = {
					colorIndex = index
	}}
	
	chestbelly1 = {
		name = "nagachestbelly1",
		parameters = {
					colorIndex = index
	}}
	chestbelly2 = {
		name = "nagachestbelly2",
		parameters = {
					colorIndex = index
	}}
	chestbelly3 = {
		name = "nagachestbelly3",
		parameters = {
					colorIndex = index
	}}
	chestbelly4 = {
		name = "nagachestbelly4",
		parameters = {
					colorIndex = index
	}}
	
	legsbelly1 = {
		name = "nagalegsbelly1",
		parameters = {
					colorIndex = index
	}}
	legsbelly2 = {
		name = "nagalegsbelly2",
		parameters = {
					colorIndex = index
	}}
	legsbelly3 = {
		name = "nagalegsbelly3",
		parameters = {
					colorIndex = index
	}}
	legsbelly4 = {
		name = "nagalegsbelly4",
		parameters = {
					colorIndex = index
	}}
end

function digestHook()
	sayLine( playerLines["exit"] )
	if #victim == 4 then
		npc.setItemSlot( "legs", legsbelly3 )
	elseif #victim == 3 then
		npc.setItemSlot( "legs", legsbelly2 )
	elseif #victim == 2 then
		npc.setItemSlot( "legs", legsbelly1 )
	else
		npc.setItemSlot( "legs", legs )
	end
end

function releaseHook(input, time)
	sayLine( playerLines["exit"] )
	if #victim == 4 then
		npc.setItemSlot( "legs", legsbelly3 )
	elseif #victim == 3 then
		npc.setItemSlot( "legs", legsbelly2 )
	elseif #victim == 2 then
		npc.setItemSlot( "legs", legsbelly1 )
	else
		npc.setItemSlot( "legs", legs )
	end
end

function feedHook()
	sayLine( playerLines["eat"] )
	if animFlag == true then
		animTimer = 0
	else
		animFlag = true
	end
	world.spawnProjectile( "npcanimchomp" , world.entityPosition( tempTarget ), entity.id(), {0, 0}, false)
	world.spawnProjectile( "swallowprojectile" , world.entityPosition( tempTarget ), entity.id(), {0, 0}, false)
end

function requestHook(input)
	sayLine( playerLines["eat"] )
	if animFlag == true then
		animTimer = 0
	else
		animFlag = true
	end
	world.spawnProjectile( "npcanimchomp" , world.entityPosition( victim[#victim] ), entity.id(), {0, 0}, false)
	world.spawnProjectile( "swallowprojectile" , world.entityPosition( victim[#victim] ), entity.id(), {0, 0}, false)
end

function updateHook(dt)

	if animFlag then
		if animTimer < 0.5 then
			npc.setItemSlot( "head", headbelly1 )
		elseif animTimer < 1.0 then
			npc.setItemSlot( "head", headbelly2 )
		elseif animTimer < 1.5 then
			npc.setItemSlot( "head", headbelly3 )
		elseif animTimer < 2.0 then
			npc.setItemSlot( "head", head )
			npc.setItemSlot( "chest", chestbelly1 )
		elseif animTimer < 4.0 then
			npc.setItemSlot( "chest", chestbelly2 )
		elseif animTimer < 6.0 then
			npc.setItemSlot( "chest", chestbelly3 )
		elseif animTimer < 8.0 then
			npc.setItemSlot( "chest", chestbelly4 )
		else
			npc.setItemSlot( "chest", chest )
			if #victim == 4 then
				npc.setItemSlot( "legs", legsbelly4 )
			elseif #victim == 3 then
				npc.setItemSlot( "legs", legsbelly3 )
			elseif #victim == 2 then
				npc.setItemSlot( "legs", legsbelly2 )
			elseif #victim == 1 then
				npc.setItemSlot( "legs", legsbelly1 )
			else
				npc.setItemSlot( "legs", legs )
			end
			animFlag = false
			animTimer = 0
		end
		animTimer = animTimer + dt
	end
	
	if math.random(700) == 1 and containsPlayer() then
		sayLine( playerLines[ #victim ] )
	end
end