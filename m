Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCF619BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKDPpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKDPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835702F392;
        Fri,  4 Nov 2022 08:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1DA6B82ECC;
        Fri,  4 Nov 2022 15:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8DEC433D6;
        Fri,  4 Nov 2022 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667576710;
        bh=E7bcdLSHvaAKIPE4ct56X1unFntQqaD0pUdA4q8WBPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iW2uzuyJnRpdzdYsOnj4Dp2jfgwg/wmolQBPj30EcOuf2VsVt3t2KGn1L2da6vygL
         dgk5H4xlPxNq7WJE0fBxhwwvtqV21rDvvnmzLfxGQBPtJoKomuEvU1KudXZgKZ8wWW
         ZyxZO03YbaXh9LiyJ5Q4bfCvW1rwPZBk+tFh4ZHJfT60Uz3U5Lx1kVzYWIMttyDcmD
         1TCxAOUJvc5dGmcoXZCI6AMCi4ilnI9/qlyIWWcoQ7fbhky8dXIQBZ3lKFJwFgma47
         E5YyYFEuly9dIIRudPC0lqTN3GuIIXhBvPqf35m07Cag87dJ8kurm8ACuWPQ12Y02s
         DtcPhURUzZJKg==
Date:   Fri, 4 Nov 2022 15:44:53 +0000
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
Message-ID: <Y2UzdYyjgahJsbHg@sirena.org.uk>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fVhQhryKijuhlxQZ"
Content-Disposition: inline
In-Reply-To: <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
X-Cookie: Quack!
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fVhQhryKijuhlxQZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 04, 2022 at 02:18:00PM +0100, Maxime Ripard wrote:

> So, the set_parent hook is effectively unused, possibly because of an
> oversight. However, it could also be an explicit decision by the
> original author to avoid any reparenting but through an explicit call to
> clk_set_parent().

> The latter case would be equivalent to setting the flag
> CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> to __clk_mux_determine_rate(). Indeed, if no determine_rate
> implementation is provided, clk_round_rate() (through
> clk_core_round_rate_nolock()) will call itself on the parent if
> CLK_SET_RATE_PARENT is set, and will not change the clock rate
> otherwise. __clk_mux_determine_rate() has the exact same behavior when
> CLK_SET_RATE_NO_REPARENT is set.

> And if it was an oversight, then we are at least explicit about our
> behavior now and it can be further refined down the line.

Given that the current approach involves patching every single user to
set a default implementation it feels like it might be more
straightforward to just have the clock API use that implementation if
none is defined - as you say there's already a flag to indicate the
unusual case where there's a solid reason to prevent reparenting.  It
feels like the resulting API is more straightforward.

--fVhQhryKijuhlxQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNlM3UACgkQJNaLcl1U
h9C5/gf/ZAWh5zvkI1qjXrZhZu2SWgV5WGeNOTbNz15+lAF9tH5C8ilg87uyeZMu
FqNtaI2yJVBQ3uV+LbG0gypsDTeJ+LtfC+/saRJdP8mYUIu8fO9g6xzs31D73Vd0
9DOeN92+hX3GUcy6kFSTwgF5zVmvHnwOewIOly65XCHvibSgBRyAgV1AyNmH9uiy
zgVO88CdCE4NwAuMynXAR8mi+U4b0vDuk6EQ5UZjLJWWNRjxvFFJrcMCHISRJGsT
yqZJd8iCFTk91ovn3IKGno5MZ5tA8qWSJ52cBxs9VRKqQhQuWQl4UD4qwWdgwN6Y
liuJLyjGo/OfBHnsuDkzhj30nFiIUA==
=scaI
-----END PGP SIGNATURE-----

--fVhQhryKijuhlxQZ--
