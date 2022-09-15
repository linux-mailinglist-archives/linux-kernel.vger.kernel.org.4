Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76835BA2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiIOWk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIOWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:58 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF04ED5C;
        Thu, 15 Sep 2022 15:39:56 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C343313E4;
        Fri, 16 Sep 2022 00:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281595;
        bh=3Yz/e6VvCsxkJMZkV+FLO9p1JbLACTNPankUYZ/dIxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X85fN93zd32Bm0XRs3r94uPlySZVOaSwA0oBhEuc5ArkOxHpIAhlHr26g8BnHUbZ0
         AvLzUbveA28HlXu6qBcX30ZJPkje2CSacH2ajorml6wOUgs7KMMw05odaMUmXtU5vp
         zXn0jXG4t4UvVAbvFev5wJKDrZx+imyFUE4Z/KC6VEd2ljyVJv1MYnkuC+hZmJn01W
         ivDHbFH/yf8yAgZQ1OrSDC0iqCnYWZjM5MZKfn3y3RyNkM3CprBgvFCmSWHo+Py6ua
         Rw3+62I67fmyxDhnXpgu4nhW0FKxLnuQNvN5EWcxetSTF/2xIcfzG4+WiXr0TmvdEN
         e4zc+j33+ysaArABj+1mGALAAIhxHvtA0FV/es5Sr1rV9f8UgIktfsnUfOAsuj2LzD
         xrso/kYKzrIQb6TvLnh5TKbUh2ofYuGdQKdEnnGPoH/FhoaXsKdW/PPb2CnP/G19K3
         +lVEV/dzOUy5/8NvkE1Qxc8+i+0XgFiCmGgDNsU3V8Yrz5neVVCG/GJ58DnaVXtW/0
         QRIh4APLQb23GS6omuWY0vfjLNHRCRWsDtOJ48WWN2D+fIUzbXOVc6V25N2fPEGqE8
         vJUj/5KzDWaSYgvUIJbjhvQlp/KH/qKCNwQ7S2Dh4PgXY7paMty5/X4amgO8/fXzG8
         6pohM7d4R1Ca5WYwtOBMez1Q=
Date:   Fri, 16 Sep 2022 00:39:54 +0200
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
Subject: [PATCH v4 12/18] Documentation: SAVEKMSG_MAGIC[12] aren't magic
 numbers
Message-ID: <c0fe3aadb700621eeee736f0ce6d73aa9d2cf856.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5ofq5afb2shlyau"
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


--f5ofq5afb2shlyau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At least not in the magic-number.rst sense: they're used as part of
delineating messages dumping dmesg into Chip RAM on the Amiga with
debug=3Dram

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 2 --
 Documentation/translations/it_IT/process/magic-number.rst | 2 --
 Documentation/translations/zh_CN/process/magic-number.rst | 2 --
 Documentation/translations/zh_TW/process/magic-number.rst | 2 --
 4 files changed, 8 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index a85623d5f4b3..5258fb55249c 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -79,9 +79,7 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 03d9fc9e6bfd..4d7982185ba4 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -85,9 +85,7 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index d6b1cfed51cd..b2aee7e7ce00 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -68,9 +68,7 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 12c3a62403ff..84419f4bb348 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -71,9 +71,7 @@ TTY_DRIVER_MAGIC      0x5402           tty_driver        =
       ``include/linux/
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
--=20
2.30.2

--f5ofq5afb2shlyau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqboACgkQvP0LAY0m
WPHaTxAAqdgarm7+r7PC+MvA4kyTC+6Fv0dNJrhg1WA8PRAqkEDjTznLEu1D4+hf
h3sqneL24bcuNmbIY9O52zbjsTNccKRpxeUp6TP3noE/hu1rAENsnHHybqXccUlT
9NW13dBeJCa/782ySiHbN+JUfDvO+72uA4Ec/QFJF/tdIQzvQUTHn3tqwknS+0DZ
wH32dKj12c8aG0dtLUfYgwQBEez8fAacz9gwTxetxRQK4sqmV92KVAcCa69qXV1/
u/3mQMDB1X7g2gpjk32lqBkiUnWcm1LlRSS/G1Se0VJaNhIqJ6AkBBpO4wAMxAU4
pcpnq9izWTHhKNBsXTSRtPEw0I84Q7rjWcUUwl0uc0lu1jYk9QygfVFPu8RvCYza
tuo3D88Nxj8dPMotpQMUxu0ObEL9xXvrJ3c6Rv2S34owMIzrKQNl0UTFfBkvpukw
WtlzLVVB3cPCzYi/VmkM/1LbmPFWPLr8jmnkbYgTsCOMAPkPgOD16xckNnKexoag
HCw47TOL1wASlZBxKjCq9aYYfApC93JxDx6AugLzVHPF5mQqKF8iaWXjjGWivyPe
aA9Nu3ltzCg+i+AeMNISYZBcGHLi4LBv+o3VDKBmEWPkPyDc8m6XVajxDhdfMAM6
yUYSwsqqGat2JA3H1VieMAC1R9BQdn6im/IIjd1jeQN6PKSJU4I=
=U1gs
-----END PGP SIGNATURE-----

--f5ofq5afb2shlyau--
