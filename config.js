// ---------- Email settings (for sign up verification and password reset) ----------
// Websites can't send email by themselves. This project uses EmailJS (free: 200 emails/month).
// Setup, about 5 minutes:
//  1. Make an account at https://www.emailjs.com and open "Email Services".
//     Add your Gmail (or other) and copy the Service ID.
//  2. Open "Email Templates" and create a template:
//       To Email:  {{to_email}}
//       Subject:   Your SkillGap {{purpose}} code
//       Body:      Hi {{name}}, your {{purpose}} code is {{code}}. It expires in 10 minutes.
//     Copy the Template ID.
//  3. Open Account and copy your Public Key (it is safe to put in a website).
//  4. Paste the three values below and save.
// Leave them empty and the site runs in demo mode (codes show on screen, no email is sent).

const EMAIL_CONFIG = {
  serviceId: "service_f2g5y7s",
  templateId: "",
  publicKey: "1ULWziTfhgk2xLFuk"
};
