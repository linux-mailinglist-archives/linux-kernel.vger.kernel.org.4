Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5946AB9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCFJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCFJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:27:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7FA23132;
        Mon,  6 Mar 2023 01:27:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so11826655lfq.5;
        Mon, 06 Mar 2023 01:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWTX5gW9Jf2qQs6IkrWmCRXrJtFSHMP+YgoqMOq3RvM=;
        b=VGVxVntcN6ghMz7cB+DzUCPLHI7Z9kSXbMtFAGs1JfkB8yl/XuDXdTWJMd+GF0e7l3
         UFhih3IMx2vzX+h3zGSYVMQAEw0ohhqp89TlxS4eYBbMgInsxABgys9KDTwn/MtaqLiZ
         UpVuDsdzZeYGz/u7uBkIdonQnsTIYZwP+aU49yn6y5/3oF37kIWaMrYaIM/doGrIlyNf
         CilAuYucyfYQkrDzboGYDZHEYNPBfX5wEwPx6AOY3JtYyOBO1OFR0SEhXGqS+jMPE15q
         hpWju011lxtu6w25JwIBHzlHsnfzUz9tf5sleC8NuBEJOJQGKxdQtb8wIGRS6T74pvAE
         U00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWTX5gW9Jf2qQs6IkrWmCRXrJtFSHMP+YgoqMOq3RvM=;
        b=qKiexCMwjf8f5I+i/yFrHgA5rusE/VJRtCtTLuh1yciG/1HFuyLTLxpfgdmjhx9s+I
         P7N5zQ0SEYkcJRfvayfL600R8lWX8TzBUdYAv7d/VoK3WzPHpuAchUuYQCNflHKtFXQe
         M/bxlQWdb3DaJecFKHAFbL27R8ZEPXt1NEyqxrZVC5eoNEBKHuOdWlVHB6RvUlsrlpY1
         grQbO7ylYaAE5sWJa44wmlZ3UgM5+z9b4Jj6v/kXSj3SMzRtcs7v9FI9oFJ2GrMsqEHz
         BUVQLCFuRm5M1kkjuXY4eUNZjbeHdzPRtKX3IPi9RSRv+Y+2ur8FQZIRk2Zw4SkNHI57
         rzxg==
X-Gm-Message-State: AO0yUKVGAJTuDLRN6VJ4HcSrOQftQ5h0YNLJRP1x0Ypobdu9fEY/8a9x
        vO0HlUa2k/DnkO4d4K7jjZS736rEf7U=
X-Google-Smtp-Source: AK7set/K8scIKQh+E8cg4YifStT/pOl1x5zxm//onrXHSBjDckEwbbPrVmY5nqWPSsA8zp29pjoZ5A==
X-Received: by 2002:a05:6512:684:b0:4dd:9f03:1f7e with SMTP id t4-20020a056512068400b004dd9f031f7emr3224550lfe.22.1678094865233;
        Mon, 06 Mar 2023 01:27:45 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id b23-20020ac25637000000b004d5ae3f5e9bsm1541082lff.130.2023.03.06.01.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:27:44 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:27:40 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] MAINTAINERS: Add ROHM BU27034
Message-ID: <7a9ae0cdaae20ae507a2d1a73abe2ec6b01dc899.1678093787.git.mazziesaccount@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KGeBRzvPq2SkTTgZ"
Content-Disposition: inline
In-Reply-To: <cover.1678093787.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KGeBRzvPq2SkTTgZ
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
index af8516d5df36..f75b38e6052d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18102,6 +18102,12 @@ S:	Maintained
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

--KGeBRzvPq2SkTTgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQFsgwACgkQeFA3/03a
ocWySgf7Bp5JFICU0trXwsnFjGVpqlNp1UzTYCroV/FEEBV6hz6HIRIG1lixysXH
u15NbZFaGbGtINzKPC3wQ95hvTOpXRiYgAuY7KPD+kJmPcWuAQnC3i8X8X8ZobtY
GtgtEwJ270DOQBnEjkHQTCLb2j6YfzRuoiU6ujvz6/Nh+Fb4fh/lC/l72aCD4C+T
qX8bIugoieQUlHuMtWFe3BKoHpkH1hLM8WIvEVkKz2pCuN6xTti706QumJ6Sb43K
A7yvjN/DlTKz3+TVhA3lzgixWw3AmxIoIPFLWLg7MIp96u/lryGVw2aS6FoiQaUl
Cbyszf/VbT7l++T+TMsvEpAVmX0Gjw==
=rGx7
-----END PGP SIGNATURE-----

--KGeBRzvPq2SkTTgZ--
