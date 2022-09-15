Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4030F5BA2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIOWkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIOWkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:07 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FAA5FF58;
        Thu, 15 Sep 2022 15:40:05 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F3F9B13E6;
        Fri, 16 Sep 2022 00:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281605;
        bh=M1JGbzREMF8OXcCGH0etdzCnTHm+FuhpN2ysgtzePhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxoYSykoeGg22uUqeQPGbqvpWjfJpVQalcoa01SNEkzrUbMAOFVRVR/JXJO4b0cE3
         JrEA6zjqlu3ppUYevQP+uvKixWfCR7e4a2gOvQ7nU0Cc7+BzI5+OMuywZRRbOGmOLZ
         snYm/aohHwVr8v0heDKXdasJ6Qe58BLmPS3tk2sYTSIrlyV8Ba6noNFnLOMpPL8Zi+
         XwmPlPcmBi6MvLRmN8BHd2sOlG7j/Y+D5754xKLB2r+fco4XWC6jjv8IE7agiZVaAn
         njlKIO9BPCnLAwdn7uZ9rG3KXCIZHGCUZpUGhgoLrkV8hmMRvGxPh3t/ZT1XkTsldS
         aWp8q51QWlcXF0BrGaEpQAQPNGAlGbparGRpEH6v4YJEHDwjNDv5A8Yxormil0z0CZ
         Hhol4UExD0CAtWYKVwH8pqXCx4PaFeAwzmYKtHAfFMTIexTNF+Nytd4bPlCmlrLbBW
         ziuUVllci+BMD/FeboTFyLv7kcl3JNVVYJ+s7Scmj0q/zYf+fj35Ua4WTQtaqtRMe7
         kEzjtDVpYZ62LeQ8DotpNsw+Yj478KxDU5PD7QCLO2WEGZoUwH8T86eWh+Fw400NiF
         dD2d2smfqYYJmviGfRY31M+AlSIyARhUB6Ye6XOkTw8cFRtRu/qWMqO4xYexcvJEtm
         C8Tbrbuqt5vU15zDDpPzsZIs=
Date:   Fri, 16 Sep 2022 00:40:03 +0200
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
Subject: [PATCH v4 14/18] Documentation: EEPROM_MAGIC_VALUE isn't a magic
 number
Message-ID: <8881090c8bf1850e1d3597cb352a8dd1757c94f1.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2h3hi6frbsc3txn"
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


--r2h3hi6frbsc3txn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's an EEPROM checksum, not a magic number per magic-number.rst

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 81ce545ffaf9..7039608d1d60 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -79,7 +79,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index c1eec1613255..9988f291764d 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -85,7 +85,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index be72c8bec907..0afde5eeaf64 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -68,7 +68,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 81f05309f6c8..2e57bd3b97f8 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -71,7 +71,6 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
--=20
2.30.2

--r2h3hi6frbsc3txn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqcMACgkQvP0LAY0m
WPGlYxAAsCi1tSSy4LgUDAoN2y/kvG4mPyQJZ7prI3B8MThDozboq2YtBpVsUEiW
9o6M9Sljp+0sY8H0r76pfY0SRvjaHQ39t8WaESl6aTuimBhsTsncQXGNayPIAE6s
snZWlpJg2i3U+cWDE4pVL6Xrv0H+s6XerWJRMrD4HHCpiDvHJgBL+sHpBj+HA5JO
Bptv/dHzAA4g4/OlCpgrw3EYJ01gAECl12GwD+tSW4GPN5FWFSIWqRMhATRH+sml
Vk8F5rZVSUSjcPrfePsLkMVig91S1+chOoamsCcASku4R83lDrGXNAQKT9MXzWPF
h9SXnaJm9QitbNCj9w8obbgWRuhcYlbCSlV8tidJtjFjTAlcDZH7jaTTMe8z/8Ll
mD35+i4jBfJaNyQG4i1LcExnq1tUbDPQNioSzPn1os5MAMIXmo/0xHYzCy79nAK0
aytFmcj4qXVA1M67khsWtSGUwAVQYyzddCJQ26coW1LOsjTGOopJiscRwfJ1yhoU
fh0ibTHzkAdKLiqqTCfHcJU87Ju4n7UjFmEjmCanhAxxzOuTmc0QEu6vS0CTC9KC
/DbC7WkEBBn6bQ49rFMDgtdDAopkKX3l4UmJOlBlcsPCNyGm+7V6U5fi9ZMUlBii
AbwW/RpkAND3f1mTeJoIIm2ZNK8QUEkVFgS0P2yC/UDYOhTj5BU=
=+stl
-----END PGP SIGNATURE-----

--r2h3hi6frbsc3txn--
