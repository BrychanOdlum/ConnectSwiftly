import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraCORS

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
	let gameManager = GameManager()

    public init() throws {
		
    }

    func postInit() throws {
        // Capabilities
        initializeMetrics(app: self)

        // Endpoints
        initializeHealthRoutes(app: self)
		
		let options = Options(allowedOrigin: .all)
		let cors = CORS(options: options)
		router.all("/*", middleware: cors)
		
		// [GET] CREATE GAME
		router.get("/game/create") { request, response, _ in
			
			let game = self.gameManager.createGame()
			
			let data = CreateGame(gameID: game.key!, hostID: game.host.key!)
			try response.send(data).end()
		}
		
		// [GET] GAME JOIN
		router.get("/game/join/:game") { request, response, _ in
			let gameKey = request.parameters["game"] ?? ""
			
			print("key \(gameKey)")
			
			let game = self.gameManager.getGame(id: gameKey)
			
			if game == nil {
				try response.send(ErrorJSON()).end()
				return
			}
			
			let guestKey = game?.guestJoin()
			if guestKey == nil {
				try response.send(ErrorJSON()).end()
				return
			}
			
			let data = JoinGame(guestID: guestKey!)
			try response.send(data).end()
		}
		
		// [GET] PLACE
		router.get("/game/place/:game/:user/:column") { request, response, _ in
			guard
				let gameID = request.parameters["game"],
				let userID = request.parameters["user"],
				let column = request.parameters["column"] else {
					try response.send(ErrorJSON()).end()
					return
			}
			
			let game = self.gameManager.getGame(id: gameID)
			let player = game?.getPlayer(key: userID)
			let columnID = Int(column)
			
			if player == nil {
				try response.send(ErrorJSON()).end()
				return
			}
			
			game?.insert(column: columnID, player: player!)
			
			try response.send(SuccessJSON()).end()
		}
		
		// [GET] FETCH
		router.get("/game/fetch/:game/:user") { request, response, _ in
			guard
				let gameID = request.parameters["game"],
				let userID = request.parameters["user"] else {
					try response.send(ErrorJSON()).end()
					return
			}
			
			guard
				let game = self.gameManager.getGame(id: gameID),
				let player = game.getPlayer(key: userID) else {
					try response.send(ErrorJSON()).end()
					return
			}
			
			let data = FetchGame(board: game.board!, host: game.host!, guest: game.guest != nil, turn: game.turn == player, winner: game.winner)
			try response.send(data).end()
		}
		
		// [GET] CHECK
		router.get("/game/check/:game/:column/:row") { request, response, _ in
			guard
				let gameID = request.parameters["game"],
				let column = request.parameters["column"],
				let row = request.parameters["row"] else {
					try response.send(ErrorJSON()).end()
					return
			}
			
			guard let game = self.gameManager.getGame(id: gameID) else {
				try response.send(ErrorJSON()).end()
				return
			}
			
			let data = game.detectVictory(column: Int(column), row: Int(row)) ? "Win" : "Loss"
			
			try response.send(data).end()
		}
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
	
	
}
