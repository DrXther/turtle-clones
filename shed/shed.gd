extends Node2D


var x = 10
var potunmade=0
var iscooking=false
var potmade=0
var bottled = 0
const pot_full=5

func _ready() -> void:
	pass
	
	#$Label.text = "surowica: " + str(x) +"\nw garnku: " + str(potunmade+potmade) + "\nbutelki: " + str(bottled)



#this doesnt work
#func _process(delta: float) -> void:
#	$Label.text = "surowica: " + str(x) +"\nw garnku: " + str(potunmade+potmade) + "\nbutelki: " + str(bottled)



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if iscooking==false and x>0 and potunmade<pot_full and potmade==0:
			x-=1
			potunmade+=1
			if potunmade==1:
				$Pot/AnimatedSprite2D.play("uncooked")


func _on_stove_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		iscooking = true
		$Pot/AnimatedSprite2D.play("cooking")
		$Stove/AnimatedSprite2D.play("hot")
		$Timer.start()
#add lid?


func _on_timer_timeout() -> void:
	iscooking=false
	$Pot/AnimatedSprite2D.play("cooked")
	$Stove/AnimatedSprite2D.play("cold")
	potmade=potunmade
	potunmade=0


func _on_bottle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if potmade>0:
			bottled += 1
			potmade -=1
			if potmade==0:
				$Pot/AnimatedSprite2D.play("empty")
