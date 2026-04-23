import Foundation

enum Weekday: Int, CaseIterable, Identifiable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }

    var shortTitle: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }

    static var mondayFirst: [Weekday] {
        [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
}

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let prescription: String
    let coachingCue: String
}

struct Meal: Identifiable {
    let id = UUID()
    let slot: String
    let menu: String
    let prepHint: String
    let swapNote: String
}

struct DailyPlan: Identifiable {
    var id: Weekday { weekday }

    let weekday: Weekday
    let focus: String
    let duration: String
    let warmup: [String]
    let exercises: [Exercise]
    let finisher: String
    let stepTarget: String
    let hydration: String
    let sleep: String
    let nutritionFocus: String
    let coachingNote: String
    let meals: [Meal]
}

struct HabitTarget: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

struct PhaseCheckpoint: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

struct CoachProfile {
    let currentBodyFat: Int
    let targetBodyFat: Int
    let paceNote: String
    let medicalNote: String
    let habits: [HabitTarget]
    let phases: [PhaseCheckpoint]
    let kitchenShortcuts: [String]
}
