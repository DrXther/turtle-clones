extends Node2D



var potunmade=0
var iscooking=false
var potmade=0
#var PlayerResorces.maple_syroup_bottles = 0
const pot_full=5


func _ready() -> void:
	pass
	
	#$Label.text = "surowica: " + str(x) +"\nw garnku: " + str(potunmade+potmade) + "\nbutelki: " + str(PlayerResorces.maple_syroup_bottles)



#this doesnt work
func _process(_delta: float) -> void:
	$Label.text = "surowica: " + str(PlayerResorces.sap_buckets) +"
		w garnku: " + str(potunmade+potmade) + "
		butelki: " + str(PlayerResorces.maple_syroup_bottles)



func _on_pot_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("pot 0")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if iscooking==false and PlayerResorces.sap_buckets>0 and potunmade<pot_full and potmade==0:
			PlayerResorces.sap_buckets-=1
			potunmade+=1
			if potunmade==1:
				$Pot/AnimatedSprite2D.play("uncooked")


func _on_stove_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("stove 0")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and potmade==0 and potunmade>0:
		iscooking = true
		$Pot/AnimatedSprite2D.play("cooking")
		$Stove/AnimatedSprite2D.play("hot")
		$Timer.start()
		$AnimationPlayer.play("timer") 
		#if upgrades then different time
#add lid?


func _on_timer_timeout() -> void:
	iscooking=false
	$Pot/AnimatedSprite2D.play("cooked")
	$Stove/AnimatedSprite2D.play("cold")
	potmade=potunmade
	potunmade=0



func _on_bottle_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("bottle 0")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if potmade>0:
			PlayerResorces.maple_syroup_bottles += 1
			potmade -=1
			if potmade==0:
				$Pot/AnimatedSprite2D.play("empty")
