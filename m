Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272C6D8185
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjDEPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjDEPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:18:13 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD555B95;
        Wed,  5 Apr 2023 08:17:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id CFB322B06725;
        Wed,  5 Apr 2023 11:17:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Apr 2023 11:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680707845; x=1680715045; bh=4g
        3Y3WtpEmHJBlHmaZSfRkusN6Gsi4T8SDJHzgHkAHw=; b=L4vZO5QE1gCVJJlu2o
        r6vojScB4+ZzvhrGxAnCgZw8q3iEvd5m35SZkx+KC1V9nR1oJrFdkv+ey7bHZjCL
        h7ZEBk9Gmy/3C1A/1qdft9MpePUYhTf2LMdsCjgEXC/wq8oDjffPfKya8bL0vOhv
        zM4glmn3aahZ0fd/tWPeXFJVlzfG49xJGig3f3S4nIf2yKej0KUqRbtf9U4HO7U4
        Fca3KFRY0boUta2nyK/ZvwIoPXjc0uR7jRie7ubda+6o8LFTmR3EQPKCjDxKPY69
        q+rnuCjeiU34JIwElnik7ZIFhfh2uCaJ5k3L+G6Ma8lMgJQI3qmYO86jMfQxx5Ci
        VdNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680707845; x=1680715045; bh=4g3Y3WtpEmHJB
        lHmaZSfRkusN6Gsi4T8SDJHzgHkAHw=; b=VEkZsmfrmM6qqrbSYR67T7b6tnqGF
        AvhJD3Y4WLLq1tU2AX/t6uAgHsNHwJpXvwtS4GnhhmEJ7XPVKNwRq+9WMhmmzML+
        RG6DEdWr2hNUhcl8o0yOuq3CX2GqoiuaH9MsBOokOxVfwovgwExj8beYgt4/HxuA
        a96LoWlzOcRy23htu+pg7NjQwIET42Hppt8MLtacCrxmqqy1yW4bPHimBOxOQWfJ
        wAwezgR/QID/T8H8Ty1cHIhdRLrfE64Z96wSdoJclrB780/8YTOOdsPEANPT/KF4
        SSABADpffcDQPX+mkREx6UEIjxMxopVCUSw91MvdZ2vn4nW1L5oPr6aSQ==
X-ME-Sender: <xms:BJEtZAuMkk6wnab4QseDQgMYaxs-ZoalWk6ba9JDW-N_MwUR-r-0_g>
    <xme:BJEtZNeeUQqDS514Kh75x4vjSF_5nb0vlfH8K6OmRPlsGhffGSlMHsAhdX_0tWg6m
    1rxuj_wVXQehW37VVk>
X-ME-Received: <xmr:BJEtZLwjCpHui3RPPt2Zh-h4Q5a1KUTc9johjdZpp-INV-i7TjtqsffumjLDSjqJRIBhpUDe69m60CBw6P-vuyAbTZVw17w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:BJEtZDOLnxucnvKx3FD6J-fSLSIdKT1u6WKBdKX_FeKFrkbQnefb_g>
    <xmx:BJEtZA_bReMUs9Hnw0kWbI8p_MC65dZMSzDb9-uV0n2-sq5SiGHLpg>
    <xmx:BJEtZLVbSPxoi4qvWklXjQcQFOKJSC341u3oT8-2Qg5yq0Cm5T0yJQ>
    <xmx:BZEtZFFxxiKux8gHULwGp3q2GhoxRfghXYlW4d0UO9AUrD_vtD7rQM5gvGo>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 11:17:22 -0400 (EDT)
Date:   Wed, 5 Apr 2023 17:17:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
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
Message-ID: <erm4iq3mygnrr4h2gd5cag3sfuovv47ibdqsbmxcfabngvnwy4@z63ksvj55zuu>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-43-9a1358472d52@cerno.tech>
 <01f32440-8dd2-4030-9006-a3123be55845@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2rp74o6ajwb6i7x"
Content-Disposition: inline
In-Reply-To: <01f32440-8dd2-4030-9006-a3123be55845@sirena.org.uk>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2rp74o6ajwb6i7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Apr 04, 2023 at 04:26:18PM +0100, Mark Brown wrote:
> On Tue, Apr 04, 2023 at 12:11:33PM +0200, Maxime Ripard wrote:
> > The tlv320aic32x4 clkin clock implements a mux with a set_parent hook,
> > but doesn't provide a determine_rate implementation.
>=20
> > This is a bit odd, since set_parent() is there to, as its name implies,
> > change the parent of a clock. However, the most likely candidate to
> > trigger that parent change is a call to clk_set_rate(), with
> > determine_rate() figuring out which parent is the best suited for a
> > given rate.
>=20
> > The other trigger would be a call to clk_set_parent(), but it's far less
> > used, and it doesn't look like there's any obvious user for that clock.
>=20
> It could be configured from device tree as well couldn't it?

Yep, indeed.

> > So, the set_parent hook is effectively unused, possibly because of an
> > oversight. However, it could also be an explicit decision by the
> > original author to avoid any reparenting but through an explicit call to
> > clk_set_parent().
>=20
> Historically clk_set_rate() wouldn't reparent IIRC.
>=20
> > The latter case would be equivalent to setting the flag
> > CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> > to __clk_mux_determine_rate(). Indeed, if no determine_rate
> > implementation is provided, clk_round_rate() (through
> > clk_core_round_rate_nolock()) will call itself on the parent if
> > CLK_SET_RATE_PARENT is set, and will not change the clock rate
> > otherwise. __clk_mux_determine_rate() has the exact same behavior when
> > CLK_SET_RATE_NO_REPARENT is set.
>=20
> > And if it was an oversight, then we are at least explicit about our
> > behavior now and it can be further refined down the line.
>=20
> To be honest it's surprising that we'd have to manually specify this, I
> would expect to be able to reparent.  I suspect it'd be better to go the
> other way here and allow reparenting.

Yeah, I think I'd prefer to allow reparenting too, but as can be seen
=66rom the other reviewers in that thread, it seems like we have a very
split community here, so that doesn't sound very realistic without some
major pushback :)

Maxime

--l2rp74o6ajwb6i7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZC2RAQAKCRDj7w1vZxhR
xRegAPwLq9rAf2gXBh+S5NNzglDB7jF/equjD6dhO2iJfkonFgD+OuUuIkBhvEAH
dy14syHvUOJJRm7L8hscnDwFHJrXQA0=
=mQrD
-----END PGP SIGNATURE-----

--l2rp74o6ajwb6i7x--
