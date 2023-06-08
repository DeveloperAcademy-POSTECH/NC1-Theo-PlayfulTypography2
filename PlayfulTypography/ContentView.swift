import SwiftUI

struct ContentView: View {
    var body: some View {
        MainScreenView()
            .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
