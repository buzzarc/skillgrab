# skillgrab
# skillgrab

# SkillGap – Skill Gap & Employment Predictor

## About the Project

**SkillGap** is a simple web-based platform that helps students identify suitable job roles based on their existing skills and proficiency levels. It compares their skills with job requirements, identifies missing skills, and suggests learning resources to help them prepare for their desired careers.

The platform also provides estimated learning timelines, alternative career options, and a downloadable PDF report.

## Problem Statement

Students often learn different technical skills but struggle to understand which jobs they are suitable for and what additional skills they need to develop.

SkillGap aims to solve this problem by connecting a student's current skills with relevant career opportunities and providing a clear learning path.

## Key Features

* **Skill Selection:** Choose from 89 predefined skills or add custom skills.
* **Skill Levels:** Set proficiency levels as Beginner, Intermediate, or Advanced.
* **Job Matching:** Find suitable job roles based on existing skills.
* **Skill Gap Analysis:** Identify missing skills and areas that need improvement.
* **Learning Roadmap:** Get learning suggestions, official documentation links, and estimated preparation time.
* **Career Insights:** Explore alternative job roles and understand how different skills relate to careers.
* **Salary Estimates:** View estimated median salaries for supported job roles.
* **Job Platforms:** Find platforms where you can search for relevant job opportunities.
* **PDF Report:** Generate and download a report containing career matches and skill-gap information.
* **Login and Sign Up:** Use the account interface to save skills in the browser.

## How It Works

1. The user enters their skills and selects their proficiency levels.
2. The website compares the entered skills with the requirements of 47 job roles.
3. A scoring formula calculates and ranks the most suitable jobs.
4. The results display matching careers, missing skills, and learning recommendations.
5. The user can explore alternative careers and download a PDF report.

## Technologies Used

* **HTML5** – Structures the website.
* **CSS3** – Handles styling and layout.
* **JavaScript** – Implements skill matching, scoring, and interactive features.
* **SQL** – Defines the database structure for users, skills, and job requirements.
* **jsPDF** – Generates downloadable PDF reports.
* **Web Crypto API** – Supports password-hashing functionality in the browser.

The project uses plain HTML, CSS, and JavaScript without frontend frameworks, keeping the implementation simple and easy to understand.

## Project Structure

```text
SkillGap/
├── index.html
├── style.css
├── script.js
├── auth.js
├── data.js
└── database.sql
```

* `index.html` – Main website structure.
* `style.css` – Website design and styling.
* `script.js` – Skill matching and application logic.
* `auth.js` – Login and sign-up functionality.
* `data.js` – Skills, job roles, and their requirements.
* `database.sql` – Database schema.

## Getting Started

1. Clone or download this repository.
2. Open the project folder in your code editor.
3. Open `index.html` in a web browser or run it using VS Code Live Server.
4. Add your skills and proficiency levels to explore suitable career options.

## Limitations

* Job matching is based on a predefined scoring formula rather than a trained machine-learning model.
* Salary figures and learning timelines are estimates.
* Job requirements and learning resources depend on the available project data.
* Login and saved skills currently rely on browser-side functionality and are not backed by a production database.

## Future Improvements

* Integrate a backend and a live database.
* Include updated job listings and salary information.
* Improve career predictions using real employment data.
* Add resume upload and automatic skill extraction.
* Provide more personalized learning recommendations.

## Conclusion

SkillGap helps students understand how their current skills align with potential careers and what they can learn to improve their opportunities. It brings skill assessment, career matching, learning recommendations, and PDF reporting together in one simple website.

---

**Project:** SkillGap – Skill Gap & Employment Predictor
**Developed by:** Add team member names and roll numbers
**Project Guide:** Add guide name
**Department/Class:** Add department and class
