Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722876F6431
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEDE7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDE7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:59:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA31BCC;
        Wed,  3 May 2023 21:59:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso26487e87.2;
        Wed, 03 May 2023 21:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683176351; x=1685768351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ErlKNWxBynVKO1TxiPrcdtE3Y8hGtnJhFEqGtEQkc8=;
        b=soIwOFlSuDbixg2p6QtdSv5cD/tBfMNtUK26BEhWsrzI1LyhraH1IP/7pkVKQNhxHs
         HUIJgYKti/U32k8lDHufVq5ADib5F02en5QQvxvNpYP8aJzrvoggy1I+YUu1tViv2LnK
         NL0KfxYalHS7fqsfbvsS8UK65BCMmtRkb8ufoAHy2r36w7gq82xc+mwsq8X6cS5Vi4MA
         VufyakMl7lhWek/zQLsSdAAE4a0H4/bPZ0rWmiVDp1KwCSWqLXvyb6EHoaRbZftbnYU6
         PlYmFCq57kaeltIRilTngjqhGubBKB9ehrBtcUBxwuGep2/pRTyDH0kZEIlpJLclS8kv
         BIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683176351; x=1685768351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ErlKNWxBynVKO1TxiPrcdtE3Y8hGtnJhFEqGtEQkc8=;
        b=OYRuxPuY5zaVy/7G/MO90gmWw0PNt5nHxOt0kzFlr2KuwqSzqZfzD9b8Zru79GZcVY
         bB+30zIYUfXQfAwE8GrY0+2dHnEiJ1TeDuw+Hyz9v9nkHcCrUAefnffgxT2+WTYO/TdE
         JxC43wP624nEa6yYxxag2P3SyRFb1c7N/PHQ9I0nrRLw+byyB69Seutm2K2Ejo3hhbAa
         npeIXa2ADY7EEYacqTdiJGGER/U3ZSLNqVTdCiz7WQ/uUGxueFTS0gJTGbGcGEg0Mc7L
         Wwrnb0r+ih3aZEBrqC4TzA21CE6l6pNFtpDBgdobpMY64lAB1f6QzIvhJh8tjI9R7qru
         T1Qg==
X-Gm-Message-State: AC+VfDysYPJpRbbldxhpPg6GY2iHHmh0MG0CPOS8oTK8MlxhoeJftLh+
        MfuBXV1K36HRQKzbQTXzZppCArkADP0=
X-Google-Smtp-Source: ACHHUZ52RfsUVAy4cdynTNVaZuAil4yNWLQoT4m/gUgpZPeOgkBoOHExFoQ6LIau3jXi/f7BzefBNg==
X-Received: by 2002:a2e:97c5:0:b0:2aa:43cd:57c9 with SMTP id m5-20020a2e97c5000000b002aa43cd57c9mr497393ljj.36.1683176350423;
        Wed, 03 May 2023 21:59:10 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e9901000000b002ab4ceea005sm3242194lji.136.2023.05.03.21.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 21:59:09 -0700 (PDT)
Date:   Thu, 4 May 2023 07:59:00 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bu27034: Reinit regmap cache after reset
Message-ID: <ZFM7lE4ZuDrUTspH@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WjVFt0L+e0GrUcbG"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WjVFt0L+e0GrUcbG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When BU27034 restores the default register values when SWRESET is
issued. This can cause register cache to be outdated.

Rebuild register cache after SWRESET.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

---
I noticed this was missing while writing driver for another light
sensor. The change is not tested in hardware as I don't have the BU27034
at my hands right now. Careful review would be highly appreciated.

This change is built on top of the
https://lore.kernel.org/all/ZFIw%2FKdApZe1euN8@fedora/
and could probably be squashed with it. Unfortunately I spotted the
missing cache re-init only after sending the fix linked above.

Please, let me know if you want me to squash and respin.
---
 drivers/iio/light/rohm-bu27034.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 740ebd86b6e5..f85194fda6b0 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1281,6 +1281,13 @@ static int bu27034_chip_init(struct bu27034_data *da=
ta)
 		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
=20
 	msleep(1);
+
+	ret =3D regmap_reinit_cache(data->regmap, &bu27034_regmap);
+	if (ret) {
+		dev_err(data->dev, "Failed to reinit reg cache\n");
+		return ret;
+	}
+
 	/*
 	 * Read integration time here to ensure it is in regmap cache. We do
 	 * this to speed-up the int-time acquisition in the start of the buffer
--=20
2.40.0


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

--WjVFt0L+e0GrUcbG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRTO40ACgkQeFA3/03a
ocUA9gf/UMa46MuFkteiHUqt7W2SqZGZFWFl4nao++CmtZ4ZyKgJdOq241lKI2cD
+O7+INvepfEnUgOpsGmXS4bnb2TZWb7GKQhqcV2fOJfwzBDB+EF4v3Vztz4s9uZz
cTr+9vBeIh+IJSY9HXIAtN6yZH8Uw4XWMylToy7f4UAlkJqAqCIYlznH9baUy5Pp
3zOkH0/uoCzuKlIut/dWjOEWkoa6vRdeKBv1tveFNlQMnbxlVbJmk6LX6fNR/6K/
EFI0cwiV+La0nikGV0fvJYlHPbbIrggEM84mHwNTQhXK5rWtDwiJKdHaVEQoDMxq
6R7emeYzjNSrS+iEGzzhy60cIyB0GQ==
=QaGQ
-----END PGP SIGNATURE-----

--WjVFt0L+e0GrUcbG--
