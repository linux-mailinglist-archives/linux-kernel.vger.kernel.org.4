Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E76BEBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCQOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCQOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:45:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5953019F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:45:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b10so5584464lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGTIDqMndMNqbxALauKCkD2N7wb/KyvKcaFqWGLKpW8=;
        b=RYpgpmM6QAuOiJ/vpIPP6iIIZSZ7EBhol/R5PpAVAiq3qVDNzvccBReap+7h7xjaI7
         KVFnEdrR1lICbHIOKXf6P0lD32XGoqwVtPaBrUpzrGRapz5JOxE3Jtbce7S2zqWRZjJ8
         DDE6k8eS5plAw5JiI0E9FBjD6ioxZatquD3B5IAU5UDQcosBu2vDdbgSaOCn1MGJ8M45
         J1euPdaq0GMUs8u+ooFI5RKTmMZrxFyF+TyOrG/BjGe2jn8J7KC6xCjumhhSNyeIcFVC
         R5Q4I78gmH475K6O4XU01Jm6Y/MzDB+QV4MJXOyi+qoCc4w5c5y9yOHgnRCnPHmE5kpQ
         1KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGTIDqMndMNqbxALauKCkD2N7wb/KyvKcaFqWGLKpW8=;
        b=u6l7nLx4WfOAZ3hw+ofNwBZJYKhEakBJX6cidCcguzOQoHzDIQX+MfKRPm2Mfti2GB
         XHnOchDfQtT6FUZRPfXnRws+C9K83DN218LFSOzMuQ6Cej6tFNKPVehBki9Sqqh4zbIy
         zw6qoy+xi/TQLaehPgP4+riR/lFEOCJsJlH6MlahilB4YKXjjYnmf+6OrH+oTIb+H8lq
         H6i1YbqqG9GhoUTKI2n4scYNiMMdE9txfLSJ5B4WTyS820wg3XgC2eP/s2nMgspQehDX
         pEC6Cjn37W/jGJPiAnFkHTspyleZWWmuO4uZfNKU+OaccHJdjPyj0tVVq2NcEYM//C1A
         upxQ==
X-Gm-Message-State: AO0yUKVJwPPCEd6/M4Y4Dpjq9msRqCQ5XTDHIl1DC2VJ3KJUgROm7Egs
        XrCwwrFMxs+O/yww1Obc9gIW9EIlHm4=
X-Google-Smtp-Source: AK7set/Hk/RT0BFYxxX2Vm4qAT5hM7upNZJZCGktwKmMZ+MzBoIF5F6aVcIk4r4c34KeB9kXXwXgFQ==
X-Received: by 2002:ac2:52ad:0:b0:4e8:3f1f:3646 with SMTP id r13-20020ac252ad000000b004e83f1f3646mr4315195lfm.55.1679064307416;
        Fri, 17 Mar 2023 07:45:07 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x25-20020ac25dd9000000b004d576298c89sm398427lfq.141.2023.03.17.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:45:06 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:45:00 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] MAINTAINERS: Add ROHM BU27034
Message-ID: <f86e1d3273667e247a8d00f7264e32b5eadec572.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3J/3hSEGsxi/zFRC"
Content-Disposition: inline
In-Reply-To: <cover.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3J/3hSEGsxi/zFRC
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

--3J/3hSEGsxi/zFRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUfOsACgkQeFA3/03a
ocWw7ggAjZ+3YSzBhFaavCYPd4Tf/Yjoa7rmKhRHM/Y1EOeAfTOLLzDmF+fyupaC
NXx5zwQrZ4NKO8NmFzq6MsY2FyenCqW8E7bl2ZXGbYBGsAZuIWPI4DfbQyPgtuW4
EnvtWikUtzfUIMWIX/8PD5HnqwjfFFQCrUenmL25IFNZVVuwRHUp2ma3HJTIHQSt
4IozTT3rJd/3DB+OFRTPHtdTm6bVU1ibUEQlxcEzAHBQyxK43/9beJQsKXcjdFoq
uOXntb2xm5UzLJ9x0WJys+gXd1XkL4rpyfH4U0FS6NIYWEJDRA1TArELo9cfQnGS
FUaOMRha7+AVFdIxoleOKj49rTCipQ==
=yFp3
-----END PGP SIGNATURE-----

--3J/3hSEGsxi/zFRC--
