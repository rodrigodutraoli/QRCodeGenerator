
import Foundation
import UIKit

public struct QRCodeGenerator {
    let logo: UIImage?
    let payload: String
    let backgroundColor: CIColor
    let color: CIColor
    let size: CGSize
    let correctionLevel: CorrectionLevel
    
    public init(logo: UIImage? = nil, payload: String, backgroundColor: CIColor, color: CIColor, size: CGSize, correctionLevel: CorrectionLevel = .M) {
        self.logo = logo
        self.payload = payload
        self.backgroundColor = backgroundColor
        self.color = color
        self.size = size
        self.correctionLevel = correctionLevel
    }
    
    public func getQRImage() -> UIImage? {
        guard var image  = createCIImage() else { return nil}
        
        ///scale to width:height
        let scaleW = self.size.width/image.extent.size.width
        let scaleH = self.size.height/image.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleW, y: scaleH)
        image = image.transformed(by: transform)
        
        if let logo = logo, let newImage =  addLogo(image: image, logo: logo) {
            image = newImage
        }
        
        if let colorImgae = updateColor(image: image) {
            image = colorImgae
        }
        
        return UIImage(ciImage: image)
    }
    
    private func updateColor(image: CIImage) -> CIImage? {
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setValue(image, forKey: kCIInputImageKey)
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")
        return colorFilter.outputImage
    }
    
    private func addLogo(image: CIImage, logo: UIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        guard let logo = logo.cgImage else {
            return image
        }
        
        let ciLogo = CIImage(cgImage: logo)
        
        
        let centerTransform = CGAffineTransform(translationX: image.extent.midX - (ciLogo.extent.size.width / 2), y: image.extent.midY - (ciLogo.extent.size.height / 2))
        
        combinedFilter.setValue(ciLogo.transformed(by: centerTransform), forKey: "inputImage")
        combinedFilter.setValue(image, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage
    }
    
    private func createCIImage() -> CIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(payload.data(using: String.Encoding.ascii), forKey: "inputMessage")
        filter.setValue(correctionLevel.rawValue, forKey: "inputCorrectionLevel")
        //https://www.qrcode.com/en/about/error_correction.html
        return filter.outputImage
    }
}

extension QRCodeGenerator {
    public enum CorrectionLevel: String {
        // Level L (Low)    7% of data bytes can be restored.
        case L
        // Level M (Medium)    15% of data bytes can be restored.
        case M
        // Level Q (Quartile)    25% of data bytes can be restored.
        case Q
        // Level H (High)    30% of data bytes can be restored.
        case H
    }
}
