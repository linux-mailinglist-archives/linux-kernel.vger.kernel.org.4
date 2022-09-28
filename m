Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B85ED701
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiI1IAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiI1IA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:00:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C2742AFB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:00:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm5so11114367plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lZABSm1MI5ZlgjTgFMO1+1NygwzeGaWl5MgvQA5quIY=;
        b=EbPTGC/2CFOGZdWxCZerJBIVQYHm8YqogP+f28KIdCJMXvNJKO91f7SN0E3tHB5UZK
         hGsTY+WAlShyt4kXWnofCNb+Mh1ZAgVSklBPMZ2x8IES5nIMGhvN2oBiBTfiMTblmzp5
         Jr7LRh0ZRy8rs7uR4BzYmV1j0XU8N8E/X2s1EnsgQQmF06MdAtP+3ItwD2BZIFVmya31
         kEgfsf1CLGmpyIgzy/clcIIaFTQZu0NAxbNdhQLKuYzWgpsOpmBm61mstf44Hr7d/eNE
         pbA0Sz/W2c1J3RIs7rn4uKdOS8n8jDgM+gsn/TEafOYR70qoRcEoj3et5hANEvMbLn0t
         VKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lZABSm1MI5ZlgjTgFMO1+1NygwzeGaWl5MgvQA5quIY=;
        b=R6ycgfFMnTe8S66Sg8EeXsSe/6Fo0rzWPnK/4Fx62/xwoDA+33CLCDgUsku8YlQqaf
         iurUEOXNbh1b/TBbceAWt4QNCZKkEaHIt/LzpubeZYr1Kla6HfkcGAKRvPV6Z/9DjbgV
         TFfWAJ3sSCqvzw9Joj2oJPJRPfPznwFjQ7hiGEn41X5R91HZ6Bs5PUEiDVe2V3Q5mj4h
         R/P5j8dDzODeZM/3bq7QU+KUQNYkD7cg6PDAv7xAEgAv+YTOXCuFr28OqG9kVx8jvoGX
         6FF11bgiSn0PAybvDTHXRUydPTpDIjzdVyQBMn+0rltPgIht7S1ElKyNr/58Tr9jPyWM
         kO3Q==
X-Gm-Message-State: ACrzQf2+FYhRVDUa+6CRihO6C9efQz+KvqWs6BoDPbIi2xEX3WoMLEFA
        5eRi2mufrG+Xeh64G2htpue0VyLjaTDZIvREIOL5QQ==
X-Google-Smtp-Source: AMsMyM5VvJq1nejmsS3ZKBBVTymO5kxUE6cwcbfDmLaB8CqM3/lls2eZb2mNaWYAjaYbYgasYZdl3z5DuN8XnCDLvl0=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr9025181pjq.202.1664352024285; Wed, 28
 Sep 2022 01:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com> <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com> <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
 <20220909142247.GA238001@francesco-nb.int.toradex.com> <CAPDyKFrwpz=gi3iY5YsO6k4o33eLQRp-wXvBx3nQ0q=G9YrqHA@mail.gmail.com>
 <70ee4f8e-7529-307e-656c-2a65d0187af6@linaro.org> <CAPDyKFoyNWZvT+QPdX4sQuS3DL8mepfnLraHLusMi9K8MOfLgg@mail.gmail.com>
 <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org> <CAPDyKFrDFAif3DnvPoLrgJ2+fv+aB9GyOoG_O3q-1m=2Y5eT5w@mail.gmail.com>
 <CAMuHMdVteS1va320fAAx445eFQ75XnapQbeGWEkg2aagnjN6Jg@mail.gmail.com> <a88274ce-279e-3a36-d929-1901d6b760cf@linaro.org>
In-Reply-To: <a88274ce-279e-3a36-d929-1901d6b760cf@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Sep 2022 09:59:46 +0200
Message-ID: <CAPDyKFpqsQRE7o=bupxFm0KCUCDm0=YwBgGUwq8RoFJi4V86Xg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sept 2022 at 16:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/09/2022 14:49, Geert Uytterhoeven wrote:
> > Hi Ulf,
> >
> > On Tue, Sep 27, 2022 at 11:49 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>>>>> The main concern that was raised on this topic was that we have to
> >>>>>>> somehow link the power-domain to the specific peripherals (the power
> >>>>>>> domain consumer) in the device tree.
> >>>>>>
> >>>>>> Yes, that is needed. Although, I don't see how that is a concern?
> >>>>>>
> >>>>>> We already have the valid bindings to use for this, see more below.
> >>>>>>
> >>>>>>>
> >>>>>>> Adding the power-domain property there will trigger validation errors
> >>>>>>> unless we do explicitly add the power-domains to the schema for each
> >>>>>>> peripheral we need this. To me this does not really work, but maybe I'm
> >>>>>>> not understanding something.
> >>>>>>>
> >>>>>>> This is what Rob wrote on the topic [1]:
> >>>>>>>   > No. For 'power-domains' bindings have to define how many there are and
> >>>>>>>   > what each one is.
> >>>>>>>
> >>>>>>> Just as an example from patch [2]:
> >>>>>>>
> >>>>>>>   can1: can@0 {
> >>>>>>>     compatible = "microchip,mcp251xfd";
> >>>>>>>     power-domains = <&pd_sleep_moci>;
> >>>>>>>   };
> >>>>>>>
> >>>>>>> leads to:
> >>>>>>>
> >>>>>>>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>>>>>>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml
> >>>>>>
> >>>>>> I think it should be fine to just add the below line to the DT
> >>>>>> bindings, for each peripheral device to fix the above problem.
> >>>>>>
> >>>>>> power-domains: true
> >>>>>
> >>>>> Again, as Rob said, no, because it must be strictly defined. So for
> >>>>> example: "maxItems: 1" for simple cases. But what if device is then part
> >>>>> of two power domains?
> >>>>>
> >>>>>>
> >>>>>> That should be okay, right?
> >>>>>
> >>>>> Adding it to each peripheral scales poorly. Especially that literally
> >>>>> any device can be part of such power domain.
> >>>>
> >>>> Right.
> >>>>
> >>>>>
> >>>>> If we are going with power domain approach, then it should be applicable
> >>>>> basically to every device or to every device of some class (e.g. I2C,
> >>>>> SPI). This means it should be added to respective core schema in
> >>>>> dtschema repo, in a way it does not interfere with other power-domains
> >>>>> properties (existing ones).
> >>>>
> >>>> Isn't that already taken care of [1]?
> >>>
> >>> No, because it does not define the items (what are the power domains and
> >>> how many). This binding expects that any device has maxItems restricting it.
> >>
> >> Right, apologize for my ignorance.
> >>
> >>>
> >>>>
> >>>> If there is more than one power domain per device, perhaps we may need
> >>>> to extend it with a more strict binding? But, that doesn't seem to be
> >>>> the case here - and if it turns out to be needed later on, we can
> >>>> always extend the bindings, no?
> >>>>
> >>>> Note also that we already have DT bindings specifying "power-domains:
> >>>> true" to deal with the above. Isn't that what we want?
> >>>
> >>> You mentioned it before and both me and Rob already responded - no,
> >>> because it does not restrict the number of items.
> >>
> >> Okay, so maxItems need to be specified for each peripheral. It's not a
> >> big deal, right?
>
> It's a bit of effort to add it manually to each device binding. It just
> does not scale well.

Whether it scales or not, that's how the power-domain bindings for
consumers look like. It's the similar situation for clocks, regulators
and other resources too.

My point is, for the discussion around $subject patch, it doesn't
really matter what option we pick. The DT docs for each peripheral
need to be updated anyway.

>
> >>
> >> Of course, it would be even easier if the core schema would use a
> >> default "maxItems: 1" for power domain consumers, which of course must
> >> be possible to be overridden for those consumers that need something
> >> else. But perhaps it's not that simple. :-)
>
> I think this would be the way to do it properly.
>
> >
> > It's not that simple: being part of a PM Domain is not a property of the
> > device being described, but a property of the integration into the SoC.
>
> I agree.
>
> This concept of power domains for every device does not look like really
> describing the hardware. The hardware itself, e.g. some camera sensor or
> I2C device, might have power supply and reset pin. It does not have
> something like power-domain.
>
> Although one could also argue that it is the same case with SoC blocks -
> being part of power domain is a property of a SoC and its power domain
> controller.

Yes. DT describes the platform too, not only the SoC and its IP blocks.

Moreover, as the power domain bindings were added back in kernel
v3.18, that's what we have to describe these kinds of platforms.

[...]

Kind regards
Uffe
