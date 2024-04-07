extends Node2D

var rng = RandomNumberGenerator.new();
var gas_box_visible = false;
var gas = 0;
var apple_cost = 0;

var move_right = false
var move_left = false
var move_up = false
var move_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Car.position = Global.car_position
	if (Global.tutorial_step == 1):
		$Tutorial/FirstItem.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.car_position = $Car.position
	$BarNode/GasLabel.text = str(Global.gas)
	$BarNode/MoneyLabel.text = str(Global.money)
	$BarNode/AppleLabel.text = str(Global.num_apples)
	if !gas_box_visible:
		$GasStationNode/GasExclaim.visible = $Car/Area2D.get_overlapping_areas().has($GasStationNode/GasStation/GasStationArea)
	elif (gas_box_visible && !$Car/Area2D.get_overlapping_areas().has($GasStationNode/GasStation/GasStationArea)):
		$GasStationNode/GasBox.visible = false
		
	$BankNode/BankExclaim.visible = $Car/Area2D.get_overlapping_areas().has($BankNode/Bank/BankArea)
	$PlayerHouse/ArrowNext.visible = $Car/Area2D.get_overlapping_areas().has($PlayerHouse/PlayerHouseArea)
	
	if move_right:
		var tween = get_tree().create_tween()
		tween.tween_property($Car, "position", Vector2($Car.position.x + 15, $Car.position.y), .25)
	if move_left:
		var tween = get_tree().create_tween()
		tween.tween_property($Car, "position", Vector2($Car.position.x - 15, $Car.position.y), .25)
	if move_up:
		var tween = get_tree().create_tween()
		tween.tween_property($Car, "position", Vector2($Car.position.x, $Car.position.y - 15), .25)
	if move_down:
		var tween = get_tree().create_tween()
		tween.tween_property($Car, "position", Vector2($Car.position.x, $Car.position.y + 15), .25)


func _on_arrow_left_input_event(viewport, event, shape_idx):
	
	if (event is InputEventMouseButton && event.pressed):
		$Car.set_texture(load("res://src/car_left.png"))
		move_left = true
	else:
		move_left = false


func _on_arrow_right_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		$Car.set_texture(load("res://src/car_right.png"))
		move_right = true
	else:
		move_right = false


func _on_arrow_up_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		move_up = true
	else:
		move_up = false

func _on_arrow_down_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		move_down = true
	else:
		move_down = false


func _on_gas_exclaim_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		gas_box_visible = true;
		$GasStationNode/GasExclaim.visible = false
		$GasStationNode/GasBox.visible = true
		


func _on_gas_purchase_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		Global.money -= 5
		Global.gas += 1
		if (Global.gas == 3 and Global.tutorial_step == 5):
			$Tutorial/Tutorial5.visible = true

func _on_bank_exclaim_area_input_event(viewport, event, shape_idx):
		if (event is InputEventMouseButton && event.pressed):
			get_tree().change_scene_to_file("res://bank.tscn")


func _on_arrow_next_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		get_tree().change_scene_to_file("res://orchard.tscn")


func _on_done_arrow_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		$Tutorial/FirstItem.visible = false
		Global.tutorial_step = 2


func _on_tutorial5_arrow_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		$Tutorial/Tutorial5.visible = false
		Global.tutorial_step = 6
