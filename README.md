## 🚀 Flicker Roadmap

### **1️⃣ Core Concept**

Flicker is a CLI tool for Flutter, similar to `shadcn`, that allows developers to add only the UI components they need. It generates modular Flutter components that can be easily customized. Works via:

```sh
flicker add <component>
```

---

### **2️⃣ Features & Goals**

#### ✅ **Phase 1: Basic CLI Functionality**

- [x] **CLI Setup:** Installable via `dart pub global activate`
- [x] **Auto-update `pubspec.yaml`** to add `flicker` package automatically when initializing
- [x] **Initialize Flicker in a Project:** `flicker init`
- [x] **Component Adding:** `flicker add <component>`
- [x] **Component Removal:** `flicker remove <component>`
- [-] **List Available Components:** `flicker list`

#### 🛠️ **Phase 2: Component System**

- [ ] **Pre-built UI Components:**
  - [ ] Button
  - [ ] Card
  - [ ] Input Field
  - [ ] Modal
  - [ ] ListTile
  - [ ] Snackbar
- [ ] **Customizable Themes:** Light & Dark mode support
- [ ] **Component Variants:** Like Filled, Outlined, Tonal buttons
- [ ] **Generate Components Dynamically:** Custom props for widgets

#### 🚀 **Phase 3: Advanced Features**

- [ ] **Interactive Prompts:** Ask users for customization options
- [ ] **Templates System:** Allow users to define & reuse component templates
- [ ] **Support for Tailwind-like Theming:** (optional)
- [ ] **Publish to Pub.dev** for easy global install
