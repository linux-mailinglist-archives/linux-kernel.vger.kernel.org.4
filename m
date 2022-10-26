Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49260EBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiJZWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiJZWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:42:56 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9824E356DA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:42:54 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E4C3C489E;
        Thu, 27 Oct 2022 00:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824173;
        bh=POnUIzf1npzUTJWLJxHdqxp++JUxZ5v0ALeMnMs/AHI=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=Iehr94EQZ22V2ug75Lmq0a6rPBjGWUmgXEOkpMQcrM6/PNtWezt0LVCjwWns1EwOC
         fVT0HDU8gnFg+GzFujXo350Z2FhzcotX6EyiYkdVgx4n9p/M9Gre9g/0pi7XHZzBVD
         ltEcGBzlL4TSjDOenqTgH3Vi/nIsYVguoWS/F4m4LsrBxnPGJuKe0cLc/5cBMVldms
         +4ixaWsYrTBIn2z2VCPsYJJyI3zPo7YrCMxB5wphuImJMGU+zBCZ9Kl0LLS7+MvI2z
         XrCZ2KbhPARbRmn0j61XQarO2I76Sslq+rmrlTBRyzP+5XVtFO1sVq7RbHNVU4ciRw
         u+/jaERqmiSIJAZclPShz1MZw0Qa7PZlHGzFcG8YxeQ52QsiOg50OdBL7IFeTj2K+8
         WREzDFPaNXBmYmuiPCRD4JIR+H4SUth176ifJ8xPUufrryV4HK4ogdiawsrhh53+Un
         Tr6RE2K5g+K8d7JOmbxSUQUf1avqplF/PayqKAAGwNc3k0A8sUn2697I8HwJ78tZGx
         +14iGTmriDxP0hSljfoNm2d0WI8YohGPvJEPWdrJqKyNEzfa4v3tMZjP2StxwzQFHC
         HeS4vOfkbbYffc44fg/hIHoRAzEm6hn6LImAdGQYnjCKBpvwgmEXjoAg779DyspJiP
         vL7ES4f2G/7Pbhz5NccQNob0=
Date:   Thu, 27 Oct 2022 00:42:52 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] pcmcia: synclink_cs: remove dead paranoia_check, warn
 for missing line
Message-ID: <051083d29e5812608deb034dfa86ae0c583fee44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ainb25crrpdnzvbz"
Content-Disposition: inline
In-Reply-To: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ainb25crrpdnzvbz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MGSLPC_PARANOIA_CHECK has never been defined automatically,
and devices with null driver_info can't happen, since we reject the open
in that case

Move the log statement from dead code to the check,
and log the state inconsistency like we do above for the line count
("invalid line #%d.")

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/char/pcmcia/synclink_cs.c | 71 +++----------------------------
 1 file changed, 6 insertions(+), 65 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/syncli=
nk_cs.c
index 262f087bfc01..19b6118639b4 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -644,25 +644,6 @@ static int mgslpc_resume(struct pcmcia_device *link)
 }
=20
=20
-static inline bool mgslpc_paranoia_check(MGSLPC_INFO *info,
-					char *name, const char *routine)
-{
-#ifdef MGSLPC_PARANOIA_CHECK
-	static const char *badinfo =3D
-		"Warning: null mgslpc_info for (%s) in %s\n";
-
-	if (!info) {
-		printk(badinfo, name, routine);
-		return true;
-	}
-#else
-	if (!info)
-		return true;
-#endif
-	return false;
-}
-
-
 #define CMD_RXFIFO      BIT7	// release current rx FIFO
 #define CMD_RXRESET     BIT6	// receiver reset
 #define CMD_RXFIFO_READ BIT5
@@ -694,8 +675,6 @@ static void tx_pause(struct tty_struct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	unsigned long flags;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "tx_pause"))
-		return;
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("tx_pause(%s)\n", info->device_name);
=20
@@ -710,8 +689,6 @@ static void tx_release(struct tty_struct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	unsigned long flags;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "tx_release"))
-		return;
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("tx_release(%s)\n", info->device_name);
=20
@@ -1476,9 +1453,6 @@ static int mgslpc_put_char(struct tty_struct *tty, un=
signed char ch)
 			__FILE__, __LINE__, ch, info->device_name);
 	}
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_put_char"))
-		return 0;
-
 	if (!info->tx_buf)
 		return 0;
=20
@@ -1508,9 +1482,6 @@ static void mgslpc_flush_chars(struct tty_struct *tty)
 		printk("%s(%d):mgslpc_flush_chars() entry on %s tx_count=3D%d\n",
 			__FILE__, __LINE__, info->device_name, info->tx_count);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_flush_chars"))
-		return;
-
 	if (info->tx_count <=3D 0 || tty->flow.stopped ||
 	    tty->hw_stopped || !info->tx_buf)
 		return;
@@ -1546,8 +1517,7 @@ static int mgslpc_write(struct tty_struct * tty,
 		printk("%s(%d):mgslpc_write(%s) count=3D%d\n",
 			__FILE__, __LINE__, info->device_name, count);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_write") ||
-		!info->tx_buf)
+	if (!info->tx_buf)
 		goto cleanup;
=20
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC) {
@@ -1600,9 +1570,6 @@ static unsigned int mgslpc_write_room(struct tty_stru=
ct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	int ret;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_write_room"))
-		return 0;
-
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC) {
 		/* HDLC (frame oriented) mode */
 		if (info->tx_active)
@@ -1632,9 +1599,6 @@ static unsigned int mgslpc_chars_in_buffer(struct tty=
_struct *tty)
 		printk("%s(%d):mgslpc_chars_in_buffer(%s)\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_chars_in_buffer"))
-		return 0;
-
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC)
 		rc =3D info->tx_active ? info->max_frame_size : 0;
 	else
@@ -1658,9 +1622,6 @@ static void mgslpc_flush_buffer(struct tty_struct *tt=
y)
 		printk("%s(%d):mgslpc_flush_buffer(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_flush_buffer"))
-		return;
-
 	spin_lock_irqsave(&info->lock, flags);
 	info->tx_count =3D info->tx_put =3D info->tx_get =3D 0;
 	del_timer(&info->tx_timer);
@@ -1681,9 +1642,6 @@ static void mgslpc_send_xchar(struct tty_struct *tty,=
 char ch)
 		printk("%s(%d):mgslpc_send_xchar(%s,%d)\n",
 			 __FILE__, __LINE__, info->device_name, ch);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_send_xchar"))
-		return;
-
 	info->x_char =3D ch;
 	if (ch) {
 		spin_lock_irqsave(&info->lock, flags);
@@ -1704,9 +1662,6 @@ static void mgslpc_throttle(struct tty_struct * tty)
 		printk("%s(%d):mgslpc_throttle(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_throttle"))
-		return;
-
 	if (I_IXOFF(tty))
 		mgslpc_send_xchar(tty, STOP_CHAR(tty));
=20
@@ -1729,9 +1684,6 @@ static void mgslpc_unthrottle(struct tty_struct * tty)
 		printk("%s(%d):mgslpc_unthrottle(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_unthrottle"))
-		return;
-
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char =3D 0;
@@ -2160,9 +2112,6 @@ static int mgslpc_break(struct tty_struct *tty, int b=
reak_state)
 		printk("%s(%d):mgslpc_break(%s,%d)\n",
 			 __FILE__, __LINE__, info->device_name, break_state);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_break"))
-		return -EINVAL;
-
 	spin_lock_irqsave(&info->lock, flags);
 	if (break_state =3D=3D -1)
 		set_reg_bits(info, CHA+DAFO, BIT6);
@@ -2218,9 +2167,6 @@ static int mgslpc_ioctl(struct tty_struct *tty,
 		printk("%s(%d):mgslpc_ioctl %s cmd=3D%08X\n", __FILE__, __LINE__,
 			info->device_name, cmd);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_ioctl"))
-		return -ENODEV;
-
 	if (cmd !=3D TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
@@ -2312,9 +2258,6 @@ static void mgslpc_close(struct tty_struct *tty, stru=
ct file * filp)
 	MGSLPC_INFO * info =3D (MGSLPC_INFO *)tty->driver_data;
 	struct tty_port *port =3D &info->port;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_close"))
-		return;
-
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) entry, count=3D%d\n",
 			 __FILE__, __LINE__, info->device_name, port->count);
@@ -2352,9 +2295,6 @@ static void mgslpc_wait_until_sent(struct tty_struct =
*tty, int timeout)
 		printk("%s(%d):mgslpc_wait_until_sent(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_wait_until_sent"))
-		return;
-
 	if (!tty_port_initialized(&info->port))
 		goto exit;
=20
@@ -2412,9 +2352,6 @@ static void mgslpc_hangup(struct tty_struct *tty)
 		printk("%s(%d):mgslpc_hangup(%s)\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_hangup"))
-		return;
-
 	mgslpc_flush_buffer(tty);
 	shutdown(info, tty);
 	tty_port_hangup(&info->port);
@@ -2468,8 +2405,12 @@ static int mgslpc_open(struct tty_struct *tty, struc=
t file * filp)
 	info =3D mgslpc_device_list;
 	while(info && info->line !=3D line)
 		info =3D info->next_device;
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
+	if (!info) {
+		printk(KERN_WARNING "%s(%d):mgslpc_open: "
+			"no device for line #%d.\n",
+			__FILE__, __LINE__, line);
 		return -ENODEV;
+	}
=20
 	port =3D &info->port;
 	tty->driver_data =3D info;
--=20
2.30.2

--ainb25crrpdnzvbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZt+wACgkQvP0LAY0m
WPEx/Q//bVkUvkkalzcQenJBzVetYREcKr6YHGXrRdWbsWtgFk6DWIoRG61dX0iW
ifXRbFEkO9CD6iA0DdrHsq5i/jkBsco2SG9zscr1OUL/Y6C2y21vjR5psR8qnGvr
8ae9l7vH1CurTEEbGf1hIaK3uifjot/EvY+jEfOXnnikTsc8CvfAK0Mmvp/Bw4Ya
QuDnuCiIB3qNlqtho+75vS2WZtHrUVWjpBoUH+7LocWMuXoRud4vPInBWOxQoDfE
AUuBE2Oet2V2SI6shjvj4/J4w+2+x4P2xAebI7WvybekoiJwl6hqgtkFweY72Gxj
xqEUpcRM5WHjJg3XYNDhzO+VpYvTK1WhQelMSiEWGLlfp7GagrLZtvleFToqbV0c
Uylthu1frK6ADJEhKVfNREgL9eNJyRQ3sk228ArcqfhOt+hMteApVM6V6YTqNBpZ
7JbEAeS4QkDRGdlwmJ25AdOV98EXG7TJF6tWyffL8dz+VM+1NLHCFX9VOYV/70wu
A0PDBcodKukhKu/FlQkO6MkHTJ19QJYr847/dvNFRxqULWV0uT3CeS6g85cqWy7u
a8haLJWU3+zFi4rYHQCYn6CMC923VNz8vf3mCUFhftgYqljtfUKy+h6dUGkXQEZ9
um0G/TnE7EWCBCR1jnvLJlSHgGjHUfDAMyKX3HE5Wq+NpY4F5Q0=
=11Qt
-----END PGP SIGNATURE-----

--ainb25crrpdnzvbz--
