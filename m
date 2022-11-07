Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211C61F69F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKGOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiKGOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:52:21 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9431BEBB;
        Mon,  7 Nov 2022 06:52:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 10FC32B05D99;
        Mon,  7 Nov 2022 09:52:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 09:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667832726; x=1667839926; bh=pH9EnTs5L3
        AE9yRrf/TOfLTE3vMWtMQ5hIBy7+jkfxo=; b=F7wDDyPbg4B6cj4BQiM8vMTPkt
        tkEJFLYEYVOXIksN+jqz4ftMcxZZXnzOddYWfqs9q6bd1iOFwyhB5pE4Fvz/05uZ
        RF10RSC0RzcIedJ1G2E1LSQq4Zg42bEfK0TSyO7m7id0Yy1xeUuD5zWJX3us817V
        rjIfPInA1Vwm/QlX4DnPJzUv40Z0ii9fRJxzgHqkydlEG9GHtOtzfSoBBYVuklOY
        znHltzYI/nV8aA3pqWRO9oD9yS5dvx0Tnbouc9wI5DeGckOnRznPX94uGeI63tXw
        4a6YpykXCScaYQzL11169W/UCCuCj+CqGjGcj2LOgIC8IwvROeIK920PT8Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667832726; x=1667839926; bh=pH9EnTs5L3AE9yRrf/TOfLTE3vMW
        tMQ5hIBy7+jkfxo=; b=tm2CjukNyGky7m61cEbNeNPEwlXow6RPoGg2KjXghbKg
        ra/lLyp2zKjbGDhKlZm+A1NYUYItu9u5SMkA9pJHis1as3Cuaw086EXYoGiWAwEc
        kwmgNzmeS59QVCIvcfLkrQ+Ebrrzyvxm0bLZzUJt64WJNOdWIwV+A1Lm0sxt1PlG
        pqQrTshYGPUOlH25VHE+1Lo/JkFnLumTSx7pnL0tNbn51t3OP92FWPXw0EfQztVG
        wtJ4RnEpesPcGbqI0l7+PnoJguGMz6X3T6Oc+iWlaBg8/BNZZbD/jeW+bRR9Y7Mm
        aeVy4dRLsyWLoksEM3gODq0m5OD2atrQxRTwoulo5w==
X-ME-Sender: <xms:lBtpY-40Eo4JzBjQaFjHtoUz7QeBdEwcwbk96GIlHmmJELkNOdiNuw>
    <xme:lBtpY355rFDdDU_5_Zhsu6BuYYJ8FsknqxkvYPdHiPLl5stDZ4ymxPAwZCGrhq1q0
    rYmNowEFVM52RrtcrQ>
X-ME-Received: <xmr:lBtpY9dGH4qlk66IJxrnFOeAg7gL0Dzov_oSAqI9d3jUn16Bj4wfUEZhAxYh6xwVb1pD_70A4Fj78DNZ9hmuXeqDZ6FtyKnnZ6v_m9fVoJ9KEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lBtpY7K_De75Z1Qb3KnMLSjsRajiL-H-Ua3gdzprEa6elskIEslNHg>
    <xmx:lBtpYyJPcAZLuZCZ9YrgeNVP2SDE0zyvQMv9GMV_qnwg12P9XLOYhg>
    <xmx:lBtpY8zZKJW8BWrb3kvSxaP7pHRcbh-yGdZ8oBvUaVqZHP2VBvAXdw>
    <xmx:lhtpY2R7H97-NMegP3mWI1QxFbMYDvDajfqDlJ0guaZiDLR4Zxs1FRw326M>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 09:52:03 -0500 (EST)
Date:   Mon, 7 Nov 2022 15:52:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Lechner <david@lechnology.com>
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
Subject: Re: [PATCH v2 54/65] clk: da8xx: clk48: Switch to determine_rate
Message-ID: <20221107145202.2mne5p2sa4l2dm6g@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-54-f6736dec138e@cerno.tech>
 <6296d944-e03d-6f2b-48b1-3dad78e3c89d@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwjqag62r4ghubsj"
Content-Disposition: inline
In-Reply-To: <6296d944-e03d-6f2b-48b1-3dad78e3c89d@lechnology.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kwjqag62r4ghubsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Nov 04, 2022 at 11:49:34AM -0500, David Lechner wrote:
> On 11/4/22 8:18 AM, Maxime Ripard wrote:
> > The TI DA8xx USB0 clk48 clocks implements a mux with a set_parent
> > hook, but doesn't provide a determine_rate implementation.
> >=20
> > This is a bit odd, since set_parent() is there to, as its name implies,
> > change the parent of a clock. However, the most likely candidate to
> > trigger that parent change is a call to clk_set_rate(), with
> > determine_rate() figuring out which parent is the best suited for a
> > given rate.
> >=20
> > The other trigger would be a call to clk_set_parent(), but it's far less
> > used, and it doesn't look like there's any obvious user for that clock.
> >=20
> > So, the set_parent hook is effectively unused, possibly because of an
> > oversight. However, it could also be an explicit decision by the
> > original author to avoid any reparenting but through an explicit call to
> > clk_set_parent().
> >=20
> > The driver does implement round_rate() though, which means that we can
> > change the rate of the clock, but we will never get to change the
> > parent.
> >=20
> > However, It's hard to tell whether it's been done on purpose or not.
> >=20
> > Since we'll start mandating a determine_rate() implementation, let's
> > convert the round_rate() implementation to a determine_rate(), which
> > will also make the current behavior explicit. And if it was an
> > oversight, the clock behaviour can be adjusted later on.
>=20
> I think this one should be the same as the clk:davinci changes and
> not allow re-parenting. Since this is a USB 48MHz PHY clock, a rate
> change will never be requested.

I'm not sure, it doesn't seem to be the same clock, it's not doing the
same thing (this one will always force the same rate, the others let the
rate change), and we're not doing the same refactoring (this one had a
round_rate implementation, the other one doesn't)

Maxime

--kwjqag62r4ghubsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2kbkgAKCRDj7w1vZxhR
xdnyAPoDUCObUrCr2C1a0eiJzKGIcW+Cl1z7L7QadhXWYBxPJAD+K5Cnal04FAYQ
nw7UCY5eZErrD6YvLzwUrAeczrFXVQw=
=GExv
-----END PGP SIGNATURE-----

--kwjqag62r4ghubsj--
