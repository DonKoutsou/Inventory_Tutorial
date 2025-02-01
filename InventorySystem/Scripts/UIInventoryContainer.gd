extends PanelContainer

class_name InventoryUIContainer

@export var Icon : TextureRect
@export var ItemAmmount : Label
@export var ItemName : Label

func RegisterContainer(Cont : InventoryItemContainer) -> void:
	Cont.connect("OnAmmountUpdated", OnAmmountUpdated)
	ItemAmmount.text = var_to_str(Cont.GetAmmount())
	ItemName.text = Cont.GetContainedItem().GetItemName()
	Icon.texture = Cont.GetContainedItem().GetItemIcon()

func OnAmmountUpdated(Amm : int) -> void:
	ItemAmmount.text = var_to_str(Amm)
