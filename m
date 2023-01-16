Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF566C0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAPOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAPOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:04:26 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532522787;
        Mon, 16 Jan 2023 06:03:06 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GE2qDv027761;
        Mon, 16 Jan 2023 08:02:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673877772;
        bh=RvMrcOnoZ7zgQpoByxWk6Ame8Dz6zp6IIoFQ6RO6aKQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=S1tN0bU7HnADi66c4at+4QyhtV4MXAEI56IaKbTHwbpgq029ARSJkNOgJoSFCTjav
         nTfgfGAJI95/+SAj8JaIL1N0+UK4xkwSEpvkSPl4ttMyuJAJFa4eBb28VK/5VCBRKj
         KgkU8fD4dy7BTXLesIWQ2zD/oeOBOINIBJSeVOyo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GE2qtm000586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 08:02:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 08:02:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 08:02:51 -0600
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GE2m1C001156;
        Mon, 16 Jan 2023 08:02:49 -0600
Message-ID: <6740eba8-5473-28ad-94f2-5e433c02c2b1@ti.com>
Date:   Mon, 16 Jan 2023 19:32:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V5 2/3] arm64: dts: ti: Add initial support for AM68 SK
 System on Module
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230116071446.28867-1-sinthu.raja@ti.com>
 <20230116071446.28867-3-sinthu.raja@ti.com>
Content-Language: en-US
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230116071446.28867-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 16/01/23 12:44, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> AM68 Starter Kit (SK) is a low cost, small form factor board designed
> for TI’s AM68 SoC. TI’s AM68 SoC comprises of dual core A72, high
> performance vision accelerators, hardware accelerators, latest C71x
> DSP, high bandwidth real-time IPs for capture and display. The SoC is
> power optimized to provide best in class performance for industrial
> applications.
> 
>     AM68 SK supports the following interfaces:
>       * 16 GB LPDDR4 RAM
>       * x1 Gigabit Ethernet interface
>       * x1 USB 3.1 Type-C port
>       * x2 USB 3.1 Type-A ports
>       * x1 PCIe M.2 M Key
>       * 512 Mbit OSPI flash
>       * x2 CSI2 Camera interface (RPi and TI Camera connector)
>       * 40-pin Raspberry Pi GPIO header
> 
> SK's System on Module (SoM) contains the SoC and DDR.
> Therefore, add DT node for the SOC and DDR on the SoM.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> TRM: http://www.ti.com/lit/pdf/spruj28
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V5:
> =============
> Address review comments:
> - Remove the unessential comment.
> - Remove alignment property from secure-ddr node, as no memory is allocated out
>   of this region.
> 
> No changes in V4.
> 
> Changes in V3:
> =============
> Addressed review comments
> - Removed the unused nodes that are disabled by default.
> OSPI support will be added once the OSPI node is enabled for J721s2/AM68 in main DTSI.
> 
> Changes in V2:
> =============
> Address review comments
> - drop the empty lines.
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-3-sinthu.raja@ti.com/
> V2: https://lore.kernel.org/lkml/20221107123852.8063-3-sinthu.raja@ti.com/
> V3: https://lore.kernel.org/lkml/20230110110052.14851-3-sinthu.raja@ti.com/
> V4: https://lore.kernel.org/lkml/20230105151740.29436-3-sinthu.raja@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> new file mode 100644
> index 000000000000..e92431250729
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-j721s2.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 16 GB RAM */
> +		reg = <0x00 0x80000000 0x00 0x80000000>,
> +		      <0x08 0x80000000 0x03 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			no-map;
> +		};
> +	};

Thank you for making the updates,

Tested-by: Vaishnav Achath <vaishnav.a@ti.com>

Bootlogs during my testing :
https://gist.github.com/vaishnavachath/64b58be41028c646b06568a73faed2fd

> +};

-- 
Regards,
Vaishnav
