Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80496F6663
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEDH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:57:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4B3C28;
        Thu,  4 May 2023 00:57:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so1129701fa.1;
        Thu, 04 May 2023 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683187045; x=1685779045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9ZN5Kt7PzcLmeQSM4/6ILQKH7duKu8J3KsFC8gjMWY=;
        b=JPYlVAlb7y9k2cIrdQjpuO+2COC4kNkXF6Hx1ptRVANh/ZvtZFxr23P/He+hDFSkiH
         SOGXfClMVcDWrriuiucKMoEzuLEnggFDg6bpr9kjXCQe/NCIQzT+H0I926Y/hmju98/I
         49jqxUOZjL5qMKXPFLZcbNQ5Czo8JOCXTOnNKG7IMKcpQezGeFzhzCeu3FsetjNDGJl6
         MWM6LU+8+Q52j+FjAqpwkCdipVCPayn0shXvUeD8qLS2RV0JIvgAYkF2gFd2cIHrKF0e
         /IyQ/QQnHn0d3cVtJwyGxT/KU+KVW3Gd3YzjBSMeeod+zLyIs2q81AlqZG86OqrigTGW
         mMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187045; x=1685779045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9ZN5Kt7PzcLmeQSM4/6ILQKH7duKu8J3KsFC8gjMWY=;
        b=gZWqsAPnHRN5OntHaxoEcirI2NLRiRgSeeYnmIMmEgeoulzURXk84HS6Igc97tA6n+
         8wf69H+UhY9fhB0yWtu3t9h4cVek0iIF7BrB5yz5Ye4v6bMe/94EsOIEpREKKMruWwLP
         +U69/i1hHeXl50I/FpzJNdwv12QUIy14xWTAfaXWSeXvf/uQb0o7U7w2J0qniiXJqFpW
         xnucdLetHpmhfYSoao1jADnnmGs6xFe5nbXqVnqxfsKf0UwFpWf0e0LNx7MYiJIgKD10
         e/VmvOnMoiY93Wpx42rkAQWT6ni68CKOEGwuSbG9P94NJAQCJVAZIHVRvLRnuTIoCm8O
         5yYw==
X-Gm-Message-State: AC+VfDygrPtSAf0GIbp6BT31sK+IqLgXQ++sKhhLZ5DmXYABys68PBd+
        P7hXVqLt+KOwlpGTbtYlX3E=
X-Google-Smtp-Source: ACHHUZ4Y+BZSjHFN5VwYPlnpB4sPH1TooqUzdhob7wA1xihalx4cRFlUUnZ/QCJykXjARr6+fJFnjg==
X-Received: by 2002:a2e:7011:0:b0:2a8:c32d:1238 with SMTP id l17-20020a2e7011000000b002a8c32d1238mr699739ljc.15.1683187044986;
        Thu, 04 May 2023 00:57:24 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b002ab1216de44sm5062166ljl.71.2023.05.04.00.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:57:24 -0700 (PDT)
Date:   Thu, 4 May 2023 10:57:13 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] iio: bu27034: Probe asynchronously
Message-ID: <e7088793e1868c77b1894b30cd026e8ed043ea7c.1683185765.git.mazziesaccount@gmail.com>
References: <cover.1683185765.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aciMmrdY9RqkdmjW"
Content-Disposition: inline
In-Reply-To: <cover.1683185765.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aciMmrdY9RqkdmjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devices which may take a while to initialize during probe and which have
no strong reason to probe synchronously can request asynchronous probing
as default probe strategy. This can speed-up start times on some
platforms.

The BU27034 gets probe delayed for at least two reasons. It enables the
supply regulator, (which is likely to have ramp-up delay if it was
disabled) and additionally it delays while the sensor itself is
initializing.

Changing to asynchronous probing may cause problems. Some of which are
discussed in:
https://lore.kernel.org/all/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org=
=2Euk/

Enabling async probing for the ROHM BU27034 should be fairly safe to try
though as there is no in-tree users for it yet. If the async probing
appears to be an issue we can switch easily back to synchronous (or
better yet, fix the actual problem).

Enable asynchronous probing for BU27034.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I am unsure if this change is 100% safe - but I don't immediately see
the harm. Please let me know if some of you have more experience on
problems when using asynchronous probing with IIO devices.
---
 drivers/iio/light/rohm-bu27034.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index f85194fda6b0..183cf550af13 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1500,6 +1500,7 @@ static struct i2c_driver bu27034_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "bu27034-als",
 		.of_match_table =3D bu27034_of_match,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new =3D bu27034_probe,
 };
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

--aciMmrdY9RqkdmjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRTZVkACgkQeFA3/03a
ocVt6QgAzTIOeNiwwPslvohllnSHS2DfMTZMJDXjJXn+lzji1prk8rKBfuCyYRHa
3nza52sa246JdTScrbx3bFY3nAN2UWbHKp93dacnrTecvk+YxaKfVtyRnHlDsBoh
6XTBQjW0XHz4pkGfjZYAg2VoaRSM6N4KR7/r88ls+5wSzz2wS03CaUovyQTNGCnO
ggrrA9F4w6nBp+4TDBX7Bn7SwNcUa2C0tHGFj3nFwBdqr0a9y1PGtTKXp3i+mELj
I9zr21IlI99VZSuM8ao4rIrXD8Lac/szHoXPIpBA8CUSVQ6bFXyJ2SQmjiG6oZTU
kJzyLAoh7ATDhqXnQ+7UUmH9W7MVQA==
=PJv1
-----END PGP SIGNATURE-----

--aciMmrdY9RqkdmjW--
