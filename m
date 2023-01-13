Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795D669653
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjAMMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAMMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:02:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596E831A1;
        Fri, 13 Jan 2023 03:54:19 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30DBs0H1018134;
        Fri, 13 Jan 2023 05:54:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673610840;
        bh=NjK3ll3K3PU3Y2EKZgN7uX2wCYmbFcRcjDsJF3k/myE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eD44ySg4bX2VY6nH4Aa3DVwlAyttpcNgMTaU1i2f13sI55/X5EwAYZ5K/3ZWzTlnw
         FPhSq/NdbbyN1vT1npCdR2xnpP5r66ejhyd6If+IBgRx4JDZd1ew3VYb5PzroN/P2B
         KKTn54ovdU5m79aIkwTo+n/ArwwBBOoiUspYrbYI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30DBs05D116596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jan 2023 05:54:00 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 13
 Jan 2023 05:54:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 13 Jan 2023 05:54:00 -0600
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30DBrvxD029551;
        Fri, 13 Jan 2023 05:53:57 -0600
Message-ID: <d109dbf8-ba51-7322-34e7-f688c5a18908@ti.com>
Date:   Fri, 13 Jan 2023 17:23:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH V3 2/3] arm64: dts: ti: Add initial support for
 AM68 SK System on Module
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230110110052.14851-1-sinthu.raja@ti.com>
 <20230110110052.14851-3-sinthu.raja@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230110110052.14851-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 10/01/23 16:30, Sinthu Raja wrote:
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
> Changes in V3:
> =============
> Addressed review comments
>  - Removed the unused nodes that are disabled by default.
> OSPI support will be added once the OSPI node is enabled for J721s2/AM68 in main DTSI.
> 
> Changes in V2:
> =============
> Address review comments
>  - drop the empty lines.
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-3-sinthu.raja@ti.com/
> V2: https://lore.kernel.org/lkml/20221107123852.8063-3-sinthu.raja@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> new file mode 100644
> index 000000000000..c35f81edee8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -0,0 +1,31 @@
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
> +	/* Reserving memory regions still pending */

Is this comment needed?

> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;

Is alignment needed here?

Please see https://lore.kernel.org/lkml/cd5dbbb0-2d9f-8d7d-b051-f8d01d710c62@ti.com/

> +			no-map;
> +		};
> +	};
> +};

-- 
Regards,
Vaishnav
