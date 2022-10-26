Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5856060EBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiJZWnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiJZWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:43:01 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE2E5BE2FF;
        Wed, 26 Oct 2022 15:42:59 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C253B48A0;
        Thu, 27 Oct 2022 00:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824178;
        bh=KJDVdPnwAEb9wGIso9S8xIg1kNqM2rqj1xsBTAC4c84=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=Ljrgv533fOq0Ozbfo+BjELxBUX0sRag6Wt/YaMEZb2uSVDHOGNtg3JBmuqaaKD2Rh
         fpU5iwAOjZlWqvTn85xF+A326d0gr1K8PPKYXtBpf3xTktT5dGkOdmRCnTS7H2kPmc
         5/ylmcotlKRTG02cjUN5mU+yoaOAKZdNI0aoC2eQS8douQiroPBrbX5Y5blye7Mcem
         Kn8pKp6dPD8FGnP4bD9wqsePORnpvk27VRNoJrsSuIRQb+Awl3+mPeoUiS3ozoYhyy
         x8yjC56ZTGSkFOOg3ZpI9K+LSK4Vjsv7PH9UiNQ6vN4A2dtXssnEiwa5arGt/+VaW3
         w0/4r1FRbKKJgIrkF5PHIepJGTppmhJw9y+QbxqEjRkz5yAgNL6B85fEcxmXGPu2WH
         VREB/N+d1bUPWv51x+6viOybX2vTxWb5YmQU2UQTvIGiinbGViS1KCxwBpPs2Qgk5i
         /9GWGb0Gt4zpNVXwD1ljW8Cx3qg+n/QCbVVAW+LM1yPddLWY5IVsU7CJsbVkB9UUq6
         ZV5FRaWvI8iBhVquNGyK4sy9CfybtDBCtQgLbGyTWhWiSc13OEP+yQdPH+vkiIj83z
         VX1V9bulmzeb8NmhGQBC0ouyP1gYnZq+6ZPYPFI349lK54YTw2I2o3FSwyb/yYMrK/
         yzINNG2FyAI2o5BttB1/gaqo=
Date:   Thu, 27 Oct 2022 00:42:57 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
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
Subject: [PATCH 05/15] coda: remove CODA_MAGIC
Message-ID: <a6eb2dae62abf49b351760a4f55031d1c6f4ea01.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icrr2cdkyzfpiibe"
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


--icrr2cdkyzfpiibe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach,
and we have better debugging tooling nowadays: kill it

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
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

--icrr2cdkyzfpiibe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZt/EACgkQvP0LAY0m
WPFUsw//TDjVp8bnKAfL6Nm55qPtO4J5E3pMtrOErW48McV3Sf7yLh3qbsPLAGZC
T+Lq6ymN/uKPAbS60kVQOcE97tR/8kvvWbGTo1bc07t54sWcujMN5EEyGwyEWoV7
7qkVzq0Xeew3ENLjoVQYXMplIKPjmAugofbqTFoFUG5MvolJVxVOV0t+U2wpmwuU
jehwmvOQYlHsB0QGnBp24nyRAUZv5DZJflr+VnoEll4UuUG8ymEJPcwtVaflN3Fh
APSCOVNvTVvvhSH9GzE/C1k6V+sp4wO5voCrrx8K44Z+BRPEqapgU3OpQ1wcI3jC
KCjCBH06xc/4PJd0fnVOMnBql+1Bb5PnAMjQrTifk96ok4ba/bZEDpnaEVN+5M+e
dmFQzBmsGtzzY2rpZBaKaPw6BDf10JMsPj7/nzKuClfmk6rldWTNJPbcOXlEgCzA
/XFAT8AgmDAyqEvbo+ROuJizrTZ/TX1gI5enlsdQW/X/lYiErOCMnEyyYMrSDhey
qDp+ryf20s6we8CbZjOOnJfgLgGNlbw76aLLOcNLpd3MDhfYWYKVe0sY4YaLR9+5
57lm+8aRRLyxK/OECu/i48V4IrhIyQDzm2VWoAeGgdEVgPzFhr5PlNQ21/3BUdxj
eHr4Hffl+VsjPnbn8kWJ38EBrR0U3gwJTos+BP4ghNjuBAv66sc=
=/6gY
-----END PGP SIGNATURE-----

--icrr2cdkyzfpiibe--
