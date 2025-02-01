extends Control

class_name World

@export var ItemScene : PackedScene

@export var ItemsToSpread : Array[Item] = []

func _ready() -> void:
	var Viewportsize = get_viewport_rect().size
	for g in 10:
		var ItRes = ItemsToSpread.pick_random()
		var It = ItemScene.instantiate() as Item2D
		It.SetItem(ItRes)
		add_child(It)
		It.position = Vector2(randf_range(0, Viewportsize.x), randf_range(0, Viewportsize.y))
