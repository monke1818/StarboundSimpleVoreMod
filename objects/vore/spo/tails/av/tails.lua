animState = "blank"

--entity.setAnimationState("bodyState", "fed4")
--entity.playSound("digest")

bellySounds = {	"belly1",
				"belly2",
				"belly3"

				}
eatenLines = {	"Nnnnhh.. Up you goooo..~",
				"*shlorp.. squelch...* Ahhhhh... Deeper, please..",
				"*lean* Let's get you 'tucked in' shall we? *sits, shlucks* Mmmhh..~"
}

idleLines = {	"Thank god, you guys get Wi-fi out here.",
				"So...any coffee shops around?",
				"I bet you're wondering how I got roped into this...So am I.",
				"So uh...wanna get in my belly?",
				"Hey could I borrow your soul for like a day or so? No reason."
}

bellyLines = {	"*Clenches warmly* Mrrrr.. Hope my foxy rear's comfy for you.~",
				"Hyuu.. This feels so wonderful.. Thanks for sliding in!",
				"Ooooh.. Wiggle for me a bit if you would, I like the tingly sensation..",
				"*Moans as his rump muscles quiver and ripple, massaging*",
				"Welcome to the Fox Den",
				"Mmmmh.. hehehee~ Enjoy your stay at 'hotel de foxbutt'.~",
				"I could show you a real fox-hole",
				"If you want, I can show you my 'fox den' *Wink*",
				"how about a look at my Tail-pipe"
}

function update(dt)
		
	animState = entity.animationState("bodyState")
		
	if world.loungeableOccupied(entity.id()) then
	
		if animState == "idle" then
			entity.setAnimationState("bodyState", "swallow")
			entity.say( eatenLines[ math.random( #eatenLines ) ] )
			entity.playSound("swallow")
		end
		
		if math.random(700) == 1 then
			entity.say( bellyLines[ math.random( #bellyLines ) ] )
			entity.playSound( bellySounds[ math.random( #bellySounds ) ] )
		end
		
	else
		
		if animState == "full"  then
			entity.setAnimationState("bodyState", "idle")
		end
		
		if math.random(700) == 1 then
			local people = world.entityQuery( entity.position(), 7, {
				withoutEntityId = entity.id(),
				includedTypes = {"player"},
				boundMode = "CollisionArea"
			})
			if #people > 0 then
				entity.say( idleLines[ math.random( #idleLines ) ] )
			end
		end
	end
end