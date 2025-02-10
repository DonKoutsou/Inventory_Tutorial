extends Node2D

class_name Interactable

@export var NeededItem : Item
@export var TransitionTexture : Texture

var Interacted : bool = false

func Interact() -> void:
	Interacted = true
	$Sprite2D.texture = TransitionTexture
