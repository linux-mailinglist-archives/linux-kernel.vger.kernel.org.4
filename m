Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E06DF53D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjDLMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjDLM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:29:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9E72B1;
        Wed, 12 Apr 2023 05:29:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q26so2275942lfe.9;
        Wed, 12 Apr 2023 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siCdH4i793Fr0Wj+21nPqmHI0RDFnIElDQrnU73xJYE=;
        b=VQeCgQHI1EcjcFspsDA0zh1lWNC/OCP9F8kU/YlAwXgU5fTRTIXy7bmnnl4+N7zA+p
         6IA34k911R6zsbWb73+5Z4Q/6GHydO4fCAqHpV0/Vpq3c7U5RY1EGSlvGUR7Td3fpzwi
         TSD63KOFu/GsWRmacMpazKGJzQxEX64GgltaFsMgj3n+2RrUATCwS252Xo1Cz3H0i7S6
         X888/cR9bclHvDmJjkuF7XVHguwYS+fBrPjh0zUvagF0HYfVVHO58kbujExExX8VuoJS
         CLTAZq0aEhmDsLfXXuzLoph0kIexzAwKXQ+Vce3NidURTMIYEBGNE65nAtIIOHuEFPWX
         4phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siCdH4i793Fr0Wj+21nPqmHI0RDFnIElDQrnU73xJYE=;
        b=q2BUy0mMUhev7NcibrK6zz0D7cQtZuwjYE0nedHdDrh6oIA2U9nfi1QCNSAfLQ0CiI
         P490+4BDmL+Ukf/hD8awsZSgtK0YCoKpRIvUj99fLz1bMbWY0L2Rj1eiMYfKP2vwdIm9
         GfVZT5s2xfG87vb9OVQy8CWthbVXf00G1G5cBHFOIq0LGQZGZkrY2HYgSSWR3Dlqumpy
         5itpweHUXno53HXitFyFJ6J9BD4xpAoKnLLq55yn4t0cJWe5WKo669Xxc4uZnkGuT1py
         dzYGL1VdQOINiIANz3oy7zZiUp7QBLterlUhTzLVgB+pQzXqPPONmZ6cYKanlaqWMH1B
         j7QQ==
X-Gm-Message-State: AAQBX9c8OTWAspTe3e9++XDqmYQe857n1KjV1VAz5sYqe4aRskDuLvv3
        jayQ/BTqk6U9ZYulWU8gdJ0=
X-Google-Smtp-Source: AKy350YoQXSzO91Dyj+lPCb5tSWpcCDLY/OAJLAUkM8P1zlP2mEfymzfXSK3UmKtyEid6KjzXadmhw==
X-Received: by 2002:a05:6512:203:b0:4e9:d158:d56b with SMTP id a3-20020a056512020300b004e9d158d56bmr512162lfo.62.1681302550783;
        Wed, 12 Apr 2023 05:29:10 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id n12-20020a19550c000000b004e7d6eb9cbfsm2973522lfe.190.2023.04.12.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:29:10 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:29:01 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: bu27034: Fix integration time units
Message-ID: <a3bc95f4a16f876925cfc157aaf5d78f3dbc513d.1681301472.git.mazziesaccount@gmail.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vA0ECADkg+SHgofM"
Content-Disposition: inline
In-Reply-To: <cover.1681301472.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vA0ECADkg+SHgofM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The integration time was presented by BU27034 in micro seconds. The ABI
documentation says this should be in seconds.

Fix integration time to be in seconds.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/rohm-bu27034.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index e486dcf35eba..6044db52abfa 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1171,7 +1171,7 @@ static int bu27034_read_raw(struct iio_dev *idev,
 		if (*val < 0)
 			return *val;
=20
-		return IIO_VAL_INT;
+		return IIO_VAL_INT_MICRO;
=20
 	case IIO_CHAN_INFO_SCALE:
 		return bu27034_get_scale(data, chan->channel, val, val2);
@@ -1229,7 +1229,10 @@ static int bu27034_write_raw(struct iio_dev *idev,
 		ret =3D bu27034_set_scale(data, chan->channel, val, val2);
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret =3D bu27034_try_set_int_time(data, val);
+		if (val)
+			return -EINVAL;
+
+		ret =3D bu27034_try_set_int_time(data, val2);
 		break;
 	default:
 		ret =3D -EINVAL;
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

--vA0ECADkg+SHgofM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ2pA0ACgkQeFA3/03a
ocWH3wf8DaSDIHX7rDqA/ad9esTevVATPHgoYuabnwMXKq3CotOxP94wplRCTiG8
dT0MOD/b+l91++exduQfwxMEgvsQ0U0RMdfyJxF7NYamj0fJanyl49piWjpTi8G2
8wGg/+6sRJ/ZOcYWxpKoKgbwVh8PaCF/8FMTBf0SeWsfdpH3CYlq3S5RBUqDKpG4
6AT6S6iK5TgxEX8B2m9sUoHs0NyvswA/EIaGtYlQ4blDeZMLvsi+ETpDdWV/H5Vi
fXkxWizLQg0rLiz6vm8azwPPbFImAmKyDd14zItcaDcvtyhkUVSU1lZWN2gz4mSX
TzX6xozVJENpSgZRitq9c5roJjbBKQ==
=x8/X
-----END PGP SIGNATURE-----

--vA0ECADkg+SHgofM--
