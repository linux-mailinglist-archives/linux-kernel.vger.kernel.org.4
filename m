Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DD6530E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLUMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:37:30 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540991A3A6;
        Wed, 21 Dec 2022 04:37:29 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h26so14588321vsr.5;
        Wed, 21 Dec 2022 04:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MKcCMPQNZUXl3AMPeB7WOuT6ex1tHrL1bNb+en/K8I=;
        b=F/hnre2VnTdmDEHXC2zXv8wfNT7aMx/0rz0w12/mgn1Nfeyr8NiwswlyGzU5EKb7Dq
         QfxU3tQbVhlROMYJ7YTNE6EXlvXcRXeeR9L+AxzpYLtXgj1TMFhnsqYPC6ucCqi2tcXD
         w9lxizIuGVxuewruscpvb3/0yJ0N3EMMjGvynhfPQKHrJ7FnyQozXYcC33tXf+SMuXXc
         XEIF3cMzYiG5tKuMOMRWvHCYtkoAaJWPGM4QKLsRl/FO4KuhPAN/j+4rynTh0hTlth9o
         N1cAr/z5LEWQh/3sHDT1YqtLNs8lTl92o2HPaZj+WwjpTkeJHxQQ8lnHpb/Ps/tBcC/g
         Qgzw==
X-Gm-Message-State: AFqh2kqoHOrQa8rSpHjf8WCPSI0tkGMzu5imYsS0ItH7uDu4l5o75P0Q
        trLmUQvr0Xo8Aaicj/F5gU1eJDOqdNlKBg==
X-Google-Smtp-Source: AMrXdXt+Z+JwfRgRiQltTcTd4HPRDvkZhCcU3KV9YrJH+i4gI7glChML5joKhe/I3ARUGIDBXoKWjA==
X-Received: by 2002:a05:6102:909:b0:3a8:3e42:ef9f with SMTP id x9-20020a056102090900b003a83e42ef9fmr393384vsh.25.1671626248029;
        Wed, 21 Dec 2022 04:37:28 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s191-20020a37a9c8000000b006feb0007217sm10582981qke.65.2022.12.21.04.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 04:37:27 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 203so11758783yby.10;
        Wed, 21 Dec 2022 04:37:27 -0800 (PST)
X-Received: by 2002:a25:ab49:0:b0:6de:6183:c5c3 with SMTP id
 u67-20020a25ab49000000b006de6183c5c3mr197746ybi.89.1671626247042; Wed, 21 Dec
 2022 04:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221221000242.340202-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221221000242.340202-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Dec 2022 13:37:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com>
Message-ID: <CAMuHMdXmKYV7CwuD=ZNgaOTc+LxP9OvEJ8gcW_iS5NamTxEE+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Wed, Dec 21, 2022 at 1:03 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document RZ/G2UL (R9A07G043U) IRQC bindings. The IRQC block on RZ/G2UL SoC
> is almost identical to one found on the RZ/G2L SoC the only difference
> being it can support BUS_ERR_INT for which it has additional registers.
> Hence new generic compatible string "renesas,rzg2ul-irqc" is added for
> RZ/G2UL SoC.
>
> Now that we have additional interrupt for RZ/G2UL and RZ/Five SoC
> interrupt-names property is added so that we can parse them based on
> names.
>
> While at it updated the example node to four spaces and added
> interrupt-names property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1- > v2
> * Dropped RB tags
> * Added generic compatible string for rzg2ul
> * Added interrupt-names
> * Added checks for RZ/G2UL to make sure interrupts are 42 and interrupt-names
> * Updated example node with interrupt-names
> * Used 4 spaces for example node

Thanks for the update!

> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -19,16 +19,19 @@ description: |
>      - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
>        stand-up edge detection interrupts)
>
> -allOf:
> -  - $ref: /schemas/interrupt-controller.yaml#
> -
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> -          - renesas,r9a07g054-irqc    # RZ/V2L
> -      - const: renesas,rzg2l-irqc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> +              - renesas,r9a07g054-irqc    # RZ/V2L
> +          - const: renesas,rzg2l-irqc
> +
> +      - items:
> +          - enum:
> +              - renesas,r9a07g043u-irqc   # RZ/G2UL
> +          - const: renesas,rzg2ul-irqc

I'm not sure it's worth splitting into RZ/G2L and RZ/G2UL alike
variants, and adding the "renesas,rzg2ul-irqc" family-specific
compatible value.  You can easily handle the difference by the presence
(or absence) of the "bus-err" interrupt source.

I understand there "renesas,r9a07g043f-irqc" will be added later to
support RZ/Five?

>
>    '#interrupt-cells':
>      description: The first cell should contain external interrupt number (IRQ0-7) and the
> @@ -44,7 +47,96 @@ properties:
>      maxItems: 1
>
>    interrupts:
> -    maxItems: 41
> +    minItems: 41
> +    items:
> +      - description: NMI interrupt
> +      - description: IRQ0 interrupt
> +      - description: IRQ1 interrupt
> +      - description: IRQ2 interrupt
> +      - description: IRQ3 interrupt
> +      - description: IRQ4 interrupt
> +      - description: IRQ5 interrupt
> +      - description: IRQ6 interrupt
> +      - description: IRQ7 interrupt
> +      - description: GPIO interrupt, TINT0
> +      - description: GPIO interrupt, TINT1
> +      - description: GPIO interrupt, TINT2
> +      - description: GPIO interrupt, TINT3
> +      - description: GPIO interrupt, TINT4
> +      - description: GPIO interrupt, TINT5
> +      - description: GPIO interrupt, TINT6
> +      - description: GPIO interrupt, TINT7
> +      - description: GPIO interrupt, TINT8
> +      - description: GPIO interrupt, TINT9
> +      - description: GPIO interrupt, TINT10
> +      - description: GPIO interrupt, TINT11
> +      - description: GPIO interrupt, TINT12
> +      - description: GPIO interrupt, TINT13
> +      - description: GPIO interrupt, TINT14
> +      - description: GPIO interrupt, TINT15
> +      - description: GPIO interrupt, TINT16
> +      - description: GPIO interrupt, TINT17
> +      - description: GPIO interrupt, TINT18
> +      - description: GPIO interrupt, TINT19
> +      - description: GPIO interrupt, TINT20
> +      - description: GPIO interrupt, TINT21
> +      - description: GPIO interrupt, TINT22
> +      - description: GPIO interrupt, TINT23
> +      - description: GPIO interrupt, TINT24
> +      - description: GPIO interrupt, TINT25
> +      - description: GPIO interrupt, TINT26
> +      - description: GPIO interrupt, TINT27
> +      - description: GPIO interrupt, TINT28
> +      - description: GPIO interrupt, TINT29
> +      - description: GPIO interrupt, TINT30
> +      - description: GPIO interrupt, TINT31
> +      - description: Bus error interrupt
> +
> +  interrupt-names:
> +    minItems: 41
> +    items:
> +      - const: nmi
> +      - const: irq0
> +      - const: irq1
> +      - const: irq2
> +      - const: irq3
> +      - const: irq4
> +      - const: irq5
> +      - const: irq6
> +      - const: irq7
> +      - const: tint0
> +      - const: tint1
> +      - const: tint2
> +      - const: tint3
> +      - const: tint4
> +      - const: tint5
> +      - const: tint6
> +      - const: tint7
> +      - const: tint8
> +      - const: tint9
> +      - const: tint10
> +      - const: tint11
> +      - const: tint12
> +      - const: tint13
> +      - const: tint14
> +      - const: tint15
> +      - const: tint16
> +      - const: tint17
> +      - const: tint18
> +      - const: tint19
> +      - const: tint20
> +      - const: tint21
> +      - const: tint22
> +      - const: tint23
> +      - const: tint24
> +      - const: tint25
> +      - const: tint26
> +      - const: tint27
> +      - const: tint28
> +      - const: tint29
> +      - const: tint30
> +      - const: tint31
> +      - const: bus-err

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
