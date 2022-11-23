Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57091635C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKWMAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKWMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:00:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87A7651
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r12so27883321lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5p4E1mI/PEqffjz8f8OBqeFrGyZRJUVUJmG4+2QrCs=;
        b=jycwFKbXMlZHgNRBW8WkRiTlZgPFeIVvaxQAfGZ77WVlLnzg6fqwEwUkshRSp/1sEr
         2kxb8Uw8xAnQ+rXrXSBpw07NrlYZiNEG0RO7DHwZK+bpX5JOL/Vnml8/UfIqleJMjOzg
         xD+IS9wKm+8JUx/MqGnfqAa2d9JgO9kaJafjxEFzuW1pIuz8syhr98hagafP6/gCOLCq
         LrNyFz+/L+ke8h0eqecdo1uUigr6qA1qEcves9XU99qT5XmWaKItuTJ4XvKJV2xvOG8u
         pKXT6NzjYySfqCVkvnEF2cYQseWQlfvlWMQ3conHtYBE09428AUHOQ99XJHmUUEiFXj2
         CFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5p4E1mI/PEqffjz8f8OBqeFrGyZRJUVUJmG4+2QrCs=;
        b=YLrvuUUEDRSgLAs51OB/do0sRXNRJ2i6et0dwlRYH6LZs0C5xLKJ7BerQYJ8UgLp9+
         Drm27SZUQ5pgkrnc2VUsNkRxvCcAa3y8PqbmfQpwQonmz6ycsx59qTA+gRSxcCyPcDGr
         eSa1gmDJiWaCbpyY1Ns5VHmk/XlHZEOPqYseIZKACh89KP5jH8FGkozWTNxT1Bhi7KeV
         u+vecBQJZHXc3VCFbPga+cgeLijKhgxkf/ZO4dvbKwh1HhjirtyFT0Dk+v86CE2Q1Qt2
         n0tOsxG59ZAeJzh/xkH5FBq1IjW3Cx2/rBNx2otUsHPIHFGxUdf2DBcR5gEuA9a1VGDf
         SRNw==
X-Gm-Message-State: ANoB5plABJCQdew3wy4UK6KRYjGIQX3vplPCfISCuEjQWoMQP/TeEnrE
        4KLzFX2WzfF7k/vmMR429D/aLpcEkyI=
X-Google-Smtp-Source: AA0mqf7YwukOfXWDIg4MANymtbNnIERJFhiOnpyWK/h5C6t5SIzAllEgcRBjpxjIBGXX9x0hs5fVlw==
X-Received: by 2002:a05:6512:3c83:b0:4a2:3a78:106d with SMTP id h3-20020a0565123c8300b004a23a78106dmr9000513lfv.419.1669204826033;
        Wed, 23 Nov 2022 04:00:26 -0800 (PST)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q21-20020a056512211500b004aa3d587c84sm2881410lfr.200.2022.11.23.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:00:25 -0800 (PST)
Date:   Wed, 23 Nov 2022 14:00:21 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] regulator: bd71815: bd71828: bd9576: Use dev_err_probe()
Message-ID: <0b644da4a8f58558ffe474d2593f85c46de2f965.1669203610.git.mazziesaccount@gmail.com>
References: <cover.1669203610.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pD2NDMyRXoJxPXvH"
Content-Disposition: inline
In-Reply-To: <cover.1669203610.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pD2NDMyRXoJxPXvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The dev_err_probe() has (at least) following benefits over dev_err()
when printing an error print for a failed function call at a device
driver probe:
        - Omit error level print if error is 'EPRBE_DEFER'
        - Standardized print format for returned error
        - return the error value allowing shortening calls like:

        if (ret) {
                dev_err(...);
                return ret;
        }

        to

        if (ret)
                return dev_err_probe(...);

Convert the ROHM BD71828, ROHM BD71815 and ROHM BD9576 regulator drivers
to use the dev_err_probe() when returned error is not hard-coded constant.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/bd71815-regulator.c | 10 ++---
 drivers/regulator/bd71828-regulator.c | 21 +++++------
 drivers/regulator/bd9576-regulator.c  | 54 +++++++++++++--------------
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71=
815-regulator.c
index c2b8b8be7824..8b55046eded8 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -602,12 +602,10 @@ static int bd7181x_probe(struct platform_device *pdev)
 			config.ena_gpiod =3D NULL;
=20
 		rdev =3D devm_regulator_register(&pdev->dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %s regulator\n",
-				desc->name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     desc->name);
 	}
 	return 0;
 }
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71=
828-regulator.c
index a4f09a5a30ca..ad728f4f2241 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -750,23 +750,20 @@ static int bd71828_probe(struct platform_device *pdev)
 		rd =3D &bd71828_rdata[i];
 		rdev =3D devm_regulator_register(&pdev->dev,
 					       &rd->desc, &config);
-		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %s regulator\n",
-				rd->desc.name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     rd->desc.name);
+
 		for (j =3D 0; j < rd->reg_init_amnt; j++) {
 			ret =3D regmap_update_bits(config.regmap,
 						 rd->reg_inits[j].reg,
 						 rd->reg_inits[j].mask,
 						 rd->reg_inits[j].val);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"regulator %s init failed\n",
-					rd->desc.name);
-				return ret;
-			}
+			if (ret)
+				return dev_err_probe(&pdev->dev, ret,
+						     "regulator %s init failed\n",
+						     rd->desc.name);
 		}
 	}
 	return 0;
diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd957=
6-regulator.c
index 393c8693b327..02c70768652b 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -953,30 +953,28 @@ static int bd957x_probe(struct platform_device *pdev)
 					   dev_fwnode(pdev->dev.parent),
 					   "rohm,vout1-en", GPIOD_OUT_LOW,
 					   "vout1-en");
-		if (!IS_ERR(en)) {
-			/* VOUT1_OPS gpio ctrl */
-			/*
-			 * Regulator core prioritizes the ena_gpio over
-			 * enable/disable/is_enabled callbacks so no need to
-			 * clear them. We can still use same ops
-			 */
+
+		/* VOUT1_OPS gpio ctrl */
+		/*
+		 * Regulator core prioritizes the ena_gpio over
+		 * enable/disable/is_enabled callbacks so no need to clear them
+		 * even if GPIO is used. So, we can still use same ops.
+		 *
+		 * In theory it is possible someone wants to set vout1-en LOW
+		 * during OTP loading and set VOUT1 to be controlled by GPIO -
+		 * but control the GPIO from some where else than this driver.
+		 * For that to work we should unset the is_enabled callback
+		 * here.
+		 *
+		 * I believe such case where rohm,vout1-en-low is set and
+		 * vout1-en-gpios is not is likely to be a misconfiguration.
+		 * So let's just err out for now.
+		 */
+		if (!IS_ERR(en))
 			config.ena_gpiod =3D en;
-		} else {
-			/*
-			 * In theory it is possible someone wants to set
-			 * vout1-en LOW during OTP loading and set VOUT1 to be
-			 * controlled by GPIO - but control the GPIO from some
-			 * where else than this driver. For that to work we
-			 * should unset the is_enabled callback here.
-			 *
-			 * I believe such case where rohm,vout1-en-low is set
-			 * and vout1-en-gpios is not is likely to be a
-			 * misconfiguration. So let's just err out for now.
-			 */
-			dev_err(&pdev->dev,
-				"Failed to get VOUT1 control GPIO\n");
-			return PTR_ERR(en);
-		}
+		else
+			return dev_err_probe(&pdev->dev, PTR_ERR(en),
+					"Failed to get VOUT1 control GPIO\n");
 	}
=20
 	/*
@@ -1037,12 +1035,10 @@ static int bd957x_probe(struct platform_device *pde=
v)
=20
 		r->rdev =3D devm_regulator_register(&pdev->dev, desc,
 							   &config);
-		if (IS_ERR(r->rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %s regulator\n",
-				desc->name);
-			return PTR_ERR(r->rdev);
-		}
+		if (IS_ERR(r->rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(r->rdev),
+					"failed to register %s regulator\n",
+					desc->name);
 		/*
 		 * Clear the VOUT1 GPIO setting - rest of the regulators do not
 		 * support GPIO control
--=20
2.38.1


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

--pD2NDMyRXoJxPXvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN+C1UACgkQeFA3/03a
ocV6xggAj4EFx9qaOc+bNDhdAVx40wXxZ0O3XX75hvb06bM9RqFaX2BUQxe3MG3Y
uB9G6Lo2wJXQvLLLbclmJthnAf1OEmouubKHUG4IbWed6OYHlOB+nnr+QZO/X88N
bnE794vfVMCsebaUNahmEXWpjNkgPcE8/uBFkuZxF7SCF0W8wz1Jf7NAd4eM3wwi
BN+GwGtLa9oKpm1Lhmf81w1JkShP7HcQrxxWS3UezDQampV9G9IvYKhwSYo53PUx
N8E4ZNOMB3zU3v3gUk3XZhOYi1IBZ9Np3W1f17NCqG++nDUeNIOZxiOq/WNtBGur
N7z746RGdCMr6HBpEaN70lI3SRcQQA==
=Cdo8
-----END PGP SIGNATURE-----

--pD2NDMyRXoJxPXvH--
