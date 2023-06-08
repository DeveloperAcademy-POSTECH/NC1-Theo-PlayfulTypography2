import SwiftUI
import Combine

// +, - 버튼이 있는 뷰
struct PlusMinusButtonView: View {
    
    // 화면 크기 변경시 알아채기
    @Environment(\.mainWindowSize) var mainWindowSize
    
    // 꾹 누를 때 반복
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    // MainScreeniew와 주고받는 변수
    @Binding var currentFontSize: Float
    @Binding var currentKerning: Float
    @Binding var currentLineSpacing: Float
    @Binding var currentLineLength: Float
    
    //
    @Binding var currentAttribute: Attributes
    
    struct buttonProperty: Identifiable {
        let symbol: String
        let value: Float
        var id: String { symbol }
    }
    
    let buttonPropertys: [buttonProperty] = [
        buttonProperty(symbol: "---", value: -10),
        buttonProperty(symbol: "--", value: -1),
        buttonProperty(symbol: "-", value: -0.1),
        buttonProperty(symbol: "+", value: 0.1),
        buttonProperty(symbol: "++", value: 1),
        buttonProperty(symbol: "+++", value: 10)
    ]
    
    /// 버튼을 눌렀을 때, 수치를 계산해주는 함수
    /// - Parameter value: Font Parameter with Float Type
    func valueCaculator(value: Float) {
        
        switch currentAttribute {
            
        case Attributes.Kerning: //폰트 자간
            currentKerning += value/10
            
            
        case Attributes.LineSpacing: //폰트 행간
            currentLineSpacing += value/20*currentFontSize
            
            
        case Attributes.LineLength: //폰트 글줄길이
            currentLineLength += value/2
            
            //여러 변수 상황에 대응
            if currentLineLength < 1.1 {
                currentLineLength = 1.1
            }
            
            if currentFontSize*currentLineLength > Float(mainWindowSize.width-10) {
                currentLineLength = Float(mainWindowSize.width-10)/currentFontSize
            }
            
            
        case Attributes.FontSize: //폰트 크기
            
            currentFontSize += value
            
            //여러 변수 상황에 대응
            if currentLineLength < 1.1 {
                currentLineLength = 1.1
            }
            if currentFontSize < 5 {
                currentFontSize = 5
            }
            if currentFontSize*currentLineLength > Float(mainWindowSize.width-10) {
                currentLineLength = Float(mainWindowSize.width-10)/currentFontSize
            }
        }
    }
    
    var body: some View {
        VStack {
            Divider()
                .padding(.bottom, 4)
            
            HStack {
                
                Text("Attribute")
                
                Spacer()
                
                Picker("Target", selection: $currentAttribute) {
                    Text("Font Size").tag(Attributes.FontSize)
                    Text("Kerning").tag(Attributes.Kerning)
                    Text("Line Spacing").tag(Attributes.LineSpacing)
                    Text("Line Length").tag(Attributes.LineLength)
                }
                .background(.white, in: RoundedRectangle(cornerRadius: 8))
                .frame(width: 150, alignment: .trailing)
                .foregroundColor(.white)
                
            }
            
            HStack {
                ForEach(buttonPropertys) { buttonAttribute in
                    Button {
                        if(self.isLongPressing){
                            self.isLongPressing.toggle()
                            self.timer?.invalidate()
                        } else {
                            valueCaculator(value: buttonAttribute.value)
                        }
                    } label: {
                        Text(buttonAttribute.symbol)
                    }
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(8)
                    .fontWeight(.bold)
                    .buttonStyle(.borderedProminent)
                    .frame(width: 34)
                    .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                        self.isLongPressing = true
                        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
                            valueCaculator(value: buttonAttribute.value/10)
                        })
                    })
                }
            }
        }
        .font(.body)
        .frame(width: 250)
    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusMinusButtonView(currentFontSize: .constant(60.1), currentKerning: .constant(1.0), currentLineSpacing: .constant(1.0), currentLineLength: .constant(500.0),currentAttribute: .constant(Attributes.FontSize))
    }
}
