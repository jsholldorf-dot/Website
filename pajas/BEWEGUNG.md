# Bewegung & Feedback

Überarbeitung nach dem Skill `emil-design-eng`. Optik, Texte, Bestellung und Reservierung sind unverändert. Geändert wurde nur, wie sich die Seite beim Benutzen anfühlt.

| Vorher | Nachher | Warum |
| --- | --- | --- |
| Hover-Farben gelten auch auf Handys (`.add-dish:hover` usw.) | Hover nur bei `@media (hover: hover) and (pointer: fine)` | Auf dem Handy blieb der „+“-Knopf nach dem Antippen dunkel stehen |
| Keine Reaktion beim Drücken von Buttons | `:active { transform: scale(.97) }`, beim runden „+“ `scale(.94)` | Der Gast spürt sofort, dass der Tipp angekommen ist |
| Warenkorb-Panel: `ease-in-out`, 500 ms auf, 300 ms zu | iOS-Drawer-Kurve `cubic-bezier(.32,.72,0,1)`, 400 ms auf, 250 ms zu | `ease-in-out` startet zäh. Schließen soll schneller sein als Öffnen |
| Dialoge und Auswahlmenüs mit Standard-`ease` | Starke `ease-out`-Kurve `cubic-bezier(.23,1,.32,1)`, Schließen in 150 ms | Sofortige Bewegung fühlt sich schneller an, bei gleicher Dauer |
| Schwebender Warenkorb-Button erscheint schlagartig | Gleitet in 450 ms von unten herein | Neue Elemente sollen nicht aus dem Nichts auftauchen |
| Artikelzahl im Warenkorb wechselt ohne Hinweis | Die neue Zahl rutscht kurz von unten herein (220 ms) | Bestätigt: „Gericht liegt im Warenkorb“ |
| Mobiles Menü springt auf | Kurzes Einblenden mit 6 px Bewegung (200 ms) | Weniger hart, trotzdem schnell |
| Uhrzeit-Felder der Reservierung wechseln die Farbe hart | Farbübergang 150 ms plus Druck-Feedback | Die Auswahl wirkt ruhig und eindeutig |
| Speisekarten-Tabs mit `transition-all` | Nur die Textfarbe wird animiert, die Inhalte wechseln sofort | Tabs werden oft geklickt. Dort bremst jede Animation |
| Startbereich erscheint auf einmal | Texte kommen gestaffelt (60 ms Abstand), das Foto blendet weich ein | Einmaliger Moment beim Laden, der die Seite hochwertiger wirken lässt |
| `prefers-reduced-motion` schaltet alles ab | Keine Bewegung mehr, nur noch sanftes Ein- und Ausblenden | Weniger Bewegung heißt nicht null Rückmeldung |
| Schließen-Knopf für Screenreader auf Englisch („Close“) | „Schließen“ | Die Seite ist deutsch |

## Geänderte Dateien

- `app/globals.css`: Easing-Kurven, Hover-Abfrage, Druck-Feedback, Einblendungen, reduzierte Bewegung
- `app/page.tsx`: Artikelzahl im Warenkorb-Button animiert beim Ändern (eine Zeile)
- `components/ui/dialog.tsx`, `components/ui/sheet.tsx`, `components/ui/select.tsx`: Kurven und Dauern, deutscher Schließen-Text
