Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA36155D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKAXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKAXFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:33 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CC76272;
        Tue,  1 Nov 2022 16:05:32 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 158FF4EEC;
        Wed,  2 Nov 2022 00:05:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343932;
        bh=onPrRQdppdHaN8PzCdalvAsxdBD2D0jz8MicPGoWdmg=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=b3f5rcxdg4kwk2OpjLmmaULacqRKIiOV+GgAzhWHDBgeP8fZAfFvHOPLVY0o3hKm4
         1kzDthvJizDM7i18SrvXXH2K2OKI0rGYLmr+dip1ZAN6xt5u7JPdKYtrcRDoTJBE6I
         qrBLM56gLlrsSpPq3b6u102ILInzxjn4T7PxLoGwGq9Z5GBkYr/tueochFiBPJ5Qt9
         +CN1IkRl2pQqS6L65dR4xGPNiIPuaolZH+lU7HZoaDJygZ0KrB8K2SkDa6gDRtlkv/
         yS18wibSQA/ukpkgrCjm+k83uElbZ7a9J4UYCP373njzX3G2uoNIX1zBgz9bnMW4RO
         P76rXCprUZzp7seAoqR7XzegmTK+NR1OL1apOdck/G+Ujqp/8A0es9I6iQyEGgPv5x
         bSRfNFitwjjZTXrSeRBDOV0jqk8n75XLVGYQmJ/m85prleq+tDVGlqkTp4AeVyRPmb
         GhtEF4fycfBxe9UkmB0tUOHIv/fEWwMREh6ziBV+GEJygAeg3QgLwI3vSlJTRQFw2f
         FW9unM6wVUcLH1Qw3NLDlQY1mrwIFvpKVPI67zqIspebfIylBjlT+xxh/rUHqT6iiN
         QqpW359gPHsS6zt2oVAme+KQIc77JbJfoFXgf9CO95mpr3Xx1R5uu+GdJSXDisdBJS
         szhVq3s734GqqkkzyKxI6p1U=
Date:   Wed, 2 Nov 2022 00:05:30 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 07/15] MIPS: IP27: clean out sn/nmi.h
Message-ID: <534e0e7e4f2b0cc1cb35d5024192473635ed1b94.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fnyakdsammmxp4xy"
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


--fnyakdsammmxp4xy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only user is arch/mips/sgi-ip27/ip27-nmi.c; this file was imported
wholesale in 2.3.99pre9-1, and received only whitespace updates since
then.

NMI_MAGIC isn't a magic number; it's unclear if it's actually used by
the firmware in some capacity or if it's a holdover from copying the SGI
code, but in the former case it's API and in the latter it's dead cruft.

Lack of QEMU support makes this unvalidatable without the hardware,
so leave it in.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst        |  1 -
 .../it_IT/process/magic-number.rst            |  1 -
 .../zh_CN/process/magic-number.rst            |  1 -
 .../zh_TW/process/magic-number.rst            |  1 -
 arch/mips/include/asm/sn/nmi.h                | 60 -------------------
 5 files changed, 64 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 62a3a2113e7c..7dada7abc733 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -76,5 +76,4 @@ KV_MAGIC              0x5f4b565f       kernel_vars_s     =
       ``arch/mips/incl
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index b20a54ee6fb2..f9634a04d349 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -82,5 +82,4 @@ KV_MAGIC              0x5f4b565f       kernel_vars_s     =
       ``arch/mips/incl
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index e7781ab923f7..966b9e6b1a46 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -65,5 +65,4 @@ KV_MAGIC              0x5f4b565f       kernel_vars_s     =
       ``arch/mips/incl
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 5cc0bfa97d9d..f3e87a6b3a01 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -68,5 +68,4 @@ KV_MAGIC              0x5f4b565f       kernel_vars_s     =
       ``arch/mips/incl
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/arch/mips/include/asm/sn/nmi.h b/arch/mips/include/asm/sn/nmi.h
index 12ac210f12a1..0bd9458fc804 100644
--- a/arch/mips/include/asm/sn/nmi.h
+++ b/arch/mips/include/asm/sn/nmi.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_SN_NMI_H
 #define __ASM_SN_NMI_H
=20
-#include <asm/sn/addrs.h>
-
 /*
  * The launch data structure resides at a fixed place in each node's memory
  * and is used to communicate between the master processor and the slave
@@ -29,14 +27,6 @@
  */
=20
 #define NMI_MAGIC		0x48414d4d455201
-#define NMI_SIZEOF		0x40
-
-#define NMI_OFF_MAGIC		0x00	/* Struct offsets for assembly	    */
-#define NMI_OFF_FLAGS		0x08
-#define NMI_OFF_CALL		0x10
-#define NMI_OFF_CALLC		0x18
-#define NMI_OFF_CALLPARM	0x20
-#define NMI_OFF_GMASTER		0x28
=20
 /*
  * The NMI routine is called only if the complement address is
@@ -48,8 +38,6 @@
  *
  */
=20
-#ifndef __ASSEMBLY__
-
 typedef struct nmi_s {
 	volatile unsigned long	 magic;		/* Magic number */
 	volatile unsigned long	 flags;		/* Combination of flags above */
@@ -59,14 +47,10 @@ typedef struct nmi_s {
 	volatile unsigned long	 gmaster;	/* Flag true only on global master*/
 } nmi_t;
=20
-#endif /* !__ASSEMBLY__ */
-
 /* Following definitions are needed both in the prom & the kernel
  * to identify the format of the nmi cpu register save area in the
  * low memory on each node.
  */
-#ifndef __ASSEMBLY__
-
 struct reg_struct {
 	unsigned long	gpr[32];
 	unsigned long	sr;
@@ -78,48 +62,4 @@ struct reg_struct {
 	unsigned long	nmi_sr;
 };
=20
-#endif /* !__ASSEMBLY__ */
-
-/* These are the assembly language offsets into the reg_struct structure */
-
-#define R0_OFF		0x0
-#define R1_OFF		0x8
-#define R2_OFF		0x10
-#define R3_OFF		0x18
-#define R4_OFF		0x20
-#define R5_OFF		0x28
-#define R6_OFF		0x30
-#define R7_OFF		0x38
-#define R8_OFF		0x40
-#define R9_OFF		0x48
-#define R10_OFF		0x50
-#define R11_OFF		0x58
-#define R12_OFF		0x60
-#define R13_OFF		0x68
-#define R14_OFF		0x70
-#define R15_OFF		0x78
-#define R16_OFF		0x80
-#define R17_OFF		0x88
-#define R18_OFF		0x90
-#define R19_OFF		0x98
-#define R20_OFF		0xa0
-#define R21_OFF		0xa8
-#define R22_OFF		0xb0
-#define R23_OFF		0xb8
-#define R24_OFF		0xc0
-#define R25_OFF		0xc8
-#define R26_OFF		0xd0
-#define R27_OFF		0xd8
-#define R28_OFF		0xe0
-#define R29_OFF		0xe8
-#define R30_OFF		0xf0
-#define R31_OFF		0xf8
-#define SR_OFF		0x100
-#define CAUSE_OFF	0x108
-#define EPC_OFF		0x110
-#define BADVA_OFF	0x118
-#define ERROR_EPC_OFF	0x120
-#define CACHE_ERR_OFF	0x128
-#define NMISR_OFF	0x130
-
 #endif /* __ASM_SN_NMI_H */
--=20
2.30.2

--fnyakdsammmxp4xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpjoACgkQvP0LAY0m
WPFo5hAAomlMnFk7oM6KmFFQtsNTwY3SLjenFOytQkxRZ65FRYbIN+IORjklMac/
vi00mKIGQbgCp9Pt38+rgNSUUUss9rbNe2IB4+d97bajyCutEH1ckauPgO3QushZ
N17tbgH0k5DdHDTCV/dIi/7mmIUcNHdPA7U/D0+5u9IS452Dpkl6kCG/dYCYIWE4
AJbIsysKfq2WIz+yPN6ZLMIptvx/EJdBjO3dlJz8yeWT3VQ5GB+H3LhtCULTBf84
uuv/YKqe+FmTn9+egs5D5xPzXZpGzh4Hwv+u1LFEfnZsZaK+j7jMCxmyNyJPsqFP
01c4L0nvJAbJhcI178SHrR9kA+XO4AdfQu19/bNVTd+jFe4xFzXeOh4Q3s6G+RCp
JRlAYsrcNPVpea9DNpcA9cgMk5Drzj8yHFSmxVgA+3hGGI0KiwiM0w5xobGOwpuH
RehCOKPvDt/gqao2YItL+fvr/VD3sD4NB9M1tXNj77nbPuXG7/B+CbYeasqujcad
4Psx2I0P0AmrOmf0Vdxg/sWwXOdzsP+NW96Itw6Kbgbe4GeiLtg2fqpKn9Duc3N/
uOAdmN0xCcAqS2WVyTtW4EA8P4lZlwT8jvKomlDTfM6BufvwST1qUzbbX2QYqcCz
NfoJORSusuiXAYxYTk+0hMBxWaq3J6L2H+tDpECyXPYfzydZk2c=
=C0RX
-----END PGP SIGNATURE-----

--fnyakdsammmxp4xy--
