Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876F5BFD17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIULoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIULn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:43:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746C901A9;
        Wed, 21 Sep 2022 04:43:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so8835573lfu.0;
        Wed, 21 Sep 2022 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nYLJNjXG8obWRA4UkgeigyjnB3GICD0oi50GKkfipRA=;
        b=gw2EksPevUhToB1Hp9odD6rDpnl5vToFCK4nV/Rjs+qZyVKxJCMfippRWva9eatKAB
         TQy0LkENf1UE5HKKNloOmx9a/FkiaZYRPa3dxpZPEnbp05elQ1oL8PlD8p85IXt23e7W
         aHYDrLp3wDechKe74JPvheXL7jez5w9EyBoD1+EQDyBo2OwZy6SAFLuKnzAK/9C5reAz
         3sIKi+z8izQhFI8FM5kupq0/UwH9/uhifdvgbDDTBu3xuWBgb7tXe62Fbu0mXBezTpIt
         dd15j5CkUkV3Y0aegVF0FrvYcu1FSxKaB0ixy9g0lclagRjqiLlb1ubI41aveC3bxO0H
         ddxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nYLJNjXG8obWRA4UkgeigyjnB3GICD0oi50GKkfipRA=;
        b=43UU8D4QfJbYFiHApIpUnqaKk9IVl+Q2cy+xGedZW/toTI8RsoMbdqBaUquEXldgbT
         OA2DfG7veON+uulLKkTiuhdF63Ag9mpU5xnywdsIiAKboRwQ4Ln3fwLowM7q1R9lidZp
         OclG860mQfiYJ/S5cDL8SeTIrcTXReSH+mnoZVRet73EA49nN03tEim9zAz5JYE25UhH
         NKZhyJUiCf3VezsiCdzyisG/CQZLjPHq3F1Nx8SCXmj1AcIJmwQwoaAvF4CDkIyxDwez
         +A9CCf4HN7lZr60oybfwXrckaMN/ilNecql+bmU6N9ERfToboSe/3/sva1vaXQUZ0QTO
         mI/g==
X-Gm-Message-State: ACrzQf29DXcBD6Q0EDjvc3ZFwd0zPaLW7ueYW0wG7I0kAPNDFWyPheLa
        e5PhTGrdn1B6cvCxw3qLfMg=
X-Google-Smtp-Source: AMsMyM7lFMQgCSqon4MHjcAjgGY1jmrE5V96sfsTMn1HNMP+atJv3Epu3t+kQI+3VDmj4/thEUe5eg==
X-Received: by 2002:ac2:4bc1:0:b0:49f:298f:8fed with SMTP id o1-20020ac24bc1000000b0049f298f8fedmr10543585lfq.212.1663760634831;
        Wed, 21 Sep 2022 04:43:54 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25fc4000000b0049936272173sm390247lfg.204.2022.09.21.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:43:53 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:43:49 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] regulator: Add devm helpers for get and enable
Message-ID: <41d2c0a9af344b7fa4eafe8d63e3c3458059fa84.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c9cYLLDh7413YUEu"
Content-Disposition: inline
In-Reply-To: <cover.1663760018.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c9cYLLDh7413YUEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few regulator consumer drivers seem to be just getting a regulator,
enabling it and registering a devm-action to disable the regulator at
the driver detach and then forget about it.

We can simplify this a bit by adding a devm-helper for this pattern.
Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://lore.kernel.org/r/ed7b8841193bb9749d426f3cb3b199c9460794cd.16=
60292316.git.mazziesaccount@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---

Please note - this patch is already in Mark's tree. It's here just to
allow compilation of the series on top of v6.0-rc4

 drivers/regulator/devres.c         | 105 +++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  14 ++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3cb3eb49ad8a..3265e75e97ab 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -253,6 +253,111 @@ int devm_regulator_bulk_get_const(struct device *dev,=
 int num_consumers,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_get_const);
=20
+static int devm_regulator_bulk_match(struct device *dev, void *res,
+				     void *data)
+{
+	struct regulator_bulk_devres *match =3D res;
+	struct regulator_bulk_data *target =3D data;
+
+	/*
+	 * We check the put uses same consumer list as the get did.
+	 * We _could_ scan all entries in consumer array and check the
+	 * regulators match but ATM I don't see the need. We can change this
+	 * later if needed.
+	 */
+	return match->consumers =3D=3D target;
+}
+
+/**
+ * devm_regulator_bulk_put - Resource managed regulator_bulk_put()
+ * @consumers: consumers to free
+ *
+ * Deallocate regulators allocated with devm_regulator_bulk_get(). Normally
+ * this function will not need to be called and the resource management
+ * code will ensure that the resource is freed.
+ */
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers)
+{
+	int rc;
+	struct regulator *regulator =3D consumers[0].consumer;
+
+	rc =3D devres_release(regulator->dev, devm_regulator_bulk_release,
+			    devm_regulator_bulk_match, consumers);
+	if (rc !=3D 0)
+		WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_put);
+
+static void devm_regulator_bulk_disable(void *res)
+{
+	struct regulator_bulk_devres *devres =3D res;
+	int i;
+
+	for (i =3D 0; i < devres->num_consumers; i++)
+		regulator_disable(devres->consumers[i].consumer);
+}
+
+/**
+ * devm_regulator_bulk_get_enable - managed get'n enable multiple regulato=
rs
+ *
+ * @dev:           device to supply
+ * @num_consumers: number of consumers to register
+ * @id:            list of supply names or regulator IDs
+ *
+ * @return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation with management, the regulators will
+ * automatically be freed when the device is unbound.  If any of the
+ * regulators cannot be acquired then any regulators that were
+ * allocated will be freed before returning to the caller.
+ */
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
+				   const char * const *id)
+{
+	struct regulator_bulk_devres *devres;
+	struct regulator_bulk_data *consumers;
+	int i, ret;
+
+	devres =3D devm_kmalloc(dev, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	devres->consumers =3D devm_kcalloc(dev, num_consumers, sizeof(*consumers),
+					 GFP_KERNEL);
+	consumers =3D devres->consumers;
+	if (!consumers)
+		return -ENOMEM;
+
+	devres->num_consumers =3D num_consumers;
+
+	for (i =3D 0; i < num_consumers; i++)
+		consumers[i].supply =3D id[i];
+
+	ret =3D devm_regulator_bulk_get(dev, num_consumers, consumers);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < num_consumers; i++) {
+		ret =3D regulator_enable(consumers[i].consumer);
+		if (ret)
+			goto unwind;
+	}
+
+	ret =3D devm_add_action(dev, devm_regulator_bulk_disable, devres);
+	if (!ret)
+		return 0;
+
+unwind:
+	while (--i >=3D 0)
+		regulator_disable(consumers[i].consumer);
+
+	devm_regulator_bulk_put(consumers);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_regulator_bulk_get_enable);
+
 static void devm_rdev_release(struct device *dev, void *res)
 {
 	regulator_unregister(*(struct regulator_dev **)res);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index 8e6cf65851b0..ee3b4a014611 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -246,12 +246,15 @@ int __must_check regulator_bulk_get(struct device *de=
v, int num_consumers,
 				    struct regulator_bulk_data *consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_consu=
mers,
 					 struct regulator_bulk_data *consumers);
+void devm_regulator_bulk_put(struct regulator_bulk_data *consumers);
 int __must_check devm_regulator_bulk_get_const(
 	struct device *dev, int num_consumers,
 	const struct regulator_bulk_data *in_consumers,
 	struct regulator_bulk_data **out_consumers);
 int __must_check regulator_bulk_enable(int num_consumers,
 				       struct regulator_bulk_data *consumers);
+int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
+				   const char * const *id);
 int regulator_bulk_disable(int num_consumers,
 			   struct regulator_bulk_data *consumers);
 int regulator_bulk_force_disable(int num_consumers,
@@ -388,6 +391,10 @@ static inline void devm_regulator_put(struct regulator=
 *regulator)
 {
 }
=20
+static inline void devm_regulator_bulk_put(struct regulator_bulk_data *con=
sumers)
+{
+}
+
 static inline int regulator_register_supply_alias(struct device *dev,
 						  const char *id,
 						  struct device *alias_dev,
@@ -478,6 +485,13 @@ static inline int regulator_bulk_enable(int num_consum=
ers,
 	return 0;
 }
=20
+static inline int devm_regulator_bulk_get_enable(struct device *dev,
+						 int num_consumers,
+						 const char * const *id)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_disable(int num_consumers,
 					 struct regulator_bulk_data *consumers)
 {
--=20
2.37.1


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

--c9cYLLDh7413YUEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+PUACgkQeFA3/03a
ocXxeQf+NWtmBeyanmurjUT/faHL5MUMTMTCOC6bF9uwt1+a8qR2l9SXixIqklBL
cZmtGyP61LV5xYX3h/PawShgoh64OUd3YvuodZLAHaOaAubWU9UlFvfS1+Rn0NBO
8teXvecUvqcHnHXmCDeshDMyNI5iI82EoR5abMO1fSKRoH0DEAjHaimRJI3IEr1p
4thAIcK95oFGyrb42nhaY9NKd2+2icG62v/iBjD5OdoSXruyF90scPAbPKti6c8D
mvQl75M4YkSAf9g6uLuXZm6dR1IZVybyc5t670N300jmxr9DmxIdwqP+fWxuTe1n
Vug+3JLgpVOGE7wFU+ZPXFw/wY0qLA==
=5d3D
-----END PGP SIGNATURE-----

--c9cYLLDh7413YUEu--
