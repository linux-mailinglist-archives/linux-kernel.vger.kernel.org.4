Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11335BA42F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIPBzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIPBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:55:10 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3C1140D2;
        Thu, 15 Sep 2022 18:55:04 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id BE50F1074;
        Fri, 16 Sep 2022 03:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663293300;
        bh=i036dqtp+M5F2iUf7rJM+aJuwo1MGvMl7sNUQfom7jo=;
        h=Date:From:Cc:Subject:From;
        b=jO4yYTbqKxQRidV2ITu2C9smcNmZQMv3jhS+P36B8OBpk2tfFzCEPRGSg2zgdBLdm
         95i3qlukPocwJsfOwb+GZ3naz/p9VjXl9CxzML/VdnFazDNL9UEGyqOLnXUDuW9COJ
         D7iCeC+w7zSugktHa9hIJvz3IWcdzY0AXJVWEAUjM2UXoVejOgbeGQ77hJ7fuYvXGJ
         dFDwRISCMTMod1Woch1TqDFEehHmuby2V/48UsomAYtB9wqejPbqNNh/jXsOm0Hir7
         kRTugodsI5plFMwoiOW1DNGYBR0w3dX4YD2LfzUGVoWJrm0XP5eqYzSR5mMCfR6Qu/
         aXyuxKEffSwqHOtWxrMyQ18szB6oX7CyuqmLK09v3GflYTjmkKHBL+nFNIV8IvZ8tu
         tJAiIPvy/FOEA8GXzHF5I1uhcVAx8PFnIUQLnvWy6VtZkk5rryoCpK4GPihiJSSKSC
         cAZWUpTMwTRNFb/0wBGgXXxfKqaqpcGQRG4vCfiSy41C+MlLojxzYlMQYiIYjJ4ngn
         qFTchflAv4KD+I3DZJ+rdR5Z/988w95/caMDutn7AF/yTr8esQsHDAp04kGMAnEb+j
         gxmVQbYOj7NDwvJG9LQykm3ZCcY9dGj+pXdaCCfl2SdWpAE9CovP9y2JwF58T20RvE
         ZuYfXcFe3oOQslZbAOqX/ics=
Date:   Fri, 16 Sep 2022 03:54:59 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH 1/5] tty: remove TTY_MAGIC
Message-ID: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqehfju4slo4lchw"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,MISSING_HEADERS,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqehfju4slo4lchw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to Greg, in the context of magic numbers as defined in
magic-number.rst, "the tty layer should not need this and I'll gladly
take patches"

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Whole series: amd64 allyesconfig builds; amd64 Debian config boots and
appears to work; naturally, the HVC stuff is S/390 only, but it's a
constant offset

 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 drivers/tty/tty_io.c                                      | 8 --------
 drivers/tty/tty_mutex.c                                   | 6 ------
 include/linux/tty.h                                       | 6 ------
 7 files changed, 24 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index f5ba36e96461..b4c7ec61437e 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -84,7 +84,6 @@ SLIP_MAGIC            0x5302           slip              =
       ``drivers/net/sl
 STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index f452fafb1e84..bcb23384fefd 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -90,7 +90,6 @@ SLIP_MAGIC            0x5302           slip              =
       ``drivers/net/sl
 STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 42f0635ca70a..6250087d36c5 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -73,7 +73,6 @@ SLIP_MAGIC            0x5302           slip              =
       ``drivers/net/sl
 STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index ae321a9aaece..fd169d760bbd 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -76,7 +76,6 @@ SLIP_MAGIC            0x5302           slip              =
       ``drivers/net/sl
 STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 82a8855981f7..33962109bd10 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -170,7 +170,6 @@ static void free_tty_struct(struct tty_struct *tty)
 	tty_ldisc_deinit(tty);
 	put_device(tty->dev);
 	kvfree(tty->write_buf);
-	tty->magic =3D 0xDEADDEAD;
 	kfree(tty);
 }
=20
@@ -265,11 +264,6 @@ static int tty_paranoia_check(struct tty_struct *tty, =
struct inode *inode,
 			imajor(inode), iminor(inode), routine);
 		return 1;
 	}
-	if (tty->magic !=3D TTY_MAGIC) {
-		pr_warn("(%d:%d): %s: bad magic number\n",
-			imajor(inode), iminor(inode), routine);
-		return 1;
-	}
 #endif
 	return 0;
 }
@@ -1533,7 +1527,6 @@ static void release_one_tty(struct work_struct *work)
 	if (tty->ops->cleanup)
 		tty->ops->cleanup(tty);
=20
-	tty->magic =3D 0;
 	tty_driver_kref_put(driver);
 	module_put(owner);
=20
@@ -3093,7 +3086,6 @@ struct tty_struct *alloc_tty_struct(struct tty_driver=
 *driver, int idx)
 		return NULL;
=20
 	kref_init(&tty->kref);
-	tty->magic =3D TTY_MAGIC;
 	if (tty_ldisc_init(tty)) {
 		kfree(tty);
 		return NULL;
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 393518a24cfe..784e46a0a3b1 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -14,8 +14,6 @@
=20
 void tty_lock(struct tty_struct *tty)
 {
-	if (WARN(tty->magic !=3D TTY_MAGIC, "L Bad %p\n", tty))
-		return;
 	tty_kref_get(tty);
 	mutex_lock(&tty->legacy_mutex);
 }
@@ -25,8 +23,6 @@ int tty_lock_interruptible(struct tty_struct *tty)
 {
 	int ret;
=20
-	if (WARN(tty->magic !=3D TTY_MAGIC, "L Bad %p\n", tty))
-		return -EIO;
 	tty_kref_get(tty);
 	ret =3D mutex_lock_interruptible(&tty->legacy_mutex);
 	if (ret)
@@ -36,8 +32,6 @@ int tty_lock_interruptible(struct tty_struct *tty)
=20
 void tty_unlock(struct tty_struct *tty)
 {
-	if (WARN(tty->magic !=3D TTY_MAGIC, "U Bad %p\n", tty))
-		return;
 	mutex_unlock(&tty->legacy_mutex);
 	tty_kref_put(tty);
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7b0a5d478ef6..ba65043e9029 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -122,8 +122,6 @@ struct tty_operations;
 /**
  * struct tty_struct - state associated with a tty while open
  *
- * @magic: magic value set early in @alloc_tty_struct to %TTY_MAGIC, for
- *	   debugging purposes
  * @kref: reference counting by tty_kref_get() and tty_kref_put(), reachin=
g zero
  *	  frees the structure
  * @dev: class device or %NULL (e.g. ptys, serdev)
@@ -193,7 +191,6 @@ struct tty_operations;
  * &struct tty_port.
  */
 struct tty_struct {
-	int	magic;
 	struct kref kref;
 	struct device *dev;
 	struct tty_driver *driver;
@@ -260,9 +257,6 @@ struct tty_file_private {
 	struct list_head list;
 };
=20
-/* tty magic number */
-#define TTY_MAGIC		0x5401
-
 /**
  * DOC: TTY Struct Flags
  *
--=20
2.30.2

--pqehfju4slo4lchw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMj13AACgkQvP0LAY0m
WPEqkQ//a9MLJLX11AXclFxX6RLlbIPvkQMpfYkQfUYAhdZfv4t4xBYUBG6ehUup
OX71YVtBpzrZ1sdJYg53uDEt7Px94XfkB5BispT5SHckwxVEGQ6imsYo0TcmHF8u
q0ELTGUN2MNTQDGKIDgmK0cAL2EOsjCWFcmS8GHqYq4DZGE6zxsfWF0x4+JkS79Y
AN1mn6HBniBMzPY41ooh4cBKq9y7nf04T1BkQeMbHhHJ0WPftcFo9CmVdISYllAi
5QcxV7j7yO9FhXGmktxZ2dsGdt41Gan4jNFOhH0mQh+zC7YjjB4X6c47BijkUy+/
haAbpBYIvjsMrnZ47xE9UVBOCv1YY9tg+q4nwFZy3ABO2eNCKFu59xQ1TQl6JIzP
oXjvJCFdfdR2Pzv2O0mAU+9A3T7+x4kyCQ2wwoNXu1sQI6OrdOunpANs1qjP5SGf
2yv+b7NPSElNIXaL0pob2gCaAnFJI7I56zMJjMHx/yW8W6wY5leg7XtMnnD3XOO9
/ZmiRsODbH48Z/P8SU1F5Wi0BBrPngmds7K0kkIJrcINLIYVvKKtJgoR1jsU3NnK
34m9MsIYLL2N7LEo/vNSoqQF58aUz2CfX8Klv5ZYWhEXrYPTpToxb2OSVM2xetxf
xClMjjbLX96cGt8jHwcN1QpW5QlfMUsvllygW97oU30zXfjGCK0=
=LmRm
-----END PGP SIGNATURE-----

--pqehfju4slo4lchw--
