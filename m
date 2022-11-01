Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA16155D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKAXGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKAXFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:43 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D2B201B4;
        Tue,  1 Nov 2022 16:05:41 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EFFC14EF2;
        Wed,  2 Nov 2022 00:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343941;
        bh=lR8M22hMDuWVHgEQasSfSc+6twHse9gvApvhgLw5hgk=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=LbFzW3tI/aQnkUbAh0fMtVsgclhaPJJyU9odpcUVRzyodlRf3Am5SAzJoBM/whsda
         4UpP9Goexk+DmUfs/zsVXdcuaOTCvqRPPwOMJ+H2fRmNBT/G/whLJQnmdwNLx9/oYU
         /uF57j99pwX1PKiHqzCZQdk4OMdWzrzi6iLEP91MMETk8wdmrtmPB22XYnUP8GFMXT
         Zp9+LQcIZyETucailYMzJlMni7scUIz3mB+yPevsBoB7EFENNpSeWicJJP83OXP0Cb
         Zk9MMr2SIXB8T7WH6AqK0bh95TF5/YcgV884yvkmIC4leJsWuUrdH5COE+rdmH/0+R
         hnUsdlIcDyV08TKShotui7i2cESKZNNqDnFAaQ7zXzIZwD3ZeX+uOE8+HLVIl39NpB
         3r4p8lLoR9/+Vhp0ycdWskDG/tCxAKw3FuNQlvNft86QXQnD2dY7O4j39Ir2Pfuw6K
         k7KtdMBXJZIpIFCLQVbX8ejXN8CU6ZtCxvL2ZXlwLw9U+s09PxBsfwwceFbIjokHZ1
         nUig8mCUMb8CC64+BpWlO2E3gli9+SAxjSxaBMj7EjWgj2JN3LDl+cmmjNzaKbVFFX
         MHIJwQC/e+xjSF/uAQ1vRjly9UWORGu5pgYZshuMwY7kbp2/09OkzxGa8QKvdrTy4K
         78Qq3jEGSmAGKjbDG82AM3fM=
Date:   Wed, 2 Nov 2022 00:05:39 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v2 09/15] x86/APM: remove APM_BIOS_MAGIC
Message-ID: <16e8d8d655122eecca13dea536f637923b7dfc88.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lg7rmmzm5xclhche"
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


--lg7rmmzm5xclhche
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach, and we have better
debugging instrumentation nowadays: kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                   | 1 -
 .../translations/it_IT/process/magic-number.rst          | 1 -
 .../translations/zh_CN/process/magic-number.rst          | 1 -
 .../translations/zh_TW/process/magic-number.rst          | 1 -
 arch/x86/kernel/apm_32.c                                 | 9 +--------
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index d8ffbc21872e..77a96a79c7e8 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -68,7 +68,6 @@ Changelog::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Magic Name            Number           Structure                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 0e59704aa617..ef509265a3df 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -74,7 +74,6 @@ Registro dei cambiamenti::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Nome magico           Numero           Struttura                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 17a73661ef17..6437c408dd67 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -57,7 +57,6 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 9d44d49b93bf..453cc205e6c3 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -60,7 +60,6 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 60e330cdbd17..f3dd21dc56b7 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -330,7 +330,6 @@ extern int (*console_blank_hook)(int);
  * The per-file APM data
  */
 struct apm_user {
-	int		magic;
 	struct apm_user *next;
 	unsigned int	suser: 1;
 	unsigned int	writer: 1;
@@ -346,11 +345,6 @@ struct apm_user {
 	apm_event_t	events[APM_MAX_EVENTS];
 };
=20
-/*
- * The magic number in apm_user
- */
-#define APM_BIOS_MAGIC		0x4101
-
 /*
  * idle percentage above which bios idle calls are done
  */
@@ -1459,7 +1453,7 @@ static void apm_mainloop(void)
=20
 static int check_apm_user(struct apm_user *as, const char *func)
 {
-	if (as =3D=3D NULL || as->magic !=3D APM_BIOS_MAGIC) {
+	if (as =3D=3D NULL) {
 		pr_err("%s passed bad filp\n", func);
 		return 1;
 	}
@@ -1616,7 +1610,6 @@ static int do_open(struct inode *inode, struct file *=
filp)
 	if (as =3D=3D NULL)
 		return -ENOMEM;
=20
-	as->magic =3D APM_BIOS_MAGIC;
 	as->event_tail =3D as->event_head =3D 0;
 	as->suspends_pending =3D as->standbys_pending =3D 0;
 	as->suspends_read =3D as->standbys_read =3D 0;
--=20
2.30.2

--lg7rmmzm5xclhche
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpkMACgkQvP0LAY0m
WPE0WA/+MYKfAHrpoMpQEkahSkd0fH8diZ+3KUAuwY34VC2y6jw8x3QGTIvwXBxF
mJqJLMDZCAT4udZGCA95047sG+O0w81EhpD5DQwhBP15aIPINpyZOwUjSh8zlkl+
Hjv9UBjb16Eg/3icp/TSc5NQOuFj/p2sBo2pCoktHA2JT49HK8bN0hpoozU/QJvd
L3t/Z61fpvNixTw1toHiMZ+UnETqUZyQkEA/JlRznvMI8XV1FCsbFkUzYE30ta0d
uHTgVRcVdD1PUENIL5RBhMnL0B1emFKnYyYlKa9HZjWhoeH8msUKDiLVGbhbHlEO
Pd1KonVJxFeWDUxA4WteSHTgr/iODa58lzF3OKGWI0Elp7Jc+AJPIjdGiM1fTxOs
G6xlcc05MsYeFHpOam7R4OijV+KNkQ67eKUdjOAzyPhFwmHlUhV1U+DkEgXZHm9b
VkBz2qg4A538KO0z4MHsm1GOPpApV4WPmyuzkk+V/As/UtIDhnC1mOUNftoT67EP
gXH5397lQ47isvXGklN7nJL1LzyeNyYvznsVsGgPTR3co5uCE7iovzYGus1LUBns
qS+dCXWq3Fwzc78naveUJceP2yzjjrwlZvNiuBN71WCOgkDQ3ck3ONaDdf1ZSgtM
K2OXR/3R9d7iMKkOkStNMf90w8nNSkS59CSPT9CBdQxsyGg4o0s=
=OI5K
-----END PGP SIGNATURE-----

--lg7rmmzm5xclhche--
