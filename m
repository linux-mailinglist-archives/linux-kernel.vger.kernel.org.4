Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263E262BED9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiKPND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiKPNDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:03:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067B205C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:03:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l12so29366687lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yj1uHK7HEYHiWFNEA4c6ztqJMkzjkf4XEFeM+LwxtIg=;
        b=DQqtzDKWBRTTXrTN9hNrp+mtDefk1sMRvbwnlYah2vXNkxG9puls0fYPV+phkNSdFW
         tlfwHOcvpqNA18GculZlgXIGwceB/LVIJlVMRIf8G1z0/6CGdTd1VWLUJMsP4tZbVaFS
         YLYSNYLsZBmUxGis5weeBHTPBW+KWHEhG0hF2k8uXZvRiX1phQBxlAweebBbn5MCDYAf
         KZPP80JcWP/6zUqVaO2p3aC7OvanvwK1xmSQBsThqwNsfFHpRKEniRUyASzYJsX8VafY
         I41RtTe4Vq1DAUdY6ZsZlHmgB3Vh826+JdSXO14quqCwX6XhtZeOtni3R+MY5QkXtexS
         KV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj1uHK7HEYHiWFNEA4c6ztqJMkzjkf4XEFeM+LwxtIg=;
        b=jdRUy7uNnd3XQidQ//YntSvbZ8eBFF19k0Fwkab9+fF77e1qTLSE/G/JZ4g+hjVlbd
         ppuucsKQSZPdGqUgf+O6HLNBgdO4Bd41UEcqoldU/SUkT+MtPJNPd0z5rY4bBC8tnKtP
         79TisrJt1W3I7lB3BQ8PklR9BlNuL9EnSmWo7OdeeDlidaHwcbvAuTwKckQy7W0gmx3e
         JBCFqTGeBSFXR7fbbS1rtlYqJY8QPvGkz1S4Ai4SCTl+hYAnhDJh5mQbPW6IhMlBOjJT
         r4y+Z/2AVuScQfCT1cU2NpSxDkGPcq7VVeU09X7W3Paty+M8MnvHBD5Yx9wUo3Sn7TCO
         kNJg==
X-Gm-Message-State: ANoB5pl5bXQzEGH1Isuf3TTEYswcK1YCy+Cf5qz76/q3ICHJx/T9AE/h
        HZZusATWPA+WlrfrjbtOgNjzt93J9zk=
X-Google-Smtp-Source: AA0mqf7AzfIzexM2z7u+Uqd3EVkiLAzQw1oHH8gedmcDfckXG3tZna2CfFK4Bwj1l2ZwJnkRNoljSA==
X-Received: by 2002:ac2:55a1:0:b0:494:9680:5036 with SMTP id y1-20020ac255a1000000b0049496805036mr6845823lfg.416.1668603791679;
        Wed, 16 Nov 2022 05:03:11 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b0026c4305e5e2sm3002831ljk.53.2022.11.16.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:03:10 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:02:41 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Airlie <airlied@gmail.com>
Subject: [PATCH RESEND v4 0/2] Use devm helpers for regulator get and enable
Message-ID: <cover.1668602942.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5Tght3fByM0oHga+"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Tght3fByM0oHga+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify couple of drivers by using the new devm_regulator_*get_enable*()

Found these patches when doing some clean-up for my local git. Seems
like these two fell through the cracks while other were merged. So, this is
a respin of subset of original series v4.



These patches were previously part of the series:
https://lore.kernel.org/lkml/cover.1660934107.git.mazziesaccount@gmail.com/
"Devm helpers for regulator get and enable". I did keep the patch series
versioning even though I changed the series name (subject of this mail)
to "Use devm helpers for regulator get and enable". Name was changed
because the devm helpers are already in 6.1-rc1.

Also, most of the patches in the series are already merged to subsystem
trees so this series now contains only the patches that have not yet
been merged. I hope they can be now directly taken sirectly into
respective subsystem trees as the dependencies should be in v6.1-rc1.

Please note that these changes are only compile-tested as I don't have
the HW to do proper testing. Thus, reviewing / testing is highly
appreciated.

Revision history:

v3 =3D> v4:
	- Drop applied patches
	- rewrite cover-letter
	- rebase on v6.1-rc1
	- split meson and sii902x into own patches as requested.
	- slightly modify dev_err_probe() return in sii902x.

Matti Vaittinen (2):
  gpu: drm: sii902x: Use devm_regulator_bulk_get_enable()
  gpu: drm: meson: Use devm_regulator_*get_enable*()

 drivers/gpu/drm/bridge/sii902x.c      | 26 ++++----------------------
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
 2 files changed, 7 insertions(+), 42 deletions(-)


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
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

--5Tght3fByM0oHga+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN032MACgkQeFA3/03a
ocUEvAgAjCWRtr46zfwvyaXn0DSSFgdHBz/YLZoO1HrDpIxcZuWYpBU4QHi5DzcN
dYCTy1OXLEYBx1FQarMFxcV/DsSskwDPzz/+XvlZH5crOqRPg71QTYZ6FO1xCVK+
Ws9cAFNhFU5EYjZcxG/AVkLAMTaQlcPlPu4hIog283gobsq40ApJbCdQGY5v8QXp
YhMiAnjeHOR3P3mEpTb6dV32WwDykP1a9bPuKb4yPT4F80sPLb7DGKYsAeeMBj2+
M1tuYjMHIJn8lERaCV28WudVTYU9BOCsXxRuitVRn3ro+wDIH9H/YhRuj3ylGLvf
OgiXECbDMP4UlrQdgHmh3TeaTZGxGw==
=joFx
-----END PGP SIGNATURE-----

--5Tght3fByM0oHga+--
