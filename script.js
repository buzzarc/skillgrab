// ---------- Setup ----------
const levelNames = ["None", "Beginner", "Intermediate", "Advanced"];
const importanceNames = ["", "Nice to have", "Important", "Core skill"];

let mySkills = {};          // example: { sql: 2, python: 1 }
let customNames = {};       // names of skills that are not in data.js
let selectedJobId = null;   // job shown in the big card

// Grab page elements
const skillInput = document.getElementById("skillInput");
const levelSelect = document.getElementById("levelSelect");
const skillList = document.getElementById("skillList");
const results = document.getElementById("results");
const emptyMsg = document.getElementById("emptyMsg");

// Numbers shown on the home page
document.getElementById("statSkills").textContent = skills.length;
document.getElementById("statJobs").textContent = jobs.length;

// Each account gets its own saved skills (currentUser is set in auth.js)
function storageKey(name) {
  return name + ":" + currentUser.email;
}

function loadUserData() {
  mySkills = {};
  customNames = {};
  selectedJobId = null;
  try {
    const savedSkills = localStorage.getItem(storageKey("mySkills"));
    const savedNames = localStorage.getItem(storageKey("customNames"));
    if (savedSkills) mySkills = JSON.parse(savedSkills);
    if (savedNames) customNames = JSON.parse(savedNames);
  } catch (e) { /* storage not available, start empty */ }
}

// Called by auth.js after a successful login
function startApp() {
  loadUserData();
  update();
}

// ---------- Helpers ----------
// Stops typed text from breaking the page
function esc(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
}

// Find a skill by id. Skills typed by the user get a simple "custom" object.
function getSkill(id) {
  const found = skills.find(function (s) { return s.id === id; });
  if (found) return found;
  return { id: id, name: customNames[id], docs: null, weeks: 4, focus: null, custom: true };
}

function levelOptions(selected) {
  let html = "";
  for (let i = 1; i <= 3; i++) {
    html += `<option value="${i}" ${i === selected ? "selected" : ""}>${levelNames[i]}</option>`;
  }
  return html;
}

// Draws the score as flip-clock style digit boxes
function flipDigits(n) {
  return String(n).split("").map(function (d) { return "<span>" + d + "</span>"; }).join("") +
    '<span class="flip-red">%</span>';
}

// Match score (0-95). Important skills count more.
function scoreJob(job) {
  let got = 0, total = 0;
  job.needs.forEach(function (n) {
    const have = mySkills[n.skill] || 0;
    total += n.weight;
    got += n.weight * Math.min(have / n.level, 1);
  });
  return Math.round((got / total) * 95);   // 95 max: nothing is guaranteed
}

// Skills the user still needs for a job, most important first
function getGaps(job) {
  const gaps = [];
  job.needs.forEach(function (n) {
    const have = mySkills[n.skill] || 0;
    if (have < n.level) {
      const skill = getSkill(n.skill);
      gaps.push({ skill: skill, have: have, need: n.level, weight: n.weight, weeks: (n.level - have) * skill.weeks });
    }
  });
  return gaps.sort(function (a, b) { return b.weight - a.weight; });
}

// What to study to go from one level to another
function focusPath(skill, from, to) {
  const steps = [];
  for (let lv = from; lv < to; lv++) {
    steps.push(levelNames[lv + 1] + ": " + skill.focus[lv]);
  }
  return steps;
}

// All jobs, best match first
function rankJobs() {
  return jobs
    .map(function (j) { return { job: j, score: scoreJob(j) }; })
    .sort(function (a, b) { return b.score - a.score; });
}

function totalWeeks(gaps) {
  return gaps.reduce(function (sum, g) { return sum + g.weeks; }, 0);
}

// Feature 3: for one of the user's skills, which jobs use it and what to focus on next
function skillInsight(id) {
  const have = mySkills[id];
  const skill = getSkill(id);

  const usedIn = jobs
    .filter(function (j) { return j.needs.some(function (n) { return n.skill === id; }); })
    .map(function (j) {
      const need = j.needs.find(function (n) { return n.skill === id; });
      return { job: j, level: need.level, weight: need.weight, score: scoreJob(j) };
    })
    .sort(function (a, b) { return b.score - a.score; });

  let focus;
  if (skill.custom) focus = "This skill is not in our database, so we can't match jobs or give focus tips. Check its official docs.";
  else if (have >= 3) focus = "You're at the top level. Build and ship real projects and read advanced docs to stay sharp.";
  else focus = "To reach " + levelNames[have + 1] + ", focus on: " + skill.focus[have];

  return { skill: skill, have: have, usedIn: usedIn, focus: focus };
}

// ---------- Add / change / remove skills ----------
function addSkill() {
  const text = skillInput.value.trim();
  if (!text) return;

  // Is it one of our skills? (match by name, ignoring capital letters)
  const known = skills.find(function (s) { return s.name.toLowerCase() === text.toLowerCase() || s.id === text.toLowerCase(); });
  let id;
  if (known) {
    id = known.id;
  } else {
    id = "custom-" + text.toLowerCase().replace(/[^a-z0-9]+/g, "-");
    customNames[id] = text;
  }

  mySkills[id] = Number(levelSelect.value);
  skillInput.value = "";
  hideSuggestions();
  selectedJobId = null;   // go back to showing the best job
  update();
}

document.getElementById("addBtn").onclick = addSkill;

// ---------- Dropdown with suggestions (scrolls when the list is long) ----------
const suggestions = document.getElementById("suggestions");
let activeIndex = -1;   // which suggestion is highlighted with the arrow keys

function showSuggestions() {
  const text = skillInput.value.trim().toLowerCase();
  const matches = skills.filter(function (s) { return s.name.toLowerCase().includes(text); });
  activeIndex = -1;
  if (matches.length === 0) { suggestions.classList.add("hidden"); return; }
  suggestions.innerHTML = matches.map(function (s) {
    return `<li data-name="${s.name}">${s.name}</li>`;
  }).join("");
  suggestions.classList.remove("hidden");
}

function hideSuggestions() {
  suggestions.classList.add("hidden");
}

function pickSuggestion(name) {
  skillInput.value = name;
  hideSuggestions();
  skillInput.focus();
}

// Arrow keys move the highlight
function moveActive(step) {
  const items = suggestions.querySelectorAll("li");
  if (items.length === 0) return;
  if (activeIndex >= 0) items[activeIndex].classList.remove("active");
  activeIndex = (activeIndex + step + items.length) % items.length;
  items[activeIndex].classList.add("active");
  items[activeIndex].scrollIntoView({ block: "nearest" });
}

skillInput.oninput = showSuggestions;
skillInput.onfocus = showSuggestions;

// mousedown (not click) so the input does not lose focus first
suggestions.onmousedown = function (e) {
  e.preventDefault();
  const item = e.target.closest("li");
  if (item) pickSuggestion(item.dataset.name);
};

skillInput.onkeydown = function (e) {
  const isOpen = !suggestions.classList.contains("hidden");
  if (e.key === "ArrowDown") {
    e.preventDefault();
    if (!isOpen) showSuggestions(); else moveActive(1);
  } else if (e.key === "ArrowUp") {
    e.preventDefault();
    moveActive(-1);
  } else if (e.key === "Escape") {
    hideSuggestions();
  } else if (e.key === "Enter") {
    if (isOpen && activeIndex >= 0) {
      pickSuggestion(suggestions.querySelectorAll("li")[activeIndex].dataset.name);
    } else {
      addSkill();
    }
  }
};

// Click anywhere else to close the dropdown
document.addEventListener("click", function (e) {
  if (!e.target.closest(".combo")) hideSuggestions();
});

// Called when the user edits a level in the list
function changeLevel(id, value) {
  mySkills[id] = Number(value);
  update();
}

function removeSkill(id) {
  delete mySkills[id];
  delete customNames[id];
  selectedJobId = null;
  update();
}

function showJob(id) {
  selectedJobId = id;
  update();
}

// ---------- Draw the page ----------
function update() {
  try {
    localStorage.setItem(storageKey("mySkills"), JSON.stringify(mySkills));
    localStorage.setItem(storageKey("customNames"), JSON.stringify(customNames));
  } catch (e) { /* storage not available, skip saving */ }

  // skill list with editable levels
  skillList.innerHTML = "";
  Object.keys(mySkills).forEach(function (id) {
    const s = getSkill(id);
    skillList.innerHTML += `<li>
      <span>${esc(s.name)} ${s.custom ? "<small>(not in database)</small>" : ""}</span>
      <span>
        <select onchange="changeLevel('${id}', this.value)">${levelOptions(mySkills[id])}</select>
        <button onclick="removeSkill('${id}')">x</button>
      </span></li>`;
  });

  // nothing added yet
  if (Object.keys(mySkills).length === 0) {
    results.classList.add("hidden");
    emptyMsg.classList.remove("hidden");
    return;
  }
  results.classList.remove("hidden");
  emptyMsg.classList.add("hidden");

  const ranked = rankJobs();
  if (!selectedJobId) selectedJobId = ranked[0].job.id;
  const current = ranked.find(function (r) { return r.job.id === selectedJobId; });

  drawJobCard(current.job, current.score);
  drawOtherJobs(ranked);
  drawRoadmap(current.job);
  drawInsights();
}

function drawJobCard(job, score) {
  let rows = "";
  job.needs.forEach(function (n) {
    const have = mySkills[n.skill] || 0;
    const good = have >= n.level;
    const skill = getSkill(n.skill);
    rows += `<tr>
      <td>${skill.name}</td>
      <td>${levelNames[n.level]}</td>
      <td>${levelNames[have]}</td>
      <td class="${good ? "ok" : "gap"}">${good ? "Ready" : "Gap"}</td>
      <td><a href="${skill.docs}" target="_blank">Docs</a></td>
    </tr>`;
  });

  const platforms = job.platforms.map(function (p) {
    return `<a href="${platformLinks[p]}" target="_blank">${p}</a>`;
  }).join(", ");

  document.getElementById("jobCard").innerHTML = `
    <h3 class="job-title">${job.title}</h3>
    <p class="info">${job.about}</p>
    <div class="flip">${flipDigits(score)}</div>
    <div class="bar"><div style="width:${score}%"></div></div>
    <p class="info">Median salary: <b>₹${job.salary} LPA</b> (approx.)</p>
    <p class="info">Find this job on: ${platforms}</p>
    <p class="info">Tip: ${job.tip}</p>
    <table>
      <tr><th>Skill</th><th>Required</th><th>You</th><th>Status</th><th>Learn</th></tr>
      ${rows}
    </table>`;
}

// Feature 2: other careers you could go for
function drawOtherJobs(ranked) {
  let html = "";
  ranked.slice(0, 6).forEach(function (r) {
    if (r.job.id !== selectedJobId) {
      html += `<button class="chip" onclick="showJob('${r.job.id}')">${r.job.title} - ${r.score}%</button>`;
    }
  });
  document.getElementById("otherJobs").innerHTML = html;
}

// Feature 1: learning roadmap with time estimate and what to focus on
function drawRoadmap(job) {
  const gaps = getGaps(job);
  if (gaps.length === 0) {
    document.getElementById("roadmap").innerHTML = "<p class='ok'>You meet every skill for this job. Start applying!</p>";
    return;
  }
  let rows = "";
  gaps.forEach(function (g, i) {
    rows += `<tr>
      <td>${i + 1}</td>
      <td>${g.skill.name}<br><small>${focusPath(g.skill, g.have, g.need).join("<br>")}</small></td>
      <td>~${g.weeks} weeks</td>
    </tr>`;
  });
  document.getElementById("roadmap").innerHTML = `
    <table><tr><th>#</th><th>Skill and what to focus on</th><th>Time</th></tr>${rows}</table>
    <p class="info">Total: <b>~${totalWeeks(gaps)} weeks</b> of study (about ${Math.ceil(totalWeeks(gaps) / 4)} months)</p>`;
}

function drawInsights() {
  let html = "";
  Object.keys(mySkills).forEach(function (id) {
    const info = skillInsight(id);
    const jobText = info.usedIn.slice(0, 3).map(function (u) {
      return `${u.job.title} (needs ${levelNames[u.level]})`;
    }).join(", ");
    html += `<div class="insight">
      <h3>${esc(info.skill.name)} - ${levelNames[info.have]}</h3>
      <p>${info.focus}</p>
      ${info.usedIn.length ? `<p class="info">Used in: ${jobText}</p>` : ""}
    </div>`;
  });
  document.getElementById("insights").innerHTML = html;
}

// ---------- PDF report ----------
let y = 20;   // current position on the PDF page

function heading(doc, text) {
  if (y > 255) { doc.addPage(); y = 20; }
  doc.setFont("helvetica", "bold"); doc.setFontSize(13); doc.setTextColor(27, 16, 53);
  doc.text(text, 14, y); y += 7;
  doc.setFont("helvetica", "normal"); doc.setFontSize(10); doc.setTextColor(40);
}

function paragraph(doc, text) {
  const lines = doc.splitTextToSize(text, 182);
  if (y + lines.length * 5 > 280) { doc.addPage(); y = 20; }
  doc.text(lines, 14, y);
  y += lines.length * 5 + 3;
}

function table(doc, head, body, extra) {
  doc.autoTable(Object.assign({
    startY: y, head: [head], body: body,
    styles: { fontSize: 9, cellPadding: 2 },
    headStyles: { fillColor: [27, 16, 53] },
    margin: { left: 14, right: 14 }
  }, extra || {}));
  y = doc.lastAutoTable.finalY + 10;
}

function downloadPdf() {
  if (!window.jspdf) {
    alert("The PDF library could not load. Check your internet connection and try again.");
    return;
  }
  const doc = new window.jspdf.jsPDF();
  y = 20;

  const ranked = rankJobs();
  const current = ranked.find(function (r) { return r.job.id === selectedJobId; });
  const job = current.job;
  const gaps = getGaps(job);

  // Title
  doc.setFont("helvetica", "bold"); doc.setFontSize(20); doc.setTextColor(27, 16, 53);
  doc.text("SkillGap Report", 14, y); y += 8;
  doc.setFont("helvetica", "normal"); doc.setFontSize(10); doc.setTextColor(100);
  doc.text("Generated on " + new Date().toLocaleDateString(), 14, y); y += 10;
  doc.setTextColor(40);

  // 1. Summary of the target job
  heading(doc, "1. Target job: " + job.title);
  paragraph(doc, job.about);
  paragraph(doc, "Employment probability: " + current.score + "%   |   Median salary with this skill set: Rs. " + job.salary + " LPA (approx., India)");
  paragraph(doc, "Where to find it: " + job.platforms.map(function (p) { return p + " (" + platformLinks[p] + ")"; }).join(", "));
  paragraph(doc, "Tip: " + job.tip);

  // 2. Required skills
  heading(doc, "2. Skills required and your level");
  const needRows = job.needs.map(function (n) {
    const have = mySkills[n.skill] || 0;
    const s = getSkill(n.skill);
    return [s.name, levelNames[n.level], levelNames[have], have >= n.level ? "Ready" : "Gap", importanceNames[n.weight], new URL(s.docs).hostname];
  });
  table(doc, ["Skill", "Required", "You", "Status", "Importance", "Official docs"], needRows, {
    didDrawCell: function (data) {      // make the docs column clickable
      if (data.section === "body" && data.column.index === 5) {
        doc.link(data.cell.x, data.cell.y, data.cell.width, data.cell.height, { url: getSkill(job.needs[data.row.index].skill).docs });
      }
    }
  });

  // 3. Roadmap
  heading(doc, "3. Learning roadmap (most important first)");
  if (gaps.length === 0) {
    paragraph(doc, "No gaps. You meet every requirement for this job. Start applying and build a portfolio.");
  } else {
    const gapRows = gaps.map(function (g, i) {
      return [i + 1, g.skill.name, focusPath(g.skill, g.have, g.need).join("\n"), "~" + g.weeks + " weeks"];
    });
    table(doc, ["#", "Skill", "What to focus on", "Time"], gapRows, { columnStyles: { 2: { cellWidth: 95 } } });
    paragraph(doc, "Total estimated study time: about " + totalWeeks(gaps) + " weeks (" + Math.ceil(totalWeeks(gaps) / 4) + " months).");
  }

  // 4. Insight for each skill the user has
  heading(doc, "4. Your skills: where they are used and what to focus on");
  Object.keys(mySkills).forEach(function (id) {
    const info = skillInsight(id);
    if (y > 250) { doc.addPage(); y = 20; }
    doc.setFont("helvetica", "bold");
    doc.text(info.skill.name + " - " + levelNames[info.have], 14, y); y += 5;
    doc.setFont("helvetica", "normal");
    paragraph(doc, info.focus);
    if (info.usedIn.length) {
      const rows = info.usedIn.map(function (u) {
        return [u.job.title, levelNames[u.level], importanceNames[u.weight], u.score + "%", "Rs. " + u.job.salary + " LPA"];
      });
      table(doc, ["Job that uses it", "Level needed", "Importance", "Your match", "Median salary"], rows);
    } else {
      paragraph(doc, "No jobs in our data use this skill yet.");
    }
  });

  // 5. Compare careers
  heading(doc, "5. Careers compared");
  const otherRows = ranked.slice(0, 5).map(function (r) {
    return [r.job.title, r.score + "%", "Rs. " + r.job.salary + " LPA", totalWeeks(getGaps(r.job)) + " weeks"];
  });
  table(doc, ["Job", "Match", "Median salary", "Study time needed"], otherRows);

  paragraph(doc, "Note: probability comes from a weighted skill-matching formula and is only a guide. Salaries are approximate medians; check Naukri, LinkedIn or AmbitionBox for current numbers.");

  doc.save("skillgap-report.pdf");
}

document.getElementById("downloadBtn").onclick = downloadPdf;

