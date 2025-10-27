extends Node2D

signal askForMoney
var pot_state = "EMPTY" # controll variable used to check if a pot is empty or ocupied by a tree
var groth_state = 0 # numeric value representing groth state of the tree
var click_on_menu = false # bool checking if a click acured inside or outside a menu

func _input(event: InputEvent) -> void:
	# checking mous click on the entier screen
	if event is InputEventMouseButton:
		# if the click acured on the menu we don't do anything,
		# but we note that the next click won't be a menu click
		if click_on_menu:
			click_on_menu = false
			#print(click_on_menu)
		else:
			toggle_menu_item(false)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# checking if mouse click ocured in area2d (pot) 
	if event.is_action_pressed("Click"):
		click_on_menu = true
		#print(click_on_menu)
		toggle_menu_item(true)

# function toggling visibility of the menu 
func toggle_menu_item(vis: bool):
	if pot_state == "EMPTY":
		$PlantTreeBtn.visible = vis
	elif groth_state < 4:
		$WatterBtn.visible = vis
	elif groth_state == 5:
		$InsertTapBtn.visible = vis

func _process(delta: float) -> void:
	pass
