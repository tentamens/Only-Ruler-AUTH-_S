extends Node


var network = NetworkedMultiplayerENet.new()
var port = 1981
var max_servers = 5


func _ready():
	StartServer()


func StartServer():
	network.create_server(port, max_servers)
	get_tree().set_network_peer(network)
	print("Authentication server started")
	
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(gateway_id):
	print("Gateway " + str(gateway_id) + " Connected")


func _Peer_Disconnected(gateway_id):
	print("Gateway " + str(gateway_id) + " Disconnected")


remote func AuthenticatePlayer(username, password, player_id):
	var token
	var gateway_id = get_tree().get_rpc_sender_id()
	var result
	if not PlayerData.Player_Data.has(username):
		result = false
	elif not PlayerData.Player_Data[username].Password == password:
		result = false
	else:
		result = true
		

		randomize()
		token = str(randi()).sha256_text() + str(OS.get_unix_time())
		var gameserver = "GameServer1"
		GameServers.DistributeLoginToken(token, gameserver)

	rpc_id(gateway_id, "AuthenticationResults", result, player_id)
	
	
	
	
	
	
	
	



