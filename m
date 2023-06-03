Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A4721005
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjFCMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFCMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:11:04 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104CCE;
        Sat,  3 Jun 2023 05:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685794255; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Q4vgihNxWamUIp6hhm1CPF4OmZKseP4OOpxwYILmFHh6KeWvIfSg3iEl7HbydsLdYbdeO4Rwr61VWthX6J2HJ9OAPVur74Y+R7iUlEa4CX4I6EqkR2BFrxvyDg85tWEAwv39slPGLrR4TsCIrHUGP1LvfvnBG3X66XTRsQB7u2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685794255; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sspiJ2UNJF/OQjMABt9qvOk84h7ByX3vdD0+pnSanSM=; 
        b=blC2P+7qFk5sIiteVQPi/C9/eLCHL1XLsCHIRZWLYOU5lZdp9N17YS4DZDhTEdUJ5hBxJuAhhnTZORg1PQGMOzrswbXf4eHX9E1CXOn2mqqnJQjy3Kpma+Ax2Py5me1R6uFZMrtQ7BNZwo0bN3vyL3wE0ekvCBYxsSrwFOo1ym8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685794255;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=sspiJ2UNJF/OQjMABt9qvOk84h7ByX3vdD0+pnSanSM=;
        b=LXsNNFMVwEzXm4TlB93GED6M+RVG6zyX6FU1AkI8bwD9slLcsMbJI3s5fHt9/aLs
        rMMW7dJmnkfPueUOkc8W/b0nyn4hvgkuRqaHztEAwXC6joiP1aUq0oUzTHUg9aAUlCw
        DpN1vBGwtzHeGx0AzMWVh83QyRzHALg1mTxWjAcw=
Received: from [192.168.83.218] (62.74.57.39 [62.74.57.39]) by mx.zohomail.com
        with SMTPS id 1685794253072363.46218317190653; Sat, 3 Jun 2023 05:10:53 -0700 (PDT)
Message-ID: <18b72d1d-7e9a-7c99-9f0e-ca20349eff82@arinc9.com>
Date:   Sat, 3 Jun 2023 15:10:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Content-Language: en-US
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-2-liviu@dudau.co.uk>
 <ZHTK+qG0xBWfn9gt@bart.dudau.co.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZHTK+qG0xBWfn9gt@bart.dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.2023 18:55, Liviu Dudau wrote:
> On Mon, May 29, 2023 at 04:08:32PM +0100, Liviu Dudau wrote:
>> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
>> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
>> connected to the main SoC over PCIe.
>>
>> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
>> improve routing bandwidth.
>>
>> The device uses NMBM over NAND, which is not currently supported in the
>> mainline, so NAND node is skipped in this revision.
>>
>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>> ---
>>   arch/mips/boot/dts/ralink/Makefile            |   3 +-
>>   .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 129 ++++++++++++++++++
>>   2 files changed, 131 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>>
>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>> index 11732b8c8163a..d27d7e8c700fe 100644
>> --- a/arch/mips/boot/dts/ralink/Makefile
>> +++ b/arch/mips/boot/dts/ralink/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>>   
>>   dtb-$(CONFIG_SOC_MT7621) += \
>>   	mt7621-gnubee-gb-pc1.dtb \
>> -	mt7621-gnubee-gb-pc2.dtb
>> +	mt7621-gnubee-gb-pc2.dtb \
>> +	mt7621-tplink-hc220-g5-v1.dtb
>>   
>>   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
>> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>> new file mode 100644
>> index 0000000000000..f003ae615a58e
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/dts-v1/;
>> +
>> +#include "mt7621.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
>> +	model = "TP-Link HC220 G5 v1";
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x8000000>;
>> +	};
>> +
>> +	chosen {
>> +		/* add 'earlycon=uart8260,mmio32,0x1e000c00' to
>> +		 * bootargs for early boot messages
>> +		 */
>> +		bootargs = "console=ttyS0,115200";
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		key-reset {
>> +			label = "reset";
>> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_RESTART>;
>> +		};
>> +
>> +		key-wps {
>> +			label = "wps";
>> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		red {
>> +			color = <LED_COLOR_ID_RED>;
>> +			function = LED_FUNCTION_FAULT;
>> +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		green {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_POWER;
>> +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "default-on";
>> +		};
>> +
>> +		blue {
>> +			color = <LED_COLOR_ID_BLUE>;
>> +			function = LED_FUNCTION_WPS;
>> +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>> +	resetc: reset-controller {
>> +		compatible = "ralink,rt2880-reset";
>> +		#reset-cells = <1>;
>> +	};
>> +
>> +	mtd {
>> +		compatible = "mediatek,mt7622-nfc";
>> +	};
>> +};
>> +
>> +&i2c {
>> +	status = "okay";
>> +};
>> +
>> +&pcie {
>> +	status = "okay";
>> +};
>> +
>> +&spi0 {
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <50000000>;
>> +	};
>> +};
>> +
>> +/* gmac1 connected to MT7530's phy0 */
>> +&gmac1 {
>> +	phy-handle = <&ethphy0>;
>> +
>> +	fixed-link {
>> +		status = "disabled";
>> +	};
>> +};
>> +
>> +&mdio {
>> +	/* MT7530's phy0 */
>> +	ethphy0: ethernet-phy@0 {
>> +		reg = <0>;
>> +	};
>> +};
>> +
>> +&switch0 {
>> +	ports {
>> +		/* phy0 is muxed to gmac1 */

I already suggested not doing this, please remove this line.

Arınç
