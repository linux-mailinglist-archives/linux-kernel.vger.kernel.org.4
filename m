Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBC63D1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiK3JWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3JWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:22:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB269391F8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:22:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a19so4438248ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrYQxj8rjyddDjRsu3FuqRZBUQ9RMmMk5gv8riRQFOM=;
        b=Q8M4gPDYB4jwdz4f2CMBq+WCzhqoJPnVSqxDPcnPj237ydBotlIL0qg+XZelvewFI4
         OYBGVoLIpcRmD/dWxXTigKma4q45VwiPVPD7Nlvw6ph0ziLAIl8p1blWCCHtUDHwt2e6
         Ia5q8KfFnpMt58kN67cQiP9MuNYK1hyJRvZjnci9KBUH7BNWct8m1a8cHJFQ6o84G/zw
         Oiu/1nOmQ3vkdqPk547uJSzTRtywI/gbFpbJzLKiqkES5ZTXHp9/XAK1l77tq2Zu4JLb
         wTbUAPIfwhT4Xz9Eeuym5sC72XZBR3tzQbYnxinYcZDlj0xUPdzobKS7vbmthCRfNLq9
         ly4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrYQxj8rjyddDjRsu3FuqRZBUQ9RMmMk5gv8riRQFOM=;
        b=ss6USyP38CkWGz4gJWuoVhmbfJz4T24o7OKR32B0AQAHj6Ym2bTQeIC/JyMEL1840d
         tvDVim49tuwn99wcYSsb1qk0oHENsKbzbeo+qV7JNPCLAGL2LP7josn80IVMQCxqJXfO
         KKFu/mzB8tmol38XU+ZN2lJMyrYtUntx/r+AXt4/HWuZXoDDqWeqV5qWq129SSVu71YP
         n2gt4vs14RhPGsWCLl9s0vTpgyHRtOh0+Tms46lpVX9ue+2sWJMd82Yjdy+K+AF4mWnc
         jV0neV1hA9EMurrDIrKyI19AzBEGxjewN0OMyvTyr/5pJdFtgZ1UP2OGOaIjiYcaLTJg
         BHog==
X-Gm-Message-State: ANoB5pkJ6IfERRr+TObfn6dUo3TvCT/p+hIuLaJy/uEktzSJb+gkmh0M
        HkN32Cv28FjjTjSXZStL8MM=
X-Google-Smtp-Source: AA0mqf4Rchr13o2XY80vRF849S2N11ziLsgahYBib0CNIMQAIIbfLZwyHl7Mga5wg7zBXockjzBaDg==
X-Received: by 2002:a05:651c:158c:b0:26c:90f:f8fe with SMTP id h12-20020a05651c158c00b0026c090ff8femr20464441ljq.2.1669800132086;
        Wed, 30 Nov 2022 01:22:12 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id u20-20020ac258d4000000b004b5241dc8cfsm190594lfo.10.2022.11.30.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:22:11 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:21:51 +0200
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
Subject: [PATCH RESEND2 v4 0/2] Use devm helpers for regulator get and enable
Message-ID: <cover.1669799805.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wDEAM8gkULDvl3zl"
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


--wDEAM8gkULDvl3zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify couple of drivers by using the new devm_regulator_*get_enable*()

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

v4: RESEND2:
	- resend code unchanged. Commit titles and and commit messages
	  improved.

v4: RESEND:
	- resend only the drm patches - others have been applied

v3 =3D> v4:
	- Drop applied patches
	- rewrite cover-letter
	- rebase on v6.1-rc1
	- split meson and sii902x into own patches as requested.
	- slightly modify dev_err_probe() return in sii902x.

---


Matti Vaittinen (2):
  drm/bridge: sii902x: Use devm_regulator_bulk_get_enable()
  drm/meson: dw-hdmi: Use devm_regulator_*get_enable*()

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

--wDEAM8gkULDvl3zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmOHIKIACgkQeFA3/03a
ocXYwAf+KjfV0msgFQZGZRTYzXQoNbPiRpwjEi03SryY+FAWtPZVLMI0VkM97vbS
eHNUOroZCLa8tqllqsFAbqc2/6PC7pS4hmU4HoFFgFnVhscCECxtJJ6F/MOYb++Y
cHAcMhAXrKbaCcyGHR+y+oW0SktYYIC3nEVwxaR3G3JE3Te4moZWO/0X3B6/WH11
Pg6XPTaclOeTWtw4sqLWDIAjjeGEkjtA16yze+GdPlo4SiS1vem6M/Z0cAWi6jiG
9GzEE8SwWcRSqqdFgMwSX1PIZgQgim6h0fDfhrj43pws4reeUXRP4bcGqUeKCVrf
uyIJN40u03Upe82WPq+z9D6aDrotYA==
=c7ic
-----END PGP SIGNATURE-----

--wDEAM8gkULDvl3zl--
