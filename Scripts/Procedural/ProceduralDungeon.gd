extends "ProceduralData.gd"

class_name ProceduralDungeon
enum eSide {WALL,EXIT}
var origin_bottomleft:bool = false
var invert = false;

# 0 = no way => WALL
# 1 =  exit
class empty_cell:
	var up:int = eSide.EXIT
	var right:int = eSide.EXIT
	var down:int = eSide.EXIT
	var left:int = eSide.EXIT
	var visited:int = 0
	var userData:Dictionary = {}
	
func _init(w:int,h:int,rnd:bool,useed:int):

	self.width = w
	self.height = h
	self.Create(empty_cell)
	self.Clean(empty_cell)	
	
func Build()->void:
	self.done = false
	self.GenerateMap_Pass1()	
	self.done = true

func IsUp(x:int,y:int,sideType:int)->bool:
	var res=false
	if self.origin_bottomleft:
		if self.data[x][self.height-y-1].up==sideType: res = true
	else:
		if self.data[x][y].up==sideType: res = true
	return res
	
func IsRight(x:int,y:int,sideType:int):
	var res=false
	if self.origin_bottomleft:
		if self.data[x][self.height-y-1].right==sideType: res = true
	else:
		if self.data[x][y].right==sideType: res = true
	return res
	
func IsDown(x:int,y:int,sideType:int):
	var res=false
	if self.origin_bottomleft:
		if self.data[x][self.height-y-1].down==sideType: res = true
	else:
		if self.data[x][y].down==sideType: res = true
	return res

func IsLeft(x:int,y:int,sideType:int):
	var res=false
	if self.origin_bottomleft:
		if self.data[x][self.height-y-1].left==sideType: res = true
	else:
		if self.data[x][y].left==sideType: res = true
	return res
	
func ToString(x,y):
	var _x = x
	var _y = 0
	if self.origin_bottomleft:
		_y = self.height-y-1
	else:
		_y = y
	return "{"+String(self.data[_x][_y].up)+","+String(self.data[_x][_y].right)+","+String(self.data[_x][_y].down)+","+String(self.data[_x][_y].left)+"}"
	pass
	
func GetCell(x:int,y:int)->empty_cell:
	var _y = self.height - y -1
	return self.data[x][_y]
	pass
	
func GenerateMap_Pass1()->void:
	
	var mx = 0
	var my = 0
	
	# create closed rooms array
	for x in range(0,self.width):
		for y in range(0,self.height):
			
			mx = ((x*2) + 1)			
			my = ((y*2) + 1)  # origin bottom/left
				
			self.data[x][y].up = eSide.WALL
			self.data[x][y].down = eSide.WALL
				
			self.data[x][y].left = eSide.WALL
			self.data[x][y].right = eSide.WALL
			
		pass