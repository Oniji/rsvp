_Note: Some features such as audible notifications when the timer reaches zero or chat reporting do not meet the HorizonXI addon standards and cannot be implemented with this addon._

The fork and its additional features have been approved for use on HorizonXI.

## How to Install
1. On the right side of the Github page (to the right of all the files) there is a section called "Releases".
2. Click the release that is marked as "Latest".
3. Inside the release there is a file called rsvp.zip. Download that. You don't need the "Source code" files.
5. Go to your download location and extract rsvp.zip. You should end up with a folder called "rsvp".
6. Put that "rsvp" folder in your addon folder. For Horizon it's probably something like ~/HorizonXI/Game/addons.

## Features
1. Local clock
2. Set a timer for {X} minutes in to the future. Quick buttons are available for common times.
3. Set a timer for a future real world time.
4. Create timer sets for HNMs. Set the first window and all subsequent windows will have timers automatically created.
5. HNM--or grouped--timers can be expanded to show the individual windows.
6. Bulk-create timers from pasted multi-line text (RSVP Multi-Creation).
7. Timers are saved to a file so they will still be there if you log out or shut down.
8. Timers persist until you cancel them so you can see how overdue you are.

## Basic Timers
The main portion of the addon is the timer list and timer creation screen.<br><br>
![image](https://github.com/user-attachments/assets/54821bdb-44ae-4d4c-abae-0bf4191c0555)<br>
_Left: Timer List in Basic Mode showing some example timers. Right: RSVP Creation window showing the Relative timer options._

### Timer List
The timer list is designed to be visible most of the time.

#### Buttons at the Top
1. "+" : Opens and closes the RSVP Creation window.
2. "++" : Opens and closes the RSVP Multi-Creation window (bulk timer paste).
3. Group: By default, grouped timers are collapsed and you can only see the nearest timer. Enabling Group Mode allows you to expand grouped timers and delete individual windows or the entire group.
4. Stamp: Toggles from countdown mode to timestamp mode. Timestamp mode lets you see the time you are counting down to. It's useful if you ever doubt that you typed the time in wrong.
5. Filt: You can configure a time filter in RSVP Settings that allows you to hide timers that are more than {X} amount of hours in the future. If you want to temporarily peak at those timers you can turn the filter off with this button to see them. The number in parenthesis shows how many timers are currently being filtered.

#### Grouping
Grouped timers are collapsed by default to save space. You can expand them to delete subsequent timers individually. You can also delete the whole group easily.

![image](https://github.com/user-attachments/assets/72d7576b-4536-4552-97c9-e12d46fe8243)<br>
_Example of an HNM timer that has the subsequent timers expanded._

### RSVP Creation
The RSVP Creation window is where you will create the timers. It has two sections based on what type of timer you are trying to create.<br><br>
![image](https://github.com/user-attachments/assets/fd9c00e0-c1a3-451e-b287-44ef4fe51f6e)<br>
_Left: Timer List in Group Mode. Right: RSVP Creation Window showing Specific timer options._

#### Relative 
Relative timers are created {X} amount of minutes into the future from the current time. If a mob dies now and it respawns in 5 minutes then you would create a Relative timer for 5 minutes to track its next spawn time. There are quick buttons available for some common times otherwise you can enter a custom amount of minutes. Relative timers do NOT require a name. If you want to quickly make a timer without thinking about a name just press the quick button or Create button and the timer will be created. Its name will be the timestamp that you are counting down to.
#### Specific
Specific timers are created by entering a specific date and time to count down to. There can be useful for HNMs or other events. Names are required for these and the time and dates need to be in the formats HH:MM:SS (AM/PM) and MM/DD/YY , respectively. The AM/PM is optional if you want to use 24-hour time. A timer preview is provided so that you can see what the addon thinks you're entering. The Sim: row is a simulation of what the timer will look like once created. Some quick buttons are available for creating timer groups for HNMs. The "10M7" buttons is for your 1-hour 10-minute windows like Fafnir (7 total windows). The "1H25" is for your 24-hour 1-hour windows like Tiamat (25 total windows). If you need to make a grouped timer with custom windows you can do that as well by expanding the "Custom Windows" drop down.

### RSVP Multi-Creation
The Multi-Creation window lets you paste several timer lines at once and create them in one click. Open it with the "++" button on the timer list, or with `/rsvp multi` (`cm` / `mm` also work).<br><br>
<img width="708" height="312" alt="image" src="https://github.com/user-attachments/assets/983ec623-a6d5-49ce-8204-8c98566309d2" />

1. Set the **Date** (`MM/DD/YY`) that the pasted clock times belong to.
2. Paste the bulk text into the multi-line field.
3. Press **Add**.

Each non-empty line is parsed independently. Lines without a valid time are ignored (headers, blank lines, etc.).

#### Line syntax
Each timer line needs a **name** and a **time**. An optional **relative phrase** helps resolve day rollover when the clock time alone is ambiguous.

```
<Name> ... [(day)] ... <H:MM:SS or H:MM:SS AM/PM> [relative phrase]
```

- **Name:** Leading letters/spaces (and `/` for combined names like `Fafnir/Nidhogg`). Extra text such as Discord emoji codes (`:turtle:`) can appear after the name and are ignored for matching.
- **Day (optional):** A number in parentheses after the name/emoji (for example `(2)` or `(4)`). For HNMs that have HQ variants (Behemoth/KB, Ada/Aspid, Fafnir/Nidhogg lines), this is stored as the HNM day index. If those HNMs have no bracketed number, day **1** is assumed. It is not used for other names (and is distinct from window tags like `(1/7)` which the addon creates itself).
- **Time:** `H:MM:SS` or `HH:MM:SS`. Optional `AM` / `PM` for 12-hour time. Without AM/PM, the time is treated as 24-hour.
- **Relative phrase (optional):** Used with the date + clock time to pick the correct day of the calendar date.
  - Future: `in a day`, `in N days`, `in N hours`, `in N minutes`, `in N seconds`
  - Past: `a day ago`, `N days ago`, `N hours ago`, `N minutes ago`, `N seconds ago`

#### Display options (Settings)
Two options in **RSVP Config → Settings** affect how bulk-created (and other) timers appear in the list:

1. **Abbreviate Names** (default off) — shortens known HNM names in the list (for example `Behemoth` → `Behe`, `Fafnir/Nidhogg` → `Faf/Nid`). Stored timer names are unchanged.
2. **Include HNM Day** (default on) — for HQ-variant HNMs above, shows the stored day after the name (for example `Behe D2`, `Faf/Nid D4`). Can be used with or without Abbreviate Names. Window tags still append when present (for example `Faf D4 (1/7)`).

#### Examples

24-hour:

```
Behemoth :zap:(2): 3:16:37 in 3 hours
Adamantoise :turtle: (1): 18:05:16 in 3 hours
Fafnir/Nidhogg 🚨🐲 (4): 8:40:33 in 17 hours
Bloodsucker :drop_of_blood:: 23:40:40 in 8 hours
```

With **Abbreviate Names** and **Include HNM Day** enabled, list labels look like `Behe D2`, `Ada D1`, `Faf/Nid D4`, and `BS` (Bloodsucker has no day tag).

12-hour:

```
Adamantoise :turtle: (1): 6:05:16 PM in 3 hours
Bloodsucker :drop_of_blood:: 11:40:40 PM in 8 hours
King Vinegarroon :scorpion:: 1:37:47 AM in 10 hours
```

#### Known HNMs
Recognized HNM names are canonicalized and scheduled with the matching window set when relevant (for example King windows for Fafnir/Nidhogg, Wyrm windows for Tiamat). Unknown names are created as normal single timers.

Supported names include: Behemoth, King Behemoth, Adamantoise, Aspidochelone, Fafnir, Nidhogg, Tiamat, Vrtra, Jormungand, Khimaira, Cerberus, Hydra, Gulool Ja Ja, Medusa, Gurfurlur, Simurgh, King Arthro, King Vinegarroon, Bloodsucker, and Shikigami Weapon (plus combined forms like `Fafnir/Nidhogg` and `Behemoth/KB`).

