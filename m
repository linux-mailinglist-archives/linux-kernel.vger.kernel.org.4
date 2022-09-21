Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323D75BFD13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIULmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIULml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:42:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CB8E98B;
        Wed, 21 Sep 2022 04:42:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b6so6616654ljr.10;
        Wed, 21 Sep 2022 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C/v5U/CH8UoPmKrRTrmN93JfcftB0DZK+X0SeEjsOJU=;
        b=FjDC6VC8Vfr90AsitmdUCUriNQqGtcpcGGsZoZGswt0qn0vL0jsTE8qbiZ6+AAZfzt
         Ig0fb3QcylFmXP4i5zhQrzwQmldDocnymgCwpMbSMLRZd0rNUBpOjDya4ihrYS6AHhIl
         f5o2YJ6lvnGFDDPDVLZq93/Fpo4boQ0TgSafx+4p+4LFpz136bTixndvOx1CdA3HLYt8
         DYoYmWuu+yHa2Ok38oFwEA+LWKWJfbv2sJuLudWqK6EyezFjMcu2NlR3fBUW578wIoB/
         Cb6vNYC8otbyKT3aduEYSFx2xVqXqBY0n0oupDNriteXdVSM8CDXFJR+p8FdqVyYXois
         2GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C/v5U/CH8UoPmKrRTrmN93JfcftB0DZK+X0SeEjsOJU=;
        b=rNuN9cGYH9U7k8K3cSTmVq1huUcJi+kSrvkuMCtAphgWbHZGumj3TPuD7nYbeljfQx
         mzn87vCDNP97m9Lj9+qT1sHrJUfOVVkGlWSWZuykrYN2KTe9CYuktlaRNFTQeKf3lc0b
         peq++7nn9Myydhjg+yKPzhcq0P7WW4TqWvrsLJXnVkbZKm5srSHjSAMZ1+PxCbiS7ah/
         00rCkjg6g/xtmv95stoprvzD5hhvGEF2Gci+UK9KOeStAqUvWzWaKACLyJhFDIrrIjHJ
         4zp2mj9zIY93kP3I7uwCb2l8XELAMRZWnIKEmjx6W8fosXK9qKBrmQ1o5E4/gV+HryoX
         b9uw==
X-Gm-Message-State: ACrzQf3H/d2eXaKjfVDNBWUHJOH7Pc40VyyT+4PE23B9T4iCxAJXqTXR
        9qMmlLERXc383T8ZA3TTTnI=
X-Google-Smtp-Source: AMsMyM4duOwh8VtqRs8Ei1L3d8dgW9TrrSDI7hgpG5kVPEO9AfhhZs6bmPrRry9pFQMa4jai5zxneg==
X-Received: by 2002:a2e:924e:0:b0:26c:5dbc:2d80 with SMTP id v14-20020a2e924e000000b0026c5dbc2d80mr2498293ljg.290.1663760558152;
        Wed, 21 Sep 2022 04:42:38 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q14-20020ac2528e000000b0049480c69d98sm386790lfm.239.2022.09.21.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:42:37 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:42:29 +0300
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
Subject: [RFC PATCH 1/5] regulator: Add devm helpers for get and enable
Message-ID: <cdc5151fb551accb8b0e3ab11bfd93df051606d2.1663760018.git.mazziesaccount@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WG2BA4DezQcfEiTc"
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


--WG2BA4DezQcfEiTc
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

Please note - this patch is already in Mark's tree. It's here just to
allow compilation of the series on top of v6.0-rc4

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

--WG2BA4DezQcfEiTc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmMq+KUACgkQeFA3/03a
ocV0BAf/Y8762HwibCYMTHCX3U2ZbIEvJreF8qLtUc5ai94BnZ7bMVkb1/3pUNT1
pwx4uLyH7l0V1HQPZzDLtZS+jw41UlV5I8qKekScV+ojZcHxcYB/640lhnRMD2VL
CnrpuSfi4aEN1Y1lkmDXSusZ1CJah6JawRkohoBtFnJ/pDFQISlqR5B/znJC5rW2
kp4NtQXVewoV+sJUNR4ca3RJu2zGsVShRxXRN3dRgEWWoZPB5dL4XSzZNzNpbidY
elFk4xjDqzS5+1TLLoK60GzLyod5zceDvlgDAs6XqG7My6gxpnlHs0Mb/nOvncrP
GhlwGhSco8CdBSiY6WQufiz9QFvbKw==
=u3OX
-----END PGP SIGNATURE-----

--WG2BA4DezQcfEiTc--
