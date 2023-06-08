import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
                GeometryReader { proxy in
                    ContentView()
                        .environment(\.mainWindowSize, proxy.size)
                }
            }
    }
}

// 윈도우 크기 가져오는 익스텐션
private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
