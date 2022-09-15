Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537065BA2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIOWlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIOWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:30 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D46AFDF33;
        Thu, 15 Sep 2022 15:40:20 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DB65F1510;
        Fri, 16 Sep 2022 00:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281618;
        bh=NcDp57NM41CxaRHeUFE46J8qQ8GsD0ZPROjOQuAUwfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPN644olUvRkqqgIv9NM/H6P6TJEOSOeYMyu2t9Llwu7dTDrE+k2TfMa3kcfYiDIk
         c3Np5ozHJ5W7x85b++GzzykX3Hw+qH374rd6/hBE5I6s+kDNaLRpEX5weG4U4jhfox
         VJNinnD/thtWLvnsEQ9jtQevT8tJJoqLfr2VEl4ns3+ICi58dZYniYmbEXOuhgI+zv
         23fp5YfXQbdhMqLJg2bocjnMbcfC4BKgqeVsD7yhvBJKh6n2hld8fxIXGsXgujuNlg
         ODc+LFLxWhi38rCfrlR1rpyLV+fU08BAAWPC6gfUCbvAijq3FpHukUVf+mnyCFFpgD
         zVuIdKKxNZ4U/pibMUtLNKpQWAcZxeWiXAMCZFyfMnXMgtQVgs3JMvD+vevrnMCx1h
         4YDQP2vQdKhev7UHmlgkbnC3UugD2UJxMPHnSnX3xCSUfUgahd8ACdEB6zfaLovxPm
         8Qwg6RZPubeHwdbTAtDLmeGpyS+Q1bVx6WT1ue1bmQFbDVT3UrH3kHsQlLGua8DBjD
         ASsyw/zd3YjndFiX2p5w1faOaP4H2BEHR8bWGY3fxHqmdN+rUoTxsNeiJXT0V/O9LH
         Q+pWbmybGStPRwHm8V8aETs5ykRyXq1gvEYnV4zLvGLx9jsBIV0K+q9Ge1WmGqXJRu
         tkE6LQO3W+wAEWsqlDU3KPWU=
Date:   Fri, 16 Sep 2022 00:40:17 +0200
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
Subject: [PATCH v4 17/18] Documentation: NBD_REPLY_MAGIC isn't a magic number
Message-ID: <a8afed8fb4d7df2c8fb95c3fa758240b2e46cdc8.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssbrusngf3o7lupp"
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


--ssbrusngf3o7lupp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's part of the line protocol

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 3f72252d9fd3..520cbab3ee17 100644
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
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index db57ea55d3be..33ad6186fbd4 100644
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
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index c555e857a210..1a8c7d3c98b6 100644
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
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index ebe99277b7b3..40063df8ba84 100644
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
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
 YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
--=20
2.30.2

--ssbrusngf3o7lupp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqdEACgkQvP0LAY0m
WPEL4w//YiAK5vgdzx33ml7mHTaZRfq0mnsN/pnHISadAYrawRsudLufQ5Q1UIoZ
QFqAkqBsfQhF/L5CWKDSsOrZnicDO3E01OY0Usl5wo0wcqer5mU5GvFX7UNPdl4V
7YVkB0BmvW1/A6mktGDVYFzZs2AJZaXLr1Up4KOgw8sV8Zk6BD2SfkC1rukqQINC
tCQci+J4OZ9Ohq865IWszTtX9Hvpg97V0u+aQC4W/dDgzoKvMZU1V1LQmfsAIVVU
IFKqcEvnUUDfRwUdj5ma+tlSs/XBHCPZIlCcg1TPtLdZOUmE4o6Jh3tvrjTwlBIy
n8wbK2QJOc+hqwQkTMvyZTh3K9YAuoGbVjNmRcSKyAP2EY30NMfbsLzuVF/ZhFFD
0rV/MpPuZ9f+u8TaXyA8dvlHCMmG17DqxQNuafVc4tvbBxCwviT2YyHMa95GXhXU
cta/0mCGa76AOC2pCGVVCXp8MU6zvMwdacgmTEGSUndVlByZRzU1HL1qT9YeR+Bd
hUrkrod+KWJfuAuJNHzvaE2PBegEa7ckOlyLYWJg1blaMFvmj67ZVtH0EY0UWgbH
xlu2YTBVwQRgXZBg1jxjEKbC0DR0i1ysNtL3M2gdf4Px6fKpFw1OVZbmynK/U78X
dWTWo+qIkoA6sVBdG3X5AU+M3izOcgOm6NTqYDv7fSbIDvS7us0=
=oS25
-----END PGP SIGNATURE-----

--ssbrusngf3o7lupp--
