Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDB6A7B68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCBGiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:38:06 -0500
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com [115.236.118.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C112048;
        Wed,  1 Mar 2023 22:38:01 -0800 (PST)
Received: from [172.16.12.93] (unknown [58.22.7.114])
        by mail-m11874.qiye.163.com (Hmail) with ESMTPA id C8A693C01EC;
        Thu,  2 Mar 2023 14:37:50 +0800 (CST)
Message-ID: <1889b80f-5fec-cee3-9cea-9b98cbe52f76@rock-chips.com>
Date:   Thu, 2 Mar 2023 14:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/8] ARM: dts: rockchip: add gpio-ranges property to
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
 <a071f3ee-a560-93bf-9c9e-0c1edf897d6a@gmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <a071f3ee-a560-93bf-9c9e-0c1edf897d6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpCTlZKGkpJShpCT09JHRlVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Khw5Tj0RIkIpFBIiFjFP
        ECgaCk9VSlVKTUxMTEhCS0xKTE1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEtMTDcG
X-HM-Tid: 0a86a10a96d62eb0kusnc8a693c01ec
X-HM-MType: 1
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/21 19:08, Johan Jonker wrote:
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
>   arch/arm/boot/dts/rk3036.dtsi  | 3 +++
>   arch/arm/boot/dts/rk3066a.dtsi | 6 ++++++
>   arch/arm/boot/dts/rk3128.dtsi  | 4 ++++
>   arch/arm/boot/dts/rk3188.dtsi  | 4 ++++
>   arch/arm/boot/dts/rk322x.dtsi  | 8 ++++++++
>   arch/arm/boot/dts/rk3288.dtsi  | 9 +++++++++
>   arch/arm/boot/dts/rv1108.dtsi  | 4 ++++
>   arch/arm/boot/dts/rv1126.dtsi  | 5 +++++
>   8 files changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 78686fc72..d99e4ea31 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -582,6 +582,7 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -595,6 +596,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -608,6 +610,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index de9915d94..6ff392735 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -280,6 +280,7 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -293,6 +294,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -306,6 +308,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -319,6 +322,7 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -332,6 +336,7 @@
>   			clocks = <&cru PCLK_GPIO4>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -345,6 +350,7 @@
>   			clocks = <&cru PCLK_GPIO6>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 192 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
> index b63bd4ad3..0ea277eb7 100644
> --- a/arch/arm/boot/dts/rk3128.dtsi
> +++ b/arch/arm/boot/dts/rk3128.dtsi
> @@ -476,6 +476,7 @@
>   			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO0>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -487,6 +488,7 @@
>   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO1>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -498,6 +500,7 @@
>   			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO2>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -509,6 +512,7 @@
>   			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO3>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 44b54af0b..6677e4a10 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -231,6 +231,7 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -244,6 +245,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -257,6 +259,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -270,6 +273,7 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index ffc16d6b9..a87db48c5 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -955,10 +955,12 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> +			rockchip,gpio-controller = <0>;
>   		};
>
>   		gpio1: gpio@11120000 {
> @@ -968,10 +970,12 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> +			rockchip,gpio-controller = <1>;
>   		};
>
>   		gpio2: gpio@11130000 {
> @@ -981,10 +985,12 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> +			rockchip,gpio-controller = <2>;
>   		};
>
>   		gpio3: gpio@11140000 {
> @@ -994,10 +1000,12 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> +			rockchip,gpio-controller = <3>;
>   		};
>
>   		pcfg_pull_up: pcfg-pull-up {
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2ca76b69a..20567ca98 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1431,6 +1431,7 @@
>   			clocks = <&cru PCLK_GPIO0>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1444,6 +1445,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1457,6 +1459,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1470,6 +1473,7 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1483,6 +1487,7 @@
>   			clocks = <&cru PCLK_GPIO4>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1496,6 +1501,7 @@
>   			clocks = <&cru PCLK_GPIO5>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 160 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1509,6 +1515,7 @@
>   			clocks = <&cru PCLK_GPIO6>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 192 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1522,6 +1529,7 @@
>   			clocks = <&cru PCLK_GPIO7>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 224 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -1535,6 +1543,7 @@
>   			clocks = <&cru PCLK_GPIO8>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 256 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index abf3006f0..d12b97ee7 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -602,6 +602,7 @@
>   			clocks = <&cru PCLK_GPIO0_PMU>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -615,6 +616,7 @@
>   			clocks = <&cru PCLK_GPIO1>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -628,6 +630,7 @@
>   			clocks = <&cru PCLK_GPIO2>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> @@ -641,6 +644,7 @@
>   			clocks = <&cru PCLK_GPIO3>;
>
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>
>   			interrupt-controller;
> diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
> index 1f07d0a4f..68e820221 100644
> --- a/arch/arm/boot/dts/rv1126.dtsi
> +++ b/arch/arm/boot/dts/rv1126.dtsi
> @@ -433,6 +433,7 @@
>   			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 0 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -444,6 +445,7 @@
>   			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 32 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -455,6 +457,7 @@
>   			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 64 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -466,6 +469,7 @@
>   			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 96 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> @@ -477,6 +481,7 @@
>   			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
>   			gpio-controller;
> +			gpio-ranges = <&pinctrl 0 128 32>;
>   			#gpio-cells = <2>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> --
> 2.20.1
>
