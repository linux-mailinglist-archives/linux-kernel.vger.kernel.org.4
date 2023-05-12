Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B37000B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbjELGls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjELGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:41:46 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8776DD99;
        Thu, 11 May 2023 23:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683873661; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WBJPNS1VncVLopJ6Or8tH6kpNvapG0NNdi3faRj/g/CxNA6BLibW/4MXUB71zA8lN2Mh93xYMM+gaVsF1pXWwBPm/bxQTG01BX3XOu954v3u3WVE2Er4M9VFo7jK9GjrhvfVpsROSFR3P4Ij2bigdoODTL8dgn9MV7KEgX96xaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683873661; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=D6pDZG9SgSjLKUr5mKOeAxGqVV/5/LNcopei0JAKDyI=; 
        b=oGaSbdCXOCO+iATsG2QFvqorzLcEzHuDyN6lDo7IJfZu1grsh7O9GiEREYo/eK5nQG/8S4ldzzre4ARhX0o2uZx5CqbSicz8c7gpyO/etlwv1QxZoJU8ClhgbPq0vBEf4xexNGOrBRiMjcCLaDRKvCT8M3QBZZNEKu8G5GiK5Q4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683873661;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=D6pDZG9SgSjLKUr5mKOeAxGqVV/5/LNcopei0JAKDyI=;
        b=CUX2vR/Z8nUvJHCwGKg0DaxyY40hlqgXdZI2m2NhBM5KVCs7NlAuVYGoZkeSSZF4
        ZXqYQm3x83UWfOHx21yUmi7C9IfGZyT5BtawbmpHE3PYDIi84LAyRIGZAyX6anaF/Rz
        KFi181YfXGILNFrrm7mPrjab3VNbfhCJUFHJpPaQ=
Received: from [10.1.111.147] (185.242.250.116-ip.operadors.cat [185.242.250.116]) by mx.zohomail.com
        with SMTPS id 1683873660851408.5520398170154; Thu, 11 May 2023 23:41:00 -0700 (PDT)
Message-ID: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
Date:   Fri, 12 May 2023 08:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mips: dts: ralink: Add support for TP-Link HC220 G5 v1
 board.
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230509200125.309026-1-liviu@dudau.co.uk>
 <43301707-8763-2a9f-956d-1ea0ae004a56@arinc9.com>
 <ZF0RxoLRyl78s8sf@bart.dudau.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZF0RxoLRyl78s8sf@bart.dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2023 18:03, Liviu Dudau wrote:
> On Thu, May 11, 2023 at 03:41:30PM +0200, Arınç ÜNAL wrote:
>> On 9.05.2023 22:01, Liviu Dudau wrote:
>>> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
>>> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
>>> connected to the main SoC over PCIe.
>>>
>>> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
>>> improve routing bandwidth.
>>>
>>> The device uses NMBM over NAND, which is not currently supported in the
>>> mainline, so NAND node is skipped in this revision.
>>>
>>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>>
>> This is great to see. I'm going to mainline all the MT7621 devicetrees on
>> OpenWrt at some point, this is a good step for this.
> 
> AFAIK this board is not supported by OpenWrt at all. So the flow will be
> the other way this time :)
> 
>>
>>> ---
>>>    arch/mips/boot/dts/ralink/Makefile            |   3 +-
>>>    .../dts/ralink/mt7621-tplink-hc220_g5.dts     | 126 ++++++++++++++++++
>>>    2 files changed, 128 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
>>>
>>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>>> index 11732b8c8163a..c57a2b40876b4 100644
>>> --- a/arch/mips/boot/dts/ralink/Makefile
>>> +++ b/arch/mips/boot/dts/ralink/Makefile
>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>>>    dtb-$(CONFIG_SOC_MT7621) += \
>>>    	mt7621-gnubee-gb-pc1.dtb \
>>> -	mt7621-gnubee-gb-pc2.dtb
>>> +	mt7621-gnubee-gb-pc2.dtb \
>>> +	mt7621-tplink-hc220_g5.dtb
>>>    obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
>>> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
>>> new file mode 100644
>>> index 0000000000000..83d15711907d0
>>> --- /dev/null
>>> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
>>> @@ -0,0 +1,126 @@
>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +/dts-v1/;
>>> +
>>> +#include "mt7621.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +
>>> +/ {
>>> +	compatible = "tplink,hc220-g5", "mediatek,mt7621-soc";
>>
>> tplink,hc220-g5-v1 should fit better. Also please make another patch to add
>> the compatible string under Boards with Mediatek/Ralink MT7621 SoC on
>> Documentation/devicetree/bindings/mips/ralink.yaml.
> 
> Will do another patch with the documentation update. I will also send a v2
> incorporating all your review comments, thanks for taking the time!
> 
> Regarding the full name: I'm quite tempted to drop the v1(.0) entirely as I'm
> not really sure that TP-Link will release another board. Doing a search now
> I fail to find on any TP-Link results the mention of the version.

What I understand is TP-Link always call their first hardware release v1 
as they are notorious for introducing new versions to cut costs as much 
as possible. On the downloads website for the product, "v1" is there on 
the product name.

https://www.tp-link.com/us/support/download/hc220-g5/

> 
>>
>>> +	model = "TP-Link HC220 G5 v1.0";
>>
>> "TP-Link HC220 G5 v1" should be enough.
>>
>>> +
>>> +	memory@0 {
>>> +		device_type = "memory";
>>> +		reg = <0x0 0x0 0x0 0x8000000>;
>>> +	};
>>> +
>>> +	chosen {
>>> +		/* bootargs = "earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0 kgdboc=ttyS0,115200 ip=192.168.88.1:192.168.88.2:::hc220:eth1:none kgdbcon console=ttyS0,115200"; */
>>> +		/* bootargs = "console=ttyS0,115200 earlycon=uart8260,mmio32,0x1e000c00 root=/dev/ram0"; */
>>> +		bootargs = "console=ttyS0,115200 root=/dev/nfs ip=192.168.88.2:192.168.88.5::255.255.255.0:hc220_g5:eth1:none nfsroot=192.168.88.5:/mips,vers=4,sec=sys ro rootwait";
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +
>>> +		key-reset {
>>> +			label = "reset";
>>> +			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_RESTART>;
>>> +		};
>>> +
>>> +		key-wps {
>>> +			label = "wps";
>>> +			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_WPS_BUTTON>;
>>> +		};
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		red {
>>> +			color = <LED_COLOR_ID_RED>;
>>> +			function = LED_FUNCTION_FAULT;
>>> +			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +
>>> +		green {
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			function = LED_FUNCTION_POWER;
>>> +			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "default-on";
>>> +		};
>>> +
>>> +		blue {
>>> +			color = <LED_COLOR_ID_BLUE>;
>>> +			function = LED_FUNCTION_WPS;
>>> +			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +	};
>>> +
>>> +	resetc: reset-controller {
>>> +		compatible = "ralink,rt2880-reset";
>>> +		#reset-cells = <1>;
>>> +	};
>>> +
>>> +	mtd {
>>> +		compatible = "mediatek,mt7622-nfc";
>>> +	};
>>> +};
>>> +
>>> +&i2c {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pcie {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&spi0 {
>>> +	status = "okay";
>>> +
>>> +	flash@0 {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +		spi-max-frequency = <50000000>;
>>> +	};
>>> +};
>>> +
>>> +/* gmac1 connected to MT7530's phy0 */
>>> +&gmac1 {
>>> +	status = "okay";
>>> +	phy-handle = <&ethphy0>;
>>> +};
>>> +
>>> +&mdio {
>>> +	/* MT7530's phy0 */
>>> +	ethphy0: ethernet-phy@0 {
>>> +		reg = <0>;
>>> +		phy-mode = "rgmii";
>>> +	};
>>> +};
>>
>> These are partially wrong, check the mt7621.dtsi on mainline. Or better,
>> don't do it. I'm very close to adding support for changing the DSA conduit
>> for user ports. I suggest you just add port@0 to the DSA switch node below.
>>
> 
> I don't claim to be an expert on DSA or how MT7530 connects to MT7621, however
> I do remember trying various combinations and failing to make all the ports
> work. I blame TP-Link on having a weird setup, but to be sure I will try your
> suggestion if I manage to understand exactly where I'm "partially wrong" :)

You're not wrong, the bindings are. You must disable fixed-link. The 
properties status okay and phy-mode rgmii on ethphy0 is not necessary so 
these can be dropped. Take a look at the GB-PC2 bindings, rgmii-rxid is 
specific to GB-PC2 so no need to do that:

https://github.com/torvalds/linux/blob/master/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts#L114

If you define the port under the DSA switch node, it should just work.

Arınç
