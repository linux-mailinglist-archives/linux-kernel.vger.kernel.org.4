Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868D05BA2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIOWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIOWj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:39:27 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CA7B140D0;
        Thu, 15 Sep 2022 15:39:26 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5D5D8178E;
        Fri, 16 Sep 2022 00:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1663281565;
        bh=xGfOa70TFxQHhzlr1nx8b4nJ8l2WPiRsHQpT3zT0PPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMLaAzwUh3iTaCPaAzaqCoSSVld0oUhm3qVSvcQR8RI19PE6Vbmh/EkQIGuwpr7VN
         WI6inmTCI76kX9EhHGIrhNZy4AOdXfSfQSiKad3LbF3gV5Vu/PyBAg+cfnFl4XLyrE
         ZFCaFyOyl7vWlFkJxa/91MNUM0/tuUJ2C1TkzR5bRTAncwTU/KKxdIhiZGn8aSrRii
         K53QeDoGbxlf26OwuqKAZLN/z6nCx4hNe9e0AVbVzlmoyjpkXmCQzAZFbDJou5Gr2y
         a3JfNw+5tqAiYetImrsjmyEu2WGFDir1ZWwTZ7aJTLEN/xJhhfaaqNafdNQrsPzoki
         b21MA993U+NGZ/CoDNQxJRwUC2jG7RMK61XE4VFXq2TIwLEzHhNn4Cn6hMmqUcDdd9
         dExnn0dh4/jEK2Owsef3BAX0li+sTvnVyoKLure9koHrtal8O7X28wa2T4B5bnGcZ7
         cAT21MadjUofmPM2M9pM8jbCEZlB411ehSS8VuAw6KeNeiSPcr0UkXvYsHKxw9VUnf
         FhhF1NIsttX0Dm0Ccta8oQ9bW2ku/7EtTLiakLRLkuBMuSC/spfSsTlUro4AqPnfDq
         Qm9qeX1MhE8MsGbOis3WhMTtajpwhtxvQYvqQhP1H+AL6YegSQERU9J5nTODj4GQO0
         Gr379fOYzSn8PcIBYeBRzlmw=
Date:   Fri, 16 Sep 2022 00:39:24 +0200
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
Subject: [PATCH v4 06/18] Documentation: sndmagic.h doesn't exist
Message-ID: <09e56999b0b323fb0add61f7dbd8c9f0a576561a.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <YyMlovoskUcHLEb7@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpbr3p6mpx7spkyu"
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


--mpbr3p6mpx7spkyu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It was added in 2.5.5 and removed in a 2.6.9 "ALSA CVS update", pre-git,
which states:
   Removal and replacement of magic memory allocators and casts
   (core part)

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 5 -----
 Documentation/translations/it_IT/process/magic-number.rst | 6 ------
 Documentation/translations/zh_CN/process/magic-number.rst | 3 ---
 Documentation/translations/zh_TW/process/magic-number.rst | 3 ---
 4 files changed, 17 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index 95598fc7d104..478c3c0bc863 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -99,8 +99,3 @@ QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry       =
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
-Note that there are also defined special per-driver magic numbers in sound
-memory management. See ``include/sound/sndmagic.h`` for complete list of t=
hem. Many
-OSS sound drivers have their magic numbers constructed from the soundcard =
PCI
-ID - these are not listed here as well.
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 1e85864de9c8..27846e1b1b3d 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -105,9 +105,3 @@ QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry     =
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
-Da notare che ci sono anche dei numeri magici specifici per driver nel
-*sound memory management*. Consultate ``include/sound/sndmagic.h`` per una
-lista completa.  Molti driver audio OSS hanno i loro numeri magici costrui=
ti a
-partire dall'identificativo PCI della scheda audio - nemmeno questi sono
-elencati in questo file.
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 8d7e2ad7e124..f0290ba8066b 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -91,7 +91,4 @@ QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry       =
       ``drivers/scsi/a
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-
-=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E5=A3=B0=E9=9F=B3=E8=AE=B0=
=E5=BF=86=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E4=B8=BA=E6=AF=8F=E4=B8=AA=E9=A9=B1=E5=8A=
=A8=E5=AE=9A=E4=B9=89=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E6=9D=A5=E8=8E=B7=E5=8F=96=E4=BB=96=E4=BB=
=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E5=A3=B0=E9=9F=B3=E9=A9=B1=E5=8A=A8=E6=8B=A5=E6=9C=89=
=E8=87=AA=E5=B7=B1=E4=BB=8E=E5=A3=B0=E5=8D=A1PCI ID=E6=9E=84=E5=BB=BA=E7=9A=
=84=E9=AD=94=E6=9C=AF=E5=80=BC-=E4=BB=96=E4=BB=AC=E4=B9=9F=E6=B2=A1=E6=9C=
=89=E8=A2=AB=E5=88=97=E5=9C=A8=E8=BF=99=E9=87=8C=E3=80=82
-
 IrDA=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E6=9D=A5=E8=8E=B7=E5=8F=
=96=E4=BB=96=E4=BB=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index d99c96a06c68..a55e4df610c9 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -94,7 +94,4 @@ QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry       =
       ``drivers/scsi/a
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-
-=E8=AB=8B=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E8=81=B2=E9=9F=B3=E8=A8=98=
=E6=86=B6=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E7=88=B2=E6=AF=8F=E5=80=8B=E9=A9=85=E5=8B=
=95=E5=AE=9A=E7=BE=A9=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E4=BE=86=E7=8D=B2=E5=8F=96=E4=BB=96=E5=80=
=91=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E8=81=B2=E9=9F=B3=E9=A9=85=E5=8B=95=E6=93=81=E6=9C=89=
=E8=87=AA=E5=B7=B1=E5=BE=9E=E9=9F=B3=E6=95=88=E5=8D=A1PCI ID=E6=A7=8B=E5=BB=
=BA=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC-=E4=BB=96=E5=80=91=E4=B9=9F=E6=B2=
=92=E6=9C=89=E8=A2=AB=E5=88=97=E5=9C=A8=E9=80=99=E8=A3=A1=E3=80=82
-
 IrDA=E5=AD=90=E7=B3=BB=E7=B5=B1=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E4=BE=86=E7=8D=B2=E5=8F=
=96=E4=BB=96=E5=80=91=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
--=20
2.30.2

--mpbr3p6mpx7spkyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMjqZsACgkQvP0LAY0m
WPGP0hAAqbyLVnaCefwh5ezwgHsgO+3dmTUbSwQx1QmiXRs4tTXBbncybXrMf4kP
XE9Mk0iNvIKrsKPr9g1L2YrUPYI9/ByBzwjHztnlO1mW9hIVgmBl8sVixUT9vOF6
s/6EYWtr96rpnUwUcw3RzBb68geG0RtmXhQoBCE4meP+WpzaUF8Ff5UAxUU3vKdh
TwiVHGEtX8sD5W8g+7fGKCgwT7Fs2J/lv+FUqTa3Rix2ScgoZa6zipcU/Ljfc3IJ
YFvKKHSwtzUomxwK2QCGqX26hJX6rEHxyIYp+eijirNY/8JzXx+gKBNXyld6nvzy
qolE2oBP0SKE18AgJJpLqBEXx3wJp5n/bewRMSru7hnq6MTbhHof4/Xhr3CP21J2
eWsZSQQ3OGiv84V8q2D4S4oW2Dq0/w8GjV20TsOw1mam9yoA0dQOo1eLXQNUM5hc
FujvfpBZtEw3tRdxBO4qM3D6RvLWGOYc7gY1U2x0p2qiQ89uDAP02TB8xYSYigZg
bDOt+8i5NwaVa/5gn4ul4ff6rxCNPdGQr1KVvf1viu+v/boE7wRLn6xg4uPsz0oi
AtFXrEkQz5HLY8ntWTf5L2/WETaCv1FQ1Cri/xZdJXhwkpeVYW1pPmih1KwKUBzm
8RiWJzNPDpLGULLz4QmSLtLnkBjMOVJZKaA6Q45wprt/Ckoqz1E=
=I0XJ
-----END PGP SIGNATURE-----

--mpbr3p6mpx7spkyu--
