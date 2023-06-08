import SwiftUI

// 폰트의 두께를 선택하는 뷰
struct FontWeightSelectorView: View {
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    @Binding var currentFontWeight: FontWeights
    
    var body: some View {
        HStack {
            Text("Font Weight")
                .padding(.trailing)
            
            Spacer()
            
            Picker(selection: $currentFontWeight, label: Text("FontWeight")) {
                Text("Ultra Light").tag(FontWeights.ultraLight)
                Text("Thin").tag(FontWeights.thin)
                Text("Light").tag(FontWeights.light)
                Text("Regular").tag(FontWeights.regular)
                Text("Medium").tag(FontWeights.medium)
                Text("Semibold").tag(FontWeights.semibold)
                Text("Bold").tag(FontWeights.bold)
                Text("Heavy").tag(FontWeights.heavy)
                Text("Black").tag(FontWeights.black)
            }
            .background(.white, in: RoundedRectangle(cornerRadius: 8))
        }
        .frame(width: 250)
    }
}

struct DropdownButton_Previews: PreviewProvider {
    static var previews: some View {
        FontWeightSelectorView(currentFontWeight: .constant(FontWeights.regular))
    }
}
