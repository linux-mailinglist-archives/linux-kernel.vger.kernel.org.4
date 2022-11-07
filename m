Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A361F278
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiKGMGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKGMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:06:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EF1B1D4;
        Mon,  7 Nov 2022 04:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE626B8101D;
        Mon,  7 Nov 2022 12:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DD2C433D6;
        Mon,  7 Nov 2022 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667822783;
        bh=TjwC/oCNbbUzKPDP67kFN1hAvayD11aeO+3EJVwBAHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVU4PMxo1R8a3xp/WKHs1dq/6doMgdlOpIsmcirQbv3czoZbcxWJpPwnRrBpNnLaM
         RIaI2ploJwL3I8PSy07X4klDoFGje/zAjmQm0GMafEh6v9eSVzb3H6UHbMJeGYIK/0
         3HkQjVeGkkfj4w3q16A9Jpu8h/eTG5MQNUyBXtMwVQBVCZBvcrvN6PBx8wq4Un2SsG
         waxoneKGslH7u6FU8MFJJQeOVg92oqhsWrP6aKBcVt7eUdvfzyvh8bep0OHaNEym9f
         kwo9TcnG/5EsDXRnkiFTaef9nelMlw97dI2zZnD+Bud8Et09b4EPGmFQOKomMmC6mm
         cuDEys2QhiEog==
Date:   Mon, 7 Nov 2022 12:06:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        David Airlie <airlied@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Lechner <david@lechnology.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        patches@opensource.cirrus.com, linux-tegra@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 43/65] ASoC: tlv320aic32x4: Add a determine_rate hook
Message-ID: <Y2j0r0wX1XtQBvqO@sirena.org.uk>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
 <Y2UzdYyjgahJsbHg@sirena.org.uk>
 <20221104155123.qomguvthehnogkdd@houat>
 <Y2U2+ePwRieYkNjv@sirena.org.uk>
 <20221107084322.gk4j75r52zo5k7xk@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjklijebr6IM77Hd"
Content-Disposition: inline
In-Reply-To: <20221107084322.gk4j75r52zo5k7xk@houat>
X-Cookie: Minimum charge for booths.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fjklijebr6IM77Hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2022 at 09:43:22AM +0100, Maxime Ripard wrote:
> On Fri, Nov 04, 2022 at 03:59:53PM +0000, Mark Brown wrote:

> > Well, hopefully everyone for whom it's an issue currently will be
> > objecting to this version of the change anyway so we'll either know
> > where to set the flag or we'll get the whack-a-mole with the series
> > being merged?

> I'm sorry, I'm not sure what you mean here. The only issue to fix at the
> moment is that determine_rate and set_parent aren't coupled, and it led
> to issues due to oversight.

> I initially added a warning but Stephen wanted to fix all users in that
> case and make that an error instead.

My suggestion is that instead of doing either of these things it'd be
quicker and less error prone to just fix the core to provide the default
implementation if nothing more specific is provided.  Any issues that
causes would already be present with your current series.

> If I filled __clk_mux_determine_rate into clocks that weren't using it
> before, I would change their behavior. With that flag set, on all users
> I add __clk_mux_determine_rate to, the behavior is the same than what we
> previously had, so the risk of regressions is minimal, and everything
> should keep going like it was?

The series does fill in __clk_mux_determine_rate for everything though -
if it was just assumed by default the only thing that'd be needed would
be adding the flag.

--fjklijebr6IM77Hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNo9K4ACgkQJNaLcl1U
h9CrmQf/bbIS1m2oXUj6n0mwM7QBssq/2mPiYM5zHCkJ5nf48MDZPWSwMuq37myq
q8lR7tDeZBdU/MtjTTpvWo8j/TLyZRrhWhX5rItRjfhZdXtePpp0tci4nHKyvWuD
Lc6+WJkeyUQsy93Y0qyvKl9DZ8o4Dyqs/lM7kkCEy+9eJNaT7QFAFZYhdUN2FJAR
2YiQG2mvchxdE7SyVxMsOfXX/J6haXQKAcKej6M1HpuJukPGEKH2N9WqfKKNUuWY
rMJ0QnheSBUxkPHRzdDOMo2k+xDK6cOSg8RxRtKQ2djWWWXII5JWs6VyVHLeK6Cx
9KTsnJ+fIbHK0GK9Pq3vm90Uk4W3Ng==
=y36Q
-----END PGP SIGNATURE-----

--fjklijebr6IM77Hd--
