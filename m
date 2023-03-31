Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0B6D20A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjCaMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjCaMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:42:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574311FD2E;
        Fri, 31 Mar 2023 05:42:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br6so28661621lfb.11;
        Fri, 31 Mar 2023 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680266541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNEmxowoywq3WMNEF0IOfpwPS+SU2BJthzKtRZ1+ZJc=;
        b=dQUARDfs3jl+z/BT7IHle4vTVbF2FhuzOi9BQFcjrtu7ddIt2jzfSlzeOW8jAoUAE6
         qhxdYgpx4OlPYoOuH0hxoioBexavXVYBnuIz9LMLsoDrkh/I2NqxdU4MBH2zKVqlEylo
         ZiqfogQ+wJQozKjPle4sUJgcG2So3N94/VcnB4SaUugWHqbQQkuyYyyCC4AEUxLAbU8c
         tav+Wbkt65zqCXe5MCVPuiaBxRKLj0xXM/le3HpGzGX2lzF8Af7w88NbzRtsXxine8GB
         B9F7I/+H/IIfZcuzDN8oR+MguleG2Lez789pUZTWyjMEi8VLWn2zzl2amtNGCCdo+eWe
         kRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNEmxowoywq3WMNEF0IOfpwPS+SU2BJthzKtRZ1+ZJc=;
        b=vU+hntB6AM6f7LiokQhWw2GAfvPOr9w/AJyuba3rptlKThtuVzhdXiIxtVM9dvZQQN
         hiZSmPybKXPclvtsQkalV39wCC7yHjKXwHvNx1U2KVVmVoGMXZXZIjSu3cRhD7qKvnzE
         Fv4Ee9JwbQISZ2XOwF/NvobZlBJhIA+AZb9dYi57rwSS03RUZLvGzBj4QVbLyAacz4LT
         vwq9utpxv5h+E4ZwLPG0haSvNcLf8DQqkKhHDFfiRYkX0rFbtR4AmoET9bnmiTulRgJ6
         ikSeDdVNPj2KtE4AcM7f7AN9OKMSEgVryOfzrSE9JLNo3YV9QKkgDcv6mYxOWAZV5rxB
         RjQA==
X-Gm-Message-State: AAQBX9cyOyG/8nqMVFb2t1zu5ENpkzWf23n2NrTH4dHFGzatDpM11odr
        GT8fMlCupw+uEkPX3utmJv6C9DzwQxQ=
X-Google-Smtp-Source: AKy350b7kh9A1nBQyVGjGpe0uzmbYvTMOLpHf+4vRrly5zjXxI+sRyEl3LDXbOmj01a2E3tGPQnaLg==
X-Received: by 2002:ac2:418a:0:b0:4e8:595c:60f9 with SMTP id z10-20020ac2418a000000b004e8595c60f9mr7123187lfh.32.1680266541301;
        Fri, 31 Mar 2023 05:42:21 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f15-20020ac2532f000000b004e887fd71acsm360364lfh.236.2023.03.31.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:42:20 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:42:17 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v7 5/5] MAINTAINERS: Add ROHM BU27034
Message-ID: <eac4b5f7fc8adcaac59ffa73e46cd7bb9c90edfa.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ifJEDPDGs33PZSK"
Content-Disposition: inline
In-Reply-To: <cover.1680263956.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ifJEDPDGs33PZSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27034 ALS driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes
v2 =3D>
- No changes

sRFCv1 =3D> v2:
- Add iio-list
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ec9326f4ce9..3f13466e50fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18100,6 +18100,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
+ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/light/rohm-bu27034.c
+
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 L:	linux-kernel@vger.kernel.org
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--0ifJEDPDGs33PZSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQm1SkACgkQeFA3/03a
ocVshAgAi6P7MixAh22l7imkshpv0NWnNrkcTh+xlMw1KxeA+eEu/yf/MNhuBVo5
PshT9QDyBrAnNWvgTzBqUkXaHPygeeX7eST5UehZMWGC78mXMQ3PgL43cTUKWWqi
1cQebjEVEa1Qk69Ifj7/gXMwPkK151GCFAB1bFQsaUrs3OPDHfJMoPmRkCQZ9geX
1Zn6Del9mZPx6TYtfjqv7hoGm9ED2ny4AZgaK8lfi6Wb2HQTuDkt+y+wzkymJ3QM
78fwkYFOS6snhYgoKCBtOt/ZSJ5cBLnRJs0QShYmi44bRWeINvx5x75iNe+TE4jV
36Dqn1OsdNbmOALstqOJr08WrG2dxg==
=hCH6
-----END PGP SIGNATURE-----

--0ifJEDPDGs33PZSK--
