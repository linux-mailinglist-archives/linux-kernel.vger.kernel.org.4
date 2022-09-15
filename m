Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E15BA2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIOWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIOWjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:21 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6091F4DB4F;
        Thu, 15 Sep 2022 15:39:20 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7FF99178C;
        Fri, 16 Sep 2022 00:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281559;
        bh=qGhBueK0ebRZKBKB5KSb+2Cz4DQKd7gwlKpohn9BcrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZnTu49axRqIawCkMmp+BBuVVzvcrMEM4Vzu+Of83+6HBKKAi3IT2RE2ITp9dLGyI
         DxesgsqM4f2NLHm0JP7th0Fd88GD1X/BP2xdfAe1XMGB0kxKitfNIOZD9Olo7nc24m
         biHPoPx0EdQs3VHV1ZpBAP9SSfkP2RNALXhK3occcMGydfOBjhFdGe9WvTreAade+r
         hwYHW8WElKW5/2PBXtWhXcHkUFD4/bUUXHvJf5S3VTRHKHAvEC/ls9cTT0WuUiMi8C
         4WDQ0tfSSfY2TYKHYw+rH/2F323qCSj0h+yDuZrTocMLy3dQWqhE22XH4S9ZzDrrcD
         7sXom/KZDab2B5jPkyKllG0ZHVEr/vcmYnhscLNw0lrbDpU9BvGiA3SQF9B7Gew84h
         xiP1k1zQQqMKIWI3LygOON584du0VVNt2aJ/XvlB++Fap6u2VI6dQyPLF24BtlrPtX
         0pYcXnr0Qc1lT9Bdo0Rzze7HbQ9RTGRkYa1007XFY2gTV7JguzuhyPCBTYDTj+DjGQ
         dnBxNqEcx5RUPGS+vP/0DtF1h4UHsYt7XcCiLfUCUbFGnd7kR4i4EK8PE3u69xkuX1
         tozIJaq3FbjBWG/vrJnd+9fbIyu6HkNAoNqhsMRd3iDdjoMBGjfG6FV53Fy6n384Qi
         r1QwsAoYC60xVdTZ82fsq+uI=
Date:   Fri, 16 Sep 2022 00:39:18 +0200
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
Subject: [PATCH v4 05/18] Documentation: HFS is not a user of magic numbers
Message-ID: <e67cec702a7ab34a8c5f7966d930d793a097a90f.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="legriee4eyru5guc"
Content-Disposition: inline
In-Reply-To: <YyMlovoskUcHLEb7@kroah.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--legriee4eyru5guc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In fs/hfs, the only magic is for delineating on-disk block types,
of which HFS_DRVR_DESC_MAGIC HFS_MFS_SUPER_MAGIC are define-only,
but they're out of scope for magic-number.rst

Magic numbers as described there were all removed, along their defines,
in the 2.6.4 "HFS rewrite", pre-git

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 3 ---
 Documentation/translations/it_IT/process/magic-number.rst | 3 ---
 Documentation/translations/zh_CN/process/magic-number.rst | 2 --
 Documentation/translations/zh_TW/process/magic-number.rst | 3 ---
 4 files changed, 11 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index fb1fbf00f49c..95598fc7d104 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -104,6 +104,3 @@ Note that there are also defined special per-driver mag=
ic numbers in sound
 memory management. See ``include/sound/sndmagic.h`` for complete list of t=
hem. Many
 OSS sound drivers have their magic numbers constructed from the soundcard =
PCI
 ID - these are not listed here as well.
-
-HFS is another larger user of magic numbers - you can find them in
-``fs/hfs/hfs.h``.
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 2f626abbd2c8..1e85864de9c8 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -111,6 +111,3 @@ Da notare che ci sono anche dei numeri magici specifici=
 per driver nel
 lista completa.  Molti driver audio OSS hanno i loro numeri magici costrui=
ti a
 partire dall'identificativo PCI della scheda audio - nemmeno questi sono
 elencati in questo file.
-
-Il file-system HFS =C3=A8 un altro grande utilizzatore di numeri magici - =
potete
-trovarli qui ``fs/hfs/hfs.h``.
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index f3192ef7158c..8d7e2ad7e124 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -95,5 +95,3 @@ NMI_MAGIC             0x48414d4d455201 nmi_s             =
       ``arch/mips/incl
 =E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E5=A3=B0=E9=9F=B3=E8=AE=B0=
=E5=BF=86=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E4=B8=BA=E6=AF=8F=E4=B8=AA=E9=A9=B1=E5=8A=
=A8=E5=AE=9A=E4=B9=89=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E6=9D=A5=E8=8E=B7=E5=8F=96=E4=BB=96=E4=BB=
=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E5=A3=B0=E9=9F=B3=E9=A9=B1=E5=8A=A8=E6=8B=A5=E6=9C=89=
=E8=87=AA=E5=B7=B1=E4=BB=8E=E5=A3=B0=E5=8D=A1PCI ID=E6=9E=84=E5=BB=BA=E7=9A=
=84=E9=AD=94=E6=9C=AF=E5=80=BC-=E4=BB=96=E4=BB=AC=E4=B9=9F=E6=B2=A1=E6=9C=
=89=E8=A2=AB=E5=88=97=E5=9C=A8=E8=BF=99=E9=87=8C=E3=80=82
=20
 IrDA=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E6=9D=A5=E8=8E=B7=E5=8F=
=96=E4=BB=96=E4=BB=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
-
-HFS=E6=98=AF=E5=8F=A6=E5=A4=96=E4=B8=80=E4=B8=AA=E6=AF=94=E8=BE=83=E5=A4=
=A7=E7=9A=84=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E7=9A=84=E6=96=87=
=E4=BB=B6=E7=B3=BB=E7=BB=9F-=E4=BD=A0=E5=8F=AF=E4=BB=A5=E5=9C=A8fs/hfs/hfs.=
h=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BB=96=E4=BB=AC=E3=80=82
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 3e803e18d492..d99c96a06c68 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -98,6 +98,3 @@ NMI_MAGIC             0x48414d4d455201 nmi_s             =
       ``arch/mips/incl
 =E8=AB=8B=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E8=81=B2=E9=9F=B3=E8=A8=98=
=E6=86=B6=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E7=88=B2=E6=AF=8F=E5=80=8B=E9=A9=85=E5=8B=
=95=E5=AE=9A=E7=BE=A9=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E4=BE=86=E7=8D=B2=E5=8F=96=E4=BB=96=E5=80=
=91=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E8=81=B2=E9=9F=B3=E9=A9=85=E5=8B=95=E6=93=81=E6=9C=89=
=E8=87=AA=E5=B7=B1=E5=BE=9E=E9=9F=B3=E6=95=88=E5=8D=A1PCI ID=E6=A7=8B=E5=BB=
=BA=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC-=E4=BB=96=E5=80=91=E4=B9=9F=E6=B2=
=92=E6=9C=89=E8=A2=AB=E5=88=97=E5=9C=A8=E9=80=99=E8=A3=A1=E3=80=82
=20
 IrDA=E5=AD=90=E7=B3=BB=E7=B5=B1=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E4=BE=86=E7=8D=B2=E5=8F=
=96=E4=BB=96=E5=80=91=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
-
-HFS=E6=98=AF=E5=8F=A6=E5=A4=96=E4=B8=80=E5=80=8B=E6=AF=94=E8=BC=83=E5=A4=
=A7=E7=9A=84=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E7=9A=84=E6=96=87=
=E4=BB=B6=E7=B3=BB=E7=B5=B1-=E4=BD=A0=E5=8F=AF=E4=BB=A5=E5=9C=A8fs/hfs/hfs.=
h=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BB=96=E5=80=91=E3=80=82
-
--=20
2.30.2

--legriee4eyru5guc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqZYACgkQvP0LAY0m
WPGRFg/8CyZQMqwKL3cna2UMCjJIdVtuccTsLLVblLiMYmnleScos80OoJcgzARD
A+M/9h9OvSOpX9k0huEtRvLXgzNJHL1MosyJnRS+ZJSS7Yr2CsYimsRUpJ+BO5LH
KSvf0T5QeChSJTdk579++nm3vwSHmTjGEadmPJLP216VlylR4J10TolccFbL0D3m
8rxiBhmiolSfw7qyp6pI8jNSdfTokZu9KlO1YvioZzis2P/NqmK/jkhJO3mkA72i
RuuZeXY90obUF4Mk9WbKxCHxtk8HD99Z+h1R+Il6QHUdLYXvAU6kwjyMwGxvWGQ0
e/UCjWEbPkwmjCiZleDU/wmIAJbtEnqCWxA/iFc31ldO9p77K3HExz5dpkoF2Nyp
EPmYUc76GF44yl0vNZTOhZT3it4l6RE+COtJVJicSRTidOuUpO7mH6wLh0QIKtLI
XMDgNQigMtZRZbqBhx7M9e4syWkGcGZ45l0eFSarH2ysL+FFALd/InQ3yMAiNckY
7oPIOyC3eGCP59nAFsrP48SXhHbFPqGwEwmOaulRUoMDC5/6YfMpHy6+3MHB3uWW
j8PK9Ao09luKqMI5VxUIYBSF9W/4zIOLOC3HQK8ZV3IwJPFePaUfjRhR/X+pvbu5
cxL6fSDHQxxhSgbMeLxmahnfSN/pFostZh/kuZVtPg8i88zjAjs=
=jMYV
-----END PGP SIGNATURE-----

--legriee4eyru5guc--
