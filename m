Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3C6EDCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDYHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjDYHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:35:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78367D30E;
        Tue, 25 Apr 2023 00:35:19 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58CFBAB;
        Tue, 25 Apr 2023 09:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682408107;
        bh=ipYHM2TMHh8mOltD733No+AnX1CuUoxSHuYan1Ob8hc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HlterMRhxAKE1xBSZDjuQxrK7DSLCnNNXBRpLad3hWl+xQybQFVoh5GXGUOGJvzTg
         wChVkaQc7H1Dpzw2q9w3B4WOLcTwhBlbQo9KMoOa4rLT5wKm2FwCLE0gOiO+7WkE8B
         f6t6DYD6QkkYZ6OgamaiSHQVC1ySqI+nuyE/1TsU=
Message-ID: <1478ab6c-5a2b-6177-d909-925f63383c41@ideasonboard.com>
Date:   Tue, 25 Apr 2023 10:35:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: Add overlay for OLDI-LCD1EVM Display
 and touch screen
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230425051235.15533-1-a-bhatia1@ti.com>
 <20230425051235.15533-2-a-bhatia1@ti.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230425051235.15533-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 08:12, Aradhya Bhatia wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> The OLDI-LCD1EVM add on board has Rocktech RK101II01D-CT panel with
> integrated touch screen. The integrated touch screen is Goodix GT928.
> Add DT nodes for these and connect the endpoint nodes with DSS.
> 
> This patch was picked from TI's public tree based on 5.10 LTS kernel.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [abhatia1@ti.com: Make syntax changes to support 6.1 DTSO format]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  2 +
>   .../dts/ti/k3-am654-evm-oldi-lcd1evm.dtso     | 70 +++++++++++++++++++
>   2 files changed, 72 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6acd12409d59..8956b19e587a 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-evm-oldi-lcd1evm.dtbo
>   
>   # Boards with J7200 SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> @@ -45,3 +46,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>   
>   # Enable support for device-tree overlays
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
> +DTC_FLAGS_k3-am654-base-board += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso b/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
> new file mode 100644
> index 000000000000..b2c790b314cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
> @@ -0,0 +1,70 @@
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
> +	gt928: touchscreen@14 {

I don't see the 'gt928' label used for anything.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> +		status = "okay";
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

