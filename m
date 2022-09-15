Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD435BA2DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIOWku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIOWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:40:12 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D79465838;
        Thu, 15 Sep 2022 15:40:10 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8EC14161A;
        Fri, 16 Sep 2022 00:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281609;
        bh=zXXRcNsmtulZKzwxQk14LXrLF1zlYcHCmX9fY+5aeFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH9PyNiwW6fcvS3AL5h1pjyLLqQ5dR6u0HVasZuypBZ6MNyEYuCqC3FE1cS/v296F
         KyjArHK/lZVFyMT9qG96lAegLxE7S807ZSn8cAYzswfoy6id4GHG5hy0C9bda+8WxY
         CCkNIC2kgdnFicfFjhgQkH20uQFj8aQq0KdilGFOgZWkf4X8xfLUwVohAH1ggzTf9L
         1r74olSAN9XEmBMBmz0UgBzMkARTRG/8Lsx2LuBPGX01MamThFB0cyEm5DiBCVhZXv
         qoj+O0ZD4z+qOXE8I4VBxufL8xjah4zXsIalHaXovb8R86ooF1s8crf0V0mSfJkMS0
         6OyZZLHKNh1X3UBbdAcMvvRR0eObfYLo6arwN7wIytL/a3btTaM/qwo3QwhgFWbZrg
         oFZYl79eIJ5v5oBavyYyPOmoHKCgxmdbZE71h0Z5fHGPSInvqiwC7K5sdxiXJ6bhTm
         MXskahCV6FTFOrqHc/q4+3AM57AwyiRoWLLdVZwwEALnycO3dWNCsU/ka6p1K/EmwT
         zZg9VTTCDdhGJ2xMUgE0tMTdMcnFgNm6oOFS/GzEuRDg0NjV2ehLI5F7CfdRllzjbD
         gCtvWBTVDCeQr/O52Ki7z8WnvV8vfDYRahiVNWFKkmEr4Gj819CnNH9Y3RMXPzVpEg
         sIoCmic5hGeoTfQ1q/KDGk1w=
Date:   Fri, 16 Sep 2022 00:40:08 +0200
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
Subject: [PATCH v4 15/18] Documentation: FW_HEADER_MAGIC isn't a magic number
Message-ID: <1b21808fb399931eb44f0dc26fda20a632ecc196.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtl5djjcgweft54z"
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


--dtl5djjcgweft54z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's a file format identifier

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 7039608d1d60..e242ef9e5dd3 100644
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
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 9988f291764d..0730b561ff47 100644
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
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 0afde5eeaf64..70e46ecf8089 100644
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
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 2e57bd3b97f8..e2c650213d51 100644
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
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
 LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
--=20
2.30.2

--dtl5djjcgweft54z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqcgACgkQvP0LAY0m
WPHxwA//Z/BPrfvwvgH+3Tjae8JCssbglBSjJDCaL9nBdlL6U0gWU3xqqNL6OdSl
wQxWG9kUWGwEG/xAE1YiAJsoWYp4vNvCvdaga/gn6PcYskBjZaNHzuKNqEOUNguI
hhtnJBvj9MMRsYxDEEhWjuc9RNN4W8Bi3wdZKx+pB0LhDoMA8GatZ6qEFj35BAbh
9P3fqqU/FEIwmyQjKRjKw+6vaNAxaTszKt2oZhmRNpEdBXIcnadetkMWcpwZsceU
Fw2zfhxn6zlpDj/aIEQshsmCbqE5fbQJL8Tf3ricOgVuAUGRfzMVh8CaqWxdfctX
PtBROb3qWSTKTd1gF6pfktbV4lOFirzqshYpE3cRCRnPDZ92cFLveMs48uMnBiqf
HgSWubWmlLHRcZqU7qDWm7RjcZWl7t0wzGZbztr40SeiC61ybk14drHBblbac9UI
b34DVpKv73xxNKpyCnDNKiG1yOgVEhM5HY2emgP1+iHe3WKu8G70jqXcnC1+HIJK
4rRzDidX/gXQG9uTXywtwCoiG46xP83XtHXQRwvoh2ejgVhiPCee9qe+uW7cyhxY
egrtR4SDQbl08rfqB4gcRTSOt76EIBD6ompc0fp8wxx6ZcAlfrhKgmYijN6ffHb7
6qvy6d+23ix/As5foAepmnFEUFxE9lO/ir85rJfVFSyJdYcS2iA=
=XOGx
-----END PGP SIGNATURE-----

--dtl5djjcgweft54z--
