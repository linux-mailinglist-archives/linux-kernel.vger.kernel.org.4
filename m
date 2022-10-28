Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E16109A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ1FQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1FQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:16:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB691B2BA5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:16:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s24so6939071ljs.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8TWnAkdw09Zj0R/c7tZPSOwcVhSuuKAhF825MfonPw=;
        b=UfXRw/6d6dzbCEFbmjwfu/TI3ptp5UWU8exlg3F34b0m2W3eK+UZggCC+wIMWiYEDw
         srEchjAfgPhhq/XoXAIyTg0yJfbIqKLWvov1TdHvS9WKrDMHNHi0+AAddaqQOoqsQCeT
         LXz7BubdiS86zDSrVnMh+VCO+ZafogS6kt+vmL5IfZY+Bo3Fg0NJHKu6CCGUf7vsLR8N
         LLh4FU7ptoLdtse4Zyh1duVF75v98F1z9T/C4IjnmRSBjZJOCXsCf4IYlzs4HixXlqWT
         zoVJ2grUArAq4TvihERax1+mEfLSeICkPD0TFtulYLvQ17NBT7K/Anik9/vDTM79emBG
         zezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8TWnAkdw09Zj0R/c7tZPSOwcVhSuuKAhF825MfonPw=;
        b=nvzhvFcUKXFLfHxqtgXIzuHNwDchEVNplP2NbkkEAdK9A4LhCL92zYDxMAGOzXI8gP
         /4DU/yTwkrMOt70y9GKCNvT5Z5zHAYziNuvDjw6WHjN9CeAZMoUMD4mDUxCasqiSnY+M
         zUuWTX7WQBBnkjtLgNufigLtxdHxCyZnTpen6SPxy+y8F75lhTkpGwuUT/qEwOCxu5ul
         8IX2cNycBiR2zSB+bUs6HzsRXbr504tO17kbJIjdc8dWRnFs24cQc1sQj8ag0jn6oBZR
         Wjs8+84WorpHQ3s8PPJ/TWFiv8d+i83XKHQ8GllTca2Z2pCmIfyOj5BrjUVpMfzIVNFR
         OEug==
X-Gm-Message-State: ACrzQf3vC/lOSO4YgQt8Gk2jevTmfuk+nlidGmoJITRRdNR11GxOFk6y
        OgsXV0QAhxasUR6vPQQ1LTA=
X-Google-Smtp-Source: AMsMyM4GRKUlaS7FLCbMf6Xv2BBGud0iVijVMQ5rr04hR6X+r7aEfsOOvtfox9XGr5qy6wyiqCDrbg==
X-Received: by 2002:a2e:bf15:0:b0:26c:12ca:52ae with SMTP id c21-20020a2ebf15000000b0026c12ca52aemr18618275ljr.103.1666934161518;
        Thu, 27 Oct 2022 22:16:01 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id by40-20020a05651c1a2800b002770d8625ffsm481886ljb.88.2022.10.27.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:16:00 -0700 (PDT)
Date:   Fri, 28 Oct 2022 08:15:45 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matt.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Change myself to a maintainer
Message-ID: <Y1tlgUVWLBRSIt5U@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipHwZaTlZQ8SmoKx"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipHwZaTlZQ8SmoKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After some off-list discussion with Marek Vasut and Geert Uytterhoeven
and finally a kx022a driver related discussion with Joe Perches
https://lore.kernel.org/lkml/92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel=
@perches.com/
it seems that my status as a reviewer has been wrong. I do look after
the ROHM/Kionix drivers I've authored and currently I am also paid to do
so as is reflected by the 'S: Supported'. According to Joe, the reviewer
entry in MAINTAINERS do not indicate such level of support and having a
reviewer supporting an IC is a contradiction.

Switch undersigned from a reviewer to a maintainer for IC drivers I am
taking care of.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..fad5e16e8074 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17811,7 +17811,7 @@ S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
=20
 ROHM BD99954 CHARGER IC
-R:	Matti Vaittinen <mazziesaccount@gmail.com>
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
@@ -17834,7 +17834,7 @@ F:	drivers/regulator/bd9571mwv-regulator.c
 F:	include/linux/mfd/bd9571mwv.h
=20
 ROHM POWER MANAGEMENT IC DEVICE DRIVERS
-R:	Matti Vaittinen <mazziesaccount@gmail.com>
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
 F:	drivers/clk/clk-bd718x7.c
 F:	drivers/gpio/gpio-bd71815.c

base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
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

--ipHwZaTlZQ8SmoKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNbZXwACgkQeFA3/03a
ocU0KggA0MGtqp9mCzrtc8KsrLtD1UBfVJU6roXy5mdPpM5X/GZYH8yyiIZHlwj5
7t9b4eWH2R00D7U5ZAlrAAZJ+jMZZih94Q2qaRXBR8BNhiVROZSfyvpmbUhxxhWi
3YmRSMTdz17tAQ3kW//3JM8nq7T55wYX8ClYwLion94T5iK7fsn1TS5PwnJ7fB+N
Bhpx2aX9m3IBqp0drbp03Sk9hpn2MOBURhHkfEBTWW7scJWmaveO3ReVID3T/iB2
DDPh9ufm2xXADL/xcmWCduF2uTmf3EZbINqV1b95KRv6eBOLwA8xvP7cTRxg6MJW
RPdEwjeKeUSjHW+GUGocVGbypBTbGg==
=eqkN
-----END PGP SIGNATURE-----

--ipHwZaTlZQ8SmoKx--
