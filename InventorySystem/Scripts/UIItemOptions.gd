extends PanelContainer

class_name UIItemOptions

@export var ItemNameLabel : Label

signal OnItemUsed()
signal OnItemInspected()
signal OnItemDroped()
signal OnItemConsumed()

func _ready() -> void:
	visible = false

func SetSelectedItem(It : Item) -> void:
	visible = true
	ItemNameLabel.text = It.GetItemName()

func _on_use_button_pressed() -> void:
	OnItemUsed.emit()


func _on_inspect_button_pressed() -> void:
	OnItemInspected.emit()


func _on_consume_button_pressed() -> void:
	OnItemConsumed.emit()


func _on_drop_button_pressed() -> void:
	OnItemDroped.emit()


func _on_cancel_button_pressed() -> void:
	visible = false
