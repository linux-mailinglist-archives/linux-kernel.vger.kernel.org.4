Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABCE5BA2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIOWlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOWkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:36 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3CC63F3C;
        Thu, 15 Sep 2022 15:40:24 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CF30CBC8;
        Fri, 16 Sep 2022 00:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281623;
        bh=uSiwbfwlbAmVy/bvi2OxiTS/OaWTkmogxTkg+BudNu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWcvLbVKAnnJulSKTKePt+dSLjrulgaXcaq3PJgdnR+jZ9dhpk7WjsMGZfDQp+rlD
         pABG4EHsy3lC/1CxdgprvZ50lQ/kvzHUtqmdHGg1aRTww2Cf4Y0bIJ4izIBevIjQlh
         ho0CxCvfRxL18aU6VB9K+sneoGMlkMzh/OlgWqkbbzttCYOIweW3HRVqscxUXg88Ph
         aL3kGg/1KmM5WzhkJBcQeDrsYaAPa4fa2nnuULeg5dHCpcUtVwhRK5SlToJ4MTkBbI
         kGVdpPZQfNyZi0dZt+UyUeDGRie7LvTUv2i2y0FMmd7i5kI6pcurhX1TviSMLqAr6+
         YSUVcgsvzHSObXFfnrqeR6Z4NKWGHNBGqgl+pu2VlzVlcsyDsg0kYUGh3OKlhBBJ8p
         YAIiCKHNx/dEYSz3RLLlNRZOGzXK7QJ1JlxMHNSab5Q+rPty2QJhhnaGd38t6qY3PN
         INS4A/gzaqDDX9zXHVheYAkwO6IPp5TLh+ZRTRgMNuPgdH/xsPMctmfRBZzRB7BPVG
         mf/lcpt42OIP9yi4BIDN3GUx5UANGHnX/qZ708KpTscaMRcyi68GkItKrXcmU8ifAd
         iGhFwwGEmwoTlQGj7IvZ0KvItFTuIfYLKibDljkaYk5p17zmXBdOEzZDp0wPzKZ8mP
         y8AI1lh0bfTiPP01hiIiSH8U=
Date:   Fri, 16 Sep 2022 00:40:22 +0200
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
Subject: [PATCH v4 18/18] Documentation: ENI155_MAGIC isn't a magic number
Message-ID: <5f1dfa09150be7f23fb275d170c9019b5197a79f.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q3sygo55ovno2tcu"
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


--q3sygo55ovno2tcu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's part of the EEPROM format

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 520cbab3ee17..f420fa2d7f8b 100644
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
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 33ad6186fbd4..fa7f926649d2 100644
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
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 1a8c7d3c98b6..4371f1683693 100644
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
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 40063df8ba84..3e83f18b9c18 100644
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
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
--=20
2.30.2

--q3sygo55ovno2tcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqdYACgkQvP0LAY0m
WPG6FBAAm69t7iWQh2dYeucifgxqyST6l+63EoAJUUnwtmT5q2we7RXU4ZfU7w2C
0ZT8+wjLYsXIpxrz/zOGFOhfLP2aIoTtkP+QgFPJxaiZcxVigbY3Rz5gMQYobf79
6qi7d1k9j5zh1cPn73lHT/zxPlTTvF399z76Vc1TawIOV/EdkHSCAOalat2EqF71
fRr1L3z1py7kdF2V2tm/o3pr6VZ9V0VgVnQBZ3dMEO/DjZ3j6OPlfIJzFpm8oDzQ
80TdIlFRRXEAXGE7xlktp/jMuMglLRjjJO/skFYewpKjWirZ5skun3xnpdy2wajO
LQXLx75jw0mCWWXf7aanD6z7/vfB9DqGOMvowWsmU7W1miLSONchC/MSlI2D8Xlf
sJGnHdxoE5zkT5916FW9neyQiaz3sktu90gxj+wn07XYrrLJCOWsNDsXKVaUQjJX
Zrk4n+byVAk/WufEyFPcOLWHagC5PtdTZJVbWHdtAoNZ9f1xrDFRIIoh098rSXlQ
P7FMRctCDOaBjbQZCfG6ysr4+/J67AiqnaKnD17HAdcse4f2HRc91iscQNYgrm+F
cNSzNNn3pNo/NuPzAotENNhjBZNPYs+TKHqhZMS1TcOmCjXXbJrwYprDbWd3kxN4
8eOMCi+TGe5Qv67I4grkXvaDhnlFU5+wWEgh6M+55BkQFsHYya4=
=SRbT
-----END PGP SIGNATURE-----

--q3sygo55ovno2tcu--
