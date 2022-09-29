Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CC5EF0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiI2Ihh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiI2Ihd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:37:33 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F7124C1A;
        Thu, 29 Sep 2022 01:37:31 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id v192so304575vkv.7;
        Thu, 29 Sep 2022 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EQWDuK883PRClmKZR3d+3u3EtiovxcQC4ep6M1p1T/A=;
        b=pEtThIwSLCQ93ILP8GJxrHHYPofFqfYLGuYsODWTfyBWwj3Cu2hfbo1pCOaEMjuFqO
         77E5W/XRnLA2cLlNl8pgYtqL9Q/blLezd2H12thOmGNhqMSFzyFERshYJaGw4hd3oeoX
         0M9rM0R6qLaueuy6Sa4lCpfEBaHahFsPPrhKqH7OtK0A7Tl0fiByotdF4N+EFvKssbH2
         TgPTnL5LLPgOWetxowmoe4yJJXFXD6+czLRiPt3kcuuRnjub3KTY6d/BB6xPQopUH+8I
         1j/9RKTYXoEUAizjRCqIQRPL2C7icE5OSCsso28CDAv0NqncKUgG1rk0EK/9B5jnqY6i
         4xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EQWDuK883PRClmKZR3d+3u3EtiovxcQC4ep6M1p1T/A=;
        b=vsrtSgwPrqlU7W2ABjbFdLnonONZeXu0kNf2v0RN6YVnyOTC5ISxVArOkatinhFOib
         7fLn6jvkmmTNixWz7UqGPBziUVCljKoNqMBnJ6//7oqr2yimbt2+ECbDKlAVHGD8MM8C
         jFep+SCjLKl/mtsamsSwgyJPIXg/FJLAMrgUsvxGeRF9QjchOy1XwxzvffDPJNWJyejj
         i+xozLhGNHJxEdrGraIsBoa+1/zOrk88TIV4n29E6IB58rJkEWPAA6bcOXZ/nLhiZc2b
         xfLIHdNy0KEx+N6fMwfgM0tw46Z+bIzPQUYfvPt8WQ3oNbzZuE4k9kU8AlLo4wVgKEo/
         2z8A==
X-Gm-Message-State: ACrzQf3jGB8OBua0qf9idnHyIqoy1dL50ajeVZV/nAFUoVGdweeqXIQw
        HpYX38agFg3wZvmtghruiQ+VJo4dhUdm3EjIGJ4GaEBIQ+GfqA==
X-Google-Smtp-Source: AMsMyM5SaMH12aE6F3oHmdorbj3GkIkZHzj2d3ClXtjMvN4JKd1yl75uj3rJbppf+pK3SbSN+Os4PIeVN5ET7I0WFak=
X-Received: by 2002:a1f:2596:0:b0:3a2:5864:697c with SMTP id
 l144-20020a1f2596000000b003a25864697cmr832835vkl.37.1664440650276; Thu, 29
 Sep 2022 01:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220928092937.27120-1-zhang.lyra@gmail.com> <20220928092937.27120-2-zhang.lyra@gmail.com>
 <75597c55-24f8-a76c-334d-cedc186aa841@linaro.org>
In-Reply-To: <75597c55-24f8-a76c-334d-cedc186aa841@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 29 Sep 2022 16:36:53 +0800
Message-ID: <CAAfSe-t1psNZSoDdP87y9M+8aj6wD_2R07H5y5iMwEHjJc7xzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: gpio: Conver Unisoc EIC controller
 binding to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, 28 Sept 2022 at 19:34, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/09/2022 11:29, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Convert the Unisoc EIC controller binding to DT schema format.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/gpio/gpio-eic-sprd.txt           |  97 ------------
> >  .../bindings/gpio/sprd,gpio-eic.yaml          | 145 ++++++++++++++++++
> >  2 files changed, 145 insertions(+), 97 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> >  create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> > deleted file mode 100644
> > index 54040a2bfe3a..000000000000
> > --- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
> > +++ /dev/null
> > @@ -1,97 +0,0 @@
> > -Spreadtrum EIC controller bindings
> > -
> > -The EIC is the abbreviation of external interrupt controller, which can
> > -be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
> > -one is in digital chip, and another one is in PMIC. The digital chip EIC
> > -controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
> > -EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
> > -module.
> > -
> > -The EIC-debounce sub-module provides up to 8 source input signal
> > -connections. A debounce mechanism is used to capture the input signals'
> > -stable status (millisecond resolution) and a single-trigger mechanism
> > -is introduced into this sub-module to enhance the input event detection
> > -reliability. In addition, this sub-module's clock can be shut off
> > -automatically to reduce power dissipation. Moreover the debounce range
> > -is from 1ms to 4s with a step size of 1ms. The input signal will be
> > -ignored if it is asserted for less than 1 ms.
> > -
> > -The EIC-latch sub-module is used to latch some special power down signals
> > -and generate interrupts, since the EIC-latch does not depend on the APB
> > -clock to capture signals.
> > -
> > -The EIC-async sub-module uses a 32kHz clock to capture the short signals
> > -(microsecond resolution) to generate interrupts by level or edge trigger.
> > -
> > -The EIC-sync is similar with GPIO's input function, which is a synchronized
> > -signal input register. It can generate interrupts by level or edge trigger
> > -when detecting input signals.
> > -
> > -Required properties:
> > -- compatible: Should be one of the following:
> > -  "sprd,sc9860-eic-debounce",
> > -  "sprd,sc9860-eic-latch",
> > -  "sprd,sc9860-eic-async",
> > -  "sprd,sc9860-eic-sync",
> > -  "sprd,sc2731-eic".
> > -- reg: Define the base and range of the I/O address space containing
> > -  the GPIO controller registers.
> > -- gpio-controller: Marks the device node as a GPIO controller.
> > -- #gpio-cells: Should be <2>. The first cell is the gpio number and
> > -  the second cell is used to specify optional parameters.
> > -- interrupt-controller: Marks the device node as an interrupt controller.
> > -- #interrupt-cells: Should be <2>. Specifies the number of cells needed
> > -  to encode interrupt source.
> > -- interrupts: Should be the port interrupt shared by all the gpios.
> > -
> > -Example:
> > -     eic_debounce: gpio@40210000 {
> > -             compatible = "sprd,sc9860-eic-debounce";
> > -             reg = <0 0x40210000 0 0x80>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -             interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > -     };
> > -
> > -     eic_latch: gpio@40210080 {
> > -             compatible = "sprd,sc9860-eic-latch";
> > -             reg = <0 0x40210080 0 0x20>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -             interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > -     };
> > -
> > -     eic_async: gpio@402100a0 {
> > -             compatible = "sprd,sc9860-eic-async";
> > -             reg = <0 0x402100a0 0 0x20>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -             interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > -     };
> > -
> > -     eic_sync: gpio@402100c0 {
> > -             compatible = "sprd,sc9860-eic-sync";
> > -             reg = <0 0x402100c0 0 0x20>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -             interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> > -     };
> > -
> > -     pmic_eic: gpio@300 {
> > -             compatible = "sprd,sc2731-eic";
> > -             reg = <0x300>;
> > -             interrupt-parent = <&sc2731_pmic>;
> > -             interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> > new file mode 100644
> > index 000000000000..e25ee1884c07
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2022 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/sprd,gpio-eic.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc EIC controller
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +description:
> > +  The EIC is the abbreviation of external interrupt controller, which can
> > +  be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
> > +  one is in digital chip, and another one is in PMIC. The digital chip EIC
> > +  controller contains 4 sub-modules, i.e. EIC-debounce, EIC-latch, EIC-async and
> > +  EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
> > +  module.
> > +
> > +  The EIC-debounce sub-module provides up to 8 source input signal
> > +  connections. A debounce mechanism is used to capture the input signals'
> > +  stable status (millisecond resolution) and a single-trigger mechanism
> > +  is introduced into this sub-module to enhance the input event detection
> > +  reliability. In addition, this sub-module's clock can be shut off
> > +  automatically to reduce power dissipation. Moreover the debounce range
> > +  is from 1ms to 4s with a step size of 1ms. The input signal will be
> > +  ignored if it is asserted for less than 1 ms.
> > +
> > +  The EIC-latch sub-module is used to latch some special power down signals
> > +  and generate interrupts, since the EIC-latch does not depend on the APB
> > +  clock to capture signals.
> > +
> > +  The EIC-async sub-module uses a 32kHz clock to capture the short signals
> > +  (microsecond resolution) to generate interrupts by level or edge trigger.
> > +
> > +  The EIC-sync is similar with GPIO's input function, which is a synchronized
> > +  signal input register. It can generate interrupts by level or edge trigger
> > +  when detecting input signals.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,sc9860-eic-debounce
> > +      - sprd,sc9860-eic-latch
> > +      - sprd,sc9860-eic-async
> > +      - sprd,sc9860-eic-sync
> > +      - sprd,sc2731-eic
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 4
>
> Why up to 4 items? Previous bindings did not mention it. I also do not

For the mainstream gpio-eic-sprd driver [1], it supports 3 reg items,
I will fix this.

> see any users of this. Anyway you need to describe the items (items with
> description) and restrict per variant in allOf:if:then

Ok.

>
> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: The interrupt shared by all GPIO lines for this controller.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        eic_debounce: gpio@40210000 {
> > +            compatible = "sprd,sc9860-eic-debounce";
> > +            reg = <0 0x40210000 0 0x80>;
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>
> One example is enough. All others are the same.

Ok, will remove.

Thanks for the review,
Chunyan

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v6.0-rc7/drivers/gpio/gpio-eic-sprd.c#592
