Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2769F8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjBVQP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBVQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:15:55 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC83D0BE;
        Wed, 22 Feb 2023 08:15:43 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e24so2122681ljj.3;
        Wed, 22 Feb 2023 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz3lK4uXKSeVg8DcNZTFoTaIwiKybc6jHkOnoRlG2ME=;
        b=MxsTDX4EQg80bndxgGa0zhgfWuvhUzJ9qqC2GFJ79xKwk4nGd9FS1lvpnnXubMbNY8
         FLRLid1tZtemjFiNb7SRPBmllQ/0NgInVn8WealcvKXMj86/qHS/P28YuaRVAh6QIw7B
         0mxE8ZPVxabBA0kLSIWCmYcTv3fqd//o/cJH3OVPRJk99TY4ME7yjTYg1lHa0wNAXR/H
         EjDS2x1Q7FnZdYtMyRRECn4trPbWsGQ3PsBYncOJGmki9ksSX89CS3w+hCNVvSrvw9cw
         xAT7NzYxkP0TzAOLIMn1/NZBVrWWwCc+yJWX2o7Db5QiAD7QzMkDXDT1DD+03NcvoG9F
         z0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz3lK4uXKSeVg8DcNZTFoTaIwiKybc6jHkOnoRlG2ME=;
        b=luvkziuAVKhs4Cc7DX9txkOLOwCG/MieuF1GfESPMP/vBz8kjcsqkWKLnAD9SIk2wY
         5ApdY1d3+66AHr5AOdfN7kcsVGucxJP7JkFcvSyUsnBEy1w2u3AlpwfKUSo3GFTBRk1B
         cOu7mfgBTHL7hzUOxBabKZWnR5k08c2SyeQFOEGEwe0Qgq38Rn5DaH/cla8olNUImIyS
         zWTN1WzxaxMSP+afaNuufiM1MmVOospSCM8UnI7e8Vo1NfGmg8+SC6LsPu+NGBP6dGKf
         IuHa/Lq35tIdhSkFdoSArCWpoDXQRkQm+k2N657y1WtGNNK4x5zRxaH3BybPPGOGNATI
         HjFw==
X-Gm-Message-State: AO0yUKVcM69Sb5A9Q+Il71w9JI+iuD9+qz1Qi7ZuwlsFhweP3+TIeFMy
        0EOWkG05zZS3M1LocylxVos=
X-Google-Smtp-Source: AK7set+nGDjPROPW++aKYnxhiYlswuO95tomifQi+o+Rfc1x8NgNNeyCm5vljnmCXKdbpwBsgJtvsQ==
X-Received: by 2002:a2e:9152:0:b0:295:9970:9f73 with SMTP id q18-20020a2e9152000000b0029599709f73mr988894ljg.29.1677082541240;
        Wed, 22 Feb 2023 08:15:41 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05651c232500b0028b6e922ba1sm1183658ljb.30.2023.02.22.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:15:40 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:15:34 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <d31b566586774801a65eb13d329f1dc68a96d2d2.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vB+lFGdjZLHs/F9Y"
Content-Disposition: inline
In-Reply-To: <cover.1677080089.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vB+lFGdjZLHs/F9Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for IIO light sensor helpers (helpers for
maintaining the scale while adjusting intergration time or gain) and
related Kunit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..43f5a024daa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10052,6 +10052,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-env=
elope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
=20
+IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/light/gain-time-scale-helper.c
+F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
+
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
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

--vB+lFGdjZLHs/F9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2P6YACgkQeFA3/03a
ocWg9gf+LMYXYyPpgC4/SdKAsWvNlezIenTQ+GTUVdz0gM4DJKTysOrjUaQW2Kea
YUKtqwfWRYc6y7h2R162ukZjCiKTKv6NUPZyOzLrxmpeZsKYLQHec1/MZ1+r6Mv6
I/sPWzq84xoc26SHkfMt5Z74RZ7QkpVX5B3yHoilHnDkdV8lMdlNXWBHCCTLaZM9
BxnW1AwBbZPw/6Db3XP43k2NsfxdD/4F2RO3UPRd4cCcDXBqC1y+ESlvYD4hVqTS
o7kENXn/JAnnKUxepjjlXUPTut1bg4CWHKF/ikS7e9SG/cwz95TSjck7bzi4nDVv
n2OwKg0EcODPOWcHYB5a7rpBH6uAJw==
=5QVW
-----END PGP SIGNATURE-----

--vB+lFGdjZLHs/F9Y--
