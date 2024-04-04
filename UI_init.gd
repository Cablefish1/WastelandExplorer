extends Control

#player vars
var wasteland_ticks : int = 0
@export var distance_from_safehouse : int = 0
var exploration_zone : String = "Suburban Wasteland"

@export var chance_of_hazards : int = 20 #chance of encountering something in the wasteland in percent.

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
func _process(_delta):
	pass



func _on_explore_suburban_wasteland_pressed():
	storyteller.tell_player("You departed for the suburban wasteland")
	exploration_tick_timer.start()
	rest_button.hide()
	$return_from_wasteland.show()
	
	

func _on_explore_city_core_pressed():
	pass # Replace with function body.


func _on_explore_wildlands_pressed():
	pass # Replace with function body.


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
	if check_if_out_of_zone():
		return
	match exploration_zone:
		"Suburban Wasteland":
			if (dicebag.roll_dice(1, 100) <= chance_of_hazards):
				storyteller.tell_player("[color=yellow]Something hazardous happened in the wasteland.[/color]")
				world_mechanics.resolve_hazard()
	

	
	update_distance_label()
	if (dicebag.roll_dice(1, 100) <= chance_of_hazards):
		storyteller.tell_player("[color=yellow]Something hazardous happened in the wasteland.[/color]")
		world_mechanics.resolve_hazard()
		if check_if_dead() == true:
			game_over()
		return
	else:
		storyteller.newline()
		storyteller.add_text("Generic wasteland stuff: Like you walk and sweat a lot.")
	

	
func update_health_bar():
	health_bar.max_value = player.max_health
	health_bar.set_value(player.health)
	health_label.set_text("Health \n"+str(player.health)+"/"+str(player.max_health))
	



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

func check_if_out_of_zone():
	if distance_from_safehouse >= 2000:
		storyteller.tell_player("[color=blue]You reach the end of "+exploration_zone+"[/color]")
		exploration_tick_timer.stop()
		match exploration_zone:
			"Suburban Wasteland":
				storyteller.tell_player("You now have new areas to explore in search of a safe place or you can pick a new direction and keep exploring the "+exploration_zone)
				$explore_city_core.show()
				$explore_wildlands.show()
				distance_from_safehouse = 0
				update_distance_label()
		return true

				
func check_if_won():
	if distance_from_safehouse >= 8000:
		storyteller.tell_player("[color=blue]You finally find a safer safehouse! Congratulations! You have won the game.[/color]")
		exploration_tick_timer.stop()
		hide_all_buttons()

func hide_all_buttons():
	$explore_wasteland_button.hide()
	$return_from_wasteland.hide()
	$RestButton.hide()



''' Nancok's script!
static func get_all_resources_in_folder(folder: String) -> Array[Resource]:
	assert( not folder.ends_with("/") )
	var output: Array[Resource]
	if folder.begins_with("res://") and not OS.has_feature("editor"):
		for file: String in DirAccess.get_files_at(folder):
			var file_name: String = file
			## Only deal with imported resources
			if not file_name.get_extension() == "remap":
				continue
				file_name = file_name.trim_suffix(".remap")
				if not file_name.get_extension() == "tres":
					continue
				var res: Resource = load(folder + "/" + file_name)
				if res is Resource:
					output.append(res)
	else:
		for file: String in DirAccess.get_files_at(folder):
			var file_name: String = file
			if not file_name.get_extension() == "tres":
				continue
			var res: Resource = load(folder + "/" + file_name)
			if res is Resource:
				output.append(res)
		return output
'''

