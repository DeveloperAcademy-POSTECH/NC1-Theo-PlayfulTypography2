import SwiftUI



enum Attributes: String {
    case FontSize, Kerning, LineSpacing, LineLength
}

enum TextAligns: String {
    case Left, Center, Right
}

enum FontFamilys: String {
    case SFPro, ByockdolVariable, GongganVariable
}

enum FontWeights: String {
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
}

// 메인화면 뷰
struct MainScreenView: View {
    
    let cfURL1 = Bundle.main.url(forResource: "ByockdolRegular", withExtension: "ttf")
    let cfURL2 = Bundle.main.url(forResource: "GongganVariable", withExtension: "ttf")
    var byockdol: UIFont
    var gonggan: UIFont
    
    init(){
        CTFontManagerRegisterFontsForURL(cfURL1! as CFURL, CTFontManagerScope.process, nil)
        byockdol = UIFont(name: "ByockdolRegular", size: 65.0)!
        CTFontManagerRegisterFontsForURL(cfURL2! as CFURL, CTFontManagerScope.process, nil)
        gonggan = UIFont(name: "GongganVariable", size: 65.0)!
    }
    
    @State var currentAttribute: Attributes = .FontSize
    @State var currentFontWeight: FontWeights = .regular
    @State var currentTextAlign: TextAligns = .Left
    @State var currentFontFamily: FontFamilys = .SFPro
    @State var currentFontSize: Float = 60.1
    @State var currentKerning: Float = -0.1
    @State var currentLineSpacing: Float = 1
    @State var currentLineLength: Float = (500)/60.1
    @State var currentFontColor = Color(.black)
    @State var currentBackgroundColor = Color(.white)
    
    @State var showingSubview = false
    
    private enum Field: Int, CaseIterable {
        case main
    }
    
    @FocusState private var focusedField: Field?
    
    
    @State var editableText = """
You can edit text!

Lorem ipsum dolor sit amet, ad eos putant complectitur necessitatibus, ad pri partem indoctum vulputate, dictas omnesque explicari id has. Vis dico paulo efficiendi in. Doctus nusquam at eam, timeam aliquip impedit quo eu. Alii nusquam quaerendum ius id, per ei epicuri mnesarchum. Case dolor scaevola ex nam.

Cu tractatos petentium per, tollit assentior eam ex. Has cu rationibus inciderint, in tempor ocurreret qui. Movet legendos deseruisse eos ut, id odio tale perfecto vix. Brute apeirian suavitate at mel, ne quis tritani duo. Eam in congue audire periculis.

Legimus noluisse verterem at quo, vim autem veniam in, nominavi adipiscing vel ex. Ut est quot melius facilisi, te quodsi singulis cotidieque eos. Ex legere alienum nominati vix. Suas menandri eam at, alia adhuc no eam. Nec at erant postea aliquam, usu no justo malis homero, ad sit periculis efficiendi. Postea definitionem eum in.

Civibus complectitur consectetuer at pro, id qui antiopam senserit. Quas justo atqui ad eum, no qui possit animal praesent, qui in amet dicant accommodare. Eu mei erroribus intellegat sententiae, sed te noluisse gloriatur. No sea electram argumentum. Usu at dicta laboramus democritum, id iriure corpora est.

Atqui apeirian vel ad, liber mentitum cum in, cum quod salutatus no. Eos soluta apeirian interpretaris ea, pro in dicit solet feugiat. Eruditi definiebas duo no, eam nemore oblique deseruisse ex. Qui congue placerat intellegebat et, te movet habemus persecuti eam, est impedit fuisset euripidis te. In sea aliquando theophrastus, ea quodsi euismod sit.
"""
    
    var body: some View {
        ZStack {
            
//            배경 테스트용 임시 코드
//            Image("backgroundImage")
//                .resizable()
//                .colorMultiply(backgroundColor)
            
            VStack {
                
                HStack {
                    
                    //우측 정렬을 선택했을 때, 왼쪽 스페이서가 활성화되어 텍스트필드를 오른쪽으로 민다.
                    if currentTextAlign.rawValue == "Right" {
                        Spacer()
                    }
                    
                    //수정 가능한 텍스트 필드, 메인 화면
                    TextField(
                        "Put any text!",
                        text: $editableText,
                        axis: .vertical
                    )
                    .disableAutocorrection(true)
                    .padding()
                    .frame(width: CGFloat(currentFontSize*currentLineLength))
                    .kerning(CGFloat(currentKerning))
                    .lineSpacing(CGFloat(currentLineSpacing))
                    .font(FontFamilyTypeConverter(Input: currentFontFamily.rawValue))
                    .fontWeight(FontWeightTypeConverter(Input: currentFontWeight.rawValue))
                    .foregroundColor(currentFontColor)
                    .multilineTextAlignment(TextAlignTypeConverter(Input: currentTextAlign.rawValue))
                    .focused($focusedField, equals: .main)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Spacer()
                        }
                        
                        ToolbarItem(placement: .keyboard) {
                            Button {
                                focusedField = nil
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down.fill")
                            }
                        }
                    }
                    
                    //좌측 정렬을 선택했을 때, 오른쪽 스페이서가 활성화되어 텍스트필드를 왼쪽으로 민다.
                    if currentTextAlign.rawValue == "Left" {
                        Spacer()
                    } else if currentTextAlign.rawValue == "Center" {
                        
                    }
                }
                
                Spacer()
            }
            
            
            VStack {
                
                Spacer()
                
                ZStack {
                    
                    VStack {
                        
                        HStack {
                            // 텍스트 정렬 선택 뷰
                            TextAlignSelectorView(currentAlign: $currentTextAlign)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top)
                                .padding(.bottom)
                                .padding(.trailing)
                        }
                        
                        ZStack {
                            
                            HStack {
                                // 폰트색, 배경색 선택 뷰
                                ColorPickerView(currentFontColor: $currentFontColor, currentBackgroundColor: $currentBackgroundColor)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing)
                            }
                            
                            HStack {
                                // 컨트롤러 패널 감추기, 보여주기
                                Button {
                                    showingSubview.toggle()
                                } label: {
                                    Rectangle()
                                        .frame(width: 8, height: 80)
                                        .foregroundColor(Color(.systemGray3))
                                        .cornerRadius(8)
                                    
                                }
                                .padding(.leading, 8)
                                .offset(x: 0, y: 100)
                                .padding(.trailing)
                                
                                Spacer()
                            }
                        }
                        
                        HStack {
                            // 폰트 종류 선택 뷰
                            FontFamilySelectorView(currentFontFamily: $currentFontFamily)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, 6)
                                .padding(.trailing)
                        }
                        
                        HStack {
                            // 폰트 두께 선택 뷰
                            FontWeightSelectorView(currentFontWeight: $currentFontWeight)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing)
                                .padding(.top, 4)
                            
                        }
                        
                        HStack{
                            //플러스 마이너스 버튼 뷰
                            PlusMinusButtonView(currentFontSize: $currentFontSize, currentKerning: $currentKerning, currentLineSpacing: $currentLineSpacing, currentLineLength: $currentLineLength, currentAttribute: $currentAttribute)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.bottom)
                                .padding(.trailing)
                        }
                    }
                    .frame(width: 310, alignment: .center)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .offset(x: showingSubview ? 300 : 0, y: 0)
                    .opacity(showingSubview ? 0.5 : 1.0)
                    .animation(.easeInOut(duration: 0.4), value: showingSubview)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .background(currentBackgroundColor)
        
        
    }
    
    /// TextAlignSelectorView에서 선택된 String값을 TextAlignment로 변환
    /// - Parameter Input: String from TextAlignSelectorView
    /// - Returns: TextAlignment
    func TextAlignTypeConverter(Input: String) -> TextAlignment{
        var textAlign: TextAlignment = .leading
        
        if Input == "Left" {
            textAlign = .leading
        } else if Input == "Center" {
            textAlign = .center
        } else if Input == "Right" {
            textAlign = .trailing
        }
        
        return textAlign
    }
    
    /// FontWeightSelectorView에서 선택된 String값을 Font.Weight로 변환
    /// - Parameter Input: String from FontWeightSelectorView
    /// - Returns: Font.Weight
    func FontWeightTypeConverter(Input: String) -> Font.Weight{
        var weight: Font.Weight = .regular
        
        if Input == "ultraLight" {
            weight = .ultraLight
        } else if Input == "thin" {
            weight = .thin
        } else if Input == "light" {
            weight = .light
        } else if Input == "regular" {
            weight = .regular
        } else if Input == "medium" {
            weight = .medium
        } else if Input == "semibold" {
            weight = .semibold
        } else if Input == "bold" {
            weight = .bold
        } else if Input == "heavy" {
            weight = .heavy
        } else if Input == "black" {
            weight = .black
        }
        
        return weight
    }
    
    /// FontFamilySelectorView에서 선택된 String값을 Font로 변환
    /// - Parameter Input: String from FontFamilySelectorView
    /// - Returns: Font
    func FontFamilyTypeConverter(Input: String) -> Font{
        var selectedFont: Font = .system(size: CGFloat(currentFontSize))
        
        // SFPro가 선택되었다면 시스템 폰트(SF Pro)로 변경
        if Input == "SFPro" {
            selectedFont = .system(size: CGFloat(currentFontSize))
        }
        //ByockdolVariable 선택시 해당 폰트로 변경
        else if Input == "ByockdolVariable" {
            selectedFont = Font(UIFont(name: "ByockdolRegular", size: CGFloat(currentFontSize))!)
        }
        //GongganVariable 선택시 해당 폰트로 변경
        else if Input == "GongganVariable" {
            selectedFont = Font(UIFont(name: "GongganVariable", size: CGFloat(currentFontSize))!)
        }
        
        return selectedFont
    }
}

struct MultilineTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        MainScreenView()
    }
}
