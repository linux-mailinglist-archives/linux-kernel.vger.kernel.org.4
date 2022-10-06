Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94085F69B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiJFOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJFOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:37:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9328321A;
        Thu,  6 Oct 2022 07:37:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a29so3039135lfo.1;
        Thu, 06 Oct 2022 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=00zNPjSV0NBnL/fqot4cVHiAuUteLJu0Hqble2AqPlI=;
        b=jLkxnaE6g2QlVfw6r4SfnRsGhqANVLQCmbqVqAPddbzc2Hlt6vumlPhAwOUTFRAYs9
         d/KNkdWYMbp3SCC545Q7PKeHBlOva9VHeiqBqhKaj/jcCSRnMXB3mZDDWHY2wnuwF2VV
         9fcWy6y2YU08w3rVhwz3xeO9T8CGSToNhEIQalwMjNy64BrAb6mDOcXgAWK/HIV8On1T
         eK3st/VoChGvUE3qlTL5tfrT5ePveGYZ8AEjiaZFkYfdLnG5WGBDJxxTIx6FBNMK4268
         6pfVhNEZJG1tc/8l2dl0M/F+l3JjUiJZUEzyRuITdriiM21mX+mQ+Y3qYMxM/DYwBWAo
         BBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=00zNPjSV0NBnL/fqot4cVHiAuUteLJu0Hqble2AqPlI=;
        b=Wrwoum/GQhH1AVMDPB2FOYgOuLSSSqOlQh8nhxmLZRVwovPae5WUBu9LsDpe3Uk0LW
         LO6TGj3RxZIeOCdy60S6sFSmsOVctgimkTiaiTwqiowb03ixENb3BbU+FsdHE8qtjc8Y
         hbyxL5zKjJrG3itnjoGzC2Ccq5dNOOgg7erLrgUkAoNQy01VSRexXQlW3XZP1Jqla5qg
         +oOWvxeXl2i6ciYStqZfGycdQqkWcosFww6YunlEdQG64csuEif8moikdP/eaYTQ1OOZ
         i2A80HF+Dw1MKQvq79RyYSfpewRBw6fY/OiGH1oQLNjlyBkEjFPldLjYmAA4mHqNkuMI
         /Dsw==
X-Gm-Message-State: ACrzQf2BONKnkwxMqEv5jWQdEe4JIdnT7zvKo+LALd/9tYsrtY68xi4V
        p/zU07lo4cibD1a99Ic8M0c=
X-Google-Smtp-Source: AMsMyM4ar/eKhA4YXpbfMC3LzHoOECJ4YMFrhXTEqAwQpgNZ3C3rSJftHJk85dr/oOKd4qPibTs4Zg==
X-Received: by 2002:a19:9202:0:b0:49d:7310:742f with SMTP id u2-20020a199202000000b0049d7310742fmr115161lfd.312.1665067020638;
        Thu, 06 Oct 2022 07:37:00 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h4-20020a05651c124400b0026be1de1500sm1925140ljh.79.2022.10.06.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:36:59 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:36:52 +0300
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
Subject: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and enable
Message-ID: <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/g10kuR76MIgIRry"
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


--/g10kuR76MIgIRry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few regulator consumer drivers seem to be just getting a regulator,
enabling it and registering a devm-action to disable the regulator at
the driver detach and then forget about it.

We can simplify this a bit by adding a devm-helper for this pattern.
Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
(cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)

---

Already in Mark's regulator tree. Not to be merged. Included just for
the sake of the completeness. Will be dropped when series is rebased on
top of the 6.1-rc1
---
 drivers/regulator/devres.c         | 59 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 13 +++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 32823a87fd40..3cb3eb49ad8a 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -70,6 +70,65 @@ struct regulator *devm_regulator_get_exclusive(struct de=
vice *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_exclusive);
=20
+static void regulator_action_disable(void *d)
+{
+	struct regulator *r =3D (struct regulator *)d;
+
+	regulator_disable(r);
+}
+
+static int _devm_regulator_get_enable(struct device *dev, const char *id,
+				      int get_type)
+{
+	struct regulator *r;
+	int ret;
+
+	r =3D _devm_regulator_get(dev, id, get_type);
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	ret =3D regulator_enable(r);
+	if (!ret)
+		ret =3D devm_add_action_or_reset(dev, &regulator_action_disable, r);
+
+	if (ret)
+		devm_regulator_put(r);
+
+	return ret;
+}
+
+/**
+ * devm_regulator_get_enable_optional - Resource managed regulator get and=
 enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on dri=
ver
+ * detach. See regulator_get_optional() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable_optional(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable(dev, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable_optional);
+
+/**
+ * devm_regulator_get_enable - Resource managed regulator get and enable
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on dri=
ver
+ * detach. See regulator_get() and regulator_enable() for more
+ * information.
+ */
+int devm_regulator_get_enable(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable(dev, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable);
+
 /**
  * devm_regulator_get_optional - Resource managed regulator_get_optional()
  * @dev: device to supply
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/c=
onsumer.h
index bc6cda706d1f..8e6cf65851b0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -207,6 +207,8 @@ struct regulator *__must_check regulator_get_optional(s=
truct device *dev,
 						      const char *id);
 struct regulator *__must_check devm_regulator_get_optional(struct device *=
dev,
 							   const char *id);
+int devm_regulator_get_enable(struct device *dev, const char *id);
+int devm_regulator_get_enable_optional(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
=20
@@ -354,6 +356,17 @@ devm_regulator_get_exclusive(struct device *dev, const=
 char *id)
 	return ERR_PTR(-ENODEV);
 }
=20
+static inline int devm_regulator_get_enable(struct device *dev, const char=
 *id)
+{
+	return -ENODEV;
+}
+
+static inline int devm_regulator_get_enable_optional(struct device *dev,
+						     const char *id)
+{
+	return -ENODEV;
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
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

--/g10kuR76MIgIRry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+6AQACgkQeFA3/03a
ocVd2QgAzMXs4723DPOcSmcxc+ndzLBrklRylOVkRmrrybLlgCCNZZvWBJu0AyFj
nPejGuGhRkMcYhmrigTuFuEGpkGf5P5U0L8/UyDzjicEtX6CxyGRn9asooFzyFL7
9CxJlIoAoi2gEVlQ8++SwPxjkxz1ZPR8MR3YsX+W0ECC90tPti0I2Cwym3ue1JVM
2FF6DcWG7J4jyWO+9MbQZrmS1sZBu7IM9BjS5DnzOY0akYQejmXPfgzVZoE7q7+F
xBXEj2vX6eB+zw/uAvIm7hIZfll/XDMk7lWq4oU+ui8MXp/gr5LZL0mxHQ/U+W+s
d0Lsop/UlvLMXZ+uudXW8MeQsavTnA==
=YEA1
-----END PGP SIGNATURE-----

--/g10kuR76MIgIRry--
