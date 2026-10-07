import {db,isStaff,sameOrigin,failure} from '@/lib/server';import {messagingConfig,processPending} from '@/lib/messages';import {env} from 'cloudflare:workers';
export async function POST(r:Request){try{if(!sameOrigin(r)||!await isStaff())return new Response(null,{status:403});const b:any=await r.json();if(!messagingConfig().email)return Response.json({error:'E-Mail-Versand ist noch nicht verbunden und aktiviert.'},{status:409});if(!b||typeof b.title!=='string'||!b.title.trim()||b.title.length>120||typeof b.body!=='string'||!b.body.trim()||b.body.length>5000||!/^[-a-zA-Z0-9]{16,80}$/.test(b.requestId||''))return Response.json({error:'Bitte Betreff und Nachricht prüfen.'},{status:400});const existing=await db().prepare('SELECT id FROM campaigns WHERE request_id=?').bind(b.requestId).first();if(existing)return Response.json({id:existing.id,duplicate:true});const recipients=await db().prepare("SELECT id,email,name,unsubscribe_token FROM guest_profiles WHERE newsletter='confirmed' AND email<>''").all();if(!recipients.results.length)return Response.json({error:'Noch keine bestätigten Event-Abonnenten vorhanden.'},{status:409});const id=crypto.randomUUID(),now=Date.now();const statements=[db().prepare('INSERT INTO campaigns(id,title,body,created_at,request_id) VALUES(?,?,?,?,?)').bind(id,b.title.trim(),b.body.trim(),now,b.requestId)];for(const g of recipients.results){const body=`Hallo ${g.name},

${b.body.trim()}

Liebe Gruesse
Jasmin & Patrice
Paja’s Restaurant
Unterer Grasweg 25, 67065 Ludwigshafen
01577 2960906

Du hast Eventinfos von Paja’s abonniert. Hier kannst du dich jederzeit abmelden:
${(env as any).SITE_ORIGIN}/newsletter?token=${g.unsubscribe_token}&action=unsubscribe`;statements.push(db().prepare('INSERT INTO message_jobs(id,job_key,guest_id,kind,channel,recipient,subject,body,created_at) VALUES(?,?,?,?,?,?,?,?,?)').bind(crypto.randomUUID(),'campaign:'+id+':'+g.id,g.id,'event','email',g.email,b.title.trim(),body,now));}await db().batch(statements);await processPending().catch(()=>{});return Response.json({id,count:recipients.results.length},{status:201})}catch{return failure()}}
