Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09345BFABC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIUJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiIUJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:22:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EA51A37;
        Wed, 21 Sep 2022 02:21:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a41so7735292edf.4;
        Wed, 21 Sep 2022 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GLpNbv2dDZs2ELKJfedbPTLfT2mNSjQrTpD1eCAo9R4=;
        b=mdAeRwbFj19Rzs/mqgRFM2d7927buI86UH/L76robThQCURIrMdVolDmohaWuKLt8F
         ZfJGEFoE5VoyRUdHha0+3lArmu35lorSe0gugTFVVrKQJBPKvNZmq7HbVEpBfkHTjfKx
         X+FRub5EJupwXhVdt7yIy/jkz30YU74pYcMEwqsMB3xrL+wzsWAbmla2uTv3ihCuU9J9
         eYWlTb67MOkHBcKQiT1i4XFrIn0KbAbBlMUPVD6NqznG8+UVojtf1f5yeFMb/wlgHwda
         3soPAwF9S213cC9McMt9xZ7Rq8GJhxlCiJxhBSldfOIvj0jbxFmFKTZioJDYlrxq2UlP
         iSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GLpNbv2dDZs2ELKJfedbPTLfT2mNSjQrTpD1eCAo9R4=;
        b=xntGCVrHyezYpeT8ZxCifWLSbgJjVLWxs+8c1UYQ1ELQl6WIvYOIX7nDd8nnUP7FvV
         3AcymrRTH6FW73iuSiC1RP23oYnkZnPv7MmZX1kqC21JRDEJ2ECgDZsQToSZOPY7Vcy9
         xba7VWPEo+trH/xCO0ablbvGV0VjLHMU9OlG/oA0noD7yRUJ9YV28L/LlvbMq2OTc9XS
         T2ct1tb7MIHrNRxTYCxCsgpMmj3XeD49p0PaKpwyOIjk22aDmIOEVfiEeEN8MVWmMYRz
         hJeLBVu/YkYDCgR61SxeGy/kgqwfjnC2ahha47SbL6SurU1NL3kLc7/nH4lIwj3b0SK2
         TXGg==
X-Gm-Message-State: ACrzQf3yewhy53iOHLICk8NJPQ8uS33vHN96juGj5/HpTJQxHGd7LdRz
        CgXb+Xw8uEAvOBuYNqPEempdCT0+bI0cgLtchVE=
X-Google-Smtp-Source: AMsMyM7+OZ810UA2mZJt2QSEYSd2Q9iA3wdNG3qKqnIkRmmrozXEWttDQZsMNbbQC6kq39c2WPA+h5udMhfxXLYzak8=
X-Received: by 2002:a05:6402:350b:b0:452:2b68:90db with SMTP id
 b11-20020a056402350b00b004522b6890dbmr23967840edd.255.1663752085609; Wed, 21
 Sep 2022 02:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
In-Reply-To: <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 21 Sep 2022 10:20:58 +0100
Message-ID: <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
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

Hi Krzysztof,

On Wed, Sep 21, 2022 at 9:53 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/09/2022 09:46, Geert Uytterhoeven wrote:
> >         Hi Rob, Krzysztof,
> >
> > This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> > suggested to bring it up with you.
>
> I guess you also need SoC maintainers as well (+Cc Arnd and Olof). :)
>
> >
> > The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
> > cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
> > To avoid duplication, we would like to have:
> >   - <riscv-soc>.dtsi includes <base-soc>.dtsi,
> >   - <arm-soc>.dtsi includes <base-soc>.dtsi.
> >
> > Unfortunately RISC-V and ARM typically use different types of interrupt
> > controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
> > possibly using different interrupt numbers.  Hence the interrupt-parent
> > and interrupts{-extended} properties should be different, too.
> >
> > Possible solutions[1]:
> >   1. interrupt-map
> >
> >   2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
> >      <base-soc>.dtsi, with
> >        - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
> >        - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
> >      Note that the cpp/dtc combo does not support arithmetic, so even
> >      the simple case where nr = 32 + na cannot be simplified.
>
> What do you mean? Macros support string concatenation and simple
> arithmetic like adding numbers. I just tested it.
>
I did try the below:

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 689aa4ba416b..0f923c276cd3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a07g043-cpg.h>

+#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr na
+
 / {
     compatible = "renesas,r9a07g043";
     #address-cells = <2>;
@@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
             compatible = "renesas,r9a07g043-ssi",
                      "renesas,rz-ssi";
             reg = <0 0x1004a000 0 0x400>;
-            interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+            interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
                      <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
                      <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
                      <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;

This worked as expected, but couldn't get the arithmetic operation
working. Could you please provide an example?

Cheers,
Prabhakar
