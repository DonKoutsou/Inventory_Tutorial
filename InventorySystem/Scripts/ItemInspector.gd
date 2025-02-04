extends Control

class_name InspectMenu

@export var ItemNameLabel : Label
@export var ItemIconTex : TextureRect
@export var ItemDescLabel : Label

func SetItem(It : Item) -> void:
	ItemNameLabel.text = It.GetItemName()
	ItemIconTex.texture = It.GetItemIcon()
	ItemDescLabel.text = It.GetItemDescription()

func On_Close_Button_Pressed() -> void:
	queue_free()
