import SwiftUI

// 폰트 종류를 드랍다운으로 선택하는 뷰
struct FontFamilySelectorView: View {
    
    @Binding var currentFontFamily: FontFamilys
    
    var body: some View {
        HStack {
            Text("Font Select")
                .padding(.trailing)
            
            Spacer()
            
            Picker(selection: $currentFontFamily, label: Text("FontSelect")) {
                Text("SF Pro").tag(FontFamilys.SFPro)
                Text("Byockdol").tag(FontFamilys.ByockdolVariable)
                Text("Gonggan").tag(FontFamilys.GongganVariable)
            }
            .background(.white, in: RoundedRectangle(cornerRadius: 8))
        }
        .frame(width: 250)
    }
}

struct FontSelecter_Previews: PreviewProvider {
    static var previews: some View {
        FontFamilySelectorView(currentFontFamily: .constant(.SFPro))
    }
}
