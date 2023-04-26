Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052DF6EF55D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjDZNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbjDZNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:18:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF25B8D;
        Wed, 26 Apr 2023 06:18:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QDHlor087488;
        Wed, 26 Apr 2023 08:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682515067;
        bh=bm39y/3rn8ZVI7gY05r2k/pqw9j6s7tCMmBsLUBkuzs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Y2Ky3t8b/7oeuRPtEXXyGYYJH+e0mY1/1MDgEEhSzCOQPASD/f/pvHDON8t5f3dXq
         VZ5cAdQnog1Dm8DX6FdOqLZrTPh8NESwBkODJyUqZp1J+AA8tTGCg7iZLc7lmnkfgv
         1sGoPe1wNnR28yD8kw6yDi3Ns0g3GSvnjJ5nvSJc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QDHliv108289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 08:17:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Apr 2023 08:17:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 08:17:47 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QDHkF1070239;
        Wed, 26 Apr 2023 08:17:46 -0500
Message-ID: <f9c70ad4-55c7-7ff7-b1dc-936830d50714@ti.com>
Date:   Wed, 26 Apr 2023 08:17:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] arm64: dts/ti: am65x: Add Rocktech OLDI panel DT
 overlay
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230426060612.19271-1-a-bhatia1@ti.com>
 <20230426060612.19271-2-a-bhatia1@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230426060612.19271-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 1:06 AM, Aradhya Bhatia wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> The OLDI-LCD1EVM add on board has Rocktech RK101II01D-CT panel[1] with
> integrated touch screen. The integrated touch screen is Goodix GT928.
> Add DT nodes for these and connect the endpoint nodes with DSS.
> 
> [1]: Product datasheet
> https://www.digimax.it/media_import/DISPLAY/ROCKTECH/TFT%20LCD/RK101II01D-CT/RK101II01D-CT_DS_001.pdf
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [abhatia1@ti.com: Make cosmetic and 6.1 DTSO syntax changes]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm64/boot/dts/ti/Makefile               |  2 +
>   ...am654-base-board-rocktech-rk101-panel.dtso | 69 +++++++++++++++++++
>   2 files changed, 71 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6acd12409d59..3e6c4aa24f85 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -20,12 +20,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   
>   # Boards with AM65x SoC
> +k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
>   
>   # Boards with J7200 SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> new file mode 100644
> index 000000000000..aed6dcf3bd7d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&{/} {
> +	display0 {
> +		compatible = "rocktech,rk101ii01d-ct";
> +		backlight = <&lcd_bl>;
> +		enable-gpios = <&pca9555 8 GPIO_ACTIVE_HIGH>;
> +		port {
> +			lcd_in0: endpoint {
> +				remote-endpoint = <&oldi_out0>;
> +			};
> +		};
> +	};
> +
> +	lcd_bl: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels =
> +			<0 32 64 96 128 160 192 224 255>;
> +		default-brightness-level = <8>;
> +	};
> +};
> +
> +&dss {
> +	status = "okay";
> +};
> +
> +&dss_ports {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	port@0 {
> +		reg = <0>;
> +
> +		oldi_out0: endpoint {
> +			remote-endpoint = <&lcd_in0>;
> +		};
> +	};
> +};
> +
> +&main_i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	touchscreen@14 {
> +		compatible = "goodix,gt928";
> +		reg = <0x14>;
> +
> +		interrupt-parent = <&pca9554>;
> +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x = <1280>;
> +		touchscreen-size-y = <800>;
> +
> +		reset-gpios = <&pca9555 9 GPIO_ACTIVE_HIGH>;
> +		irq-gpios = <&pca9554 3 GPIO_ACTIVE_HIGH>;
> +	};
> +};
