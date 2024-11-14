---
name: Achievement request
about: Suggest a new achievement
title: 'achievements: '
labels: achievements, enhancement
assignees: ''

---

- **Description**: 
  - Write why you want the achievement etc.

`{{X}}` - a number like `2`
`{{DIFFICULTY}} - `easy`, `medium`, `hard`

- **Title**: 
  - "Correctly answer `{{X}}` `{{DIFFICULTY}}` questions in a row"

- **Conditional Logic**: 
  `{{DIFFICULTY}}MaxCorrectAnswersStreak >= {{X}}`
