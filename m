Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB586962AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBNLtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBNLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:49:12 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796323849;
        Tue, 14 Feb 2023 03:49:10 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id j5so8018560qvi.3;
        Tue, 14 Feb 2023 03:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8o+V62iNadVynv0wmjLeHQllkaxUHndiQdcgv2rq9I=;
        b=zlo7Nb2jOqAVZTLCKV5Vwy24nYm6ew3YY1tAWT9kpLVpRF3xrNZDuPTtpjgKVTsgzc
         qN6cQc0cSXobhmhccnry5T1XfRy8UhgZzRoAvSNk/Sn4icFg3PnuhGBFnM/jfyH/I5Zb
         PpPg8LwynNvc9FRTaotakNv69kRILUTFcQ+0H++KfthAPfFda7l/bA/MWsLI9gAw8bp5
         DxlrTUlb64+J71q5Oc0mDf5YHVuiBsFWB2goDdfvYmdFLulKOTpv3UdeP7LMsz4Q5ihg
         YLatTqCWzurzKMJ4OHYkwbGIkQNt0ta9UydA+Ij/uQFFfk73AVKNYxx7rINGaeYXUJWk
         WxCQ==
X-Gm-Message-State: AO0yUKWTHHU6MyHbVmIViP6+dxWk1ZHPjYojP834ST3QpVqMEDdTCQOW
        Asl7BER0geQIBxPpbnzTT+KSWdJDZavrZ1Gk
X-Google-Smtp-Source: AK7set+vnjtZpYChSQqPL/m2PDeo5t6vdFw9rHu/QMb60KkUwaf2rH18ypWUWGCDYrulFw4AVnw6/A==
X-Received: by 2002:ad4:5dcb:0:b0:56e:a07b:f4db with SMTP id m11-20020ad45dcb000000b0056ea07bf4dbmr5071213qvh.24.1676375349736;
        Tue, 14 Feb 2023 03:49:09 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x188-20020a3795c5000000b00721299cfffesm11700756qkd.39.2023.02.14.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:49:09 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-52f0001ff8eso103759237b3.4;
        Tue, 14 Feb 2023 03:49:08 -0800 (PST)
X-Received: by 2002:a81:4f11:0:b0:52f:972:e6a1 with SMTP id
 d17-20020a814f11000000b0052f0972e6a1mr227619ywb.235.1676375348561; Tue, 14
 Feb 2023 03:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20230130191152.182826-1-fabrizio.castro.jz@renesas.com> <24bac8be-c301-8efd-4392-e10db00d17f7@linaro.org>
In-Reply-To: <24bac8be-c301-8efd-4392-e10db00d17f7@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Feb 2023 12:48:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW+RZ73iPJMk-omC4egqBMGPJFeMoUkvcowkO51rN2oGQ@mail.gmail.com>
Message-ID: <CAMuHMdW+RZ73iPJMk-omC4egqBMGPJFeMoUkvcowkO51rN2oGQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 9:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 30/01/2023 20:11, Fabrizio Castro wrote:
> > The RZ/V2M EVK comes with a slot for a uSD card, and an eMMC.
> > Add support for the both of them.
> >
> > Please note that the pinctrl driver for RZ/V2M doesn't support
> > interrupts yet, therefore the card detect pin has been connected
> > to the SDHI IP directly in this patch.
> > We'll connect the card detect pin to its corresponding GPIO when
> > we'll have driver support for interrupts in the RZ/V2M pinctrl
> > driver.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> > +
> > +
>
> Just one blank line

Fixing...

> >  &extal_clk {
> >       clock-frequency = <48000000>;
> >  };
> > @@ -69,6 +118,26 @@ &i2c2 {
> >  };
> >
> >  &pinctrl {
> > +     emmc_pins: emmc {
> > +             emmc_pins_data {
>
> No underscores in node names.

... and renaming to "data" etc. while queuing in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
