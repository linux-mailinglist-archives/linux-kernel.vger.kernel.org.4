Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E960FF90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiJ0Rxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0Rxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:53:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC3170451;
        Thu, 27 Oct 2022 10:53:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so6815387ejc.7;
        Thu, 27 Oct 2022 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te6fDSLj/TBuvVXZMqUMxKDlKF/5a5kAYU4EMoUuQxc=;
        b=U/nPCjlVL2xeGbSWNYKEN0FEUD4Pc14/Z17r9bOZI9CenYfpYSry8RO1hQOmSuZQQg
         hTCI6ZGh2dXkMFwzb/Ub9WccR0s8h2n19u8+0EkyBt9CsgajeDOnNe1u9AzKl/Qz2R/Y
         XN+i3aDLKg/jKLNFltXuUWdbLD3BOmK+1gRAJat7+XsxDmoBcSb2nU3GTrJ4gRoMO152
         Z0TvMPEs7FELcUrP5TXnYIxw9eKpAaomy3OkfxwIey5P82d31EJtyS4D1TS4biQLWr9M
         ilL6zhM9Wcc0zxztTxXEPdw3h1QvSW98aL+iLY6aIG9n5c0aPkHCIeiNuq4aGyjTHvlJ
         sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te6fDSLj/TBuvVXZMqUMxKDlKF/5a5kAYU4EMoUuQxc=;
        b=ofRm6UITswwHFkFuku8GXSJ3Vw0tnAJiYLVviATWFkIENlcPPIQLXnc7c3gTnv3SmV
         Y/gj6y941ykMDqPsriWUURsv0AF73CSAgCQ56MHscP8DRz+thwK0ERk8Jliv56rl93gP
         gxQwD4IDSquedwB5eaXqnZ4e0aGbgcBXDBXI/kRBZAwprTLXBWPpZ0waAQt7VWcr9N4A
         9Uonvs5ieTU6n5SCJ791d0KO45HPDX/b9xhrQKTTjHOxD5BrV3P8le1kuEKO+LVIkmK0
         OjZ0ybvbKHWNElEbrfoEr/jzW9+XTZTQjeAZH+wVSoAG5T+yEMkA+tQHsLbW65dgDpQ9
         9tqA==
X-Gm-Message-State: ACrzQf1RRQwSj93vjctxWbp0ggU50FbSjXJggaELzc70UNrvoECU1IQK
        D6GTal5kIcEuhT6ub08qdFU=
X-Google-Smtp-Source: AMsMyM4FqBH+p8YuqMG/vutEJ71E3+yKsmXow2Thqk422xq8Z76kd7ciUNtkVMJCAexUoSRsQ/WeQA==
X-Received: by 2002:a17:907:97d5:b0:7ac:5f72:6c1a with SMTP id js21-20020a17090797d500b007ac5f726c1amr13606352ejc.126.1666893205055;
        Thu, 27 Oct 2022 10:53:25 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p10-20020a056402500a00b004615e1bbaf4sm1322908eda.87.2022.10.27.10.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 10:53:24 -0700 (PDT)
Message-ID: <2dc46681-894d-4521-bfa7-3e9209691e0a@gmail.com>
Date:   Thu, 27 Oct 2022 19:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 3/4] ARM: dts: rockchip: add rk3128.dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kever.yang@rock-chips.com, heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
 <674b875a-0dfa-eff2-5018-eafed851707f@gmail.com>
 <f45a4dcb-12e6-9a72-dbb3-7ec198ff2b1d@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <f45a4dcb-12e6-9a72-dbb3-7ec198ff2b1d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Kever, Heiko and others,

On 10/27/22 16:58, Krzysztof Kozlowski wrote:
> On 26/10/2022 20:53, Johan Jonker wrote:
>> Add basic rk3128 support.
>>
> 
> Thank you for your patch. There is something to discuss/improve.

Thank you for your review.

Some more questions/comments below.

> 
>> +#include <dt-bindings/clock/rk3128-cru.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +
>> +/ {
>> +	compatible = "rockchip,rk3128";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	aliases {
>> +		gpio0 = &gpio0;
>> +		gpio1 = &gpio1;
>> +		gpio2 = &gpio2;
>> +		gpio3 = &gpio3;

Is gpio OK here?

>> +		i2c0 = &i2c0;
>> +		i2c1 = &i2c1;
>> +		i2c2 = &i2c2;
>> +		i2c3 = &i2c3;
>> +		spi0 = &spi0;
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
> 
> Bus aliases are board specific and represent what is actually available
> on headers/pins etc. These do not belong to SoC DTSI.

I just follow current Rockchip DT common practice.

Do we need to change all Rockchip boards?
Would like to hear from Heiko what's the plan here?
Syncing to U-boot is already a mess...

So far only instructions/changes and discussion about mmc nodes.

Can Rockchip specific rules be publicized in a central place? 

===
mmc aliases on reg order, availability and without number gap.
===

Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

===
My incomplete list:

For nodes:
If exists on top: model, compatible and chosen.
Sort things without reg alphabetical first,
then sort the rest by reg address.

Inside nodes:
If exists on top: compatible, reg and interrupts.
In alphabetical order the required properties.
Then in alphabetical order the other properties.
And as last things that start with '#' in alphabetical order.
Add status below all other properties for soc internal components with
any board-specifics.
Keep an empty line between properties and nodes.

Exceptions:
Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
and dma-names.
Sort simple-audio-card,name above other simple-audio-card properties.
Sort regulator-name above other regulator properties.
Sort regulator-min-microvolt above regulator-max-microvolt.

> 
>> +	};
>> +
>> +	arm-pmu {
>> +		compatible = "arm,cortex-a7-pmu";
>> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@f00 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0xf00>;
>> +			clock-latency = <40000>;
>> +			clocks = <&cru ARMCLK>;

>> +			operating-points = <
>> +				/* KHz    uV */
>> +				 816000 1000000
>> +			>;
> 
> Why not operating-points-v2?

rk3128 doesn't have a tsadc.
As long as this thermal stuff is not implemented with drivers and regulators I would prefer to keep it basic in the DT for now.
Just keep things simple for now till someone with hardware can fix that.

https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm/boot/dts/rk312x.dtsi#L315

	tsadc: tsadc {
		compatible = "rockchip,rk3126-tsadc-virtual";
		nvmem-cells = <&cpu_leakage>;
		nvmem-cell-names = "cpu_leakage";
		#thermal-sensor-cells = <1>;
		status = "disabled";
	};
> 
>> +			#cooling-cells = <2>; /* min followed by max */
>> +		};
>> +
>> +		cpu1: cpu@f01 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0xf01>;
>> +		};
>> +
>> +		cpu2: cpu@f02 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0xf02>;
>> +		};
>> +
>> +		cpu3: cpu@f03 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0xf03>;
>> +		};
>> +	};
>> +
>> +	timer {

>> +		compatible = "arm,armv7-timer";

Original 2 interrupts:

>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;

Could someone help here with the correct interrupts properties?

This was later changed to 4 interrupts:

		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
See:
arm: dts: enable arm arch virtual timer for rk312x
https://github.com/rockchip-linux/kernel/commit/405105146fd8a25ef3c9c46d18895ad243a6db2d

===

How to calculate the number?
Please advise? Thanks!

From rk3128 TRM show only 3 interrupts: ????
PPI
27 VIRTUAL TIMER High level
29 SECURE PHYSICAL TIMER High level
30 NON-SECURE PHY TIMER High level

>> +		arm,cpu-registers-not-fw-configured;
>> +		clock-frequency = <24000000>;
>> +	};
>> +
>> +	xin24m: oscillator {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "xin24m";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	pmu: syscon@100a0000 {
>> +		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
>> +		reg = <0x100a0000 0x1000>;
>> +	};
>> +
>> +	gic: interrupt-controller@10139000 {
>> +		compatible = "arm,cortex-a7-gic";
>> +		reg = <0x10139000 0x1000>,
>> +		      <0x1013a000 0x1000>,
>> +		      <0x1013c000 0x2000>,
>> +		      <0x1013e000 0x2000>;
>> +		interrupts = <GIC_PPI 9 0xf04>;

How can this number be 9 if the lowest PPI IRQ ID is:

27 VIRTUAL TIMER High level

Can someone help here? Thanks!

> 

> f04 looks like a mask, so use standard defines for it.

OK
Will check which defines ends up with 0xf04. 
interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>; ??

> 
>> +		interrupt-controller;
>> +		#interrupt-cells = <3>;
>> +		#address-cells = <0>;
>> +	};
>> +
>> +	usb_otg: usb@10180000 {
>> +		compatible = "rockchip,rk3128-usb", "rockchip,rk3066-usb", "snps,dwc2";
>> +		reg = <0x10180000 0x40000>;
>> +		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_OTG>;
>> +		clock-names = "otg";
>> +		dr_mode = "otg";
>> +		phys = <&usb2phy_otg>;
>> +		phy-names = "usb2-phy";
>> +		status = "disabled";
>> +	};
>> +
>> +	usb_host_ehci: usb@101c0000 {
>> +		compatible = "generic-ehci";
>> +		reg = <0x101c0000 0x20000>;
>> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +		phys = <&usb2phy_host>;
>> +		phy-names = "usb";
>> +		status = "disabled";
>> +	};
>> +
>> +	usb_host_ohci: usb@101e0000 {
>> +		compatible = "generic-ohci";
>> +		reg = <0x101e0000 0x20000>;
>> +		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +		phys = <&usb2phy_host>;
>> +		phy-names = "usb";
>> +		status = "disabled";
>> +	};
>> +
>> +	sdmmc: mmc@10214000 {
>> +		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
>> +		reg = <0x10214000 0x4000>;
>> +		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>> +			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> +		dmas = <&pdma 10>;
>> +		dma-names = "rx-tx";
>> +		fifo-depth = <256>;
>> +		max-frequency = <150000000>;
>> +		resets = <&cru SRST_SDMMC>;
>> +		reset-names = "reset";
>> +		status = "disabled";
>> +	};
>> +
>> +	sdio: mmc@10218000 {
>> +		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
>> +		reg = <0x10218000 0x4000>;
>> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>> +			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> +		dmas = <&pdma 11>;
>> +		dma-names = "rx-tx";
>> +		fifo-depth = <256>;
>> +		max-frequency = <150000000>;
>> +		resets = <&cru SRST_SDIO>;
>> +		reset-names = "reset";
>> +		status = "disabled";
>> +	};
>> +
>> +	emmc: mmc@1021c000 {
>> +		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
>> +		reg = <0x1021c000 0x4000>;
>> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>> +			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>> +		dmas = <&pdma 12>;
>> +		dma-names = "rx-tx";
>> +		fifo-depth = <256>;
>> +		max-frequency = <150000000>;
>> +		resets = <&cru SRST_EMMC>;
>> +		reset-names = "reset";
>> +		status = "disabled";
>> +	};
>> +
>> +	nfc: nand-controller@10500000 {
>> +		compatible = "rockchip,rk3128-nfc", "rockchip,rk2928-nfc";
>> +		reg = <0x10500000 0x4000>;
>> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
>> +		clock-names = "ahb", "nfc";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_cs0
>> +			     &flash_dqs &flash_rdn &flash_rdy &flash_wrn>;
>> +		status = "disabled";
>> +	};
>> +
>> +	cru: clock-controller@20000000 {
>> +		compatible = "rockchip,rk3128-cru";
>> +		reg = <0x20000000 0x1000>;
>> +		clocks = <&xin24m>;
>> +		clock-names = "xin24m";
>> +		rockchip,grf = <&grf>;
>> +		#clock-cells = <1>;
>> +		#reset-cells = <1>;
>> +		assigned-clocks = <&cru PLL_GPLL>;
>> +		assigned-clock-rates = <594000000>;
>> +	};
>> +
>> +	grf: syscon@20008000 {
>> +		compatible = "rockchip,rk3128-grf", "syscon", "simple-mfd";
>> +		reg = <0x20008000 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		usb2phy: usb2phy@17c {
> 

> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

You are absolutely correct. Except for Rockchip usb2phy nodes ....
#phy-cells is located in a sub node, so we keep as it is... ;)

dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml 
https://lore.kernel.org/all/20210601164800.7670-2-jbx6244@gmail.com/

> 
>> +			compatible = "rockchip,rk3128-usb2phy";
>> +			reg = <0x017c 0x0c>;
>> +			clocks = <&cru SCLK_OTGPHY0>;
>> +			clock-names = "phyclk";
>> +			clock-output-names = "usb480m_phy";
>> +			#clock-cells = <0>;
>> +			status = "disabled";
>> +
> 
> 
> Best regards,
> Krzysztof
> 

Kind regards,

Johan Jonker
