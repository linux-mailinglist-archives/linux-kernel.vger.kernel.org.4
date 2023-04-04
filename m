Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D76D6EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjDDVKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjDDVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:09:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756B10CC;
        Tue,  4 Apr 2023 14:09:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 334L9Wpc111198;
        Tue, 4 Apr 2023 16:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680642572;
        bh=onqPr9mEVO+U7FiPIUiywjeWvi73OnugS8heMEi3tiI=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=sylth1/lnjw0NGNRrifehZEZ4cYLHo+2XiMv2uJRcuwnYQVMkZBjxfoablZvfx2PW
         JIq7WsWJ6bg3/LINIo1V1qtClX8t99ycopd1d8Hm2K+yZfQiVx5rAm90fcwSzcoGC2
         MWZK8Ukfj59a1bsRE9Z4Kwf4fXu8jxAwL8HWnchU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 334L9W69030055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 16:09:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 16:09:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 16:09:32 -0500
Received: from [10.250.32.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 334L9Vho059596;
        Tue, 4 Apr 2023 16:09:32 -0500
Message-ID: <4b9ad103-3210-18cc-50f9-935d95a1efa3@ti.com>
Date:   Tue, 4 Apr 2023 16:09:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: omap: Convert omap.txt to yaml
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20230404205844.3553159-1-andreas@kemnade.info>
 <20230404205844.3553159-2-andreas@kemnade.info>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230404205844.3553159-2-andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 3:58 PM, Andreas Kemnade wrote:
> From: Andrew Davis <afd@ti.com>
> 
> Convert omap.txt to yaml.
> 
> CC: linux-omap@vger.kernel.org
> Signed-off-by: Andrew Davis <afd@ti.com>
> [various cleanup, adding Epson Moverio BT-200]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   .../devicetree/bindings/arm/omap/omap.txt     | 152 ------------------
>   Documentation/devicetree/bindings/arm/ti.yaml | 147 +++++++++++++++++

How about

Documentation/devicetree/bindings/arm/ti/omap.yaml

as we already have a arm/ti/k3.yaml for our K3 devices.

Andrew

>   2 files changed, 147 insertions(+), 152 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index fa8b31660cadd..0608ef36d0a68 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -41,49 +41,11 @@ SoC Type (optional):
>   
>   SoC Families:
>   
> -- OMAP2 generic - defaults to OMAP2420
> -  compatible = "ti,omap2"
> -- OMAP3 generic
> -  compatible = "ti,omap3"
> -- OMAP4 generic - defaults to OMAP4430
> -  compatible = "ti,omap4"
> -- OMAP5 generic - defaults to OMAP5430
> -  compatible = "ti,omap5"
>   - DRA7 generic - defaults to DRA742
>     compatible = "ti,dra7"
> -- AM33x generic
> -  compatible = "ti,am33xx"
> -- AM43x generic - defaults to AM4372
> -  compatible = "ti,am43"
>   
>   SoCs:
>   
> -- OMAP2420
> -  compatible = "ti,omap2420", "ti,omap2"
> -- OMAP2430
> -  compatible = "ti,omap2430", "ti,omap2"
> -
> -- OMAP3430
> -  compatible = "ti,omap3430", "ti,omap3"
> -  legacy: "ti,omap34xx" - please do not use any more
> -- AM3517
> -  compatible = "ti,am3517", "ti,omap3"
> -- OMAP3630
> -  compatible = "ti,omap3630", "ti,omap3"
> -  legacy: "ti,omap36xx" - please do not use any more
> -- AM335x
> -  compatible = "ti,am33xx"
> -
> -- OMAP4430
> -  compatible = "ti,omap4430", "ti,omap4"
> -- OMAP4460
> -  compatible = "ti,omap4460", "ti,omap4"
> -
> -- OMAP5430
> -  compatible = "ti,omap5430", "ti,omap5"
> -- OMAP5432
> -  compatible = "ti,omap5432", "ti,omap5"
> -
>   - DRA762
>     compatible = "ti,dra762", "ti,dra7"
>   
> @@ -96,116 +58,8 @@ SoCs:
>   - DRA718
>     compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
>   
> -- AM5748
> -  compatible = "ti,am5748", "ti,dra762", "ti,dra7"
> -
> -- AM5728
> -  compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> -
> -- AM5726
> -  compatible = "ti,am5726", "ti,dra742", "ti,dra74", "ti,dra7"
> -
> -- AM5718
> -  compatible = "ti,am5718", "ti,dra722", "ti,dra72", "ti,dra7"
> -
> -- AM5716
> -  compatible = "ti,am5716", "ti,dra722", "ti,dra72", "ti,dra7"
> -
> -- AM4372
> -  compatible = "ti,am4372", "ti,am43"
> -
>   Boards (incomplete list of examples):
>   
> -- OMAP3 BeagleBoard : Low cost community board
> -  compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
> -
> -- OMAP3 BeagleBoard A to B4 : Early BeagleBoard revisions A to B4 with a timer quirk
> -  compatible = "ti,omap3-beagle-ab4", "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
> -
> -- OMAP3 Tobi with Overo : Commercial expansion board with daughter board
> -  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3"
> -
> -- OMAP4 SDP : Software Development Board
> -  compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4"
> -
> -- OMAP4 PandaBoard : Low cost community board
> -  compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
> -
> -- OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
> -  compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
> -
> -- OMAP4 VAR-STK-OM44 : Commercial dev kit with VAR-OM44CustomBoard and VAR-SOM-OM44 w/WLAN
> -  compatible = "variscite,var-stk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
> -
> -- OMAP4 VAR-DVK-OM44 : Commercial dev kit with VAR-OM44CustomBoard, VAR-SOM-OM44 w/WLAN and LCD touchscreen
> -  compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
> -
> -- OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
> -  compatible = "ti,omap3-evm", "ti,omap3630", "ti,omap3"
> -
> -- AM335X EVM : Software Development Board for AM335x
> -  compatible = "ti,am335x-evm", "ti,am33xx"
> -
> -- AM335X Bone : Low cost community board
> -  compatible = "ti,am335x-bone", "ti,am33xx"
> -
> -- AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
> -  compatible = "ti,am3359-icev2", "ti,am33xx"
> -
> -- AM335X OrionLXm : Substation Automation Platform
> -  compatible = "novatech,am335x-lxm", "ti,am33xx"
> -
> -- AM335X phyBOARD-WEGA: Single Board Computer dev kit
> -  compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx"
> -
> -- AM335X CM-T335 : System On Module, built around the Sitara AM3352/4
> -  compatible = "compulab,cm-t335", "ti,am33xx"
> -
> -- AM335X SBC-T335 : single board computer, built around the Sitara AM3352/4
> -  compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx"
> -
> -- AM335X phyCORE-AM335x: Development kit
> -  compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
> -
> -- AM335x phyBOARD-REGOR: Single Board Computer
> -  compatible = "phytec,am335x-regor", "phytec,am335x-phycore-som", "ti,am33xx"
> -
> -- AM335X UC-8100-ME-T: Communication-centric industrial computing platform
> -  compatible = "moxa,uc-8100-me-t", "ti,am33xx";
> -
> -- OMAP5 EVM : Evaluation Module
> -  compatible = "ti,omap5-evm", "ti,omap5"
> -
> -- AM437x CM-T43
> -  compatible = "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
> -
> -- AM437x SBC-T43
> -  compatible = "compulab,am437x-sbc-t43", "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
> -
> -- AM43x EPOS EVM
> -  compatible = "ti,am43x-epos-evm", "ti,am43", "ti,am438x"
> -
> -- AM437x GP EVM
> -  compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
> -
> -- AM437x SK EVM: AM437x StarterKit Evaluation Module
> -  compatible = "ti,am437x-sk-evm", "ti,am4372", "ti,am43"
> -
> -- AM57XX CL-SOM-AM57x
> -  compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> -
> -- AM57XX SBC-AM57x
> -  compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> -
> -- AM5748 IDK
> -  compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
> -
> -- AM5728 IDK
> -  compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
> -
> -- AM5718 IDK
> -  compatible = "ti,am5718-idk", "ti,am5718", "ti,dra7"
> -
>   - DRA762 EVM:  Software Development Board for DRA762
>     compatible = "ti,dra76-evm", "ti,dra762", "ti,dra7"
>   
> @@ -217,9 +71,3 @@ Boards (incomplete list of examples):
>   
>   - DRA718 EVM: Software Development Board for DRA718
>     compatible = "ti,dra718-evm", "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
> -
> -- DM3730 Logic PD Torpedo + Wireless: Commercial System on Module with WiFi and Bluetooth
> -  compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3"
> -
> -- DM3730 Logic PD SOM-LV: Commercial System on Module with WiFi and Bluetooth
> -  compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3"
> diff --git a/Documentation/devicetree/bindings/arm/ti.yaml b/Documentation/devicetree/bindings/arm/ti.yaml
> new file mode 100644
> index 0000000000000..d0374fea519d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ti.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP SoC architecture
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description: Platforms based on Texas Instruments OMAP SoC architecture.
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
> +              - nokia,n800
> +              - nokia,n810
> +              - nokia,n810-wimax
> +              - ti,omap2420-h4
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
> +              - compulab,omap3-cm-t3530
> +              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom OMAP35xx SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx Torpedo Development Kit
> +              - nokia,omap3-n900
> +              - openpandora,omap3-pandora-600mhz
> +              - ti,omap3430-sdp
> +              - ti,omap3-beagle
> +              - ti,omap3-evm                  # TI OMAP35XX EVM (TMDSEVM3530)
> +              - ti,omap3-ldp                  # TI OMAP3430 LDP (Zoom1 Labrador)
> +              - timll,omap3-devkit8000
> +          - const: ti,omap3430
> +          - const: ti,omap3
> +
> +      - description: TI OMAP3630 SoC based platforms
> +        items:
> +          - enum:
> +              - amazon,omap3-echo             # Amazon Echo (first generation)
> +              - compulab,omap3-cm-t3730
> +              - goldelico,gta04
> +              - lg,omap3-sniper               # LG Optimus Black
> +              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom DM3730 SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
> +              - nokia,omap3-n9
> +              - nokia,omap3-n950
> +              - openpandora,omap3-pandora-1ghz
> +              - ti,omap3-beagle-xm
> +              - ti,omap3-evm-37xx             # TI OMAP37XX EVM (TMDSEVM3730)
> +              - ti,omap3-zoom3
> +          - const: ti,omap3630
> +          - const: ti,omap3
> +
> +      - description: TI AM35 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
> +              - teejet,mt_ventoux
> +              - ti,am3517-craneboard     # TI AM3517 CraneBoard (TMDSEVM3517)
> +              - ti,am3517-evm            # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
> +          - const: ti,am3517
> +          - const: ti,omap3
> +
> +      - description: TI OMAP4430 SoC based platforms
> +        items:
> +          - enum:
> +              - amazon,omap4-kc1        # Amazon Kindle Fire (first generation)
> +              - motorola,droid4         # Motorola Droid 4 XT894
> +              - motorola,droid-bionic   # Motorola Droid Bionic XT875
> +              - ti,omap4-panda
> +              - ti,omap4-sdp
> +          - const: ti,omap4430
> +          - const: ti,omap4
> +
> +      - description: TI OMAP4460 SoC based platforms
> +        items:
> +          - enum:
> +              - epson,epson,embt2ws    # Epson Moverio BT-200
> +              - ti,omap4-panda-es
> +          - const: ti,omap4460
> +          - const: ti,omap4
> +
> +      - description: TI OMAP5 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,omap5-cm-t54
> +              - isee,omap5-igep0050
> +              - ti,omap5-uevm
> +          - const: ti,omap5
> +
> +      - description: TI AM33 SoC based platforms
> +        items:
> +          - enum:
> +              - bosch,am335x-guardian
> +              - compulab,cm-t335
> +              - gumstix,am335x-pepper
> +              - moxa,uc-2101
> +              - moxa,uc-8100-me-t
> +              - novatech,am335x-lxm  # NovaTech OrionLXm
> +              - tcl,am335x-sl50      # Toby Churchill SL50 Series
> +              - ti,am335x-bone
> +              - ti,am335x-evm
> +              - ti,am335x-evmsk
> +              - ti,am3359-icev2
> +          - pattern: '^ti,am33(5[1246789]|xx)$' # ti,am33xx is legacy please use full SoC name
> +
> +      - description: TI AM43 SoC based platforms
> +        items:
> +          - enum:
> +              - compulab,am437x-cm-t43
> +              - ti,am437x-gp-evm
> +              - ti,am437x-idk-evm
> +              - ti,am437x-sk-evm
> +          - pattern: '^ti,am4372[26789]$'
> +          - const: ti,am43
> +
> +      - description: TI AM57 SoC based platforms
> +        items:
> +          - enum:
> +              - beagle,am5729-beagleboneai
> +              - compulab,cl-som-am57x
> +              - ti,am5718-idk
> +              - ti,am5728-idk
> +              - ti,am5748-idk
> +          - pattern: '^ti,am57[0124][689]$'
> +          - const: ti,am57
> +
> +additionalProperties: true
> +
> +...
