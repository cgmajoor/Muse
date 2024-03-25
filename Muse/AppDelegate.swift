//
//  AppDelegate.swift
//  Muse
//
//  Created by Ceren Majoor on 25/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        window?.rootViewController = createNavigationController()
        window?.makeKeyAndVisible()
        return true
    }

}

private extension AppDelegate {
    
    func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: ArtworkListViewController())

        // TODO: Refactor
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.systemGray6
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController.navigationBar.standardAppearance = navigationBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        return navigationController
    }
}
