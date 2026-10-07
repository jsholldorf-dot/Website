CREATE TABLE `campaigns` (
	`id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`body` text NOT NULL,
	`created_at` integer NOT NULL,
	`request_id` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `campaigns_request_id_unique` ON `campaigns` (`request_id`);--> statement-breakpoint
CREATE TABLE `consent_events` (
	`id` text PRIMARY KEY NOT NULL,
	`guest_id` text NOT NULL,
	`event` text NOT NULL,
	`time` integer NOT NULL,
	`text` text NOT NULL,
	`source` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `guest_profiles` (
	`id` text PRIMARY KEY NOT NULL,
	`contact_key` text NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`email` text NOT NULL,
	`saved_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`retention` integer DEFAULT 0 NOT NULL,
	`newsletter` text DEFAULT 'none' NOT NULL,
	`requested_at` integer,
	`confirmed_at` integer,
	`revoked_at` integer,
	`confirm_token` text NOT NULL,
	`unsubscribe_token` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `guest_profiles_contact_key_unique` ON `guest_profiles` (`contact_key`);--> statement-breakpoint
CREATE UNIQUE INDEX `guest_profiles_confirm_token_unique` ON `guest_profiles` (`confirm_token`);--> statement-breakpoint
CREATE UNIQUE INDEX `guest_profiles_unsubscribe_token_unique` ON `guest_profiles` (`unsubscribe_token`);--> statement-breakpoint
CREATE TABLE `message_jobs` (
	`id` text PRIMARY KEY NOT NULL,
	`job_key` text NOT NULL,
	`guest_id` text,
	`kind` text NOT NULL,
	`channel` text NOT NULL,
	`recipient` text NOT NULL,
	`subject` text NOT NULL,
	`body` text NOT NULL,
	`status` text DEFAULT 'queued' NOT NULL,
	`created_at` integer NOT NULL,
	`accepted_at` integer,
	`send_day` text DEFAULT '' NOT NULL,
	`provider_id` text,
	`error` text DEFAULT '' NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `message_jobs_job_key_unique` ON `message_jobs` (`job_key`);--> statement-breakpoint
CREATE INDEX `idx_message_jobs_status_created` ON `message_jobs` (`status`,`created_at`);--> statement-breakpoint
ALTER TABLE `reservations` ADD `email` text DEFAULT '' NOT NULL;--> statement-breakpoint
ALTER TABLE `reservations` ADD `sms_notify` integer DEFAULT 0 NOT NULL;