Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444045BA2DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIOWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIOWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:17 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 100B53A14A;
        Thu, 15 Sep 2022 15:40:14 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F3CA6161C;
        Fri, 16 Sep 2022 00:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281614;
        bh=LJxbxN0p+J8K4MB6fZQ/FX68iUgDSxVET1nGFcHAxDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC9LxH81GBDUWS66rXqUxR+BRXg1iwoTKrioNmZDS2v0lCvd1wM+lSHHiiFytSw3B
         6Vb2KIeDz1mejudKQsmwPwTxqEBxngcMVCKPhKRQwHPcy2cMP8ohX6RQU7DwQoF6aA
         rk+qus0XbBml2Ts9sUwIBKihg6fFEe0AdImxESxD720xW4OId8+NcIlJlkiITDsVuZ
         xEAPGZ+z2UpRvdCIrh7f7KC3Iw6Wj2fNL+dDkOlirxDIfFsksIWTNqEzTFVMH8TO+o
         GlQrRd1u94EFPZvogOMRBzG+YGLI4E7CS3S0NZo10ImB6BDt/kEWzkAN9Uy789jlyN
         niyGI+wu92fvGzg0NLb0q2z0Rb5S972+NLeCDBeWODYSW7ZKP9WMhlgrBK2MOwvQtf
         cpF3txzKg5ZP0GPciHBGbgaGNWFvrwlIyz0q0t0CYvmklb5Nyt7mKW5okmN741PDX7
         64bifIfc2vpjF1KI0F06QSmNt1XV1LMwfWGlpXNx93SgfzicaY4AsS12CwJwFrnqIu
         nM0uRlzqvqFnPeDQ7vyvDWopT3+qVSDDlPhDxsOHizeaDlBP9TXO93pqgeGKQZXmZf
         o0VRN5qfUvwFy0iTvxNwh9WXvoihaKIzz5/EZyN/w1RbgGB+FL9PJqGyGJFuK5CEFR
         lAv5k4ye3tPfxl6krEp0q9wo=
Date:   Fri, 16 Sep 2022 00:40:12 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH v4 16/18] nbd: remove define-only NBD_MAGIC, previously magic
 number
Message-ID: <10a80681c5966fed1a1afc696e3db114f481514c.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xpjr53kvf7ol5gv5"
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


--xpjr53kvf7ol5gv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

commit f4507164e779 ("nbd: rename the nbd_device variable from lo to
nbd") renamed LO_MAGIC to NBD_MAGIC; commit 5ea8d10802ec ("nbd:
separate out the config information") removed the last users of that

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 drivers/block/nbd.c                                       | 2 --
 5 files changed, 6 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index e242ef9e5dd3..3f72252d9fd3 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -81,7 +81,6 @@ NBD_REQUEST_MAGIC     0x12560953       nbd_request       =
       ``include/linux/
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 0730b561ff47..db57ea55d3be 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -87,7 +87,6 @@ NBD_REQUEST_MAGIC     0x12560953       nbd_request       =
       ``include/linux/
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 70e46ecf8089..c555e857a210 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -70,7 +70,6 @@ NBD_REQUEST_MAGIC     0x12560953       nbd_request       =
       ``include/linux/
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index e2c650213d51..ebe99277b7b3 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -73,7 +73,6 @@ NBD_REQUEST_MAGIC     0x12560953       nbd_request       =
       ``include/linux/
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a709daefbc4..e185d7b5f1e8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -157,8 +157,6 @@ static struct dentry *nbd_dbg_dir;
=20
 #define nbd_name(nbd) ((nbd)->disk->disk_name)
=20
-#define NBD_MAGIC 0x68797548
-
 #define NBD_DEF_BLKSIZE_BITS 10
=20
 static unsigned int nbds_max =3D 16;
--=20
2.30.2

--xpjr53kvf7ol5gv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqcwACgkQvP0LAY0m
WPFaRw/+KLY9JQVt3S6Uq8YY1O5AK2Xvnk8+Faf/e5+ajK0ZY+tODhLaUj532JPw
KryqUqOduysnHgM/9eQ3E3+UwMqu/Q4YibiPrHPTkJkbSZIZAyZqahtSXM7+Jgi1
W7iYjWtxk8ayGEAazuX0+f+7K9htN7grQNEhnKnFvRw0KVN74sAi01SqT5vxHTja
zrsI0nPVVWgjiDYTt7PTNu3QSkoY1/mBtORzrMnCLOqRSiVS3IFFDhQMqt/L1Wcw
SG3bqKEU4noZPrIj8uP8C9MRMkJKzJGNZsqhzKZltuhcUXYVAgkjkaSpsGWgbz7w
UIJAGUVm2VXqdbGynmSfyxXJUX/q8PVWEiJ3zDHdkc534JLjlIKBbSinFkF3cMyC
iSzkp5VA2RLWBYru/+E13vpH16gPstxKxPv7lZxCx6ZUms8ZBuT3R/oIchEHKJxm
ZziSa/Iq9bVKl2lqsh4egkugcAtp8LkVoyOj6HT6Zx0QDlrAL/wDAJBg9XRYl/Q/
M4rfoKffAJgsFFviwKhoripKIB2rSXbeiiX8lIEUAugSDxzM/0FB06dMQB8lYSMT
RSW4VCpN6aRYHTB917vyRAdvQKUV3H8zH+abYBe3zVJb8+QZxFgzop7NJfHFJW9v
UXGtgUDMDEPPIr+EJRxQ2a9rONdS67XMs4IOPuuylNwKy/j1L20=
=bjLr
-----END PGP SIGNATURE-----

--xpjr53kvf7ol5gv5--
