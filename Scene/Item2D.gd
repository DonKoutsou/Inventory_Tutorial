extends Node2D

class_name Item2D

@export var ItemSprite : Sprite2D

var ItemResource : Item

func SetItem(It : Item) -> void:
	ItemResource = It
	ItemSprite.texture = It.GetItemIcon()

func GetItemResource() -> Item:
	return ItemResource
