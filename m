Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0756155CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiKAXFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiKAXF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:26 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D014060FB;
        Tue,  1 Nov 2022 16:05:23 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 058F84EE4;
        Wed,  2 Nov 2022 00:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343923;
        bh=5guxHxeMZO6jIhjwoXxtFNICxaf3NerLu1RM6JzApG4=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=DOZ/iY9VEwQrhOuresZhwUToPAjrGxbNLWtvATGCJF/4go+9j/vqg7qzRFZUwgxL0
         oIyqPGCrnf7bTW/g6D00WKuA9nrlq6qe6Og1tWtZveGnphXUU6eqBZt8zLRU87czrB
         uYY39qwZdFHmrbm6BdWtd4ohAmGB72vJCXecnyEHnlvh7ZAtGUZHI6KfiwMu1VE3sI
         D7cQmliNCrOj/cg7/6xCoY9e0KOiwcJGyIqkh6wzmH611pN0nTSsyPq62rW2O6uCAS
         CoKSmGvLxb+OHZA46BbFiiopFl0fxLjOHTjc+BKwRdOfuMIL+hDO25MB71f1OSuruL
         J84ebKfovFSpHjj87gYE/ggggv4OnXO93FU7kYjUD1f+BpskCcoqowDdClF8TD3bUN
         F7Lus6J1DqIfdyHZdJt5CiLzD/Hjex3fWt5HHaVd7Cr3PtnefUbC/Vr2MFzOetJrjy
         6t2IJ6zjK8wAnVwHCrVP+SLlF6x5CNLSADto4wvKi152wcg/9KxO3Qy9kSkQjBjZ0O
         rbp7qXzntnmtVxhRDZFp5qQIcK61+G2DwZVTxrMvSH0Qi2s/0v0WSJia8oc/qGc9ud
         VdiWibn8aQjkq16g3CsZy0QQ/hk2aiyCx6DU6Lzv+qiJIEsaiN0CSrX/lfUGjeB5Kd
         py8AaTSFkrnZi53mymxcbUuY=
Date:   Wed, 2 Nov 2022 00:05:21 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        codalist@coda.cs.cmu.edu
Subject: [PATCH v2 05/15] coda: remove CODA_MAGIC
Message-ID: <9b1b965d7301e67654d726db42876232333a459a.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pu3tzosysrvyscbj"
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


--pu3tzosysrvyscbj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach, and we have better
debugging tooling nowadays: kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 fs/coda/cnode.c                                           | 2 +-
 fs/coda/coda_fs_i.h                                       | 2 --
 fs/coda/file.c                                            | 1 -
 7 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 18f8b1e3a993..335169e43be1 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -74,7 +74,6 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 827167b18f15..699b681088ac 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -80,7 +80,6 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 9553475e9867..d1ede86944f1 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -63,7 +63,6 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 8a64f56ae267..1dd01f1e1c17 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -66,7 +66,6 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 62a3d2565c26..e217cca338bd 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -157,7 +157,7 @@ struct coda_file_info *coda_ftoc(struct file *file)
 {
 	struct coda_file_info *cfi =3D file->private_data;
=20
-	BUG_ON(!cfi || cfi->cfi_magic !=3D CODA_MAGIC);
+	BUG_ON(!cfi);
=20
 	return cfi;
=20
diff --git a/fs/coda/coda_fs_i.h b/fs/coda/coda_fs_i.h
index 1763ff95d865..9e4b54dbe7d7 100644
--- a/fs/coda/coda_fs_i.h
+++ b/fs/coda/coda_fs_i.h
@@ -35,9 +35,7 @@ struct coda_inode_info {
 /*
  * coda fs file private data
  */
-#define CODA_MAGIC 0xC0DAC0DA
 struct coda_file_info {
-	int		   cfi_magic;	  /* magic number */
 	struct file	  *cfi_container; /* container file for this cnode */
 	unsigned int	   cfi_mapcount;  /* nr of times this file is mapped */
 	bool		   cfi_access_intent; /* is access intent supported */
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 3f3c81e6b1ab..c23f846bf206 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -222,7 +222,6 @@ int coda_open(struct inode *coda_inode, struct file *co=
da_file)
=20
 	host_file->f_flags |=3D coda_file->f_flags & (O_APPEND | O_SYNC);
=20
-	cfi->cfi_magic =3D CODA_MAGIC;
 	cfi->cfi_mapcount =3D 0;
 	cfi->cfi_container =3D host_file;
 	/* assume access intents are supported unless we hear otherwise */
--=20
2.30.2

--pu3tzosysrvyscbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpjEACgkQvP0LAY0m
WPHYpBAAhF4r1rtnfHZlwWyc5wvaX1H3F2m0UsQUKMH80MtPqWqvPVbeRpyjXQ6N
RZ3YnRes6JVp6hFTzUnr8AyVMH76/QopUnn7QvdJtiRjbzWBBIWV3F/DzU82c9jv
8BT9jAHUyYwiLB5nk00gqi+hKJ6sZZhEDuLz388WkKX6z6y02hPsy+bmsUIgIMg6
fE5TY29umkvhAFkTJH+G4jJFYltDmi+cbsbN3Qnm7jGtF7SLFXkA1nSxUyf7Bbvj
v1XmwERWweA1SbMqUEamTFk4uV1pv/tGESbKDdo8ZYiTr0qRQhCf/ARqlva53pC1
qhpSpjeInfNdabLotbfDW2QJGXGqwltyMzRp0F0NRSm+dsaC/HpGCiLxEy+Dc2y9
nUjxH4nYeQKMYE8Jzekj54XvaFPBl3a4M6aSMFb6J/uQiEEKMMrJgpOTfwjs9p41
vs0Vyaj5jUg7yBU/SfdEcCL0tf4/V9MgsSq5d27SCgoV/osx9ETIFZqOF3J/oWrm
hgfAFrVuRtOhFVB9xlwFwck2jhLYfOKz2oFQLX0ZxEgOX8xsfVxK2SaX2Ovvt76r
5NKnDEOjCvBJMES0ICzPbXD/LTD1G8iWjrjra9waGespDiP8tQATjdDSaCZkWIIM
NVVMRVzPo2qmyaS1xtAGTifO2Vm7Ak6nGn8lkWIQDjxtkh6TqYw=
=ga2S
-----END PGP SIGNATURE-----

--pu3tzosysrvyscbj--
