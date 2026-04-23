# LeanCut Coach

LeanCut Coach is a native SwiftUI iPhone app that:

- reads the current date and weekday from the device,
- shows the workout and meal plan for today,
- includes a full weekly workout split,
- includes a simple Indian meal plan for each day,
- frames the cut as a gradual move from roughly 30% body fat toward 12%.

## What Is Inside

- `LeanCutCoach.xcodeproj`: open this on a Mac in Xcode.
- `LeanCutCoach/LeanCutCoachApp.swift`: app entry point.
- `LeanCutCoach/ContentView.swift`: Today, Week, and Guide tabs.
- `LeanCutCoach/Models.swift`: workout, meal, and profile models.
- `LeanCutCoach/PlanStore.swift`: built-in weekly workout and diet data.
- `LeanCutCoach/Theme.swift`: app colors and visual theme.

## Open It In Xcode

1. Copy or open the `ios-app/LeanCutCoach` folder on a Mac.
2. Open `LeanCutCoach.xcodeproj`.
3. In Signing & Capabilities, choose your Apple team and adjust the bundle identifier if needed.
4. Run on an iPhone simulator or device.

## Health Framing

The plan is intentionally conservative and is built around widely used public-health guardrails:

- steady weight loss instead of crash dieting,
- regular strength training plus weekly cardio,
- simple balanced Indian meals built around protein, vegetables, and controlled starch servings.

This is still a template, not medical treatment. If you have existing health conditions, medication, or significant joint pain, personalize it with a qualified clinician or sports dietitian before pushing aggressively toward 12% body fat.
