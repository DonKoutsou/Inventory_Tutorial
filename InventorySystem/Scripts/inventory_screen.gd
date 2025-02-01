extends Control

class_name InventoryScreen

@export var WeightText : Label
@export var ContainerPlacement : Control
@export var InventoryContainerScene : PackedScene
@export var Inv : Inventory

func _ready() -> void:
	Inv.connect("ContainerCreated", OnContainerCreated)
	Inv.connect("OnWeightChanged", OnWeightUpdated)
	OnWeightUpdated(Inv.GetCurrentWeight())

func OnContainerCreated(Cont : InventoryItemContainer) -> void:
	var UIContainer = InventoryContainerScene.instantiate() as InventoryUIContainer
	UIContainer.RegisterContainer(Cont)
	ContainerPlacement.add_child(UIContainer)

func OnWeightUpdated(NewW : float) -> void:
	WeightText.text = "Weight : {0} / {1}".format([NewW, Inv.MaxWeight])

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Inventory")):
		visible = !visible
