# ComicCraft – AI Comic Story Creator

ComicCraft is a full-featured web-based AI application that transforms user prompts into rich, publication-ready 5-panel comic books. Powered by **Google Gemini AI** for intelligent story planning and scriptwriting, and **Stable Diffusion** for dynamic comic-style illustrations, ComicCraft allows users to craft, preview, and download custom comics with ease.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Key Features](#key-features)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Prerequisites & System Requirements](#prerequisites--system-requirements)
6. [Step-by-Step Installation (Windows)](#step-by-step-installation-windows)
7. [Environment Variables & API Keys](#environment-variables--api-keys)
8. [Running the Application](#running-the-application)
9. [How the AI Comic Pipeline Works](#how-the-ai-comic-pipeline-works)
10. [PDF Export Architecture](#pdf-export-architecture)
11. [REST API & JSON Endpoints](#rest-api--json-endpoints)
12. [Troubleshooting & Common Issues](#troubleshooting--common-issues)
13. [Hardware & Stable Diffusion Notes](#hardware--stable-diffusion-notes)
14. [Skill Wallet Submission Readiness](#skill-wallet-submission-readiness)

---

## Project Overview

ComicCraft bridges the gap between text storytelling and visual graphic novel creation. By inputting:
- **Story Prompt** (e.g., *"A brave fox exploring an enchanted forest finds an ancient crystal relic."*)
- **Main Character Name** (e.g., *"Finn"*)
- **Setting** (e.g., *Enchanted Forest, Space, Cyber City, School, or Custom*)
- **Story Tone** (e.g., *Adventure, Dramatic, Light-hearted, Funny, Poetic, or Custom*)
- **Art Style** (e.g., *Comic Book, Anime, Pixel Art, Realistic, or Custom*)

ComicCraft coordinates multiple AI models to architect a 5-panel narrative arc, write custom character dialogues and narrator boxes, generate cohesive visual illustrations, and assemble everything into an interactive browser preview and downloadable multi-page PDF comic book.

---

## Key Features

- **Sequential 5-Panel Comic Arc:** Introduction, Inciting Incident, Rising Action, Climax, and Resolution.
- **Dual-Model Gemini Architecture:**
  - **Gemini Flash (`gemini-1.5-flash`):** Rapid structured storyboard and visual prompt extraction.
  - **Gemini Pro (`gemini-1.5-pro`):** Deep scriptwriting, contextual dialogue balloons, and narrative captions.
- **Stable Diffusion Illustration Generator:**
  - Connects to Hugging Face Serverless Inference API for cloud-accelerated Stable Diffusion generation.
  - Automatic prompt enhancement incorporating art styles and comic composition guidelines.
  - Built-in graceful offline visualizer when API keys are not yet configured or during development.
- **Publication-Grade PDF Exporter:**
  - Built using `fpdf2` and `Pillow`.
  - Full-color title cover page with character credentials and premise.
  - Dedicated pages for each panel featuring comic headers, illustrations, yellow caption tags, narration boxes, and styled speech bubbles.
  - Safe Unicode/ASCII transliteration preventing character encoding crashes.
- **Interactive Modern Frontend:**
  - Responsive retro comic book pop-art interface.
  - Quick-preset story buttons for immediate one-click testing.
  - Dynamic loading state tracker showing the current AI processing step.
  - Export success validation page that verifies file existence on disk before allowing downloads.
- **Developer REST API:** Complete JSON endpoint (`POST /generate-comic/json`) and testing endpoint (`GET /test-image`) documented in Swagger UI (`/docs`).

---

## Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Backend Framework** | Python 3.10+, FastAPI, Uvicorn, Pydantic v2 |
| **Templating & Static** | Jinja2, HTML5, CSS3 (Pop-Art Comic Theme) |
| **Story & Script AI** | Google Gemini API (`google-generativeai` SDK), Gemini 1.5 Flash, Gemini 1.5 Pro |
| **Illustration AI** | Hugging Face Stable Diffusion (`runwayml/stable-diffusion-v1-5`), Pillow (PIL) |
| **PDF Generation** | FPDF2, Pillow |
| **Configuration** | `python-dotenv` |

---

## Project Structure

```
ComicCraft/
│
├── app/
│   ├── __init__.py             # App package initialization
│   ├── main.py                 # FastAPI application, static mounting & lifespan
│   ├── routes.py               # Route handlers (GET /, POST /generate, JSON API, etc.)
│   ├── gemini_flash.py         # Gemini Flash structured 5-panel outline generator
│   ├── gemini_pro.py           # Gemini Pro dialogue and narration generator
│   ├── image_generator.py      # Stable Diffusion / Hugging Face illustration pipeline
│   ├── layout_builder.py       # Comic layout assembler combining text & images
│   └── exporters.py            # FPDF2 publication comic PDF exporter
│
├── templates/
│   ├── index.html              # Comic creation studio & input form
│   ├── comic_preview.html      # 5-panel interactive comic strip viewer
│   └── export_success.html     # PDF download and completion confirmation
│
├── static/
│   ├── css/
│   │   └── style.css           # Comic book theme, responsive layout & animations
│   ├── panels/                 # Storage for generated panel illustration PNGs
│   │   └── .gitkeep
│   └── exports/                # Storage for generated comic PDFs
│       └── .gitkeep
│
├── tests/
│   └── test_comiccraft.py      # Automated end-to-end and component verification tests
│
├── .env.example                # Template for required environment variables
├── .gitignore                  # Git exclusion rules (keys, caches, exports)
├── requirements.txt            # Python dependencies
└── README.md                   # Complete documentation
```

---

## Prerequisites & System Requirements

- **Operating System:** Windows 10/11 (or macOS / Linux)
- **Python:** Python 3.10 to Python 3.13 installed and added to your system `PATH`.
- **Internet Connection:** Required for downloading Python packages and calling Gemini / Hugging Face APIs.
- **API Keys (Optional for local demo, Required for live AI):**
  - Google Gemini API Key (`GEMINI_API_KEY`)
  - Hugging Face Access Token (`HF_API_KEY`)

---

## Step-by-Step Installation (Windows)

Open **PowerShell** or **Command Prompt** and navigate to your desired directory:

### 1. Clone or Open the Project Directory
```powershell
cd C:\Users\arunachala\.gemini\antigravity\scratch\ComicCraft
```

### 2. Create a Python Virtual Environment
Creating an isolated virtual environment is recommended:
```powershell
python -m venv env
```

### 3. Activate the Virtual Environment
On Windows PowerShell:
```powershell
.\env\Scripts\Activate.ps1
```
*(If PowerShell restricts script execution, run: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`)*

Or on Windows Command Prompt (`cmd.exe`):
```cmd
env\Scripts\activate.bat
```

### 4. Install Dependencies
Install all required packages from `requirements.txt`:
```powershell
pip install -r requirements.txt
```

---

## Environment Variables & API Keys

ComicCraft uses environment variables to keep your secrets safe. **Never commit your `.env` file to version control.**

### 1. Create your `.env` file
Copy the provided `.env.example` file to `.env`:
```powershell
Copy-Item .env.example .env
```
*(On CMD: `copy .env.example .env`)*

### 2. Configure Your Keys inside `.env`
Open `.env` in any text editor and populate the keys:
```env
# Google Gemini API Key
GEMINI_API_KEY=your_gemini_api_key_here

# Hugging Face Access Token
HF_API_KEY=your_huggingface_token_here

# Optional: Model Identifiers
GEMINI_FLASH_MODEL=gemini-1.5-flash
GEMINI_PRO_MODEL=gemini-1.5-pro
SD_MODEL_ID=runwayml/stable-diffusion-v1-5
```

### How to Obtain the API Keys:
1. **Google Gemini API Key:**
   - Visit [Google AI Studio](https://aistudio.google.com/app/apikey).
   - Sign in with your Google account.
   - Click **Create API key** and copy the string into `GEMINI_API_KEY`.
2. **Hugging Face Access Token:**
   - Visit [Hugging Face Settings > Tokens](https://huggingface.co/settings/tokens).
   - Create a free account if needed.
   - Click **New token**, select **Read** permissions, and copy the token into `HF_API_KEY`.

> **Note on Fallback / Demo Mode:**
> If you run ComicCraft without configuring API keys, ComicCraft will not crash. The system includes an **Offline Demo Mode** that allows you to test the complete 5-panel generation, layout composition, and PDF download pipeline immediately. Live AI indicators on the navigation bar clearly display whether live AI or offline mode is active.

---

## Running the Application in Visual Studio Code (Recommended)

ComicCraft includes full first-class configuration for **Visual Studio Code** (`.vscode/` and `ComicCraft.code-workspace`).

### 1. Open in VS Code
- Open VS Code.
- Go to **File** > **Open Folder...** (or **Open Workspace from File...**) and select:
  ```text
  C:\Users\arunachala\.gemini\antigravity\scratch\ComicCraft
  ```
  *(Or open `ComicCraft.code-workspace` directly).*

### 2. Run with One Click / F5
- Press **`F5`** on your keyboard (or go to the **Run & Debug** tab `Ctrl + Shift + D` and click **"FastAPI: ComicCraft (Uvicorn Live)"**).
- VS Code will automatically start Uvicorn with hot reload enabled and connect the debugger.

### 3. Or Use VS Code Tasks
- Press **`Ctrl + Shift + B`** to launch the default build task (`Run ComicCraft Server (Uvicorn)`).
- Or press **`Ctrl + Shift + P`** > type **Tasks: Run Task** and choose:
  - `Run ComicCraft Server (Uvicorn)` – Starts server on port 8000
  - `Run Verification Test Suite` – Runs automated tests
  - `Setup .env from .env.example` – Copies `.env.example` to `.env`
  - `Install Dependencies (pip)` – Runs pip install
  - `Open ComicCraft in Browser` – Opens `http://127.0.0.1:8000`

---

## Running from Windows Terminal / PowerShell (Alternative)

### 1. Start the FastAPI Server
With your terminal open in the project folder, run:
```powershell
python -m uvicorn app.main:app --reload --host 127.0.0.1 --port 8000
```
*(Or simply double-click `start_server.bat` in File Explorer).*

### 2. Access the Application
- **ComicCraft Web Studio:** Open [http://127.0.0.1:8000](http://127.0.0.1:8000) in any web browser.
- **Interactive Swagger API Docs:** Open [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs) to explore and test the REST endpoints.
- **Interactive Swagger API Docs:** Open [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs) to explore and test the REST endpoints.

---

## How the AI Comic Pipeline Works

```
                     ┌───────────────────────┐
                     │   User Inputs Form    │
                     │ (Prompt, Hero, Style) │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │     Gemini Flash      │
                     │ (Structured Outline)  │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │      Gemini Pro       │
                     │ (Dialogue & Scripts)  │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │   Stable Diffusion    │
                     │  (5 Panel Artworks)   │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │    Layout Builder     │
                     │ (Merge Text + Images) │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │     FPDF2 Exporter    │
                     │   (Multi-Page PDF)    │
                     └──────────┬────────────┘
                                │
                                ▼
                     ┌───────────────────────┐
                     │ Preview & PDF Export  │
                     │   Ready in Browser    │
                     └───────────────────────┘
```

1. **User Input:** User submits story prompt, character name, setting, tone, and art style.
2. **Gemini Flash (`app/gemini_flash.py`):** Uses Google's fast multimodal model to create a 5-panel chronological storyboard with panel titles, scene descriptions, and specialized visual prompts tailored to the chosen art style.
3. **Gemini Pro (`app/gemini_pro.py`):** Takes the outline and context to write rich narrator captions, punchy action dialogue balloons, and dramatic comic title tags while preserving character voice consistency.
4. **Stable Diffusion (`app/image_generator.py`):** Generates high-resolution comic illustrations for all 5 panels via Hugging Face Serverless Inference API (or local Diffusers) and saves them safely to `static/panels/`.
5. **Layout Builder (`app/layout_builder.py`):** Matches panel numbers, outlines, scripts, and image filepaths into a unified comic data structure.
6. **PDF Exporter (`app/exporters.py`):** Generates a downloadable multi-page comic book PDF under `static/exports/`.

---

## PDF Export Architecture

The PDF export module (`app/exporters.py`) produces high-quality, printable comic books:
- **Cover Page:** Bold comic title banner, full story metadata grid (Protagonist, Setting, Tone, Art Style, Premise), and an introductory feature illustration.
- **Sequential Panel Pages:** Each panel is formatted on its own page with:
  - Red top banner with panel number and title.
  - Clean bordered comic illustration.
  - Yellow comic caption banner.
  - Gray narrator story box.
  - Blue-accented dialogue speech balloon.
  - Bottom scene composition description.
- **Safety Handling:** All text is transliterated to safe character encodings to eliminate latin-1 or unhandled character crashes.

---

## REST API & JSON Endpoints

In addition to the web UI, ComicCraft provides REST API endpoints:

### `POST /generate-comic/json`
Accepts a JSON payload and returns the structured comic layout along with the generated PDF path:
```json
{
  "story_prompt": "A heroic robot defending a neon city from rogue drones.",
  "character_name": "Spark",
  "setting": "City",
  "tone": "Adventure",
  "art_style": "Anime",
  "allow_demo_fallback": true
}
```

**Response (HTTP 200 OK):**
```json
{
  "status": "success",
  "character_name": "Spark",
  "story_prompt": "A heroic robot defending a neon city from rogue drones.",
  "setting": "City",
  "tone": "Adventure",
  "art_style": "Anime",
  "pdf_path": "/static/exports/comiccraft_1790324599_84f6a735.pdf",
  "demo_mode": true,
  "comic_layout": [
    {
      "panel_number": 1,
      "title": "1. The Awakening in City",
      "scene_description": "...",
      "image_prompt": "...",
      "narration": "...",
      "dialogue": "...",
      "caption": "AT DAWN...",
      "image_path": "/static/panels/panel_1_....png",
      "text": "..."
    }
  ]
}
```

### `GET /test-image`
Tests the image generation subsystem independently:
- Parameters: `prompt`, `art_style`, `panel_number`
- Example: `http://127.0.0.1:8000/test-image?art_style=Comic%20Book&panel_number=1`

---

## Troubleshooting & Common Issues

| Issue | Cause | Solution |
| :--- | :--- | :--- |
| `GEMINI_API_KEY is missing` | `.env` file does not contain a valid Gemini key | Copy `.env.example` to `.env` and insert your Gemini API key, or enable Offline Demo Mode in the UI. |
| `Hugging Face model 503 loading` | Stable Diffusion model is cold-starting on Hugging Face | ComicCraft automatically retries up to 3 times with exponential backoff. If it times out, the built-in fallback creates the panel graphic. |
| `Script execution is disabled` on Windows PowerShell | PowerShell execution policy restrictions | Run: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` and then run `.\env\Scripts\Activate.ps1`. |
| Port 8000 already in use | Another service is using port 8000 | Run on a different port: `uvicorn app.main:app --port 8080 --reload` |

---

## Hardware & Stable Diffusion Notes

- **Cloud Mode (Default):** ComicCraft uses Hugging Face's hosted Serverless Inference API via `HF_API_KEY`. This means **no dedicated NVIDIA GPU or 12GB VRAM is required on your computer**. You can run ComicCraft on any standard Windows laptop or PC.
- **Local Diffusers Option:** For advanced users who want to run Stable Diffusion entirely offline using local PyTorch and CUDA, install `diffusers`, `transformers`, `accelerate`, and `torch` with CUDA support.

---

## Automated Verification Tests

ComicCraft includes a comprehensive automated test script that tests all 6 components of the application. Run it at any time with:

```powershell
python tests\test_comiccraft.py
```

Expected output:
```
--- [1/6] Testing Outline Generation ---
[OK] Outline generation test passed (5 panels verified).

--- [2/6] Testing Story & Dialogue Generation ---
[OK] Story & dialogue generation test passed.

--- [3/6] Testing Image Generation ---
[OK] Image generation test passed.

--- [4/6] Testing Layout Builder ---
[OK] Layout builder test passed.

--- [5/6] Testing PDF Exporter ---
[OK] PDF export test passed.

--- [6/6] Testing FastAPI Routes via TestClient ---
[OK] GET / returned 200 OK with ComicCraft HTML.
[OK] GET /docs returned 200 OK.
[OK] GET /test-image returned 200 OK with image path.
[OK] POST /generate returned 200 OK rendering comic_preview.html with all 5 panels.
[OK] POST /generate-comic/json returned 200 OK with 5 panels and PDF path.
[OK] GET /export-success returned 200 OK.
[OK] Form validation error handling returned 400 Bad Request as expected.

==========================================
SUCCESS: ALL 6 TEST SUITES PASSED PERFECTLY!
==========================================
```

---

## Skill Wallet Submission Readiness

This repository is built and structured specifically for **Skill Wallet** submission:
- **Clean Architecture:** Strict separation of routes, model pipelines, layout composition, and PDF exporting.
- **No Hard-coded Credentials:** Sensitive credentials and API tokens are handled strictly via environment variables.
- **Self-Contained & Documented:** Complete installation, execution, and verification instructions are included.
- **Reproducible Verification:** All routes and dependencies have been thoroughly tested on Windows.
