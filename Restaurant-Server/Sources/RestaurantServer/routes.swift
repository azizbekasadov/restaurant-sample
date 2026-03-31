import Fluent
import Vapor

enum RoutesMaxBodySizePolicy {
    static let size: ByteCount = "5mb"
}

func routes(_ app: Application) throws {
    let restaurantService = RestaurantService()
    let restaurantController = RestaurantController(restaurantService: restaurantService)
    
    let reviewService = ReviewsService()
    let reviewsController = ReviewsController(reviewsService: reviewService)
    
    // Restaurant
    app.post("restaurant", use: restaurantController.create)
    app.get("restaurant", use: restaurantController.all)
    app.delete("restaurant", ":restaurantId", use: restaurantController.delete)
    
    // Reviews
    app.post("reviews", use: reviewsController.create)
    app.get("restaurant", ":restaurantId", "reviews", use: reviewsController.getByRestaurantId)
    
    
    app.routes.defaultMaxBodySize = RoutesMaxBodySizePolicy.size
}
