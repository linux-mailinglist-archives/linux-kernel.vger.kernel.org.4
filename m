Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE345629BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiKOOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKOOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:25 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEEC2B610;
        Tue, 15 Nov 2022 06:11:24 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id d7so7116816qkk.3;
        Tue, 15 Nov 2022 06:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEBoPkzZkEwXxKxn/LguL/Tj7JNM9p+vnmqYk3f/wqg=;
        b=t+0BF7v8qNwl9dvZTGsWpEK+153oiJxHnUloU7OOA0OaFRDMXH0pSRjkcJZ6BsCKl1
         S6eYj4vqa6qZhJ9aFpnn/gZLc8qvygceWJ7YyzssLq8EE8NFmBkM+P/I/ZqXVGzHUZHp
         pUzQy4dxAWIe9cu/t3V2df8p8++ehhoZlg8grw1umexHn2nTGF/9iiuqTnDWtpcrHA5b
         iJCH1P/VaDKDQsiFe4IcrQ42KENs0/eLQp/Mk3XfNEIqlL72ivtrOJR1EAmXCUupFK8F
         4cGzgGlEN7E2KntsrycO5WRYTfjfocYLxqFBqOldwkFq6/lzzSaXw4UTu851kFujJNoK
         J8MQ==
X-Gm-Message-State: ANoB5pnQI6ahEvOZvvv775rU3iR2BaXi5uWFh1e+zxNTgzBDP2cG17IF
        iigkjw8o4tTIWGQ2CkE62HMc76UuD8zbjw==
X-Google-Smtp-Source: AA0mqf4QG3pJAV5zFRWByezi8YOB5YXep940kO74qeNszq9lLHnXXhlsaBbglsJ7hUOzoiEMHI69Dw==
X-Received: by 2002:a37:c245:0:b0:6ee:909e:ed6c with SMTP id j5-20020a37c245000000b006ee909eed6cmr15276266qkm.264.1668521483304;
        Tue, 15 Nov 2022 06:11:23 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g26-20020ac8469a000000b003a5416da03csm7193453qto.96.2022.11.15.06.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:11:21 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 63so17300258ybq.4;
        Tue, 15 Nov 2022 06:11:20 -0800 (PST)
X-Received: by 2002:a25:844b:0:b0:6de:6c43:3991 with SMTP id
 r11-20020a25844b000000b006de6c433991mr15875248ybm.604.1668521478365; Tue, 15
 Nov 2022 06:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-7-herve.codina@bootlin.com> <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
In-Reply-To: <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 15:11:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHEc6XYcdrcZ=H_wjBy4vFBTRjUDE2rRmGd+Jyg7BzDQ@mail.gmail.com>
Message-ID: <CAMuHMdUHEc6XYcdrcZ=H_wjBy4vFBTRjUDE2rRmGd+Jyg7BzDQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 15, 2022 at 2:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/11/2022 12:15, Herve Codina wrote:
> > Add the USBF controller available in the r9a06g032 SoC.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> > index 563024c9a4ae..a4bb069457a3 100644
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -117,6 +117,18 @@ dmamux: dma-router@a0 {
> >                       };
> >               };
> >
> > +             udc: usb@4001e000 {
> > +                     compatible = "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
> > +                     reg = <0x4001e000 0x2000>;
> > +                     interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&sysctrl R9A06G032_HCLK_USBF>,
> > +                              <&sysctrl R9A06G032_HCLK_USBPM>;
> > +                     clock-names = "hclkf", "hclkpm";
> > +                     power-domains = <&sysctrl>;
> > +                     status = "disabled";
>
> If you provided all resources (clocks, power domains etc), why disabling it?

Doesn't this depend on wiring on the board, and providing pin control
in the board DTS?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
