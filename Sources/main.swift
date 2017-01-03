import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import KituraStencil

HeliumLogger.use()

let router = Router()
router.setDefault(templateEngine: StencilTemplateEngine())

router.all("/static", middleware: StaticFileServer())

router.get("/") {
	request, response, next in
	defer { next() }
	try response.render("home", context: [:])
}

router.get("/static/:file") {
	request, response, next in
	defer { next() }
	guard let file = request.parameters["file"] else { return }
	try response.send(download: file)
}

router.get("/contact") {
	request, response, next in
	defer { next() }
	try response.render("contact", context: [:])
}

router.post("/udid") {
	request, response, next in
	defer { next() }
	print("request: \(request)")
	print("Query params:\(request.queryParameters)")
	print("parsedbody: \(request.body)")
//	var requestDict = NSDictionary(contentsOfFile: request.body as? String)
	
//	let deviceName = ["DEVICE_NAME" : DEVICE_NAME ]
//	let udid = ["UDID" : UDID ]
//	let product = ["PRODUCT"]
//	let version = request.
//	let serial
	
//	try response.render("home", context: [:])
}


let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
