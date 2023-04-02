Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99786D379D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDBL04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 07:26:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC426A62;
        Sun,  2 Apr 2023 04:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54C87B80E2C;
        Sun,  2 Apr 2023 11:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A187C433EF;
        Sun,  2 Apr 2023 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680434810;
        bh=HWff7eibON8w+XDz0Uya0LSYSO5UEYLrhxzi6vZ81pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SjCvc4Va+C2Kp9174pX05RKbrEOcClJ55xUIhhwk896AqTCUJtbPp5DYu5Y040hKI
         s6pXZT1w0HbRSxbnxskVpzqhGmno6uD3BUXn9iqg92LU4ZKvBM4zx9ObO85JTL+ugQ
         mTRAKBpjMoMfGMqWRAs8L2VzoYQuuHH+k3NKaQGoj6qHjC0AGhvsbuWpdnYXS55VI9
         YkaaJ1NWOPlXHUzKQNh/yBCsEsUgXuRBxMVjoiOiGuzfH01u8L8r7BoTy8n1n5+kVL
         Mf8W8x8NlSfcjRimx0Jv6BXhJVK8OTYAkHHViLqiE99Hpx1pvksokFph1Z53Ms1ra6
         fihpzPSCP4n1g==
Message-ID: <3865a750-2cd1-c92f-8bd2-22dfeea43769@kernel.org>
Date:   Sun, 2 Apr 2023 13:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: omap: Convert omap.txt to yaml
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Cc:     Andrew Davis <afd@ti.com>
References: <20230401140248.3363674-1-andreas@kemnade.info>
 <20230401140248.3363674-2-andreas@kemnade.info>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230401140248.3363674-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 16:02, Andreas Kemnade wrote:
> From: Andrew Davis <afd@ti.com>
> 
> Convert omap.txt to yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> [various cleanup, adding Epson Moverio BT-200]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Your CC list is broken in few ways. Just use the script, don't re-invent
the addresses.

> ---
>  .../devicetree/bindings/arm/omap/omap.txt     | 185 ------------------
>  Documentation/devicetree/bindings/arm/ti.yaml | 157 +++++++++++++++
>  2 files changed, 157 insertions(+), 185 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml
> 

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
> +              - ti,omap2420-h4
> +              - nokia,n800
> +              - nokia,n810
> +              - nokia,n810-wimax

This looks unordered.

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
> +              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom OMAP35xx SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx Torpedo Development Kit
> +              - ti,omap3430-sdp
> +              - ti,omap3-beagle
> +              - compulab,omap3-cm-t3530
> +              - timll,omap3-devkit8000
> +              - ti,omap3-evm                  # TI OMAP35XX EVM (TMDSEVM3530)
> +              - ti,omap3-ldp                  # TI OMAP3430 LDP (Zoom1 Labrador)
> +              - nokia,omap3-n900
> +              - openpandora,omap3-pandora-600mhz

This section looks in even more random order.

> +          - const: ti,omap3430
> +          - const: ti,omap3
> +
> +      - description: TI OMAP3630 SoC based platforms
> +        items:
> +          - enum:
> +              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom DM3730 SOM-LV Development Kit
> +              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
> +              - ti,omap3-beagle-xm
> +              - compulab,omap3-cm-t3730
> +              - amazon,omap3-echo             # Amazon Echo (first generation)
> +              - ti,omap3-evm-37xx             # TI OMAP37XX EVM (TMDSEVM3730)
> +              - goldelico,gta04
> +              - nokia,omap3-n9
> +              - nokia,omap3-n950
> +              - lg,omap3-sniper               # LG Optimus Black
> +              - ti,omap3-zoom3
> +              - openpandora,omap3-pandora-1ghz
> +          - const: ti,omap3630
> +          - const: ti,omap3
> +
> +      - description: TI AM35 SoC based platforms
> +        items:
> +          - enum:
> +              - teejet,mt_ventoux
> +              - ti,am3517-craneboard     # TI AM3517 CraneBoard (TMDSEVM3517)
> +              - ti,am3517-evm            # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
> +              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
> +          - const: ti,am3517
> +          - const: ti,omap3
> +
> +      - description: TI OMAP4430 SoC based platforms
> +        items:
> +          - enum:
> +              - motorola,droid4         # Motorola Droid 4 XT894
> +              - motorola,droid-bionic   # Motorola Droid Bionic XT875
> +              - amazon,omap4-kc1        # Amazon Kindle Fire (first generation)
> +              - ti,omap4-panda
> +              - ti,omap4-sdp
> +          - const: ti,omap4430
> +          - const: ti,omap4
> +
> +      - description: TI OMAP4460 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,omap4-panda-es
> +              - epson,epson,embt2ws    # Epson Moverio BT-200
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
> +              - ti,am335x-bone
> +              - compulab,cm-t335
> +              - ti,am335x-evm
> +              - ti,am335x-evmsk
> +              - bosch,am335x-guardian
> +              - ti,am3359-icev2
> +              - novatech,am335x-lxm  # NovaTech OrionLXm
> +              - moxa,uc-2101
> +              - moxa,uc-8100-me-t
> +              - gumstix,am335x-pepper
> +              - tcl,am335x-sl50      # Toby Churchill SL50 Series
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
> +      - description: TI DRA7 SoC based platforms
> +        items:
> +          - enum:
> +              - ti,dra718-evm

This is not correct. Maybe you forgot to fix DTS, but anyway it's
confusing to have dra718-evm with dra768 SoC. Is this really proper
combination?


> +              - ti,dra722-evm
> +              - ti,dra742-evm
> +              - ti,dra762-evm
> +          - pattern: '^ti,dra7[12456][024568p]$'
> +          - const: ti,dra7

Best regards,
Krzysztof

