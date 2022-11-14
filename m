Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C026278AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiKNJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiKNJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA7273C;
        Mon, 14 Nov 2022 01:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC6260F51;
        Mon, 14 Nov 2022 09:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA65C433C1;
        Mon, 14 Nov 2022 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668416750;
        bh=D7WS1/Iq9HsSGiJfZeeNpWeUbfN2wCTKHRwR1waF5b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu23KWX+hkd2VrW8L8cgRL+RvzQoNmHr4ZHYqyx7b9ggw62j+4gl+srj7mMWbYEWO
         eMq9AeoWeTXuHN/JCWdPJOC4s9/SfymP7ivydCT3Rc5lzvj0XxUfCGvOXg+FUovve3
         mBjFDbEU8fbv5pZjeBcZG4yoTG+UTWC2w0hMhrdGaf5jiuivlIjmg6M0icdu4BayDd
         QORZ6I5Y6XZL3p7KDrZaQgns3WiyBQD5S5uJ7AJ3isJBuf/JmKGDVf410NdJ4z5Krb
         lm/rhmS+2/v3szQ2Sg6geE8bZDNcFgYVQt+IzZj3PeuYYzaH8viYNnTeheDKRc95zq
         VsYSZrpR3L72Q==
Date:   Mon, 14 Nov 2022 09:05:34 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
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
Subject: Re: [PATCH v2 35/65] clk: ux500: sysctrl: Add a determine_rate hook
Message-ID: <Y3IE3ta8hLLUcu7H@google.com>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-35-f6736dec138e@cerno.tech>
 <CAPDyKFoycVedCJMy0=UK+q5SiPQHqje_8bSN-gdkpBa6KhFfkg@mail.gmail.com>
 <CACRpkdYOj8uozJZO4MV-_OAKeOsQHhoEM=PyynVuNY-JkpgTOw@mail.gmail.com>
 <CAPDyKFr6VeF3s47JfzJ9urtMsEem+GiBtHeU=_S8jNaz-D+qnw@mail.gmail.com>
 <CACRpkdb8uYfs6w99FVjD_t6nZgDhPUx=yB1j=CmpHTHAM2QGQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb8uYfs6w99FVjD_t6nZgDhPUx=yB1j=CmpHTHAM2QGQw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022, Linus Walleij wrote:

> On Thu, Nov 10, 2022 at 2:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 10 Nov 2022 at 12:39, Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Thu, Nov 10, 2022 at 12:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Fri, 4 Nov 2022 at 14:32, Maxime Ripard <maxime@cerno.tech> wrote:
> > > > >
> > > > > The UX500 sysctrl "set_parent" clocks implement a mux with a set_parent
> > > > > hook, but doesn't provide a determine_rate implementation.
> > > > >
> > > > > This is a bit odd, since set_parent() is there to, as its name implies,
> > > > > change the parent of a clock. However, the most likely candidate to
> > > > > trigger that parent change is a call to clk_set_rate(), with
> > > > > determine_rate() figuring out which parent is the best suited for a
> > > > > given rate.
> > > > >
> > > > > The other trigger would be a call to clk_set_parent(), but it's far less
> > > > > used, and it doesn't look like there's any obvious user for that clock.
> > > >
> > > > If I recall correctly, that is the use case we did target for these
> > > > types of clocks. See sound/soc/ux500/ux500_ab85xx.c, for example.
> > >
> > > Hm I am trying to get that driver to work ... from time to time.
> > > It's just that ALSA SoC DT has changed to much that it turns out
> > > into a complete rewrite :/
> > >
> > > So in sound/soc/ux500/mop500_ab8500.c
> > > I see this:
> > >
> > >         status = clk_set_parent(drvdata->clk_ptr_intclk, clk_ptr);
> > >         if (status)
> > > (...)
> > >
> > > and there is elaborate code to switch between "SYSCLK" and
> > > "ULPCLK" (ulta-low power clock). Just like you say... however
> > > a clock named SYSCLK or ULPCLK does not appear in the
> > > code in drivers/clk/ux500 or any DT bindings so... it seems to
> > > be non-working for the time being.
> >
> > It's definitely not working, but the corresponding clocks ("ulpclk",
> > "intclk", "audioclk", etc) are being registered in ab8500_reg_clks().
> >
> > What seems to be missing is a DT conversion for these clocks, so they
> > can be consumed properly. Right?
> 
> Yeps that and a few more things, I have a scratch rewrite here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git/log/?h=ux500-audio-rewrite
> 
> I remember Lee said he had audio working with the mainline kernel
> on Snowball at one point, unfortunately I think that was before we
> started with the DT conversions and then we probably broke it.

That was also 100 years ago. :)

But yes, it used to work at one point.

-- 
Lee Jones [李琼斯]
