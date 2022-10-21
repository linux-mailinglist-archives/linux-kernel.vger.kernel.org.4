Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA114607835
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJUNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJUNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:19:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCB270236;
        Fri, 21 Oct 2022 06:18:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a25so3744635ljk.0;
        Fri, 21 Oct 2022 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRkhXHMl4TQ/DqaAGRL8GCynFjjb+3hTJyL1LA0fGPI=;
        b=WgobnPDdXrxxYqHttfwgpj1q5gAY72WGanvgflFsMOySjkHmZ4ZH4p7AB0RtJyA3KR
         LAQJzEZ7NujWLO07huI2EltfmcuGTsWpKfAxegLQF6ITGT5ldA3qdzhI3F4kFUq4yVGw
         zaIz7sxHn5cE8lamSLUKUO0ZVDZZNZAIVmGSTwuP4f8oGB8ATSsPMkGX2VDO/4i5MZNi
         bPGdh+ZVAvIhLxkO1TLvj50dkUl/1NOl0SeeLJjHwicmqljgCcVMVsjgf6Lg53kjC09m
         dNUk9rCAkhIQhKjM82dlPBTIwqx7IB9jFo3fTAy7E717X6RDH/DQOgQqpIuQ5070bUD0
         Z6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRkhXHMl4TQ/DqaAGRL8GCynFjjb+3hTJyL1LA0fGPI=;
        b=wAMVbd/DgFo3RgrZSCoGdGawxZiKoRWQCnL40dL69xlc/VgApLI5wF9yiXrkPWwBwg
         as2wNoE/oeCPRb5ij4V8tQNk9lKvA9BaJaS8R283zQSZeCuWgdDJX93Hz7zlkuOxFuh0
         U8Nv9mdJjp9vI8ZmUTVAGFBhEC4sGFz4AN2Tsv1YA6LJzY197aGbrFyRPsgAZoBceXld
         XxhQUsAe+ORiv8hODTbS8SaEQwe9os0YjH/YhjxmjYzb7P3BpOByjWEOhim2vBklJLsy
         DuowOAtPnO4gj9Y6+wm9ZpoJ/puQVcdH5Qdi7YupRmPKHCC4Ns8ja5ldCCTENpvLQ+nZ
         vg2w==
X-Gm-Message-State: ACrzQf2j36vyJRynPQtky/JV2sHtFKt0b3y9hVb/3pq9I/GWW5DvPTrc
        aX8liCgpGx9/6tF8XAQ+f14=
X-Google-Smtp-Source: AMsMyM5ZI9LOvAWowEwE1BQiARts/ZjcHuWX/l3x5n+ReleYNXhDm3X/s5vQQklCiZ0l7SohVfPGEA==
X-Received: by 2002:a2e:a7d0:0:b0:26f:d241:483b with SMTP id x16-20020a2ea7d0000000b0026fd241483bmr6279663ljp.426.1666358328736;
        Fri, 21 Oct 2022 06:18:48 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f49000000b0049944ab6895sm3150402lfz.260.2022.10.21.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:18:47 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:18:43 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 3/4] hwmon: lm90: simplify using
 devm_regulator_get_enable()
Message-ID: <a1fa4364cbb775de25478117dd22dda0742089e3.1666357434.git.mazziesaccount@gmail.com>
References: <cover.1666357434.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M3g96xv3Iy/Ir190"
Content-Disposition: inline
In-Reply-To: <cover.1666357434.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M3g96xv3Iy/Ir190
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---
RFCv1 =3D> v2:
- No changes
---
 drivers/hwmon/lm90.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index db595f7d01f8..a3f95ba00dbf 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2663,11 +2663,6 @@ static void lm90_remove_pec(void *dev)
 	device_remove_file(dev, &dev_attr_pec);
 }
=20
-static void lm90_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int lm90_probe_channel_from_dt(struct i2c_client *client,
 				      struct device_node *child,
 				      struct lm90_data *data)
@@ -2749,24 +2744,13 @@ static int lm90_probe(struct i2c_client *client)
 	struct device *dev =3D &client->dev;
 	struct i2c_adapter *adapter =3D client->adapter;
 	struct hwmon_channel_info *info;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct lm90_data *data;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, "vcc");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err < 0) {
-		dev_err(dev, "Failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm90_regulator_disable, regulator);
+	err =3D devm_regulator_get_enable(dev, "vcc");
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
=20
 	data =3D devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
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

--M3g96xv3Iy/Ir190
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNSnDMACgkQeFA3/03a
ocWlJQf/f4PSr4V2vI2p2GUquvO7G7G/Ap8fvDhLsezltYKOvhysBmxyc5W6uOE7
A7UDzafqeVb2ZRqrHDe3b348v/vZ2nUN37wDIQVQiLFYeVUWJtYQY0AIt3MAYSgh
/6pYUFjsOhPk4zgrplh2O07iDM7V0h09ovKA/aQ4KtsOgKoi+zmhD7ka4YhwSoaf
4MEQG4S4pGi5/tJlHG87zH7/+LESzo1g3s2GH5bZOolQQGfahwA+hP7ztnQ/4E0R
WnPt+SydxPSAGI0A6ImdFCAemC8LkfsmDOfPbV7aVQonl/Pm+PYxKEC0auspopMv
EARJfxX8SY6Civ722e+t7twiVR0REg==
=bf9B
-----END PGP SIGNATURE-----

--M3g96xv3Iy/Ir190--
