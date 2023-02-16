Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDF699A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBPQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBPQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:41:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740B4CC98;
        Thu, 16 Feb 2023 08:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E97F61D58;
        Thu, 16 Feb 2023 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61ABC433D2;
        Thu, 16 Feb 2023 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676565702;
        bh=8sTJMeSGClWhu2e1UsvG81Ext9xqh2ISQ2oaTGOEIzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRjhpTf9yfcn4VnlqPX8DCJKwf2ZHtHDVvmiBQLvPU5YR4TsCgZBHvyr5RvlxpCKK
         /8XHpvqSpRE+PGMXxEVTPGJ4fgFU8gVfhZVKeSn7ZBpDkjZAHUgqMO2bj6Is0EXlg7
         T+dMGrEX8iyTxbFIxPLsJvU0EX8B3VPu0EwqKdXfHXevp/EQMF0yrcu4Wr4xhBnWoE
         1cZnFiAJSIhFSuoR90bkajimWd7UDMLl8MSjL+bUZaX37RdrT4wjY9jX4Vn1PILdvz
         muhsghyt1glVIzN9LSljLOz3PUoELOn3ADsftvI4MNoBLZGTGGSHla0n10uIFbVaxh
         0npRcwmSZzQCw==
Received: by mail-vs1-f45.google.com with SMTP id w22so1063436vsf.13;
        Thu, 16 Feb 2023 08:41:42 -0800 (PST)
X-Gm-Message-State: AO0yUKVvRN4hhd4PDrHMuLv5+zzI6qn3lqUsj/R1mfYlpYggdYSTvNpP
        X7z7KVFjaiZPv9zcsCZzHRjD9+cSct4tVegBrQ==
X-Google-Smtp-Source: AK7set+niv4ZSmswRovGksbtGiFL4MZld6t7lwQbAtr3Ngi7aeyzQ2baByBO1jfmnJ26M5xKBQLKKBDckB79adHICi4=
X-Received: by 2002:a67:d812:0:b0:412:4fed:e7ad with SMTP id
 e18-20020a67d812000000b004124fede7admr1147102vsj.67.1676565701656; Thu, 16
 Feb 2023 08:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20230216153339.19987-1-afd@ti.com> <20230216153339.19987-3-afd@ti.com>
In-Reply-To: <20230216153339.19987-3-afd@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Feb 2023 10:41:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4JU=ZrLqiZuQHNZf6PdErwpBebcn9OVDdVd9YOjY7Jg@mail.gmail.com>
Message-ID: <CAL_Jsq+4JU=ZrLqiZuQHNZf6PdErwpBebcn9OVDdVd9YOjY7Jg@mail.gmail.com>
Subject: Re: [RFC 2/2] WIP: dt-bindings: omap: Convert omap.txt to yaml
To:     Andrew Davis <afd@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:34 AM Andrew Davis <afd@ti.com> wrote:
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Thanks for posting this!

> ---
>  .../devicetree/bindings/arm/omap/omap.yaml    | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.yaml

Move this to arm/ti,omap.yaml or arm/ti.yaml. The rest of omap/ dir
should get moved elsewhere eventually.

>
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.yaml b/Documentation/devicetree/bindings/arm/omap/omap.yaml
> new file mode 100644
> index 0000000000000..cf07a7a7df279
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.yaml
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/omap/omap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP SoC architecture device tree bindings

Drop 'device tree bindings'

> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description: |

Drop '|'

> +  Platforms based on Texas Instruments OMAP SoC architecture.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description: TI OMAP2420 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap2420-h4 # TI OMAP2420 H4 board
> +              - nokia,n800 # Nokia N800
> +              - nokia,n810 # Nokia N810
> +              - nokia,n810-wimax # Nokia N810 WiMax

A bit more whitespace before the comments would be nice. Personally I
don't see much value in pretty names that just reformat the compatible
string, but either way is fine.

> +          - const: ti,omap2420
> +          - const: ti,omap2
> +
> +      - description: TI OMAP2430 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap2430-sdp # TI OMAP2430 SDP
> +          - const: ti,omap2430
> +          - const: ti,omap2
> +
> +      - description: TI OMAP3430 SoC based platforms
> +        items:
> +          - enum:
> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom OMAP35xx SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx Torpedo Development Kit
> +              - ti,omap3430-sdp # TI OMAP3430 SDP
> +              - ti,omap3-beagle # TI OMAP3 BeagleBoard
> +              - compulab,omap3-cm-t3530 # CompuLab CM-T3530
> +              - timll,omap3-devkit8000 # TimLL OMAP3 Devkit8000
> +              - ti,omap3-evm # TI OMAP35XX EVM (TMDSEVM3530)
> +              - ti,omap3-ldp # TI OMAP3430 LDP (Zoom1 Labrador)
> +              - nokia,omap3-n900 # Nokia N900
> +          - const: ti,omap3430
> +          - const: ti,omap3
> +
> +      - description: TI OMAP3630 SoC based platforms
> +        items:
> +          - enum:
> +              - logicpd,dm3730-som-lv-devkit # LogicPD Zoom DM3730 SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
> +              - ti,omap3-beagle-xm # TI OMAP3 BeagleBoard xM
> +              - compulab,omap3-cm-t3730 # CompuLab CM-T3730
> +              - amazon,omap3-echo # Amazon Echo (first generation)
> +              - ti,omap3-evm-37xx # TI OMAP37XX EVM (TMDSEVM3730)
> +              - ti,omap3-gta04 # OMAP3 GTA04
> +              - nokia,omap3-n9 # Nokia N9
> +              - nokia,omap3-n950 # Nokia N950
> +              - lg,omap3-sniper # LG Optimus Black
> +              - ti,omap3-zoom3 # TI Zoom3
> +          - const: ti,omap3630
> +          - const: ti,omap3
> +
> +      - description: TI AM35 SoC based platforms
> +        items:
> +          - enum:
> +              - teejet,mt_ventoux # TeeJet Mt.Ventoux
> +              - ti,am3517-craneboard # TI AM3517 CraneBoard (TMDSEVM3517)
> +              - ti,am3517-evm # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
> +              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
> +          - const: ti,am3517
> +          - const: ti,omap3
> +
> +      - description: TI OMAP4430 SoC based platforms
> +        items:
> +          - enum:
> +              - motorola,droid4 # Motorola Droid 4 XT894
> +              - motorola,droid-bionic # Motorola Droid Bionic XT875
> +              - amazon,omap4-kc1 # Amazon Kindle Fire (first generation)
> +              - ti,omap4-panda # TI OMAP4 PandaBoard
> +              - ti,omap4-sdp # TI OMAP4 SDP board
> +          - const: ti,omap4430
> +          - const: ti,omap4
> +
> +      - description: TI OMAP4460 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap4-panda-es # TI OMAP4 PandaBoard-ES
> +          - const: ti,omap4460
> +          - const: ti,omap4
> +
> +      - description: TI OMAP543 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,omap5-cm-t54 # CompuLab CM-T54
> +              - isee,omap5-igep0050 # IGEPv5
> +              - ti,omap5-uevm # TI OMAP5 uEVM board
> +          - const: ti,omap5
> +
> +      - description: TI AM33 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,am335x-bone # TI AM335x BeagleBone
> +              - compulab,cm-t335 # CompuLab CM-T335
> +              - ti,am335x-evm # TI AM335x EVM
> +              - ti,am335x-evmsk # TI AM335x EVM-SK
> +              - bosch,am335x-guardian # Bosch AM335x Guardian
> +              - ti,am3359-icev2 # TI AM3359 ICE-V2
> +              - novatech,am335x-lxm # NovaTech OrionLXm
> +              - moxa,uc-2101 # Moxa UC-2101
> +              - moxa,uc-8100-me-t # Moxa UC-8100-ME-T
> +              - gumstix,am335x-pepper # Gumstix Pepper
> +              - tcl,am335x-sl50 # Toby Churchill SL50 Series
> +          - pattern: '^ti,am33(5[1246789]|xx)$' # ti,am33xx is legacy please use full SoC name
> +
> +      - description: TI AM43 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,am437x-cm-t43 # CompuLab CM-T43
> +              - ti,am437x-gp-evm # TI AM437x GP EVM
> +              - ti,am437x-idk-evm # TI AM437x Industrial Development Kit
> +              - ti,am437x-sk-evm # TI AM437x SK EVM
> +          - pattern: '^ti,am4372[26789]$'
> +          - const: ti,am43
> +
> +      - description: TI AM57 SoC based platforms
> +        items:
> +          - enum:
> +              - beagle,am5729-beagleboneai # BeagleBoard.org BeagleBone AI
> +              - compulab,cl-som-am57x # CompuLab CL-SOM-AM57x
> +              - ti,am5718-idk # TI AM5718 IDK
> +              - ti,am5728-idk # TI AM5728 IDK
> +              - ti,am5748-idk # TI AM5748 IDK
> +          - pattern: '^ti,am57[0124][689]$'
> +          - const: ti,am57
> +
> +      - description: TI DRA7 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,dra718-evm # TI DRA718 EVM
> +              - ti,dra722-evm # TI DRA722 EVM
> +              - ti,dra742-evm # TI DRA742 EVM
> +              - ti,dra762-evm # TI DRA762 EVM
> +          - pattern: '^ti,dra7[12456][024568p]$'
> +          - const: ti,dra7
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +        model = "TI OMAP2430 SDP (Software Development Board)";
> +        compatible = "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +    };
> +
> +  - |
> +    / {

You can't have 2 root node examples. Well, you can, but they are just
merged together...

We normally don't have examples for these either.

> +        model = "TI DRA762 EVM";
> +        compatible = "ti,dra762-evm", "ti,dra762", "ti,dra7";
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +    };
> +
> +...
> --
> 2.39.1
>
