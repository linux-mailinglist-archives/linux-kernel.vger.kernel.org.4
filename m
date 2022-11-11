Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1539624F64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKKBPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:14:58 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2812414016;
        Thu, 10 Nov 2022 17:14:30 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1BA1A450;
        Fri, 11 Nov 2022 02:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129270;
        bh=iMPtb8qACfC1PCFMoSnSmABFq0REu+ki/WXYNsR3gJU=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=t2icKf2Ugagh1j+0i+rwTAU6ZYCKGC6SDiXzex29FoPzql0KaRHR2kIC0OHE/j2FD
         tLcBYfFOnGcRSULDSAKioJ0C2OMe9gRLbta6MKusbK7dQ3dFS49qE3rEp94dZwRDzS
         /WFDjfLXMZOa+XbTrVmZiEHch0MPbZiJS4owyiLJabTPrQwyYN8WRgNZJjQ48tduai
         XrOFGF1aNHcpoZM+oFlWXeg8xJaPVtThoH98wHzJuNXeZlNl0aLMX9lWAfqBFxsFNs
         +yuEZBfjVYvibiicoFkUNHG7OFjGE1AVSR/JWuUKP54R5eJA/WSYUb8i6WkaSDPCZg
         7ub0Dzc6CmzWw==
Date:   Fri, 11 Nov 2022 02:14:29 +0100
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
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 10/15] scsi: acorn: remove QUEUE_MAGIC_{FREE,USED}
Message-ID: <eeb9a60fe1dbe2d0142ec13caf083f2f43c9d2d8.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4c2xpbvm5v7swk4p"
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


--4c2xpbvm5v7swk4p
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

--4c2xpbvm5v7swk4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtofQACgkQvP0LAY0m
WPEleA/+OF6cho1MQ0/1sXpn5YTYMn1mTLGk5XAMi6PGbQBcV6j2dBsq3IBUgN+S
pI0zv16OiOLBTWFaGLms6erTWQoMURvGIy/rx6NhnOeFZhfSxQ3bkoFjo1mf3mXp
BSjm8JhaKkl0Wk+vs6exwxhS/kcxpaO+iKdInpYQiHj8IdtTr0YqjpTZj6zE6sbU
WiGuYjYOjkmQka6zwzEL7tTUKRAsVq0LQ2u4kCApAmVEfJg/aswa+Mg+ZdhiNkQo
w14HEBOjxNHb6dVSlslVcbFtM8821iSOp7SR6c1+wPPusiMOeQdL9S6w+NI1noPX
2qEYjcGLn2gEkAhwg4ohYtdS3i4ba36uAw0jchbSYC2eWgnR9tMCXW1Eff5wMwfK
DYNqxuqmSnHl+Uv+EGIZDiUihi0maKxICr0+/I8o0O3tehWbyS4lBQeyv2pVBsj5
DzuQJpcuFCWF+unBh2YDgWvuK6UsXkmadXj5wPkeJbZtkTHSdflai3BDubfQcLrz
qIxl5CYQIFYwu4JupMKsBNVHzKflaDNtgdjpg4hpOeN2kB2mtJZLXTqdEex2o66t
0TYB+rORK/QYOdmRbaN6cc9tZxiSpY+jsc1z5FtIKdL8S2OSiOTGeeBpKrOuvVwh
v8GKbWdGNQDwC2rVHPmWW7de/KRbvTCE7QdPe8tLZNkTvrR+M4Y=
=9jv9
-----END PGP SIGNATURE-----

--4c2xpbvm5v7swk4p--
