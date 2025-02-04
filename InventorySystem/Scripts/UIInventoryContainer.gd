extends PanelContainer

class_name InventoryUIContainer

@export var Icon : TextureRect
@export var ItemAmmount : Label
@export var ItemName : Label

var _ItemCont : InventoryItemContainer

signal OnContainerSelected
signal OnContainerDeselected

func RegisterContainer(Cont : InventoryItemContainer) -> void:
	Cont.connect("OnAmmountUpdated", OnAmmountUpdated)
	Cont.connect("OnContainerEmptied", DeleteSelf)
	_ItemCont = Cont
	ItemAmmount.text = var_to_str(Cont.GetAmmount())
	ItemName.text = Cont.GetContainedItem().GetItemName()
	Icon.texture = Cont.GetContainedItem().GetItemIcon()

func OnAmmountUpdated(Amm : int) -> void:
	ItemAmmount.text = var_to_str(Amm)

func GetContainer() -> InventoryItemContainer:
	return _ItemCont

func _on_select_button_pressed() -> void:
	OnContainerSelected.emit()

func DeleteSelf() -> void:
	OnContainerDeselected.emit()
	queue_free()
