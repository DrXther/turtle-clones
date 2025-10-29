extends Node2D

var pot_state = "EMPTY" # controll variable used to check if a pot is empty or ocupied by a tree
var groth_state = 0 # numeric value representing groth state of the tree

var time_growing = 0 # amount of time that the sapling has been growing for
var time_beetween_groth_states = 0 # amount of time needed to go to the next state of 
var need_water = false # does the tree need to be watterd

var tap_installed = false # does the tree have a tap
var bucket_full = false
var time_leaking = 0 # time that the tree has been producing sap
var time_to_fill_bucket = 25 # time needed to fill bucket with sap


func _on_watter_btn_pressed() -> void:
	need_water = false


func _on_plant_tree_btn_pressed() -> void:
	if PlayerResorces.money >= 100:
		need_water = true
		pot_state = "SAP"
		$Sapling.visible = true
		$PlantTreeBtn.visible = false
		$WatterBtn.visible = true
		PlayerResorces.change_money(-100)


func _on_insert_tap_btn_pressed() -> void:
	$InsertTapBtn.visible = false
	var texture = load("res://assets/groth_state3_tap.png")
	$Sapling.texture = texture
	tap_installed = true


func _on_collect_sap_btn_pressed() -> void:
	bucket_full = false
	PlayerResorces.change_sap_buckets(1)
	print(PlayerResorces.sap_buckets)
	$CollectSapBtn.visible = false


# function responsible for timing each groth state
func manage_groth_process(delta):
	if pot_state == "SAP" and not need_water:
		$Timer.visible = true
		time_growing += delta
		$Timer.text = "%4.2f" % (time_beetween_groth_states - time_growing)
		if time_growing >= time_beetween_groth_states:
			time_growing = 0
			groth_state += 1
			time_beetween_groth_states += 5
			need_water = true
			$Timer.visible = false
			$Timer.text = str(time_beetween_groth_states)
			change_groth_state()


# function used for changing the apearenc of sapling based on the current groth state
func change_groth_state():
	var texture
	match groth_state:
		0:
			texture = load("res://assets/sapling.png")
			$Sapling.texture = texture
		1:
			texture = load("res://assets/groth_state1.png")
			$Sapling.texture = texture
		2:
			texture = load("res://assets/groth_state2.png")
			$Sapling.texture = texture
		3:
			texture = load("res://assets/groth_state3.png")
			$Sapling.texture = texture
			$WatterBtn.disabled = true
			$WatterBtn.visible = false
			$InsertTapBtn.visible = true


# function responsible for sap generation
func manage_sap_production(delta):
	if not bucket_full and tap_installed:
		$Timer.visible = true
		time_leaking += delta
		$Timer.text = "%4.2f" % (time_to_fill_bucket - time_leaking)
		if time_leaking >= time_to_fill_bucket:
			print("Sap ready for collection")
			$Timer.text = str(time_to_fill_bucket)
			$Timer.visible = false
			time_leaking = 0
			bucket_full = true
			$CollectSapBtn.visible = true


func _ready() -> void:
	$Timer.text = str(time_beetween_groth_states)
	change_groth_state()


func _process(delta: float) -> void:
	if need_water:
		$WatterBtn.disabled = false
	else:
		$WatterBtn.disabled = true
	manage_groth_process(delta)
	manage_sap_production(delta)
