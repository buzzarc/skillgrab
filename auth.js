// ---------- Log in / Sign up / Forgot password (front-end demo) ----------
// Accounts live in this browser's localStorage, so this is NOT real security.
// A real site needs a server, real emails, and the users table from database.sql.

let currentUser = null;   // example: { email: "a@b.com", name: "Ut" }

// Page elements
const authMain = document.getElementById("authMain");
const appMain = document.getElementById("app");
const views = { login: "viewLogin", signup: "viewSignup", forgot: "viewForgot" };
const badgeText = {          // [small label, big word on the badge]
  login: ["LOG IN", "Builder"],
  signup: ["SIGN UP", "Newcomer"],
  forgot: ["RESET", "Locked out"]
};

// Reset code details (kept in memory only)
let resetEmail = "";
let resetCode = "";
let resetExpires = 0;

// ---------- helpers ----------
function getUsers() {
  try { return JSON.parse(localStorage.getItem("users")) || {}; }
  catch (e) { return {}; }
}

function saveUsers(users) {
  try { localStorage.setItem("users", JSON.stringify(users)); return true; }
  catch (e) { return false; }
}

function setMsg(id, text) {
  document.getElementById(id).textContent = text;
}

// We never store the password itself, only a salted hash of it
async function hashPassword(password, salt) {
  const text = salt + password;
  if (window.crypto && crypto.subtle) {
    const bytes = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
    return Array.from(new Uint8Array(bytes)).map(function (b) {
      return b.toString(16).padStart(2, "0");
    }).join("");
  }
  let h = 5381;   // old browsers: simple fallback hash
  for (let i = 0; i < text.length; i++) h = ((h << 5) + h + text.charCodeAt(i)) | 0;
  return String(h);
}

function makeSalt() {
  return Math.random().toString(36).slice(2) + Date.now().toString(36);
}

// ---------- email helpers ----------
const emailEnabled = !!(EMAIL_CONFIG.serviceId && EMAIL_CONFIG.templateId && EMAIL_CONFIG.publicKey);

// Checks the shape of an email (name@site.com). Only a real email can prove the address exists.
function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[a-z]{2,}$/i.test(email);
}

function makeCode() {
  return String(Math.floor(100000 + Math.random() * 900000));
}

// Sends a code by email with EmailJS. Returns true if it worked.
async function sendCodeEmail(to, name, code, purpose) {
  try {
    const res = await fetch("https://api.emailjs.com/api/v1.0/email/send", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        service_id: EMAIL_CONFIG.serviceId,
        template_id: EMAIL_CONFIG.templateId,
        user_id: EMAIL_CONFIG.publicKey,
        template_params: { to_email: to, name: name, code: code, purpose: purpose }
      })
    });
    return res.ok;
  } catch (e) {
    return false;
  }
}

// ---------- switching between the three pages ----------
function showView(name) {
  Object.keys(views).forEach(function (key) {
    document.getElementById(views[key]).classList.toggle("hidden", key !== name);
  });
  document.getElementById("badgeMode").textContent = badgeText[name][0];
  document.getElementById("badgeTitle").textContent = badgeText[name][1];
  ["loginMsg", "signupMsg", "forgotMsg", "resetMsg"].forEach(function (id) { setMsg(id, ""); });
  pendingSignup = null;
  document.getElementById("verifyBox").classList.add("hidden");
  document.getElementById("signupSubmit").textContent = "Create account →";

  if (name === "forgot") {   // start the reset steps again
    document.getElementById("forgotForm").classList.remove("hidden");
    document.getElementById("resetForm").classList.add("hidden");
  }
}

document.querySelectorAll("[data-view]").forEach(function (el) {
  el.onclick = function () { showView(el.dataset.view); };
});

// "Show / Hide" buttons next to password boxes
document.querySelectorAll("[data-toggle]").forEach(function (btn) {
  btn.onclick = function () {
    const box = document.getElementById(btn.dataset.toggle);
    const hide = box.type === "text";
    box.type = hide ? "password" : "text";
    btn.textContent = hide ? "Show" : "Hide";
  };
});

// ---------- LOG IN ----------
document.getElementById("viewLogin").onsubmit = async function (e) {
  e.preventDefault();
  const email = document.getElementById("loginEmail").value.trim().toLowerCase();
  const password = document.getElementById("loginPassword").value;
  const user = getUsers()[email];

  if (!email || !password) { setMsg("loginMsg", "Enter your email and password."); return; }
  if (!user || (await hashPassword(password, user.salt)) !== user.hash) {
    setMsg("loginMsg", "Wrong email or password.");
    return;
  }
  login(email);
};

// ---------- SIGN UP ----------
// With email set up (config.js): step 1 sends a code, step 2 checks it, then the account is made.
// Without it (demo mode): the account is made straight away.
let pendingSignup = null;   // { email, password, code, expires }

async function createAccount(name, email, password) {
  const users = getUsers();
  const salt = makeSalt();
  users[email] = { name: name, salt: salt, hash: await hashPassword(password, salt) };
  if (!saveUsers(users)) { setMsg("signupMsg", "Could not save the account (browser storage is blocked)."); return; }
  login(email);
}

document.getElementById("viewSignup").onsubmit = async function (e) {
  e.preventDefault();
  const name = document.getElementById("signupName").value.trim();
  const email = document.getElementById("signupEmail").value.trim().toLowerCase();
  const password = document.getElementById("signupPassword").value;
  const confirm = document.getElementById("signupConfirm").value;

  if (!name) { setMsg("signupMsg", "Enter your name."); return; }
  if (!isValidEmail(email)) { setMsg("signupMsg", "Enter a valid email, like name@gmail.com."); return; }
  if (password.length < 6) { setMsg("signupMsg", "Password must be at least 6 characters."); return; }
  if (password !== confirm) { setMsg("signupMsg", "Passwords do not match."); return; }
  if (getUsers()[email]) { setMsg("signupMsg", "An account with this email already exists. Log in instead."); return; }

  if (!emailEnabled) { createAccount(name, email, password); return; }

  const sameAsBefore = pendingSignup && pendingSignup.email === email && pendingSignup.password === password;
  if (!sameAsBefore) {
    // step 1: email a code
    setMsg("signupMsg", "Sending code...");
    const code = makeCode();
    if (!(await sendCodeEmail(email, name, code, "sign up"))) {
      setMsg("signupMsg", "Could not send the email. Check the address and try again.");
      return;
    }
    pendingSignup = { email: email, password: password, code: code, expires: Date.now() + 10 * 60 * 1000 };
    document.getElementById("verifyBox").classList.remove("hidden");
    document.getElementById("signupSubmit").textContent = "Verify & create account →";
    setMsg("signupMsg", "Code sent. Check your inbox (and spam folder).");
    return;
  }

  // step 2: check the code
  const entered = document.getElementById("signupCode").value.trim();
  if (entered !== pendingSignup.code || Date.now() > pendingSignup.expires) {
    setMsg("signupMsg", "Invalid or expired code.");
    return;
  }
  pendingSignup = null;
  createAccount(name, email, password);
};

// ---------- FORGOT PASSWORD ----------
// Step 1: enter your email and we send a reset code.
// In demo mode (no email set up) the code is shown on screen instead.
document.getElementById("forgotForm").onsubmit = async function (e) {
  e.preventDefault();
  const email = document.getElementById("forgotEmail").value.trim().toLowerCase();
  if (!isValidEmail(email)) { setMsg("forgotMsg", "Enter a valid email."); return; }

  const user = getUsers()[email];
  const codeBox = document.getElementById("codeBox");
  resetEmail = "";
  codeBox.classList.add("hidden");

  if (user) {
    resetEmail = email;
    resetCode = makeCode();
    resetExpires = Date.now() + 10 * 60 * 1000;   // valid for 10 minutes
    if (emailEnabled) {
      setMsg("forgotMsg", "Sending code...");
      if (!(await sendCodeEmail(email, user.name, resetCode, "password reset"))) {
        setMsg("forgotMsg", "Could not send the email. Try again in a moment.");
        return;
      }
    } else {
      codeBox.innerHTML = resetCode + "<small>Demo mode: no email service is connected, so the code shows here.</small>";
      codeBox.classList.remove("hidden");
    }
  }
  // same message either way, so nobody can guess who has an account
  setMsg("forgotMsg", "");
  setMsg("resetMsg", "If an account exists for this email, a reset code has been sent.");
  document.getElementById("forgotForm").classList.add("hidden");
  document.getElementById("resetForm").classList.remove("hidden");
};

// Step 2: enter the code and a new password
document.getElementById("resetForm").onsubmit = async function (e) {
  e.preventDefault();
  const code = document.getElementById("resetCodeInput").value.trim();
  const newPassword = document.getElementById("newPassword").value;
  const users = getUsers();

  if (!resetEmail || code !== resetCode || Date.now() > resetExpires) {
    setMsg("resetMsg", "Invalid or expired code.");
    return;
  }
  if (newPassword.length < 6) { setMsg("resetMsg", "Password must be at least 6 characters."); return; }

  const salt = makeSalt();
  users[resetEmail].salt = salt;
  users[resetEmail].hash = await hashPassword(newPassword, salt);
  if (!saveUsers(users)) { setMsg("resetMsg", "Could not save the new password."); return; }

  resetCode = "";
  document.getElementById("resetForm").reset();
  document.getElementById("forgotForm").reset();
  showView("login");
  setMsg("loginMsg", "Password updated. Log in with your new password.");
};

// ---------- log in / out ----------
function login(email) {
  currentUser = { email: email, name: getUsers()[email].name };
  try { localStorage.setItem("session", email); } catch (e) { /* ignore */ }

  document.getElementById("viewLogin").reset();
  document.getElementById("viewSignup").reset();
  authMain.classList.add("hidden");
  appMain.classList.remove("hidden");
  document.body.classList.add("in");
  document.getElementById("navGuest").classList.add("hidden");
  document.getElementById("userBar").classList.remove("hidden");
  document.getElementById("userName").textContent = "Hi, " + currentUser.name;
  startApp();   // in script.js
}

document.getElementById("logoutBtn").onclick = function () {
  try { localStorage.removeItem("session"); } catch (e) { /* ignore */ }
  currentUser = null;
  appMain.classList.add("hidden");
  authMain.classList.remove("hidden");
  document.body.classList.remove("in");
  document.getElementById("userBar").classList.add("hidden");
  document.getElementById("navGuest").classList.remove("hidden");
  showView("login");
};

// ---------- when the page opens: stay logged in if there is a saved session ----------
(function checkSession() {
  let email = null;
  try { email = localStorage.getItem("session"); } catch (e) { /* ignore */ }
  if (email && getUsers()[email]) login(email);
})();
