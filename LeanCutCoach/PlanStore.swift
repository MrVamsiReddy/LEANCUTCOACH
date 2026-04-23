import Foundation

struct PlanStore {
    let calendar: Calendar
    let profile: CoachProfile
    let weeklyPlans: [DailyPlan]

    init(calendar: Calendar = .current) {
        self.calendar = calendar
        self.profile = CoachProfile(
            currentBodyFat: 30,
            targetBodyFat: 12,
            paceNote: "Aim for a steady 0.4 to 0.8 kg loss per week. Going from 30% to 12% body fat usually takes multiple phases, not one crash diet.",
            medicalNote: "This template is for generally healthy adults. If you have diabetes, blood pressure issues, joint pain, sleep apnea, or use medication that affects weight or blood sugar, get a clinician's sign-off before pushing the cut.",
            habits: [
                HabitTarget(title: "Protein Anchor", detail: "Build every meal around paneer, curd, eggs, chicken, fish, tofu, dal, or chana."),
                HabitTarget(title: "Daily Steps", detail: "Keep 8,000 to 10,000 steps as the default fat-loss baseline."),
                HabitTarget(title: "Hydration", detail: "Drink 2.5 to 3.5 liters of water and include buttermilk or lemon water when helpful."),
                HabitTarget(title: "Sleep", detail: "Protect 7.5 to 8.5 hours. Recovery matters when calories are lower.")
            ],
            phases: [
                PhaseCheckpoint(title: "Phase 1: 30% to 22%", detail: "Lock in lifting form, meal timing, and step consistency for 10 to 14 weeks."),
                PhaseCheckpoint(title: "Phase 2: 22% to 16%", detail: "Keep protein high, tighten snack choices, and add a little more cardio only if progress stalls."),
                PhaseCheckpoint(title: "Phase 3: 16% to 12%", detail: "Use smaller calorie cuts, keep stress low, and avoid trying to rush the final lean-out.")
            ],
            kitchenShortcuts: [
                "Cook one dal and one protein twice a week so lunch and dinner stay easy.",
                "Keep curd, roasted chana, makhana, fruit, and salad vegetables ready to grab.",
                "On lifting days, keep one main carb serving around training. On lighter days, reduce that carb serving only if fat loss stalls for 2 full weeks.",
                "Use simple flavoring: ginger, garlic, jeera, chilli, haldi, dhania, lemon, and curd-based marinades."
            ]
        )

        self.weeklyPlans = [
            DailyPlan(
                weekday: .monday,
                focus: "Upper Body Strength",
                duration: "65 to 75 min",
                warmup: [
                    "5 min brisk walk or cycle",
                    "Band pull-aparts x 20",
                    "Scap push-ups x 10"
                ],
                exercises: [
                    Exercise(name: "Incline dumbbell or machine press", prescription: "4 x 8 to 10", coachingCue: "Leave 1 to 2 reps in the tank."),
                    Exercise(name: "One-arm dumbbell row", prescription: "4 x 10 each side", coachingCue: "Pull elbow toward hip, not shoulder."),
                    Exercise(name: "Seated shoulder press", prescription: "3 x 8 to 10", coachingCue: "Control the lowering phase."),
                    Exercise(name: "Lat pulldown or assisted pull-up", prescription: "3 x 10 to 12", coachingCue: "Pause briefly at the bottom."),
                    Exercise(name: "Front plank", prescription: "3 x 40 sec", coachingCue: "Ribs down and glutes tight.")
                ],
                finisher: "10 to 12 min incline walk",
                stepTarget: "9,000 to 10,000 steps",
                hydration: "3.0 L water",
                sleep: "7.5 to 8.5 h",
                nutritionFocus: "Use a moderate carb day: breakfast and lunch can carry the main starch servings around training.",
                coachingNote: "Good form and a calm calorie deficit beat random hard workouts.",
                meals: [
                    Meal(slot: "Breakfast", menu: "2 to 3 moong chillas stuffed with paneer, plus curd", prepHint: "Soak and blend batter the night before.", swapNote: "Swap paneer with egg bhurji if you want a non-veg option."),
                    Meal(slot: "Lunch", menu: "2 rotis, chicken breast or paneer bhurji, cucumber salad", prepHint: "Keep lunch oil light and salad large.", swapNote: "To stay vegetarian, keep paneer and add extra dal."),
                    Meal(slot: "Snack", menu: "Buttermilk and roasted chana", prepHint: "Portable and easy for work hours.", swapNote: "Use a whey shake if you miss protein earlier in the day."),
                    Meal(slot: "Dinner", menu: "Dal tadka, beans-carrot sabzi, grilled fish or tofu", prepHint: "Keep dinner lighter than lunch but still protein-first.", swapNote: "If fully vegetarian, use tofu or extra dal plus paneer.")
                ]
            ),
            DailyPlan(
                weekday: .tuesday,
                focus: "Lower Body Strength",
                duration: "65 to 75 min",
                warmup: [
                    "5 min bike",
                    "Hip openers x 8 each side",
                    "Bodyweight squats x 12"
                ],
                exercises: [
                    Exercise(name: "Goblet squat or leg press", prescription: "4 x 8 to 10", coachingCue: "Drive through full foot."),
                    Exercise(name: "Romanian deadlift", prescription: "4 x 8 to 10", coachingCue: "Hips back, soft knees, flat back."),
                    Exercise(name: "Walking lunges", prescription: "3 x 12 each leg", coachingCue: "Keep torso tall."),
                    Exercise(name: "Leg curl", prescription: "3 x 12", coachingCue: "Control the squeeze."),
                    Exercise(name: "Hanging knee raise", prescription: "3 x 12", coachingCue: "Move slowly, no swinging.")
                ],
                finisher: "8 to 10 min easy cycle cool-down",
                stepTarget: "8,500 to 10,000 steps",
                hydration: "3.0 L water",
                sleep: "7.5 to 8.5 h",
                nutritionFocus: "Keep rice or roti near lunch or post-workout. Do not let late-night snacking erase the day.",
                coachingNote: "Lower-body days create fatigue fast while cutting, so stop before form breaks.",
                meals: [
                    Meal(slot: "Breakfast", menu: "Oats cooked in milk with chia and whey, or oats with 3 eggs on the side", prepHint: "Use cinnamon and fruit instead of sugary toppings.", swapNote: "If you prefer savory, switch to oats upma with eggs or tofu."),
                    Meal(slot: "Lunch", menu: "1 cup rice, rajma, grilled chicken or paneer, salad", prepHint: "Keep rajma thick and filling so cravings stay lower.", swapNote: "If fully veg, use paneer and rajma together."),
                    Meal(slot: "Snack", menu: "Apple and thick curd", prepHint: "Choose plain curd, not sweetened cups.", swapNote: "Greek yogurt or chaas plus peanuts also works."),
                    Meal(slot: "Dinner", menu: "Palak paneer or chicken, 2 small rotis, stir-fried veg", prepHint: "Prioritize the sabzi volume.", swapNote: "For a lighter dinner, drop one roti and add more veg.")
                ]
            ),
            DailyPlan(
                weekday: .wednesday,
                focus: "Conditioning + Core",
                duration: "45 to 55 min",
                warmup: [
                    "5 min brisk walk",
                    "Thoracic rotations x 8 each side",
                    "Glute bridges x 15"
                ],
                exercises: [
                    Exercise(name: "Kettlebell or dumbbell goblet squat", prescription: "3 x 12", coachingCue: "Smooth reps, no grinding."),
                    Exercise(name: "Push-up incline variation", prescription: "3 x 10 to 15", coachingCue: "Keep body in one line."),
                    Exercise(name: "Step-up", prescription: "3 x 12 each side", coachingCue: "Drive through the front leg."),
                    Exercise(name: "Dead bug", prescription: "3 x 12 each side", coachingCue: "Lower back stays gently pressed down."),
                    Exercise(name: "Brisk walk or bike intervals", prescription: "20 min", coachingCue: "You should feel worked, not destroyed.")
                ],
                finisher: "5 min easy walk and deep breathing",
                stepTarget: "10,000 steps",
                hydration: "2.8 to 3.2 L water",
                sleep: "8 h target",
                nutritionFocus: "Use a slightly lighter carb day. Keep vegetables and protein high so hunger stays manageable.",
                coachingNote: "This day keeps calorie burn up without beating your joints.",
                meals: [
                    Meal(slot: "Breakfast", menu: "Veg omelette or tofu scramble, plus one fruit", prepHint: "Cook with onion, tomato, and spinach.", swapNote: "Paneer bhurji works if eggs are not your thing."),
                    Meal(slot: "Lunch", menu: "Moong dal khichdi, curd, kachumber salad", prepHint: "Keep the ghee minimal while cutting.", swapNote: "Add grilled chicken on the side if you want more protein."),
                    Meal(slot: "Snack", menu: "Sprouts chaat with onion, tomato, lemon", prepHint: "Add chaat masala lightly to control sodium.", swapNote: "Roasted chana and chaas is the faster version."),
                    Meal(slot: "Dinner", menu: "Clear chicken soup or dal soup, sauteed veg, paneer cubes", prepHint: "Make dinner easy to digest and light.", swapNote: "If hunger is high, add one small roti.")
                ]
            ),
            DailyPlan(
                weekday: .thursday,
                focus: "Upper Body Hypertrophy",
                duration: "60 to 70 min",
                warmup: [
                    "5 min rower or walk",
                    "Band external rotations x 15",
                    "Arm circles x 20"
                ],
                exercises: [
                    Exercise(name: "Machine chest press", prescription: "3 x 10 to 12", coachingCue: "Smooth tempo, full range."),
                    Exercise(name: "Cable or machine row", prescription: "3 x 10 to 12", coachingCue: "Squeeze shoulder blades together."),
                    Exercise(name: "Lateral raise", prescription: "3 x 15", coachingCue: "Use lighter weights and cleaner reps."),
                    Exercise(name: "Face pull", prescription: "3 x 15", coachingCue: "Elbows high, neck relaxed."),
                    Exercise(name: "Hammer curl + rope pushdown", prescription: "3 rounds of 12 each", coachingCue: "Short rests, but stay controlled.")
                ],
                finisher: "12 min incline walk",
                stepTarget: "9,000 to 10,000 steps",
                hydration: "3.0 L water",
                sleep: "7.5 to 8.5 h",
                nutritionFocus: "Another moderate carb day. Use lunch as the biggest meal if you train before evening.",
                coachingNote: "Pump work helps you hold muscle while body fat drops.",
                meals: [
                    Meal(slot: "Breakfast", menu: "Overnight oats with curd, seeds, and fruit", prepHint: "Add whey only if you need extra protein.", swapNote: "Switch to paneer toast on whole wheat if you prefer warm food."),
                    Meal(slot: "Lunch", menu: "2 rotis, chana masala, paneer tikka, salad", prepHint: "Keep paneer grilled, not heavy with cream.", swapNote: "Swap paneer tikka for chicken tikka if desired."),
                    Meal(slot: "Snack", menu: "Unsweetened lassi and a small handful of peanuts", prepHint: "Measure peanuts so calories stay under control.", swapNote: "Makhana roasted in minimal ghee also works."),
                    Meal(slot: "Dinner", menu: "Egg curry or tofu curry, lauki or tori sabzi, half cup rice", prepHint: "Use rice strategically, not automatically.", swapNote: "If you trained late and feel hungry, add one roti instead.")
                ]
            ),
            DailyPlan(
                weekday: .friday,
                focus: "Lower Body + Posterior Chain",
                duration: "60 to 70 min",
                warmup: [
                    "5 min brisk walk",
                    "Hamstring sweeps x 10",
                    "Mini-band lateral walks x 12 each side"
                ],
                exercises: [
                    Exercise(name: "Trap-bar deadlift or rack pull", prescription: "4 x 6 to 8", coachingCue: "Heavy but technically clean."),
                    Exercise(name: "Bulgarian split squat", prescription: "3 x 10 each leg", coachingCue: "Stay balanced and upright."),
                    Exercise(name: "Hip thrust", prescription: "3 x 10 to 12", coachingCue: "Pause at the top."),
                    Exercise(name: "Leg extension", prescription: "3 x 12 to 15", coachingCue: "Control both directions."),
                    Exercise(name: "Side plank", prescription: "3 x 30 sec each side", coachingCue: "Stack shoulders and hips.")
                ],
                finisher: "10 min easy spin or walk",
                stepTarget: "8,500 to 9,500 steps",
                hydration: "3.0 L water",
                sleep: "8 h target",
                nutritionFocus: "Keep carbs around lunch or after training, then finish the day with a protein-heavy dinner.",
                coachingNote: "Posterior-chain strength supports a better-looking cut and stronger posture.",
                meals: [
                    Meal(slot: "Breakfast", menu: "Poha with peas, plus 3 boiled eggs or tofu", prepHint: "Keep poha portion controlled and protein generous.", swapNote: "Paneer poha is the vegetarian high-protein version."),
                    Meal(slot: "Lunch", menu: "Rice, sambar, paneer or chicken, veg poriyal", prepHint: "This is a solid South Indian-style cut meal when portions are planned.", swapNote: "If appetite is low, reduce rice and keep sambar and protein high."),
                    Meal(slot: "Snack", menu: "Milk or whey shake and roasted makhana", prepHint: "This works well when you get home tired.", swapNote: "Curd with cinnamon is another easy option."),
                    Meal(slot: "Dinner", menu: "Chicken keema or soya granules roll, salad, curd", prepHint: "Use whole-wheat roti as the wrap base.", swapNote: "Skip the wrap and eat it as a bowl if calories need tightening.")
                ]
            ),
            DailyPlan(
                weekday: .saturday,
                focus: "Full Body Circuit + Outdoor Cardio",
                duration: "50 to 65 min",
                warmup: [
                    "5 min easy walk",
                    "Dynamic lunges x 8 each side",
                    "Shoulder reaches x 10"
                ],
                exercises: [
                    Exercise(name: "Circuit: squat, push-up, row", prescription: "4 rounds of 10 each", coachingCue: "Move steadily, rest 60 sec between rounds."),
                    Exercise(name: "Farmer carry", prescription: "4 x 40 sec", coachingCue: "Walk tall and breathe normally."),
                    Exercise(name: "Reverse lunge", prescription: "3 x 12 each side", coachingCue: "Keep front knee tracking over toes."),
                    Exercise(name: "Mountain climber", prescription: "3 x 30 sec", coachingCue: "Fast feet, stable shoulders."),
                    Exercise(name: "Outdoor walk", prescription: "20 to 30 min", coachingCue: "Low stress, conversational pace.")
                ],
                finisher: "Stretch calves, hips, chest for 5 min",
                stepTarget: "10,000 to 12,000 steps",
                hydration: "3.0 to 3.5 L water",
                sleep: "7.5 to 8.5 h",
                nutritionFocus: "Keep the meals simple and planned. Weekends often break the cut more than weekdays.",
                coachingNote: "This is the high-movement day, not a junk-food reward day.",
                meals: [
                    Meal(slot: "Breakfast", menu: "3 idlis, sambar, and 2 eggs or paneer cubes", prepHint: "Let the protein side make the meal cut-friendly.", swapNote: "A dosa works too, but keep oil moderate."),
                    Meal(slot: "Lunch", menu: "Homemade whole-wheat wrap with chicken or paneer and lots of salad", prepHint: "Pack it before leaving home if your day gets busy.", swapNote: "Turn it into a bowl if wraps trigger overeating."),
                    Meal(slot: "Snack", menu: "Fruit and black chana chaat", prepHint: "Keep this ready before weekend cravings hit.", swapNote: "Buttermilk and roasted chana is the faster version."),
                    Meal(slot: "Dinner", menu: "Fish curry or tofu curry, veg, 1 cup rice", prepHint: "Enjoy a proper home-style dinner but hold the second serving.", swapNote: "If weight loss slows, cut the rice to half cup.")
                ]
            ),
            DailyPlan(
                weekday: .sunday,
                focus: "Recovery, Mobility, and Meal Prep",
                duration: "35 to 45 min",
                warmup: [
                    "10 min easy walk",
                    "Cat-cow x 10",
                    "Ankle and hip mobility x 5 each side"
                ],
                exercises: [
                    Exercise(name: "Mobility flow", prescription: "15 min", coachingCue: "Move smoothly and breathe through each position."),
                    Exercise(name: "Bird dog", prescription: "3 x 10 each side", coachingCue: "Stay stable through the trunk."),
                    Exercise(name: "Bodyweight squat", prescription: "3 x 15", coachingCue: "Use this as movement, not a max-effort set."),
                    Exercise(name: "Long walk", prescription: "25 to 35 min", coachingCue: "Easy pace, low stress."),
                    Exercise(name: "Meal prep block", prescription: "45 min in the kitchen", coachingCue: "Cook once to make the week easier.")
                ],
                finisher: "5 min nasal breathing and light stretching",
                stepTarget: "8,000 to 10,000 steps",
                hydration: "2.8 to 3.2 L water",
                sleep: "8 h target",
                nutritionFocus: "Keep meals clean and predictable so Monday starts strong. No all-day cheat meals.",
                coachingNote: "Recovery days protect your joints, consistency, and next week's momentum.",
                meals: [
                    Meal(slot: "Breakfast", menu: "Besan chilla, curd, and one fruit", prepHint: "Add chopped spinach or onion to increase volume.", swapNote: "If you want more protein, add paneer to the filling."),
                    Meal(slot: "Lunch", menu: "Home-style chicken curry or rajma, salad, 1 cup rice", prepHint: "Enjoy the family meal, just measure the rice once.", swapNote: "If lunch becomes heavy, keep dinner very light."),
                    Meal(slot: "Snack", menu: "Buttermilk and peanuts", prepHint: "Simple snacks prevent random weekend nibbling.", swapNote: "Roasted chana is a lower-calorie swap."),
                    Meal(slot: "Dinner", menu: "Paneer bhurji or dal soup, sauteed veg, 1 small roti", prepHint: "Finish the week with a light, protein-led meal.", swapNote: "Skip the roti if lunch ran large.")
                ]
            )
        ]
    }

    func weekday(for date: Date) -> Weekday {
        Weekday(rawValue: calendar.component(.weekday, from: date)) ?? .monday
    }

    func plan(for date: Date) -> DailyPlan {
        let targetWeekday = weekday(for: date)
        return weeklyPlans.first(where: { $0.weekday == targetWeekday }) ?? weeklyPlans[0]
    }

    func weeklyPlansMondayFirst() -> [DailyPlan] {
        Weekday.mondayFirst.compactMap { day in
            weeklyPlans.first(where: { $0.weekday == day })
        }
    }

    func formattedToday(for date: Date) -> String {
        date.formatted(.dateTime.weekday(.wide).month(.wide).day().year())
    }

    func compactDate(for date: Date) -> String {
        date.formatted(.dateTime.month(.abbreviated).day())
    }
}
