Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B36D8206
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbjDEPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbjDEPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68244E64;
        Wed,  5 Apr 2023 08:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08EC63E21;
        Wed,  5 Apr 2023 15:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7C9C433EF;
        Wed,  5 Apr 2023 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708886;
        bh=q6hazTR3zs7E7OVM3zxpzK5DagX6jtQENEamOL0SGKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlbEhXatZkXJ9X7FsGvPf2rH95VpY5tOnyIMJWR/0y9to3LuusuWOEW94RzKcDlKg
         HsFf5CsPOKukH8P5uoSP2Z0JlxMdLwy9OxF/8G86S5WBCQNQtEOwVMDqSea8cvrsDU
         564oj+TiTuatTLbxixAITrHG3+c5+iQ5kEWuaj8LLDEFmeZMfABdscXZNA/eAMWJAk
         0YkRM5fCov8t3qCX2aBvV3kmH3qO4N9tKQnMqdz4QY5qygfyDOUcQlTmMnAu3at4ih
         jXuoUGUjvrX+RS3OfX29rQcD6mKS146C1VyprHv8nlDm6+/mgIZ+D1r/IpS6sIO5UV
         4+HTzWQ25QIJA==
Date:   Wed, 5 Apr 2023 16:34:31 +0100
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
Subject: Re: [PATCH v3 43/65] ASoC: tlv320aic32x4: Add a determine_rate hook
Message-ID: <fcc11e4d-eba6-4eff-b3e5-9488a4da84c3@sirena.org.uk>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-43-9a1358472d52@cerno.tech>
 <01f32440-8dd2-4030-9006-a3123be55845@sirena.org.uk>
 <erm4iq3mygnrr4h2gd5cag3sfuovv47ibdqsbmxcfabngvnwy4@z63ksvj55zuu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWy5+BLE6plJ+54H"
Content-Disposition: inline
In-Reply-To: <erm4iq3mygnrr4h2gd5cag3sfuovv47ibdqsbmxcfabngvnwy4@z63ksvj55zuu>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rWy5+BLE6plJ+54H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 05:17:21PM +0200, Maxime Ripard wrote:
> On Tue, Apr 04, 2023 at 04:26:18PM +0100, Mark Brown wrote:

> > To be honest it's surprising that we'd have to manually specify this, I
> > would expect to be able to reparent.  I suspect it'd be better to go the
> > other way here and allow reparenting.

> Yeah, I think I'd prefer to allow reparenting too, but as can be seen
> from the other reviewers in that thread, it seems like we have a very
> split community here, so that doesn't sound very realistic without some
> major pushback :)

For these ASoC drivers I think we should just do the reparenting,
they're very much at the leaf of the tree so the considerations that
make it a problem sometimes are unlikely to apply.

--rWy5+BLE6plJ+54H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtlQYACgkQJNaLcl1U
h9B5kwgAhgnq7R11Qu+B0UHvMPR+YuXSbduHynE7TqBLfStAOBSo1K13PASgQaa9
wrmguaiF0D05AzsDdSViUh7jt1zNtO3da+OYl8oXujrIbMZbGni9L/fGVLPLH9LH
S4EKLVYbDM7dTpVx0aDXvlVCYW21kOHRWWv/J6PmtESnjJOfnQGHe3Xs1h8ZgovN
olevNVv7bIIBbK+syW2trg9ueeQFhIP8zFvA7seKaKplyJQN6b6ZBpF5/0RIVobC
9KooGdA4p3nEKzSBi+TYDZL/NYxlB7m/Y8nMussyk40gnvHmlVGYXLA0nVd3MP6U
GEwYUUby6V7fvlt7mTxduZug5WAoPQ==
=MZpO
-----END PGP SIGNATURE-----

--rWy5+BLE6plJ+54H--
