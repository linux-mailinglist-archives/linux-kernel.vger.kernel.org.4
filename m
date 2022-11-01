Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C656155CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKAXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKAXFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:25 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA6AD201B6;
        Tue,  1 Nov 2022 16:05:14 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 364744EDC;
        Wed,  2 Nov 2022 00:05:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343914;
        bh=+UKsAgRkYwH0P7LvkS7eTSehZSfe3qZMT/OrdLiAgRQ=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=BOtOuXSaZ5DQvmBE5tVcDRKYynMHpX4YonAA4WKIe5cJWUZV91jAkUS8M3wgMhwem
         hbZ2+HIv/WZrpW/LxznzOWtDeeR/i3VaU4voW0FHWaTTkkAwql3Bo7Nrat2CXx0xw7
         oip5KYOSVMZO4ZOa9LScUP0oLvsprica7wx221C8bIxLd3rLChWbh8QeSQeTgGr2Rp
         QmFvYutz4sjvGa7k2MBuY/SKArkn+PiMwNjUgMbMQihQ+Q/k+HKVZIr+FQb4FU/sQm
         nlqFQZYiK+7yRxSfJwppVA1U7I3az/07LiRbm4GFhwQcY8uAfkTc3k2lvBSkUfhXQ2
         8pJ8qr7MH1VGa5cOLp4ZUwIjCIF8SsRYGO9QYVNXuIQTfDcPL6BzOuI6epIpuE1haw
         9UgqHuJf0ypYO3FEvxZ7t51fnZUuPwicIXJzycf1pBmJaOddwqWPI3OnLpM6WSk65e
         qGywaT3VBCxqdcyhsf7qJCDRkiq9OONteJwWiLPQ9His4TjwWSzMXe3z2aA3xyVq6d
         SAXHyyJmqCqD9tuE2o/Cnx9SIzxNcn+0HvNgl4wTr/5jTetWbEOYILN1B5Kngese2l
         ALLWcRit1+Ps7BMJSYvyf2AD9CxphKbXJd2KhVazOG7reTk8ZDbh1WFSRvH10cnTdJ
         MgCq+qmiL/MGb2/2PDomCRmE=
Date:   Wed, 2 Nov 2022 00:05:13 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v2 03/15] pcmcia: synclink_cs: remove MGSLPC_MAGIC
Message-ID: <97d4e73a458993348cf46711c63cbbb53b65ebdd.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6azsrycbuw2xj4i"
Content-Disposition: inline
In-Reply-To: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l6azsrycbuw2xj4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MGSLPC_PARANOIA_CHECK has never been defined automatically, and in the
context of magic numbers as defined in magic-number.rst, "the tty layer
should not need this".

This is 100% dead cruft, and we have better debugging tooling nowadays:
kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
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

--l6azsrycbuw2xj4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpigACgkQvP0LAY0m
WPFkVg/+KjNmB+44jaSrXKBBdtrCYlo7gEomdRaHDA6WBY5z/tsFKb/WuKwsvw0e
J21q9T5+kLR7JDFrNR5KVkymQ75+zUvb5iaoyw/QhbQkpn9lMwrC/bji+8eee+jU
waKKEHuwT5/ZCVRUkAlizwUlYsbDUOBD3eY8cXw0/lfxMtiLXT7GwDjXMhslJvxQ
RO7brEhT6aehJFxpwT43BGAvFRlLbj81R+FpsySmFU58fMeFSfFN6B9wMQWXiN+O
b6v/dgjXh5xPf+73dIMQYHGMFHy0gTeMXkkqPRfcD8Aaz/MXHnOfwL5cPyhvHhwC
oLazWxizV2oVS5tZoC8M5y+4GXbYV1XTarZ5G0WPTY6FH0crrl6SBBDjkH6jY9Ja
HEmH2BEsgmn2TtAjd+OPhC/kW7frivyUv617a+RjhILU25hVDb/CiWD/T/QVFVRw
yseqGeEEwsrTRCRmI1bMlP5l6Fs92E2tli8k+MUA0+MHvb6ErXYkafbN8wlQ46wi
RkdB+Pxxc958B0Qh9tSysF0HozAwL41PAFfo7ceY4jZTib37KlCG+DmlvAE3+e0h
laOnBc5K1GA1ZpH8WJGbthRTvi1zaqOG4i7j/ZNhVfmvRg1LgXxgZ16LF3kjw+/m
Oez6fNrJkFdIj0VC5rlggRXqBe5serezE8xFVOdKvBVNCT1cSnk=
=a4++
-----END PGP SIGNATURE-----

--l6azsrycbuw2xj4i--
