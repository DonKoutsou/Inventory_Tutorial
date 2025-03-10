extends Resource

class_name Inventory

@export var MaxWeight : float = 40
@export var BaseItemScene : PackedScene

var _CurrentWeight : float = 0

var _InventoryContents : Array[InventoryItemContainer]

signal ContainerCreated(Cont : InventoryItemContainer)
signal OnItemUsed(Cont : InventoryItemContainer)
signal OnItemDropped(It : Item)
signal OnWeightChanged(NewW : float)

func AddItemToInventory(It : Item) -> void:
	if (It.CanStack()):
		var ItemContainer = GetContainerForItem(It)
		if (ItemContainer == null):
			ItemContainer = InventoryItemContainer.new()
			ItemContainer.RegisterItem(It)
			_InventoryContents.append(ItemContainer)
			ContainerCreated.emit(ItemContainer)
		ItemContainer.UpdateAmm(1)
		OnItemAdded(It)
	else:
		var ItemContainer = InventoryItemContainer.new()
		ItemContainer.RegisterItem(It)
		ItemContainer.UpdateAmm(1)
		_InventoryContents.append(ItemContainer)
		ContainerCreated.emit(ItemContainer)
		OnItemAdded(It)

func UseItem(Cont : InventoryItemContainer) -> void:
	OnItemUsed.emit(Cont)

func RemoveItemFromContainer(Cont : InventoryItemContainer, DropToFloor : bool = true) -> void:
	Cont.UpdateAmm(-1)
	if (DropToFloor):
		OnItemDropped.emit(Cont.GetContainedItem())
	OnItemRemoved(Cont.GetContainedItem())
	if (Cont.GetAmmount() == 0):
		_InventoryContents.erase(Cont)
		Cont.ContainerRemoved()

func OnItemAdded(It : Item) -> void:
	_CurrentWeight += It._ItemWeight
	OnWeightChanged.emit(_CurrentWeight)

func OnItemRemoved(It : Item) -> void:
	_CurrentWeight -= It._ItemWeight
	OnWeightChanged.emit(_CurrentWeight)
	
func CanFitItem(It : Item) -> bool:
	return _CurrentWeight + It.GetItemWeight() <= MaxWeight

func HasItem(It : Item) -> bool:
	for g in _InventoryContents:
		if (g.GetContainedItem().resource_path == It.resource_path):
			return true
	return false

func GetContainerForItem(It : Item) -> InventoryItemContainer:
	for g in _InventoryContents:
		if (g.GetContainedItem().resource_path == It.resource_path):
			return g
	return null

func GetCurrentWeight() -> float:
	return _CurrentWeight
