Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71A5E6432
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIVNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiIVNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:50:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1FB1C114
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:50:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n10so15601283wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z3sexyeyUJdURCD2OUYhtkAo269PZ5QlEsbN/k/uA2k=;
        b=EJSgc6RwBPaKrSSKq9ogi4vGgcOXAmjG+KdpCjqOh0Y/OEllPIrpLEKZqRJeBbbpKC
         priIyFKaZVg2m2KvndRX0twZB2hcFVIeP+OSZNQCPx+3LWdgAZSFX9vTCAjsGJgyRb/e
         BUflfjC5VjyC6fLr1B0ZfvJURpsCi8iFj3gJ1Tq3flUeIoAZ2SjX6JSPOdyveJ8XL2ZE
         pL0gZUTwhxKAKwWF3QT9iFb37pSl9/Vb5hW9Xh1d/MKkKY4tRZchaAwfs2QyzJr18qjr
         gqz+pMvijAv0nElV4lVpzM6X6YXQRNoI/bgj5+WSE+RLo36pQDKx5+M438cCKSczFB+H
         XrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z3sexyeyUJdURCD2OUYhtkAo269PZ5QlEsbN/k/uA2k=;
        b=3JS5vtQo0UvI+yRnhxcXHxjktwJlserCqOBLFydYSbfvyabLM52un0R2PbXvKPk4Ko
         MEmfbcBvTq7Azx+NX4L3Y6gxuH1zkz2SOYifKcdyQ6EJd/W+GDFw2H3f1//y2j2tbj0F
         /4SxZQqws3prvjPl4qadb5iTtAhO58ztt/ROL7Pn8Cs/NgCFrv+X1D/wSOBy6f3DGTvn
         7R7EDZzIF1A654jNzg9X/91a31HvuqS+3xiE3S1mte/bPQDqwlRSeqqqm6XHJnihL4QX
         FFO5F0f+pEeM68a4mUnnFIZKaA2lPaddIXwEQ9T/8MCvEkSLedz8th+k6z1kqcWHO2Il
         1GqA==
X-Gm-Message-State: ACrzQf0zIJDZeHg4gRndzls1OqVbmHb9nVaPzlwIa2HBpwvVdlYcW4Yf
        Va82rFvlnsbq0AWWfOZH7qS8theVsiggrzSG22s5/w==
X-Google-Smtp-Source: AMsMyM7SdBsyCznGI20l+F9gnW5c3o/BLK/I1RC+ONDHDo/OVst2OLbxyvWZLD+Zs00qr8W2jQsHoMi5m622ax9rIs8=
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id
 r15-20020a5d6c6f000000b0022a77786ea2mr2243789wrz.15.1663854607926; Thu, 22
 Sep 2022 06:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com> <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com> <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
 <20220909142247.GA238001@francesco-nb.int.toradex.com>
In-Reply-To: <20220909142247.GA238001@francesco-nb.int.toradex.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Sep 2022 15:49:31 +0200
Message-ID: <CAPDyKFrwpz=gi3iY5YsO6k4o33eLQRp-wXvBx3nQ0q=G9YrqHA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 16:22, Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> Hello Ulf,
>
> On Fri, Aug 26, 2022 at 03:50:46PM +0200, Ulf Hansson wrote:
> > On Thu, 28 Jul 2022 at 13:21, Francesco Dolcini
> > <francesco.dolcini@toradex.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 11:37:07AM +0200, Ulf Hansson wrote:
> > > > On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
> > > > <francesco.dolcini@toradex.com> wrote:
> > > > >
> > > > > Hello Ulf and everybody,
> > > > >
> > > > > On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> > > > > > On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > > > > > So our plan is to explicitly handle a (shared) regulator in every
> > > > > > > driver involved, adding that regulator capability for drivers not
> > > > > > > already having one.
> > > > > >
> > > > > > Please don't! I have recently rejected a similar approach for Tegra
> > > > > > platforms, which now have been converted into using the power domain
> > > > > > approach.
> > > > >
> > > > > Just to quickly re-iterate how our hardware design looks like, we do
> > > > > have a single gpio that control the power of a whole board area that is
> > > > > supposed to be powered-off in suspend mode, this area could contains
> > > > > devices that have a proper Linux driver and some passive driver-less
> > > > > components (e.g. level shifter) - the exact mix varies.
> > > > >
> > > > > Our proposal in this series was to model this as a power domain that
> > > > > could be controlled with a regulator. Krzysztof, Robin and others
> > > > > clearly argued against this idea.
> > > >
> > > > Well, historically we haven't modelled these kinds of power-rails
> > > > other than through power-domains. And this is exactly what genpd and
> > > > PM domains in Linux are there to help us with.
> > > >
> > > > Moreover, on another SoC/platform, maybe the power-rails are deployed
> > > > differently and maybe those have the ability to scale performance too.
> > > > Then it doesn't really fit well with the regulator model anymore.
> > > >
> > > > If we want to continue to keep drivers portable, I don't see any
> > > > better option than continuing to model these power-rails as
> > > > power-domains.
> > > >
> > > > >
> > > > > The other approach would be to have a single regulator shared with the
> > > > > multiple devices we have there (still not clear how that would work in
> > > > > case we have only driver-less passive components). This is just a
> > > > > device-tree matter, maybe we would need to add support for a supply to
> > > > > some device drivers.
> > > > >
> > > > > Honestly my conclusion from this discussion is that the only viable
> > > > > option is this second one, do I miss something?
> > > >
> > > > No thanks!
> > > >
> > > > Well, unless you can convince me there are benefits to this approach
> > > > over the power-domain approach.
> > >
> > > I'm fine with our current power-domain proposal here, I do not need to
> > > convince you, I have the other problem to convince someone to merge
> > > it :-)
> > >
> > > Maybe Krzysztof, Robin or Mark can comment again after you explained
> > > your view on this topic.
> >
> > To move things forward, I suggest you re-start with the power domain approach.
> >
> > Moreover, to avoid any churns, just implement it as another new SoC
> > specific genpd provider and let the provider deal with the regulator.
> I'm sorry, but I was not able to understand what you mean, can you
> provide some additional hint on the topic? Some reference driver we can
> look at?

Typically, "git grep pm_genpd_init" will find genpd providers.

There are a couple of examples where a regulator (among other things)
is being controlled from the genpd's ->power_on|off() callbacks, such
as:

drivers/soc/mediatek/mtk-pm-domains.c
drivers/soc/imx/gpc.c

>
> The driver we implemented and proposed with this patch is just
> connecting a power-domain to a regulator, it's something at the board
> level, not at the SoC one.
> We do not have a (existing) SoC driver were we could add the power
> domain provider as an additional functionality.

Right, so you need to add a new SoC/platform driver for this.

>
> > In this way, you don't need to invent any new types of DT bindings,
> > but can re-use existing ones.
> The only new binding would be a new "compatible" to have a place to
> tie the regulator instance used in the device tree, but I do not think
> that this is an issue at all.

Yes, I agree.

>
> The main concern that was raised on this topic was that we have to
> somehow link the power-domain to the specific peripherals (the power
> domain consumer) in the device tree.

Yes, that is needed. Although, I don't see how that is a concern?

We already have the valid bindings to use for this, see more below.

>
> Adding the power-domain property there will trigger validation errors
> unless we do explicitly add the power-domains to the schema for each
> peripheral we need this. To me this does not really work, but maybe I'm
> not understanding something.
>
> This is what Rob wrote on the topic [1]:
>   > No. For 'power-domains' bindings have to define how many there are and
>   > what each one is.
>
> Just as an example from patch [2]:
>
>   can1: can@0 {
>     compatible = "microchip,mcp251xfd";
>     power-domains = <&pd_sleep_moci>;
>   };
>
> leads to:
>
>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml

I think it should be fine to just add the below line to the DT
bindings, for each peripheral device to fix the above problem.

power-domains: true

That should be okay, right?

>
> > If you post a new version, please keep me cced, then I will help to review it.
> Thanks!
>
> Francesco
>
> [1] https://lore.kernel.org/all/20220613191549.GA4092455-robh@kernel.org/
> [2] https://lore.kernel.org/all/20220609150851.23084-6-max.oss.09@gmail.com/
>

Kind regards
Uffe
