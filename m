Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AA648897
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLISo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLISoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:44:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C4E82F8F;
        Fri,  9 Dec 2022 10:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 103C4B828E4;
        Fri,  9 Dec 2022 18:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90FDC433EF;
        Fri,  9 Dec 2022 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670611461;
        bh=bljG7345NgKX8LifuzmL9Uxp8+NUQVPSMFRNHLEjX2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aEq2YJu7PnhewbhTAaoWklh9No4oZ9Sy+suhjD5I7aMX0FgHRPDbYclBYCC9X9fk8
         z9vjR4zzhP0p23zJ3YYtCge9AncBuXMS9aMswZHgr0/wrJVUw+6tbGv/uwQIZaHR7k
         On7KIDci/YBCI0Y3Vi8gWsiX5A6IY0QEMF74ni65WrtZwOnRLeoAUdEcz62Mdoskse
         Kd7KLqPVVobNt5/hgLgarWWCTFnn7xBk/mSqaDU3/OIeRBGXat3LkeQehxuB7pett3
         WrOUcylxz2dVKEf0BYtPNN2MsTohGbO6GtjB5Lnu2H42BVQeIE5y0qwWYE+0jtM1VR
         tj2wmF+OeHecg==
Received: by mail-lj1-f181.google.com with SMTP id h10so5819414ljk.11;
        Fri, 09 Dec 2022 10:44:21 -0800 (PST)
X-Gm-Message-State: ANoB5plPTU+kF2MWkVgvQ3p1UEbfJFPV9VdBG1+WTAR8ge8qUXbE4Zjt
        Ss9uaDRJNE9BFAuFvvCAb9Y8L8F9lIafv+Afut4=
X-Google-Smtp-Source: AA0mqf7BbiHe41qN/JbTpTXG8a2z2bbZlw236fNln0qvVWNaHMZFHCk2sYBGNS+zW9sLSTk7c0NKXwXZwq7ePkkKxzs=
X-Received: by 2002:a05:651c:b14:b0:277:7eef:1d97 with SMTP id
 b20-20020a05651c0b1400b002777eef1d97mr25615124ljr.516.1670611459831; Fri, 09
 Dec 2022 10:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20221209171621.3351220-1-robh@kernel.org> <CAL_JsqL-FVy1SK1ZTVoPaxDG0-7_PtcZZHFWJt8+aaGWFFBwaA@mail.gmail.com>
In-Reply-To: <CAL_JsqL-FVy1SK1ZTVoPaxDG0-7_PtcZZHFWJt8+aaGWFFBwaA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 19:44:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFJ+779S93dO3BzKKnEw=dBnbtzS+-yboFfj35ASnheJA@mail.gmail.com>
Message-ID: <CAMj1kXFJ+779S93dO3BzKKnEw=dBnbtzS+-yboFfj35ASnheJA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Convert Fujitsu SDHCI to DT schema
To:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Jassi and Masahisa

On Fri, 9 Dec 2022 at 19:42, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 9, 2022 at 11:16 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Convert the Fujitsu SDHCI binding to DT schema format.
> >
> > The interrupts were not documented. The driver only uses the first
> > interrupt, but the DT and example have 2 interrupts. The 2nd one is
> > unknown. "dma-coherent" was also not documented, but is used.
> >
> > The "socionext,synquacer-sdhci" compatible was not documented, but it is
> > compatible with "fujitsu,mb86s70-sdhci-3.0.yaml" and is in use (in
> > u-boot Synquacer dts).
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../mmc/fujitsu,mb86s70-sdhci-3.0.yaml        | 67 +++++++++++++++++++
> >  .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 ---------
> >  2 files changed, 67 insertions(+), 32 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
> > new file mode 100644
> > index 000000000000..0218a6ce4b2f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fujitsu,mb86s70-sdhci-3.0.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/fujitsu,mb86s70-sdhci-3.0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Fujitsu SDHCI controller
> > +
> > +maintainers:
> > +  - Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>
> Bounces. Any other volunteers?
>
> > +
> > +allOf:
> > +  - $ref: mmc-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: socionext,synquacer-sdhci
> > +          - const: fujitsu,mb86s70-sdhci-3.0
> > +      - const: fujitsu,mb86s70-sdhci-3.0
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Core clock
> > +      - description: Interface clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: iface
> > +
> > +  dma-coherent: true
> > +
> > +  interrupts:
> > +    maxItems: 2
> > +
> > +  fujitsu,cmd-dat-delay-select:
> > +    type: boolean
> > +    description: Indicating that the host requires the CMD_DAT_DELAY control
> > +      to be enabled.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    mmc@36600000 {
> > +        compatible = "fujitsu,mb86s70-sdhci-3.0";
> > +        reg = <0x36600000 0x1000>;
> > +        interrupts = <0 172 0x4>,
> > +               <0 173 0x4>;
> > +        bus-width = <4>;
> > +        vqmmc-supply = <&vccq_sdhci1>;
> > +        clocks = <&clock 2 2 0>, <&clock 2 3 0>;
> > +        clock-names = "core", "iface";
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> > deleted file mode 100644
> > index 3ee9263adf73..000000000000
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> > +++ /dev/null
> > @@ -1,32 +0,0 @@
> > -* Fujitsu SDHCI controller
> > -
> > -This file documents differences between the core properties in mmc.txt
> > -and the properties used by the sdhci_f_sdh30 driver.
> > -
> > -Required properties:
> > -- compatible: "fujitsu,mb86s70-sdhci-3.0"
> > -- clocks: Must contain an entry for each entry in clock-names. It is a
> > -  list of phandles and clock-specifier pairs.
> > -  See ../clocks/clock-bindings.txt for details.
> > -- clock-names: Should contain the following two entries:
> > -       "iface" - clock used for sdhci interface
> > -       "core"  - core clock for sdhci controller
> > -
> > -Optional properties:
> > -- vqmmc-supply: phandle to the regulator device tree node, mentioned
> > -  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> > -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> > -  requires the CMD_DAT_DELAY control to be enabled.
> > -
> > -Example:
> > -
> > -       sdhci1: mmc@36600000 {
> > -               compatible = "fujitsu,mb86s70-sdhci-3.0";
> > -               reg = <0 0x36600000 0x1000>;
> > -               interrupts = <0 172 0x4>,
> > -                            <0 173 0x4>;
> > -               bus-width = <4>;
> > -               vqmmc-supply = <&vccq_sdhci1>;
> > -               clocks = <&clock 2 2 0>, <&clock 2 3 0>;
> > -               clock-names = "iface", "core";
> > -       };
> > --
> > 2.35.1
> >
