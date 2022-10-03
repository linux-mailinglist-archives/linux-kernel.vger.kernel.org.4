Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8945F2C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJCIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiJCIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:39:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C594B98B;
        Mon,  3 Oct 2022 01:13:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l14so819072lja.8;
        Mon, 03 Oct 2022 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ozJi7bas0K7OL0m/OlaE7Db/H8qeB+9gBWikgiBjNdA=;
        b=AY3EwZCkUfoCgnmJKPHFE/JaPiyO4ZsN2ZD1VaZZ8NACu+v0YePbkc4falbnv23QtE
         zsFDgeGk/L7z0oEuC6SkJUr4OfNzt6K0Lt4bGALj6WsqeeVaFK5XC4jcWW2RXRse9mqZ
         RZHaeth/4DyJeSZktk/RLOoogCe7kLchTDUIAiTc/jr8I+Y+56ybzZET4lz9FL2cquZC
         MN7BwPqeIZJhOfJVptdX7EeA+nDTlDR6HhEvHlNC2s5HMiycoJ8oAIm8NCg5oLkD71dl
         3xKfUWGZmk0P/YO3b9T1SXuL+8BISEZy2VJj9e2vLbjtUgmbFGpEbBnYA9L58ZB9kzYG
         JM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ozJi7bas0K7OL0m/OlaE7Db/H8qeB+9gBWikgiBjNdA=;
        b=RhNb3myUOyGwGG/ZqakV2vtLE5Bo2tt0T21g/cteCM7YGbik4cULLsT3Xia6PyM1Ny
         SVzUPT7IDYwHT4JcknSq0lo4l/V5wr8xanjXbam/zMhkr9p+k4P0jx1xQarQh9IrzElo
         LNjNw1exiHC7X6IQtcsDyc1AmZHE8rs9Jvi2DT02sp/YnAZiSB+rbS6CjKZVR69uuPlX
         gdBT6x9LwFfjeTOrIYlefNprUmY5fOB7idMn+qNEEuvadMH6q/DtIbibd8TzyjdPxad9
         b7Gy9usKd7+tXQaSG3spMFJhK36tWXjrrgZyXukvbbqDz7eerP/3owokeyQTbqfWzCAF
         HqQQ==
X-Gm-Message-State: ACrzQf2q5pQn+2EcNSf3YEx6gi1rnVGUapw7RXzBb0S2ym0T1JIA8DFk
        vyb4twPDZo+I5yu0urTE8eQ=
X-Google-Smtp-Source: AMsMyM7F1g9zUs46xXqRuvQk06G1LfAvpgeb3ufEV0bYD5xWTKuboqXMYNUj8G9BX1ykdwlX4Oc1DA==
X-Received: by 2002:a05:651c:1a26:b0:26c:4c0d:b10a with SMTP id by38-20020a05651c1a2600b0026c4c0db10amr5760102ljb.415.1664784816913;
        Mon, 03 Oct 2022 01:13:36 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id m1-20020a2ea881000000b0026c423959desm822084ljq.25.2022.10.03.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:13:36 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:13:31 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] iio: at91-sama5d2_adc: Use
 IIO_STATIC_CONST_DEVICE_ATTR()
Message-ID: <4476a4ce852febb3eb863878e66751c787195b18.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0RceFZoSIZYBk5np"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0RceFZoSIZYBk5np
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Slightly simplify by dropping open-coded constant data iio_dev_attr
functions and using the IIO_STATIC_CONST_DEVICE_ATTR() instead.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index 6e3f9fa93cee..dca014d1108f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1841,26 +1841,13 @@ static ssize_t at91_adc_get_watermark(struct device=
 *dev,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
 }
=20
-static ssize_t hwfifo_watermark_min_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", "2");
-}
-
-static ssize_t hwfifo_watermark_max_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sysfs_emit(buf, "%s\n", AT91_HWFIFO_MAX_SIZE_STR);
-}
-
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       at91_adc_get_fifo_state, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       at91_adc_get_watermark, NULL, 0);
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "2");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_ST=
R);
=20
 static IIO_CONST_ATTR(oversampling_ratio_available,
 		      __stringify(AT91_OSR_1SAMPLES) " "
--=20
2.37.3


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

--0RceFZoSIZYBk5np
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6masACgkQeFA3/03a
ocVFOwf+MOBner9amlp7MwwSXLM4mws2DdggLA9dDw0SC5bYjryERfkpQDydgffq
U2IjQXossv6RH9CKuiFrZsB4YIA4B6RgapZlw0diTbYv5r7hLi17NGaBLx3pJ8E6
aC5FIwrSLl0+odcrtDpvSr4N8o7mSZoOmQG03yqU5K58v7Q6ft/0p+jWGDLJFMSq
Pa97L8d79vEQ6pvRZnEOO3DpcxgyUuz4ONR4VTkYwxV6RRVq46fs7DaNCc97K3MN
KN1Pzdzmt2yOZu6Ix4GvaCd6ZNgWrqNfSiFHZND07SKWcrP1f46Qa1vQgUyXDGF0
yY1LVUCRfCajBKzT2NIJDI9UMgIXWA==
=fxgo
-----END PGP SIGNATURE-----

--0RceFZoSIZYBk5np--
