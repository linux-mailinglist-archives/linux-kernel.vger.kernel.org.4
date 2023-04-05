Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209066D8142
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbjDEPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjDEPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263D7ECB;
        Wed,  5 Apr 2023 08:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9462625CA;
        Wed,  5 Apr 2023 15:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41DAC433D2;
        Wed,  5 Apr 2023 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707447;
        bh=D4YX5DK0pun7qG4OSMVc8e9vaDN+H7CmPuWpZRhiBTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H++unxUb7nt0bWB0cZRIpirjyl6fMUIanjR0IybKKbOFCDZQ7fl3nGRfgXxHBmOTc
         aLr8pCNoVrScF3nXsYVeVlit6tFVqt3RTHudqPjdJeU4XNb3Fm+L6FyB4ZGRpA8mku
         uHDprHNH/IIWooGinODcsKEp00ZKOvzTS5e+wLSdqGlH/MPkZGOJVa2hJjKHooD4a0
         m1oiZgR8OnAyymsDZMT9AjB6JLhQsxqkpcXhI/shb8qZ4C8ggWEHL6au6GNGlms1bf
         2LcKx7iD5BDrkm8i9BaGwlDiJoOZSwNIUEO5nDNUcLF6Xb9gQmEcDK0dMfWFuHYUX9
         29DfTcAe3KLQg==
Date:   Wed, 5 Apr 2023 16:10:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Abel Vesa <abelvesa@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 64/65] ASoC: tlv320aic32x4: div: Switch to
 determine_rate
Message-ID: <692983f2-4aef-4ab9-9777-43f46b9cb4ba@sirena.org.uk>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-64-9a1358472d52@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Lzv7qB7yUCBJADV"
Content-Disposition: inline
In-Reply-To: <20221018-clk-range-checks-fixes-v3-64-9a1358472d52@cerno.tech>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Lzv7qB7yUCBJADV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 12:11:54PM +0200, Maxime Ripard wrote:

> The driver does implement round_rate() though, which means that we can
> change the rate of the clock, but we will never get to change the
> parent.

> However, It's hard to tell whether it's been done on purpose or not.

> Since we'll start mandating a determine_rate() implementation, let's
> convert the round_rate() implementation to a determine_rate(), which
> will also make the current behavior explicit. And if it was an
> oversight, the clock behaviour can be adjusted later on.

Similar comments to the other patch, I'm pretty sure this is just
surprising design on the part of the clock API and we should just allow
reparenting.

--3Lzv7qB7yUCBJADV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtj2AACgkQJNaLcl1U
h9C6nwf/eAXWoy2nqSW5TGkiJhKHJv8x94Toi8TRODFF+R/hoCeBiwbDpLoGU2W+
XtYiCa4AsVVTQShMscEuygSt4HqR2Hm7gaw+SoRwfdX/dEpqMCCF1Uzc9IAgRRv/
3aWJLZtx/5Mpyu3eaA6b7ul2tFP8PDE90ePyk1zHCZGUE189FK95s3Xc6zmVnuy2
Es8Td9JeVAZhnxCyLYGLVjoUw8/LsBEXAQWpSr/ayacNPTQa9PlPM3k/HCggwR7g
3NRnovXN1XYJ2pkkaN9RB9yifiB9Doz8KnLhSJVYG2lIaFMyYDSuYFu2zEIa8M/y
YabesVhSGONiNYKoP8QmdjTZqKi2nw==
=i5C8
-----END PGP SIGNATURE-----

--3Lzv7qB7yUCBJADV--
