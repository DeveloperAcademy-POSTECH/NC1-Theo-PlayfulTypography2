import SwiftUI

// 배경 또는 글자의 색상을 선택하는 뷰
struct ColorPickerView: View {
    
    @Binding var currentFontColor: Color
    @Binding var currentBackgroundColor: Color
    
    var body: some View {
        VStack {
            ColorPicker("Font Color", selection: $currentFontColor)
                .frame(width: 250)
                .padding(.top, 4)
            ColorPicker("Background Color", selection: $currentBackgroundColor)
                .frame(width: 250)
                .padding(.top, 14)
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(currentFontColor: .constant(.black), currentBackgroundColor: .constant(.white))
    }
}
