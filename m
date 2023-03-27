Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2916CA292
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjC0Lfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC0LfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:35:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931B949DF;
        Mon, 27 Mar 2023 04:35:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c9so562083lfb.1;
        Mon, 27 Mar 2023 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hdyVG+oGE2YzS39xkKQQ5eMsyD+BlG3ZOXr0rLttTA=;
        b=b/KWW5+rFAfwLomDNnWwUgWUu5U67q5tn8p+sKVnpqaUCgAUsO4Y54jDYDHQG7ug8s
         ecl9s1dU8S2suavBZqJqRVUOj7vV7+CLIFSTay8qDl4JEvh3ZkwAOndco4TlvHfUApG1
         durcQRIdl/j0HEROCTvX5tW/nWruh2R1WyJzMyX+bJLpdNSZFJSr4soNNd0dJA+noGjV
         hDtaecfs6EcJuw6ekbFaQZxqLo57xXVTM4PWUTwPN6Lug/w0o90NsHPwPUKiOuZA28lQ
         ewWULojhlTnUAICnvBsUrYXtZWxxrXUb8UoqJCoZIamSdx4CsH1OKj+ykVfqqbHIY6gP
         Hr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hdyVG+oGE2YzS39xkKQQ5eMsyD+BlG3ZOXr0rLttTA=;
        b=Vm3GOx52M+uJkppn/7aQPY5nPBk9ZXqKJmduB7kKaBx4PXWcNiHfq7KdAuKdCTdI1X
         xP4YYUIZJs461eUEsyARyhGlCfld5Vb05/UCpoKO9SG256ewgbOVNN7Uw5rPZllrm6vS
         O4sA7Zf82BrTJqNvH3TgrLcwDbw0ig3UvUAs84ZGsBA+V7ygfkmGHJvQHdnFdsisMGIh
         hBG++hyDE/wRKynQAILtgRj2PmOh2u1L9xylq4Kam/mcxV9VzSg2KAttNZoqoLEHAGpt
         uDDeeiLY21sNvMSGkrYMXwpBey/bhnfeE0HOyrYTpkDVqk82k2RGz8DD2FkBqn91Yvq0
         pSMA==
X-Gm-Message-State: AAQBX9cb7l0ETlxcdXxZ25uOWmw2/DXUG84Osg4uaXOBHMPNI4G2XVbm
        ETnpYdd1nkZIXRtIBxa/HRE=
X-Google-Smtp-Source: AKy350alruadLz70VgFv9OOdT7OVS87shC0BgnEPgmCGXKFkL+HAoiPrzjNo/GF0c4tV/wW7XsjzPQ==
X-Received: by 2002:a19:ee18:0:b0:4a4:68b8:f4f1 with SMTP id g24-20020a19ee18000000b004a468b8f4f1mr3531613lfb.55.1679916910965;
        Mon, 27 Mar 2023 04:35:10 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h18-20020ac25972000000b004cc8207741fsm4651459lfp.93.2023.03.27.04.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:35:10 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:35:06 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v6 7/7] MAINTAINERS: Add ROHM BU27034
Message-ID: <6ac766ebde8946cf86d63167a1cf940ab23c7383.1679915278.git.mazziesaccount@gmail.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nai/9JrqzLObFj3I"
Content-Disposition: inline
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nai/9JrqzLObFj3I
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

--nai/9JrqzLObFj3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhf2oACgkQeFA3/03a
ocU7wgf/XY4tGaVfs1PrIqLnChO9bo6i3gakTFC4JBSoVhite9Qf3cSs70fSBhdH
X0YcadaZft8F/FnGqwfhfJLdk1fS/SI7+noNGHkvEcaDJ6ZzOpyTHsPt0n3Urkfz
F9Cd7/Y3hSwdKenv0fdnqd9AWLG2WGaTtjzxJ+qufwSr+leJrHA1EZhpd+2xVNju
QzEHu3Y/SefIz4M4/U6Dq4zEpj6tajx2KXqR0jDC+kGl4uSZi/aEHLvB1krdOc4x
CMiUcWxf8rV7IXJXshQRAo1+EsrcyY2W1kMETMThTfykdV20Mk06ZRt7MBeRh9VJ
LGpFCGjrCZAxHoocXLGinR3OsLTpxw==
=T6S/
-----END PGP SIGNATURE-----

--nai/9JrqzLObFj3I--
