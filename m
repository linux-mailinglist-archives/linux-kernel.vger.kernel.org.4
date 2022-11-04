Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0337C619C21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKDPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKDPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:51:32 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3602D763;
        Fri,  4 Nov 2022 08:51:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2CF9E58022E;
        Fri,  4 Nov 2022 11:51:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 04 Nov 2022 11:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667577089; x=1667584289; bh=96a+nENK+p
        wJv6heDljopZWYNAHZZlQcLYBgPBXjxIA=; b=c28hMZxPcLC5cKVn4RzGU23sOy
        5KEaQ9azswPKVog9NQ9wCBgjJ5zlJEN0cHdbBCKvIlrdT+ZQfG2rcIz/rQlXO2jw
        k1UxgqmX2FagKHw4X9whxQYdXqwWm+7Stg0ICjSEvVtcBkwwWTvNMnDOyIgDZEfK
        HtR1ckYbIzWCnRQVeUfpYNLCZ1i4rwsh+GH+8saO+PVq3hn4d5QWQBRwmhPFIulZ
        ZlC0ds9S6hNtgM4W07ajJa0wYBoiJMHdyUGc3JQeTkMBHEKKxMPhA7p0I2haT2t2
        3KZ/N91fsmtAZg/vrWyo2Oe6uM7vziDS9Pnre6j6vnzrWB8ADGNFdEv/GhOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667577089; x=1667584289; bh=96a+nENK+pwJv6heDljopZWYNAHZ
        ZlQcLYBgPBXjxIA=; b=lcjGNhjEpFG9UwlWNPlyqpI20z1c8nUuBQ9ZXwVXmg/b
        ZeLdY5iT/PXtaTrCfBAbCRdLswoYCAlW/DJ8MOK3ly5WU0Ri4GsMvmbAiZM3YEV8
        7b7rziMvPjbfCHBYUwVNNrurjBuR3uM3+3L5lP3jdROGg/FnKT7sHSV3uPRkhQpZ
        apKhPjgWLrgSbzFty/fXLc5fDY2SimZDf9xM4fPoFnfU9jFtTLnjSfErO1Csdvwy
        Kk5IyWi+3oStGEXC27JrUOyDJxsp3DASuQw9cI88KNVcO6v5HFvkr0/dBK9GL+h7
        ToiYgcEnWuz66mqkbQ5B1R6Mal/DSPHP4ae31UzZPw==
X-ME-Sender: <xms:_jRlY7Ez8WsNCE5vgDv7giaGvtlg_-S_TRslJicSiPCdt5bJkUoEjA>
    <xme:_jRlY4UkRheR3U5QmJmsOPh6-XGK5CQfNUGZeNQ_AbqAFRLcEDmyB2cLzouBqARTU
    krI-Ojq4CzRnSVgVcQ>
X-ME-Received: <xmr:_jRlY9JiqeUBTyn6bWYvKmWYMotpgbK8YnEgDbLILKZx9L6KVBu2EE7Q3xNYrmiF1AYxcraFfmECS4yiAk2-MsqHugGRG3CxMH-3YrxjsuZX1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_jRlY5ErY3ILridCfPdMiI1BdUsTnsKgcTt_koj5Y7kuky5Mvy56uw>
    <xmx:_jRlYxWXTfF1vqAblQrq-NPyvBsz17O77BeYEHZbjU-jpqVh11zyFw>
    <xmx:_jRlY0POCHLJSycVzP16fIOwooAHD-iZGUX4A32zENNBZ9QYZ-oINg>
    <xmx:ATVlY1cZWdXf4vVe3bWpJOEOfEyXbf56TJKG-VDoEj6QaLJERlKGuA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 11:51:24 -0400 (EDT)
Date:   Fri, 4 Nov 2022 16:51:23 +0100
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
Message-ID: <20221104155123.qomguvthehnogkdd@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-43-f6736dec138e@cerno.tech>
 <Y2UzdYyjgahJsbHg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mczzont5aeejoi22"
Content-Disposition: inline
In-Reply-To: <Y2UzdYyjgahJsbHg@sirena.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mczzont5aeejoi22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Nov 04, 2022 at 03:44:53PM +0000, Mark Brown wrote:
> On Fri, Nov 04, 2022 at 02:18:00PM +0100, Maxime Ripard wrote:
>=20
> > So, the set_parent hook is effectively unused, possibly because of an
> > oversight. However, it could also be an explicit decision by the
> > original author to avoid any reparenting but through an explicit call to
> > clk_set_parent().
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
> Given that the current approach involves patching every single user to
> set a default implementation it feels like it might be more
> straightforward to just have the clock API use that implementation if
> none is defined - as you say there's already a flag to indicate the
> unusual case where there's a solid reason to prevent reparenting.  It
> feels like the resulting API is more straightforward.

That would be another solution indeed. The thing is, most places where
determine_rate is missing seems to be oversight, and the flag is missing
as well.

Just filling determine_rate if it's missing with
__clk_mux_determine_rate will possibly pick different parents, and I'm
fairly certain that this have never been tested on most platforms, and
will be completely broken. And I don't really want to play a game of
whack-a-mole adding that flag everywhere it turns out it's broken.

Maxime

--mczzont5aeejoi22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2U0+wAKCRDj7w1vZxhR
xXdWAP9xOaAlwGZ6oTzlixCwOJjLcIji+k20bZRWJg3KwM8WjgD/XCMOLieTzsjF
hAeOJdZFWunkoq+e4ZeBrrG36c3row8=
=SvO6
-----END PGP SIGNATURE-----

--mczzont5aeejoi22--
