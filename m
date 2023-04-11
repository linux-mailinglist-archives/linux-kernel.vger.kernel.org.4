Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217916DDBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDKNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDKNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:09:51 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E014690;
        Tue, 11 Apr 2023 06:09:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8667320007;
        Tue, 11 Apr 2023 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681218585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zj1JtAKrv3GVkrzExsf9B7vpxAMSpGNgfjgQje0eTak=;
        b=oNG2Rb7etLGd3op/Iz2fmq0xokA2awaHaTUwmpMIqfWRcdiVNffJhH1OiD/NJa8U8VhbyA
        yF9MXtYH8Fxz3M+cAq/7V/oq1xoDx4mXB50I/MCViACuf5Xj/3sm+jiFSUhQyd/GFiKSU+
        MvbhXoQ5xcQFvUgIZ6glZLEM1HPSvT3ZkSE8cIw3GiRKuf3ey7u+ch+9vo/URZlNg8hBkX
        sdQ/9ZojYLUArwz1K4ERP3d5/cBFRF6/83yyqSdXppNVR0gRdgwuMipAeMDZ8IGKN7s335
        n6r/K2t/A0PaaBtBH3FUkAWJV3CrDikEbkeZlUHa/BD6XrUBmGFFsgVYyetBaQ==
Date:   Tue, 11 Apr 2023 15:09:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
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
        alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: Re: [PATCH v3 28/65] clk: renesas: r9a06g032: Add a determine_rate
 hook
Message-ID: <20230411150930.4fb22d7e@xps-13>
In-Reply-To: <CAMuHMdXUEOP_3zjf8nwDyHvZVG-D0AsBjnr=esKzejMMcEiLSQ@mail.gmail.com>
References: <20221018-clk-range-checks-fixes-v3-0-9a1358472d52@cerno.tech>
        <20221018-clk-range-checks-fixes-v3-28-9a1358472d52@cerno.tech>
        <CAMuHMdXUEOP_3zjf8nwDyHvZVG-D0AsBjnr=esKzejMMcEiLSQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert & Maxime,

geert@linux-m68k.org wrote on Tue, 11 Apr 2023 12:27:38 +0200:

> CC Gareth, Herv=C3=A9, Miquel, Ralph
>=20
> On Tue, Apr 4, 2023 at 2:44=E2=80=AFPM Maxime Ripard <maxime@cerno.tech> =
wrote:
> > The Renesas r9a06g032 bitselect clock implements a mux with a set_parent
> > hook, but doesn't provide a determine_rate implementation.
> >
> > This is a bit odd, since set_parent() is there to, as its name implies,
> > change the parent of a clock. However, the most likely candidate to
> > trigger that parent change is a call to clk_set_rate(), with
> > determine_rate() figuring out which parent is the best suited for a
> > given rate.
> >
> > The other trigger would be a call to clk_set_parent(), but it's far less
> > used, and it doesn't look like there's any obvious user for that clock.
> >
> > So, the set_parent hook is effectively unused, possibly because of an
> > oversight. However, it could also be an explicit decision by the
> > original author to avoid any reparenting but through an explicit call to
> > clk_set_parent().
> >
> > The latter case would be equivalent to setting the flag
> > CLK_SET_RATE_NO_REPARENT, together with setting our determine_rate hook
> > to __clk_mux_determine_rate(). Indeed, if no determine_rate
> > implementation is provided, clk_round_rate() (through
> > clk_core_round_rate_nolock()) will call itself on the parent if
> > CLK_SET_RATE_PARENT is set, and will not change the clock rate
> > otherwise. __clk_mux_determine_rate() has the exact same behavior when
> > CLK_SET_RATE_NO_REPARENT is set.
> >
> > And if it was an oversight, then we are at least explicit about our
> > behavior now and it can be further refined down the line.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech> =20
>=20
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I searched for 'possible callers', I didn't find any places
where this would be used on the consumer side. However, downstream,
there is a rzn1-clock-bitselect.c clock driver which states:

+ * This clock provider handles the case of the RZN1 where you have periphe=
rals
+ * that have two potential clock source and two gates, one for each of the
+ * clock source - the used clock source (for all sub clocks) is selected b=
y a
+ * single bit.
+ * That single bit affects all sub-clocks, and therefore needs to change t=
he
+ * active gate (and turn the others off) and force a recalculation of the =
rates.

I don't know how much of this file has been upstreamed (under a
different form) but this might very well be related to the fact that
reparenting in some cases would be a major issue and thus needs to be
avoided unless done on purpose (guessing?).

Maybe Ralph can comment, but for what I understand,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> But I do not have the hardware.
>=20
> > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > @@ -1121,6 +1121,7 @@ static int r9a06g032_clk_mux_set_parent(struct cl=
k_hw *hw, u8 index)
> >  }
> >
> >  static const struct clk_ops clk_bitselect_ops =3D {
> > +       .determine_rate =3D __clk_mux_determine_rate,
> >         .get_parent =3D r9a06g032_clk_mux_get_parent,
> >         .set_parent =3D r9a06g032_clk_mux_set_parent,
> >  };
> > @@ -1145,7 +1146,7 @@ r9a06g032_register_bitsel(struct r9a06g032_priv *=
clocks,
> >
> >         init.name =3D desc->name;
> >         init.ops =3D &clk_bitselect_ops;
> > -       init.flags =3D CLK_SET_RATE_PARENT;
> > +       init.flags =3D CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> >         init.parent_names =3D names;
> >         init.num_parents =3D 2;
> > =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

Thanks,
Miqu=C3=A8l
