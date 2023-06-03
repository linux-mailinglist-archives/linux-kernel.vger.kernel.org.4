Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F3720FFD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFCMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFCMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:06:27 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28726CE;
        Sat,  3 Jun 2023 05:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685793973; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dPp8+RIHW3Y0LWp9Lg1UfbigkqIq6GFIvQTZ1F3j30CtwhCzevw4P70IgCkQ+cSHs86Rir3wAYuLv2AJeT3O3ArMfWWhiF+g4vRjezAoj5yN/1qI9iuzDk2mznXuTQZB4lLajOQ6dRJxlD6rUwwZdksqWv1tEstcD9MvtbzENGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685793973; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qZ+DRMrEQSMFmYN6TOQ1EMiUZqQZdc1StxPgV97rvEI=; 
        b=R1AxWdWnhecGuIJDCennf6pM8qbp7vctQuTgRTNdRf6xQ28rWnwZ45vj3zVa2JfRPSF3Oe/qSy8JtCnKS75YKI4JWsqpD8TUeC73m8dalo5kc+NX0kHCvKX9588FQsaSmrdXgJ3Njp0R42T81q23qFxV7mI0StQtG81rnwbZK8s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685793973;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qZ+DRMrEQSMFmYN6TOQ1EMiUZqQZdc1StxPgV97rvEI=;
        b=M4TUDHQ/5V4ny6KYmxJPjQ+Aje1hytUzVNcOLQNJu/eKfCoeuatCDOP9Od2O6KbF
        /10KxBPDXNbFKRaZLayWJ26OiD07m/6EMGPOqh4oBIR1scjVWgFVPrTl99mU71Civ41
        nBAbrdybyNEZF+aArUHkklCD2SMnG51xTHCANYNQ=
Received: from [192.168.83.218] (62.74.57.39 [62.74.57.39]) by mx.zohomail.com
        with SMTPS id 1685793972225528.2250753986209; Sat, 3 Jun 2023 05:06:12 -0700 (PDT)
Message-ID: <cc70b28c-7bbe-0766-4a43-c0d7584e108a@arinc9.com>
Date:   Sat, 3 Jun 2023 15:06:08 +0300
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

Do you mean MT7662 5GHz WiFi?

>> connected to the main SoC over PCIe.
>>
>> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
>> improve routing bandwidth.

This is not always true, I'd prefer you remove this sentence from the 
patch log.

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

What's going on here? Just do 'reg = <0x00000000 0x08000000>;'.

>> +	};
>> +
>> +	chosen {
>> +		/* add 'earlycon=uart8260,mmio32,0x1e000c00' to

8260?

>> +		 * bootargs for early boot messages

Isn't just adding "earlycon" to bootargs enough?

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

We don't use this anymore.

>> +
>> +	mtd {
>> +		compatible = "mediatek,mt7622-nfc";
>> +	};

What's this got to do with this device?

>> +};
>> +
>> +&i2c {
>> +	status = "okay";
>> +};

Why does this device need i2c?

>> +
>> +&pcie {
>> +	status = "okay";
>> +};

Do both WiFi chips work by just enabling pcie? I was expecting 
'compatible = "mediatek,mt76";' on pcie@0,0 and pcie@1,0.

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

I thought you said this device had NAND flash, not NOR.

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

Remove the two nodes above.

>> +
>> +&switch0 {
>> +	ports {
>> +		/* phy0 is muxed to gmac1 */
>> +		port@0 {
>> +			status = "okay";
>> +			label = "lan2";
>> +		};
> 
> I've made the changes to look similar to the gnubee-gb-pc2, and things mostly
> work, with the exception that I can mount an NFS root filesystem only on "lan2"
> interface at boot time. All other interfaces (ports) hang forever waiting for
> an DHCP response from my server. The only difference is where I plug in the
> ethernet cable, no other change (not even a restart) on the server.

This sounds like a userspace configuration issue.

Arınç
