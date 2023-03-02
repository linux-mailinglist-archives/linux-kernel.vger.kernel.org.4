Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860B26A8090
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCBK7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCBK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:59:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0453D907;
        Thu,  2 Mar 2023 02:59:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k14so21544501lfj.7;
        Thu, 02 Mar 2023 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZU83ck9nL38ZM2QNQUisMyQtOcrBNc5YvsQ6uxiWRs=;
        b=ccAW2hJxOVK2lC8nG+r9tlvgUeNIS15ArQbmGAT6iFcue1ol2MacH0rlruCUintfOq
         y3zxwNI7aCoamDvYz3B8XDii8+NzJtiAyVinEAavefRls9mcvOCKAKNFbfai9XdLiKb8
         Knqd5alK+LTBjthtGA3yg0f+KlWywF8UWEuJDEyy/kA0HKS1tbzIT/wnlVkxYkoTZb7q
         jTsiNYIkI03Xnmo2jJ6mEVRaeRCZmRW0gOBpjSfJHV7uJM8EqgVGDhiPWa1wCVTbNCu2
         EZ5HdBz0eN+gD5CicQi0FPiNQnjG4Jtv2A1IhPx2Uadr7qwm4EThKFFbO4eoK/4qTAso
         qRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZU83ck9nL38ZM2QNQUisMyQtOcrBNc5YvsQ6uxiWRs=;
        b=Ofidp9YDfc8J2xEOqsoSKBntoQ+6Q+ru1OOev6XEiI3xffb6emBY5Qac523PknmBXk
         Tl9utbmGGVMjnixVhEfHI1zkJzoIJEKmctWQ042KfUearp46NbjVPz/HWB6PSVYn6lkC
         EcbIVDNn5mcndJejx6JQ+Z/PrRe58x67yehdgMzYhx1u/seeYiQOneAM+sdUVNujoZs4
         fsWGRVckedZNCLOJ3AS8R+WyGKKL7Z0ljiRVN4qOUUg3QMLi9308yXdDW6pFHprOQLla
         XKa/2iryvOr+sN1yOKiGCFLtH9rIjOEs+c7fNCquuJfvCdQ2UJ/h4+/w1aa2QG3ux2g8
         vW8Q==
X-Gm-Message-State: AO0yUKXzTYzgeHC62ZwqZr+jzdnhFxuE5mX6VSl+grhistEmozBpoTnU
        PVl6x6eKaFh49XaZ22AtGFo=
X-Google-Smtp-Source: AK7set8g/5D1OZPbkh5jNtNyCafs5oyBV22cpQ3+MlJliGQHmedsPl8z1G0IUWixnkP81FLkj5Jwaw==
X-Received: by 2002:a19:7408:0:b0:4d9:8773:7d76 with SMTP id v8-20020a197408000000b004d987737d76mr2625146lfe.11.1677754766407;
        Thu, 02 Mar 2023 02:59:26 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h24-20020a197018000000b004b4b5da5f80sm2060404lfc.219.2023.03.02.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:59:25 -0800 (PST)
Date:   Thu, 2 Mar 2023 12:59:21 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add ROHM BU27034
Message-ID: <3ca01c6cfab2c1ed51fddf43d31feae425d79de1.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ziNQpaz/Y+XVXgT"
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


--6ziNQpaz/Y+XVXgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27034 ALS driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes since RFCv1:
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

--6ziNQpaz/Y+XVXgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQAgYkACgkQeFA3/03a
ocX+kgf+MgA8qc3YT2GFCNSi25ET53VrWw2MvQekLSh/4+0p0JmRqLZgjM5DXZtL
8iX4hNBiNtVdnRh7vmCjpL91E4eErkqIki0XTu3DxM5jbNVy9E2VzWFjrhw931zl
Vd6hMkenQisepuV4Xuqpkxb/fSsPXhSCwXCIyVMGkaMooK3WY7t8UUultFqgLqfw
Ox1vsznrMxcejWBx73nCnH8znbjVxaTRqZeqylaQJBWdG2ipNIleH94NmkC4e4EA
pxIYAlC7Egpf/pka/ssfBYS76AY/cD6ValOHJf7Jjb+SxgiAJlW8XJ+UQsxTJq6B
CUA7I+YZVmhIZ5Ecfod7RT5S+MfLug==
=Kj7n
-----END PGP SIGNATURE-----

--6ziNQpaz/Y+XVXgT--
