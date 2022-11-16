Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF762BEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiKPNEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKPNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:04:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209F26DB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so29374654lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w2U0GiGwFFrflmNCFpCFLaMnMdqbHDas4my61VJ3H4=;
        b=KAgIfzEgdBLkeRinXDVjGiOgDz4zxSP/Q12JRlfv9kc3Z0v1GoUvkrvMdg61Aye5RF
         TzgwQMoR19i2nvfMfobkJVN2k2PS8K7zB7qRjke7MIHjC325iSFR6fcT1OZOg6XqS+6q
         4UbQn7/DqGiydfHGtx6F9lW/VEz0B5KI+bf5I3OniXwsnHcI/QxY4PLrgXhKLHFzJXGD
         OFtQbFrp+uvaLYFxXYJ6TAmoz78B1tV58ztVPwWKLQ+GV/B/qLrdt5GFNd1PAziSQmZH
         W1FBb8NEZYMss5dOJyo/D8lgckfchWPB1dn+MJOQH1vmqmCiIyJMuIzJGH/zsEL9HtRq
         9MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w2U0GiGwFFrflmNCFpCFLaMnMdqbHDas4my61VJ3H4=;
        b=FDGZl7nlpPBP1BDJ1dU5zDip4yV2aRkokQKmbpSVxBwpwg7efs27FkGgTbFn3EZnh1
         s0yzNzIaWwjzRbuPKWJsTuET90a/5/q/pfl04ObVfkkO+G3U3YkDqu34/6kYt8vOcDRW
         ZMVTr3BChFLuevixiYGEtb/iEgIftbInML7r3T5f73kuD1XJHZninJqHgJGCX3oPdnC/
         uzoxbGzK2HyFoZ3yezz/PSarekXTYWrJU8sn465umm9RpbvG5K8/C3FNXWUlhYd5hIO1
         BbABm+KJGTMpxUG1CBMjmONyduIDj4zUiEABkoBEbkbNRv5FTpLPsslWzl4oG+zAHatT
         ax2A==
X-Gm-Message-State: ANoB5pnIvLPZz/WjcburRwC85vQx1EqhbDQeY7+47ux7JuVJ6izYXc4D
        4nYd22rll//dcT78KxCCU4c=
X-Google-Smtp-Source: AA0mqf5bbbM2Ey8aDDMRRxoQANiNABBR5EuqgbA88InhXkY5YtNllspX8hGfwRC2BZ1dEtaaBfF7Sw==
X-Received: by 2002:a19:8c1e:0:b0:4b4:6460:24d with SMTP id o30-20020a198c1e000000b004b46460024dmr6846311lfd.386.1668603838350;
        Wed, 16 Nov 2022 05:03:58 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b00492ea54beeasm2590371lft.306.2022.11.16.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:03:57 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:03:51 +0200
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
Subject: [PATCH RESEND v4 2/2] gpu: drm: meson: Use
 devm_regulator_*get_enable*()
Message-ID: <a2f0835e8d3b5f5768d887ce47a1575ae11b19f0.1668602942.git.mazziesaccount@gmail.com>
References: <cover.1668602942.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+AsYBOOQaVjrzzJT"
Content-Disposition: inline
In-Reply-To: <cover.1668602942.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+AsYBOOQaVjrzzJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify using the devm_regulator_get_enable_optional(). Also drop the
seemingly unused struct member 'hdmi_supply'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
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

--+AsYBOOQaVjrzzJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN037cACgkQeFA3/03a
ocUqbwgAr9qOikS0LMJyO5GovQMABn825PnykrWGi+dZ6sDx5/TPtK3c6Wa+M75x
AarIBszsCEdzLvBgGZs1OvcsAUvoV/8Xxeg8LkysmC6MOXrHVlklb2ybdezc13Xr
/1ZT1lfyVl+FdgzLgcM6PzjOobO0YDxS8GMoIXft5WeEbsOM5O8/CW7CgOHbi8QP
//3f3nJu8bTsJOZRjgcNEw9InElYaZYwPJUktYOfQ0qTSWSO9HCaeWYV13KQlAP8
7YcST0Jm3ywbRiQAv5hzZhjkcZ634PVGsTpNlLgy+2MHrLOnHIQEw0vPiwKeYiJH
XIT3agwTeqk+1JCl0jFIpZgiepnk7Q==
=WwI9
-----END PGP SIGNATURE-----

--+AsYBOOQaVjrzzJT--
