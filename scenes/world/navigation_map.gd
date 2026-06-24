extends NavigationRegion2D
class_name NavigationMap

func _ready() -> void:
	NodeRefs.navigation_regions.append(self)
