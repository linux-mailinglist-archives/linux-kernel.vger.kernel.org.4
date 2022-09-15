Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82875BA2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIOWk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIOWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:55 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8DBC4E620;
        Thu, 15 Sep 2022 15:39:52 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 614431616;
        Fri, 16 Sep 2022 00:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281591;
        bh=z+bHJUZhZw6AgtmFbhkEVNMXd7B4tmecX1P8Y9aMnFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVYp4JOZlf5O+234CjpJRivKGJMwDrpkd2JgUqiVHpT5RUuRn+yodFuTa5igTdQZI
         NdN586GYU4RzsoY1r+6hQRx+8qwXX95Psl+NAd8Qteam9SjLSmAqu0EV4FwvjvZ1C5
         jDoa4O3RT24If8FiKurrdZujSlBL8ikkC+fpcY97gHirs1fehZsXBGELlfAnyTa1lp
         U7VijHkH+EQ6B/COmX8JzIi7vHEycX+elvKE8i38A13v3glSl4YArdDyzVkwW8R84h
         ib/c3hZDvWf6Phufb38EInJe5bCaL5f2tvfh/Ju/E+rWE4hXLAwTJ3WXEERX0pfcJC
         jNIcBXkDOyFm1neE0Hz+HAVpSgrGZlQF1HOtCoXy20mLQeguFcs+YEAhEkOKyjsQ0s
         5SErsVNL/o85ehfVabSRbelzMgKigAUyDXSaHRAbnLB+FUBX8k4iV3a4XobEC65k3C
         KUZRNqnjtmwp2yvEhJJIEjPVYpzDgMiGcW81JhMFF3IaoAMreRYe+k7XJlOscKUeHn
         FoNaLZJiSabB0yrSjoOJ1XPShbGYhrq25klqfKH/Gffjbeilr2qt4YH+ImJwVj+46l
         AyFe9/hRy29kmJForrwKEZMtWHLguHsxMrdZ0vavZCnHT5PxM4ssbLaR24g4lyenQl
         lrnvz06COJhMeAIolQx2OGKI=
Date:   Fri, 16 Sep 2022 00:39:50 +0200
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
Subject: [PATCH v4 11/18] Documentation: RIEBL_MAGIC isn't a magic number
Message-ID: <773e5a8fe80201bed0dff5cdb1ce6f4272b0cc92.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrqphrmf26ymszxs"
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


--nrqphrmf26ymszxs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At least not in the sense described in magic-number.rst:
it determines whether the Atari VME Lance Ethernet card has a hardware
MAC address or not, and is set thereby to indicate this

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 687eb3cf4f0a..a85623d5f4b3 100644
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
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index ec74c6c1d05b..03d9fc9e6bfd 100644
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
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 9bfe4fa8ca10..d6b1cfed51cd 100644
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
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index b1f8f2a6d725..12c3a62403ff 100644
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
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
--=20
2.30.2

--nrqphrmf26ymszxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqbUACgkQvP0LAY0m
WPGjSw/9Gd3NNW74sqcfIqMBd7ALTqZh/4F/CvkbQ7IfHkfmno7JseK2v+QIxzrh
x8urBOEnZZLuiMqN1oC12pugYoGW4Gb2l9lqwERMCHh8kbgwAPzPUMdBJdfw4Cdu
PTcaQ5S72Efuc9q3WdTG94hMrTqvw4jTXRm6czm9zKwdi8E5eTIuw8qqZf/VrgDe
2UmoU5xTi0epVrLoX0Gxneugo5EaSJm3iinDvu9+Db3Dj+Odlh9N2+0rqVseqNlY
Augpt2o/sG9qm2a5lnM8V0STacmrz2QWmNWDNTPvY64VHShbvJCbGO8gE/kWbalb
ESwe+5D1rBZyqZagzzu0LyG8ENV0p3xkI97DkhOtBROSiGpvW+tzJoQgcCkJUMlD
uiFrJG4TzrXApVkldWtIvxdNN5FTFTO3N5LHasoL0L+n7p6ElQJ6+kQCw4GDCHpd
uvurmrbyQW1fohRwpLDYcRW+8ogxB0v5SumWG65RUhHldwJkr1pmdlyTgFZZxTBN
fDHCOetXkKpXNuysjSJ0AEQizrTPT3UD4vPTaBa56W/PdWllVrYKSSaz367okbAY
tT3+VCJ+/zbQnuFO0RhJsBt9bIDy522EszjSBlcJg1VhjZiWtWPKPIAeJEuB2ehD
bxWmErJXG++PA8NQcOfNROTaJWinv61DnIHxgy89nomyvGKud4o=
=dLxI
-----END PGP SIGNATURE-----

--nrqphrmf26ymszxs--
