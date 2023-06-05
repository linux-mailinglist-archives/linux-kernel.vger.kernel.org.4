Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CE722CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjFEQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjFEQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:36:38 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C33112D;
        Mon,  5 Jun 2023 09:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685982952; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=i4Fx3bzsyv8ax+NVVQyJ7YKa76olcwNPbIMlzoRspg3LItGA18Abl37So+PhSaWEvmch4ihthQzse3HfVjeZg03Dj6LNMDoCLl/b9nuClIGmz573bYlRQK1jS4aUzMYpr561L+0RHyjceiFYZzATSclj0DCg5H+5+nuYtc/1Ajw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685982952; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vhpDe4ORzyxrvEQ9PSOVh6poH3wwmuSbaPGgG+VkgPM=; 
        b=K1+ATVVTR+pE56O+QrT92LqYB70TOGu0fB2XO/PKXC8aklSwY+mL/BBO3JWDuDHT68ydZ1rpFe8JyS8ZARVEHqgjlzZpPkJeA6iOPc3QS+6/aOUjFvVxgBsliaeBbrpi77ZFVjdrIbWtBNufFQuF7bXNUdbpl98dOv1xAlraq1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685982952;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vhpDe4ORzyxrvEQ9PSOVh6poH3wwmuSbaPGgG+VkgPM=;
        b=YX/oOvcipRQroJVE7GFGrMcytsWjjn38+dCiLe+HotMsfT97LpkzlLgXSAbpCeew
        CpiM1oj9K8sHtxCKNCk6JtDnyxGgVvQ7he6y/Iv+6t8cYn6oiwbvooFmxSDxVADiaUb
        NaI2AUK4eST+empV9qPfrscE0loVUjaSvzrVvZm4=
Received: from [192.168.83.218] (62.74.57.47 [62.74.57.47]) by mx.zohomail.com
        with SMTPS id 1685982949903244.21922042909762; Mon, 5 Jun 2023 09:35:49 -0700 (PDT)
Message-ID: <552b4604-d1b3-0052-62aa-424944c5ecb1@arinc9.com>
Date:   Mon, 5 Jun 2023 19:35:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH v3 1/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
To:     Liviu Dudau <liviu@dudau.co.uk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230605150114.601102-1-liviu@dudau.co.uk>
 <20230605150114.601102-2-liviu@dudau.co.uk>
Content-Language: en-US
In-Reply-To: <20230605150114.601102-2-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.06.2023 18:01, Liviu Dudau wrote:
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
> connected to the main SoC over PCIe.
> 
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>   arch/mips/boot/dts/ralink/Makefile            |  3 +-
>   .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 92 +++++++++++++++++++
>   2 files changed, 94 insertions(+), 1 deletion(-)
>   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> 
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> index 11732b8c8163a..d27d7e8c700fe 100644
> --- a/arch/mips/boot/dts/ralink/Makefile
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>   
>   dtb-$(CONFIG_SOC_MT7621) += \
>   	mt7621-gnubee-gb-pc1.dtb \
> -	mt7621-gnubee-gb-pc2.dtb
> +	mt7621-gnubee-gb-pc2.dtb \
> +	mt7621-tplink-hc220-g5-v1.dtb
>   
>   obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> new file mode 100644
> index 0000000000000..859aaa1c1bc2b
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> @@ -0,0 +1,92 @@
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
> +	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
> +	model = "TP-Link HC220 G5 v1";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>;

Please use 8 digit addressing for the memory start and size offsets:

0x00000000 0x08000000

> +	};
> +
> +	chosen {
> +		bootargs = "earlycon console=ttyS0,115200";
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

Usually the led name would point to the component the LED is used for.

> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;

Is there a specific reason you're using leds/common.h,
color & function instead of 'label = "red:ledname"'?

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

Every led node needs the "led-" prefix to satisfy the leds-gpio.yaml
schema. You can check for dt-schema warnings using this command:

ARCH=mips make clean dtbs_check

Ignore the warning for mediatek,mt7621-eth.

> +	};
> +};
> +
> +&pcie {
> +	status = "okay";
> +
> +	pcie@0,0 {
> +		compatible = "mediatek,mt76";
> +	};
> +
> +	pcie@1,0 {
> +		compatible = "mediatek,mt76";
> +	};

Both radios work with this then?

Also, I see a bunch of warnings now that the mediatek,mt76 compatible
string is added. The warning from schemas/pci/pci-bus.yaml is concerning.

/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0:compatible: ['mediatek,mt76'] does not contain items matching the given schema
	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'reset-gpios' were unexpected)
	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@1e140000: pcie@0,0:compatible: ['mediatek,mt76'] does not contain items matching the given schema
	From schema: /usr/lib/python3/dist-packages/dtschema/schemas/pci/pci-bus.yaml
/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@0,0: clocks: [[2, 23]] is too short
	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
/mnt/Documents/for-netnext/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: pcie@0,0: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'clocks', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'phy-names', 'phys', 'ranges' were unexpected)
	From schema: /mnt/Documents/for-netnext/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml

Rob, Krzysztof any ideas what to do? The PCI child node is supposed to
be the properties of the wireless device. But the compatible string
doesn't match the schema on schemas/pci/pci-bus.yaml.

       compatible:
         contains:
           pattern: "^(pci[0-9a-f]{3,4},[0-9a-f]{1,4}|pciclass,[0-9a-f]{4,6})$"

Liviu, in the meantime, you should submit this patch without this
compatible string. I will handle this issue.

Arınç
