Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015F6A7B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCBGiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBGiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:38:16 -0500
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B27A265A3;
        Wed,  1 Mar 2023 22:38:14 -0800 (PST)
Received: from [172.16.12.93] (unknown [58.22.7.114])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id 2E07B3C01E4;
        Thu,  2 Mar 2023 14:38:11 +0800 (CST)
Message-ID: <6eff30d4-aad3-33e7-49ff-707bca1bda11@rock-chips.com>
Date:   Thu, 2 Mar 2023 14:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] arm64: dts: rockchip: add gpio-ranges property to
 gpio nodes
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        sjg@chromium.org, philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
 <845d82ef-bd36-cc95-dde8-48429597d51b@gmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <845d82ef-bd36-cc95-dde8-48429597d51b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9KSlZJSE4ZSB8fSRhNH0pVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6Tgw5Nz0KHEJIIhwzFitC
        Ag1PCQ1VSlVKTUxMTEhCS0JJSUJDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS01CTTcG
X-HM-Tid: 0a86a10ae73c2eb0kusn2e07b3c01e4
X-HM-MType: 1
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/21 19:09, Johan Jonker wrote:
> Add a gpio-ranges property to Rockchip gpio nodes to be
> independent from aliases and probe order for our bank id.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Looks good to me, GPIO controller has 32 pin each bank, even if there 
may have some empty bits.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,
- Kever
> ---
>
> Number of pins per bank not checked with datasheet.
> Use default 32 for now.
> ---
>   arch/arm64/boot/dts/rockchip/px30.dtsi   | 4 ++++
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++++
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++++
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
>   6 files changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 4f6959eb5..9fcc0d0f3 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -1387,6 +1387,7 @@
>   			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&pmucru PCLK_GPIO0_PMU>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1399,6 +1400,7 @@
>   			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO1>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1411,6 +1413,7 @@
>   			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO2>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1423,6 +1426,7 @@
>   			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO3>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index dd228a256..38976f413 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -798,6 +798,7 @@
>   			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO0>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -809,6 +810,7 @@
>   			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO1>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -820,6 +822,7 @@
>   			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO2>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -831,6 +834,7 @@
>   			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO3>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -842,6 +846,7 @@
>   			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO4>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 6d7a7bf72..7ba695728 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -1051,6 +1051,7 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1064,6 +1065,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1077,6 +1079,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1090,6 +1093,7 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index a4c5aaf1f..5a008ed18 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -984,6 +984,7 @@
>   			interrupts = <GIC_SPI 0x51 IRQ_TYPE_LEVEL_HIGH>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -997,6 +998,7 @@
>   			interrupts = <GIC_SPI 0x52 IRQ_TYPE_LEVEL_HIGH>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -1010,6 +1012,7 @@
>   			interrupts = <GIC_SPI 0x53 IRQ_TYPE_LEVEL_HIGH>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -1023,6 +1026,7 @@
>   			interrupts = <GIC_SPI 0x54 IRQ_TYPE_LEVEL_HIGH>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 1881b4b71..7eb96fcc6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2091,6 +2091,7 @@
>   			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -2104,6 +2105,7 @@
>   			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -2117,6 +2119,7 @@
>   			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -2130,6 +2133,7 @@
>   			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> @@ -2143,6 +2147,7 @@
>   			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <0x2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index eed0059a6..870b4d9c6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -1808,6 +1808,7 @@
>   			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -1819,6 +1820,7 @@
>   			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -1830,6 +1832,7 @@
>   			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -1841,6 +1844,7 @@
>   			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -1852,6 +1856,7 @@
>   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> --
> 2.20.1
>
