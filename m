Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9D624F58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiKKBOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiKKBOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:14:07 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B7A0BE20;
        Thu, 10 Nov 2022 17:14:00 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DD121A20;
        Fri, 11 Nov 2022 02:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129239;
        bh=EmS73flWSI5awH2OX02dV/dWRq9xdQACUG/VomspvD8=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=osTVRJ7T0aZNSh32hMSp9Fu3rZjCBSq6Whj6NpFfXpgzsOE4C8bHvuVgqlKavX7rf
         ZVJf2CT1iikTPNJ+3xiZov8Dop77RyGyk6TOK5yA/S99cTIbswDQxh5cMtZ15F5KtW
         9I7BeBMV+vdJP0ia13P9W09g02wXeG94kRYv09dAFSbrka+meHGSZ7ncZfWhuVrTha
         fNwarmvdmpN+j516npYjEtEkNichcf69AWKiKLzFErXxt9N5whiw+p9QDjd2lHcfla
         vTKF4qOBKcI2Gwk08xh3XzWGacxqjxdtIRkYsygu+1M86md7pd4W1sMbe49meyF+xL
         SOlw69S9C01iA==
Date:   Fri, 11 Nov 2022 02:13:58 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        codalist@coda.cs.cmu.edu
Subject: [PATCH v3 05/15] coda: remove CODA_MAGIC
Message-ID: <91a186d5a3ebebb10ca5f9dd460448ff42c5229d.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wc3b7g3avvslsnss"
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


--wc3b7g3avvslsnss
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

--wc3b7g3avvslsnss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtodYACgkQvP0LAY0m
WPFLlBAAh+53/T94gGHaeWupoUo2WmogB0m7VHrPfcOM6fVqhXr7PICKBL4CHSAE
TqmQ4pMC0wDrH8bxPPMXRCzJL/0VnzAmvKsGrcLy443TMBP6JS35VF7OUJtvJb7z
bW2J78rbkLamY4s4wNpdz7wk6tvn9RW/ym92rfFAz6tVuhE3iywjiTGzQf1ZE38T
22t65KBqCaGihecB+Nb6My/hJmEimguI00hgjftABh1WukOOcaqRD7B52SZtRU1R
QHWMXi46rRj+d1Y4CZBHHrWVLDL85vLdP1/L2R/HFppN72Hacs13fzmurY6bPIhi
g8/RICB8HTHRABvw5k+VCgfiaz0VCJJnxgcYOu8cGJpAe7LvhpUaPF8Bhy3VDo8F
YOSJ9JPcyvdYraWoQU3gDz0yn4BwJBNOnb2s+YD3DZcYJa3X6DMsJcfUtwHmYIjf
8jyHRLrzyH5W+HUZAQ+TCBYpFMw0Y0dz9HlCJ3yvX5SGL2N1ofpcbG0K46yBQ9hN
HrohsPkpIeyAwQXPWelM0F1fuBzIlbmM87c+fCxTOV/a525POmN38tk3Bh23glLa
xqYrDr9lelg8SlMtwUDmzki8PC+3aYVhKHOciYBko234ZE/2GMy/gJR95bbyG7QD
hZUxDJUz4LTTPyNEk4IGg1M7p2uUWxI9TkHonhKRbZHV5qxnbCk=
=Z4Mi
-----END PGP SIGNATURE-----

--wc3b7g3avvslsnss--
