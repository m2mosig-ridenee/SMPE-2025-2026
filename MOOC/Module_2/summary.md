# Module 2: Computational Documents  

---

## 1. Why Computational Documents Matter

Modern research relies heavily on code, data transformations, and statistical processing.  
Reproducibility issues arise because most scientific work hides important steps behind the scenes.

### Common reproducibility failures
- Missing documentation or methodological details  
- Hidden data cleaning steps  
- Programming mistakes or statistical errors  
- Proprietary or opaque software obscuring how results are produced  
- Poor backup/versioning practices  

Examples like the Reinhart & Rogoff Excel error, fMRI false positives, and crystallography mistakes show the importance of **transparent, inspectable computation**.

Computational documents exist to make both the **public display** (final results) and the **behind-the-scenes** (code, data, intermediate steps) visible.

---

## 2. What a Computational Document Is

A computational document is a single file mixing:
- Explanatory text  
- Executable code blocks  
- Automatically captured results (numbers, tables, graphs)  
- Hyperlinks, formulas, metadata  

It keeps a live interpreter session:  
Variables persist across code cells, allowing incremental computation with narrative explanation.

The document can be exported (HTML, PDF, LaTeX, Word) while choosing which parts to show or hide.

---

## 3. Why Reproducibility Is Difficult

### (a) Lack of transparent information
- Missing protocols  
- Unclear data transformations  
- undocumented decisions  
- inaccessible raw data  

### (b) Misuse of GUI or black-box tools
- Spreadsheets misinterpreting gene names (Excel → dates)  
- Proprietary software hiding underlying logic  
- Overly interactive tools making calculations non-inspectable  

### (c) Bad technical practices
- No backups  
- No version control  
- Overwritten data  
- Missing code review or continuous integration  
- Use of unreadable/binary formats  

### (d) Scientific publishing constraints
Articles hide complexity due to limited space and don’t contain enough detail to reproduce work.

### (e) Cultural fears about openness
Researchers fear:
- exposing errors  
- others exploiting their work  
- revealing sensitive data  
But transparency increases credibility, helps error detection, and boosts impact.

---

## 4. Principles of Computational Documents

Computational documents support:
- **Transparency**  
- **Traceability**  
- **Inspectability**  
- **Reusability**  
- **Reproducibility**

They allow:
- Step-by-step explanation of analyses  
- Regenerating all figures and tables on demand  
- Keeping code, decisions, and results in one place  

---

## 5. Tools for Creating Computational Documents

### **A. Jupyter Notebooks**
- Browser-based, easy to use  
- Integrates Python, R, Julia, Ruby  
- Autocompletion, magic commands  
- Inline graphical output  
- JSON storage (not human-readable)  
- Export to HTML/PDF and share via GitLab/GitHub  

### **B. RStudio + R Markdown (knitR)**
- Dedicated to R  
- Excellent for generating polished documents (HTML, PDF, Word)  
- Supports multiple languages, but no persistent Python state  
- Very strong for academic publishing  

### **C. Emacs Org-mode**
- Most powerful but steep learning curve  
- Native multi-language support (R, Python, shell, etc.)  
- Remote execution (SSH)  
- Session persistence  
- Superb navigation and tagging (journals, lab notebooks)  
- Fine-grained control over export (LaTeX, HTML)  

---

## 6. Collaboration Challenges & Strategies

Coauthors may be:
1. **Enthusiastic** → everyone adopts the tool  
2. **Benevolent but busy** → they edit text, but you manage computation  
3. **Resistant** → maintain a separate computational document to produce figures and integrate them into a traditional paper  

Sharing options:
- RPubs (temporary)
- GitLab / GitHub repositories  
- Long-term repositories: **Zenodo, Figshare, HAL**  

When using GitHub/GitLab, be careful: making a repo public exposes its entire history.

---

## 7. Key Takeaways

- Reproducibility demands transparency and traceability.  
- Computational documents unify **narrative + code + results**.  
- Prefer **text-based, open formats** (Markdown, Org-mode) over proprietary ones.  
- Good practices (version control, backups, documentation) are as important as the tools.  
- The goal is to make your work understandable and reusable — for yourself and for others — long after it is produced.

---