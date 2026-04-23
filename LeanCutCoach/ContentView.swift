import SwiftUI

struct ContentView: View {
    let store: PlanStore

    @State private var selectedTab: AppTab = .today

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayDashboard(store: store)
                .tabItem {
                    Label("Today", systemImage: "sun.max.fill")
                }
                .tag(AppTab.today)

            WeekPlannerView(store: store)
                .tabItem {
                    Label("Week", systemImage: "calendar")
                }
                .tag(AppTab.week)

            GuideView(store: store)
                .tabItem {
                    Label("Guide", systemImage: "figure.strengthtraining.traditional")
                }
                .tag(AppTab.guide)
        }
        .tint(Palette.accent)
    }
}

private enum AppTab: Hashable {
    case today
    case week
    case guide
}

private struct TodayDashboard: View {
    let store: PlanStore

    @State private var revealCards = false

    var body: some View {
        TimelineView(.periodic(from: .now, by: 60)) { context in
            let plan = store.plan(for: context.date)

            ZStack {
                AppBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HeroCard(store: store, plan: plan, date: context.date)

                        SectionShell(title: "Today's Workout", subtitle: "\(plan.focus) • \(plan.duration)") {
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Warm-up")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Palette.textPrimary)

                                ForEach(plan.warmup, id: \.self) { drill in
                                    BulletText(text: drill)
                                }

                                Divider()
                                    .overlay(Palette.stroke)

                                Text("Main Work")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Palette.textPrimary)

                                ForEach(plan.exercises) { exercise in
                                    WorkoutRow(exercise: exercise)
                                }

                                Divider()
                                    .overlay(Palette.stroke)

                                HighlightStrip(label: "Finisher", value: plan.finisher)
                                HighlightStrip(label: "Coach Cue", value: plan.coachingNote)
                            }
                        }

                        SectionShell(title: "Today's Meals", subtitle: plan.nutritionFocus) {
                            VStack(spacing: 12) {
                                ForEach(plan.meals) { meal in
                                    MealRow(meal: meal)
                                }
                            }
                        }

                        SectionShell(title: "Recovery Targets", subtitle: "The boring stuff is what makes the cut work.") {
                            VStack(spacing: 12) {
                                SmallMetric(title: "Steps", value: plan.stepTarget, icon: "figure.walk")
                                SmallMetric(title: "Hydration", value: plan.hydration, icon: "drop.fill")
                                SmallMetric(title: "Sleep", value: plan.sleep, icon: "moon.stars.fill")
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                    .opacity(revealCards ? 1 : 0)
                    .offset(y: revealCards ? 0 : 22)
                }
                .scrollIndicators(.hidden)
            }
            .onAppear {
                if !revealCards {
                    withAnimation(.spring(response: 0.75, dampingFraction: 0.88)) {
                        revealCards = true
                    }
                }
            }
        }
    }
}

private struct WeekPlannerView: View {
    let store: PlanStore

    var body: some View {
        let today = store.weekday(for: Date())

        ZStack {
            AppBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weekly Cut Planner")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(Palette.textPrimary)

                        Text("Every day has a clear workout focus and a simple Indian meal pattern, so you never have to guess what comes next.")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(Palette.textSecondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    ForEach(store.weeklyPlansMondayFirst()) { plan in
                        WeeklyPlanCard(plan: plan, isToday: plan.weekday == today)
                            .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 32)
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct GuideView: View {
    let store: PlanStore

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SectionShell(
                        title: "Goal Frame",
                        subtitle: "Current template: \(store.profile.currentBodyFat)% body fat to \(store.profile.targetBodyFat)%"
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(store.profile.paceNote)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(Palette.textPrimary)

                            HStack(spacing: 10) {
                                StatChip(label: "Start", value: "\(store.profile.currentBodyFat)%")
                                StatChip(label: "Goal", value: "\(store.profile.targetBodyFat)%")
                                StatChip(label: "Focus", value: "Slow Cut")
                            }
                        }
                    }

                    SectionShell(title: "Fat-Loss Phases", subtitle: "Think in phases so the final stretch does not become reckless.") {
                        VStack(spacing: 12) {
                            ForEach(store.profile.phases) { phase in
                                PhaseRow(phase: phase)
                            }
                        }
                    }

                    SectionShell(title: "Non-Negotiables", subtitle: "These habits matter more than fancy supplements.") {
                        VStack(spacing: 12) {
                            ForEach(store.profile.habits) { habit in
                                HabitRow(habit: habit)
                            }
                        }
                    }

                    SectionShell(title: "Simple Indian Prep", subtitle: "Keep the food local, filling, and realistic for busy days.") {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(store.profile.kitchenShortcuts, id: \.self) { shortcut in
                                BulletText(text: shortcut)
                            }
                        }
                    }

                    SectionShell(title: "Safety Note", subtitle: "Important before getting aggressive with the cut.") {
                        Text(store.profile.medicalNote)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(Palette.textPrimary)
                    }
                }
                .padding(20)
                .padding(.bottom, 32)
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct HeroCard: View {
    let store: PlanStore
    let plan: DailyPlan
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("LeanCut Coach")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(Palette.accentSoft)

                    Text(plan.weekday.title)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(Palette.textPrimary)

                    Text(store.formattedToday(for: date))
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                Image(systemName: "flame.fill")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Palette.accent)
                    .padding(14)
                    .background(Circle().fill(Palette.chip))
            }

            Text(plan.focus)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)

            Text("Today's goal is not to suffer. It is to train hard enough to keep muscle, eat simply, and repeat tomorrow.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    StatChip(label: "Current", value: "\(store.profile.currentBodyFat)%")
                    StatChip(label: "Target", value: "\(store.profile.targetBodyFat)%")
                    StatChip(label: "Session", value: plan.duration)
                }
            }
        }
        .padding(22)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Palette.card, Palette.card.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Palette.stroke, lineWidth: 1)
        )
    }
}

private struct WeeklyPlanCard: View {
    let plan: DailyPlan
    let isToday: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.weekday.title)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Palette.textPrimary)

                    Text("\(plan.focus) • \(plan.duration)")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                if isToday {
                    Text("Today")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(Palette.backgroundTop)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Palette.accent))
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Workout")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Palette.textPrimary)

                ForEach(plan.exercises) { exercise in
                    BulletText(text: "\(exercise.name) • \(exercise.prescription)")
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Meals")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Palette.textPrimary)

                ForEach(plan.meals) { meal in
                    BulletText(text: "\(meal.slot): \(meal.menu)")
                }
            }

            HighlightStrip(label: "Daily Focus", value: plan.nutritionFocus)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Palette.card)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(isToday ? Palette.accent.opacity(0.7) : Palette.stroke, lineWidth: 1)
        )
    }
}

private struct SectionShell<Content: View>: View {
    let title: String
    let subtitle: String
    let content: Content

    init(title: String, subtitle: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Palette.textPrimary)

                Text(subtitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Palette.textSecondary)
            }

            content
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Palette.card)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(Palette.stroke, lineWidth: 1)
        )
    }
}

private struct WorkoutRow: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(exercise.name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Palette.textPrimary)

                Spacer()

                Text(exercise.prescription)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(Palette.accentSoft)
            }

            Text(exercise.coachingCue)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct MealRow: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(meal.slot.uppercased())
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(Palette.accentSoft)

                Spacer()
            }

            Text(meal.menu)
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)

            Text("Prep: \(meal.prepHint)")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)

            Text("Swap: \(meal.swapNote)")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct HabitRow: View {
    let habit: HabitTarget

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(habit.title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)

            Text(habit.detail)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct PhaseRow: View {
    let phase: PhaseCheckpoint

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(phase.title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)

            Text(phase.detail)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct StatChip: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.textSecondary)

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(Palette.chip)
        )
    }
}

private struct SmallMetric: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Palette.accent)
                .frame(width: 34, height: 34)
                .background(Circle().fill(Palette.chip))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(Palette.textPrimary)

                Text(value)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Palette.textSecondary)
            }

            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct HighlightStrip: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label.uppercased())
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundStyle(Palette.accentSoft)

            Text(value)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(Palette.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Palette.chip)
        )
    }
}

private struct BulletText: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(Palette.accent)
                .frame(width: 7, height: 7)
                .padding(.top, 6)

            Text(text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(Palette.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct AppBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Palette.backgroundTop, Palette.backgroundBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(Palette.accent.opacity(0.22))
                .frame(width: 240, height: 240)
                .blur(radius: 28)
                .offset(x: -140, y: -260)

            Circle()
                .fill(Palette.success.opacity(0.18))
                .frame(width: 220, height: 220)
                .blur(radius: 32)
                .offset(x: 150, y: 260)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView(store: PlanStore())
}
