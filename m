Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59426EE1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjDYMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:36:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF76133;
        Tue, 25 Apr 2023 05:36:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PCaQSE118702;
        Tue, 25 Apr 2023 07:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682426186;
        bh=a8ZzUBxGcdZC2WqUfeTHPotN0IAVG//7JNbWuLbiUpE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nHLHr54hhJdVbMneEB3ZAbkOwlGf1ZLYjdnBukgxxhVj3o29dToZ+UGx/5u3BwYp1
         qK0AfFeBejZ6RKeieoXESLQWP9maNIX7fmt7hOFthknx2HrB13Z4NCLFduMqeZPvJ2
         QbBPclKW1G7maNKtN3FPS9zgyjXgDX3MXrnTwdTQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PCaQcp128970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 07:36:26 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 07:36:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 07:36:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PCaPoH026635;
        Tue, 25 Apr 2023 07:36:25 -0500
Date:   Tue, 25 Apr 2023 07:36:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH 1/2] arm64: dts: ti: Add overlay for OLDI-LCD1EVM Display
 and touch screen
Message-ID: <20230425123625.avecko7gzx6s7uap@greedy>
References: <20230425051235.15533-1-a-bhatia1@ti.com>
 <20230425051235.15533-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230425051235.15533-2-a-bhatia1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject could do a bit of improvement.

On 10:42-20230425, Aradhya Bhatia wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> The OLDI-LCD1EVM add on board has Rocktech RK101II01D-CT panel with
> integrated touch screen. The integrated touch screen is Goodix GT928.
> Add DT nodes for these and connect the endpoint nodes with DSS.
> 
> This patch was picked from TI's public tree based on 5.10 LTS kernel.

Please drop this.

> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> [abhatia1@ti.com: Make syntax changes to support 6.1 DTSO format]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  .../dts/ti/k3-am654-evm-oldi-lcd1evm.dtso     | 70 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6acd12409d59..8956b19e587a 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-evm-oldi-lcd1evm.dtbo
>  
>  # Boards with J7200 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> @@ -45,3 +46,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>  
>  # Enable support for device-tree overlays
>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
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

Product link?

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
> +		status = "okay";

Status is okay by default.

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
> -- 
> 2.39.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
