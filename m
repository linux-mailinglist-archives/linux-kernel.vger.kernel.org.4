Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D462298C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKILF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKILFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:05:53 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648AC183A8;
        Wed,  9 Nov 2022 03:05:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id A2BB358028C;
        Wed,  9 Nov 2022 06:05:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 09 Nov 2022 06:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1667991951; x=
        1667999151; bh=vmOE1i1nn9SMlBuCJ3VnNfQD0xqLuGWwaNRgBFkPe6c=; b=i
        UBuhX7kriUxSCehPgyDNVaNazC6ZqYODyvhJk308S4xAUw5FR/DHRUqG16A1PS1v
        ENmxNSthPcYKnBHtEEF4NaMy6AMNMFRKmBB4ZMO5eWIGTyu5mcJ/lxtMQQKTp+Sl
        bQoUGjVADCr+WlHx0lEbNyRZEkgxaNZtrOmYQk0n2ac7Ict9gfpAbOd1BC7PqTrX
        39etLAMsLKZQd37k5nG5BLcya9So/IuudBRhm20X4So5igEWds4fbHOimh5wN49/
        ln1R90AfTyvxybxkoM8IkNdb6OToGOLdadgCnR968ucV/axdvSNCg+RE2oF7ctmL
        2LiRGx0TVolehy8/Ne86g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1667991951; x=
        1667999151; bh=vmOE1i1nn9SMlBuCJ3VnNfQD0xqLuGWwaNRgBFkPe6c=; b=T
        TY4LI5yFmrInBONewR1yb5qlBkxihM8159PIPlYDmWA5k3cs6R078ZVOeWwQKn+P
        +GckfW29QMZbSl2Ct2toWmPP/d/xCps3+gIRhC/48d53tAMpx3CcXdvjbcMdlGaH
        418HC+LOEQXdmRN+xj8IKR8GWz1rDO6wMRy7uCnn56UrZhz/yjPEDpwf7vYX0fkH
        m0aRfjw4W6386+uBxP7werCj507zKudg266b6LBMV4hkq3aTnpLukKcBpCDI5KGA
        8lLXnV2C7a6crYf665PdrAcrj1EAi4pI3ygcaSw2JcXkB3tTOxiiF/e+yvWF+UEd
        KTf55HOf20U+esBTcvDDw==
X-ME-Sender: <xms:j4lrYzcfce-pkfxbNMuUAe7O8SDJOGOpo4BU3gOxZUwHo3_o1PcbrA>
    <xme:j4lrY5PQ31XtPRQUz_ETEKlwp3m5MnIUkuBQicNvVSH2Dk-Z3jYgjUTMMcj9vm_ZH
    2AmIewUJcs6VVAxKrI>
X-ME-Received: <xmr:j4lrY8g4lF5pYrEXuizOwk38wsEzey4gfyK8eZCr5QD3P-aC1t9ztZvQmVMmd1ki94ZIcVtJtjvk3LGTtQiMc2tfSmAhsaxLcXamGm7hIZoq2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeuteef
    teefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:j4lrY09JY312_H6bkXFS7A43Biy7qGwzGnEeP5Y0uZ9G7kysxJhf1A>
    <xmx:j4lrY_v0OupU2v2HjodxIchYMkMoZQ5cFdpdz4BYWFJTwbBA5z3TNQ>
    <xmx:j4lrYzFtfrVh7k6R2NrlYul8_U1RKhEST7MBUj48swjdXWPIopZ5uQ>
    <xmx:j4lrYz0j-wnR26hF6pYd5MvmBktuLP8ovKPiXE4FNNZ6DDGeDvNxfQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Nov 2022 06:05:49 -0500 (EST)
Date:   Wed, 9 Nov 2022 12:05:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Linus Walleij <linus.walleij@linaro.org>
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
Subject: Re: [PATCH v2 34/65] clk: ux500: prcmu: Add a determine_rate hook
Message-ID: <20221109110548.4dcbkwx3jgjnhldw@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-34-f6736dec138e@cerno.tech>
 <CACRpkdYwM6X8bBABCisUGX=P4F=hcFb7QLT3Cu7XUWUvV4TE1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACRpkdYwM6X8bBABCisUGX=P4F=hcFb7QLT3Cu7XUWUvV4TE1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 08, 2022 at 02:25:04PM +0100, Linus Walleij wrote:
> On Fri, Nov 4, 2022 at 2:32 PM Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > The UX500 PRCMU "clkout" clock implements a mux with a set_parent hook,
> > but doesn't provide a determine_rate implementation.
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
>=20
> It is actually set up from the device tree, typically like this:
>=20
> /* clkout1 from ACLK divided by 8 */
> clocks =3D <&clkout_clk DB8500_CLKOUT_1 DB8500_CLKOUT_SRC_ACLK 8>;
>=20
> So the parent (source) and divisor comes in there.
>=20
> clk->source and clk->divider is already set up when clk_hw_register() is
> called.

I wasn't aware that we had such bindings. AFAIUI, it looks redundant
with assigned-clock-rates and assigned-clock-parents, could we deprecate
it?

> So set/get_parent() is never used on clkout.
>=20
> I think I just added the callbacks for completeness, should we delete them
> altogether?

I can't really test any of these platforms, so I'm a bit wary of making
such changes myself. Feel free to send a follow-up if you think it's
needed :)

> The patch is probably fine as-is as well so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Maxime
