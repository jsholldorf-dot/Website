CREATE TABLE `reservations` (
	`id` text PRIMARY KEY NOT NULL,
	`created_at` integer NOT NULL,
	`date` text NOT NULL,
	`time` text NOT NULL,
	`guests` integer NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`note` text NOT NULL,
	`status` text DEFAULT 'angefragt' NOT NULL,
	`idempotency` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `reservations_idempotency_unique` ON `reservations` (`idempotency`);