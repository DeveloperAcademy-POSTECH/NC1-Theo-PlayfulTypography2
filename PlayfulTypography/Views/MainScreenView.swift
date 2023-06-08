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
텍스트를 수정할 수 있어요!

이 헌법시행 당시에 이 헌법에 의하여 새로 설치될 기관의 권한에 속하는 직무를 행하고 있는 기관은 이 헌법에 의하여 새로운 기관이 설치될 때까지 존속하며 그 직무를 행한다. 모든 국민은 직업선택의 자유를 가진다. 법관은 탄핵 또는 금고 이상의 형의 선고에 의하지 아니하고는 파면되지 아니하며, 징계처분에 의하지 아니하고는 정직·감봉 기타 불리한 처분을 받지 아니한다. 통신·방송의 시설기준과 신문의 기능을 보장하기 위하여 필요한 사항은 법률로 정한다. 헌법개정안은 국회가 의결한 후 30일 이내에 국민투표에 붙여 국회의원선거권자 과반수의 투표와 투표자 과반수의 찬성을 얻어야 한다.

국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경제의 발전에 노력하여야 한다. 국회의원은 그 지위를 남용하여 국가·공공단체 또는 기업체와의 계약이나 그 처분에 의하여 재산상의 권리·이익 또는 직위를 취득하거나 타인을 위하여 그 취득을 알선할 수 없다. 이 헌법공포 당시의 국회의원의 임기는 제1항에 의한 국회의 최초의 집회일 전일까지로 한다. 언론·출판에 대한 허가나 검열과 집회·결사에 대한 허가는 인정되지 아니한다. 재판의 심리와 판결은 공개한다. 다만, 심리는 국가의 안전보장 또는 안녕질서를 방해하거나 선량한 풍속을 해할 염려가 있을 때에는 법원의 결정으로 공개하지 아니할 수 있다.

혼인과 가족생활은 개인의 존엄과 양성의 평등을 기초로 성립되고 유지되어야 하며, 국가는 이를 보장한다. 모든 국민은 법률이 정하는 바에 의하여 국가기관에 문서로 청원할 권리를 가진다. 국가원로자문회의의 조직·직무범위 기타 필요한 사항은 법률로 정한다. 연소자의 근로는 특별한 보호를 받는다. 국회의원은 현행범인인 경우를 제외하고는 회기중 국회의 동의없이 체포 또는 구금되지 아니한다. 국회는 정부의 동의없이 정부가 제출한 지출예산 각항의 금액을 증가하거나 새 비목을 설치할 수 없다. 모든 국민은 건강하고 쾌적한 환경에서 생활할 권리를 가지며, 국가와 국민은 환경보전을 위하여 노력하여야 한다.

대법관의 임기는 6년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다. 국교는 인정되지 아니하며, 종교와 정치는 분리된다. 모든 국민은 근로의 권리를 가진다. 국가는 사회적·경제적 방법으로 근로자의 고용의 증진과 적정임금의 보장에 노력하여야 하며, 법률이 정하는 바에 의하여 최저임금제를 시행하여야 한다. 정당의 설립은 자유이며, 복수정당제는 보장된다. 행정권은 대통령을 수반으로 하는 정부에 속한다. 대통령은 국무회의의 의장이 되고, 국무총리는 부의장이 된다. 공무원은 국민전체에 대한 봉사자이며, 국민에 대하여 책임을 진다. 사회적 특수계급의 제도는 인정되지 아니하며, 어떠한 형태로도 이를 창설할 수 없다.

대통령의 임기연장 또는 중임변경을 위한 헌법개정은 그 헌법개정 제안 당시의 대통령에 대하여는 효력이 없다. 대통령이 제1항의 기간내에 공포나 재의의 요구를 하지 아니한 때에도 그 법률안은 법률로서 확정된다. 정당의 목적이나 활동이 민주적 기본질서에 위배될 때에는 정부는 헌법재판소에 그 해산을 제소할 수 있고, 정당은 헌법재판소의 심판에 의하여 해산된다. 국회의 회의는 공개한다. 다만, 출석의원 과반수의 찬성이 있거나 의장이 국가의 안전보장을 위하여 필요하다고 인정할 때에는 공개하지 아니할 수 있다. 대법관은 대법원장의 제청으로 국회의 동의를 얻어 대통령이 임명한다. 국가는 청원에 대하여 심사할 의무를 진다.

위원은 탄핵 또는 금고 이상의 형의 선고에 의하지 아니하고는 파면되지 아니한다. 대한민국의 경제질서는 개인과 기업의 경제상의 자유와 창의를 존중함을 기본으로 한다. 국무회의는 대통령·국무총리와 15인 이상 30인 이하의 국무위원으로 구성한다. 대통령은 조약을 체결·비준하고, 외교사절을 신임·접수 또는 파견하며, 선전포고와 강화를 한다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 대통령이 궐위된 때 또는 대통령 당선자가 사망하거나 판결 기타의 사유로 그 자격을 상실한 때에는 60일 이내에 후임자를 선거한다. 국가는 재해를 예방하고 그 위험으로부터 국민을 보호하기 위하여 노력하여야 한다.
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
