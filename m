Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30DB60B3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiJXROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiJXRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:13:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBB19C23;
        Mon, 24 Oct 2022 08:49:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s24so2819036ljs.11;
        Mon, 24 Oct 2022 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHc3Mek8Tu+f1IsJvs/N59LV3VIyfdy/eRQyFei/ucU=;
        b=DZ08L6jiqLwm3ECqQFI5lUNSI6chJWwaEnq1VWXYBuJ5HFIdUjkK8bnjl1Avfx/u8o
         t/m35wfqf315I0SBhrfMZ55ChOaOtUpNgoH4UfocOm8urw/MCvzhF3yl32dGZwVpXIzr
         PjH5zC3o/H80pgMVqDwIQex3EpfUYiwVCsvhl00idNOgYN54AirFjL3zbN1iWv91fHjO
         hI+JyOYjiaEU/KjnZnsj8Qrgmc83H8EUs+g2gLdQ43SfNeIQ1RLFzUhJ8lillHGiKmtE
         v9xUnnU+C9IUwvBvZDLYZ2+94pDvydaX9XxymJ0zFf4jl8SQGQ5d/tI00hAXFpZOjVZN
         aPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHc3Mek8Tu+f1IsJvs/N59LV3VIyfdy/eRQyFei/ucU=;
        b=wopFb8J2sX8AdhPRvhcCJrNyS1Ad8XAliIFTp7A3NTifMtjnnEY4lP74TtigliUFOq
         IFvpJx6bB1Tpme0nq52TVZd8HN2qiWNX8cE9KnHCSC1c2ZP+DN+aSAZwx4LYyb6sb6sQ
         dNNeN8O3/iDbNZB2gyC3XrZvYxY61Cx6d1RVUErlEyXQKG8kTsvl0SMsjGvu2Yygis/C
         /FIjAiAhh8HWkuOO2rpX3Er27Kgx5EpHawbpGr071hpAsbOys1RU6ILOOJH6Xgd2ZgGe
         URUDqQvMpqml8IJwsF2wRqD76m7GnRzogpQBp/xtvPYQF6t3kX7q+0LtGFUB+WSrrgaR
         40Yg==
X-Gm-Message-State: ACrzQf1yPTxqs7/JRClM9Jlf4u2yZMusohwaSleKy7i5GfI/j8rzIWls
        3HUDAFqHdh3ZCDPFhY540pMysqYzbEY=
X-Google-Smtp-Source: AMsMyM6w+uq+AVqn8/uRiNt5yKt+pdjIYgBADK1oTI2uO8TZu92bvwyi50CPaB/jE1Z33rKNwmR9IQ==
X-Received: by 2002:a2e:83c6:0:b0:26d:e24c:ec01 with SMTP id s6-20020a2e83c6000000b0026de24cec01mr11402033ljh.340.1666615266446;
        Mon, 24 Oct 2022 05:41:06 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id k2-20020a05651c10a200b0027710117ebdsm218801ljn.121.2022.10.24.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:41:05 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:40:58 +0300
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
Subject: [PATCH v5 3/3] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <7895435f7fd31a3b576fc6a59b01eb3202c85d36.1666614295.git.mazziesaccount@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QIOM4X2h3JXGo+zZ"
Content-Disposition: inline
In-Reply-To: <cover.1666614295.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QIOM4X2h3JXGo+zZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v4 =3D> v5: After discussion with Joe Perches
- change myself to a maintainer
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..63cae24a74a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
 F:	include/linux/mfd/khadas-mcu.h
 F:	drivers/thermal/khadas_mcu_fan.c
=20
+KIONIX/ROHM KX022A ACCELEROMETER
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
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

--QIOM4X2h3JXGo+zZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNWh9oACgkQeFA3/03a
ocX12AgAvPI6uS08LVi3a6cRqziBzIBZQpsTAJhky+2H6aczBkdaEhyo3GVLZ3nV
3QMfAl6t/ONfXexldYKfx6QC4s6WU1EYFJRf5xUGWcOfX3G9qlLodj8VDLfbUS93
yzct0B1GXWFCPGS8XHQA1Dwgh1Pur0UDiPhrLuHMeIXMnalFRkEXYBt3Dyz2MnF4
5/8hVoArN1T8fOHilG05Z6OmStRbJskz/3KjQ6Wmpzn2nm8KSvdjlN4OPsySryuW
5jKtNsYStLcmeMIyM6gwZxA5Dkkr5bbLiUPj/WB1k2Mq0fMFlqPhjB9yvJoPy3mS
or0JF+vac4WTA2dlh0feJnY38MSSrg==
=eJGN
-----END PGP SIGNATURE-----

--QIOM4X2h3JXGo+zZ--
