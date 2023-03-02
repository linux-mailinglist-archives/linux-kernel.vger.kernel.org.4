Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC26A808B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCBK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:58:53 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37023119;
        Thu,  2 Mar 2023 02:58:47 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m7so21565440lfj.8;
        Thu, 02 Mar 2023 02:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iB3ZHqIvGaV6O8/ZD18GgVi7kiqvSLJxda/Q9WdZgB0=;
        b=CyOqaO9pPXK8FisUFKroncxCfR/ZVPGNUTywJ1sL6lfPOsuK3V4QrghDWCZ5h5rhBI
         rEgpTDSxf2xBISA+dxYfjMDsyKNhRbevKpnBftpgsL0Cnmttc3+CG6f6ifOG1AvYtDSK
         LMMBDKdCd2dZPz+xeCN/Xha6u23w9v63aReXV6F441/dWzXASYCZc5hhCR8MDqFrmu5L
         J6zYv84MAfy1/+LSzKC1IrUB6BZwbVxmO1Ix19rNbNjvvDPjrcSvepIIeruvuFs54IOj
         AoK8Rxh+ZX32hmUPdbBQCh2isXOEIdTFqVR3hhPVQTGxZ6BOtQ+qIcBGpjIYe4Nm7s4T
         DuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB3ZHqIvGaV6O8/ZD18GgVi7kiqvSLJxda/Q9WdZgB0=;
        b=7FzBSA2A1ghPru5PS5UITWTJnebFty12TmRV40TYQRJzS/B1Ni+KxobercPtktrAIP
         RtSYlGWRFbvDItMJ0KYXMSoCxgoxpR0K+0ZkhcAYXfDiYFaYsVg2YrB2GaFlUMaY5gbV
         9TS2FuTFr7OSs5Ydz5PT5rfHQWp/tmL0i3aJmwIl5+AblnVIKdMxohOj+jFnmgRY/mHd
         XmTf7Zf/ndInD8bOm5SPuwEFaKA7VyCgqUS9J8IHwpzNQUU74z3iIwdYSbONkXnXw765
         Lngs8XN/ziAEh4hiDkZJ4JCXtvYIXqL4GrZLWxvg7JRmoTEIBhIm3D2mvR7jiNBk6yjV
         mBEQ==
X-Gm-Message-State: AO0yUKUSgrUE2/fnbTxaEXi0EDSpII1UkOkfEEsIiYp+3S9VmePxpu5Q
        DZmt+fcZfjOXtP8xqOEM+vKaI+8Heo0=
X-Google-Smtp-Source: AK7set/uycqjMqjX+L0su7nY1jcJQbX22CUw1pPFG6+o9RDUExsGhlyIUQSbd8YA8/LuwatCAgITgQ==
X-Received: by 2002:a05:6512:481:b0:4db:ee9:7684 with SMTP id v1-20020a056512048100b004db0ee97684mr2753424lfq.56.1677754725941;
        Thu, 02 Mar 2023 02:58:45 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id r1-20020a19ac41000000b004dc4bb2f4bcsm2061159lfc.276.2023.03.02.02.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:58:45 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:58:40 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <4134fd67e2a702f79d467cc7ab60f94113512f2a.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bw7QQrHnGi5qqzUe"
Content-Disposition: inline
In-Reply-To: <cover.1677750859.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bw7QQrHnGi5qqzUe
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
index 135d93368d36..af8516d5df36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10059,6 +10059,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-env=
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

--Bw7QQrHnGi5qqzUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQAgWAACgkQeFA3/03a
ocUMAQf6AkM+r7lDSysaRrUkacVp/dNOx5DyWrv03xlogmzc3FDS8JtR5Kw3bocy
sxwlbABT7wQuxv5hNWwyPHOOxr0qETHnHH/y9rYAdeiJHRMg+99IH3dtbYpI2JEh
6B4ZpUQfLF0IzEJMLP3GGMhD9oR7WU9+O1V3zoZN6LiArIzj/3PBp7/HR4Rx2nBs
9PuLrf+koSfRuImQuB+sdh83nDsDOrJi8oCdg6igIgNfeK2nXP/UZHwCYvuZSusE
vQE7S2uU2XEaDZ+k6KbjSB+2UQyOdBRepc4M9CyyGrP0FoWzuEVfmjZ2z8EIak1o
+T+d03pxGfenlUe/0t0xpagN7uAkwA==
=cvt4
-----END PGP SIGNATURE-----

--Bw7QQrHnGi5qqzUe--
