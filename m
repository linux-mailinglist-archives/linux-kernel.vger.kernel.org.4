Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81B36C87FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCXWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjCXWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:04:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7F15899;
        Fri, 24 Mar 2023 15:03:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l27so3152595wrb.2;
        Fri, 24 Mar 2023 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695435;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ3RSbBi4GxRzlwFNletxU5cxz92xG3Lj6FTyrjdc0o=;
        b=T3F8aNz2ox9uoURQlE0mq2sXW4z262BpvG7ZxRtAtIbFhPc/TQEpQM0a0SgR+TrqHO
         CLYGJXT6hxHwzdY9UN32CZG2dOkIF2LFvXUPmwkIF/2GkwmMW7kb6axItHjQcEjAF96P
         YoZ2Q3loL8sCvN2e52vHQqe+AQbmZyqmh9t2+HCpPytsWAA2sxbaBc61b92bJ1dDr0QQ
         Tdx2iHxB/Aa/m/jyDHMcs00O0mdizZduxSlMQxMVQw/7cAeVdYgYGEV+MFN8ajK6+qK2
         SFuRxlx0kY19AQ86OkmU5aCJ9GqDDqrZ45+h67Pz4nAn4V4ElL3E8abtemphkRCVy/gF
         HzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695435;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ3RSbBi4GxRzlwFNletxU5cxz92xG3Lj6FTyrjdc0o=;
        b=nmxnWhLnjHt3vcEBGatjhUU02G51BLUYULi2BQs8T4icOYnbGK69tW1ZyhLdYQcMdB
         lQ0/cjB5ysCngJr+CEm08KzBxQPdvw9X2h6gTwaZr765p/kVhGS3ZHa9p2MkUwe4i6DO
         +mq78Ig92aPgTQIc1F70Sq/YjIDabu83Pt9ZFe8r6o9fb3z0cRTseWTLlOrOFg+vtI2b
         pm+PiiHs2A9PrdXj9dpJ6nghIOvs3c/SBtAPr8/4HfP3MAPqgCx3MF2VYczslInfrCzo
         1GdO642oQVdIw8XR/hKtcau1UhnMIXiv9pEJQI5nRdopNyqqUpazgyVMpzeyhK/CGJCu
         +E6Q==
X-Gm-Message-State: AAQBX9ccfpBnfgybTJcuB6w0QlS5vELRyLYPQwuxym7dv63XmkNTTpek
        gNP11EBchsClD+5U2Z4sRJo=
X-Google-Smtp-Source: AKy350bTnEgVdoWb1kTWyTj04kbZ8RkYf2o8/EHnYZiiSg63myut6K0B/vHtQugbPkbZgvwsB8kF9A==
X-Received: by 2002:adf:e905:0:b0:2ce:a096:3ff2 with SMTP id f5-20020adfe905000000b002cea0963ff2mr3187613wrm.63.1679695434807;
        Fri, 24 Mar 2023 15:03:54 -0700 (PDT)
Received: from localhost (94.197.5.156.threembb.co.uk. [94.197.5.156])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002be5bdbe40csm19237361wrs.27.2023.03.24.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:03:54 -0700 (PDT)
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
 <20221018-clk-range-checks-fixes-v2-56-f6736dec138e@cerno.tech>
 <80VTKR.CE8RVN8M3ZYK3@crapouillou.net>
 <20221104145946.orsyrhiqvypisl5j@houat>
 <cp7Yh29ndlOOi1yW8KwCcpzoLPLxm1vR@localhost>
 <20221107085417.xrsh6xy3ouwdkp4z@houat>
 <ucJ6KSBqdPTxfxUQqLUr9C9RGiQRnY1I@localhost>
 <20221109110045.j24vwkaq3s4yzoy3@houat>
 <06a293adc75990ed3e297b076fc38d8a.sboyd@kernel.org>
 <xpKMzGb1sOsucWMTlJIMzrT5KjLlZ7JP@localhost>
 <20230324111959.frjf4neopbs67ugd@houat>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
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
Date:   Fri, 24 Mar 2023 20:58:48 +0000
In-reply-to: <20230324111959.frjf4neopbs67ugd@houat>
Message-ID: <rTJKpeLOBeu3eOLW5z3P5fEpcOJJLrGs@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maxime Ripard <maxime@cerno.tech> writes:

> On Thu, Mar 23, 2023 at 03:35:30PM +0000, Aidan MacDonald wrote:
>>
>> Stephen Boyd <sboyd@kernel.org> writes:
>>
>> > Quoting Maxime Ripard (2022-11-09 03:00:45)
>> >> On Mon, Nov 07, 2022 at 08:57:22PM +0000, Aidan MacDonald wrote:
>> >> >
>> >> > Maxime Ripard <maxime@cerno.tech> writes:
>> >> >
>> >> > > Hi,
>> >> > >
>> >> > > On Fri, Nov 04, 2022 at 05:35:29PM +0000, Aidan MacDonald wrote:
>> >> >
>> >> > Assigning the parent clock in the DT works once, at boot, but going off
>> >> > what you wrote in the commit message, if the clock driver has a
>> >> > .determine_rate() implementation that *can* reparent clocks then it
>> >> > probably *will* reparent them, and the DT assignment will be lost.
>> >>
>> >> Yes, indeed, but assigned-clock-parents never provided any sort of
>> >> guarantee on whether or not the clock was allowed to reparent or not.
>> >> It's just a one-off thing, right before probe, and a clk_set_parent()
>> >> call at probe will override that just fine.
>> >>
>> >> Just like assigned-clock-rates isn't permanent.
>> >>
>> >> > What I'm suggesting is a runtime constraint that the clock subsystem
>> >> > would enforce, and actively prevent drivers from changing the parent.
>> >> > Either explicitly with clk_set_parent() or due to .determine_rate().
>> >> >
>> >> > That way you could write a .determine_rate() implementation that *can*
>> >> > select a better parent, but if the DT applies a constraint to fix the
>> >> > clock to a particular parent, the clock subsystem will force that parent
>> >> > to be used so you can be sure the clock is never reparented by accident.
>> >>
>> >> Yeah, that sounds like a good idea, and CLK_SET_RATE_NO_REPARENT isn't
>> >> too far off from this, it's just ignored by clk_set_parent() for now. I
>> >> guess we could rename CLK_SET_RATE_NO_REPARENT to CLK_NO_REPARENT, make
>> >> clk_set_parent handle it, and set that flag whenever
>> >> assigned-clock-parents is set on a clock.
>> >>
>> >> It's out of scope for this series though, and I certainly don't want to
>> >> deal with all the regressions it might create :)
>> >>
>> >
>> > This sounds like a new dt binding that says the assigned parent should
>> > never change. It sounds sort of like gpio hogs. A clock-hogs binding?
>>
>> Ideally we want the clock driver to be able to reparent clocks freely
>> to get the best rate. But we also need some control over that to stop
>> consumers from being reparented in undesired ways. Eg. you might want
>> to make sure the GPU gets its own PLL so it can be reclocked easily,
>> and putting another device on the GPU's PLL could prevent that.
>>
>> The only way to achieve this today is (1) never do any reparenting in
>> the clock driver; and (2) use assigned-clock-parents in the DT to set
>> up the entire clock tree manually.
>>
>> Maxime said that (2) is basically wrong -- if assigned-clock-parents
>> provides no guarantee on what the OS does "after boot" then the OS is
>> pretty much free to ignore it.
>
> I didn't really say it's wrong, just that it never provided the
> guarantee you expect it to provide. I can't really say whether it's an
> issue or not on your platform.
>
> It's mostly unrelated to this series though, none of these patches
> affect that behavior in one way or the other.

I know. Sorry for derailing your patch :(

>> My suggestion: add a per-clock bitmap to keep track of which parents
>> are allowed. Any operation that would select a parent clock not on the
>> whitelist should fail. Automatic reparenting should only select from
>> clocks on the whitelist. And we need new DT bindings for controlling
>> the whitelist, for example:
>>
>>     clock-parents-0 = <&clk1>, <&pll_c>;
>>     clock-parents-1 = <&clk2>, <&pll_a>, <&pll_b>;
>>
>> This means that clk1 can only have pll_c as a parent, while clk2 can
>> have pll_a or pll_b as parents. By default every clock will be able
>> to use any parent, so a list is only needed if the machine needs a
>> more restrictive policy.
>>
>> assigned-clock-parents should disable automatic reparenting, but allow
>> explicit clk_set_parent(). This will allow clock drivers to start doing
>> reparenting without breaking old DTs.
>
> I'm generally not a fan of putting all these policies in the device
> tree. Do you have an example where it wouldn't be possible to do exactly
> this from the driver itself?
>
> Maxime

I'm confused. What's implicit in the example is clk1 and clk2 might
have *other* possible choices of parent clock and the device tree is
limiting what the OS is allowed to choose.

Why would you put such arbitrary limitations into the driver? They
would be different from machine to machine, unless the clock tree is
so simple there is only *one* meaningful way to configure it. Most
SoCs are complicated enough that there will be tradeoffs depending
on what peripherals you are using (typically a single machine will
not use *every* peripheral device provided by the SoC).
