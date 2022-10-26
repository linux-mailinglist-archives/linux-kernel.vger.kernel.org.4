Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6E60EBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiJZWm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiJZWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:42:51 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 062DE1F9D5;
        Wed, 26 Oct 2022 15:42:50 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4B735489C;
        Thu, 27 Oct 2022 00:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824169;
        bh=z+Ch54k+gmevbiInJZ+ZMJKFOWNNhIeKTNXpceivE7M=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=eInDpVGunEUvT6dYehv5m3C8ThSDrmXAle8/b0GhcaOXgnk8vOBUNu9XLZb8+pek+
         kfdbYHXD6YjL29PPocHeAJlf72Q93tsvXtk++Mm0aOJh3VLtbSYPxD5vAkRjVvEISA
         W6dwoMyhg/uj4PVn43oBdbDNZJ4zH39CJLjQiF/hVij0Mq9wrQs3JSyVF0dYU4lIqQ
         9uP4CdzWQGvhkpvj0qBg2/LE0tKDEjkcIx1mYp3aY6t4Bo90fNr/TFzF0RkImh7jbg
         zzW2hD6nRo4DezdHay25upYcBvroLH5ob4rGsWuXijYxriKyo88uCyGbBvMzBqq7/p
         5e5lNipu/ItOeddN2EdDKYUvdwHyTOdkB9rtn+roh7K0ivwPftz9BeLaszEygqGwzK
         E0Y7wEvdr1Kw2X8soctrl8sQHoSrsK4/qADBC7r1sKWudwn0CqQ+BiDVGiOATekxyy
         /jt362ZP/qYm58AmF/4X9bmnLFspedhKOSvOtcVbgycFY6q/bIWoYAEGppF5AzJ6kl
         8jE7Krr/5WnxpvtTAHRA5wYE/Qv4+oxU3VLD9JBV0W3Ku7jW4xHNGE/fxv7isAf7h3
         hp/LETvRJpptE3Agk+qeft2GSVtkoxZgCDD8xT8yWqDLDjnykmJEtrJGkPs1nFN0LP
         /0mpI/ZPHJZmMuBoXpOZNvhQ=
Date:   Thu, 27 Oct 2022 00:42:48 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH 03/15] pcmcia: synclink_cs: remove MGSLPC_MAGIC
Message-ID: <c909c36218b0d4b5888b41f9af18e763a5b36dcf.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="giavft5aq6szb66s"
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


--giavft5aq6szb66s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MGSLPC_PARANOIA_CHECK has never been defined automatically,
and in the context of magic numbers as defined in magic-number.rst,
"the tty layer should not need this"

This is 100% dead cruft, and we have better debugging tooling nowadays:
kill it

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                 |  1 -
 .../translations/it_IT/process/magic-number.rst        |  1 -
 .../translations/zh_CN/process/magic-number.rst        |  1 -
 .../translations/zh_TW/process/magic-number.rst        |  1 -
 drivers/char/pcmcia/synclink_cs.c                      | 10 ----------
 5 files changed, 14 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index a4414b7e15aa..18f8b1e3a993 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -72,7 +72,6 @@ PG_MAGIC              'P'              pg_{read,write}_hd=
r      ``include/linux/
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index f51c5ef9d93f..827167b18f15 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -78,7 +78,6 @@ PG_MAGIC              'P'              pg_{read,write}_hd=
r      ``include/linux/
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 3b53bd67e41b..9553475e9867 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -61,7 +61,6 @@ PG_MAGIC              'P'              pg_{read,write}_hd=
r      ``include/linux/
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 7d176a87ec3c..8a64f56ae267 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -64,7 +64,6 @@ PG_MAGIC              'P'              pg_{read,write}_hd=
r      ``include/linux/
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/syncli=
nk_cs.c
index b2735be81ab2..262f087bfc01 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -137,7 +137,6 @@ struct _input_signal_events {
 typedef struct _mgslpc_info {
 	struct tty_port		port;
 	void *if_ptr;	/* General purpose pointer (used by SPPP) */
-	int			magic;
 	int			line;
=20
 	struct mgsl_icount	icount;
@@ -228,8 +227,6 @@ typedef struct _mgslpc_info {
=20
 } MGSLPC_INFO;
=20
-#define MGSLPC_MAGIC 0x5402
-
 /*
  * The size of the serial xmit buffer is 1 page, or 4096 bytes
  */
@@ -525,7 +522,6 @@ static int mgslpc_probe(struct pcmcia_device *link)
 		return -ENOMEM;
 	}
=20
-	info->magic =3D MGSLPC_MAGIC;
 	tty_port_init(&info->port);
 	info->port.ops =3D &mgslpc_port_ops;
 	INIT_WORK(&info->task, bh_handler);
@@ -652,8 +648,6 @@ static inline bool mgslpc_paranoia_check(MGSLPC_INFO *i=
nfo,
 					char *name, const char *routine)
 {
 #ifdef MGSLPC_PARANOIA_CHECK
-	static const char *badmagic =3D
-		"Warning: bad magic number for mgsl struct (%s) in %s\n";
 	static const char *badinfo =3D
 		"Warning: null mgslpc_info for (%s) in %s\n";
=20
@@ -661,10 +655,6 @@ static inline bool mgslpc_paranoia_check(MGSLPC_INFO *=
info,
 		printk(badinfo, name, routine);
 		return true;
 	}
-	if (info->magic !=3D MGSLPC_MAGIC) {
-		printk(badmagic, name, routine);
-		return true;
-	}
 #else
 	if (!info)
 		return true;
--=20
2.30.2

--giavft5aq6szb66s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZt+cACgkQvP0LAY0m
WPGU2g//ealvvVdNSk/+j901xtE1Cn9QAl98lXslGQsYfilZkbInrouwago5FJ12
w0A4HDWLv06lawk1BcZof2bpTkVK3oyLs/zy94ZwTi8WOC1HkKArulk0w4YHe0AE
jt/tA+FMQAYzcMBdtkKfsQZ+YYNjyUCVWW4xHwak6/tndMEtEnnPuHQbWcRvi6Kw
iyt3C28j3hnRq8ZkRmSnbNc1IHmuo/ULgROhn83SuX5OUnHIIRn8EoMvSg44CpUP
3c1nJNjv3GW32/8EDumTFGKpGVFr6kqHqX8x8AZd+EpuVBaLuQ+LyxJs52ByE3lL
q3CFT0VmsCVf8JMqXyqMbJl1oSo4EeF2RI494nsiR4vduDtWbr2lg6qqPfvzXl7C
iECR1OfZ9svLjyQ3INqG1GL0Tw46P5HGkqtl+ScoAdDoxgsXKFyA+VhEoVlyII3n
FBKaBDsv6J89fU5w+tdwnvl/dybLgUICigUCGQupyGpXFgf2ruCOGiBPPf3uXH4F
V82MdEiTDXaihwbRN3K5kxoO4B4krANkjRmUlGlHtvtki6q/fMNs3/cby9+/WFjb
mYpBBrPS0sG0+Abtf5s4qOhxvidFMv0gz1zHoqwQB9uR6awbNop5tIuiCorE/tsY
VRVUBF3LeYei5ykJydNDratNNzzab4KgMNQX7FqCobk3VBCmOpg=
=Eazf
-----END PGP SIGNATURE-----

--giavft5aq6szb66s--
