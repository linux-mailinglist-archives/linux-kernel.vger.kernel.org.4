Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6845F69B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiJFOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJFOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:37:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79983F19;
        Thu,  6 Oct 2022 07:37:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f37so2993362lfv.8;
        Thu, 06 Oct 2022 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TIOQsYCwUfvmYBpnckXs7J461Nfe7jNypQ8rjuxui5M=;
        b=UoOejhVb8uhTDW4mIIC6+sC9g9rgk8Ejo2ExD/mTw8tLBlk0QwgT7FkBe0F2W1Nu6P
         RuCkElQO/d1dBdWp13c3VtBT0kcLkWysZjhSUgcSUh54uV2ODwPvWWbFDnN3lP34BN33
         9pFrTQ50vxXqozR9T2K7SwEnNHDY0Vul5kgWiUs5yALvYDL+PJKF8SjOaRmeCHhzJZlJ
         BIwUfel++pEr1+2+YpbVvJlChpmcpruT+18cdtkAujjH9rrZ/+NpqUuc20s7WK5Iklbg
         SIXUAZdjLSfkTFgQduy46dB/AHVdRGFHmHIc+8AgSJ6HzhYEPxCvpa4uGyRlhHdejOgA
         RrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TIOQsYCwUfvmYBpnckXs7J461Nfe7jNypQ8rjuxui5M=;
        b=Dzxavq1WSnYPy87ocf14AT+P0zHp4N7LpWGryPyTtGQ4m4rf5OC67Z7yOCNqvAz0wd
         GVHcJH8z00WFxSaHxPehJxARmDnObWfEdNv0MORMeJzLyA+uyzv7s6+EGHaWJ18CQmyx
         xzohrPcOUYQV1CAZyBgk8MDVAJQjFSssTSsav5xhaoxYQiaBxgZtaKik2R+WIDqkz8wa
         za3f4PjegZWVKE2jIUBx7Y27q2PUameYZeF/WMWEw2dDmtSa8xunJT4EUILG7af9cH4z
         z813zheiet29B8F0WK9V8OYc6A7b+Mt5cZDuHRlGLM2mJ5p+tKV44V6gPmM5LEbA40TK
         AkZw==
X-Gm-Message-State: ACrzQf14+2zGmVh9cdC2XpJTtFElILJKOKfjbclzcjrKGSAKWaQHoMOD
        027z1dChz7dul4OJ7z04sHQ=
X-Google-Smtp-Source: AMsMyM68nVJo1+16nF5jOCHFbbaBlMhSus02odyFoAUULTd4wWsn3gXhAfBwB1ceKOQnEsd60Q513A==
X-Received: by 2002:ac2:4acf:0:b0:4a2:6c60:935 with SMTP id m15-20020ac24acf000000b004a26c600935mr91402lfp.397.1665067040824;
        Thu, 06 Oct 2022 07:37:20 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512231400b0049f9c732858sm2713975lfu.254.2022.10.06.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:37:20 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:37:14 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/5] regulator: Add devm helpers for get and enable
Message-ID: <a80bd095506411dae86760f307725b9ecddd9426.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Epbr6MBHrwzV0do7"
Content-Disposition: inline
In-Reply-To: <cover.1665066397.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Epbr6MBHrwzV0do7
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
Already in Mark's regulator tree. Not to be merged. Included just for
the sake of the completeness. Will be dropped when series is rebased on
top of the 6.1-rc1
---
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

--Epbr6MBHrwzV0do7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+6BoACgkQeFA3/03a
ocWYzgf/dGa7CvdE9jSXZIvYxGfPY+lUorBXYaygwOAayKb23L9nDPl9rc83oGur
8cPl6uZFKAnQ34NLwV89w336Vd+ONvdc31QD0fUJ9gzKCyjOVUGugQF8G8arTTbM
RXtsOZqN27W+j+u5RPX/AWoHp+/LfN7Snkr4q15RfHM3lYWBwKVAQ2dncGyVsELu
Kdb+CvVSABZOZ4CqI+i4Q1lIlLSoC11MisxKMCjm27Is+3O9iOucJgGcn00xPu1i
JrWfwxPYjpg1sjWPlDNPwTO4CznEU4gjR/DfTvZ4er0DrMO2KwQhvJLeoSQXbD1E
QNsZ/Qvkzpd1lIxJn8u8to/+FtdlHQ==
=QLwe
-----END PGP SIGNATURE-----

--Epbr6MBHrwzV0do7--
