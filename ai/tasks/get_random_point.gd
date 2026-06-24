@tool
extends BTAction

func _generate_name() -> String:
	return "GetRandomPoint"
	
func _tick(_delta: float) -> Status:
	var target:Vector2 = Vector2.ZERO
	var nav_region:NavigationRegion2D = blackboard.get_var("navigation_region")
	
	target = NavigationServer2D.region_get_random_point(nav_region, 1, false)
	
	blackboard.set_var("target_position", target)
	return SUCCESS
