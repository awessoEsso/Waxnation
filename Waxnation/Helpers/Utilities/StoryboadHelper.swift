//
//  StoryboadHelper.swift
//  Waxnation
//
//  Created by Esso AWESSO on 10/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import UIKit


protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    /// The uniform place where we state all the storyboard we have in our application
    enum Storyboard: String {
        case main
        case authentication
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    // MARK: - Convenience Initializers
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - Class Functions
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    
    // MARK: View Controllers
    
    static func detailsViewController() -> DetailsViewController {
        let mainStoryboard = UIStoryboard(storyboard: .main)
        let detailsViewController: DetailsViewController = mainStoryboard.instantiateViewController()
        return detailsViewController
    }
    
    static func signUpViewController() -> SignUpViewController {
        let mainStoryboard = UIStoryboard(storyboard: .authentication)
        let signUpViewController: SignUpViewController = mainStoryboard.instantiateViewController()
        return signUpViewController
    }
    
    static func signInViewController() -> SignInViewController {
        let mainStoryboard = UIStoryboard(storyboard: .authentication)
        let signInViewController: SignInViewController = mainStoryboard.instantiateViewController()
        return signInViewController
    }
    
   
}


