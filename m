Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46562B72B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKPKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKPKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:06:14 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185808F;
        Wed, 16 Nov 2022 02:06:13 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k19so21169539lji.2;
        Wed, 16 Nov 2022 02:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdCk/i513kMMAJ+DkyLvEiWGOZZpsa1KluZXc3adt2s=;
        b=gMnLwBENppi0q8Mxp9H8G4bKEGmmGwJOWSaSSdT90HCK5hNtIyvNmGU5mT01YgQCbp
         keisqPaSfBWp7mPi62c540GP8aVNDDKlQ1v7IF1aamFl/hyCoTMNfVQu0LpfgcFr8oYK
         NjXs/OMQe0XpgsDTxoT+3ZozMg4hzw91fIp9NCn2h7Aaz4yQBLyFjh+/D4HPe3+G/G8R
         bAh1NDVpu/J4OBabGB8yJAjQpuCiauOlO8LzpZW3r/nim3TmndNXl1M9yGF8ml4/yrdW
         JC48diak+YJU4vIOqFMG30qt/pDpYE3G6UCWJGXqvEc3LjeOtVmujjIkA/gk3y/UVYnJ
         p0UQ==
X-Gm-Message-State: ANoB5pnxPcKm+Ao2l6CVLrvCCqB7xcz/yQ7Dbgr1x6WHcwRrPkKtkoTU
        IXVp343Dgr8QGoD8xclbr37cg8myzWE=
X-Google-Smtp-Source: AA0mqf7v3Z1IOvNFxMwudHwY9nPh40xyL7BRyyG/NI859k8v6Fr1ukOKjNxWPS+RZdvx4AsDQIE7WA==
X-Received: by 2002:a2e:8706:0:b0:26d:e3ae:886a with SMTP id m6-20020a2e8706000000b0026de3ae886amr8016298lji.531.1668593171311;
        Wed, 16 Nov 2022 02:06:11 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e83d7000000b00268cfcf841asm2920650ljh.56.2022.11.16.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:06:10 -0800 (PST)
Date:   Wed, 16 Nov 2022 12:05:56 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: 88pm860x: simplify using devm
Message-ID: <Y3S2BPJC+jLLN59z@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tiDKVUK3dZKOLXxl"
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tiDKVUK3dZKOLXxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use devm variants for requesting threaded IRQ and for power-supply
registration. Clean up error path and remove the .remove-callback.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Oh, found this commit while cleaning-up my local git branches. Seems
like I never got around sending this?

Please note, commit is untested as I don't have the 88pm860x HW
---
 drivers/power/supply/88pm860x_charger.c | 38 ++++++-------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/88pm860x_charger.c b/drivers/power/supply=
/88pm860x_charger.c
index f21ce52fbc04..2b9fcb7e71d7 100644
--- a/drivers/power/supply/88pm860x_charger.c
+++ b/drivers/power/supply/88pm860x_charger.c
@@ -690,8 +690,7 @@ static int pm860x_charger_probe(struct platform_device =
*pdev)
 	    (chip->id =3D=3D CHIP_PM8607) ? chip->companion : chip->client;
 	if (!info->i2c_8606) {
 		dev_err(&pdev->dev, "Missed I2C address of 88PM8606!\n");
-		ret =3D -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	info->dev =3D &pdev->dev;
=20
@@ -704,44 +703,26 @@ static int pm860x_charger_probe(struct platform_devic=
e *pdev)
 	psy_cfg.drv_data =3D info;
 	psy_cfg.supplied_to =3D pm860x_supplied_to;
 	psy_cfg.num_supplicants =3D ARRAY_SIZE(pm860x_supplied_to);
-	info->usb =3D power_supply_register(&pdev->dev, &pm860x_charger_desc,
-					  &psy_cfg);
+	info->usb =3D devm_power_supply_register(&pdev->dev, &pm860x_charger_desc,
+					       &psy_cfg);
 	if (IS_ERR(info->usb)) {
-		ret =3D PTR_ERR(info->usb);
-		goto out;
+		return PTR_ERR(info->usb);
 	}
=20
 	pm860x_init_charger(info);
=20
 	for (i =3D 0; i < ARRAY_SIZE(info->irq); i++) {
-		ret =3D request_threaded_irq(info->irq[i], NULL,
-			pm860x_irq_descs[i].handler,
-			IRQF_ONESHOT, pm860x_irq_descs[i].name, info);
+		ret =3D devm_request_threaded_irq(&pdev->dev, info->irq[i], NULL,
+						pm860x_irq_descs[i].handler,
+						IRQF_ONESHOT,
+						pm860x_irq_descs[i].name, info);
 		if (ret < 0) {
 			dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
 				info->irq[i], ret);
-			goto out_irq;
+			return ret;
 		}
 	}
 	return 0;
-
-out_irq:
-	power_supply_unregister(info->usb);
-	while (--i >=3D 0)
-		free_irq(info->irq[i], info);
-out:
-	return ret;
-}
-
-static int pm860x_charger_remove(struct platform_device *pdev)
-{
-	struct pm860x_charger_info *info =3D platform_get_drvdata(pdev);
-	int i;
-
-	power_supply_unregister(info->usb);
-	for (i =3D 0; i < info->irq_nums; i++)
-		free_irq(info->irq[i], info);
-	return 0;
 }
=20
 static struct platform_driver pm860x_charger_driver =3D {
@@ -749,7 +730,6 @@ static struct platform_driver pm860x_charger_driver =3D=
 {
 		   .name =3D "88pm860x-charger",
 	},
 	.probe =3D pm860x_charger_probe,
-	.remove =3D pm860x_charger_remove,
 };
 module_platform_driver(pm860x_charger_driver);
=20

base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
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

--tiDKVUK3dZKOLXxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN0tgAACgkQeFA3/03a
ocXyXgf+OUGV4IQkSWIAnFyABpjUWCecJIV9WtoTTNDLi2Y/kq//Pc9UWANmvgPD
FOQfL8tJPXiKg4Gpofnh8U2E4tMD4Z5bwAj6dJtOHNUs2Ecyly0DzAeCCY315xNB
MA10RujvxDYfU3tBN4cuk+LSlwwXhXhxp6tD0tp+4OzPpAkq9G8PEVq4Y28Qba+9
rlKKw/L6CBPqytUXqykibgpTKGur3UNjylpWmSN8C1ZONztrwCOMj3dmmiTCUncT
EylZpRIx8ejJOqMT2ri26DExSlkcuQzPUIZ144Lt+rfJtWORff1nREOfh+UEY+Pv
+hNs0i3yrr8pEi/5f9lF+rQv6jexew==
=6GTB
-----END PGP SIGNATURE-----

--tiDKVUK3dZKOLXxl--
