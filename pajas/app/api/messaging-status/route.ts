import {messagingConfig} from '@/lib/messages';export async function GET(){const c=messagingConfig();return Response.json({email:c.email,sms:c.sms},{headers:{'Cache-Control':'no-store'}})}
