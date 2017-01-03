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

router.get("/static/enroll.mobileconfig") {
	request, response, next in
	defer { next() }
	try response.send(download: "/static/enroll.mobileconfig")
	
}

router.get("/contact") {
	request, response, next in
	defer { next() }
	try response.render("contact", context: [:])
}


let port = Int(ProcessInfo.processInfo.environment["PORT"] ?? "8090") ?? 8090

Kitura.addHTTPServer(onPort: port, with: router)
Kitura.run()
