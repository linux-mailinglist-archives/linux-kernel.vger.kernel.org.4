Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58445619301
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKDIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKDIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:55:46 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B727B00;
        Fri,  4 Nov 2022 01:55:44 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id ml12so2825203qvb.0;
        Fri, 04 Nov 2022 01:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHvf7TO13NiRepNOl3pQQUFpejKFz3jWeeX9C6rTH50=;
        b=3wQkgg0M22Tdl0e+WYUf//k1HZJQZCym/2tYicICRr0AfxAKAzdd0Kb3o9IvP1Cye4
         qEqnhw2F7GBY3zX/BL60MO8Yk6D30HeWrpgibCbIka30Q7asDZ4Q3MKUt96yq8cCss/O
         dCdG/fxnMZYPjlHSIRUtlQG/D6CmHD7EZ/dfwWO3W7FYy/XBKOkD+Pe/HhcwXgg2VPxM
         LGQ5illmnAS9FvDP2FBgvPug2OhjngsxQFsQzykHRWtUqt4jPxGBxnVQoKgZIDoBmrZb
         UYXGzxqiGrpvl0ASYEpmiImFG49gZsRjk01ZHAvWX3vlVzt1i6d40fXFT1Oa8Chmz3eh
         Omuw==
X-Gm-Message-State: ACrzQf27storwgvHMm3Su7hUg925LVEBmrKRa2grqJOamZ1sKvu0Ode6
        7gKiGqcC3qG6YsVEZNZUbThCHb7U0/Cp8w==
X-Google-Smtp-Source: AMsMyM55vd3E3y9WCYK0wd2r1+XcBd4ZQDAH5IzfkXtzA4pJhHSe7BAzQ83N6YiRnFLY8EtvQOxBhg==
X-Received: by 2002:ad4:5c47:0:b0:4bc:f84:da8f with SMTP id a7-20020ad45c47000000b004bc0f84da8fmr18424813qva.73.1667552143839;
        Fri, 04 Nov 2022 01:55:43 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id bk14-20020a05620a1a0e00b006f3e6933bacsm2458151qkb.113.2022.11.04.01.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 01:55:43 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id j2so5070755ybb.6;
        Fri, 04 Nov 2022 01:55:42 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr21218538ybc.89.1667552142441; Fri, 04
 Nov 2022 01:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
 <20221103230648.53748-3-fabrizio.castro.jz@renesas.com> <7fcd798a-9cce-9453-1657-7be1abf3b97e@linaro.org>
In-Reply-To: <7fcd798a-9cce-9453-1657-7be1abf3b97e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Nov 2022 09:55:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-b-DoNGeccO82bh4s9d7HKh_7o5W967a_iKBMo-fckw@mail.gmail.com>
Message-ID: <CAMuHMdX-b-DoNGeccO82bh4s9d7HKh_7o5W967a_iKBMo-fckw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
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

On Fri, Nov 4, 2022 at 2:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 03/11/2022 19:06, Fabrizio Castro wrote:
> > s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.
> >
> > renesas,i2c-r9a09g011 is not actually used by the driver, therefore
> > changing this doesn't cause any harm.
>
> And what about other users of DTS? One chosen driver implementation
> might not be enough...
>
> >
> > Fixes: ba7a4d15e2c4 ("dt-bindings: i2c: Document RZ/V2M I2C controller")
>
> You need to explain the bug - where is the issue, how it affects users.
> Otherwise it is not a bug and there is nothing to fix.

Yep.

    The preferred form is "<vendor>,<family>-<module>", blah blah ...

> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
> > index c46378efc123..92e899905ef8 100644
> > --- a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
> > @@ -16,7 +16,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > -          - renesas,i2c-r9a09g011  # RZ/V2M
> > +          - renesas,r9a09g011-i2c  # RZ/V2M
>
> No.
>
> Deprecate instead old compatible. There are already users of it, at
> least in kernel. Not sure about other OS/bootloaders/firmwares.

As stated in the cover letter:

    Since it's early days for r9a09g011.dtsi, and compatible
    renesas,i2c-r9a09g011 isn't being actively used at the moment,
    I think it's safe to change to make compatible strings less
    confusing.

The bindings entered in v6.0.
The first user in the kernel is not yet in a released kernel, it will
be in v6.1. So it can still be fixed in v6.1...
Even if we don't fix it before v6.2, I don't think there is much harm in
making this change.

With the patch description improved:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
