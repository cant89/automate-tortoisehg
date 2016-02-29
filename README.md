TORTOISE HG AUTOMATE BRANCHING
======

Bat to automate new branch flow in Mainteinance.

## INSTALL

1. Copy bat files wherever you want
2. Run TortoiseHg ad go to File -> Settings, then select Tools form the left side of the opened window
3. From the "List of all tools" add a new task for start-work with these options(replace also squares brackets):
	```js
	tool name = start-work
	command = start [path-to-the-start-work-file-on-your-drive] {ROOT} {REV}
	```

	and another new one task for end-work with these options:

	```js
	tool name = end-work
	command = start [path-to-the-end-work-file-on-your-drive] {ROOT} {REV}
	```

4. Select both commands and click "Add to list" button
5. Then press OK and restart Tortoise
6. Enjoy


******************************************************************

## BAT #1 - START WORK

Bat to execute at the begin of a new work.
These are the operations that are running:

0. Ask to the user for the new branch name
1. Pull
2. Update to default
3. Create new branch
4. Commit (empty) -  necessary to create the new branch


## BAT #2 - END WORK

Bat to execute at the end of our work flow, and it will merge our working branch into Maintenance
These are the operations that are running:

0. Check position != default & Maintenance
1. Pull
2. Update to last commit of current branch and eventually merge
3. Commit
4. Update Maintenance
5. Merge branch with Local (Maintenance)
6. Commit
7. Update to default

******************************************************************

## FAQ

1. Posso iniziare una nuova lavorazione inserendo come nome del branch quello di un branch già esistente, creato in precedenza?

	No. Per quanto Tortoise non restituisca errori in prima battuta nella creazione di branch con lo stesso nome, darà errori in fase di push, avendo il branch due teste.
	La procedura corretta è fare un update manuale al branch di riferimento ed eseguire commit manuali.

2. Se nel Merge del Branch con Maintenance nascono dei conflitti, cosa succede?

	In automatico si apre di default Beyond Compare 4, se usi un'altro tool scrivici.
	n.b: in futuro sarà possibile scegliere il proprio tool di conflitto.

3. E' normale che non vengano fatti i Push in automatico?

	Si, assolutamente! Il bat agisce al 100% in locale, ogni push è volutamente lasciato all'utente per ragioni di sicurezza.
