Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27BE62F4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiKRMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbiKRMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:31:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A845091;
        Fri, 18 Nov 2022 04:30:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so12631455ejb.9;
        Fri, 18 Nov 2022 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZylkDqipsSWVUpDnUzy17v+WnuvxbbaswTfv5O4dBs=;
        b=eUjQ+DkdwrOamw24nWNeklKUIiMEQiQeEM567HSHskrMW8Us15k4Djy5Z9MOfHDEJA
         leaJXxOQS+royEE5tCZ4iXf4sii3zaDalYpxMriW61uWRNQp1VKIY06yol3TqXKWDSlk
         zIJn1Z/wnb2TCSSCAovxKTwpmmWhRdohBZv+73obigClXe2Psj9xUGAg0q5reejJYUou
         LCB+02opStYWrwYLu0hAIGsCg/994/BBKrsjzad6976U9wbOr5dzGtrTJDIZTtWR41bX
         1SINPUWPt9t6z1vVFFsq7YyD3HEYo75UCocoNsITgn+0BVYD9T9GA57iQyRN46MnD/0F
         cq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZylkDqipsSWVUpDnUzy17v+WnuvxbbaswTfv5O4dBs=;
        b=BxJhIZj6IOkRWTwMF3MWwsOGjI/g8ljUUpUoDKLOvdSYEdCojDNm84K2u/d9qfizFJ
         awLkcDGseMfoaKH79HQaE6ppIwvqFgd9El8KuaiLwRTcOwd/XaVgCvfN9WrRFvMlQsZN
         P9ApEA10o1DVb9/fzTkUUzKQNNYPRRmQKupny7BOc0gD9CGOf7nGvvS0OvM3FpjJQwnG
         VPSRXl7/GH6a75paQwJaAjJiBLQRRuYEUA7CqQbPmOUWaWGxae9I2Uk7yuEQjk6S0RZ8
         tcML2wJEtHZp48HSThFoar3CqgsIBSx0qunGimmiHNAAaDtgU5Y4VkSsvxIi1+xvvvv5
         H8/Q==
X-Gm-Message-State: ANoB5pmww3XhkvxahK26gATRBWp6dYWNefXVKSRpjnRpLcdP66dBOCeE
        UWj6nzpNl78SpQgs2B9Bzfq378SulFjODE+la7Y=
X-Google-Smtp-Source: AA0mqf62SAwlT3nJuz3Cdfa6K5MCGjq8wuc9X2LC0JRmw3MyXGf9MwEzDmidvSVaV+efJ1qjyE1NRSy+etHWrG6upqo=
X-Received: by 2002:a17:906:3e41:b0:78d:bc9f:33da with SMTP id
 t1-20020a1709063e4100b0078dbc9f33damr5761785eji.80.1668774610255; Fri, 18 Nov
 2022 04:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
In-Reply-To: <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 18 Nov 2022 12:29:43 +0000
Message-ID: <CA+V-a8uqQ2fK1UjRT864jyHdt6Z47V=iARSJC6B2M6Gikms=Eg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/G2UL SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Nov 17, 2022 at 10:54 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
> > identical to one found on the RZ/G2L SoC. No driver changes are
> > required as generic compatible string "renesas,rzg2l-irqc" will be
> > used as a fallback.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > ---
> > Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
> > - G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
> > domain) -> RISCV INTC
>
> I think this difference is purely a software difference, and abstracted
> in DTS through the interrupt hierarchy.
> Does it have any impact on the bindings?
>
> > - On the RZ/Five we have additional registers for IRQC block
>
> Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> warranting separate compatible values.
>
> > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
>
> Can you please elaborate? I may have missed something, but to me it
> looks like that is exactly the same on RZ/G2UL and on RZ/Five.
>
Now that we have to update the binding doc with the BUS_ERR_INT too,
do you think it would make sense to add interrupt-names too?

BUS_ERR_INT will have to be handled IRQC itself (i.e. IRQC will
register a handler for it).

Cheers,
Prabhakar
