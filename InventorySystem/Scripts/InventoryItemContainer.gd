extends Resource

class_name InventoryItemContainer

var _StoredItem : Item
var _Ammount : int = 0

signal OnAmmountUpdated(NewAmmount : int)
signal OnContainerEmptied

func RegisterItem(It : Item) -> void:
	_StoredItem = It

func UpdateAmm(Amm : int) -> void:
	_Ammount += Amm
	OnAmmountUpdated.emit(_Ammount)

func GetAmmount() -> int:
	return _Ammount
	
func GetContainedItem() -> Item:
	return _StoredItem

func ContainerRemoved() -> void:
	OnContainerEmptied.emit()
