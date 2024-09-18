import SwiftUI
import FirebaseCore
import FirebaseFirestore
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      // Request notification permission
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
          if granted {
              print("Permission granted for notifications")
          } else if let error = error {
              print("Failed to get notification permission: \(error.localizedDescription)")
          }
      }
      return true
  }
}

@main
struct BunnyApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
