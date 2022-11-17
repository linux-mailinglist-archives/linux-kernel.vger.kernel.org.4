Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F462D89C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiKQK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiKQKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:55:43 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D060360;
        Thu, 17 Nov 2022 02:54:09 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id c15so792711qtw.8;
        Thu, 17 Nov 2022 02:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIhS9kUWRte6tp6oPguGoJfmoXVyyx+AXGkevCZ7vGM=;
        b=O0Sf4hUhl+zWLJ0OMY6gPHqHmg/wX7Z1lua4ux8M3OpKu6hJ+mzpK9OdVqqqy988I5
         Tn/hB7CUDdbBV1VyL2GDyTx2PsU1HnM2kqWn6QQ+36g2WUD22oXpbc3lTvDAxUFcJsOG
         2BF0fTheCNZmjNWvHLlSrubsJejS6VBDBZtbZ4vvsjlFO6jZMrua7Vk70oQn3jC95rIA
         nz0EwgVYSygOGg6EsQoTfOpoJwU1uG7C8IGLmFfRV5K6Y/kmVCJk/5BbUTm5ISfirPqL
         rx0Ay8DcIDdaU3NdgQ/8Iz4zCHh/2lzqwFh2e8Nx+EWnNSeUc0DyxOj9J9bauz9f/iah
         BxvA==
X-Gm-Message-State: ANoB5pl4FDSMtnwctpONyB87ioipPPsM+g3yh2xpwydorsMSSiN/zogg
        oBxVsJPZdptfsRqlEORYjvVEEEuTo/dPvg==
X-Google-Smtp-Source: AA0mqf5g8PaP/U2X5ncbHAtzRjwcmj47CZ/kAfbAs8zbgPWQ+YdGXF+h4uSSFGoUsCcyODXOm74bKQ==
X-Received: by 2002:ac8:6697:0:b0:3a5:24ad:73d with SMTP id d23-20020ac86697000000b003a524ad073dmr1682733qtp.167.1668682448230;
        Thu, 17 Nov 2022 02:54:08 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a24d500b006ce0733caebsm249240qkn.14.2022.11.17.02.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 02:54:07 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id i131so1393529ybc.9;
        Thu, 17 Nov 2022 02:54:07 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr1544397ybp.202.1668682446781; Thu, 17
 Nov 2022 02:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 11:53:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
Message-ID: <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> identical to one found on the RZ/G2L SoC. No driver changes are
> required as generic compatible string "renesas,rzg2l-irqc" will be
> used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> ---
> Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> domain) -> RISCV INTC

I think this difference is purely a software difference, and abstracted
in DTS through the interrupt hierarchy.
Does it have any impact on the bindings?

> - On the RZ/Five we have additional registers for IRQC block

Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
warranting separate compatible values.

> - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC

Can you please elaborate? I may have missed something, but to me it
looks like that is exactly the same on RZ/G2UL and on RZ/Five.

> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> @@ -26,6 +26,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043u-irqc   # RZ/G2UL
>            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
>            - renesas,r9a07g054-irqc    # RZ/V2L
>        - const: renesas,rzg2l-irqc

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
