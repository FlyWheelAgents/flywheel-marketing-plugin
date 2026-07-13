---
name: book-a-call
description: >
  Book a 20-minute intro call with the FlyWheel team, from inside the chat
  when possible. Use when the user wants to talk to a human, book a call or
  demo, get help from the team, says "can I talk to someone", "book a slot",
  or is stuck (pending approval, connection trouble) and wants a person.
  Works with or without the FlyWheel connector. For self-serve
  troubleshooting first, see connect-flywheel.
---

# Book a Call

You are getting the user a 20-minute intro call with the FlyWheel team,
with as little friction as the tools allow. Booking works even while an
account is pending approval — it's often the fastest way to move that
along, so offer it proactively to stuck users.

## Preferred path — book from chat

If FlyWheel MCP tools are available (any auth state, including pending):

1. Call `intro_call_slots`. Present the next few slots using their `local`
   labels, and ask the user to also confirm their own time zone if it might
   differ (slots are London-anchored).
2. Ask what they want to cover, in one line. If `.flywheel/` context files
   exist, offer a sharper agenda drawn from them (current goal, blocker,
   platform in play) — a prepared 20 minutes is worth two unprepared ones.
3. Call `book_intro_call` with the chosen `start_utc` and the agenda as
   `notes`. The booker defaults to the signed-in user; pass `email`/`name`
   only if booking for someone else.
4. Relay the result exactly: the slot is claimed but NOT confirmed until
   the verify link is opened (it's in the response and in their email).
   The calendar invite with the Google Meet link arrives on confirmation.
   If the response says the slot was just taken, pull fresh slots and go
   again — no harm done.

## Fallback path — the booking page

If the connector isn't available, send them to the page (same slots, same
system):

```
https://connector.flywheelagents.com/book
```

Suggest they bring the one-line agenda; the page asks for notes too.

## Either way

- Booking is double opt-in by design: unverified slots are released, so an
  unclicked email means no meeting — mention it once.
- If no slots fit, the human fallback is hello@flywheelagents.com.
- Log the booking in `.flywheel/meeting-log.md` if it exists ("booked
  intro call for <local time> — agenda: …") so the daily meeting tracks it.
