CREATE TABLE `orders` (
	`id` text PRIMARY KEY NOT NULL,
	`created_at` integer NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`plate` text NOT NULL,
	`note` text NOT NULL,
	`items` text NOT NULL,
	`total` integer NOT NULL,
	`status` text DEFAULT 'eingegangen' NOT NULL,
	`pickup` text DEFAULT '' NOT NULL,
	`invoice` integer DEFAULT 0 NOT NULL,
	`idempotency` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `orders_idempotency_unique` ON `orders` (`idempotency`);--> statement-breakpoint
CREATE TABLE `settings` (
	`id` text PRIMARY KEY NOT NULL,
	`value` text NOT NULL
);
