Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4C73BB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFWPUl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjFWPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:20:01 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2781AC;
        Fri, 23 Jun 2023 08:19:59 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-440b31263f5so273172137.0;
        Fri, 23 Jun 2023 08:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533598; x=1690125598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILQtktcDzZ1jDAABaDuOMKEHo85IkfnjEuCD0npTbLY=;
        b=iBU2mq5aXE1QRyUFKhgEghOL7FmS7K7THjFF6I9A1b7DOsGcNADez9RW+MA93uKMqD
         ls1biTqCwWJysffom6+Tloq91Q5izFkfXpjDzSM1taBozV2IRuOftrm+GhPeUU3bWVcn
         zmad95SkwewEmMR2TXP9F4NVdUsUqLAzZQfLatzFhKaNv9FfIabExAB/aPArz70qCW4u
         Nx9pbOGrjHByHAl1DPI9dhTscYbESUysiajfcSk7pLs6IZc0VrbuNKiYMsuSxkDZMwov
         W+CMC2+2aVP11k604tiLTsEr4kIvtW7uqhv09vXjerhCGlrOGOvnNHp2nnBWD0x1Lr9A
         D40g==
X-Gm-Message-State: AC+VfDyf6KMTBDKVoHo8rcdPbLSMwjwgatV9bc9Ht9IFJrYI5AXYHyxw
        oNmbs2zIdVZ+Zvs+0atiLHVJpLXRkuySvA==
X-Google-Smtp-Source: ACHHUZ7nCvzPr3ZEO/UvwD5THLFu3Pdsu7Nobq32rJpTlCcRZ+6Z0JuwJR+gWerOb9udTjI6ECe41Q==
X-Received: by 2002:a05:6102:3651:b0:440:a9df:31b9 with SMTP id s17-20020a056102365100b00440a9df31b9mr9170910vsu.18.1687533598041;
        Fri, 23 Jun 2023 08:19:58 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id m22-20020a9f3116000000b0078f3657faa5sm1214849uab.36.2023.06.23.08.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:19:57 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4715cbe0422so293791e0c.3;
        Fri, 23 Jun 2023 08:19:57 -0700 (PDT)
X-Received: by 2002:a1f:da87:0:b0:476:3544:773 with SMTP id
 r129-20020a1fda87000000b0047635440773mr1046946vkg.11.1687533596966; Fri, 23
 Jun 2023 08:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
 <20230623144312.GE2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623144312.GE2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 17:19:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdknNczxXod7b6znBHSgXVEb9oNZCAajKCc0Spm1SrYQ@mail.gmail.com>
Message-ID: <CAMuHMdXdknNczxXod7b6znBHSgXVEb9oNZCAajKCc0Spm1SrYQ@mail.gmail.com>
Subject: Re: [PATCH 01/39] dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 23, 2023 at 4:43 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Jun 22, 2023 at 11:21:13AM +0200, Geert Uytterhoeven wrote:
> > Add device tree bindings for the LCD Controller (LCDC) found in Renesas
> > SuperH SH-Mobile and ARM SH/R-Mobile SOCs.
> >
> > Based on a plain text prototype by Laurent Pinchart.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas SH-Mobile LCD Controller (LCDC)
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> I'd be happy if you co-maintained this with me :-) Or even took
> ownership completely.

OK. Thinking about it ;-)

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,r8a7740-lcdc # R-Mobile A1
> > +      - renesas,sh73a0-lcdc  # SH-Mobile AG5
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 5
> > +    description:
> > +      Only the functional clock is mandatory.
> > +      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
> > +      "vou" or "dv_clk") is available on R-Mobile A1 only).
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 5
> > +    items:
> > +      enum: [ fck, media, lclk, hdmi, video ]
>
> Switching to per-item descriptions would allow documenting which clock
> applies to which SoC.
>
> Are enum items unique by default ?

Given how about all clocks but fck are optional, it's a bit hard
to handle this in a perfect way.
Note that "pattern: '^dclkin\.[0123]$'" in renesas,du.yaml has the same issue.

> This would allow a combination of clocks that doesn't include the fck
> clock, that's not right.

Right. But when fixing the first to "fck", you have to duplicate all others.
So it should become something like:

  - const: fck
  - enum: [ media, lclk, hdmi, video ]
  - enum: [ media, lclk, hdmi, video ]
  - enum: [ media, lclk, hdmi, video ]
  - enum: [ media, lclk, hdmi, video ]

>
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: |
> > +      The connections to the output video ports are modeled using the OF graph
> > +      bindings specified in Documentation/devicetree/bindings/graph.txt.
>
> it's available in YAML form now. I'd just drop the "specified in ...".

OK.

> > +      The number of ports and their assignment are model-dependent.
> > +      Each port shall have a single endpoint.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
> > +        unevaluatedProperties: false
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: HDMI port (R-Mobile A1 LCDC1 and SH-Mobile AG5)
> > +        unevaluatedProperties: false
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: MIPI-DSI port (SH-Mobile AG5)
> > +        unevaluatedProperties: false
>
> Let's condition the ports on the compatible value to enable automatic
> validation.
>
> > +
> > +    required:
> > +      - port@0
>
> Based on the above, port@1 is required too as it's present on all
> supported SoCs. Let's condition this on the compatible value too.

It does not depend solely on the SoC, but also on the LCDC instance.
port@1 is not available on R-Mobile A1 LCDC0, only on LCDC1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
