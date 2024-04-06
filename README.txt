This script is actually made for a German server but is tested from scratch in English. Other languages like Spanish, French or Russian have been translated by a translator (DeepL) and I do not provide official support for them. I also do not provide support for code changes. If you would like to contribute, please contact me via ticket in Discord.



DEV THINGS ON GERMAN:

Stand: 06.04.2024

Phantom Gaming - Custom System

- Checkt nach Updates auf GitHub
- Sucht bei Connect in Datenbank nach Name und Discord ID (Whitelist)
- VPN Check bei Spieler die in der Datenbank stehen um abfragen zu minimieren
- Updatet IP des Spielers bei jedem Join



Todo's:

Whitelist System:

    DATABASE:
        - Aktuelle Ingame ID in DB hinzufügen bei join

    Server-Side:
        - Warteschlange; Ein nach anderem, jede 10 Sekunden. Falls Server voll Warten auf freien Platz.

    Client-Side:
        - Ban Player Command