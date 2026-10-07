import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = {title:"Paja’s Restaurant · Ludwigshafen-Maudach",description:"Hausgemachte Küche, gemeinsame Zeit und Essen zur Abholung. Willkommen bei Jasmin und Patrice in Paja’s Restaurant.",icons:{icon:"/favicon.svg"}};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="de"><body>{children}</body></html>}