-- SkillGap database (works in SQLite / MySQL / PostgreSQL)
-- Same data as data.js. Run this file, then try the queries at the bottom.

CREATE TABLE skills (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  weeks_per_level INTEGER,      -- weeks to go up one level
  docs_url TEXT,                -- official documentation
  focus_beginner TEXT,          -- what to study to reach each level
  focus_intermediate TEXT,
  focus_advanced TEXT
);

CREATE TABLE jobs (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  median_salary_lpa REAL,       -- approx. India, lakhs per year
  about TEXT,                   -- what the job involves
  tip TEXT                      -- portfolio / interview tip
);

CREATE TABLE job_skills (
  job_id TEXT REFERENCES jobs(id),
  skill_id TEXT REFERENCES skills(id),
  level_needed INTEGER,         -- 1 Beginner, 2 Intermediate, 3 Advanced
  weight INTEGER                -- 1 nice to have, 3 core
);

CREATE TABLE job_platforms (
  job_id TEXT REFERENCES jobs(id),
  platform TEXT
);

-- Accounts (for when you connect a real backend)
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,  -- never store the real password
  salt TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_skills (
  user_id INTEGER REFERENCES users(id),
  skill_id TEXT,                -- no foreign key, so custom skills are allowed
  level INTEGER                 -- 1 Beginner, 2 Intermediate, 3 Advanced
);

-- Skills
INSERT INTO skills VALUES ('html', 'HTML', 2, 'https://developer.mozilla.org/en-US/docs/Web/HTML', 'Tags, headings, links, images, forms', 'Semantic tags, accessibility basics, SEO meta tags', 'ARIA, performance, responsive images, web components');
INSERT INTO skills VALUES ('css', 'CSS', 3, 'https://developer.mozilla.org/en-US/docs/Web/CSS', 'Selectors, box model, colours, fonts', 'Flexbox, Grid, media queries, responsive layout', 'Animations, CSS variables, architecture (BEM), performance');
INSERT INTO skills VALUES ('javascript', 'JavaScript', 5, 'https://developer.mozilla.org/en-US/docs/Web/JavaScript', 'Variables, functions, loops, DOM basics', 'Async/await, fetch, ES6+ modules, array methods', 'Closures, event loop, testing, performance, design patterns');
INSERT INTO skills VALUES ('typescript', 'TypeScript', 3, 'https://www.typescriptlang.org/docs/', 'Basic types and interfaces', 'Generics, union types, typing React/Node code', 'Utility types, strict config, advanced type patterns');
INSERT INTO skills VALUES ('react', 'React', 4, 'https://react.dev/learn', 'Components, props, state, JSX', 'Hooks, routing, forms, calling APIs', 'State management, performance, testing, Next.js');
INSERT INTO skills VALUES ('nextjs', 'Next.js', 3, 'https://nextjs.org/docs', 'Pages, routing, layouts', 'Data fetching, server components, API routes', 'Caching, auth, deployment, performance');
INSERT INTO skills VALUES ('tailwind', 'Tailwind CSS', 2, 'https://tailwindcss.com/docs', 'Utility classes and layout', 'Responsive design, dark mode, reusable components', 'Custom config, plugins, design tokens');
INSERT INTO skills VALUES ('nodejs', 'Node.js', 4, 'https://nodejs.org/docs/latest/api/', 'Modules, npm, a simple HTTP server', 'Express, REST APIs, JWT auth, env config', 'Streams, clustering, testing, security, scaling');
INSERT INTO skills VALUES ('python', 'Python', 4, 'https://docs.python.org/3/', 'Syntax, data types, loops, functions', 'OOP, files, modules, virtual environments, libraries', 'Decorators, generators, testing, async, packaging');
INSERT INTO skills VALUES ('fastapi', 'FastAPI', 2, 'https://fastapi.tiangolo.com/', 'Routes and request/response models', 'Validation, databases, authentication', 'Async code, background tasks, testing, deployment');
INSERT INTO skills VALUES ('django', 'Django', 4, 'https://docs.djangoproject.com/', 'Models, views, templates', 'Forms, auth, Django REST framework', 'Caching, security, testing, deployment');
INSERT INTO skills VALUES ('sql', 'SQL', 3, 'https://www.postgresql.org/docs/current/sql.html', 'SELECT, WHERE, ORDER BY, basic INSERT/UPDATE', 'JOINs, GROUP BY, subqueries, table design', 'Window functions, indexes, query plans, transactions');
INSERT INTO skills VALUES ('mongodb', 'MongoDB', 3, 'https://www.mongodb.com/docs/', 'Documents, collections, CRUD', 'Queries, indexing, aggregation basics', 'Schema design, replication, performance tuning');
INSERT INTO skills VALUES ('git', 'Git', 1, 'https://git-scm.com/doc', 'init, add, commit, push, pull', 'Branches, merging, pull requests, fixing conflicts', 'Rebase, bisect, team workflows, clean history');
INSERT INTO skills VALUES ('cicd', 'GitHub Actions', 2, 'https://docs.github.com/actions', 'Workflow files, running tests on push', 'Caching, secrets, build matrices, deploy steps', 'Reusable workflows, security, self-hosted runners');
INSERT INTO skills VALUES ('docker', 'Docker', 3, 'https://docs.docker.com/', 'Images, containers, run/stop commands', 'Dockerfiles, volumes, docker compose', 'Multi-stage builds, networking, image security');
INSERT INTO skills VALUES ('kubernetes', 'Kubernetes', 5, 'https://kubernetes.io/docs/home/', 'Pods, deployments, services', 'ConfigMaps, secrets, ingress, scaling', 'Helm, monitoring, security, cluster operations');
INSERT INTO skills VALUES ('terraform', 'Terraform', 3, 'https://developer.hashicorp.com/terraform/docs', 'Providers, resources, plan/apply', 'Variables, modules, remote state', 'Workspaces, testing, large-team patterns');
INSERT INTO skills VALUES ('aws', 'AWS', 5, 'https://docs.aws.amazon.com/', 'Core services: EC2, S3, IAM', 'VPC, RDS, Lambda, load balancers', 'Cost control, security, architecture patterns, monitoring');
INSERT INTO skills VALUES ('linux', 'Linux', 3, 'https://man7.org/linux/man-pages/', 'Navigation, files, permissions, basic commands', 'Shell scripting, processes, services, SSH', 'Networking, performance tuning, security hardening');
INSERT INTO skills VALUES ('excel', 'Excel', 2, 'https://support.microsoft.com/excel', 'Formulas, sorting, filtering, charts', 'Pivot tables, XLOOKUP, conditional formatting', 'Power Query, dashboards, macros/VBA basics');
INSERT INTO skills VALUES ('powerbi', 'Power BI', 3, 'https://learn.microsoft.com/power-bi/', 'Importing data, basic visuals', 'Data modelling, relationships, DAX basics', 'Advanced DAX, performance, row-level security');
INSERT INTO skills VALUES ('tableau', 'Tableau', 3, 'https://help.tableau.com/current/pro/desktop/en-us/default.htm', 'Connecting data, basic charts', 'Calculated fields, filters, dashboards', 'LOD expressions, performance, data storytelling');
INSERT INTO skills VALUES ('numpy', 'NumPy', 2, 'https://numpy.org/doc/', 'Arrays, indexing, basic maths', 'Broadcasting, vectorised operations', 'Memory layout, performance, linear algebra');
INSERT INTO skills VALUES ('pandas', 'Pandas', 3, 'https://pandas.pydata.org/docs/', 'DataFrames, reading CSVs, selecting columns', 'Cleaning data, groupby, merging tables', 'Time series, performance, data pipelines');
INSERT INTO skills VALUES ('ml', 'Machine Learning', 6, 'https://scikit-learn.org/stable/user_guide.html', 'Regression, classification, train/test split', 'Model evaluation, feature engineering, scikit-learn pipelines', 'Hyperparameter tuning, deployment, MLOps, monitoring');
INSERT INTO skills VALUES ('pytorch', 'PyTorch', 5, 'https://pytorch.org/docs/stable/', 'Tensors, autograd, simple models', 'Training loops, datasets, CNNs', 'Custom layers, distributed training, deployment');
INSERT INTO skills VALUES ('java', 'Java', 6, 'https://docs.oracle.com/en/java/', 'Syntax, classes, collections', 'OOP design, streams, exceptions, Maven/Gradle', 'Concurrency, JVM tuning, Spring Boot, testing');
INSERT INTO skills VALUES ('cpp', 'C++', 6, 'https://en.cppreference.com/', 'Syntax, pointers, functions', 'OOP, STL, memory management', 'Templates, move semantics, concurrency, performance');
INSERT INTO skills VALUES ('csharp', 'C#', 5, 'https://learn.microsoft.com/dotnet/csharp/', 'Syntax, classes, collections', 'LINQ, async, .NET basics', 'Dependency injection, performance, ASP.NET Core');
INSERT INTO skills VALUES ('kotlin', 'Kotlin', 4, 'https://kotlinlang.org/docs/home.html', 'Syntax, null safety, classes', 'Coroutines, Android basics', 'Jetpack Compose, app architecture, testing');
INSERT INTO skills VALUES ('flutter', 'Flutter', 4, 'https://docs.flutter.dev/', 'Widgets, layouts, Dart basics', 'State management, navigation, APIs', 'Animations, performance, publishing to app stores');
INSERT INTO skills VALUES ('figma', 'Figma', 3, 'https://help.figma.com/', 'Frames, shapes, text, basic layout', 'Auto layout, components, prototyping', 'Design systems, variables, developer handoff');
INSERT INTO skills VALUES ('godot', 'Godot', 4, 'https://docs.godotengine.org/', 'Scenes, nodes, GDScript basics', 'Physics, signals, UI, animation', 'Shaders, optimization, exporting, multiplayer');
INSERT INTO skills VALUES ('unity', 'Unity', 5, 'https://docs.unity3d.com/Manual/index.html', 'Editor, GameObjects, C# scripts', 'Physics, prefabs, UI, animation', 'Optimization, shaders, architecture, publishing');
INSERT INTO skills VALUES ('blender', 'Blender', 5, 'https://docs.blender.org/manual/en/latest/', 'Interface and modelling basics', 'Materials, lighting, rendering, animation', 'Geometry nodes, simulation, compositing, pipelines');
INSERT INTO skills VALUES ('aftereffects', 'After Effects', 4, 'https://helpx.adobe.com/after-effects/user-guide.html', 'Layers, keyframes, basic effects', 'Masks, tracking, expressions', 'Compositing, 3D camera, automation');
INSERT INTO skills VALUES ('photoshop', 'Photoshop', 3, 'https://helpx.adobe.com/photoshop/user-guide.html', 'Layers, selections, basic edits', 'Masks, retouching, colour correction', 'Compositing, smart objects, automation');
INSERT INTO skills VALUES ('rust', 'Rust', 6, 'https://doc.rust-lang.org/book/', 'Ownership, borrowing, structs, enums', 'Traits, error handling, cargo, iterators', 'Lifetimes, async, unsafe code, performance');
INSERT INTO skills VALUES ('go', 'Go', 4, 'https://go.dev/doc/', 'Syntax, slices, maps, functions', 'Structs, interfaces, goroutines, HTTP servers', 'Concurrency patterns, testing, profiling, microservices');
INSERT INTO skills VALUES ('c', 'C', 6, 'https://en.cppreference.com/w/c', 'Syntax, pointers, arrays, functions', 'Memory allocation, structs, file I/O, Makefiles', 'Debugging with gdb, optimisation, system calls');
INSERT INTO skills VALUES ('php', 'PHP', 4, 'https://www.php.net/docs.php', 'Syntax, forms, arrays, functions', 'OOP, sessions, databases with PDO, Composer', 'Security, testing, performance, frameworks');
INSERT INTO skills VALUES ('ruby', 'Ruby', 4, 'https://www.ruby-lang.org/en/documentation/', 'Syntax, arrays, hashes, blocks', 'OOP, gems, Rails basics', 'Metaprogramming, testing, performance');
INSERT INTO skills VALUES ('swift', 'Swift', 5, 'https://www.swift.org/documentation/', 'Syntax, optionals, structs', 'SwiftUI, networking, Core Data', 'Concurrency, app architecture, App Store publishing');
INSERT INTO skills VALUES ('dart', 'Dart', 3, 'https://dart.dev/guides', 'Syntax, classes, collections', 'Async, streams, null safety', 'Isolates, packages, performance');
INSERT INTO skills VALUES ('r', 'R', 4, 'https://cran.r-project.org/manuals.html', 'Vectors, data frames, basic plots', 'dplyr, ggplot2, statistical tests', 'Modelling, R Markdown, Shiny apps');
INSERT INTO skills VALUES ('scala', 'Scala', 5, 'https://docs.scala-lang.org/', 'Syntax, case classes, collections', 'Functional style, pattern matching, sbt', 'Spark with Scala, concurrency, type system');
INSERT INTO skills VALUES ('lua', 'Lua', 3, 'https://www.lua.org/manual/5.4/', 'Syntax, tables, functions', 'Metatables, modules, coroutines', 'Embedding in games, performance, debugging');
INSERT INTO skills VALUES ('bash', 'Bash / Shell', 3, 'https://www.gnu.org/software/bash/manual/', 'Commands, variables, loops', 'Functions, pipes, text tools (grep, sed, awk)', 'Robust scripts, cron, error handling');
INSERT INTO skills VALUES ('matlab', 'MATLAB', 4, 'https://www.mathworks.com/help/matlab/', 'Matrices, plotting, scripts', 'Functions, toolboxes, data import', 'Simulink, optimisation, code generation');
INSERT INTO skills VALUES ('vue', 'Vue.js', 4, 'https://vuejs.org/guide/', 'Templates, reactivity, components', 'Router, Pinia state, composition API', 'Performance, testing, Nuxt, SSR');
INSERT INTO skills VALUES ('angular', 'Angular', 5, 'https://angular.dev/overview', 'Components, templates, modules', 'Services, routing, forms, RxJS basics', 'State (NgRx), testing, performance, SSR');
INSERT INTO skills VALUES ('svelte', 'Svelte', 3, 'https://svelte.dev/docs', 'Components, reactivity, props', 'Stores, routing with SvelteKit', 'SSR, transitions, performance');
INSERT INTO skills VALUES ('bootstrap', 'Bootstrap', 2, 'https://getbootstrap.com/docs/', 'Grid system, buttons, forms', 'Components, utilities, customising with Sass', 'Theming, accessibility, performance');
INSERT INTO skills VALUES ('springboot', 'Spring Boot', 5, 'https://docs.spring.io/spring-boot/', 'Project setup, controllers, REST basics', 'JPA, validation, security, config', 'Microservices, testing, monitoring, performance');
INSERT INTO skills VALUES ('laravel', 'Laravel', 4, 'https://laravel.com/docs', 'Routes, controllers, Blade views', 'Eloquent ORM, auth, migrations', 'Queues, testing, APIs, deployment');
INSERT INTO skills VALUES ('flask', 'Flask', 2, 'https://flask.palletsprojects.com/', 'Routes, templates, forms', 'Blueprints, databases, REST APIs', 'Testing, auth, deployment');
INSERT INTO skills VALUES ('graphql', 'GraphQL', 3, 'https://graphql.org/learn/', 'Queries, schemas, types', 'Mutations, resolvers, Apollo', 'Performance, caching, federation, security');
INSERT INTO skills VALUES ('mysql', 'MySQL', 3, 'https://dev.mysql.com/doc/', 'Install, create tables, basic queries', 'Indexes, joins, stored procedures', 'Replication, tuning, backups');
INSERT INTO skills VALUES ('postgresql', 'PostgreSQL', 3, 'https://www.postgresql.org/docs/', 'Install, tables, psql basics', 'Indexes, JSONB, transactions', 'Query tuning, replication, extensions');
INSERT INTO skills VALUES ('redis', 'Redis', 2, 'https://redis.io/docs/', 'Strings, hashes, expiry', 'Lists, sets, caching patterns', 'Persistence, clustering, pub/sub, performance');
INSERT INTO skills VALUES ('firebase', 'Firebase', 3, 'https://firebase.google.com/docs', 'Auth and Firestore basics', 'Security rules, storage, hosting', 'Cloud functions, analytics, scaling');
INSERT INTO skills VALUES ('spark', 'Apache Spark', 5, 'https://spark.apache.org/docs/latest/', 'DataFrames, reading files', 'Transformations, joins, Spark SQL', 'Tuning, streaming, cluster management');
INSERT INTO skills VALUES ('kafka', 'Apache Kafka', 4, 'https://kafka.apache.org/documentation/', 'Topics, producers, consumers', 'Partitions, consumer groups, schemas', 'Streams, reliability, scaling');
INSERT INTO skills VALUES ('airflow', 'Apache Airflow', 3, 'https://airflow.apache.org/docs/', 'DAGs, tasks, scheduling', 'Operators, sensors, connections', 'Dynamic DAGs, monitoring, scaling');
INSERT INTO skills VALUES ('snowflake', 'Snowflake', 3, 'https://docs.snowflake.com/', 'Warehouses, loading data, SQL', 'Stages, roles, semi-structured data', 'Performance, cost control, data sharing');
INSERT INTO skills VALUES ('azure', 'Microsoft Azure', 5, 'https://learn.microsoft.com/azure/', 'Core services: VMs, Storage, Entra ID', 'Networking, App Service, Functions', 'Security, monitoring, cost, architecture');
INSERT INTO skills VALUES ('gcp', 'Google Cloud', 5, 'https://cloud.google.com/docs', 'Core services: Compute Engine, Cloud Storage, IAM', 'VPC, Cloud Run, BigQuery', 'Security, monitoring, cost, architecture');
INSERT INTO skills VALUES ('ansible', 'Ansible', 3, 'https://docs.ansible.com/', 'Inventory, ad-hoc commands, playbooks', 'Roles, variables, templates', 'Vault, testing, large-scale automation');
INSERT INTO skills VALUES ('jenkins', 'Jenkins', 3, 'https://www.jenkins.io/doc/', 'Jobs and freestyle pipelines', 'Jenkinsfile, plugins, agents', 'Shared libraries, security, scaling');
INSERT INTO skills VALUES ('nginx', 'Nginx', 2, 'https://nginx.org/en/docs/', 'Installing, serving static files', 'Reverse proxy, SSL, load balancing', 'Caching, rate limiting, performance tuning');
INSERT INTO skills VALUES ('tensorflow', 'TensorFlow', 5, 'https://www.tensorflow.org/guide', 'Tensors, Keras basics', 'Training models, callbacks, datasets', 'Custom layers, TFLite, deployment');
INSERT INTO skills VALUES ('opencv', 'OpenCV', 4, 'https://docs.opencv.org/', 'Reading images, colours, drawing', 'Filters, edges, contours, video', 'Object detection, tracking, optimisation');
INSERT INTO skills VALUES ('genai', 'Generative AI / LLMs', 4, 'https://docs.claude.com/', 'Prompting, using LLM APIs', 'RAG, embeddings, tool use, evaluation', 'Agents, fine-tuning, safety, production monitoring');
INSERT INTO skills VALUES ('wordpress', 'WordPress', 3, 'https://wordpress.org/documentation/', 'Installing, themes, plugins', 'Custom themes, page builders, WooCommerce', 'Plugin development, security, performance');
INSERT INTO skills VALUES ('shopify', 'Shopify', 3, 'https://shopify.dev/docs', 'Setting up a store, products, themes', 'Liquid templates, apps, checkout basics', 'APIs, custom apps, performance');
INSERT INTO skills VALUES ('selenium', 'Selenium', 3, 'https://www.selenium.dev/documentation/', 'Locators, basic browser scripts', 'Waits, page objects, test frameworks', 'Parallel runs, CI, grid');
INSERT INTO skills VALUES ('cypress', 'Cypress', 2, 'https://docs.cypress.io/', 'Writing basic tests, selectors', 'Fixtures, network stubbing, custom commands', 'CI, parallelisation, component testing');
INSERT INTO skills VALUES ('postman', 'Postman', 1, 'https://learning.postman.com/docs/', 'Sending requests, collections', 'Environments, tests, variables', 'Automation, mock servers, CI runs');
INSERT INTO skills VALUES ('security', 'Cybersecurity (OWASP)', 5, 'https://owasp.org/www-project-top-ten/', 'OWASP Top 10, passwords, HTTPS', 'Injection, XSS, auth flaws, secure coding', 'Threat modelling, pen-testing basics, incident response');
INSERT INTO skills VALUES ('wireshark', 'Wireshark', 3, 'https://www.wireshark.org/docs/', 'Capturing packets, basic filters', 'Protocols (TCP, HTTP, DNS), display filters', 'Troubleshooting, traffic analysis, security');
INSERT INTO skills VALUES ('analytics', 'Google Analytics', 2, 'https://support.google.com/analytics', 'Setting up tracking, basic reports', 'Events, conversions, audiences', 'Attribution, dashboards, data export');
INSERT INTO skills VALUES ('illustrator', 'Adobe Illustrator', 4, 'https://helpx.adobe.com/illustrator/user-guide.html', 'Shapes, pen tool, colours', 'Typography, gradients, logo design', 'Brand systems, advanced vectors, automation');
INSERT INTO skills VALUES ('premiere', 'Adobe Premiere Pro', 3, 'https://helpx.adobe.com/premiere-pro/user-guide.html', 'Importing, cutting, exporting', 'Transitions, audio, colour basics', 'Advanced editing, workflows, motion graphics');
INSERT INTO skills VALUES ('lightroom', 'Adobe Lightroom', 2, 'https://helpx.adobe.com/lightroom-classic/user-guide.html', 'Importing, basic edits', 'Presets, masking, colour grading', 'Batch workflows, catalog management, retouching');
INSERT INTO skills VALUES ('davinci', 'DaVinci Resolve', 4, 'https://www.blackmagicdesign.com/products/davinciresolve/training', 'Cutting and exporting', 'Colour page, audio, effects', 'Advanced grading, Fusion, workflows');
INSERT INTO skills VALUES ('houdini', 'Houdini', 6, 'https://www.sidefx.com/docs/houdini/', 'Interface, nodes, basic modelling', 'Particles, VEX basics, simulations', 'Procedural pipelines, pyro/fluids, Python');
INSERT INTO skills VALUES ('nuke', 'Nuke', 5, 'https://learn.foundry.com/nuke/', 'Nodes, merges, keying', 'Tracking, roto, colour matching', '3D compositing, deep compositing, pipelines');
INSERT INTO skills VALUES ('unreal', 'Unreal Engine', 6, 'https://dev.epicgames.com/documentation/en-us/unreal-engine', 'Editor, Blueprints, levels', 'Materials, lighting, animation', 'C++, Niagara, optimisation, packaging');

-- Jobs
INSERT INTO jobs VALUES ('frontend', 'Frontend Developer', 6, 'Builds the parts of websites and apps that people see and click.', 'Have 3 deployed, responsive projects. Be ready to explain how you debug layout and state bugs.');
INSERT INTO jobs VALUES ('backend', 'Backend Developer', 7, 'Builds the servers, APIs and databases that sit behind apps.', 'Build one API with login and a database. Expect questions on REST, SQL joins and error handling.');
INSERT INTO jobs VALUES ('fullstack', 'Full Stack Developer', 8, 'Works on both the frontend and backend of a product.', 'One finished, deployed end-to-end app beats many small demos.');
INSERT INTO jobs VALUES ('analyst', 'Data Analyst', 5.5, 'Turns raw data into reports and answers for business teams.', 'Practise SQL problems and build a dashboard from a public dataset. Explain the insight, not just the chart.');
INSERT INTO jobs VALUES ('datasci', 'Data Scientist', 9, 'Finds patterns in data and builds models to guide decisions.', 'Show 2 end-to-end notebooks, each with a clear problem, method and result.');
INSERT INTO jobs VALUES ('mleng', 'Machine Learning Engineer', 10, 'Trains models and ships them into real products.', 'Deploy at least one model behind an API, since employers want it running, not just trained.');
INSERT INTO jobs VALUES ('gamedev', 'Game Developer (Godot)', 5, 'Builds game mechanics, levels and tools.', 'Publish 2 small finished games (itch.io) rather than one big unfinished one.');
INSERT INTO jobs VALUES ('unitydev', 'Game Developer (Unity)', 5.5, 'Builds games and interactive apps in Unity.', 'Ship a playable build with a short gameplay video, and keep the code tidy.');
INSERT INTO jobs VALUES ('uiux', 'UI/UX Designer', 5, 'Designs how apps look and feel, from research to prototypes.', 'Case studies matter: show the problem, your process and the result.');
INSERT INTO jobs VALUES ('devops', 'DevOps / Cloud Engineer', 9, 'Keeps software building, deploying and running reliably.', 'Show a project with a CI pipeline, Docker and a cloud deployment.');
INSERT INTO jobs VALUES ('mobile', 'Mobile App Developer', 7, 'Builds Android and iOS apps.', 'Publish one app (or an APK) and be ready to explain state management.');
INSERT INTO jobs VALUES ('javadev', 'Java Developer', 7, 'Builds large business software, often for banks and enterprises.', 'Expect OOP, collections and SQL questions; one Spring Boot project helps a lot.');
INSERT INTO jobs VALUES ('vfx', 'VFX / 3D Artist', 4.5, 'Creates visual effects, 3D assets and motion graphics.', 'A short polished showreel (60-90 sec) with breakdowns of how each shot was made.');
INSERT INTO jobs VALUES ('golang', 'Go Backend Developer', 9, 'Builds fast backend services and APIs, often for startups and cloud products.', 'Build a small concurrent service (e.g. a URL shortener) and explain how goroutines work.');
INSERT INTO jobs VALUES ('systems', 'Systems Programmer', 8, 'Writes low-level software such as drivers, tools and performance-critical code.', 'Be ready for pointer, memory and data-structure questions; show a small project in C or Rust.');
INSERT INTO jobs VALUES ('phpdev', 'PHP / WordPress Developer', 4.5, 'Builds and maintains websites and web apps with PHP and WordPress.', 'Show 2 live sites: one custom theme or plugin and one Laravel app.');
INSERT INTO jobs VALUES ('rubydev', 'Ruby Developer', 7, 'Builds web apps and APIs with Ruby, usually on Rails.', 'Ship one full Rails-style app with tests and explain your database design.');
INSERT INTO jobs VALUES ('ios', 'iOS Developer', 8, 'Builds apps for iPhone and iPad.', 'Publish or demo an app with networking and local storage; know SwiftUI state well.');
INSERT INTO jobs VALUES ('android', 'Android Developer', 7, 'Builds apps for Android phones and tablets.', 'Show an app using an API, a local database and a clean architecture.');
INSERT INTO jobs VALUES ('angulardev', 'Angular Developer', 7, 'Builds large web apps for companies using Angular and TypeScript.', 'Know components, services, RxJS and routing; build a CRUD dashboard.');
INSERT INTO jobs VALUES ('vuedev', 'Vue / Svelte Developer', 6.5, 'Builds modern interfaces with Vue or Svelte.', 'Build one app in each framework and compare them in your README.');
INSERT INTO jobs VALUES ('webdesign', 'Web Designer', 4.5, 'Designs and builds good-looking websites, often for small businesses.', 'Have 4-5 polished, responsive sites with before/after screenshots.');
INSERT INTO jobs VALUES ('springdev', 'Spring Boot Developer', 8, 'Builds enterprise backends and microservices with Java and Spring Boot.', 'Build a REST API with JPA and security; know dependency injection well.');
INSERT INTO jobs VALUES ('djangodev', 'Django Developer', 7, 'Builds full web apps and admin tools with Python and Django.', 'One deployed Django app with auth, a database and tests.');
INSERT INTO jobs VALUES ('pyapi', 'Python API Developer', 7.5, 'Builds lightweight Python APIs and services with Flask or FastAPI.', 'Build and document an API (OpenAPI) and deploy it.');
INSERT INTO jobs VALUES ('dataeng', 'Data Engineer', 11, 'Builds the pipelines and warehouses that move and store company data.', 'Build one pipeline end to end: ingest, transform, schedule, and store.');
INSERT INTO jobs VALUES ('stats', 'Statistical Analyst (R)', 6.5, 'Uses statistics and R to test ideas and explain results.', 'Show a report in R Markdown with clear methods and conclusions.');
INSERT INTO jobs VALUES ('simeng', 'Simulation / Embedded Engineer', 6, 'Models systems and writes low-level code for devices.', 'Show a simulation project with clear assumptions and results.');
INSERT INTO jobs VALUES ('azurecloud', 'Azure Cloud Engineer', 9, 'Builds and manages cloud systems on Microsoft Azure.', 'Deploy a small app on Azure with a pipeline; certifications (AZ-104) help.');
INSERT INTO jobs VALUES ('gcpcloud', 'Google Cloud Engineer', 9, 'Builds and manages cloud systems on Google Cloud.', 'Deploy a service on Cloud Run and use BigQuery in a project.');
INSERT INTO jobs VALUES ('sre', 'Site Reliability Engineer', 12, 'Keeps large systems fast, stable and recoverable.', 'Know Linux deeply and be ready to debug an outage out loud.');
INSERT INTO jobs VALUES ('release', 'Build & Release Engineer', 8, 'Automates how software is built, tested and released.', 'Show a Jenkins pipeline that builds, tests and deploys a project.');
INSERT INTO jobs VALUES ('genaieng', 'Generative AI Engineer', 12, 'Builds products on top of large language models.', 'Build a RAG app with evaluation, and explain where it fails.');
INSERT INTO jobs VALUES ('cveng', 'Computer Vision Engineer', 10, 'Builds software that understands images and video.', 'Show a detection or tracking project with a demo video.');
INSERT INTO jobs VALUES ('dba', 'Database Administrator', 7, 'Keeps company databases fast, safe and backed up.', 'Practise backups, indexing and slow-query fixes on a real dataset.');
INSERT INTO jobs VALUES ('apieng', 'API Engineer (GraphQL)', 8, 'Designs and builds the APIs other apps depend on.', 'Build a GraphQL API with auth and caching; document it clearly.');
INSERT INTO jobs VALUES ('qa', 'QA Automation Engineer', 6, 'Writes automated tests that catch bugs before users do.', 'Build a test framework from scratch and show reports.');
INSERT INTO jobs VALUES ('security', 'Cybersecurity Analyst', 8, 'Finds and fixes security weaknesses and watches for attacks.', 'Practise on legal labs (TryHackMe, HackTheBox) and write up what you learn.');
INSERT INTO jobs VALUES ('ecom', 'E-commerce Developer', 6, 'Builds and customises online stores.', 'Show a custom Shopify theme or app on a live store.');
INSERT INTO jobs VALUES ('marketing', 'Digital Marketing Analyst', 5, 'Tracks how websites and ads perform and suggests improvements.', 'Show a report where data led to a clear recommendation.');
INSERT INTO jobs VALUES ('graphic', 'Graphic Designer', 4, 'Creates logos, posters, social media and brand material.', 'A portfolio of 5-8 strong pieces, with the brief and result for each.');
INSERT INTO jobs VALUES ('videoed', 'Video Editor', 4, 'Edits films, ads and online videos.', 'A 2-minute showreel with different styles; show before/after colour work.');
INSERT INTO jobs VALUES ('photoed', 'Photo Editor / Retoucher', 3.5, 'Edits and retouches photos for brands, weddings and magazines.', 'Show before/after pairs and keep the editing natural.');
INSERT INTO jobs VALUES ('comp', 'VFX Compositor', 6, 'Blends live footage and effects into the final shot.', 'A short reel with breakdowns of each layer and node graph.');
INSERT INTO jobs VALUES ('fx', 'FX Technical Artist', 7, 'Builds simulations like fire, smoke and destruction for film and games.', 'Show procedural setups and explain how you control them.');
INSERT INTO jobs VALUES ('unrealdev', 'Game Developer (Unreal)', 7, 'Builds games and real-time experiences in Unreal Engine.', 'Show a playable level with polished lighting and a short gameplay video.');
INSERT INTO jobs VALUES ('luadev', 'Game Scripter (Lua)', 4.5, 'Writes gameplay scripts and mods in Lua for games and game tools.', 'Publish a small mod or game script with a short demo video and clean code.');

-- Skills each job needs
INSERT INTO job_skills VALUES ('frontend', 'html', 3, 2);
INSERT INTO job_skills VALUES ('frontend', 'css', 3, 2);
INSERT INTO job_skills VALUES ('frontend', 'javascript', 3, 3);
INSERT INTO job_skills VALUES ('frontend', 'react', 2, 3);
INSERT INTO job_skills VALUES ('frontend', 'git', 2, 1);
INSERT INTO job_skills VALUES ('backend', 'javascript', 3, 2);
INSERT INTO job_skills VALUES ('backend', 'nodejs', 3, 3);
INSERT INTO job_skills VALUES ('backend', 'sql', 3, 3);
INSERT INTO job_skills VALUES ('backend', 'git', 2, 1);
INSERT INTO job_skills VALUES ('backend', 'docker', 1, 1);
INSERT INTO job_skills VALUES ('fullstack', 'html', 2, 1);
INSERT INTO job_skills VALUES ('fullstack', 'css', 2, 1);
INSERT INTO job_skills VALUES ('fullstack', 'javascript', 3, 3);
INSERT INTO job_skills VALUES ('fullstack', 'react', 2, 2);
INSERT INTO job_skills VALUES ('fullstack', 'nodejs', 2, 2);
INSERT INTO job_skills VALUES ('fullstack', 'sql', 2, 2);
INSERT INTO job_skills VALUES ('fullstack', 'git', 2, 1);
INSERT INTO job_skills VALUES ('analyst', 'sql', 3, 3);
INSERT INTO job_skills VALUES ('analyst', 'excel', 2, 2);
INSERT INTO job_skills VALUES ('analyst', 'python', 2, 2);
INSERT INTO job_skills VALUES ('analyst', 'powerbi', 2, 2);
INSERT INTO job_skills VALUES ('datasci', 'python', 3, 3);
INSERT INTO job_skills VALUES ('datasci', 'pandas', 3, 3);
INSERT INTO job_skills VALUES ('datasci', 'numpy', 2, 2);
INSERT INTO job_skills VALUES ('datasci', 'sql', 2, 2);
INSERT INTO job_skills VALUES ('datasci', 'ml', 2, 3);
INSERT INTO job_skills VALUES ('mleng', 'python', 3, 3);
INSERT INTO job_skills VALUES ('mleng', 'ml', 3, 3);
INSERT INTO job_skills VALUES ('mleng', 'pytorch', 2, 2);
INSERT INTO job_skills VALUES ('mleng', 'pandas', 2, 2);
INSERT INTO job_skills VALUES ('mleng', 'git', 2, 1);
INSERT INTO job_skills VALUES ('mleng', 'docker', 1, 1);
INSERT INTO job_skills VALUES ('gamedev', 'godot', 3, 3);
INSERT INTO job_skills VALUES ('gamedev', 'cpp', 2, 2);
INSERT INTO job_skills VALUES ('gamedev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('unitydev', 'unity', 3, 3);
INSERT INTO job_skills VALUES ('unitydev', 'csharp', 3, 3);
INSERT INTO job_skills VALUES ('unitydev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('uiux', 'figma', 3, 3);
INSERT INTO job_skills VALUES ('uiux', 'html', 1, 1);
INSERT INTO job_skills VALUES ('uiux', 'css', 1, 1);
INSERT INTO job_skills VALUES ('devops', 'aws', 3, 3);
INSERT INTO job_skills VALUES ('devops', 'docker', 3, 3);
INSERT INTO job_skills VALUES ('devops', 'linux', 2, 2);
INSERT INTO job_skills VALUES ('devops', 'cicd', 2, 2);
INSERT INTO job_skills VALUES ('devops', 'git', 2, 1);
INSERT INTO job_skills VALUES ('devops', 'python', 1, 1);
INSERT INTO job_skills VALUES ('mobile', 'flutter', 3, 3);
INSERT INTO job_skills VALUES ('mobile', 'dart', 2, 2);
INSERT INTO job_skills VALUES ('mobile', 'git', 2, 1);
INSERT INTO job_skills VALUES ('mobile', 'sql', 1, 1);
INSERT INTO job_skills VALUES ('javadev', 'java', 3, 3);
INSERT INTO job_skills VALUES ('javadev', 'sql', 3, 2);
INSERT INTO job_skills VALUES ('javadev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('javadev', 'docker', 1, 1);
INSERT INTO job_skills VALUES ('vfx', 'blender', 3, 3);
INSERT INTO job_skills VALUES ('vfx', 'aftereffects', 3, 3);
INSERT INTO job_skills VALUES ('vfx', 'photoshop', 2, 1);
INSERT INTO job_skills VALUES ('golang', 'go', 3, 3);
INSERT INTO job_skills VALUES ('golang', 'postgresql', 2, 2);
INSERT INTO job_skills VALUES ('golang', 'docker', 2, 2);
INSERT INTO job_skills VALUES ('golang', 'redis', 1, 1);
INSERT INTO job_skills VALUES ('golang', 'git', 2, 1);
INSERT INTO job_skills VALUES ('systems', 'c', 3, 3);
INSERT INTO job_skills VALUES ('systems', 'cpp', 2, 2);
INSERT INTO job_skills VALUES ('systems', 'rust', 2, 2);
INSERT INTO job_skills VALUES ('systems', 'linux', 2, 2);
INSERT INTO job_skills VALUES ('systems', 'git', 2, 1);
INSERT INTO job_skills VALUES ('phpdev', 'php', 3, 3);
INSERT INTO job_skills VALUES ('phpdev', 'mysql', 2, 2);
INSERT INTO job_skills VALUES ('phpdev', 'laravel', 2, 2);
INSERT INTO job_skills VALUES ('phpdev', 'wordpress', 2, 1);
INSERT INTO job_skills VALUES ('phpdev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('rubydev', 'ruby', 3, 3);
INSERT INTO job_skills VALUES ('rubydev', 'sql', 2, 2);
INSERT INTO job_skills VALUES ('rubydev', 'html', 2, 1);
INSERT INTO job_skills VALUES ('rubydev', 'css', 2, 1);
INSERT INTO job_skills VALUES ('rubydev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('ios', 'swift', 3, 3);
INSERT INTO job_skills VALUES ('ios', 'firebase', 1, 1);
INSERT INTO job_skills VALUES ('ios', 'git', 2, 1);
INSERT INTO job_skills VALUES ('android', 'kotlin', 3, 3);
INSERT INTO job_skills VALUES ('android', 'java', 2, 2);
INSERT INTO job_skills VALUES ('android', 'firebase', 2, 1);
INSERT INTO job_skills VALUES ('android', 'git', 2, 1);
INSERT INTO job_skills VALUES ('angulardev', 'angular', 3, 3);
INSERT INTO job_skills VALUES ('angulardev', 'typescript', 3, 2);
INSERT INTO job_skills VALUES ('angulardev', 'html', 2, 1);
INSERT INTO job_skills VALUES ('angulardev', 'css', 2, 1);
INSERT INTO job_skills VALUES ('angulardev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('vuedev', 'vue', 3, 3);
INSERT INTO job_skills VALUES ('vuedev', 'svelte', 2, 2);
INSERT INTO job_skills VALUES ('vuedev', 'javascript', 3, 2);
INSERT INTO job_skills VALUES ('vuedev', 'css', 2, 1);
INSERT INTO job_skills VALUES ('vuedev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('webdesign', 'html', 3, 2);
INSERT INTO job_skills VALUES ('webdesign', 'css', 3, 2);
INSERT INTO job_skills VALUES ('webdesign', 'bootstrap', 2, 1);
INSERT INTO job_skills VALUES ('webdesign', 'tailwind', 2, 1);
INSERT INTO job_skills VALUES ('webdesign', 'javascript', 2, 2);
INSERT INTO job_skills VALUES ('webdesign', 'figma', 2, 1);
INSERT INTO job_skills VALUES ('springdev', 'java', 3, 3);
INSERT INTO job_skills VALUES ('springdev', 'springboot', 3, 3);
INSERT INTO job_skills VALUES ('springdev', 'mysql', 2, 2);
INSERT INTO job_skills VALUES ('springdev', 'docker', 1, 1);
INSERT INTO job_skills VALUES ('springdev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('djangodev', 'python', 3, 3);
INSERT INTO job_skills VALUES ('djangodev', 'django', 3, 3);
INSERT INTO job_skills VALUES ('djangodev', 'postgresql', 2, 2);
INSERT INTO job_skills VALUES ('djangodev', 'docker', 1, 1);
INSERT INTO job_skills VALUES ('djangodev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('pyapi', 'python', 3, 3);
INSERT INTO job_skills VALUES ('pyapi', 'fastapi', 2, 2);
INSERT INTO job_skills VALUES ('pyapi', 'flask', 2, 2);
INSERT INTO job_skills VALUES ('pyapi', 'sql', 2, 1);
INSERT INTO job_skills VALUES ('pyapi', 'git', 2, 1);
INSERT INTO job_skills VALUES ('dataeng', 'sql', 3, 3);
INSERT INTO job_skills VALUES ('dataeng', 'python', 3, 3);
INSERT INTO job_skills VALUES ('dataeng', 'spark', 2, 2);
INSERT INTO job_skills VALUES ('dataeng', 'airflow', 2, 2);
INSERT INTO job_skills VALUES ('dataeng', 'kafka', 1, 1);
INSERT INTO job_skills VALUES ('dataeng', 'snowflake', 1, 1);
INSERT INTO job_skills VALUES ('dataeng', 'scala', 1, 1);
INSERT INTO job_skills VALUES ('stats', 'r', 3, 3);
INSERT INTO job_skills VALUES ('stats', 'sql', 2, 2);
INSERT INTO job_skills VALUES ('stats', 'excel', 2, 1);
INSERT INTO job_skills VALUES ('stats', 'tableau', 2, 1);
INSERT INTO job_skills VALUES ('simeng', 'matlab', 3, 3);
INSERT INTO job_skills VALUES ('simeng', 'c', 3, 2);
INSERT INTO job_skills VALUES ('simeng', 'python', 2, 1);
INSERT INTO job_skills VALUES ('azurecloud', 'azure', 3, 3);
INSERT INTO job_skills VALUES ('azurecloud', 'terraform', 2, 2);
INSERT INTO job_skills VALUES ('azurecloud', 'docker', 2, 2);
INSERT INTO job_skills VALUES ('azurecloud', 'linux', 2, 1);
INSERT INTO job_skills VALUES ('azurecloud', 'git', 2, 1);
INSERT INTO job_skills VALUES ('gcpcloud', 'gcp', 3, 3);
INSERT INTO job_skills VALUES ('gcpcloud', 'terraform', 2, 2);
INSERT INTO job_skills VALUES ('gcpcloud', 'docker', 2, 2);
INSERT INTO job_skills VALUES ('gcpcloud', 'linux', 2, 1);
INSERT INTO job_skills VALUES ('gcpcloud', 'git', 2, 1);
INSERT INTO job_skills VALUES ('sre', 'kubernetes', 3, 3);
INSERT INTO job_skills VALUES ('sre', 'linux', 3, 3);
INSERT INTO job_skills VALUES ('sre', 'bash', 2, 2);
INSERT INTO job_skills VALUES ('sre', 'terraform', 2, 2);
INSERT INTO job_skills VALUES ('sre', 'git', 2, 1);
INSERT INTO job_skills VALUES ('release', 'jenkins', 3, 3);
INSERT INTO job_skills VALUES ('release', 'ansible', 2, 2);
INSERT INTO job_skills VALUES ('release', 'nginx', 2, 1);
INSERT INTO job_skills VALUES ('release', 'linux', 2, 2);
INSERT INTO job_skills VALUES ('release', 'bash', 2, 1);
INSERT INTO job_skills VALUES ('release', 'git', 2, 1);
INSERT INTO job_skills VALUES ('genaieng', 'python', 3, 3);
INSERT INTO job_skills VALUES ('genaieng', 'genai', 3, 3);
INSERT INTO job_skills VALUES ('genaieng', 'fastapi', 2, 1);
INSERT INTO job_skills VALUES ('genaieng', 'git', 2, 1);
INSERT INTO job_skills VALUES ('cveng', 'python', 3, 3);
INSERT INTO job_skills VALUES ('cveng', 'opencv', 3, 3);
INSERT INTO job_skills VALUES ('cveng', 'tensorflow', 2, 2);
INSERT INTO job_skills VALUES ('cveng', 'numpy', 2, 1);
INSERT INTO job_skills VALUES ('dba', 'mysql', 3, 3);
INSERT INTO job_skills VALUES ('dba', 'postgresql', 3, 3);
INSERT INTO job_skills VALUES ('dba', 'sql', 3, 2);
INSERT INTO job_skills VALUES ('dba', 'linux', 2, 1);
INSERT INTO job_skills VALUES ('dba', 'redis', 2, 1);
INSERT INTO job_skills VALUES ('apieng', 'graphql', 3, 3);
INSERT INTO job_skills VALUES ('apieng', 'nodejs', 3, 2);
INSERT INTO job_skills VALUES ('apieng', 'postman', 2, 2);
INSERT INTO job_skills VALUES ('apieng', 'typescript', 2, 1);
INSERT INTO job_skills VALUES ('apieng', 'git', 2, 1);
INSERT INTO job_skills VALUES ('qa', 'selenium', 3, 3);
INSERT INTO job_skills VALUES ('qa', 'cypress', 2, 2);
INSERT INTO job_skills VALUES ('qa', 'postman', 2, 2);
INSERT INTO job_skills VALUES ('qa', 'python', 2, 1);
INSERT INTO job_skills VALUES ('qa', 'git', 2, 1);
INSERT INTO job_skills VALUES ('security', 'security', 3, 3);
INSERT INTO job_skills VALUES ('security', 'wireshark', 3, 2);
INSERT INTO job_skills VALUES ('security', 'linux', 2, 2);
INSERT INTO job_skills VALUES ('security', 'python', 2, 1);
INSERT INTO job_skills VALUES ('ecom', 'shopify', 3, 3);
INSERT INTO job_skills VALUES ('ecom', 'html', 3, 1);
INSERT INTO job_skills VALUES ('ecom', 'css', 3, 1);
INSERT INTO job_skills VALUES ('ecom', 'javascript', 2, 2);
INSERT INTO job_skills VALUES ('marketing', 'analytics', 3, 3);
INSERT INTO job_skills VALUES ('marketing', 'excel', 2, 2);
INSERT INTO job_skills VALUES ('marketing', 'sql', 1, 1);
INSERT INTO job_skills VALUES ('graphic', 'photoshop', 3, 3);
INSERT INTO job_skills VALUES ('graphic', 'illustrator', 3, 3);
INSERT INTO job_skills VALUES ('graphic', 'figma', 1, 1);
INSERT INTO job_skills VALUES ('videoed', 'premiere', 3, 3);
INSERT INTO job_skills VALUES ('videoed', 'aftereffects', 2, 2);
INSERT INTO job_skills VALUES ('videoed', 'davinci', 2, 2);
INSERT INTO job_skills VALUES ('videoed', 'photoshop', 1, 1);
INSERT INTO job_skills VALUES ('photoed', 'lightroom', 3, 3);
INSERT INTO job_skills VALUES ('photoed', 'photoshop', 3, 2);
INSERT INTO job_skills VALUES ('comp', 'nuke', 3, 3);
INSERT INTO job_skills VALUES ('comp', 'aftereffects', 2, 2);
INSERT INTO job_skills VALUES ('comp', 'davinci', 2, 1);
INSERT INTO job_skills VALUES ('fx', 'houdini', 3, 3);
INSERT INTO job_skills VALUES ('fx', 'python', 2, 2);
INSERT INTO job_skills VALUES ('fx', 'blender', 2, 1);
INSERT INTO job_skills VALUES ('unrealdev', 'unreal', 3, 3);
INSERT INTO job_skills VALUES ('unrealdev', 'cpp', 3, 3);
INSERT INTO job_skills VALUES ('unrealdev', 'blender', 1, 1);
INSERT INTO job_skills VALUES ('unrealdev', 'git', 2, 1);
INSERT INTO job_skills VALUES ('fullstack', 'nextjs', 2, 1);
INSERT INTO job_skills VALUES ('fullstack', 'mongodb', 1, 1);
INSERT INTO job_skills VALUES ('luadev', 'lua', 3, 3);
INSERT INTO job_skills VALUES ('luadev', 'cpp', 1, 1);
INSERT INTO job_skills VALUES ('luadev', 'git', 2, 1);

-- Where to find each job
INSERT INTO job_platforms VALUES ('frontend', 'LinkedIn');
INSERT INTO job_platforms VALUES ('frontend', 'Naukri');
INSERT INTO job_platforms VALUES ('frontend', 'Wellfound');
INSERT INTO job_platforms VALUES ('backend', 'LinkedIn');
INSERT INTO job_platforms VALUES ('backend', 'Naukri');
INSERT INTO job_platforms VALUES ('backend', 'Indeed');
INSERT INTO job_platforms VALUES ('fullstack', 'LinkedIn');
INSERT INTO job_platforms VALUES ('fullstack', 'Naukri');
INSERT INTO job_platforms VALUES ('fullstack', 'Wellfound');
INSERT INTO job_platforms VALUES ('analyst', 'LinkedIn');
INSERT INTO job_platforms VALUES ('analyst', 'Naukri');
INSERT INTO job_platforms VALUES ('analyst', 'Internshala');
INSERT INTO job_platforms VALUES ('datasci', 'LinkedIn');
INSERT INTO job_platforms VALUES ('datasci', 'Naukri');
INSERT INTO job_platforms VALUES ('datasci', 'Wellfound');
INSERT INTO job_platforms VALUES ('mleng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('mleng', 'Wellfound');
INSERT INTO job_platforms VALUES ('mleng', 'Naukri');
INSERT INTO job_platforms VALUES ('gamedev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('gamedev', 'Naukri');
INSERT INTO job_platforms VALUES ('gamedev', 'Indeed');
INSERT INTO job_platforms VALUES ('unitydev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('unitydev', 'Naukri');
INSERT INTO job_platforms VALUES ('unitydev', 'Indeed');
INSERT INTO job_platforms VALUES ('uiux', 'LinkedIn');
INSERT INTO job_platforms VALUES ('uiux', 'Internshala');
INSERT INTO job_platforms VALUES ('uiux', 'Naukri');
INSERT INTO job_platforms VALUES ('devops', 'LinkedIn');
INSERT INTO job_platforms VALUES ('devops', 'Naukri');
INSERT INTO job_platforms VALUES ('devops', 'Indeed');
INSERT INTO job_platforms VALUES ('mobile', 'LinkedIn');
INSERT INTO job_platforms VALUES ('mobile', 'Naukri');
INSERT INTO job_platforms VALUES ('mobile', 'Wellfound');
INSERT INTO job_platforms VALUES ('javadev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('javadev', 'Naukri');
INSERT INTO job_platforms VALUES ('javadev', 'Indeed');
INSERT INTO job_platforms VALUES ('vfx', 'LinkedIn');
INSERT INTO job_platforms VALUES ('vfx', 'Naukri');
INSERT INTO job_platforms VALUES ('vfx', 'Behance');
INSERT INTO job_platforms VALUES ('golang', 'LinkedIn');
INSERT INTO job_platforms VALUES ('golang', 'Wellfound');
INSERT INTO job_platforms VALUES ('golang', 'Naukri');
INSERT INTO job_platforms VALUES ('systems', 'LinkedIn');
INSERT INTO job_platforms VALUES ('systems', 'Naukri');
INSERT INTO job_platforms VALUES ('systems', 'Indeed');
INSERT INTO job_platforms VALUES ('phpdev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('phpdev', 'Naukri');
INSERT INTO job_platforms VALUES ('phpdev', 'Internshala');
INSERT INTO job_platforms VALUES ('rubydev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('rubydev', 'Wellfound');
INSERT INTO job_platforms VALUES ('rubydev', 'Naukri');
INSERT INTO job_platforms VALUES ('ios', 'LinkedIn');
INSERT INTO job_platforms VALUES ('ios', 'Naukri');
INSERT INTO job_platforms VALUES ('ios', 'Indeed');
INSERT INTO job_platforms VALUES ('android', 'LinkedIn');
INSERT INTO job_platforms VALUES ('android', 'Naukri');
INSERT INTO job_platforms VALUES ('android', 'Indeed');
INSERT INTO job_platforms VALUES ('angulardev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('angulardev', 'Naukri');
INSERT INTO job_platforms VALUES ('angulardev', 'Indeed');
INSERT INTO job_platforms VALUES ('vuedev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('vuedev', 'Wellfound');
INSERT INTO job_platforms VALUES ('vuedev', 'Naukri');
INSERT INTO job_platforms VALUES ('webdesign', 'LinkedIn');
INSERT INTO job_platforms VALUES ('webdesign', 'Naukri');
INSERT INTO job_platforms VALUES ('webdesign', 'Internshala');
INSERT INTO job_platforms VALUES ('springdev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('springdev', 'Naukri');
INSERT INTO job_platforms VALUES ('springdev', 'Indeed');
INSERT INTO job_platforms VALUES ('djangodev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('djangodev', 'Wellfound');
INSERT INTO job_platforms VALUES ('djangodev', 'Naukri');
INSERT INTO job_platforms VALUES ('pyapi', 'LinkedIn');
INSERT INTO job_platforms VALUES ('pyapi', 'Wellfound');
INSERT INTO job_platforms VALUES ('pyapi', 'Naukri');
INSERT INTO job_platforms VALUES ('dataeng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('dataeng', 'Wellfound');
INSERT INTO job_platforms VALUES ('dataeng', 'Naukri');
INSERT INTO job_platforms VALUES ('stats', 'LinkedIn');
INSERT INTO job_platforms VALUES ('stats', 'Indeed');
INSERT INTO job_platforms VALUES ('stats', 'Naukri');
INSERT INTO job_platforms VALUES ('simeng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('simeng', 'Naukri');
INSERT INTO job_platforms VALUES ('simeng', 'Indeed');
INSERT INTO job_platforms VALUES ('azurecloud', 'LinkedIn');
INSERT INTO job_platforms VALUES ('azurecloud', 'Naukri');
INSERT INTO job_platforms VALUES ('azurecloud', 'Indeed');
INSERT INTO job_platforms VALUES ('gcpcloud', 'LinkedIn');
INSERT INTO job_platforms VALUES ('gcpcloud', 'Naukri');
INSERT INTO job_platforms VALUES ('gcpcloud', 'Indeed');
INSERT INTO job_platforms VALUES ('sre', 'LinkedIn');
INSERT INTO job_platforms VALUES ('sre', 'Naukri');
INSERT INTO job_platforms VALUES ('sre', 'Indeed');
INSERT INTO job_platforms VALUES ('release', 'LinkedIn');
INSERT INTO job_platforms VALUES ('release', 'Naukri');
INSERT INTO job_platforms VALUES ('release', 'Indeed');
INSERT INTO job_platforms VALUES ('genaieng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('genaieng', 'Wellfound');
INSERT INTO job_platforms VALUES ('genaieng', 'Naukri');
INSERT INTO job_platforms VALUES ('cveng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('cveng', 'Wellfound');
INSERT INTO job_platforms VALUES ('cveng', 'Naukri');
INSERT INTO job_platforms VALUES ('dba', 'LinkedIn');
INSERT INTO job_platforms VALUES ('dba', 'Naukri');
INSERT INTO job_platforms VALUES ('dba', 'Indeed');
INSERT INTO job_platforms VALUES ('apieng', 'LinkedIn');
INSERT INTO job_platforms VALUES ('apieng', 'Wellfound');
INSERT INTO job_platforms VALUES ('apieng', 'Naukri');
INSERT INTO job_platforms VALUES ('qa', 'LinkedIn');
INSERT INTO job_platforms VALUES ('qa', 'Naukri');
INSERT INTO job_platforms VALUES ('qa', 'Internshala');
INSERT INTO job_platforms VALUES ('security', 'LinkedIn');
INSERT INTO job_platforms VALUES ('security', 'Naukri');
INSERT INTO job_platforms VALUES ('security', 'Indeed');
INSERT INTO job_platforms VALUES ('ecom', 'LinkedIn');
INSERT INTO job_platforms VALUES ('ecom', 'Naukri');
INSERT INTO job_platforms VALUES ('ecom', 'Internshala');
INSERT INTO job_platforms VALUES ('marketing', 'LinkedIn');
INSERT INTO job_platforms VALUES ('marketing', 'Naukri');
INSERT INTO job_platforms VALUES ('marketing', 'Internshala');
INSERT INTO job_platforms VALUES ('graphic', 'LinkedIn');
INSERT INTO job_platforms VALUES ('graphic', 'Naukri');
INSERT INTO job_platforms VALUES ('graphic', 'Behance');
INSERT INTO job_platforms VALUES ('videoed', 'LinkedIn');
INSERT INTO job_platforms VALUES ('videoed', 'Naukri');
INSERT INTO job_platforms VALUES ('videoed', 'Behance');
INSERT INTO job_platforms VALUES ('photoed', 'LinkedIn');
INSERT INTO job_platforms VALUES ('photoed', 'Naukri');
INSERT INTO job_platforms VALUES ('photoed', 'Behance');
INSERT INTO job_platforms VALUES ('comp', 'LinkedIn');
INSERT INTO job_platforms VALUES ('comp', 'Naukri');
INSERT INTO job_platforms VALUES ('comp', 'Behance');
INSERT INTO job_platforms VALUES ('fx', 'LinkedIn');
INSERT INTO job_platforms VALUES ('fx', 'Naukri');
INSERT INTO job_platforms VALUES ('fx', 'Behance');
INSERT INTO job_platforms VALUES ('unrealdev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('unrealdev', 'Naukri');
INSERT INTO job_platforms VALUES ('unrealdev', 'Indeed');
INSERT INTO job_platforms VALUES ('luadev', 'LinkedIn');
INSERT INTO job_platforms VALUES ('luadev', 'Naukri');
INSERT INTO job_platforms VALUES ('luadev', 'Indeed');

-- ---------- Example queries ----------

-- 1. Which jobs need SQL, and how important is it?
SELECT j.title, js.level_needed, js.weight
FROM jobs j JOIN job_skills js ON j.id = js.job_id
WHERE js.skill_id = 'sql' ORDER BY js.weight DESC;

-- 2. Highest paying jobs first
SELECT title, median_salary_lpa FROM jobs ORDER BY median_salary_lpa DESC;

-- 3. Skills for one job, with docs links
SELECT s.name, js.level_needed, s.docs_url
FROM job_skills js JOIN skills s ON s.id = js.skill_id
WHERE js.job_id = 'backend';

-- 4. Skills that open the most jobs
SELECT s.name, COUNT(*) AS jobs_using_it
FROM job_skills js JOIN skills s ON s.id = js.skill_id
GROUP BY s.name ORDER BY jobs_using_it DESC;

-- 5. All skills saved by one user (user 1)
SELECT skill_id, level FROM user_skills WHERE user_id = 1;