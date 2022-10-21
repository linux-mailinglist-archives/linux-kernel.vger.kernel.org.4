Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A24607613
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJULXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJULX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:23:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB1263093;
        Fri, 21 Oct 2022 04:23:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g7so4550943lfv.5;
        Fri, 21 Oct 2022 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqpdzxh11piHyrsdYH/hMiJ+aTKND0zUJe+5TRJCoCA=;
        b=Z0bH4IF8UY8KyFRVfg89Ce9qfemn10tWWyc9UKPS5DUGTeX+mCHfG1Rl9Akl6r/MCx
         YeLIDU5fEhR1wlP2osDsN8bXKglWOOBIj7dL+Il5+JKJc8pD0poBJZUgXi9n4JrxcLqo
         IRtelBKZIP0czN0m0WulZbOhzyRuTIsnZTChhBVu7NRDtpj76wqDx9WsIL5lYVsT9W/m
         40njxh8s1iO91waXHneCSNnRvnkYaW+Q0HS8p/VcTLMDWdv82I5iBkNNWxSDVbOg9IYe
         cJ5pUj4QCBKAWbUp3AeizEpFR3ikXcAkMowHS+/o8N7Df1mmduCtAG6x5Tto04Hu0sp0
         KurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqpdzxh11piHyrsdYH/hMiJ+aTKND0zUJe+5TRJCoCA=;
        b=39n9HEWBtPCQM3gQT9g/ojO/H97uaT01E10LwkwSGX25iI/3pakwQMnp9EDp22cy/j
         wRFc/I+RPg2wqhEaXO8PhrKt1YanDFTmqHgnQeC7/pOMANGSFbCWwF0/slaeEnl6VV7o
         moKDsifkYAyv9ityGIX0XtZYoKwlGj5eWUwl4QpFNesEuie5YAeBAs/NMMTBmZZqcXpz
         J2mX2WXONNnmPTg4qhJejasXRsanxL7w/AIf4InHYg+REJImRQQ3nWNdBOfc/01CGgzN
         xrveznXfwu8at31yt/CX96DG0FG17p6utP9KzVxVlwC30slLLp4wLYBMIV6uNn/daGLb
         FT2Q==
X-Gm-Message-State: ACrzQf3LIlgAaGAtZRevbZZhz9WT8IxHOnCE/lIf361SfY2FCH5RYdkK
        VXjRKD3R9veB/OOX9Lmf450=
X-Google-Smtp-Source: AMsMyM5o5dWYAn/8FS+pHRs7ka8TDtNjya43of5VK6oNagezPOdvuy5HO5EVbsUKFJI+n+5l9iDTcA==
X-Received: by 2002:a19:6558:0:b0:4a4:7fc2:7927 with SMTP id c24-20020a196558000000b004a47fc27927mr7038375lfj.674.1666351399998;
        Fri, 21 Oct 2022 04:23:19 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id l2-20020a2e3e02000000b0026be1de1500sm3341009lja.79.2022.10.21.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:23:18 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:23:13 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T137bSOkmQEtsLas"
Content-Disposition: inline
In-Reply-To: <cover.1666350457.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T137bSOkmQEtsLas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..3ab9c5f97dfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
 F:	include/linux/mfd/khadas-mcu.h
 F:	drivers/thermal/khadas_mcu_fan.c
=20
+KIONIX/ROHM KX022A ACCELEROMETER
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/accel/kionix-kx022a*
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
--=20
2.37.3


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

--T137bSOkmQEtsLas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNSgSEACgkQeFA3/03a
ocUp0AgAmJzPCSyJryGc0AplYi/SZHhLE6YmLR4uVa2187xwviNdIPY40G47bRcg
+Au2IT6ckmurn5UWX6a3wvsN8tWvjnfSSVcXAuu2HVNRExVCAuSvXgP2GQcmlNyh
q1baK+3n5itvJvf1mz8EbvqEXeTzZUZ5iux7VT0uXiAcyf3Zve2J8QlwSZUtnvGT
axuvQ2XW/KXnB3ifNFDiDkO5VS0S4buzNOUyrYPRH8VXq48vIawydM0gvwl8oBFK
mFRaDCUnukmo7gOCfL6Ts+Yt4JqpI9QL8t1ueOZ4YQL2UbUf3bBmPJ1FgTm3H8vU
cNa7g4qIJNubuZn3NpFLCKrAizbFQQ==
=Muhs
-----END PGP SIGNATURE-----

--T137bSOkmQEtsLas--
