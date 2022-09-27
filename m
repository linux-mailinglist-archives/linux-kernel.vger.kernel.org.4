Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82A5EBEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiI0Jtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiI0Jtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:49:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524DB6557
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:49:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5122410wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nq3WBeYXhCQSWiPmtePyjnaCUywGX1VqNE4Hjgy4wjc=;
        b=V1VJQbmw0izIU2rdeQJcqVR9AbM0sVv89CHIhahpjyv/i2me2zCtcOSEedttm9j6oi
         yw5ZlpSIa4yNFOqdKS3PuHnydhDiLPoID6JNCjkN+rf0DNcf2b8OsnGCNIXaO0eZgoq5
         EvbSlUY1ImqxreH0IC2/Q72qf2492665axweX4Ct5v+lpwu89vI8KtC8Vlg5uKIna00W
         7Ci+yz+V25R2JNkTGiyfuLL64YdICh0lthZUb81d6IIBGt5+eubvJi6FsP6W+SopJ24q
         1rx7ByHMathFUSgxMuV0Fvh0n0BLvwQBL1AflIa9PfhLBLpoL6PIiBxFSXDPHnADWT7v
         CxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nq3WBeYXhCQSWiPmtePyjnaCUywGX1VqNE4Hjgy4wjc=;
        b=Rc70E3r7ALwSqLLh7qWUThDom8wMnaOoYSXzzyfWsRhQTkrNJXEGSmZs+1lX/CQfKK
         +gzoNd2qVy/JQkEFFO8xttL9528lpWebWMW1f5kahUnyHAVI2TmtQvP6tiBbaf+kxcgX
         S65gJBAl7GFfFg0A1Uiidi0OlyeuzZOP2zCZrejlMs1EnnofGjuWWS5HlxkWIsEwSHRz
         gdB2ZOTAj6mQ7epUj57+bhfluHjdDBUcNedSwzL2fNt81sJ6W6wmHAfdAOK+GGPOWkx/
         aSsT7vEohnhM6+l3L3n/sTFPqPFLfN4kRSLSXD5ThKp2gXUdBIJ5kyOs72wspTitMbcs
         dsXg==
X-Gm-Message-State: ACrzQf1nYH583Zu9vYrTYuM974W8DHAjy447nJpsmwbNbuuSMvviCm0O
        eqBGg01ZjZciqMxWCjVoV9IvuazinddcxQpQl9zsoQ==
X-Google-Smtp-Source: AMsMyM6M89HqlD5eusQam02W5+l7q/StJRn0ZBEpd8Lzpy2VnGizkYIrEvsUOghaHY6iPZwXzF5II8l8+QwOJ/BFmAM=
X-Received: by 2002:a1c:f311:0:b0:3b5:18ca:fc5e with SMTP id
 q17-20020a1cf311000000b003b518cafc5emr1955721wmq.70.1664272165913; Tue, 27
 Sep 2022 02:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com> <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com> <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
 <20220909142247.GA238001@francesco-nb.int.toradex.com> <CAPDyKFrwpz=gi3iY5YsO6k4o33eLQRp-wXvBx3nQ0q=G9YrqHA@mail.gmail.com>
 <70ee4f8e-7529-307e-656c-2a65d0187af6@linaro.org> <CAPDyKFoyNWZvT+QPdX4sQuS3DL8mepfnLraHLusMi9K8MOfLgg@mail.gmail.com>
 <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org>
In-Reply-To: <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 11:48:48 +0200
Message-ID: <CAPDyKFrDFAif3DnvPoLrgJ2+fv+aB9GyOoG_O3q-1m=2Y5eT5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

[...]

> >>>>
> >>>> The main concern that was raised on this topic was that we have to
> >>>> somehow link the power-domain to the specific peripherals (the power
> >>>> domain consumer) in the device tree.
> >>>
> >>> Yes, that is needed. Although, I don't see how that is a concern?
> >>>
> >>> We already have the valid bindings to use for this, see more below.
> >>>
> >>>>
> >>>> Adding the power-domain property there will trigger validation errors
> >>>> unless we do explicitly add the power-domains to the schema for each
> >>>> peripheral we need this. To me this does not really work, but maybe I'm
> >>>> not understanding something.
> >>>>
> >>>> This is what Rob wrote on the topic [1]:
> >>>>   > No. For 'power-domains' bindings have to define how many there are and
> >>>>   > what each one is.
> >>>>
> >>>> Just as an example from patch [2]:
> >>>>
> >>>>   can1: can@0 {
> >>>>     compatible = "microchip,mcp251xfd";
> >>>>     power-domains = <&pd_sleep_moci>;
> >>>>   };
> >>>>
> >>>> leads to:
> >>>>
> >>>>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>>>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml
> >>>
> >>> I think it should be fine to just add the below line to the DT
> >>> bindings, for each peripheral device to fix the above problem.
> >>>
> >>> power-domains: true
> >>
> >> Again, as Rob said, no, because it must be strictly defined. So for
> >> example: "maxItems: 1" for simple cases. But what if device is then part
> >> of two power domains?
> >>
> >>>
> >>> That should be okay, right?
> >>
> >> Adding it to each peripheral scales poorly. Especially that literally
> >> any device can be part of such power domain.
> >
> > Right.
> >
> >>
> >> If we are going with power domain approach, then it should be applicable
> >> basically to every device or to every device of some class (e.g. I2C,
> >> SPI). This means it should be added to respective core schema in
> >> dtschema repo, in a way it does not interfere with other power-domains
> >> properties (existing ones).
> >
> > Isn't that already taken care of [1]?
>
> No, because it does not define the items (what are the power domains and
> how many). This binding expects that any device has maxItems restricting it.

Right, apologize for my ignorance.

>
> >
> > If there is more than one power domain per device, perhaps we may need
> > to extend it with a more strict binding? But, that doesn't seem to be
> > the case here - and if it turns out to be needed later on, we can
> > always extend the bindings, no?
> >
> > Note also that we already have DT bindings specifying "power-domains:
> > true" to deal with the above. Isn't that what we want?
>
> You mentioned it before and both me and Rob already responded - no,
> because it does not restrict the number of items.

Okay, so maxItems need to be specified for each peripheral. It's not a
big deal, right?

Of course, it would be even easier if the core schema would use a
default "maxItems: 1" for power domain consumers, which of course must
be possible to be overridden for those consumers that need something
else. But perhaps it's not that simple. :-)

Kind regards
Uffe
