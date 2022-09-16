Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAA5BA42D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIPBzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIPBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:55:10 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C9C11AF12;
        Thu, 15 Sep 2022 18:55:07 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 70BE2E78;
        Fri, 16 Sep 2022 03:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663293306;
        bh=N3vQS5AYXxMLawpBRXT2LeeGvkV2SaAVtJNCbDHexlw=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=gXGYVaRWCN1FQEpE7xp/UX+JPuAWgo/GKtLk8prjYqPnKm2lmxKZX63vRZmLTqx30
         JDbldRPoVBnO17Zku6VMoRu8VfqxI+o7q8H6FCI5PHn40tRTWFMj7gGFo/vTM6PEve
         3zJWjoQH/vekzYHs/zayDTERMcaM+jnipJrWifKY9Z4NOueg2fKGJVgBqD2dGim9sC
         TJ+R8Dk6yTMorYqWv6L2q2DRquDr4n6inRZwMmC3yQNvZTWTwfEAC/fipTBPXzg5a1
         OhOZm1Wo6dtJAu67BkCjfHZP6a0Ug7FF+vmxS56MHAz8ZBd0aX4TEKB4AfN/RN2MZT
         TRtaLssvm7ujtzFacgbNuM10hvYwl+DFSE4r400D7Rcs+IxHHc1h/y/PDclnsajPtT
         AnrF5JZpkYuUamBG/PTIc5GY+rH4qeQdvohtyncDrnA2FK9cjdJsILFn9ILZ1zfaxB
         1NxwayzpHUsmhzjV8hxIvm+iDCszYME4lRbo4DFXUHXlpVMMWIKNcOluJ+ym5oO7UR
         LFnWKlEDSuiGTFQH28BllRmKWxxAyyMYsnHZp7GT/Uhfy+ky4PqN8aWCHLwbrDq+ql
         oaI6XkRQvPE9i4Llycc/3YqTXbRjxGB7dG+UwnM/DQBoaUthqFI0WhVfAqAFjVsdxI
         fkIBcKw68s8OPv1xLBut09V0=
Date:   Fri, 16 Sep 2022 03:55:05 +0200
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
Subject: [PATCH 2/5] tty: remove TTY_DRIVER_MAGIC
Message-ID: <723478a270a3858f27843cbec621df4d5d44efcc.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="swyyvwfzdtgh22iy"
Content-Disposition: inline
In-Reply-To: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swyyvwfzdtgh22iy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to Greg, in the context of magic numbers as defined in
magic-number.rst, "the tty layer should not need this and I'll gladly
take patches"

Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 drivers/tty/tty_io.c                                      | 1 -
 include/linux/tty_driver.h                                | 5 -----
 6 files changed, 10 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index b4c7ec61437e..d47799ba0ca4 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -85,7 +85,6 @@ STRIP_MAGIC           0x5303           strip             =
       ``drivers/net/st
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index bcb23384fefd..24022ab52ebb 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -91,7 +91,6 @@ STRIP_MAGIC           0x5303           strip             =
       ``drivers/net/st
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 6250087d36c5..811804996283 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -74,7 +74,6 @@ STRIP_MAGIC           0x5303           strip             =
       ``drivers/net/st
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index fd169d760bbd..8e37e00590f5 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -77,7 +77,6 @@ STRIP_MAGIC           0x5303           strip             =
       ``drivers/net/st
 SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
 AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 33962109bd10..d036fc59a2e8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3321,7 +3321,6 @@ struct tty_driver *__tty_alloc_driver(unsigned int li=
nes, struct module *owner,
 		return ERR_PTR(-ENOMEM);
=20
 	kref_init(&driver->kref);
-	driver->magic =3D TTY_DRIVER_MAGIC;
 	driver->num =3D lines;
 	driver->owner =3D owner;
 	driver->flags =3D flags;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 4841d8069c07..b0421f5de8a6 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -396,7 +396,6 @@ struct tty_operations {
 /**
  * struct tty_driver -- driver for TTY devices
  *
- * @magic: set to %TTY_DRIVER_MAGIC in __tty_alloc_driver()
  * @kref: reference counting. Reaching zero frees all the internals and the
  *	  driver.
  * @cdevs: allocated/registered character /dev devices
@@ -432,7 +431,6 @@ struct tty_operations {
  * @driver_name, @name, @type, @subtype, @init_termios, and @ops.
  */
 struct tty_driver {
-	int	magic;
 	struct kref kref;
 	struct cdev **cdevs;
 	struct module	*owner;
@@ -489,9 +487,6 @@ static inline void tty_set_operations(struct tty_driver=
 *driver,
 	driver->ops =3D op;
 }
=20
-/* tty driver magic number */
-#define TTY_DRIVER_MAGIC		0x5402
-
 /**
  * DOC: TTY Driver Flags
  *
--=20
2.30.2

--swyyvwfzdtgh22iy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMj13gACgkQvP0LAY0m
WPF1fw//QDsJljVX10mZTHRjFIsQF/g0sXdswWcwiLhpFd2sSlG0EgTImHFrCCfc
mtiv5c9bZOayJGorWxdi4niXDgBpuI1z5uH7ibcTD6C8kC3+wj0IstO4FP1i2Gdu
xU7/5IgvbWy4+qW9yXOaBt7firQWkQPSkHkE5sV5kYWDLSo0f28OkaBF43gWHk5P
ON+1Q1vnNd5710MXXiQ+251zRZ2uqfd9YZfxQrZGjza9kJZTFX50ljpULJi4mjPF
1Xb6ER+PQ0VYGbEqa6ejJAfI9IdSlXr5x4avjieeKSfnnkIP72taymbPWx6rKmYd
5AHVBcWPRBamS4ngCOHibkg6wUEVpkrMZkRYtLJeT6FlU9fwGK/IDb9TG4ft8b7u
tFpiExV6dJBEBCs2o30mSfOym2CoY9WO+QMOJt/4MT8JN0aKAeko02SwPCr/ohTT
24VarihD8Ot3Ww4Nds43QulJYIt2CbZ3/+aXGg2XYUV30RBIFvcuUBBO44Mih1E6
yCSWTdaQJ405r9BPlI4QSxMYPSKXbrLm/YcilhPAcrqM6/HJIyd4ymwAx/+cmCCn
p699Bxz8BGQ0yzvmGdru4NZFh1MDugjg62j51Mj7ovuVm2VqgXrTCbMjBQlBbF19
acO64/ui0L7YZiTTXMGgyOrkreY415bDfed1LbOOKY5Op2I88kA=
=45RD
-----END PGP SIGNATURE-----

--swyyvwfzdtgh22iy--
