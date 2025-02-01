extends Item

class_name ContainerItem

@export var _ContentName : String
@export var _Capacity : float
@export var _CurrentContetAmmount : float

func GetItemDescription() -> String:
	return "{0} | {1}/{2} of {3}".format([_ItemDescription, _CurrentContetAmmount, _Capacity, _ContentName])

func GetContentName() -> String:
	return _ContentName

func GetContentCapacity() -> float:
	return _Capacity

func GetContentAmmount() -> float:
	return _CurrentContetAmmount

func GetItemWeight() -> float:
	return _ItemWeight + _CurrentContetAmmount

func CanStack() -> bool:
	return false
