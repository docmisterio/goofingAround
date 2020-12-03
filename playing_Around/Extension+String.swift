import Foundation

extension String {
    func durationInFeet(_ duration: String) -> String {
        let currentDuration = Double(duration)
        return String(currentDuration! * currentDuration! * 16)
    }

    func durationInMeters(_ duration: String) -> String {
        let myDuration = Double(duration)
        return String(myDuration! * myDuration! * 16 * 0.3)
    }
}
