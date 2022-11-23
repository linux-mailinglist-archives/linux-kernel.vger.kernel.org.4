Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A35635C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiKWMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiKWMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:00:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36249624A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so27820396lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcR8ovYNo2My0WUKcVnNmYC5cYpEMC0rr3gdSJ74NfU=;
        b=ZrlPHAS+WGiK3Lav2tjX9E3L3EQhNwAGul34uyaC6bhMi4CQY5elSYO++LxtQ+rIG7
         pynaS8fphG+u0aowuVnGAGSO308yaigyNIPmgo2h9itDgHFQKi03T7NGZl+96WAr7+k1
         OKf6GBFSb/8U0NObV+mVI5sikProfgzcwhqJoiErqM490fCODGRBD2biWQLeX63LAIT6
         9gHBFjNOMOc5CaeR8dEZKz+2i9v0z5qpZpEep3MVS+ZoeSAmAo3SN1wnPVS6uKXFPs71
         fqYOZt/GYlz08sOgbf1t2FvLTMExnQPPTa0b6TK1jk+wTPp1uNOznGI4Yk9le4LNWiDs
         vwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcR8ovYNo2My0WUKcVnNmYC5cYpEMC0rr3gdSJ74NfU=;
        b=TLCDroC83hHX9dRrRPu09a9hfEkH9w2YnfqNWGW9hvrYBybRbbpMXNCqiTNDSHuWIp
         Yq0iD/5phcZk3sK7dSjteKQ6EKSEABaPCF6gee1WC11ESBKlES9pikfRcP5nbJ3y2gYU
         hIXDPY2qRDzLvyYSFG5r+FZz/DyszAYEEyKm+fsGBQmGnJK/093HwVmRRah4DtYcMD41
         1EseJA3FLGnJ4127NDJjHBraPoVvFe5Jkss1QwesU3PotorYvnk5G/nHsP//4HHtvdgy
         2zatYOsvjp+EH4nl4l5MmX1BgiiAEa6bkarVIwUqY9CsPHuP6XpusE/CtiplWcvroJdt
         kshg==
X-Gm-Message-State: ANoB5pl4U1IWzBbCfTUPPSNspUxYc7EXIUS36MZcdIxj/SRL1wzbLUPq
        jPLhO4c/UCW3SGPKdy0wJEEBOODMDM4=
X-Google-Smtp-Source: AA0mqf5fQTrrGiUBe6YgPLonglnqFdXNQLBvN4RKRcZqL01u41/3wbm9cmGiL8uHKDcF+fq8QsecuA==
X-Received: by 2002:a05:6512:68b:b0:4a8:d2b7:ed5c with SMTP id t11-20020a056512068b00b004a8d2b7ed5cmr10789411lfe.434.1669204842474;
        Wed, 23 Nov 2022 04:00:42 -0800 (PST)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b004b48c977d8dsm2892067lfg.125.2022.11.23.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:00:41 -0800 (PST)
Date:   Wed, 23 Nov 2022 14:00:38 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] regulator: bd718x7: Use dev_err_probe()
Message-ID: <fee54c2d04bb41b51381e31523f9ed31575206d2.1669203610.git.mazziesaccount@gmail.com>
References: <cover.1669203610.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+iqplJKpcdzleyKU"
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


--+iqplJKpcdzleyKU
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

Convert the ROHM BD718x7 regulator driver to use the dev_err_probe() when
returned error is not hard-coded constant.

NOTE:
This commit also changes the error handling path to return immediately
=66rom a spot where the error is spotted instead of using a single point
of exit.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
For many years I have preferred a single point of exit in a function
when managing it does not require any big tricks. In my experience a
single point of exit makes resource-leaking and lock releasing much less
error prone. Eg, consider mistakes like:

=2E..
mutex_lock(&mtx)
=2E..
if (err)
	return err;
=2E..
mutex_unlock(&mtx);

return 0;

Vs.

=2E..
mutex_lock(&mtx)
=2E..
if (err)
	goto err_out;
=2E..

err_out:
mutex_unlock(&mtx);

return err;

I still think a single point of exit is often a good idea. However, I am
slowly adapting to thought that the single point of exit does not really
play a big role in bd718x7 regulator probe and using dev_err_probe()
allows us to avoid the extra {} after condition... So, maybe it indeed
is a time for me to ditch the goto here. Please, let me know if you
think othervice :)
---
 drivers/regulator/bd718x7-regulator.c | 51 ++++++++++-----------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd71=
8x7-regulator.c
index d161b0026f33..894fab0d53d0 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1706,20 +1706,17 @@ static int bd718xx_probe(struct platform_device *pd=
ev)
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
-		err =3D -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
=20
 	/* Register LOCK release */
 	err =3D regmap_update_bits(regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
-		goto err;
-	} else {
-		dev_dbg(&pdev->dev, "Unlocked lock register 0x%x\n",
-			BD718XX_REG_REGLOCK);
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to unlock PMIC\n");
+
+	dev_dbg(&pdev->dev, "Unlocked lock register 0x%x\n",
+		BD718XX_REG_REGLOCK);
=20
 	use_snvs =3D of_property_read_bool(pdev->dev.parent->of_node,
 					 "rohm,reset-snvs-powered");
@@ -1736,13 +1733,11 @@ static int bd718xx_probe(struct platform_device *pd=
ev)
 					 BD718XX_WDOG_POWEROFF_MASK |
 					 BD718XX_KEY_L_POWEROFF_MASK,
 					 BD718XX_POWOFF_TO_RDY);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to change reset target\n");
-			goto err;
-		} else {
-			dev_dbg(&pdev->dev,
-				"Changed all resets from SVNS to READY\n");
-		}
+		if (err)
+			return dev_err_probe(&pdev->dev, err,
+					     "Failed to change reset target\n");
+
+		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
 	}
=20
 	config.dev =3D pdev->dev.parent;
@@ -1778,13 +1773,10 @@ static int bd718xx_probe(struct platform_device *pd=
ev)
 			desc->ops =3D swops[i];
=20
 		rdev =3D devm_regulator_register(&pdev->dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %s regulator\n",
-				desc->name);
-			err =3D PTR_ERR(rdev);
-			goto err;
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     desc->name);
=20
 		/*
 		 * Regulator register gets the regulator constraints and
@@ -1807,28 +1799,23 @@ static int bd718xx_probe(struct platform_device *pd=
ev)
 		    !rdev->constraints->boot_on)) {
 			err =3D regmap_update_bits(regmap, r->init.reg,
 						 r->init.mask, r->init.val);
-			if (err) {
-				dev_err(&pdev->dev,
+			if (err)
+				return dev_err_probe(&pdev->dev, err,
 					"Failed to take control for (%s)\n",
 					desc->name);
-				goto err;
-			}
 		}
 		for (j =3D 0; j < r->additional_init_amnt; j++) {
 			err =3D regmap_update_bits(regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
-			if (err) {
-				dev_err(&pdev->dev,
+			if (err)
+				return dev_err_probe(&pdev->dev, err,
 					"Buck (%s) initialization failed\n",
 					desc->name);
-				goto err;
-			}
 		}
 	}
=20
-err:
 	return err;
 }
=20
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

--+iqplJKpcdzleyKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN+C2YACgkQeFA3/03a
ocUWRgf/fEgNu7YYaMh5NmKk50Btq9kWI28dfnEKIa8PQAhJ6IePYvwfwAP7p4Ke
mr+XktaBV0CQi2e4yENTKuZMk1XKGY4mHuO7rdMNYrbR6EqWmia0ijZwai4FAi9Q
2Iga1IYdAHtuU5RX4yuFr8E8r7ZzppxBU4RjslIMt7MB8/kl/xqSdJWaSVLs0oLb
CQ4bftM8X5LHsRoQ3swbJIRQVBt3FsZEokDARIgaUSogykSd8SoOCY9/usThzH6Q
004f5ugNtR5XwwYyXvkDOJo4DRgcA8i3yrTZ/YpVLJMZwEBVkagnlZ18NnZqXpn6
tjyl8BWn58Gthij524kFUh71QlhkaA==
=47Ei
-----END PGP SIGNATURE-----

--+iqplJKpcdzleyKU--
