extends Node2D

var count
var price

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init(amount, cost):
	count = amount;
	price = cost;

func _on_exclaim_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		$ExclaimNode/Exclaim.visible = false
		$OrderBoxNode/PriceLabel.text = "$" + str(price)
		$OrderBoxNode/AmountLabel.text = "x" + str(count)
		$OrderBoxNode.visible = true
