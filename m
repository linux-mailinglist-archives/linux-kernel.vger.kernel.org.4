Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3696EE441
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjDYOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjDYOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:48:36 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74634268F;
        Tue, 25 Apr 2023 07:48:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9A47582063;
        Tue, 25 Apr 2023 10:48:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Apr 2023 10:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682434110; x=1682441310; bh=2Z
        9xscxrsAsgngjIzMB6+vzGDqIX8rHhJnudaSYumkM=; b=qBJOkoVe+VNibxNNQO
        VK2js4W7TzTuIpkDDa3BLdnOC7eWX0KgROExYuxUdEFqCJsGyLbF+D2tvbjjep3U
        bAgos8DrJ/Hjkb2ZGyXZzyFpvNCDW+gofoAROAJGv7CQnlCLqe6ATS1J4MJRcmwg
        4Q4K2ZOUhpVU1cAQnmuGP1cxN/fjHKicRyETbAXCNO2Qviwt8gxnXoRRWuv/7jMb
        lpg2wS+gSdjofHEnqblqp4x8V5wAiRkLnum/Bj+m5Ab2mWfdXh50k0IcR2nmhcwk
        FuFT4cztt9au15O9HposWQfpC/GQXa6ocvA7cTgvabmtqhnoORgHy7MV3BJ+J4+o
        madw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682434110; x=1682441310; bh=2Z9xscxrsAsgn
        gjIzMB6+vzGDqIX8rHhJnudaSYumkM=; b=ZbXzsek9V7jy7FBZZjfe3bm2cOnrh
        g8hTeK6Fhh/HecH47BxVkmvQT4XP9+M+x5KplHQbt5qHnZNNXyfRp06v//jCH0RC
        DUCYVonbAkK2V/lr/TciWCARVwImuF5DwfEBVrzgz0SHl4MSBuyPKdc91oYeLqSY
        pE8IfifJ7qSu7D2RWCrnrGGBDOMDaHkY8R6kvjVE+3WFWd4tRjO7Xt6yE3jhSCc/
        Aij9bWtJ1nykUzu0l0UP7BqeLIIqSMgUzPkplevnEdX0QwHjeP3gh+71Je/iz0dF
        +ymAW48RTZj+2K+0DcXQ9oCXzPQ8kyrHTzGj8aWYJ9U2KnGQiFEba+s3w==
X-ME-Sender: <xms:PuhHZDLbuxmUpnoqvk2pbFPZI4YCEbbSxOZ4NXL8FtOSYnAeA4UioA>
    <xme:PuhHZHJc-XHI78gu6IZO_LN-Huzr4JDWRbrFwQHAhOqfTcfuJqSNIVVshGEm_Ojen
    4xz68r8IBuWi29LLgA>
X-ME-Received: <xmr:PuhHZLsgs5wGOs9cdcbI9NeM9EwJqurgjDl5URQyrdXV8HLV8_Bn08oaxPWQYfQojWZpWChXh1eu7rgS2E_nLBg9Mez76dY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:PuhHZMZd9EIBUl1Wyry-TbjgK_2L_TMsq-N8aN870T0DkJ8bJyUOzw>
    <xmx:PuhHZKaVF3HvOGKJpBoJT0DtU3QQ5hT6MNvdpXdzvoWzV37ERODA5g>
    <xmx:PuhHZAB4bMGgrV5lZuu5ELLK3c9LN4lJ_EJCMX6Bpm6vKa8U0femUA>
    <xmx:PuhHZOgJU5V6hv_jQmVadgi43lNAg_tfkJs7WPvVbbwAPmeqE1qC2w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 10:48:28 -0400 (EDT)
Date:   Tue, 25 Apr 2023 16:48:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dinh Nguyen <dinguyen@kernel.org>
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
        Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v3 29/65] clk: socfpga: gate: Add a determine_rate hook
Message-ID: <sjlp5ubnpvulgwhhymmfkmmobkgxacyqwagqozodkee3di2qik@3igj6k3zgbk6>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
 <20221018-clk-range-checks-fixes-v3-29-9a1358472d52@cerno.tech>
 <679921ee-98d4-d6ef-5934-e009fd4b31fc@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="635dxoh2qhipywob"
Content-Disposition: inline
In-Reply-To: <679921ee-98d4-d6ef-5934-e009fd4b31fc@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--635dxoh2qhipywob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dinh,

On Mon, Apr 24, 2023 at 01:32:28PM -0500, Dinh Nguyen wrote:
> On 4/4/23 05:11, Maxime Ripard wrote:
> > The SoCFGPA gate clock implements a mux with a set_parent hook, but
> > doesn't provide a determine_rate implementation.
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
> > The latter case would be equivalent to setting the flag
> > CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> > to __clk_mux_determine_rate(). Indeed, if no determine_rate
> > implementation is provided, clk_round_rate() (through
> > clk_core_round_rate_nolock()) will call itself on the parent if
> > CLK_SET_RATE_PARENT is set, and will not change the clock rate
> > otherwise. __clk_mux_determine_rate() has the exact same behavior when
> > CLK_SET_RATE_NO_REPARENT is set.
> >=20
> > And if it was an oversight, then we are at least explicit about our
> > behavior now and it can be further refined down the line.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >   drivers/clk/socfpga/clk-gate.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-g=
ate.c
> > index 32ccda960f28..cbba8462a09e 100644
> > --- a/drivers/clk/socfpga/clk-gate.c
> > +++ b/drivers/clk/socfpga/clk-gate.c
> > @@ -110,6 +110,7 @@ static unsigned long socfpga_clk_recalc_rate(struct=
 clk_hw *hwclk,
> >   static struct clk_ops gateclk_ops =3D {
> >   	.recalc_rate =3D socfpga_clk_recalc_rate,
> > +	.determine_rate =3D __clk_mux_determine_rate,
> >   	.get_parent =3D socfpga_clk_get_parent,
> >   	.set_parent =3D socfpga_clk_set_parent,
> >   };
> > @@ -166,7 +167,7 @@ void __init socfpga_gate_init(struct device_node *n=
ode)
> >   	init.name =3D clk_name;
> >   	init.ops =3D ops;
> > -	init.flags =3D 0;
> > +	init.flags =3D CLK_SET_RATE_NO_REPARENT;
> >   	init.num_parents =3D of_clk_parent_fill(node, parent_name, SOCFPGA_M=
AX_PARENTS);
> >   	if (init.num_parents < 2) {
> >=20
>=20
> This patch broke SoCFPGA boot serial port. The characters are mangled.

Do you have any other access to that board? If so, could you dump
clk_summary in debugfs with and without that patch?

Maxime

--635dxoh2qhipywob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEfoOwAKCRDj7w1vZxhR
xavIAP9NdWOgKUDjN4zLo7wwwqFUwBI6vcLYDH178vQMtvLupgD9GDdlERsfJpng
mzdl0IfdqknQqk5qHgVllUa6sstbpgY=
=0zSO
-----END PGP SIGNATURE-----

--635dxoh2qhipywob--
