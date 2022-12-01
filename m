Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0263EDF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLAKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLAKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:34:25 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDC93A74
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:34:12 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k185so1130633vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAH21UNUqbLO3zijQeQTjTfJALMFYCO0nKI/Gngxo3k=;
        b=IwOFeehWF+oYg12+9ZkiwGVadxZFj01NXaOuCnRgTZZLpM+Fn5sqOhpu1UxUlQzM6i
         xc1P4SeeF/9DaTcEWv4zIFhgg5o4km4geZx+Kts4fY4wOM0jADweJiizzcHbZl3S2X6R
         twBoFlgb6kiWQg4lDniO80Jub/yfTWo1qyCOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAH21UNUqbLO3zijQeQTjTfJALMFYCO0nKI/Gngxo3k=;
        b=3ATGIEoP/pEqw6rR/5fhneZb9A/T/tBf5/H3/kqZCqm9p8WYd4plcpVVtgmIMxzAtD
         edtGH2uojq2RV12s564pDbbjpn2MHs3tqPiX+C9sLcfRkJUFpXbANTjn2oQivIjSDpwa
         dGV579NERA32zK+2Mx4JnO2cO8zu+S0GTHofPKvlG/v33PsXhUdCD+rGitzmNvGR2kmk
         iQpH+zOl+SchOR3PmjI5DAm4CVyMiFSRtnFz9KhkOXffVQNV5tF//oJL4XkMc/PqC71C
         AqOzAoRLVXxtjIoOB/W/sEW70UnaTE1xIaJ6slKSsAvK19lnhBcbmKP5hpdC4ddvh4hB
         7D3A==
X-Gm-Message-State: ANoB5pkHW2hxbmiNHohzEN7fCjfWg7Ccu4umPd82yutDpKjrz45YLqtk
        mpAUYYFiZ62Xpn6F7jLj9BGJLj8iQpJc3oYJEirpNA==
X-Google-Smtp-Source: AA0mqf5Qao8vLv1WxRsnp96mIE7XC+68JCjxa9YlTVwuYfJ+F04VjR31/MXn43r9GYB1R+7pgmupfpOHqY8MQlfAy4g=
X-Received: by 2002:a05:6102:e0c:b0:3b0:6da7:39ba with SMTP id
 o12-20020a0561020e0c00b003b06da739bamr24540024vst.26.1669890851122; Thu, 01
 Dec 2022 02:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20221201084229.3464449-1-wenst@chromium.org> <20221201084229.3464449-2-wenst@chromium.org>
 <5250d7d3-ff46-e08d-926c-4efd92390d88@collabora.com>
In-Reply-To: <5250d7d3-ff46-e08d-926c-4efd92390d88@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 18:33:59 +0800
Message-ID: <CAGXv+5E63+dE-=KbD_LW+BV+fBWnfaD+oH0+e9T_aS-XEffN5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183: Fix systimer 13 MHz
 clock description
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 5:31 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/12/22 09:42, Chen-Yu Tsai ha scritto:
> > The systimer block derives its 13 MHz clock by dividing the main 26 MHz
> > oscillator clock by 2 internally, not through the TOPCKGEN clock
> > controller.
> >
> > On the MT8183 this divider is set either by power-on-reset or by the
> > bootloader. The bootloader may then make the divider unconfigurable to,
> > but can be read out by, the operating system.
> >
> > Making the systimer block take the 26 MHz clock directly requires
> > changing the implementations. As an ABI compatible fix, change the
> > input clock of the systimer block a fixed factor divide-by-2 clock
> > that takes the 26 MHz oscillator as its input.
> >
> > Fixes: 5bc8e2875ffb ("arm64: dts: mt8183: add systimer0 device node")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> I generally not just like - but *love* - this change, I had that in my mind
> for a couple of months now and forgot about it because reasons.
>
> There's just one thing that, since we're doing this now, we can clarify (and
> that's important to avoid questions like "why isn't this board-specific"):
> the 26MHz clock "clk26m" oscillator that we're using for the system timers
> is a SoC-provided clock, and its name is "SYSCLK" as in "System bus clock".

Looking at the schematics it is terribly more complicated. :(

The crystal feeds the DCXO in the PMIC, which also acts as a buffer.
The PMIC then feeds the SoC and any other chips, such as a modem.

On other platforms we describe the oscillator at the dtsi level as well.
The reason why it isn't board-specific is that the requirements and
properties of the crystal are specified in the platform's datasheet,
i.e. it is a design requirement that every board use the same crystal.

I don't see the datasheet spelling out SYSCLK though. The TOPCKGEN part
mostly just refers to it as CLK26M, or some variant of it, which likely
denotes some fan-out branch. The system timer part also just says "26M"
or "26 MHz clock source".

Also, we can't change the clock name, as "clk26m" is hard-coded into
the clk drivers.

> I know that your target is to describe how we get from 26M to 13M, but at
> this point it may be worth it to use the right names to help preventing
> confusion about that clock not being an external crystal on the board but
> something internal to the SoC.

But as I described above, it is an actual crystal on the board. We are
simply omitting parts of the signal path. Notably the PMIC needs to be
excluded due to circular dependency reasons. And also we most definitely
don't want the system to be touching it.

ChenYu

> So, I propose:
> 1. Change `clk26m: oscillator` to `clk26m: sysclk` or `clk26m: sysclk-26m`;
> 2. Add the divider as `clk13m: sysclk-div2`.
>
> What do you think?
>
> Cheers,
> Angelo
>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 19ff1babc359..0cbbaebe1213 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -585,6 +585,15 @@ psci {
> >               method = "smc";
> >       };
> >
> > +     clk13m: fixed-factor-clock-13m {
> > +             compatible = "fixed-factor-clock";
> > +             #clock-cells = <0>;
> > +             clocks = <&clk26m>;
> > +             clock-div = <2>;
> > +             clock-mult = <1>;
> > +             clock-output-names = "clk13m";
> > +     };
> > +
> >       clk26m: oscillator {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> > @@ -968,8 +977,7 @@ systimer: timer@10017000 {
> >                                    "mediatek,mt6765-timer";
> >                       reg = <0 0x10017000 0 0x1000>;
> >                       interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> > -                     clocks = <&topckgen CLK_TOP_CLK13M>;
> > -                     clock-names = "clk13m";
> > +                     clocks = <&clk13m>;
> >               };
> >
> >               iommu: iommu@10205000 {
>
>
