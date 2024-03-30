import Flutter
import UIKit

public class MiniPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mini", binaryMessenger: registrar.messenger())
    let instance = MiniPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "saveLastBundleId":
      // TODO: get an actual bundleId
      let hostBundleID = self.parentViewController!.valueForKey("_hostBundleID")
      let currentHostBundleID = String(hostBundleID)
      UserDefaults.standard.set(currentHostBundleID, forKey: "last_app_bundle_id")
    case "toPreviousApp":
      self.toPreviousApp()
//      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func toPreviousApp() -> Bool {
    if #available(iOS 17.0, *) {
      let sharedDefaults = UserDefaults(suiteName: "group.lexia")
      let lastAppBundleId = UserDefaults.standard.string(forKey: "last_app_bundle_id")
      guard let obj = objc_getClass("LSApplicationWorkspace") as? NSObject else { return false }
      let workspace = obj.perform(Selector(("defaultWorkspace")))?.takeUnretainedValue() as? NSObject
      let open = workspace?.perform(Selector(("openApplicationWithBundleID:")), with: lastAppBundleId) != nil
      return open
    } else {
      guard
        let sysNavIvar = class_getInstanceVariable(UIApplication.self, "_systemNavigationAction"),
        let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
        let destinations = action.perform(#selector(getter: PrivateSelectors.destinations)).takeUnretainedValue() as? [NSNumber],
        let firstDestination = destinations.first
      else {
        return false
      }
      action.perform(#selector(PrivateSelectors.sendResponseForDestination), with: firstDestination)
      return true
    }
  }
}
