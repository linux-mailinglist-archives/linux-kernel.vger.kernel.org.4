Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0763D1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiK3JXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiK3JXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:23:12 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A02F3A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:23:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l8so20155216ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGai96t0pVD49z2Oe24kTckJ4TAh6OnuSc06LTgbBHs=;
        b=go472kIN5B1Uc+NA0wAic0hCbPCGr8DEEK4Ux8xipfXkD91wky5WY40pHPX1jcHOI5
         JhBAR8KL+7g1Q5ubS7962T/ToIxdQA9IZoFbZknAOflR3Mm6ojHloqIGWj4FTEBLkIdt
         p47glaUsIVE69a/LkSVoX2BZ6IlIQICilLCIP1p61fedXPHQP8u4UK0+J7AcuXsP4kbB
         msDLcrBd+bY/I1IOMpPpO0C3sM2YKO2GwqzJ7bkaBUEfFo4rsIq5aU4/eBh94ip1fiOR
         /NiCJFfXEE1uS6WJf2oi3KxHZ+p9jU4B/t9g2NIW0kLQAUKAir2ezlU1w9DvKsAhuGFr
         C9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGai96t0pVD49z2Oe24kTckJ4TAh6OnuSc06LTgbBHs=;
        b=sORXzGNSVeBjfWjn0QwHF2F/mQeRYVfTt67+7zz7qaR4OYE/hKUp1V97TwcjEzEgK/
         en7TqcrSNAUjt11nTf7Cq2qv7R/BCwDA/JaY4RBol+KWKQ1GwFQXOQw+FOJ5LnNOryxM
         UtGZEFgqoONdD0EvVFH51KTp0KHai/9M3s8ydcy8UcRmbuXiBL4lZ6VUaMP4oiA09GZT
         kopTqI1rHgdBxdvIF5NETv+XATAdXxFDjLXZLH7GUoTnEjQD8V8PQnu9FlGxObwdWHvm
         0OKIBjNZTwfcKdHu/oQxOyqQE8HNtupzU4CFCrXIfVKUUZignb23B4/WDhzbiZGaB601
         VYFA==
X-Gm-Message-State: ANoB5plIxBZovSQZaPo56MDTtRYSVfL64nZIjaBV9Fvk0DyFgKLCIwmF
        oeltcGaBeNQHRJ8mqIaW0Sg=
X-Google-Smtp-Source: AA0mqf6QzfIZXii01B5TmgIaVGOx8hXf2IofQ7Fvz/NTck20aLOkGH6AnMjK33uAlAASv3csnyEC7Q==
X-Received: by 2002:a2e:8750:0:b0:279:9466:9355 with SMTP id q16-20020a2e8750000000b0027994669355mr7804106ljj.253.1669800185798;
        Wed, 30 Nov 2022 01:23:05 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b0049a4862966fsm182793lfk.146.2022.11.30.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:23:04 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:23:00 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND2 v4 2/2] drm/meson: dw-hdmi: Use
 devm_regulator_*get_enable*()
Message-ID: <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
References: <cover.1669799805.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+FpHG9ThwonLOArJ"
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


--+FpHG9ThwonLOArJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify using the devm_regulator_get_enable_optional(). Also drop the
now unused struct member 'hdmi_supply'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Martin Blumenstingl <martin.blumenstingl@googlemail.com>

---
v4 resend 2:
Respinning unchanged code with the commit title changed as wa suggested
by Robert Foss and commit message changed as was suggested by Martin.

I am doing a clean-up for my local git and encountered this one.
Respinning as it seems this one fell through the cracks.
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/=
meson_dw_hdmi.c
index 5cd2b2ebbbd3..7642f740272b 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -140,7 +140,6 @@ struct meson_dw_hdmi {
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
-	struct regulator *hdmi_supply;
 	u32 irq_stat;
 	struct dw_hdmi *hdmi;
 	struct drm_bridge *bridge;
@@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *m=
eson_dw_hdmi)
=20
 }
=20
-static void meson_disable_regulator(void *data)
-{
-	regulator_disable(data);
-}
-
 static void meson_disable_clk(void *data)
 {
 	clk_disable_unprepare(data);
@@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, stru=
ct device *master,
 	meson_dw_hdmi->data =3D match;
 	dw_plat_data =3D &meson_dw_hdmi->dw_plat_data;
=20
-	meson_dw_hdmi->hdmi_supply =3D devm_regulator_get_optional(dev, "hdmi");
-	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
-		if (PTR_ERR(meson_dw_hdmi->hdmi_supply) =3D=3D -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		meson_dw_hdmi->hdmi_supply =3D NULL;
-	} else {
-		ret =3D regulator_enable(meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-		ret =3D devm_add_action_or_reset(dev, meson_disable_regulator,
-					       meson_dw_hdmi->hdmi_supply);
-		if (ret)
-			return ret;
-	}
+	ret =3D devm_regulator_get_enable_optional(dev, "hdmi");
+	if (ret !=3D -ENODEV)
+		return ret;
=20
 	meson_dw_hdmi->hdmitx_apb =3D devm_reset_control_get_exclusive(dev,
 						"hdmitx_apb");
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

--+FpHG9ThwonLOArJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmOHIPMACgkQeFA3/03a
ocWCtwf/SqqXk1TmF3RIampIzoVrQFshZ9dfdQ6qZa4jPxhDGGo8ciDcfn5T85on
kokvVj+hJXDVO4y7RdOCkAHgrpsfpkeP/D0lpuweheJI4D+vQamC7w4IXawx+A1R
4/ep6+L1m/e9IvNDN5wjzonI0tHiiLk/9hevkphEa6ub4+SQJth/D8Lki+MthGn5
7WZlwzG9uZe2dfZBCZf/AlimWeiZffPO4MpG5qDWoX8Ww5c0522DTk9Ve5uDXGzY
B5mi24ZGT7drjnC+tma7tIC11wnFSzm5146qoGIdLN4WM4D9kYFjzNooDHGcGIvG
too31/Cs5RBF1g4dMEGRL1lbeuTMcw==
=cZNk
-----END PGP SIGNATURE-----

--+FpHG9ThwonLOArJ--
