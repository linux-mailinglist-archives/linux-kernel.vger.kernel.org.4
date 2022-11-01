Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBD6155D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKAXHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKAXGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:06:05 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D6476444;
        Tue,  1 Nov 2022 16:05:47 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DA5594E2E;
        Wed,  2 Nov 2022 00:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1667343946;
        bh=KPLxLEvEsq/B2PBaYPKenFHyW0xpBnqpgZ5eCop6z4Y=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=F3/Z8Z03YwtWXHw61U/ZaoHURISnMiZOPPyYEzBYpWlJRAiPbluz3d7S+ISXrX/xF
         MjoRv/R6CiWv+wDz2QK/STrpfwH0BWfPVHI4V3iP7sKTc4fJQhtqPh03IQ9DU+S9uI
         ulviDCARR7cNi1rpIIFnMBHQ+EFzsPdnB7Wc4PfAaCyLxXgwn2mtbjrjUeE2udllk4
         am/HfmPXXNN6OYPI7ZA6bqFVsm4fSgeteHRNVLYRCOlRTHgVTMJip8SvlXldWF5ppZ
         jNFXFOqnjHkADlHKEnptboM7kOCKKB1ooP4Kc3CIGQQ4LInA32FU6yRW12K5cPrcb+
         DuPiWBEDxvM8BKYu2a3YKg8jxluyPv6K/JAePc6Tl9yK4jy2SpT/EIPS91yfjAzsHa
         O1Q+BtGCNDhJRiJ6vKcJhu9kAFdzwvuLaJiGzZd1F/mVSfMXiOzXCAn7pXjOq72Y5s
         6acAXYJ+hS0cMO+BvDzclwfer4LEIOcmizZPaQOIh/9sMTP9w9kqhcnfWt4+K81U2x
         dTXGkMygcODlR4zfCkMbyZfhvmnDJhkxsXbLE34CMxL5zXMC2xwG0FA3ZFFL1jwW2P
         YT+p4dT9+YtV+9lyiS0/jCh5s1JfPK/YJhHvXxxKF40tlYmess6rheeSHSMaP4QE9u
         c19XJii0gy41/ycQZl5Y0i5w=
Date:   Wed, 2 Nov 2022 00:05:45 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: [PATCH v2 10/15] scsi: acorn: remove QUEUE_MAGIC_{FREE,USED}
Message-ID: <7e9abe0511428bdb665eae5b9517a0d45e72de75.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrb67imauyktfm6s"
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


--xrb67imauyktfm6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach, and we have better
debugging instrumentation nowadays: kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst        |  2 --
 .../it_IT/process/magic-number.rst            |  2 --
 .../zh_CN/process/magic-number.rst            |  2 --
 .../zh_TW/process/magic-number.rst            |  2 --
 drivers/scsi/arm/queue.c                      | 21 -------------------
 5 files changed, 29 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 77a96a79c7e8..c1c68c713cbc 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -72,6 +72,4 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index ef509265a3df..5b609ca78a14 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -78,6 +78,4 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 6437c408dd67..ab4d4e32b61f 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -61,6 +61,4 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 453cc205e6c3..a6131d978189 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -64,6 +64,4 @@ FASYNC_MAGIC          0x4601           fasync_struct     =
       ``include/linux/
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/drivers/scsi/arm/queue.c b/drivers/scsi/arm/queue.c
index 978df23ce188..fe7d814a73a9 100644
--- a/drivers/scsi/arm/queue.c
+++ b/drivers/scsi/arm/queue.c
@@ -26,27 +26,11 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_tcq.h>
=20
-#define DEBUG
-
 typedef struct queue_entry {
 	struct list_head   list;
 	struct scsi_cmnd   *SCpnt;
-#ifdef DEBUG
-	unsigned long	   magic;
-#endif
 } QE_t;
=20
-#ifdef DEBUG
-#define QUEUE_MAGIC_FREE	0xf7e1c9a3
-#define QUEUE_MAGIC_USED	0xf7e1cc33
-
-#define SET_MAGIC(q,m)	((q)->magic =3D (m))
-#define BAD_MAGIC(q,m)	((q)->magic !=3D (m))
-#else
-#define SET_MAGIC(q,m)	do { } while (0)
-#define BAD_MAGIC(q,m)	(0)
-#endif
-
 #include "queue.h"
=20
 #define NR_QE	32
@@ -74,7 +58,6 @@ int queue_initialise (Queue_t *queue)
 	queue->alloc =3D q =3D kmalloc_array(nqueues, sizeof(QE_t), GFP_KERNEL);
 	if (q) {
 		for (; nqueues; q++, nqueues--) {
-			SET_MAGIC(q, QUEUE_MAGIC_FREE);
 			q->SCpnt =3D NULL;
 			list_add(&q->list, &queue->free);
 		}
@@ -119,9 +102,7 @@ int __queue_add(Queue_t *queue, struct scsi_cmnd *SCpnt=
, int head)
 	list_del(l);
=20
 	q =3D list_entry(l, QE_t, list);
-	BUG_ON(BAD_MAGIC(q, QUEUE_MAGIC_FREE));
=20
-	SET_MAGIC(q, QUEUE_MAGIC_USED);
 	q->SCpnt =3D SCpnt;
=20
 	if (head)
@@ -144,9 +125,7 @@ static struct scsi_cmnd *__queue_remove(Queue_t *queue,=
 struct list_head *ent)
 	 */
 	list_del(ent);
 	q =3D list_entry(ent, QE_t, list);
-	BUG_ON(BAD_MAGIC(q, QUEUE_MAGIC_USED));
=20
-	SET_MAGIC(q, QUEUE_MAGIC_FREE);
 	list_add(ent, &queue->free);
=20
 	return q->SCpnt;
--=20
2.30.2

--xrb67imauyktfm6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNhpkkACgkQvP0LAY0m
WPGs/RAAmiHklRL++0P2QUfQEAzaOa48pN8TtkxtsQ/zm+5drZHf7lo9cFTyb/R+
EDCFCkndFEZL5/vnE5urNiS9Gb6fPHvDEUrEanrcctrSjJ4IrECXxrts6/9W3rqK
srZ2PAI/ZoTedfNN1IbdVpL8oIxyYAg0OzYGBzX00r2Cm9wqLOmes6K+rKI1T2k8
rlpWpyc/vPRgzOgEB7c14anSU7SXGFWvU1N9MGle8/DiOuv1YJhKXms+XEXf3e80
nI4ihRtT1Xu+Zd5uOlO5o8PchOxKRvv5jf+2Hj5QugUj5hSVUcm1jiLhHBZhkQ06
+AUYx/LxuJIZx6u/sqjTqABvJJpy5xdDzgvd4Ah7fvVzLEPAzLY345UZ6iYZBtiT
t/yStbt7F/jDlmv3PHoAY8JL+HivyI7NOQ4dWpGl504tg5vSZEFIZ91Lww/wgmTU
hryOsY8TZAwvRWwEHH6rdna05X36atwHhyx0kbj3lpWAzXj0O24I5PUydLw12jhq
z6dX5Xph3jAo8+grcvEwX9Tm/t3IiLFCSEIQgigmvSRDMHnf1sClA6KURqB2EURr
tSiBsyGs2KmvSIdp8GtSWG5YUv+xWY4rMvt3nJwrwSgM1FTfZFMFjhNxCpNxHRZ9
NxvyYY9nLH6MXILF3vYDyLqlogzgTdFwEOITUHI5yXYmF3+BTbY=
=9Ie7
-----END PGP SIGNATURE-----

--xrb67imauyktfm6s--
