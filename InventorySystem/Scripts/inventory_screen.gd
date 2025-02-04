extends Control

class_name InventoryScreen

@export var WeightText : Label
@export var ContainerPlacement : Control
@export var ItemOptions : UIItemOptions
@export var InventoryContainerScene : PackedScene
@export var Inv : Inventory
@export var InventoryDescriptorScene : PackedScene

var SelectedContainer : InventoryItemContainer

func _ready() -> void:
	Inv.connect("ContainerCreated", OnContainerCreated)
	Inv.connect("OnWeightChanged", OnWeightUpdated)
	OnWeightUpdated(Inv.GetCurrentWeight())

func OnContainerCreated(Cont : InventoryItemContainer) -> void:
	var UIContainer = InventoryContainerScene.instantiate() as InventoryUIContainer
	UIContainer.RegisterContainer(Cont)
	ContainerPlacement.add_child(UIContainer)
	UIContainer.connect("OnContainerSelected", OnItemContainerSelected.bind(UIContainer))

func OnWeightUpdated(NewW : float) -> void:
	WeightText.text = "Weight : {0} / {1}".format([NewW, Inv.MaxWeight])

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Inventory")):
		visible = !visible

func OnItemContainerSelected(ItemContainer : InventoryUIContainer) -> void:
	if (SelectedContainer != null):
		SelectedContainer.disconnect("OnContainerEmptied", OnItemContainerDeselected)
	SelectedContainer = ItemContainer.GetContainer()
	SelectedContainer.connect("OnContainerEmptied", OnItemContainerDeselected)
	ItemOptions.SetSelectedItem(SelectedContainer.GetContainedItem())

func OnItemContainerDeselected() -> void:
	SelectedContainer.disconnect("OnContainerEmptied", OnItemContainerDeselected)
	SelectedContainer = null
	ItemOptions.visible = false

func OnItemUsed() -> void:
	pass

func OnItemInspected() -> void:
	var Inspector = InventoryDescriptorScene.instantiate() as InspectMenu
	Inspector.SetItem(SelectedContainer.GetContainedItem())
	add_child(Inspector)

func OnItemConsumed() -> void:
	pass

func OnItemDroped() -> void:
	Inv.RemoveItemFromContainer(SelectedContainer)
