Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5763D1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiK3JXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiK3JWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:22:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229A1C112
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:22:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so25998200lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGvCkJhsGrDGRU0up7It8RIrU+VkoFlEUPGl7kmXIeY=;
        b=k5W5TLxgDf03r77V1DcSG6YijxnMLnxYltQfx+OsR20+7qR3PeKhho0lzcFr5Fi2ti
         p+fivdkeVMxwYNqIWmTeFAWpbyq3K6H+QJoBmPRpFpt/weblVJPopeqMjfjGN8kQIR7a
         vY8FfqpoOJdHmQFglX9SFgUyX+GI7G3Hgazc1dtpq35cEnho9aAl6r06naUDxamMZU0l
         Q0Rk7KuCcrDVZSw1gV36clFKsvP/LSigKy3jX6Gk1IUPw58pbCJwALGAeIz71BJ2L1Qe
         dpnT8RlL4aQWxhtXj7tZ/eHlRvO0TB8jLEhu4QoJjL4c9phbDoib8ndFpxd+strTPEea
         LPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGvCkJhsGrDGRU0up7It8RIrU+VkoFlEUPGl7kmXIeY=;
        b=AQuQlqBt83Uzm8H6R7lCjS0wpzbE+/lklMhI1uV8/DRe+Qfo4/wCtDKzn6lhmB/0pS
         6AlY0WRTzvDPLQk8Lnu5trH3QnOEyerMiYFT3Kdw9DYcjKcLO+Db/MsFJ2aliseamuDj
         swjY+03CCjp1FaQLOJBbXEXFcFlxqB1+PNV+3d///QsnhgLKyiDuwEocKANPUgmW63Kx
         TOjxh6qX22qokMNCuyCrMdccS4pSWspzeDSKf+X5v5+nSi6+5YvD7KjKKo2Z+UO62Qo0
         IHjVB5kei2tdh1DuDSaXkCrdD4HEvFYsAbaC9Na6Krxoj2351jFLtEPc+26h1c/mt91v
         FFtw==
X-Gm-Message-State: ANoB5pn5ln23h1LgboOlm0c7rNsOMraU03oOXDidQUOSMnFODr5e0iNN
        sJwtzBrCqUpdu5lYoR9pg+s=
X-Google-Smtp-Source: AA0mqf4yUCD0eY3oDTEWgWnd0jkf0QxzE3/0IccZ6qurtSOamh1gTq4uw3/MtvUj9lsXUcCx73SzPg==
X-Received: by 2002:a05:6512:13a5:b0:4ad:70f0:c7c with SMTP id p37-20020a05651213a500b004ad70f00c7cmr18753760lfa.190.1669800162970;
        Wed, 30 Nov 2022 01:22:42 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f06000000b00498fbec3f8asm186189lfq.129.2022.11.30.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:22:42 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:22:37 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND2 v4 1/2] drm/bridge: sii902x: Use
 devm_regulator_bulk_get_enable()
Message-ID: <e6153c7beb2076b9ea13082b2024ec3296bc08bc.1669799805.git.mazziesaccount@gmail.com>
References: <cover.1669799805.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kYoVLQBN7jlVRhX/"
Content-Disposition: inline
In-Reply-To: <cover.1669799805.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kYoVLQBN7jlVRhX/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify using devm_regulator_bulk_get_enable()

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Robert Foss <robert.foss@linaro.org>

---
v4 resend 2:
Resending unchanged code  with commit title prefix adjusted as suggested
by Robert

I am doing a clean-up for my local git and encountered this one.
Respinning as it seems this one fell through the cracks.
---
 drivers/gpu/drm/bridge/sii902x.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii9=
02x.c
index 878fb7d3732b..f6e8b401069b 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -171,7 +171,6 @@ struct sii902x {
 	struct drm_connector connector;
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
-	struct regulator_bulk_data supplies[2];
 	bool sink_is_hdmi;
 	/*
 	 * Mutex protects audio and video functions from interfering
@@ -1072,6 +1071,7 @@ static int sii902x_probe(struct i2c_client *client,
 	struct device *dev =3D &client->dev;
 	struct device_node *endpoint;
 	struct sii902x *sii902x;
+	static const char * const supplies[] =3D {"iovcc", "cvcc12"};
 	int ret;
=20
 	ret =3D i2c_check_functionality(client->adapter,
@@ -1122,27 +1122,11 @@ static int sii902x_probe(struct i2c_client *client,
=20
 	mutex_init(&sii902x->mutex);
=20
-	sii902x->supplies[0].supply =3D "iovcc";
-	sii902x->supplies[1].supply =3D "cvcc12";
-	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
-				      sii902x->supplies);
+	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplie=
s);
 	if (ret < 0)
-		return ret;
-
-	ret =3D regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
-				    sii902x->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable supplies");
-		return ret;
-	}
+		return dev_err_probe(dev, ret, "Failed to enable supplies");
=20
-	ret =3D sii902x_init(sii902x);
-	if (ret < 0) {
-		regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
-				       sii902x->supplies);
-	}
-
-	return ret;
+	return sii902x_init(sii902x);
 }
=20
 static void sii902x_remove(struct i2c_client *client)
@@ -1152,8 +1136,6 @@ static void sii902x_remove(struct i2c_client *client)
=20
 	i2c_mux_del_adapters(sii902x->i2cmux);
 	drm_bridge_remove(&sii902x->bridge);
-	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
-			       sii902x->supplies);
 }
=20
 static const struct of_device_id sii902x_dt_ids[] =3D {
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

--kYoVLQBN7jlVRhX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmOHIN0ACgkQeFA3/03a
ocXt3Af+NBbbybBiC/fT+7c3dEowQsdOb3b3yvhY2tN/4V4tTz6es4KCLfCsSDEy
H/BBqUFHCJ2ocgaOAybbpFKjBdm/K7vjoZWJo7EGvNPaY1BxETbcE+PdadGHTlsJ
TumNxh/jE4yAwIjGHQXum1XHL14LFhkSQiOPNo7uE/9xsSPtKMhWXTffoKum4oJ4
vN12chwj3UUBfgtlhATNHyCwkB8+2WY708tp4yL9lEQ9aU+s0euqdb5+vtBojghd
fuwOFipon6SJ1u5iwAUFvYZZezecr+JBEtiUgVXKEamW9ALaxdCoZKD16/Kgoqmn
X7Gxe3riJJ71fmvVZDSrHkOjsfclXQ==
=umTN
-----END PGP SIGNATURE-----

--kYoVLQBN7jlVRhX/--
