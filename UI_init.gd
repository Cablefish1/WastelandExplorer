extends Control

###player vars
var wasteland_ticks : int = 0
var distance_from_safehouse : int = 0

var debug = true

@onready var dicebag = Dicebag.new()
@onready var storyteller = $Storyteller
@onready var exploration_tick_timer = $ExplorationTickTimer
@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/Label
@onready var distance_label = $DistanceLabel
@onready var rest_button = $RestButton

#DATA NODES
@onready var world_mechanics = $WorldMechanics
@onready var player = $PlayerDataObject




# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_health_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	pass


func _on_explore_wasteland_button_pressed():
	storyteller.tell_player("You departed for the wasteland")
	exploration_tick_timer.start()
	rest_button.hide()
	$return_from_wasteland.show()
	
	


func _on_return_from_wasteland_pressed():
	storyteller.newline()
	storyteller.add_text("Following paths you remember to be safe you returned from the wasteland.")
	exploration_tick_timer.stop()
	rest_button.show()
	$return_from_wasteland.hide()
	
	

func _on_rest_button_pressed():
	storyteller.tell_player("You rest for a while regaining all your lost health.")
	player.health = player.max_health
	update_health_bar()

	


func _on_exploration_tick_timer_timeout():
	distance_from_safehouse += 10
	check_if_won()
	update_distance_label()
	if distance_from_safehouse % 60 == 0:
		storyteller.tell_player("[color=yellow]Something hazardous happened in the wasteland.[/color]")
		world_mechanics.resolve_hazard()
		if check_if_dead() == true:
			game_over()
		
	else:
		storyteller.newline()
		storyteller.add_text("Generic wasteland stuff: Like you walk and sweat a lot.")
	

	
func update_health_bar():
	health_bar.max_value = player.max_health
	health_bar.set_value(player.health)
	health_label.set_text("Health \n"+str(player.health)+"/"+str(player.max_health))
	


func resolve_hazard():
	
	
	
	''' OLD RESOLVE HAZARD
	if dicebag.flip_coin() == true:
		var damage_taken = dicebag.roll_dice(1,10) 
		storyteller.newline()
		storyteller.append_text("[color=red]You stumble and hurt yourself taking "+str(damage_taken)+" damage.[/color]")
		player.health = player.health - damage_taken
		update_health_bar()
		check_if_dead()
	else:
		storyteller.newline()
		storyteller.append_text("[color=green]But you got lucky and avoided it.[/color]")
	
'''

func check_if_dead():
	if player.health <= 0:
		return true
	return false

func game_over():
	storyteller.tell_player("[color=purple]You have died in the wasteland.[/color]")
	storyteller.newline()
	storyteller.add_text("GAME OVER!")
	exploration_tick_timer.stop()
	hide_all_buttons()


func update_distance_label():
	distance_label.set_text("Distance from safehouse:\n"+str(distance_from_safehouse)+" meters")

func check_if_won():
	if distance_from_safehouse >= 1000:
		storyteller.tell_player("[color=blue]You finally find a safer safehouse! Congratulations! You have won the game.[/color]")
		exploration_tick_timer.stop()
		hide_all_buttons()

func hide_all_buttons():
	$explore_wasteland_button.hide()
	$return_from_wasteland.hide()
	$RestButton.hide()

