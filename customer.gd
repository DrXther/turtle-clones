extends Node2D
signal bought

@onready var label = $Label
@onready var sprite = $Sprite2D

func _ready():
    sprite.texture = load("res://assets/customer.png")
    label.text = "Chcę syrop klonowy 🍁"
    buy_product()

func buy_product():
    var t = randf_range(1.0, 3.0)
    await get_tree().create_timer(t).timeout
    react_to_sale()

func react_to_sale():
    if not is_inside_tree():
        return
    label.text = "Dzięki! 😋"
    emit_signal("bought")
    await get_tree().create_timer(1.0).timeout
    queue_free()