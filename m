Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11461EDB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKGIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKGIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:54:23 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAFABE3A;
        Mon,  7 Nov 2022 00:54:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CBDFB580981;
        Mon,  7 Nov 2022 03:54:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Nov 2022 03:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1667811261; x=
        1667818461; bh=DpobGsjjO6+ObD0CgLx0PfBT5w/ojqtKffWwUQfBXkA=; b=a
        L7x6VeduJt+1Hu5h1m6xZv3p7hN365kpXqH5SuShvo3zwCzJIKsm96bEmylPDRnr
        vKihkUHqJ+opr8d5eypGD34fQlnFGyxPjZz8U+6RxuJq36EaUEjtGGOHxWFWJmsR
        xF8mQxK/zVQWtqPsaAi62pWa+AWIoU2BQQvgaXR8zkOkphgUl8UR2UNnuFhq1pY6
        BBMhiWDZbMK+qFDNXAtIYmad+XRLYmN1xRyV+Cdif96MtdkOqfkm8tHhatycY5y4
        6hqoUGqXVWC6P521j5IjRmmgaDJ6w3DWXYznabMX8M7Hgb9gEW6XKEk3hW0kJ2QI
        +2VDPHajg+fFKI1/fw4zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1667811261; x=
        1667818461; bh=DpobGsjjO6+ObD0CgLx0PfBT5w/ojqtKffWwUQfBXkA=; b=a
        wf3lMuGSE0c+KKuKS9VUt+n1OzUMiXhyTIxQLBDjWgJq5Rasjs/0LinZ+VNNis3Q
        alYUFBZQZ1o6/Q54VwJt3hqIwUHR2Sqily3v9eJVSTlP+Hu2fMStre5KXTVYz4tY
        up+dWJV8xLSoFiZUgzmweb/bZBcB/fFtJnk3gDOGBjofi4mAWNWAPpiPA0jEfPrm
        qZYWyDNc5qSMORFII98iU3MY0TQmveTRjRLYGwUC3eXJUsRYRr3v7if3WJeSkO6I
        j3g07rByjglyFc5HGmp7F1QOFNm/ObUDgojleoszz+DZFx1tbTqcAVeOKkORWZom
        ZIRqMfyKz+fN8PnA+frdQ==
X-ME-Sender: <xms:vMdoY_7qKFUnXrMLgK6UK63X-Fh4SaqG616lZWh2McRJiMf86oKkBg>
    <xme:vMdoY05eqjOQdOTGTKTySzE1Wn9z9h-j5CLWyw-kRMMS7CUhWbIcIkplkIUxbV3Zx
    tjU76RkWB9nO9l2Z6w>
X-ME-Received: <xmr:vMdoY2eTjJtLQJNNaygWBJHdzqd2eezOC-jGJ5qGPoZggXSc-nHUmqhTbr9BJgETFjOt3Omg7gRBI2Br8ytbDietmUNlkAqFM8RJrlQ2C87Yog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleelfeeileelteetfedvieekfeefffevhfdtvefgheevudevheejvddv
    ieeltdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vMdoYwK5IAG7BHmBDjFkYVhB3wRP1TzolwSnR7LPSyHllzJNSVgrKg>
    <xmx:vMdoYzJWQmddsqBUPbOODTn8VI2mqM3H1ese92evIxTkRlBaGuPeYA>
    <xmx:vMdoY5w7ruPvXZ8uflNCksVlsNEDzQ_jl3m9tAGFgnB3-SXCh18Y3A>
    <xmx:vcdoY6WhoDikh1uwLRRPXPUC7EI94vIUcFL5a0jAMBx8zIodtk5heg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 03:54:18 -0500 (EST)
Date:   Mon, 7 Nov 2022 09:54:17 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <sboyd@kernel.org>,
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
        Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v2 56/65] clk: ingenic: cgu: Switch to determine_rate
Message-ID: <20221107085417.xrsh6xy3ouwdkp4z@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-56-f6736dec138e@cerno.tech>
 <80VTKR.CE8RVN8M3ZYK3@crapouillou.net>
 <20221104145946.orsyrhiqvypisl5j@houat>
 <cp7Yh29ndlOOi1yW8KwCcpzoLPLxm1vR@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cp7Yh29ndlOOi1yW8KwCcpzoLPLxm1vR@localhost>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 04, 2022 at 05:35:29PM +0000, Aidan MacDonald wrote:
>=20
> Maxime Ripard <maxime@cerno.tech> writes:
>=20
> > Hi Paul,
> >
> > On Fri, Nov 04, 2022 at 02:31:20PM +0000, Paul Cercueil wrote:
> >> Le ven. 4 nov. 2022 =E0 14:18:13 +0100, Maxime Ripard <maxime@cerno.te=
ch> a
> >> =E9crit :
> >> > The Ingenic CGU clocks implements a mux with a set_parent hook, but
> >> > doesn't provide a determine_rate implementation.
> >> >
> >> > This is a bit odd, since set_parent() is there to, as its name impli=
es,
> >> > change the parent of a clock. However, the most likely candidate to
> >> > trigger that parent change is a call to clk_set_rate(), with
> >> > determine_rate() figuring out which parent is the best suited for a
> >> > given rate.
> >> >
> >> > The other trigger would be a call to clk_set_parent(), but it's far =
less
> >> > used, and it doesn't look like there's any obvious user for that clo=
ck.
> >> >
> >> > So, the set_parent hook is effectively unused, possibly because of an
> >> > oversight. However, it could also be an explicit decision by the
> >> > original author to avoid any reparenting but through an explicit cal=
l to
> >> > clk_set_parent().
> >> >
> >> > The driver does implement round_rate() though, which means that we c=
an
> >> > change the rate of the clock, but we will never get to change the
> >> > parent.
> >> >
> >> > However, It's hard to tell whether it's been done on purpose or not.
> >> >
> >> > Since we'll start mandating a determine_rate() implementation, let's
> >> > convert the round_rate() implementation to a determine_rate(), which
> >> > will also make the current behavior explicit. And if it was an
> >> > oversight, the clock behaviour can be adjusted later on.
> >>
> >> So it's partly on purpose, partly because I didn't know about
> >> .determine_rate.
> >>
> >> There's nothing odd about having a lonely .set_parent callback; in my =
case
> >> the clocks are parented from the device tree.
> >>
> >> Having the clocks driver trigger a parent change when requesting a rate
> >> change sounds very dangerous, IMHO. My MMC controller can be parented =
to the
> >> external 48 MHz oscillator, and if the card requests 50 MHz, it could =
switch
> >> to one of the PLLs. That works as long as the PLLs don't change rate, =
but if
> >> one is configured as driving the CPU clock, it becomes messy.
> >> The thing is, the clocks driver has no way to know whether or not it is
> >> "safe" to use a designated parent.
> >>
> >> For that reason, in practice, I never actually want to have a clock
> >> re-parented - it's almost always a bad idea vs. sticking to the parent=
 clock
> >> configured in the DTS.
> >
> > Yeah, and this is totally fine. But we need to be explicit about it. The
> > determine_rate implementation I did in all the patches is an exact
> > equivalent to the round_rate one if there was one. We will never ask to
> > change the parent.
> >
> > Given what you just said, I would suggest to set the
> > CLK_SET_RATE_NO_REPARENT flag as well.
>
> Ideally there should be a way for drivers and the device tree to
> say, "clock X must be driven by clock Y", but the clock framework
> would be allowed to re-parent clocks freely as long as it doesn't
> violate any DT or driver constraints.

I'm not really sure what you mean there, sorry. Isn't it what
assigned-clock-parents/clk_set_parent() at probe, plus a determine_rate
implementation that would affect best_parent_hw would already provide?

> That way allowing reparenting doesn't need to be an all-or-nothing
> thing, and it doesn't need to be decided at the clock driver level
> with special flags.

Like I said, the default implementation is already working to what you
suggested if I understood properly. However, this has never been tested
for any of the drivers in that series so I don't want to introduce (and
debug ;)) regressions in all those drivers that were not setting any
constraint but never actually tested their reparenting code.

So that series is strictly equivalent to what you had before, it's just
explicit now.

If you find that some other decision make sense for your driver in
particular cases, feel free to change it. I barely know most of these
platforms, so I won't be able to make that decision (and test it)
unfortunately.

Maxime
