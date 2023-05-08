Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39A6FAA7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjEHLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjEHLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:02:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E434881;
        Mon,  8 May 2023 04:01:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso1310285e87.3;
        Mon, 08 May 2023 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683543700; x=1686135700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emaLfDqfNji1wHcGzgZ0JEzgTkXF4yqdECX8DFHrBeQ=;
        b=V0KakBYcXFaNHApKKoyS4LPMeoML66Ouc+LVpR69suB0GgqzrleJIrRFLRioegCtZX
         WASlzjlAMVi7a0HCxEMsWldkEgeGUA06puIsb/9SUo1poXMhPmE9Rupmy6RIYn9UZ3kr
         2nXcDAg8GxUpcViYYEf90TT6zDjpXdUDs9Eqw2EcxPUBUgejOiFCfFUkj0pNNbxSA1/X
         eXaLBsynQeRqPl5lHtdytt7n45NbvUSycOuFu9mxsySWQb27Wx8T7GVqvye7zlAy3Dcy
         NCQvgshxXdsUlEjBoHU2eiNzmxnyDF+i5n+LReiqfWFKwMRgxwRaA23yoFYwpfxdYLEG
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543700; x=1686135700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emaLfDqfNji1wHcGzgZ0JEzgTkXF4yqdECX8DFHrBeQ=;
        b=MDgrCEMFqKN0KjEmq6wAOrOVW274hEWwWTxKhWZoso6n/AQaIxf5IAKTa8vNF9e0fV
         FlGIkBfelndozt/dx/9TP9aIiOl4aC3TC0qAgc8sOYPIMMnp4Euuyon42OH7i80dzz1c
         X0dWsfgB2oQzgOYEc0EfTsPtgkOUDFjJqH6InXWOkFjwirIJ/EBmBdMP/I3Rg7jz5xIb
         JW1QyXPY9XT00CnfPtDo4uzSh0oiMM2QMxLTtGmyF7zlXHjnAtEZmtUSdBxbI0Bbp3o7
         7HLqT89FEsMn5lkkwqf6N4PDNFDO72vkhXn3yrk6PBCgjhi7KsR97gXhgmnKmRtQJQ0Q
         czkw==
X-Gm-Message-State: AC+VfDwEZfnEwDl15IRfpZDxCwnWU0pEZl/yTMgtIbmhCz8/16sh/Jbv
        1EvvYbwUamLRU7kaPchSKFA=
X-Google-Smtp-Source: ACHHUZ6dG8Y0kgfDKQd70uztKs9K6rH+WNaZKQOl3nQqSZk2PyRg6Q6LSBY97tcH5RhG5f1EzaQOxg==
X-Received: by 2002:a19:ae1a:0:b0:4f2:4d0a:7bdf with SMTP id f26-20020a19ae1a000000b004f24d0a7bdfmr908928lfc.52.1683543700112;
        Mon, 08 May 2023 04:01:40 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id j1-20020ac25501000000b004f001b0eda2sm1262729lfk.56.2023.05.08.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:01:38 -0700 (PDT)
Date:   Mon, 8 May 2023 14:01:25 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: bu27034: Ensure reset is written
Message-ID: <ZFjWhbfuN5XcKty+@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zUN/p8D1oB8SxR7S"
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


--zUN/p8D1oB8SxR7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reset bit must be always written to the hardware no matter what value
is in a cache or register. Ensure this by using regmap_write_bits()
instead of the regmap_update_bits(). Furthermore, the SWRESET bit may be
self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
we do also read the right state - should we ever need to read it.

Finally, writing the SWRESET bit will restore the default register
values. This can cause register cache to be outdated if there are any
register values cached.

Rebuild register cache after SWRESET and use regmap_update_bits() when
performing the reset.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

---
v3: Combined patches:
("iio: bu27034: Ensure reset is written")
https://lore.kernel.org/lkml/ZFIw%2FKdApZe1euN8@fedora/
("iio: bu27034: Reinit regmap cache after reset")
https://lore.kernel.org/lkml/ZFM7lE4ZuDrUTspH@fedora/
---
 drivers/iio/light/rohm-bu27034.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 25c9b79574a5..f85194fda6b0 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -231,6 +231,9 @@ struct bu27034_result {
=20
 static const struct regmap_range bu27034_volatile_ranges[] =3D {
 	{
+		.range_min =3D BU27034_REG_SYSTEM_CONTROL,
+		.range_max =3D BU27034_REG_SYSTEM_CONTROL,
+	}, {
 		.range_min =3D BU27034_REG_MODE_CONTROL4,
 		.range_max =3D BU27034_REG_MODE_CONTROL4,
 	}, {
@@ -1272,12 +1275,19 @@ static int bu27034_chip_init(struct bu27034_data *d=
ata)
 	int ret, sel;
=20
 	/* Reset */
-	ret =3D regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
+	ret =3D regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
 			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
 	if (ret)
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
2.40.1


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

--zUN/p8D1oB8SxR7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRY1noACgkQeFA3/03a
ocVEWgf/b+ePeCroBNw29JDeXSmCoyM+l+yLgNn2ymP9efCBdwIqRfUFkdPTj+u2
8JRaNblOnR2wsZnu/XaHl0wW7wFjiqv/XSvBr20rpEPwDLBhiFCH8x2sNNGFINf9
u/bPkIOnMIFOJcI8kdbcCJK9HGrxsMvoUUFlkmPpUAYJVcxOGJ+O+IYhz7NPD5HJ
CtpvvbILLPIxUMtj7ZE9lYC/odXCGYyZcXgTGtpdLzs834VYO/CeIXaQF5uW7a5W
hnYQovD7nLFRKHnhAf2Vo5dzmd66nfWvFqCkQTnqVGARiOUfuc4Zrb52M+ExS7gi
KMLV7orU4EcdI2/QHyGdKFJGsCRU9w==
=z93B
-----END PGP SIGNATURE-----

--zUN/p8D1oB8SxR7S--
