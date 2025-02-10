extends Node2D

class_name Character

@export var Speed : float
@export var Inv : Inventory

var Interactables : Array[Interactable]

func _ready() -> void:
	Inv.connect("OnItemDropped", DropItemToFeet)
	Inv.connect("OnItemUsed", TryUseItemFromContainer)

func DropItemToFeet(It : Item) -> void:
	var ItemSc = Inv.BaseItemScene.instantiate() as Item2D
	ItemSc.SetItem(It)
	get_parent().add_child(ItemSc)

func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("MoveUp")):
		position.y -= Speed
	if (Input.is_action_pressed("MoveDown")):
		position.y += Speed
	if (Input.is_action_pressed("MoveLeft")):
		position.x -= Speed
	if (Input.is_action_pressed("MoveRight")):
		position.x += Speed

func TryUseItemFromContainer(Cont : InventoryItemContainer) -> void:
	var It = Cont.GetContainedItem()
	for g in Interactables:
		if (g.Interacted):
			continue
		if (g.NeededItem.resource_path == It.resource_path):
			g.Interact()
			Inv.RemoveItemFromContainer(Cont, false)
			return
	
func _on_item_area_area_entered(area: Area2D) -> void:
	if (area.get_parent() is Item2D):
		var It = area.get_parent() as Item2D
		if (Inv.CanFitItem(It.GetItemResource())):
			Inv.AddItemToInventory(It.GetItemResource())
			It.queue_free()
	else : if (area.get_parent() is Interactable):
		Interactables.append(area.get_parent())


func _on_item_area_area_exited(area: Area2D) -> void:
	if (area.get_parent() is Interactable):
		Interactables.erase(area.get_parent())
