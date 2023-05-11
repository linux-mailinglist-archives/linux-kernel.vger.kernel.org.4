Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF86FF347
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjEKNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbjEKNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:42:42 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C39106FE;
        Thu, 11 May 2023 06:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683812497; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K671dRJqJ6CcUVcTDR2GrznlYg85PJvfwUuPHVNQTONH+XIWXPEmoWVjgeRAs/P1Mh2Qna2pF2XXjmqoHr0hG51Uhq8WFRPzPl9W3qRm8vAUfBE+DZHvzAiTyJAiT52GtdR/ZMVag+SFF572cABX5VeYY0VcMREeesv8UOHC4Vc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683812497; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NJC90hJhhjD1XBhnChgbIuywfFFmozsScJkdqRfbtqQ=; 
        b=QlPAIFd/rrIJgQgcfZubrazWVZlDGzQCxgZvo/wpQW7JHd8q34YkNNDSTMlDhEnA4vKsJI2g3GZBTHfT493L4X9WlaaAkH3LkuUN32NI1wBWezshL7utjgfVEf20rLVrUkDM+khWI/3AzF02kY5qbej88P2Hey74sA26LSvE7Ds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683812497;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=NJC90hJhhjD1XBhnChgbIuywfFFmozsScJkdqRfbtqQ=;
        b=fTbs23CUVhdvZ2u6uSsIsvpFnrMVxDkJ8jBLHeCCCYhRnDO+erlpFxQsWvDmxR6m
        MS48YPnjNPxgQGPBRABS5KjMpy3ym+W8oO9X1ApAJyUYMoPSv3foyDeuiqDAEWX/Na7
        Qql8YxzyGbe5njMDSB9p+Jf1CqTKjXsdqHF8LHQc=
Received: from [10.1.111.147] (185.242.250.116-ip.operadors.cat [185.242.250.116]) by mx.zohomail.com
        with SMTPS id 1683812496359181.1424886960276; Thu, 11 May 2023 06:41:36 -0700 (PDT)
Message-ID: <43301707-8763-2a9f-956d-1ea0ae004a56@arinc9.com>
Date:   Thu, 11 May 2023 15:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mips: dts: ralink: Add support for TP-Link HC220 G5 v1
 board.
Content-Language: en-US
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230509200125.309026-1-liviu@dudau.co.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230509200125.309026-1-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.05.2023 22:01, Liviu Dudau wrote:
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
> connected to the main SoC over PCIe.
> 
> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
> improve routing bandwidth.
> 
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

This is great to see. I'm going to mainline all the MT7621 devicetrees 
on OpenWrt at some point, this is a good step for this.

> ---
>   arch/mips/boot/dts/ralink/Makefile            |   3 +-
>   .../dts/ralink/mt7621-tplink-hc220_g5.dts     | 126 ++++++++++++++++++
>   2 files changed, 128 insertions(+), 1 deletion(-)
>   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> 
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> index 11732b8c8163a..c57a2b40876b4 100644
> --- a/arch/mips/boot/dts/ralink/Makefile
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>   
>   dtb-$(CONFIG_SOC_MT7621) += \
>   	mt7621-gnubee-gb-pc1.dtb \
> -	mt7621-gnubee-gb-pc2.dtb
> +	mt7621-gnubee-gb-pc2.dtb \
> +	mt7621-tplink-hc220_g5.dtb
>   
>   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> new file mode 100644
> index 0000000000000..83d15711907d0
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/dts-v1/;
> +
> +#include "mt7621.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "tplink,hc220-g5", "mediatek,mt7621-soc";

tplink,hc220-g5-v1 should fit better. Also please make another patch to 
add the compatible string under Boards with Mediatek/Ralink MT7621 SoC 
on Documentation/devicetree/bindings/mips/ralink.yaml.

> +	model = "TP-Link HC220 G5 v1.0";

"TP-Link HC220 G5 v1" should be enough.

> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x8000000>;
> +	};
> +
> +	chosen {
> +		/* bootargs = "earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0 kgdboc=ttyS0,115200 ip=192.168.88.1:192.168.88.2:::hc220:eth1:none kgdbcon console=ttyS0,115200"; */
> +		/* bootargs = "console=ttyS0,115200 earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0"; */
> +		bootargs = "console=ttyS0,115200 root=/dev/nfs ip=192.168.88.2:192.168.88.5::255.255.255.0:hc220_g5:eth1:none nfsroot=192.168.88.5:/mips,vers=4,sec=sys ro rootwait";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-reset {
> +			label = "reset";
> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RESTART>;
> +		};
> +
> +		key-wps {
> +			label = "wps";
> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WPS_BUTTON>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_WPS;
> +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	resetc: reset-controller {
> +		compatible = "ralink,rt2880-reset";
> +		#reset-cells = <1>;
> +	};
> +
> +	mtd {
> +		compatible = "mediatek,mt7622-nfc";
> +	};
> +};
> +
> +&i2c {
> +	status = "okay";
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +/* gmac1 connected to MT7530's phy0 */
> +&gmac1 {
> +	status = "okay";
> +	phy-handle = <&ethphy0>;
> +};
> +
> +&mdio {
> +	/* MT7530's phy0 */
> +	ethphy0: ethernet-phy@0 {
> +		reg = <0>;
> +		phy-mode = "rgmii";
> +	};
> +};

These are partially wrong, check the mt7621.dtsi on mainline. Or better, 
don't do it. I'm very close to adding support for changing the DSA 
conduit for user ports. I suggest you just add port@0 to the DSA switch 
node below.

> +
> +&switch0 {
> +	/* #gpio-cells = <2>;
> +	gpio-controller; */
> +
> +	ports {
> +		/* phy0 is muxed to gmac1 */
> +		/delete-node/ port@0;
> +
> +		port@1 {
> +			status = "okay";
> +			label = "lan1";
> +		};
> +
> +		port@2 {
> +			status = "okay";
> +			label = "wan";
> +		};
> +	};
> +};

Arınç
