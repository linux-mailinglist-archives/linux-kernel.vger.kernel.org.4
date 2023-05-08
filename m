Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC76FA86F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjEHKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjEHKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:39:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327AA26EA2;
        Mon,  8 May 2023 03:39:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4950103e87.2;
        Mon, 08 May 2023 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683542394; x=1686134394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITL2Opz6E6A0DibX5pblUWA3qdWmUenAiQmhMjtE1P4=;
        b=D2iTdIJd2dvnUS6tDeRqImvxB44uq0GmGQnUQtbyB1LW3cehqdUB/G9MoHVq9MExy6
         9K8O58aPqmPw+ExIzsYLUKWD4laN2pfelvbn1ViF4FWdL7Z69LOwjGoRGZdWz6ZR3Ljj
         WKzTgbfb4Y+RdHKUDs2+qPYyuqL12qpouIAvsOY7/1JpIfwCYwrU+aZ5cCgBSRFxShjP
         BeaAzt6cQkvQJSxViYtla0fUmohznEkGlYLLMupQ393dfbPHbX3c3kc5Q9xsbYJpNRY2
         AvSKlwwZAw6NlkeLCQXtu2WxyqJHRv7LdsNyoyS/Kqb3398jgpWix02+MqiWCJ0sOgpS
         lIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542394; x=1686134394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITL2Opz6E6A0DibX5pblUWA3qdWmUenAiQmhMjtE1P4=;
        b=MWbqM5b8/fXIgKG3urDkZEX8NOgBOhinkwJ0mcVoWfj19JvV6b3/BcAEOtSz0Gehcg
         oTBJdLetV6F8jFFhqAZ6q9teNeNl8w2CXxiitHhjjnB5E4q2La/6Px67RNYFLk0GmPsG
         jK/7mbNxFopjqmRvlu7LUJqCJaSJjdnOpPZGbhBwUPeNzsfkpvu1JCYlYHHLTV3sgFgG
         rtusYGpTUrCR1g0IFMbHMczC09jYP/EmBUVj92fMkuuRf3OHhUjdCxuVoGgRRvn9jCeM
         vUo3hOrlLhEM+x61xl+F8/14SCfvBE+1TJqtwEgczHAyYWxc8x1x1B9pDUFUC/0QdefZ
         Jcmg==
X-Gm-Message-State: AC+VfDyCWRfryubGjImlEbJ4xEpeHulGmekNuv4ZplX/x6pN84e60GQ+
        PgB3ccaE8191y3XDiOrwJeoKtZCS2/w=
X-Google-Smtp-Source: ACHHUZ6CAahghdWRq/LOQPLWN9BZzrw8fWcZ7mq+GVYfzMWgLTwJH+D4zwxnzFC2x7JZD+Tp4shnFA==
X-Received: by 2002:ac2:5447:0:b0:4eb:341c:ecc5 with SMTP id d7-20020ac25447000000b004eb341cecc5mr2290694lfn.12.1683542394364;
        Mon, 08 May 2023 03:39:54 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b004eedb66983csm1245391lfo.273.2023.05.08.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:39:53 -0700 (PDT)
Date:   Mon, 8 May 2023 13:39:49 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] MAINTAINERS: Add ROHM BU27008
Message-ID: <31e25a41135ab0a86645b5078af797802b32f9c7.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8UjCQYjFpjbeJzQ5"
Content-Disposition: inline
In-Reply-To: <cover.1683541225.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8UjCQYjFpjbeJzQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27008 color sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
No changes since v1
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32772c383ab7..c02e3d2ec348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18198,10 +18198,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
-ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+ROHM BU270xx LIGHT SENSOR DRIVERs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
+F:	drivers/iio/light/rohm-bu27008.c
 F:	drivers/iio/light/rohm-bu27034.c
=20
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
--=20
2.40.1


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

--8UjCQYjFpjbeJzQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRY0XUACgkQeFA3/03a
ocVlYwgAoVdhy5/9TOCo6CvTPfep1lA6mtTvoCgdVJyKKzMS6cd/TI2p/VuHdyMU
ct3VYsERP0hvg9pkd8d1npeiDyhJ3mtCPbmnEj71eamudj/Enzo/oq5MePuCngcX
xM8uJopazW7trk/7WTA+HOzV2vVGqq9Lm2+m34GnNcxGxuu0FMa7F9LBD1P5ffr7
Z3IdVB4JBaSN375XTwAyVAbFMPvdtbhnD4IZrsRbZmxOZD5LZ3cxQ44WR/IVAnXS
S6T9U3YLGc/YiroNUinmTR6unIeFTc9Gpb6P1D45a24QoYyw4UyItsvBRnjO8m0j
J7E1swPBOHdkQ1VRsr3QSwn3ukpLmQ==
=qIiF
-----END PGP SIGNATURE-----

--8UjCQYjFpjbeJzQ5--
