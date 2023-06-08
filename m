Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E05727C45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFHKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjFHKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:04:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5C2D4A;
        Thu,  8 Jun 2023 03:04:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589VfeW024371;
        Thu, 8 Jun 2023 12:04:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=25By25eZ9+apvHmnFy05WmGq+kLPlKCKhTFuzTbhMlE=;
 b=Dkn/PNi/gKK44IZDaGBN3hpDzEWHfZ94uzySzRbBmb+ujKClntnMR+XIv+7W/7AMym8a
 oLaoxBk55GhhM+YaviEqGv41bm4Botlee12XI6xwzH5ia0ik3rvaqy3XHovK5ipoP44i
 B9qzcH1ghAC6QTu8TahdH+Y4xos4AdeF5os7a0HFlBBkUb2uSUB9nUtmMZhM/t+8DM/i
 DvMxrxzrEwHuUVAK4M7CtdZrt6Pni9wHXsvVKo6uRFKR9ANZialtiVKjrihd1H3ns2sx
 MUO1h8LAzkLgP8QmfSwTYKlJRLcm903aFfmr7nEeri3GT6mvyIv5Qe/CkB0ycn5yUGei Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r34893emy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 12:04:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B081100046;
        Thu,  8 Jun 2023 12:04:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A2B1222C9B;
        Thu,  8 Jun 2023 12:04:01 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 8 Jun
 2023 12:04:01 +0200
Message-ID: <65e46951-6b8d-6f18-d6be-16bacd247cd6@foss.st.com>
Date:   Thu, 8 Jun 2023 12:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 5/5] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <dantuguf14105@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230606145555.2155664-1-sean@geanix.com>
 <20230606145555.2155664-5-sean@geanix.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230606145555.2155664-5-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 16:55, Sean Nyekjaer wrote:
> Add support for the Octavo OSD32MP1-RED development board.
> 
> General features:
>   - STM32MP157C
>   - 512MB DDR3
>   - CAN-FD
>   - HDMI
>   - USB-C OTG
>   - UART
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> This is made with great inspiration from Neeraj Dantu's work:
> https://raw.githubusercontent.com/octavosystems/OSD32MP1-RED-Device-tree/main/linux-v5.10-r0/stm32mp157c-osd32mp1-red.dts
> 
> So what copyright is needed here?
> And author?

hum maybe Rob, or Krzystof will have a better answer than me but I would 
say that only your name is enough. It's boards descriptions based on 
common binding so at the end if 2 boards are quite similar their DT will 
be similar. Not sure, but adding Neeraj as author could impose to him a 
kind of responsibility to this file, and you have to check this point 
with him if plan to add him.

Alex

> 
> Still need to test ethernet and HDMI, thats why I have done this a RFC.
> 
>   .../arm/boot/dts/stm32mp157c-osd32mp1-red.dts | 186 ++++++++++++++++++
>   1 file changed, 186 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts
> new file mode 100644
> index 000000000000..dd4e2668878c
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-osd32mp1-red.dts
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) ?? - All Rights Reserved
> + * Author: ???
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15xx-osd32mp1.dtsi"
> +
> +/ {
> +	model = "Octavo OSD32MP1 RED board";
> +	compatible = "octavo,stm32mp157c-osd32mp1-red", "st,stm32mp157";
> +
> +	aliases {
> +		serial0 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xc0000000 0x20000000>;
> +	};
> +
> +	led {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			label = "heartbeat";
> +			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;
> +	phy-handle = <&phy0>;
> +	st,eth-clk-sel;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@0 {
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +
> +&i2s2{
> +	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc PLL3_R>;
> +	clock-names = "pclk", "i2sclk", "x8k", "x11k";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2s2_pins_b>;
> +	pinctrl-1 = <&i2s2_sleep_pins_b>;
> +	status = "okay";
> +
> +	i2s2_port: port {
> +		i2s2_endpoint: endpoint {
> +			remote-endpoint = <&sii9022_tx_endpoint>;
> +			format = "i2s";
> +			mclk-fs = <256>;
> +		};
> +	};
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&ltdc{
> +	status = "okay";
> +
> +	port {
> +		ltdc_ep0_out: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +	};
> +};
> +
> +&i2c1{
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	pinctrl-1 = <&i2c1_sleep_pins_a>;
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	hdmi-transmitter@39 {
> +		compatible = "sil,sii9022";
> +		reg = <0x39>;
> +		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpiog>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ltdc_pins_e>;
> +		pinctrl-1 = <&ltdc_sleep_pins_e>;
> +		status = "okay";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&ltdc_ep0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				sii9022_tx_endpoint: endpoint {
> +					remote-endpoint = <&i2s2_endpoint>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&tamp {
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	cd-gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	disable-wp;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <8>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&vdd>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	status = "okay";
> +};
> +
> +&m_can1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can1_pins_d>;
> +	pinctrl-1 = <&m_can1_sleep_pins_d>;
> +	status = "okay";
> +};

