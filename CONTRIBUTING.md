# Contributing to Triviology

Thank you for considering contributing to Triviology! Here are some guidelines to help you get started.

## Table of Contents

- [Project Structure](#project-structure)
- [How to Contribute](#how-to-contribute)
- [Suggested Software](#suggested-software)
- [Suggested Extensions](#suggested-extensions)
- [Code Style](#code-style)
- [Setting Up the Development Environment](#setting-up-the-development-environment)
- [Submitting Changes](#submitting-changes)
- [Reporting Issues](#reporting-issues)
- [License](#license)

## Project Structure

- `lib/`: Contains the main source code for the app.
  - `main.dart`: Entry point of the application.
  - `navigation_widget.dart`: Handles navigation between pages.
  - `settings_page.dart`: Page where users can customize their experience.
  - `stats_page.dart`: Page displaying user statistics.
  - `achievements_page.dart`: Page displaying user achievements.
  - `download_page.dart`: Page where users can download other databases/datasets of questions.
  - `home_page.dart`: Home page of the application.
  - `quiz_page.dart`: Page where users can take quizzes.
  - `quiz_settings_page.dart`: Page where users can choose quiz settings.
  - `quiz_summary_page.dart`: Page displaying quiz results.
- `assets/`: Contains images, fonts, and other assets.
- `test/`: Contains unit and widget tests.

Every code file starts with a description too.

## How to Contribute

1. **Fork the repository**: Click the "Fork" button at the top right of the repository page.
2. **Clone your fork**: `git clone https://github.com/your-username/triviology.git`
3. **Create a branch**: `git checkout -b your-feature-branch`
4. **Make your changes**: Implement your feature or fix.
5. **Commit your changes**: `git commit -m 'Add some feature'`
6. **Push to the branch**: `git push origin your-feature-branch`
7. **Create a Pull Request**: Open a pull request on the original repository.

## Suggested Software

We recommend using the following software for development:

- **VSCode/VSCodium**: A powerful and lightweight code editor.

## Suggested Extensions

Here are some suggested extensions to enhance your development experience:

- [Better Comments by Aaron Bond](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments): This extension helps you create more human-friendly comments in your code. It allows you to categorize your annotations into alerts, queries, TODOs, and highlights, making it easier to understand and maintain your code.
- [Error Lens by Alexander](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens): This extension highlights errors and warnings directly in the code, making it easier to spot and fix issues quickly.
- [Flutter by Dart Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter): Provides a rich set of Flutter-specific functionalities, including debugging, IntelliSense, and more.
- [Dart by Dart Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code): Offers comprehensive support for the Dart programming language, including code completion, debugging, and more.
- [GitHub Theme by GitHub](https://marketplace.visualstudio.com/items?itemName=GitHub.github-vscode-theme): Provides a beautiful and consistent theme for your VSCode, inspired by GitHub's design.
- [Material Icon Theme by Philipp Kief](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme): Provides a comprehensive set of icons for various file types and folders, making it easier to navigate and manage your project files.

Feel free to suggest more extensions.

## Code Style

- Follow the Dart style guide: [Effective Dart](https://dart.dev/guides/language/effective-dart).
- Write meaningful commit messages.

## Setting Up the Development Environment

1. Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
2. Clone the repository: `git clone https://github.com/yourusername/triviology.git`
3. Navigate to the project directory: `cd triviology`
4. Get the dependencies: `flutter pub get`

## Submitting Changes

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Create a pull request.

## Reporting Issues

- Use the GitHub issues page to report bugs or request features.
- Provide as much detail as possible, including steps to reproduce the issue.

## License

By contributing, you agree that your contributions will be licensed under the GNU General Public License v3.0. See `LICENSE`.
