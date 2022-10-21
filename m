Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9DE60782E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJUNSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJUNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:18:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9027354E;
        Fri, 21 Oct 2022 06:18:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b1so5049344lfs.7;
        Fri, 21 Oct 2022 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihyfIhpnzq65oKa3RDOB7v3ysoQ+yvmg3Y0WFsPd1bw=;
        b=I9NeRnvmBddsliQwQ2JpFRY+yBhvSinkJq/RCwn5uMf4MgZObYFZAv/iOK3QP8HDji
         9FhiOcX3yboLmgid/jqKyVngYBvuPvf5BkzKMNFWrL8KQT1Tl6iFXObUupxvMPyj6ipV
         hTwvZClXLoQOmaru2RChDi02M5YSHTfFduAL2+4oTQGWTpzWlEA43DlIrC6Xrq73NH5O
         7Zs1g3PN9W+9D9GL2WBG90EoQeCFaYYsg3kjewxiPQUlMaz2PZmj+0fcCPZO2Un+43ag
         2qgx1yDok3Bs6op5lq+uaO6uVmesvlIp5o4EQAeDUAca5dg6zkwSVqXiapNee7MfkIoj
         SUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihyfIhpnzq65oKa3RDOB7v3ysoQ+yvmg3Y0WFsPd1bw=;
        b=jVb9PcnpXr+uEaKDgc7OtKLl5ba5omCn5WlvLO1hVWXNw1jF8Pxl9sU64NjFke7OwZ
         haG4gaZI0rCSqapdDdj9So+Ib78bAdqYRlKDcxDfdmyBAfBDxPhg2VEBPpmzBDvRnmqk
         K5bHOPttgiGIlb5N3ndlhoXVAKeuUiDbR/Z9rlVb2hwarP3eHbblDyDNGWmSCgyMafb6
         rmSg2+mJeSQKVZfzJwRGWdRW4ZO0Brfr9A/XzwlsUcJ33E4u9Nh91wBGaSAKuW1uQ6JS
         phV3F5a1nfJFKavn91hYeSKKDlnbcgO0lPES7EJ/n/yCn4FxGctovhTxciwpoYKzUr/H
         PPzA==
X-Gm-Message-State: ACrzQf0L6qSqccQb1TD9EYuWqPnTUsGt/szVCz37x4LBkCLtgBnlFJK9
        MWVbacdBtVHeWTxSaIExM8o=
X-Google-Smtp-Source: AMsMyM5r/E/MTpA6dpEKyj/vPwlJ3EnRAGRQWeDHieNWdktxJ3gFXIx6Cn2GnJ4y5gYcXpejtbqXhg==
X-Received: by 2002:a05:6512:3085:b0:4a2:7d80:d4b4 with SMTP id z5-20020a056512308500b004a27d80d4b4mr7150541lfd.534.1666358288796;
        Fri, 21 Oct 2022 06:18:08 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id a13-20020a056512200d00b00494747ba5f7sm2210665lfb.272.2022.10.21.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:18:07 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:18:01 +0300
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
Subject: [PATCH v4 1/4] gpu: drm: meson: Use devm_regulator_*get_enable*()
Message-ID: <c14058c4b7018556a78455ffef484a7ebe4d8ea2.1666357434.git.mazziesaccount@gmail.com>
References: <cover.1666357434.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I73xNqd38oT7/msC"
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


--I73xNqd38oT7/msC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify using the devm_regulator_get_enable_optional(). Also drop the
seemingly unused struct member 'hdmi_supply'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v3 =3D> v4:
- split meson part to own patch

RFCv1 =3D> v2:
- Change also sii902x to use devm_regulator_bulk_get_enable()

Please note - this is only compile-tested due to the lack of HW. Careful
review and testing is _highly_ appreciated.
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

--I73xNqd38oT7/msC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNSnAkACgkQeFA3/03a
ocVRkQgAmAp5C+Mg1nONvKcJHcITidnpA5Ktq6dm9OB4A11/VOy5Y8vZKLKVXldv
ejqrFYrMUa//jhZlfwE1dFQbnKn+XXFd06QurEX/mGMBncGU6+i97cXjCF6EYPEH
H75CW6UyXgbz0rJ2tZ/OZCcwYDG9eqHbpgaFY1EGeznu7QkGwV+M4pREhesDo+nm
mXIsmGEztzGu2TMM+TI8mrWodczDnF66iTQRHDQy0t12jnrrCB3uemE4wjpyZCJP
ftoZuJbu0T4lhagXnftz1H7ymW7/qFeCxr85CCCHndF19IUBs3YuWXaRQ1YoaKkJ
olB+Ubu0zJfGizSC/oJqDwtKUthyeA==
=ECH6
-----END PGP SIGNATURE-----

--I73xNqd38oT7/msC--
