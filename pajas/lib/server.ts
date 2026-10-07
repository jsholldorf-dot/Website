import { env } from "cloudflare:workers";
import { cookies } from "next/headers";
import { getChatGPTUser } from "@/app/chatgpt-auth";
export function db(){const binding=(env as any).DB;if(!binding)throw new Error("Speicher nicht verfügbar");return binding;}
export async function config(){const rows=await db().prepare("SELECT id,value FROM settings").all();return Object.fromEntries(rows.results.map((r:any)=>[r.id,r.value]));}
export async function signature(userId:string){const secret=(env as any).SESSION_SECRET;if(!secret)throw new Error("Teamzugang nicht eingerichtet");const key=await crypto.subtle.importKey("raw",new TextEncoder().encode(secret),{name:"HMAC",hash:"SHA-256"},false,["sign"]);return Array.from(new Uint8Array(await crypto.subtle.sign("HMAC",key,new TextEncoder().encode(userId)))).map(b=>b.toString(16).padStart(2,"0")).join("");}
export async function isStaff(){const user=await getChatGPTUser();if(!user)return false;return (await cookies()).get("pajas-team")?.value===await signature(user.userId);}
export function sameOrigin(r:Request){return r.headers.get("origin")===new URL(r.url).origin;}
export function failure(){return Response.json({error:"Das hat gerade nicht geklappt. Bitte erneut versuchen oder uns anrufen."},{status:503});}
