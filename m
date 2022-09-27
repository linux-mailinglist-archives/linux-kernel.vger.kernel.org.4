Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC45EC348
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiI0Mt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiI0MtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:49:19 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC4167066;
        Tue, 27 Sep 2022 05:49:17 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id x18so5911004qkn.6;
        Tue, 27 Sep 2022 05:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kxKNS5DDyDVwQYf8SSh+Z282XSXl8OO2BaUjOfJxTOs=;
        b=xb6AyPT0DL1frZJ//0cOhbZdCmM8J0lIRf1W6Pmx9QR/wzkQOLYzooofyE033sdQT4
         BVhg9ssWXT74uSFLT0DM+441DkrbYQJIigzv9desA8Poa3mDemECt//lO0IJGHgpA0Cq
         V57BkUfYvtC8vIfogrIvouNHfZch3XwNYKM5jRoq1EYvbSGe9PPcfCYehdRQnZIfQViH
         J/xMC2dAHAapwcBxP9KrV/0CKaXCkpsLIeVMGMiGT9+ex7qXXVogKizDA5HZryJPa0sq
         i8/A03XLyzBvMIwMGW2CBuH9I0IgPEjUUoKUK3G1bZNDGypbgsh7M8guQdinP969h/J9
         SZ6Q==
X-Gm-Message-State: ACrzQf3rQ0d/VHEdO7GWNciJu+Az6WGZGnJeAkUJFId1thvI8UEsOBmi
        /UPL+gM79Ns3/SPmDvi2lNIoEH5hWr5JUQ==
X-Google-Smtp-Source: AMsMyM4CyBLabq0ZbBgwCR3Gqlzbn0bg99UnLwPevLhtmzH5TJDJkERMQLybGBIbqSfb1g5ZxmyyPA==
X-Received: by 2002:a37:852:0:b0:6cf:7510:3c91 with SMTP id 79-20020a370852000000b006cf75103c91mr14259370qki.657.1664282956686;
        Tue, 27 Sep 2022 05:49:16 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a269900b006cea2984c9bsm939654qkp.100.2022.09.27.05.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:49:16 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 4so3923511ybe.2;
        Tue, 27 Sep 2022 05:49:15 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr24148017ybl.604.1664282955514; Tue, 27
 Sep 2022 05:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com> <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com> <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
 <20220909142247.GA238001@francesco-nb.int.toradex.com> <CAPDyKFrwpz=gi3iY5YsO6k4o33eLQRp-wXvBx3nQ0q=G9YrqHA@mail.gmail.com>
 <70ee4f8e-7529-307e-656c-2a65d0187af6@linaro.org> <CAPDyKFoyNWZvT+QPdX4sQuS3DL8mepfnLraHLusMi9K8MOfLgg@mail.gmail.com>
 <d19ffd93-bbb3-ac61-0ec3-58fd48443eb2@linaro.org> <CAPDyKFrDFAif3DnvPoLrgJ2+fv+aB9GyOoG_O3q-1m=2Y5eT5w@mail.gmail.com>
In-Reply-To: <CAPDyKFrDFAif3DnvPoLrgJ2+fv+aB9GyOoG_O3q-1m=2Y5eT5w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 14:49:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVteS1va320fAAx445eFQ75XnapQbeGWEkg2aagnjN6Jg@mail.gmail.com>
Message-ID: <CAMuHMdVteS1va320fAAx445eFQ75XnapQbeGWEkg2aagnjN6Jg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Tue, Sep 27, 2022 at 11:49 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >>>> The main concern that was raised on this topic was that we have to
> > >>>> somehow link the power-domain to the specific peripherals (the power
> > >>>> domain consumer) in the device tree.
> > >>>
> > >>> Yes, that is needed. Although, I don't see how that is a concern?
> > >>>
> > >>> We already have the valid bindings to use for this, see more below.
> > >>>
> > >>>>
> > >>>> Adding the power-domain property there will trigger validation errors
> > >>>> unless we do explicitly add the power-domains to the schema for each
> > >>>> peripheral we need this. To me this does not really work, but maybe I'm
> > >>>> not understanding something.
> > >>>>
> > >>>> This is what Rob wrote on the topic [1]:
> > >>>>   > No. For 'power-domains' bindings have to define how many there are and
> > >>>>   > what each one is.
> > >>>>
> > >>>> Just as an example from patch [2]:
> > >>>>
> > >>>>   can1: can@0 {
> > >>>>     compatible = "microchip,mcp251xfd";
> > >>>>     power-domains = <&pd_sleep_moci>;
> > >>>>   };
> > >>>>
> > >>>> leads to:
> > >>>>
> > >>>>   imx8mm-verdin-nonwifi-dahlia.dtb: can@0: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >>>>           From schema: .../bindings/net/can/microchip,mcp251xfd.yaml
> > >>>
> > >>> I think it should be fine to just add the below line to the DT
> > >>> bindings, for each peripheral device to fix the above problem.
> > >>>
> > >>> power-domains: true
> > >>
> > >> Again, as Rob said, no, because it must be strictly defined. So for
> > >> example: "maxItems: 1" for simple cases. But what if device is then part
> > >> of two power domains?
> > >>
> > >>>
> > >>> That should be okay, right?
> > >>
> > >> Adding it to each peripheral scales poorly. Especially that literally
> > >> any device can be part of such power domain.
> > >
> > > Right.
> > >
> > >>
> > >> If we are going with power domain approach, then it should be applicable
> > >> basically to every device or to every device of some class (e.g. I2C,
> > >> SPI). This means it should be added to respective core schema in
> > >> dtschema repo, in a way it does not interfere with other power-domains
> > >> properties (existing ones).
> > >
> > > Isn't that already taken care of [1]?
> >
> > No, because it does not define the items (what are the power domains and
> > how many). This binding expects that any device has maxItems restricting it.
>
> Right, apologize for my ignorance.
>
> >
> > >
> > > If there is more than one power domain per device, perhaps we may need
> > > to extend it with a more strict binding? But, that doesn't seem to be
> > > the case here - and if it turns out to be needed later on, we can
> > > always extend the bindings, no?
> > >
> > > Note also that we already have DT bindings specifying "power-domains:
> > > true" to deal with the above. Isn't that what we want?
> >
> > You mentioned it before and both me and Rob already responded - no,
> > because it does not restrict the number of items.
>
> Okay, so maxItems need to be specified for each peripheral. It's not a
> big deal, right?
>
> Of course, it would be even easier if the core schema would use a
> default "maxItems: 1" for power domain consumers, which of course must
> be possible to be overridden for those consumers that need something
> else. But perhaps it's not that simple. :-)

It's not that simple: being part of a PM Domain is not a property of the
device being described, but a property of the integration into the SoC.

All synchronous hardware needs power (single/multiple), clock(s), and
reset(s).  But the granularity of control over power(s), clocks, and resets
depends on the integration.  So the related properties can appear
anywhere.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
