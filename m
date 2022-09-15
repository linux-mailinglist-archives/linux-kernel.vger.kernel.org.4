Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAE5BA2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIOWkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiIOWjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:51 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 125AD32EE1;
        Thu, 15 Sep 2022 15:39:43 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8635513E0;
        Fri, 16 Sep 2022 00:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281582;
        bh=zek6dqsN1Df5q+fVXQctrkYAxt863IcYolu9KG9kFog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4goD5OesDAG2K7s+s7zTEnr1SM82EySm/oN1aOBA4vSOPeLtPa2dt9LVpL7bkXRR
         SAFIBrXkl+2vsnvV6fP1nL2MKJ67I5ca+JA+ULqAsLEwHntKOX5H4wQ5Uzhuvbz5Hf
         nLJJE66DhAhy4ZFVkTZLAWMbiIdE6N99rD/puzq1uPmur0X+s0vhtRruak82QmzrPp
         W+nwJt+qgPNpA9UH1PzUe9Tm3w9nPOsMxbCBA78kbfuyej3bfn2IsXA7Ebz5Y+C2Pe
         Akqc8OXgI9qeS0gs/uq4042beXJbpRaNmHyDkD/LkcpilG7WKeRJ94BWadPSTh5Pww
         esAnQrThhgTVVYi2GRbnjauApo4piQsYrd8WU5nTJ0x1wCY3oPDD4fomuB9vl73GL1
         F3MyuxTPyfJb15gxyo7EbQE/fOte8mGicTLUXBzGrgL61UodWs9AMyaOTAyaez4GAr
         gABSseHupT3cs9Wna+Fy+2uJGHWke1ztFOTVyDPonu7ymR6upEft4Jehg2wB6qy6eg
         swZQyshwDf1w7cX/6FhJTHyDy8rPF0LHFm9Yg82aXo0cfyr7mo+ZvYwJC6OwOeuwyF
         s5SDcKN1y2f1em1+v0IGEzP/AK8nUES7G34MhksnBLcvAyq4bTre+oSuW/RepFHwvX
         OlNqfnhSB8UvN8nZy74W+dPk=
Date:   Fri, 16 Sep 2022 00:39:41 +0200
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
Subject: [PATCH v4 09/18] Documentation: CG_MAGIC isn't a magic number
Message-ID: <a508477cfeb18eca4a24c29836f809fe34f20467.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncw3cd2h2uhkwlgt"
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


--ncw3cd2h2uhkwlgt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At least not in the sense described here: it delineates UFS cylinder
groups, is never assigned, and the only macro that incorporates it
(ufs_cg_chkmagic; the second one is unused) is used to detect CGs and
protect from filesystem corruption

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 478c3c0bc863..b24bb1b92fd5 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -78,7 +78,6 @@ MGSL_MAGIC            0x5401           mgsl_info         =
       ``drivers/char/s
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 27846e1b1b3d..4de7f7593f0b 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -84,7 +84,6 @@ MGSL_MAGIC            0x5401           mgsl_info         =
       ``drivers/char/s
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 8c4bef0760cd..0aa97c98f479 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -67,7 +67,6 @@ MGSL_MAGIC            0x5401           mgsl_info         =
       ``drivers/char/s
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index b071bd837e62..a24c3f0e0d41 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -70,7 +70,6 @@ MGSL_MAGIC            0x5401           mgsl_info         =
       ``drivers/char/s
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
--=20
2.30.2

--ncw3cd2h2uhkwlgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqa0ACgkQvP0LAY0m
WPF9+g/+LjC7wl1R1wyLiTWtIDTJyJh13INAJIGnolq4I5Qvj4ImCLjt2NSYyeZX
ZmmxtrHpmAkxvp3lTK2KP98ZVWJs36xBdzLKbDt5rIJafa/GuccqXjewOaHr/l+v
fuozE1/6bal8qbl93D5qfHSWzya94Z5QZST5aES3cWs3KC/NuEU1jmkDbAimJ4lu
K8RJdD7wgZV5vrqslI4OFOo5wkkeoUDboP+71YRnJhRxrwRry9gYVuj657DmYG9b
foaYrjmdYfRW7x1K0JCOHLM0P8khd/rLxRBQpMbcyxioOifOQ8hCnPucqz1cGMqT
6RAR+MXdfQi00B70KQffpTsfoV66PtrgYjRD4vM22uRp5bRQpPm5DxK7kzju4/h/
pEBg4XDNxzKg6zMrwGXrms4yTbFgzZFkfOnLSSh5vHETk1kvyh45BpSlCY5PfXjJ
zt611TUwqYg40s3jUtkVaY3DAVXyINQe+/c1wYB7TWojOyWgywx8G/3Ez2KLMxZA
jJOM9uiRBHERaXAfIEPjdybhGZdhu/G17VG6A8iD3oc2/2DEavYkfa9xvuFtJPU6
KMn+wcMdI6gy+graeGK1pxEebYCNRu8fRcpsQad755LKj60vQYkCpD75J7eRqVKl
ODAjDvbkXhj6dCW8iVcXukzen+rGDxpLZc8ysl/qXaXv7+7KkRk=
=NxnE
-----END PGP SIGNATURE-----

--ncw3cd2h2uhkwlgt--
