Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1760A61F792
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKGP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiKGP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:26:20 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E03A1B3;
        Mon,  7 Nov 2022 07:26:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id DEA372B05E77;
        Mon,  7 Nov 2022 10:26:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Nov 2022 10:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667834768; x=1667841968; bh=IIy8QXUDWn
        lcncLyNQJNbxMRRWumgUmyAMyd+aDiO3o=; b=Yz8C45furNQhVL2oz7HXZgGnHH
        TvCIbx3oIXxLgbEPnABUHdZn1FjTlBXO/L1HUin7nlSwmgzBZEAHQXtqUueLWNNB
        OwfmyOlg36y4QZvHUbl/IFeKRrua5v3nbs+lI8yzO8mXx4IT19hD5T6x7SIXqH7E
        cc2GzTsHAmmLjTDm7nLKE9rJj7tzh9QXh/pmM/gmbKHm8u4yCEDXIt2H8iqZARt9
        QsECam1RG4/cnzrlWYrmdX95jbKBthE1SCw52xWcjKgvNrC/w9eFBvNcqPdoP0VC
        kgyueznhPVmNlxZMotlGuMS8QDMwTbcA/aTq9dkJ4NLHTQ8GcN7cr6b1QC9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667834768; x=1667841968; bh=IIy8QXUDWnlcncLyNQJNbxMRRWum
        gUmyAMyd+aDiO3o=; b=we3Y+H0VECymbGK0VaXTFHbsW346wsLVjErpCLgJ45+g
        scHpf9eiainU1JBqntlua0SrTwXrGABBVlunf276/GfhfNOd/1vGEf1lUcHwrvm5
        zbWxzN3W7Zenf9Aa8Y0lcDOZ0gM54P8lT8lwFBUPN/ByfauorTjW7d7RXbvSlkJT
        k7v9evp6jVencFixQzMQhtO2nt3yGpBePuWO6Pu5QWJ2wKtmD8tFnyhZw/c9eN/k
        XmLHoh4bXi0sW22vHo0bm88oijG5yx4MWoMqBaBgxLapeXxyjGYt3QLy+aQKy4Ug
        w/V1K5ZGWlq/bSa4sSDWF1/AjvqtR9hsVVTIILV+1w==
X-ME-Sender: <xms:jiNpY8OMxnFFt5PbqqvqZSEoKfqq7taLlfkj3szUIQCjdWFIeQL24w>
    <xme:jiNpYy89u_mQTLvZGrbcNIjZbLYu9wV4EYfNRlktfKZUm38GG6xC_Qlt2hrpbO_df
    BSGxlyk5s8vknO0ZFg>
X-ME-Received: <xmr:jiNpYzSfZa6atc_eqwJFct1WjeHK-hLh2fplSb5wr1nE_LAD9arud3e8hqAHxwKU5wiR6hkEVdXqGN4RgoEjwLXSB8uMLCObkZqNF9IY6V2NlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jiNpY0vtIK-PZdgej79mMr_MApM6wLdfXscqntkFAEOkhGYrOU0MCQ>
    <xmx:jiNpY0cvni03g0uv0yl-yo399Y_hbctd4rNagD2H1NT2_Xs_g9EWBQ>
    <xmx:jiNpY42HLjMSaphod3lQyPY5KzbEAeoKRXRXEDPctlkn3XY9SKEjVg>
    <xmx:kCNpY4m1DCnGwZRgh_rsYFaEzCSCv9LG7n_fC4ovY1-GZspzYu6x7s6Mw5U>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 10:26:05 -0500 (EST)
Date:   Mon, 7 Nov 2022 16:26:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
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
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
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
Message-ID: <20221107152603.57qimyzkinhifx5p@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
 <Y2UzdYyjgahJsbHg@sirena.org.uk>
 <20221104155123.qomguvthehnogkdd@houat>
 <Y2U2+ePwRieYkNjv@sirena.org.uk>
 <20221107084322.gk4j75r52zo5k7xk@houat>
 <Y2j0r0wX1XtQBvqO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jvzxow5645ldbud"
Content-Disposition: inline
In-Reply-To: <Y2j0r0wX1XtQBvqO@sirena.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jvzxow5645ldbud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 12:06:07PM +0000, Mark Brown wrote:
> On Mon, Nov 07, 2022 at 09:43:22AM +0100, Maxime Ripard wrote:
> > On Fri, Nov 04, 2022 at 03:59:53PM +0000, Mark Brown wrote:
>=20
> > > Well, hopefully everyone for whom it's an issue currently will be
> > > objecting to this version of the change anyway so we'll either know
> > > where to set the flag or we'll get the whack-a-mole with the series
> > > being merged?
>=20
> > I'm sorry, I'm not sure what you mean here. The only issue to fix at the
> > moment is that determine_rate and set_parent aren't coupled, and it led
> > to issues due to oversight.
>=20
> > I initially added a warning but Stephen wanted to fix all users in that
> > case and make that an error instead.
>=20
> My suggestion is that instead of doing either of these things it'd be
> quicker and less error prone to just fix the core to provide the default
> implementation if nothing more specific is provided.  Any issues that
> causes would already be present with your current series.
>=20
> > If I filled __clk_mux_determine_rate into clocks that weren't using it
> > before, I would change their behavior. With that flag set, on all users
> > I add __clk_mux_determine_rate to, the behavior is the same than what we
> > previously had, so the risk of regressions is minimal, and everything
> > should keep going like it was?
>=20
> The series does fill in __clk_mux_determine_rate for everything though -
> if it was just assumed by default the only thing that'd be needed would
> be adding the flag.

The behavior assumed by default was equivalent to
__clk_mux_determine_rate + CLK_SET_RATE_NO_REPARENT. We could indeed set
both if determine_rate is missing in the core, but that's unprecedented
in the clock framework so I think we'll want Stephen to comment here :)

It's also replacing one implicit behavior by another. The point of this
series was to raise awareness on that particular point, so I'm not sure
it actually fixes things. We'll see what Stephen thinks about it.

Maxime

--6jvzxow5645ldbud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2kjiwAKCRDj7w1vZxhR
xbC4AQCzinBg5fORSxUmh/ryaaQ1U50ULCO44lpcoTcfgR8NCQEArCtBTBrB8cDz
ZaXsPn80Mh//XhAP83gNXiHtZW4aJwQ=
=1n6i
-----END PGP SIGNATURE-----

--6jvzxow5645ldbud--
