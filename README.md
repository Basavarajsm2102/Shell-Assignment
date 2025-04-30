# 🔧 Shell Script: sig.conf Line Editor

## 📜 Objective

Create a **shell script** that updates a single line in a configuration file (`sig.conf`) based on user input.

---

## 📥 User Inputs

The script should prompt the user to input the following values:

1. **Component Name**: must be one of  
   `INGESTOR`, `JOINER`, `WRANGLER`, `VALIDATOR`

2. **Scale**: must be one of  
   `MID`, `HIGH`, `LOW`

3. **View**: must be one of  
   `Auction`, `Bid`  
   > Internally, these map to:  
   > - `Auction` → `vdopiasample`  
   > - `Bid` → `vdopiasample-bid`

4. **Count**: a **single-digit number** (`0`–`9`)

---

## 🛠️ Functionality

- The script must **validate each input** — users can only enter allowed values.
- It will then **search the `sig.conf` file** for a line that matches:
