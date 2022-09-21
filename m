Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCF5BFC01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIUKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:08:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3820785B3;
        Wed, 21 Sep 2022 03:07:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hy2so8754404ejc.8;
        Wed, 21 Sep 2022 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=16JHpy8HOV5zOjzO41UWCeQsc//VdSkHGlgOJLsMd8k=;
        b=W2nsBUXvxZW4u9Vlf0bwCXbGqjxzpcwSk+491KYGNutwKR5iVS/4+r1ZWnYID/AMjB
         XMXv5w2GMh6+F8QGi7Io73MQA5tSGqmG2x/3U2WZN7mB/C3zCUl0vt1c7Li5kpJ5ieNe
         r8r2OyPJyAxFaQXePEK0wOHZpVDUuuj7DJjhSGHEzNN9tpj70q+o/+LJhw5u9sVksOQr
         T/FBkTX5G9QjyXlKxw1cBnk2Z5yk3gkHGF0DZ2+UvaT/knvTFCAVHRVNnH91qBVrvo8H
         80e0lk7XR3ChVikb17npTnmpn70MchyWfxrtsQAYXUWDsUZhSg0+lJ+n9WpY5F7UyvaE
         pQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=16JHpy8HOV5zOjzO41UWCeQsc//VdSkHGlgOJLsMd8k=;
        b=dcC3LGwj3pgCe7ObXfI0e1KitgTpUqZ2Kw/5ijPrBW92BbAF04UZb4ypnW5WMt4kxc
         APkhp1e8dIrp5nZ5IYW46QHxUNsZtqJq/nRcZ6CUPCR1edlMJw4/zdomdgAjso/zoozn
         pv2VmOoEnijqhnuZX2LhIb4+rBMp2Wlfk3sujDI5r89iCbBv0X3017wTygd/61KoedHS
         nI7l169xfPGgcHxfFNTmt9Gl0khpubMqEAbWs4OyKEAKvlieXORxGWBr73RLD8a0nqqU
         veW2ncMq0NChL9hTQjzU6o6xuQYe01FqAA2/p6SUxQP5n+PugiwEP6dMVITd6vKn5xDw
         jCJw==
X-Gm-Message-State: ACrzQf1hUsjmAjH6ybMnh3q0TEJZvZb5Cu20xLQRg6axjJfqKY14nxTo
        FOtr8YkjCdsuhkH59tU+UXpnUNwN/jOxRKpe1qTuIzMUrh4=
X-Google-Smtp-Source: AMsMyM5rh1KQ7KgFpMv+pJ3tu52sOsSxVxHqI6HzSneUdWNk74IBai04tZfLSooyjz4dTz8BOkizUbI1Qgl4nYk8Jqs=
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id
 17-20020a170906059100b0073dc3ef84aemr20462081ejn.155.1663754876285; Wed, 21
 Sep 2022 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org> <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
 <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
In-Reply-To: <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 21 Sep 2022 11:07:29 +0100
Message-ID: <CA+V-a8svcTXceeLSVD4D9VazTc9nN5MXsFmvcFaDd2mM0REDhg@mail.gmail.com>
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

On Wed, Sep 21, 2022 at 10:26 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/09/2022 11:20, Lad, Prabhakar wrote:
> >>
> >> What do you mean? Macros support string concatenation and simple
> >> arithmetic like adding numbers. I just tested it.
> >>
> > I did try the below:
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > index 689aa4ba416b..0f923c276cd3 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> > @@ -8,6 +8,8 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/r9a07g043-cpg.h>
> >
> > +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr na
> > +
> >  / {
> >      compatible = "renesas,r9a07g043";
> >      #address-cells = <2>;
> > @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
> >              compatible = "renesas,r9a07g043-ssi",
> >                       "renesas,rz-ssi";
> >              reg = <0 0x1004a000 0 0x400>;
> > -            interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > +            interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
> >                       <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
> >                       <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
> >                       <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
> >
> > This worked as expected, but couldn't get the arithmetic operation
> > working. Could you please provide an example?
>
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> index ff6aab388eb7..0ecca775fa3f 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/r9a07g043-cpg.h>
>
> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
>  / {
>         compatible = "renesas,r9a07g043";
>         #address-cells = <2>;
> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>                         compatible = "renesas,r9a07g043-ssi",
>                                      "renesas,rz-ssi";
>                         reg = <0 0x1004a000 0 0x400>;
> -                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>
>
>
> Or any other method like that....
>
Thanks for the pointer! (Ive tested the above and it works)

Cheers,
Prabhakar
