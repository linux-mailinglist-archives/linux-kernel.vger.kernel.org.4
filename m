Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E269624F54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKKBOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiKKBOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:14:03 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F3DC19025;
        Thu, 10 Nov 2022 17:13:51 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E1BE8830;
        Fri, 11 Nov 2022 02:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129230;
        bh=2qw6TvHBv7fuk35THthOMAX/8jL0jt7zA08jqmpyNqA=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=KUADlVZ00qHvy8pFOiMs8eB0n6a0OfHjICx8XT1wT+TcjVOmYhPX8yH8AVbZGH6ot
         SxUnGNUhN2L+n/PTFQ2L9R8OnZofF6d0bg7u1Co/VEPDxqokeFggFdFouBvHcZq7sp
         OgSDq2aYxQpfbeFdoo1kbxYozVYVU8Mne3+Ri6f4r4YG7cqsR+3KRl1RnMCpAlxPao
         mNkmqvoqcrgEVTG/7l6+HNaZQov651BUMmiVE0S3psyIknmENaR3Ebf5qDJ21tzTO9
         xcm7lf0uf70xQQ2HTwozxE8MGNY9C/LCqhr2iafUnbIWQFn+UGWJiQn5Xnq38zSocG
         p6oAirCizknSA==
Date:   Fri, 11 Nov 2022 02:13:49 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v3 03/15] pcmcia: synclink_cs: remove MGSLPC_MAGIC
Message-ID: <eeef314de1dd0d645821e7d582d13fdb33c48b20.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4nxk345g5c234jre"
Content-Disposition: inline
In-Reply-To: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nxk345g5c234jre
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

--4nxk345g5c234jre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtoc0ACgkQvP0LAY0m
WPEEjRAAqsTyU1bpqazHB7yZ7GExfBT6q2C25YhYlEe9IjSio8GZ0s6I9zQcpAiw
q/FbRqQjbag3WB478vSINkwjx8tGu3wMHhfgfOARH0qXs8W3zg1WJ0ScX020TUuy
s5IftTXIqRVIZvzjqMn/88x944diSyH4ayB8Oz8yn0TpL8FUU0Dl2FLAoxyz8V9j
eGD6tLDPVEv2zZzB9xb3+t4QKIsz9aM6jfmJ/Ycgojx/Ar/nlk22b+miUbKuThXW
A4Pw//obEYJ4VOruLJh8qioA3G1tcQ/TyxTTjCKcd0gfIJAki1TtWNKRiSjHDhB7
nedhU4fvxnDil+sbBPl2qhNvfaun/1L4xESLx6dUuPaK6tprlwsv3NOI00xxNi+x
/rUq4v9CyOb1rAof3LjTL4nC8aqfFD0zTisnH3F4OO5n+fPxvw4QEmLC23JLsTWT
jIBWBr4Js4M9J8/aw7VP9WrC0Oyy7ntAu/MIaV1hY9RUDFRpMc3E2taXiA1Bqe4t
o0jIap3fPMoQlsw1O5Z/Qpx9U6n9FPmWnyiDTdHcAcNCXn+C2CDfAhe8sQOd5tXm
0h+tyWqDlZIWMyeYI64iNHUqyC5yq4OXbc7iSrekhRRQKBAv0GL9Cf+u3KnPCgoQ
Ol/E/RCoFF21Mj+H7NG0b2pTOvX0I4w5lwEPMIlLcDnU4FBJk24=
=Zx0p
-----END PGP SIGNATURE-----

--4nxk345g5c234jre--
