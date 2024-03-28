extends RichTextLabel

@onready var player = $"../PlayerDataObject"
@onready var show_stats_button = $"../ShowStatsButton"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_show_stats_button_pressed():
	if self.visible == false:
		show_stats_button.set_text("Hide Stats")
		show()
		clear()
		add_text("Player Stats:")
		newline()
		for stat in player.stats:
			var value = player.stats[stat]
			add_text(str(value)+str(" "+str(stat)))
			newline()
	else:
		show_stats_button.set_text("Show Stats")
		hide()
