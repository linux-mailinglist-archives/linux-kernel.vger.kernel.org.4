Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3ED5BA2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIOWke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIOWkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:03 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48DF05A2E5;
        Thu, 15 Sep 2022 15:40:00 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 17F001618;
        Fri, 16 Sep 2022 00:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281600;
        bh=qA+MFatH0jJlgH4hAwyv7icWkDYlhBl68VgbEDFqFPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSZL3bwhtuSLEHzwzYTdapKiljrkodwNXc8WrWFpPxG5ZD0fpG0pjuSUqxuJcXfEA
         JZkr1hvdvPjQhhAWrdCp8Hm5P/yIpZ1JTYbpOGQrNAa7ZN+zlKLjjcOawM4P0YcpR8
         pxLwbaPZ/byD4tl9K8ArEnOG+YGX5mbzl2TnettONzH0xpJf6GWg4XjcOHFBHMRF4/
         enftQD9mXgzy0xxIwrHKkw9I5GAOT8ldU86TLv81QGpOgVPBuMlvrsM2teNh3Jv0kt
         3X0SJNom/ROaRv5y/BtYR0dqVqIKrQKVHyAYlQ/VJhO4wr/TmeyXys1VOXrZGkCns8
         py9CwCPfGx2o9rmmxG+DTVsC+v9C4jXGQ1vOBOkzCVzoeVrT/rEgU0EzU6p/t4cXB9
         cVkKXPlTECvSv2A2Ud4pFwmofSKRU6pJdxpJ0KCuH9ZV+FA4ADPPMmUg/7zSfR/Vmf
         hKPj4EurrrJXxNQoJ0T8A9jJuVNUBrptWHG8myXQVw3fNQsGkbq/+fCpy0AqatRMEE
         0nRCpMKmBRmDFikqPitIjwL3V+NNCtYaMZvjbFdWdsj7x8wOlbfo32eSdOZrNIGyep
         /RtEf4mMbu5K977cjG/1O/Kn4K+0tXMRbOHYQYqe34mXu0e3UULGoAomavyUlLepC0
         PtwOafgZS6c8IFLpsGTHL734=
Date:   Fri, 16 Sep 2022 00:39:58 +0200
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
Subject: [PATCH v4 13/18] Documentation: COW_MAGIC isn't a magic number
Message-ID: <f24a428d82713821ca571bf477a099252d06ae14.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="il4g72ybhaeebpj2"
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


--il4g72ybhaeebpj2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At least not in the magic-number.rst sense: it's part of a file format

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 5258fb55249c..81ce545ffaf9 100644
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
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 4d7982185ba4..c1eec1613255 100644
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
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index b2aee7e7ce00..be72c8bec907 100644
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
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 84419f4bb348..81f05309f6c8 100644
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
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
--=20
2.30.2

--il4g72ybhaeebpj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqb4ACgkQvP0LAY0m
WPFAKxAAiYCF1MsKGJb2bcUJc9hd//ByLT3HEer2TZUjZTPTJV7/XwF8LmObX6GX
1IU6mTu4SEySWcM7OvXOahDMdw8SRIi3eirFjERRwZlCZoIokyX7qkM50lZuF5Lh
LVjIjVnvsjM+7N6SF4FDUSepOz1lj2IkAz8r/z/9B1Dqu5ZCfB7+6zEh61IL0ZiR
48XT2KcAGwQcI/vxPBC9oF+WK01MzryXBcNjdHyLcgBGWe3PJV1hlShymiLqmIIK
HJ6Penq+O2+rX4PUlMuJKixULNU/lu2sh4foLsjEHg4tYBj+nor4mrm2/hES6t85
IYdJP9mzWb+SvgOuNKOErPtImwMVcwX0ZJcGXsT6gjVF09EfupLR4Is6aRti7QUJ
1+7NmTOvkI90jkxnYCZ8GyrVwdxRY6M8faxV0PyQ6jmBahiEx8fF2u0u2SP02ZPN
p29+VZcKRBQDVQy7ftFEVY037WvQ0gdful3gilnJWwg4hsdUc1IBc9TpLkPlzvis
AIKqaFeErOF5iWZsNiPnayGTDOeMxa4Kbyk0FmBK70764zF094Tgg+bx+xhAm3EZ
rsAq5EiuqyF/0SHiGKgQPcI5zmuroiPc4EvA/BoS/WK1xKjIs1GnHmuY4dWksxQj
Ihm7TgcNE+3aVnJM/2jQRgQYZA1kk/fJHeWMTdISQOTFG84qKbM=
=IFqh
-----END PGP SIGNATURE-----

--il4g72ybhaeebpj2--
