extends Node2D

@export var customer_scene: PackedScene = preload("res://scenes/customer.tscn")
@export var syrup_price: int = 10

var money := 0

func _ready():
    $MoneyLabel.text = "💰 Pieniądze: " + str(money)
    $SellButton.text = "Sprzedaj syrop 🍯"
    $SellButton.pressed.connect(_on_sell_button_pressed)
    spawn_customer()

func spawn_customer():
    var c = customer_scene.instantiate()
    c.position = Vector2(500, 320)
    c.connect("bought", Callable(self, "_on_customer_bought"))
    $CustomerSpawner.add_child(c)

func _on_customer_bought():
    money += syrup_price
    $MoneyLabel.text = "💰 Pieniądze: " + str(money)
    await get_tree().create_timer(1.5).timeout
    spawn_customer()

func _on_sell_button_pressed():
    for child in $CustomerSpawner.get_children():
        if child.has_method("react_to_sale"):
            child.react_to_sale()