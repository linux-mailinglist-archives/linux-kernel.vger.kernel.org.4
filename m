Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D96F47E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjEBQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjEBQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:00:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A13A9B;
        Tue,  2 May 2023 09:00:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8ba23a2abso39471471fa.2;
        Tue, 02 May 2023 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043239; x=1685635239;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOscjZRE2kRGfBRAgK+YuOAkiZKv/9Xhgl259n6HHD8=;
        b=ULs8Q+OAhTdDuL84xJdiokUXzHzLNVyWArenYjGvP1XxLpA57fuVABb2gUwKVI+v3X
         uAoezZ46LWDJBpjphtVz1bP+H1tWClkdZiLEEchzp1VTxZ7UkzCvtXLH85iVLtuNyBWp
         zX7o8qChacRm0mLKBMYCXsYLEPmYiXS684ohfxxXOxhojzhN26L/TRJFmpNHmBMHnyvQ
         V2VSfR5L/ljIuqTxhW9Ew+U0EexZsLuXn9Qrof4rQx5QJnf8uO127dbFohfAXuO4H2q/
         KZZMCYXuhKZLTdsKGlQBjRYfO6zmkmgHAh8O9AdanCvZRHmZOH7WoxW3FtokvtVVnnv4
         aa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043239; x=1685635239;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOscjZRE2kRGfBRAgK+YuOAkiZKv/9Xhgl259n6HHD8=;
        b=FA3ROfvymLHwphPn6Nk7gfyatZugUawG4bS52sVk+6zhr/9vTvVzuMhUbeInB/vcwh
         xC8LL7Ajz0ETBhsuEf5w2Ua8DNx5ibHjGD3CogzHhqNqon5xH/4ttEkfrqXKskxzTYIa
         MhbDmJXFnRlFhqGyUsgxhL35+1wSPVCDu368yiVPkRZPDvJS+UKxpfvoodYwL1alHZSk
         Yqz41hegl5bf1tyqPjgQys3rr6PEzEL5HMsUmD7fXUwrrWJcND3f+DTKWRlTrX9HLeoM
         2oDJOU3mFPKGUID7X4+VF+W+wxIImfC7CrCImmlx7iO+f7uvh8o9+HHA498qXH7tGECa
         b8lg==
X-Gm-Message-State: AC+VfDxqM67MJVfp3TjkGhyL3rcVMuetlh6eqqYc6wgEQlppgcDohpMh
        MakHeWBRFjf1MX2skIsIuLvDxn5IlOI=
X-Google-Smtp-Source: ACHHUZ4AAUeFcYiXKC+0RnlCNa80VNnACAiB3koGh0zDekVxTctb4wPvV5E5Jw8taj3CHh+O92hKag==
X-Received: by 2002:ac2:561a:0:b0:4f0:13e2:ed99 with SMTP id v26-20020ac2561a000000b004f013e2ed99mr115975lfd.12.1683043239085;
        Tue, 02 May 2023 09:00:39 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25a08000000b004ecb06acbb3sm5401968lfn.281.2023.05.02.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:00:37 -0700 (PDT)
Date:   Tue, 2 May 2023 19:00:24 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bu27034: Ensure reset is written
Message-ID: <ZFEzmA/0whRO6IFv@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dohUr8GHFqpjSqLp"
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


--dohUr8GHFqpjSqLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reset bit must be always written to the hardware no matter what value
is in a cache or register. Ensure this by using regmap_write_bits()
instead of the regmap_update_bits(). Furthermore, the RESET bit may be
self-clearing, so mark the SYSTEM_CONTROL register volatile to guarantee
we do also read the right state - should we ever need to read it.

Signed-off by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

---
I haven't verified if the reset bit is self-clearin as I did temporarily
give away the HW.

In worst case the bit is not self clearing - but we don't really
get performance penalty even if we set the register volatile because the
SYSTEM_CONTROL register only has the part-ID and the reset fields. The
part-ID is only read once at probe.

---
 drivers/iio/light/rohm-bu27034.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 25c9b79574a5..740ebd86b6e5 100644
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
@@ -1272,7 +1275,7 @@ static int bu27034_chip_init(struct bu27034_data *dat=
a)
 	int ret, sel;
=20
 	/* Reset */
-	ret =3D regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
+	ret =3D regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
 			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");

base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420
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

--dohUr8GHFqpjSqLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRRM40ACgkQeFA3/03a
ocU1Awf8D8Y7JyIoqDRcOcZTe1sTfU4Kamm+vdjzMCK/0HfzX23JKyK5OhOez80x
3XWGmzOklKTlRRlMSd/f7HsGozK6FNtdf2WS5kJBCsxp1DTO1w32lujTDcbQyzOF
anoxRgLhDB5JQAKbBmpU/PGWrkUwa47mdgCKP1iCXQQoSKnDHGt8GYm+4lEX77zU
jp2kTfuZaoLaXBgcMcZeiYRBwuWVHk1bmmXq6QXtrwAn7OuPk265vt2qhtSBx13k
lFts4Wgeoc5TChH3AAstXFB6CU+AIXE4V1OklhCaFDHvdVvf4I88lGWh2k8b8S29
TGWVa+VrNpfhyibdsrXCSiizoTdBdw==
=dBhE
-----END PGP SIGNATURE-----

--dohUr8GHFqpjSqLp--
