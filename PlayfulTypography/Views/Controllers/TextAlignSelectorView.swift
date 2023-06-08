import SwiftUI

//텍스트 정렬 종류를 선택하는 뷰
struct TextAlignSelectorView: View {
    
    @Binding var currentAlign: TextAligns
    
    var body: some View {
        Picker("Align", selection: $currentAlign) {
            Image(systemName: "text.alignleft").tag(TextAligns.Left)
            Image(systemName: "text.aligncenter").tag(TextAligns.Center)
            Image(systemName: "text.alignright").tag(TextAligns.Right)
        }
        .pickerStyle(.segmented)
        .frame(width: 252)
    }
}

struct AlignSelector_Previews: PreviewProvider {
    static var previews: some View {
        TextAlignSelectorView(currentAlign: .constant(TextAligns.Left))
    }
}
