Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7297060EBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiJZWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiJZWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:43:32 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88CCC13738E;
        Wed, 26 Oct 2022 15:43:08 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D461F482E;
        Thu, 27 Oct 2022 00:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824187;
        bh=HaE4IXPdx+zXOUMr9BZGgBKqpp/SrgiEjg+jSxW76Go=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=L7s6hrXXlym5v2if6/tEycFPoqI7Ro7ohFfsKomakdmG0J7ZyvgXdkDpK/SMEinzO
         KeXJK9Vu2EtbZtz8jxjcsargnEPo/dHpEdiY5U1kXH+3GpAG/aIS3S3krb53d/GAlO
         5fjo5xLuteBo6whwP+ZJfaocxoQ1Nhl971iFDlz1gyvEY2yh2zdrRoWyQjqFgEzRu7
         55ppghfsJBwtQ4UBbi/EyNWxtm/bVNFfrGLRV9Uu1A/zK17dNAZdYRxtv5BnHTdYYX
         LOdO0u12AtRvyb4u6DEWdzJBBGn/1kyvd5PWkfJxo9na4FdSyFL5/V5RfDDivx9bWL
         2JBbtsqpiFnHLzUrKUorhBRRoKIINkRUYjgIsnoqHEuOtseWNlcNYxnniNuJvtjSJX
         6e9GMoAwSbkU7lHGgfnUDqGXNSqE+fNBG8jWBNTqYW1VTd+Ruei4FlAEDB8HhSYaOg
         xr5+je/zhxRGrUiE3IMo8rFfaFlJOY1L3/t7r3X+B2b4TxIpzLN9B+WO4KXm6NqDM8
         cXSMAcSpJ0I3SKi9AI9gYYC5sfuISR3G0D4gqXZ6n93TPxqfNQ89PbpzFn7Ngh3OLu
         DBczps3Sbl8ssmF/2rgaKZJqVLuFTRzd6BEhZrvc6V6s7gyhAxnD4mnRC30EGAoKdl
         iDPQuNFEhLwm84Vs4ZpjqkBg=
Date:   Thu, 27 Oct 2022 00:43:06 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
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
Subject: [PATCH 07/15] MIPS: IP27: clean out sn/nmi.h
Message-ID: <08c138e14f71c207c4428df9fd31154744be9d98.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6cphbowxihuyvxx"
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


--q6cphbowxihuyvxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only user is arch/mips/sgi-ip27/ip27-nmi.c;
this file was imported wholesale in 2.3.99pre9-1,
and received only whitespace updates since then

NMI_MAGIC isn't a magic number; it's unclear if it's actually used
by the firmware in some capacity or if it's a holdover from copying
the SGI code, but in the former case it's API
and in the latter it's dead cruft

Lack of QEMU support makes this unvalidatable without the hardware,
so leave it in

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

--q6cphbowxihuyvxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZt/oACgkQvP0LAY0m
WPEByg//aGGsurgOuyOl2qmidd3+pAyPAl6kHAwylZ3CmbxelkCo5/eHCOenUUWn
XAncJgYXmI2662Q6JT8dOsoHO1azc/dsHGzCUw8leWiTaEbOBpy8bISxQtc31ip6
zNCR+wuvpCRuQrBH+oeTErhyhUCzBcD4RA2D7qHahahM9P1J9Qu0mS5aJ69LwiyC
RfiQqG5X4x3sLkbboljFR97hXKzCC5tNgN+soK5y1uytO8QnRIeWUeWWxhPagkuM
mjDpTxycJYbs0DjqnlgwX87iKf1QTZXCNKZ/XbrhtYOrZQKakCqm16MvNY5TOBaT
8rb8gf2H5nNCiCF7hI5buXYLao6ViWcdiN3U4MGjd+9fh+SMN4UqvxA9dYy+0GO1
J+3dBASCpafr6zLeeHELuxHhcY9TH9zW53Ipeh9WkRn/59Uf3AcqxlXDW0OB0n3u
K7uq5xXlk/XwnvDtFn6lHQOghafa5HBhGLPYcphPppgKvetKCwxFNsG4F0umfOlI
xt6DVSfljagP/b/Vb98QsPcIVoFJF25RK2ebaaZtG+6G1Fzl7OW3MJnC2vwakEpA
kCqW5x65HIChL0LL+MVSQoyZIx+WuQuNG5G0VRG9VUCfYiEQ5h47UWcAp8J3ZoRi
Hw/6XqHPf0EBifwT7cORKoVOVXiFP9U8rKxXHXmFmbfPUF8NAWk=
=F6wi
-----END PGP SIGNATURE-----

--q6cphbowxihuyvxx--
