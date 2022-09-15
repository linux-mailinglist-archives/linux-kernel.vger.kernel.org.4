Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1895BA2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIOWj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIOWji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:38 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ED7C13F72;
        Thu, 15 Sep 2022 15:39:34 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 39ECE13DC;
        Fri, 16 Sep 2022 00:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281573;
        bh=aoUHk/MSTL9FrGzPr5nN6/GsZPBfgkDSGCsPH7cZvQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0W8vLSjxp6kDAAGvmwlf4PnPgJec8HJVLB3ZATGhtvIE1lSafnww83FiB3dtV4/b
         10Fa8xMFjWXRKCARMNoVdunEBM6ul/BMbW7xqlxb2gfy01QpOiJW2h1LveZzsmN18Z
         9esC019dSuv28Zb7TukIaQE9ATvb3PzF64KZ/4JLB/sRtXmmAt2OjOXUYZVW6GkaHb
         2y7xHNc4ghrwqWuZVOepToT10lu6yYEpEDYUzQZaT9yY3oQnCEWuWmzI+SsXwqhCRW
         yruL6N+HBX2TnPuI3yA2HqXgl1SMErIykWstTwCfKS4Vu6HTsIzqM38Vi+NvhbMLFo
         kVaVEXKVZpqVOLlfg8seat5kUTyPaNBDbAH/59213rywCIYgKJHgAktbpiDGNmSMA8
         agEY6wALjSE1j9G10trUy4Na0UGYEy82i6uRgpFAVJmC9UmmMjA/Ix/q7aC5z/Zyst
         7TeRjSchyyowd62FsRe8vi42jfrYWLsLGg0+rG3dhfcPhB/YEeiOl0nW3OiMUc4pZF
         osXlTxLLlUqzskt6w4rJ7CeF39bcAHloY4rAgznRku9yFpSdGcRApGPG9YH/h2fRaY
         WKimx7os6J420NXqlkr4/oRHx7TtOHBYOr2eG1rOid4K1nNx8fCnYoKT0s1h68KsJ6
         gxfOa1dHj4VcrKBz7EjuPV/0=
Date:   Fri, 16 Sep 2022 00:39:32 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, Hu Haowen <src.res@email.cn>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v4 07/18] Documentation: zh: remove references to IrDA
Message-ID: <d07ce5b1bc173fd02b7e5b708beb81b9432745f8.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pkqb3pgf523se6uo"
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


--pkqb3pgf523se6uo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These lines blame back to their first appearance which cites linux-2.6,
and IrDA was finally fully removed in 4.17 with commit d64c2a76123f
("staging: irda: remove the irda network stack and drivers")

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/translations/zh_CN/process/magic-number.rst | 2 --
 Documentation/translations/zh_TW/process/magic-number.rst | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index f0290ba8066b..3e13a19a1fcc 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -90,5 +90,3 @@ QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry       =
       ``drivers/scsi/a
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-IrDA=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E6=9D=A5=E8=8E=B7=E5=8F=
=96=E4=BB=96=E4=BB=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index a55e4df610c9..0fd7eb32d159 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -93,5 +93,3 @@ QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry       =
       ``drivers/scsi/a
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-IrDA=E5=AD=90=E7=B3=BB=E7=B5=B1=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E4=BE=86=E7=8D=B2=E5=8F=
=96=E4=BB=96=E5=80=91=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
--=20
2.30.2

--pkqb3pgf523se6uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqaMACgkQvP0LAY0m
WPELcBAAnz8hD7LtTeqZ/5uD1oshD55XGlsZ94tcG+Or8KM6MboB4+CleI85gu6J
T45dvDpMEfGHaKtcWjo216BGkYfQk9NIOwdj5LEvs9MS4hpj8oUfc52YIvC04Tl4
8kpXYbHDMD+l35Sb0lyJwPYhmO2JS1gqEW/vhXBIp78qH4TsMxR3JQSJxVEtjWaV
0J/er9toMMdR2p441elvdLtJW/+yAv/iF/iQRmvCkvbZPYZH6wHTiHV3At4spZqX
RU+hw9vQcsOl3Wo5LzdqYzbcrUhdx0MuEuMM8KGIt7E/sD5161WHSZGWfsqF7LPG
Kr6b8F73nEd9kAMuDXLmDnaW3Id4doK4mfHOH7MAZioJwiBojG/LATrQ23bLrJye
6FYS73NqPtRtltZkqbBwBvUqwo6iI691fIVwEPx4YXokowgLXN1fwIFlU9wByxjd
IbtrT6NW1QuKeSseAeSP+8Gr+9mu/BrIA653QLMwk3Lat0lCEijRzwj18Cgvg8AM
8Zuj1lvpnHff5+PAbFCDPpBtHlwyeSwJ935zFTJrAPc56/4ygLZ9qc+UcgSMmdu0
8eZ1v1CuO416IqJJfHSA3jhexaxdE1BYYbqWTbcdZAPAPVMdHV6dVwep0wCqrlR4
De4KJMGUjOyEJi+B943of9nWBa/1bBb1Jfth11w/Du5n2mcIjJM=
=KQoh
-----END PGP SIGNATURE-----

--pkqb3pgf523se6uo--
