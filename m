Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF869F8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjBVQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjBVQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:16:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C13D925;
        Wed, 22 Feb 2023 08:16:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x24so10840941lfr.1;
        Wed, 22 Feb 2023 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9YMLBYcPz/4Hlblq1d7hFRHt4s8YknOklPReJ3GiyY=;
        b=b1xBoyvL2h5smGjmn94Ham0JSyYLz8r2UnWaGNSQONcCY9PuAzhG/nJE8V1/+kg5em
         97DVyp+687d7Ig4+iHDslu9bnDBr9q1UoBDHGnf6N63BRuEI1t9o831id2QmSwHYwDfr
         7bAkslkNRa1vtIaKIHqm84MR0sl7uxH48LkgqMLNvYGvepcpk3N8zcD1V84bW0qSxO7d
         tGn0cGXkskLBPYX/W9a0oIhCRXPcobfSQRnqd+Sqk/ksI8D4BfhpRvwUtZO6/4Mk4tQD
         KZw39GDY8cs/poPxF11lPUCM+TLMouBbDkGGi4LJwaPTVg//KOaXBefhEjjEwMxerKeH
         W2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9YMLBYcPz/4Hlblq1d7hFRHt4s8YknOklPReJ3GiyY=;
        b=hz18BNHtAc2CZ4PSQPa8AYdqMS7/qWBIrKsuVHa9WGWnfEhkP/0aIy+e0OffArgNh6
         xDX8tb9j+e5AgnTu0uaGI4iU/b8SVBrnBw+PrUX8s18Y/EbCPcEmJ8LtksoAOVgf4N3K
         BVzerWPcvNB/c7BfhlG8tdFdU2SgxUxHmOksj7/LO4Vw93K5EHh+uoo5NxnZwLBegj3R
         JM0AuSvN0CR2mV1PG4Hk6ydOrMymH3CIUJOWjK5h9TGnkmvfNED6cun4bbZvT5LnfzTi
         zhVLqN0DzZ01DH+3qLBD9cI2qCW9xbCm4UfF2gq3gzMMHEHZrTQd9xhvUga+C01yJloE
         xliQ==
X-Gm-Message-State: AO0yUKUtnWtcak3qrOD9RyOdfZvIy2oX4v3IKvEezh3vwQzbrTU4IGyK
        ynN1R1zqzv0SxUsxP4I+1LU=
X-Google-Smtp-Source: AK7set/VuHemzuZuwIMi2PoQLRysxBPaa9lJAZXaeL3TFucxHl9nNqqCwNbM+Ex4gdZbddqGtL3HDA==
X-Received: by 2002:ac2:5613:0:b0:4d6:ef7f:fc53 with SMTP id v19-20020ac25613000000b004d6ef7ffc53mr3252689lfd.34.1677082583575;
        Wed, 22 Feb 2023 08:16:23 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b004d57ca1c96csm359052lfc.172.2023.02.22.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:16:22 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:16:18 +0200
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
Subject: [RFC PATCH 6/6] MAINTAINERS: Add ROHM BU27034
Message-ID: <8dbdf68749389605cc4dff396ddd66d27fdb2a0d.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qOVCSwgf+lSCy3A0"
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


--qOVCSwgf+lSCy3A0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27034 ALS driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43f5a024daa2..8d31ef852372 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18090,6 +18090,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
+ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
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

--qOVCSwgf+lSCy3A0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP2P9IACgkQeFA3/03a
ocWKGwf+NYZPx7+q1bS8S0Nsm1l1Rvjcs4LfPWyq+Of5pwQyWLUrZC+RuFuEULX4
/V1BiX6BoKCN9rpbX2NTPWquaN4qrNUa+o4qL9vNbfGEqv8bis2RxVmOfzyQeu+a
rmsFG1vtyQY0AkRhAIbHgwWmgIkuPCFPkXfcR+qh5CIPmgKkK6n6ciQQZwJP12vV
THIYElmdYEgWRxsnDB28sXtpxgHKE0bx6aQI4TvR9JSESfDbfKa0MexxxxDtkx5W
qfRb+LNAnAFXXsNYPddPy4c3ciDSSDhGtav0vHSCeyvqi3Y5LAaauuVVkm+HES4v
fwrWO6HovI5VDqnnLZ51o3HDzFDp2w==
=VWJH
-----END PGP SIGNATURE-----

--qOVCSwgf+lSCy3A0--
