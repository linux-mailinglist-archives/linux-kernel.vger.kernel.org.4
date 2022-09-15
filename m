Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D665BA2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIOWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIOWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:15 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92A0850050;
        Thu, 15 Sep 2022 15:39:13 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C8CC41788;
        Fri, 16 Sep 2022 00:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281552;
        bh=l1AU6Q89GEr3BmQnHBWunOTXWFXiKtc6E9sYbAlEk2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mreFRuRob2/Jb47FZ3IiSQGvLvinqLR4JBBb/UlqsUR/++FCI39pblNTNyEEbtuq1
         sPzu5M3xV+ETZBLCmtzUkQJ2JECJ60nFAehj4SFWQkvDwGv+ea0LwoyFBddAK0zbBP
         3Gmzik3LJ0REC9ZSNlmpbnPgKamOXAv4+EocG6u0inuIWgEzW2bvSZG1D/3qgdx5u1
         mFURMhpOhjeqPIW6B5koi7fuqUBAfn4yyVoF2w+XBKX2KsZG21/ggLK2rU4ToOhCdA
         D7uaA4J4ytUEMS4AZgXUPTvl0ktd1KnkrYBcYY3TwSz8rrmm2yTcDguJbSXVczpnbA
         F8JTQRZj/7yOLYT7T6lougiWarGHU/HFBuFD1/W8/4mfsxm5wie3eEbI+ZPs0vKds6
         rEL61bTn4bI6BWy1NpfYJG1CW6Qxeqopn+Jc6GnyUNTvUxnE5T74cjD51yQokwh78l
         /WoWFZX9pKFS243Hrw/9+9anDVDNd1Y86r+BYautC7FcIc7HVE9cpQalkyhyyITBMf
         wnOLuQlUW/nBZ4sn99iSOYHGSriC5vlznZeV7Q1Tk9uqMuBnJSB0HSvAGP4uQY4Ryl
         cV7Zlf0P7of9x7Y2ioijQJDwCWsRiSlEVTnO8mHRGu0cqSjKmtJtx67Q+q4nV1vbsL
         6yfaoKXBDlk1pT6pOpvdU0NE=
Date:   Fri, 16 Sep 2022 00:39:11 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: [PATCH v4 04/18] MIPS: remove define-only GDA_MAGIC, previously
 magic number
Message-ID: <c2e7510beebdd698e20d0704712e623fad00fc1c.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvwxo7sfyzulcppb"
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


--mvwxo7sfyzulcppb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The last user was removed in the 2.6.4 "MIPS mega-patch", pre-git

Found with
grep MAGIC Documentation/process/magic-number.rst | while read -r mag _;
do git grep -wF "$mag"  | grep -ve '^Documentation.*magic-number.rst:' \
-qe ':#define '"$mag" || git grep -wF "$mag" | while IFS=3D: read -r f _;
do sed -i '/\b'"$mag"'\b/d' "$f"; done ; done

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 arch/mips/include/asm/sn/gda.h                            | 2 --
 5 files changed, 6 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index f16f4e2cc48f..fb1fbf00f49c 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -85,7 +85,6 @@ BAYCOM_MAGIC          0x19730510       baycom_state      =
       ``drivers/net/ba
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 5366cad4a4ea..2f626abbd2c8 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -91,7 +91,6 @@ BAYCOM_MAGIC          0x19730510       baycom_state      =
       ``drivers/net/ba
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 08f5a83eed92..f3192ef7158c 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -75,7 +75,6 @@ BAYCOM_MAGIC          0x19730510       baycom_state      =
       ``drivers/net/ba
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 8a30da3d36b2..3e803e18d492 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -78,7 +78,6 @@ BAYCOM_MAGIC          0x19730510       baycom_state      =
       ``drivers/net/ba
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/arch/mips/include/asm/sn/gda.h b/arch/mips/include/asm/sn/gda.h
index d52f81620661..5b8c96d5b587 100644
--- a/arch/mips/include/asm/sn/gda.h
+++ b/arch/mips/include/asm/sn/gda.h
@@ -16,8 +16,6 @@
=20
 #include <asm/sn/addrs.h>
=20
-#define GDA_MAGIC	0x58464552
-
 /*
  * GDA Version History
  *
--=20
2.30.2

--mvwxo7sfyzulcppb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqY8ACgkQvP0LAY0m
WPHKkA//aKjjwaAs4MAgzWxJ4Ujq1CpYuzLkq9rTA0BpELR63vGDTYM7puDm1ePR
J7prkA0BC5DClWovtgEXsGULgVB/hxR9KpwUv+iixDZSWmfMh0/zuiL7MtO+xciA
4toIQ91w4wwG6WsLvbQHvfsBEeQfFdPZBpxFGcNTFFSAasX0iUzzVZ3PQ1D/zeCR
ynnE/8l8M0EQWxiAILehmnJ9AvXHFypF/xklxsWkrQV7EV+nr+QDZF6ao9MVdgPK
u7kMq4vMDHcJK7hr5tLfO49JW5JH6Kxrf+46S2oI2v1bV5InriT1HrD+zaSm+vVl
T/MCEzTmM0s+DRAQNtxIVpEIuCnErZOzb+iCwcaSbw1l9A0+8YnvJtXWIGK34kCi
jK20kzWpcqvHfFDeyiMHjPJCgKpmS5he5Lte1ybSjwtiZh+6e9cjttkRIJIZ3F9K
RMhK1iZ5SfDPIrVw2kCjTxwjZ4jRoRImZj8aTCqaBXYqkarQoq5cjfXtGDbNSDgU
WxCJkJNqw20BwMZSCERToBkxHIBC0ANUnkqTOSYd0qNzwdAtEsqtC84Epen/R4JY
aJ58gWekSVgEr2Jy4W6XLb6LbGQ5prQ6zhpYfVIbXYS9JxxGfUWmTWjtR1Rkuapy
MPzSNfW9lpqyRFKCMQFN5DuJcr/pMy6RRDu2cuKqTGOf55ZKnII=
=JF+O
-----END PGP SIGNATURE-----

--mvwxo7sfyzulcppb--
