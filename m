Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0360EBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiJZWoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJZWnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:43:40 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4147313B513;
        Wed, 26 Oct 2022 15:43:22 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 877F34660;
        Thu, 27 Oct 2022 00:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1666824201;
        bh=mvQMiGrPqRBI4af3hBhxU3HI0eaRowKnINCh9+jrcSA=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=ULqGBj8SeLyN/SfR2/usj29XQun7NIgWv2xzq5RLvyiutKNOkyMD/UnZaEnL0YnNH
         qQ3BnWA27eG3L4xDwm9AwBaH1W8X07xzXMI3jaJGvDUSdNtdJX1xy8CFYUdc8wJINV
         1gKXWmJN0mtPxyoHNx/kEZSi6gELDrH9a4jH/H/R7ss6Ek91Otj2XP51I2sFFHGlaT
         0WjyMQvZlkGOQpSgNpy6v7vpIFzfsXGIBzpOqBJiolDXy3pnLyAXj05lk4at9SfW3j
         vFOw9TwO/0+W4e9hcjYRHFLlYX4ODmbEFY9g5wubbcIVAWfoWgJfiz+nv0hYD3wKkz
         dlW5AhxFvr1KkbhKP34VgiuDWsinsOUI2qP2+Ey/+uWr8H7M6iOc0J6snFDbou8HqT
         pYrOSm8s42ZpJTrBHuLdAR3ExbiYvw/zdAO2QSdcr2tqFWkucPCOdak4X+J4l0q5I4
         QmeuHwUZPjDE6kW/JZB6YhA5UHnXLGDcpgdtvZPaxyTIjpel/nLwK6ezKqPucpjpdH
         DUI6d1ZEWMvo5SvKhJCVYPlILrK7M2DkMZzVXHYPFkgCc5ohcFcaoQH++/AQMjs/la
         N/qPsi4RzpVENHuoczo+o1twDdGyGQchsfaxzecrNdLyacGmYSQs+M182XEL28mQyB
         P4sSVpphFltQH/3cT+YxeYp4=
Date:   Thu, 27 Oct 2022 00:43:20 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
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
Subject: [PATCH 10/15] scsi: acorn: remove QUEUE_MAGIC_{FREE,USED}
Message-ID: <f1330d4027e3d7e85d2a5cd7c5f43fed866b9ef9.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uh4qysktmizprqov"
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


--uh4qysktmizprqov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach,
and we have better debugging instrumentation nowadays: kill it

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
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

--uh4qysktmizprqov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNZuAgACgkQvP0LAY0m
WPFbqhAAiaN76od9eGWIW+KwFtAQK0m4SLDJt/RRj/8GHYLoWS1mTGl6LxLTcvJG
yGNSHSAi8Z/Er3g6fQMngi9dJvvHhN33uMFxe/8rHnnz+8ZjEflua/zTRbPDpR4u
fVX4CTaUJ5XXa4SMMlBDsKjO5MGU6j08lQiFe3Q4zsyE4SFn1YSELai+JiEDvxC5
XiQVVpYAtsbpVFI2uo9zWPxfxZ8u3tmsJ17f4tymr9ny2roeKuG+G50G+a9K3YwL
zZPbSNqrDdkJsd1BNkDcGDpxxjotLmsOKQOIo7g1noMPo+/TGGtpytZG6ScSqzCi
bSSBb9rD249ce+0iYnjWcoSHDDJCvlGVTUVWH28bEqoxSpdv9skhpLJOVrI+O/re
awvZ6dDB/LtNqfdx5gSonfyGNkspZzUYXTJnQMYsgDtuHDOPgkliRbxOJp4LSGL4
lt+ybXIer863zMlc5xIPXtkgRn6lVtHryk2kOFAVM6c6N99GjAyqJl0PLvYOG6vf
bSJkwYXReHQ8bCusG5cyio9hMwSiCPaJUvxpaRnzwko5VlwedVlpN+LhDVGjmHHy
3SfGe3BNZ7UzivYRtXtxHOZH7A0EoTOb0zLtOlUiWNeXl0J1qLuL4ic7q8S3XO9z
Y51RFJ4jv0ogeJg5Z8tWcZLp0nir93JbR4IMmdyrP3iUfm9mQwk=
=9YLr
-----END PGP SIGNATURE-----

--uh4qysktmizprqov--
