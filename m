Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79A62D990
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiKQLij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiKQLiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:38:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91D4C270;
        Thu, 17 Nov 2022 03:37:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so4324243ejc.7;
        Thu, 17 Nov 2022 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zMQX8AFM4+P40dwGO+CyF4bBPvR3k12VUGD9oa/4yeQ=;
        b=WYrU3kvS60+yQxwaVGGMTQTHQzFCAiUJtvhcvzz3VZJqUevVL9siU+dhSaZ2pQWIrp
         v9Az6aPIca/tdKpWg9X4/pMdW/6lL7yDhpGV0j7tHQAvcRR26qRttBSufo4XKpwjuLxy
         sKhh5Orbq3wTIH00yk06+xqOo48VzKiPDPe6P+dcVJseEV5FdGOUfdDWoeXAyVACplIF
         D4FW1IyHQtatgcfY1GrD/sccMCyLZBLssMUAjrI7tim+zDLFJ+G9guz009/0hhHjINWT
         TUWAmdj4WOt2an4xeRCLbrzsioPejsWgwVgmfDNDr3Ra192/NgM4onyt8JqjEupBKma3
         aajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMQX8AFM4+P40dwGO+CyF4bBPvR3k12VUGD9oa/4yeQ=;
        b=dFb0mFgzK4xc6RveBDrJLxfx7yd1jFJJxQQLgLcQWCTFX1NKBiuaMS+OgYpOZbMabo
         /6RrwkGlb7v0XbcyFlIQt9kuycvVD0WsIUq2NgbrGbaWK5svJh/v/t3e3yeMx/K9Q/GQ
         BhvXIXoDxw3KIVU/a7WPCH2sJrU14lMXn8WLgn+W1mkBN++gE5RQTbFXeoDAppyBN+7f
         GHgCseT/cO+qHPzzafn1PjLjcV85hCcUxqAEyt49NQh2eHODa/AS7W+WRfEwiSBwPIO+
         V1KR340xoQc/hvnmlCNrBaX6BPDL9JPOrYIMYh4n/ChISgl2ElbZUG1U1akR+6zoWOeE
         Z1kw==
X-Gm-Message-State: ANoB5plvTDS+qfMlu6F6bMGprkXvCFAUEgbvohTyQuakayz9EqfnHHLU
        PmoA6WMK4ugTiKQ95sKLjz4SSgHzXZDH0OQaSmY=
X-Google-Smtp-Source: AA0mqf4xOOviUI3cFCwoPMYxg/ad/F4L+UYFYT8InKXEPc0HT/kv7DYGtvX940O48ROCwwImO2z2yLD4Afi4UK72IAY=
X-Received: by 2002:a17:906:8a57:b0:7ad:a030:4915 with SMTP id
 gx23-20020a1709068a5700b007ada0304915mr1852029ejc.267.1668685069407; Thu, 17
 Nov 2022 03:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
In-Reply-To: <CAMuHMdV46aMfqu+kMW9E-RURugK-giOx0k-NPe5XX4nxKZJzkg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Nov 2022 11:37:23 +0000
Message-ID: <CA+V-a8sa1Tz_q-Ymca-QYn0amPTZh49-y=8P=wMqnQHa=Xpqqg@mail.gmail.com>
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

Thank you for the review.

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
For now I dont know for sure, as I havent started looking into it yet.

> > - On the RZ/Five we have additional registers for IRQC block
>
> Indeed, the NMI/IRQ/TINT "Interruput" Mask Control Registers, thus
> warranting separate compatible values.
>
\o/

> > - On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
>
> Can you please elaborate? I may have missed something, but to me it
> looks like that is exactly the same on RZ/G2UL and on RZ/Five.
>
I completely missed rz/g2ul had this interrupt too.

Cheers,
Prabhakar
