Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4360EBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiJZWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiJZWnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:43:35 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E9C139C07;
        Wed, 26 Oct 2022 15:43:13 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9CEBD4830;
        Thu, 27 Oct 2022 00:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824192;
        bh=6pkTsC/X3DXZE/1Nfcqo6aUpf8jpMUrgSqAARhHXbY4=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=t0N1sIXCHYG7BMvFda7Y9i2bcXE6p67yVFVd6WfdMLY9915Tv6VpSKFYkKF/H+Rs+
         OWR03FlGilVT3HXqNkE0B5l//9jLy7diLyZPOObJNUxr460n4EgKxqHhVAggZPLOTY
         LdwHziOYdEi0OkGHlOvvJiu8J2P9o0MuBrJwf22Z6jwv/3q4U6TWHO6SzAz6kAk53g
         KZgH43sk5odPvW08Dp9Mq/82cQBOVu2SodgMOaZ/h0DukqCQ3CcuvvLZi+K7Men3tM
         Qbw51HcMUEOrRILuaTPM9MtF3JBBQOxGWZyIHkPQEN134EEgbe5vhV4i4K+wIGrqDL
         3z3sSrL74sUt4I1xRYLKcQtsud40Vv+DjkIWiJfnBNXmWIqf2iU0F+6N92r8VEN8Lc
         eP+qjW59Q8R3lwCXE6jVdXGOW+BzVZlcPZWvxGjYUW+lxc1KQpSI2VwI7YjBpY+nC/
         gO1ypdzK/VHzFMNTf0Rx6hRJJQlTCehKImwiqtyhYILNof7laAMdziTY0KUVGoAI8O
         8V9rSQXCRSN6dSv/dY2DBPTCxYoia5c965CSOQUwCw7cRLxaTFhbHR5qpBiOiPCd6U
         Ol72bU+1saOpAQWUWyW5hQUpy+W0ptzFh8qQchjE4nBQo9QMxAuKn1bUBPswJaWkCc
         Y4IAQRR+gQHbtP2KG4w7U6uE=
Date:   Thu, 27 Oct 2022 00:43:11 +0200
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
Subject: [PATCH 08/15] MIPS: IP27: remove KV_MAGIC
Message-ID: <ebf854f94d7a33c744202efb31cbb61087a33e44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sniqqlarsgxgmoca"
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


--sniqqlarsgxgmoca
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It appeared in the original import of SGI code in 2.4.0-test3pre8
and has never been used anywhere

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 arch/mips/include/asm/sn/klkernvars.h                     | 8 ++------
 arch/mips/sgi-ip27/ip27-klnuma.c                          | 1 -
 6 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 7dada7abc733..d8ffbc21872e 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -72,7 +72,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index f9634a04d349..0e59704aa617 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -78,7 +78,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 966b9e6b1a46..17a73661ef17 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -61,7 +61,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index f3e87a6b3a01..9d44d49b93bf 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -64,7 +64,6 @@ APM_BIOS_MAGIC        0x4101           apm_user          =
       ``arch/x86/kerne
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/arch/mips/include/asm/sn/klkernvars.h b/arch/mips/include/asm/=
sn/klkernvars.h
index ea6b21795163..93d5eb873255 100644
--- a/arch/mips/include/asm/sn/klkernvars.h
+++ b/arch/mips/include/asm/sn/klkernvars.h
@@ -6,18 +6,14 @@
 #ifndef __ASM_SN_KLKERNVARS_H
 #define __ASM_SN_KLKERNVARS_H
=20
-#define KV_MAGIC_OFFSET		0x0
-#define KV_RO_NASID_OFFSET	0x4
-#define KV_RW_NASID_OFFSET	0x6
-
-#define KV_MAGIC		0x5f4b565f
+#define KV_RO_NASID_OFFSET	0x0
+#define KV_RW_NASID_OFFSET	0x2
=20
 #ifndef __ASSEMBLY__
=20
 #include <asm/sn/types.h>
=20
 typedef struct kern_vars_s {
-	int		kv_magic;
 	nasid_t		kv_ro_nasid;
 	nasid_t		kv_rw_nasid;
 	unsigned long	kv_ro_baseaddr;
diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-kln=
uma.c
index abd7a84df7dd..82bb7ac20ef8 100644
--- a/arch/mips/sgi-ip27/ip27-klnuma.c
+++ b/arch/mips/sgi-ip27/ip27-klnuma.c
@@ -61,7 +61,6 @@ static __init void set_ktext_source(nasid_t client_nasid,=
 nasid_t server_nasid)
=20
 	KERN_VARS_ADDR(client_nasid) =3D (unsigned long)kvp;
=20
-	kvp->kv_magic =3D KV_MAGIC;
 	kvp->kv_ro_nasid =3D server_nasid;
 	kvp->kv_rw_nasid =3D master_nasid;
 	kvp->kv_ro_baseaddr =3D NODE_CAC_BASE(server_nasid);
--=20
2.30.2

--sniqqlarsgxgmoca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZt/8ACgkQvP0LAY0m
WPG5kBAApZjQIEPUhGRvbEU3UKObOB6nSNfts+IU7eRWcYCb2Lr4Rmjf9DV7JKqk
xPXD7AofKmfoqF6qKlKshzIHEtv0Uhw8k42jcq+ooAaZgsHExkUAGEtfGr5R9D3i
VAW04tKX8RgQPDaOduhdmUNDWbB/kUGce9p0E5xpX/JBGOYikPR+BtSd2tUb25xl
X+TFD7zsPtrhbzewFfkkwogNVMp4stgwM82spHWmd9lK+3Kh+k1/K4hW/kL7Hj4L
KzXGMDl7uGLFledvCfYAjM7H7k/zvADG6bKjT2wjY9bXUGY3rSY9mbbhHr5g9psA
4rvVsGlkqLe2EAQ7zE2Riyf+DP36or3+uNWKuXlcuNoN1hzABXg4hJ0BV/A64Wxq
IfWiuZsEUaPSVxiRYXdhpzsbHPTPijVxB3+TcR3tS0RxaNjTqU3aIQY6k0fKzaqH
XPFH4Us9PGfLRSQ32ZrOzo4t3fPDRLUSiAvFgjMIBlXdo7n+KF5jXymRPXe9xvsl
eqXkKbH/greIy3oE6jNP1E2gNcDcjo90vwPnkUwFn+XW5b/HhMyLji627NP0GnS1
qtMdFPlHxB3wBOlXCeD3i2S9yjHN4qBfRmHlgdm2K8mRYHcNeNb9yx3vYXIKqvm9
GkoHiyeDHqNon/MC87ZQossiF8jVuhLWTjcbkG9gYAKNmIALNK8=
=9nt2
-----END PGP SIGNATURE-----

--sniqqlarsgxgmoca--
