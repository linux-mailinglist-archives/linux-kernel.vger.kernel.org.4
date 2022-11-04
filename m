Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AC619C65
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiKDQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiKDQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B131230;
        Fri,  4 Nov 2022 09:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0F262271;
        Fri,  4 Nov 2022 16:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C5C433C1;
        Fri,  4 Nov 2022 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667577610;
        bh=RnKpU/hTdTSmTNhPFE1pRi4HN2+uJR5IYJ3mHMOQJ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cT/Z80DQRnPv/70/29SwYeenhOJLyjbBPUFlgfpd/AZinAJl0ffseRleU9nuJBUko
         sIKZREqhjpM5ixmbGPtno+npoo5AfZQueFrKX4MHj5HbO6032QcomMPEs11RxlCRCF
         +npEC1nMjw2yzXE3+8fu/b6DX5Zyh1ekZsGoJSUiBNkV8rAVlWCjALi+TPQALz5yLf
         8JmAJZSyXbUsqNPG3SJPuUdwaXQ/YK17sNKIv6mAuSRsBddzrpVxhgHxOUN/vVDF21
         VhZaoe2BNXMOANIoVRwbo95TtqPu/Q5GIO4aUt0cX2VGbao265lJ1lyL1fG/C3KEu+
         lOiIL5YO6XPRw==
Date:   Fri, 4 Nov 2022 15:59:53 +0000
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
Message-ID: <Y2U2+ePwRieYkNjv@sirena.org.uk>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
 <Y2UzdYyjgahJsbHg@sirena.org.uk>
 <20221104155123.qomguvthehnogkdd@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFrR3s30/s3KKRzK"
Content-Disposition: inline
In-Reply-To: <20221104155123.qomguvthehnogkdd@houat>
X-Cookie: Quack!
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UFrR3s30/s3KKRzK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 04, 2022 at 04:51:23PM +0100, Maxime Ripard wrote:

> Just filling determine_rate if it's missing with
> __clk_mux_determine_rate will possibly pick different parents, and I'm
> fairly certain that this have never been tested on most platforms, and
> will be completely broken. And I don't really want to play a game of
> whack-a-mole adding that flag everywhere it turns out it's broken.

Well, hopefully everyone for whom it's an issue currently will be
objecting to this version of the change anyway so we'll either know
where to set the flag or we'll get the whack-a-mole with the series
being merged?

--UFrR3s30/s3KKRzK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNlNvgACgkQJNaLcl1U
h9CDMAf+IBF/7wHY1CiObYqxme229wA2t2WnnYY98dUUNS5r9zuNUi7juhvrvn+E
VFS2XsBkk6YvHvT2mQdVWxnTb3suMHPfHzr2euHUVwNVevnBNKDVYp8nlYmyRSUC
orLXibEBBMbA69rPzQyaFqZHj17zEyWQvHSrWk44MnQJH2f7JFEmcLPXgug1dpsP
mmWyfYnKKlRXMqDPkJ3ozY2AaABQkWdk64ke2unO7z9M7ySybhybPHBibISAn/WA
8mQ7NgbHPzpVnTCfrRwSEd05eCvJaEacBYFByW87lEEEtfxwwJsXSZCJpmc9ZVPm
WTCliiQC4/Pd0EJKpPQCXYinp/27fw==
=2DXe
-----END PGP SIGNATURE-----

--UFrR3s30/s3KKRzK--
