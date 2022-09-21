Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE75BFD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIULqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIULq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:46:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D88274E;
        Wed, 21 Sep 2022 04:46:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j16so8769395lfg.1;
        Wed, 21 Sep 2022 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cGOSHWHf030IkSak76+na5Q86ksMR3Kog0w1HGe6B7w=;
        b=YvwQVCEcOX+91V2ztGsfXdJEhHHJWkRHmJM6klWRQDY+2Dn3XwragRB47ZO1bQbgxr
         vi8J9f7TWxX3e7SEHx0osYHkk52Cyf1x8ASWd4RcAeIbktWq0d6fqlu/9Hrv1NmWHtjk
         8tEYkFiAlYn+cbltH5A5dS2DrqzSB04pm7QJhJyBmZlj1OamQMFiJBsD0LHygCgO4Q+A
         vwMxQ4qb/76oXmepA/ZQU4QjNjNqk4tqGTW6q0prF5aH9Kkc3UZx+K1QaEkljXnZ7YTR
         xyXHgADYfq1fmiGpls5UeSjyFtJsFdNq4wBlQ1upnUmfDQQfv+BEEi8v9nX7qjTTv3DL
         rXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cGOSHWHf030IkSak76+na5Q86ksMR3Kog0w1HGe6B7w=;
        b=yij/uo7qtgZWLZcGUXDO00wQ8X/MH5ydr77o37ToKoK2wp46xEq1oZnD/6A7HGCgHQ
         qT6hKvi5XFiw9UE9k5qNDhjoGzbW8WYOTJLumJMk3RG5UWSKcYU5AvlKmaWXMMdR3MRW
         uSx5gwzGweN6nMCmNeakWaKg7KJ6hE2nPSWvSYtYhKEt+rHKCVITOB/9za6ypNDv/NuT
         t+3f7Kh/V5oWXx8mPDpJakh6y4NBMmXwoK/s3H1z+3DC2wHRJByL1S/nMM25DuoHuce5
         pwTLpGWQLnJtmpgk4MmTxgTuss5PsIOW8avgUgpPLJ/P2A1Ia+JAews2THF9UW0riGqN
         6DmA==
X-Gm-Message-State: ACrzQf0XtKHgRN2r1CwgxXvAMdxxDHy9LzDHTkNRNA338h+2TZpITmvB
        jPtNhRjcCVLOTOgc2KN8oSE=
X-Google-Smtp-Source: AMsMyM7t/VO2lT3aSQgvK3Lr8FxWhe6n1kmdTneSbtTNXnbiiAq2oAiNTphzCbeeAnDpoCp63DKeww==
X-Received: by 2002:a05:6512:3295:b0:497:a156:795a with SMTP id p21-20020a056512329500b00497a156795amr9532093lfe.345.1663760783934;
        Wed, 21 Sep 2022 04:46:23 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y18-20020a197512000000b004946aef1814sm396307lfe.137.2022.09.21.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:23 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:46:18 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <68ac8d4bb3f8bd1239bd22db43b5bf64f149fd79.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wJkDbAIU0Z2c5qr"
Content-Disposition: inline
In-Reply-To: <cover.1663760018.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wJkDbAIU0Z2c5qr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entry for ROHM/Kionix KX022A accelerometer senor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..74f1c75775b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11355,6 +11355,11 @@ F:	drivers/mfd/khadas-mcu.c
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
2.37.1


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

--7wJkDbAIU0Z2c5qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+YoACgkQeFA3/03a
ocWAowgAk6DuKJCcAgFOYZfnpkzj7hW+EVAABH6aWX3iRepXOIrVFezMfQKNCvvm
7KLu2JVZvrA8QwrVPBJFqWnORyDHL983RN3vuy7YfpOR1bXIdJk2567o8dIlfUM5
XfutdC9JStRt+Mrz3F+dr3yWf3V7rrilCoFiy41yWwwGtDpkHtrdE5caDziZuqGw
SoisqFraFm/+rbU5QwH3POUtT4cfZ46A5KTQKTvHdv3Ezvni8HVTNswcjjjhnzcF
dCYJeMLSpuFuKCummrcJ8uWaqtfpMv60GHmoNESBJ/CoOqF0PHfxSBu6yPsmeSDB
EkI8akyZtxYHJgWnqTjmElIzItKAhg==
=+gvv
-----END PGP SIGNATURE-----

--7wJkDbAIU0Z2c5qr--
