Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0435BA2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIOWkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIOWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:54 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12914330D;
        Thu, 15 Sep 2022 15:39:47 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EE04C1614;
        Fri, 16 Sep 2022 00:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281587;
        bh=RpfhczrjQyRDjNi2A5keQuhy3D3gB+SDGLxs3kQRLd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgfojmTZt7iiZ9Hgy7Qf4Juv2ftkJIwujWAPKFHtO6eV889TxjYb84JTI3secdly/
         TMCt255GN0fz67KWFjLj7WfQ/P9f90qTwPFO15s9BzZfDgd+KbfUPH/jJix42O0tHA
         xTLzgZI3FRz5N1onSs2ArRM/nmZzO4Zpt35cJogDMsOGM31p/fZYFf+CtifKa2AFlr
         QgYJQS5mkZpzVmCSGVzDfNt96MzyjBKWwSbq/bcDAVtuDXseDvm+AMre8sq0s5QM6E
         uIflnuV7r1lf3q6RGIU0aS3mxs2u28+vbRZor3RVoCsBQJe0XRpEk+Gt5ECNQG43F0
         LrvFduSDlSGz1QafQowoaMRyEYSxj9vfsJk2Cb0GkoEuHr2+JQM8ZjxD4GYp2Rx/IJ
         t1n76WpVD4l5YEonQhIoxFiHzeUxNDCyMYEAuECB4oDSsqFWU+1uBHO3rFU/RtyQDo
         3GzZ8oqZtGxQf2FAViPDzsJueUe8c/PEgfbBLjoUeZXZwxJdRDyesrvTO76L3IS6Fm
         6RAaNkjMo2vYBj+QuECeFQr6/cR7nt3fRY+4JqZtFAi86N27duywGQmQn/CG03hhHm
         s8Z8qZ+yVh593hl9tjZbYH0YRpq3Pek5CvORXANYdfheqq9rrXzkX/PR0jvH8/z9Sq
         qao70REnKHekF9KExsM1kh64=
Date:   Fri, 16 Sep 2022 00:39:45 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v4 10/18] Documentation: FULL_DUPLEX_MAGIC isn't a magic
 number
Message-ID: <ff28a15f9154589788277807523aa71c45c24d28.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ul3qdfwbdocmlvkc"
Content-Disposition: inline
In-Reply-To: <YyMlovoskUcHLEb7@kroah.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ul3qdfwbdocmlvkc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's used to control a mysterious register on the DEC DE21040,
see comment in drivers/net/ethernet/dec/tulip/de2104x.c

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index b24bb1b92fd5..687eb3cf4f0a 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -77,7 +77,6 @@ TTY_MAGIC             0x5401           tty_struct        =
       ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 4de7f7593f0b..ec74c6c1d05b 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -83,7 +83,6 @@ TTY_MAGIC             0x5401           tty_struct        =
       ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 0aa97c98f479..9bfe4fa8ca10 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -66,7 +66,6 @@ TTY_MAGIC             0x5401           tty_struct        =
       ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index a24c3f0e0d41..b1f8f2a6d725 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -69,7 +69,6 @@ TTY_MAGIC             0x5401           tty_struct        =
       ``include/linux/
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
--=20
2.30.2

--ul3qdfwbdocmlvkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqbEACgkQvP0LAY0m
WPGVuw/+IB5yqr284pFZx6/M7qzz7+fT+XiSTQDbnMKroCTJ12MhhjrHil/Az/oa
wrdztqmOBBjF+N2d4fwSaJt3TApPApPlToZiaehHN7gkhAJcKa6uPxfwYhrjQDDR
zhbvL8KJ+/CtFhJfdX4nNqfcYKzsjk15dSutttN/ldhbvVBpK8fOKv/ic3UWUzXQ
6veY8W3XgOBQtXC8ouWkmm1CwJJnpFVWpep9jRIX8c2VJgVWwCJUulydM8fFaS99
6P1fX+kdnbpfh1lgts/Utatp7W7kfu0PeXdbTs4sJi9ZRU0f/1VIqD4+V3vXrGH5
7LcuHbR8cna5iGt2yqUr7PUPSmEokFyeMV5/637I3pdZFzjzCgTsiM/zvTJhsWK3
Bp5EVv5JXCc52f/ecPp2kjcUn6ewdB+z94F2wt+y3eWv0/ocI3006BBFSmXWhihg
QaaktzgPAi7Pgl6o226jpNIB5HzUNlbUivgdz2xN1a5K4W29pRKv8ZEK7XSU7/AT
FxcWcd+kg4wWXCL8lZZL0NzZfl1BbljVpumePONdGwtJ1eGz4tncuygOjf/8FEAf
Tj9iaGBt1VG+i4dg1Jv/PNowe+WThPxoQUcDZi+kJqDR+MPwjL/m1ZpY4OlMuFMn
nZqpjwWP+8xl7qSM4YCf3Xtx9/8DP5wEreirG5btLf3BeRZLJNA=
=baDK
-----END PGP SIGNATURE-----

--ul3qdfwbdocmlvkc--
