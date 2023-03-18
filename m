Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CCC6BF844
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 07:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCRGHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCRGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:07:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1930B0A;
        Fri, 17 Mar 2023 23:07:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so7462616plb.3;
        Fri, 17 Mar 2023 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679119665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OSciM2x0+oGmVdQlvuC0U3qKjDi3cY9emvJC0OLmMU=;
        b=HUJT+JUxL7hPnr380yrvXXitKd0FupDusqtJ7XLUmcmeIxJUz84ZGftGijXq2DoOBe
         soD37gv+K2D4a+cIznZYJXf6UT2ZFEVA9K/4IOezNLgrg4nc9Bvmu9nwKzEmacIGrhLp
         +xDIjrI4X+cBAQ8qRYWU/DHj/VIOk3b5Ip7yg2qjNmdR89tnFMMKRvOFU8VPgRQYuCD4
         HW33Tas4Qb8KlMeN22pcEFOZIqEAwpMn+VioryYmNZJA0wF/sZv8nzUxY8LPE5e1etaI
         X+410n8M+Mhad7tp30peKCGPcdZnMjg9pwjKVwAiUVF+Kd+p6Q5zIuEPPy33g34jFT/d
         Oa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OSciM2x0+oGmVdQlvuC0U3qKjDi3cY9emvJC0OLmMU=;
        b=WLKyoUdLYRyWP+4R2s+TyUCWP3xCzPtg4L4UFoZzTR71aJiNA4INuvf5NFE7UCHasX
         fGNcv7qI0PXROs8PPSaIOnLx/SwH2hsthRmmsK/NmGTs/0Cfw4YjGepCY/n5EPOLUwMB
         NlL8MJ9lvvsn3prVIgeTbgwVmP1xTo0/4/mKHmPQWN5TmvMv5RV16iF1cB+cgVxyo/f8
         X7eUWLQOmo8rWCuEFTBc/XTrCb/NxKYeKJL0NPx/UA2Z/sMZ0fsfkTnABmEzeWheItUI
         hmyzXFVL7v3embGgHf/t3tz1fuJmIH6UvNMliChUVe/O1N09v4KEFTFOjz0h9/78I2b/
         P5cw==
X-Gm-Message-State: AO0yUKUaixPhKPLu8rARurFyKmxaeZVX2qe9utx13sNwtqG9Jkx/GnuA
        yJ5e4xHqix9EIzO4yeMOBbU=
X-Google-Smtp-Source: AK7set93kf5NiNy1CPG3znsB8tTN2iUuq7zIgS+nK8Er8UGMS8t75Yk4fDXt42CEHuCuL6ul03bwAA==
X-Received: by 2002:a05:6a20:8e06:b0:d6:8c70:85ce with SMTP id y6-20020a056a208e0600b000d68c7085cemr11714588pzj.54.1679119664657;
        Fri, 17 Mar 2023 23:07:44 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b0056283e2bdbdsm2447380pfn.138.2023.03.17.23.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 23:07:44 -0700 (PDT)
Message-ID: <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
Date:   Sat, 18 Mar 2023 14:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


Thanks for your review.


On 2023/3/16 下午 03:45, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add initial device tree support for Nuvoton ma35d1 SoC, including
>> cpu, clock, reset, and serial controllers.
>> Add reference boards som-256m and iot-512m.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
>>   .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  24 ++
>>   .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  23 ++
>>   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 272 ++++++++++++++++++
>>   4 files changed, 321 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>>   create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>> index a99dab90472a..c11ab4eac9c7 100644
>> --- a/arch/arm64/boot/dts/nuvoton/Makefile
>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>> @@ -1,2 +1,4 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_NPCM) += nuvoton-npcm845-evb.dtb
>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-iot-512m.dtb
>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-som-256m.dtb
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>> new file mode 100644
>> index 000000000000..dffcaef1e6d8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Shan-Chun Hung <schung@nuvoton.com>
>> + *         Jacky huang <ychuang3@nuvoton.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include "ma35d1.dtsi"
>> +
>> +/ {
>> +	model = "Nuvoton MA35D1-IoT";
>> +	compatible = "nuvoton,ma35d1-iot", "nuvoton,ma35d1";
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	mem: memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
>> +	};
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>> new file mode 100644
>> index 000000000000..3e6c3d5469ac
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Shan-Chun Hung <schung@nuvoton.com>
>> + *         Jacky huang <ychuang3@nuvoton.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include "ma35d1.dtsi"
>> +
>> +/ {
>> +	model = "Nuvoton MA35D1-SOM";
>> +	compatible = "nuvoton,ma35d1-som", "nuvoton,ma35d1";
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	mem: memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x80000000 0 0x10000000>; /* 256M DRAM */
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> new file mode 100644
>> index 000000000000..8c855f6b330a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -0,0 +1,272 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>> + * Author: Shan-Chun Hung <schung@nuvoton.com>
>> + *         Jacky huang <ychuang3@nuvoton.com>
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +#include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +/ {
>> +	compatible = "nuvoton,ma35d1";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
>> +		serial3 = &uart3;
>> +		serial4 = &uart4;
>> +		serial5 = &uart5;
>> +		serial6 = &uart6;
>> +		serial7 = &uart7;
>> +		serial8 = &uart8;
>> +		serial9 = &uart9;
>> +		serial10 = &uart10;
>> +		serial11 = &uart11;
>> +		serial12 = &uart12;
>> +		serial13 = &uart13;
>> +		serial14 = &uart14;
>> +		serial15 = &uart15;
>> +		serial16 = &uart16;
> Aliases of interfaces coming out of SoC are properties of boards, not
> SoC DTSI.


OK, I will remove it from dtsi, and add to dts if required.


>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>
> Blank line.
>
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a35";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
> Between every node as well.


OK, I will fix them.


>> +		cpu1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a35";
>> +			reg = <0x0 0x1>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +		L2_0: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	clk_hxt: clock_hxt {
> No underscores in node names.


I will rewrite as:

clk_hxt: clock-hxt {


>
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "clk_hxt";
> This looks like a property of boards, not SoC. Are you sure the clock
> physically is in every SoC? If so, why it is not part of clock
> controller? (before you start explaining what is this, have in mind that
> I am pretty sure I know what is this, so rather answer the questions)


Yes, it's external to SoC and should be board specific.

I will move this to board dts.


>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
>> +			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Secure */
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
>> +			      IRQ_TYPE_LEVEL_LOW)>, /* Physical Non-Secure */
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
>> +			      IRQ_TYPE_LEVEL_LOW)>, /* Virtual */
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
>> +			      IRQ_TYPE_LEVEL_LOW)>; /* Hypervisor */
>> +		clock-frequency = <12000000>;
>> +		interrupt-parent = <&gic>;
>> +	};
>> +
>> +	sys: system-management@40460000 {
>> +		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> +		reg = <0x0 0x40460000 0x0 0x200>;
>> +
>> +		reset: reset-controller {
>> +			compatible = "nuvoton,ma35d1-reset";
>> +			regmap = <&sys>;
>> +			#reset-cells = <1>;
>> +		};
>> +	};
>> +
>> +	clk: clock-controller@40460200 {
>> +		compatible = "nuvoton,ma35d1-clk", "syscon";
>> +		reg = <0x00000000 0x40460200 0x0 0x100>;
>> +		#clock-cells = <1>;
>> +		clocks = <&clk_hxt>;
>> +		clock-names = "clk_hxt";
>> +		assigned-clocks = <&clk CAPLL>,
>> +				  <&clk DDRPLL>,
>> +				  <&clk APLL>,
>> +				  <&clk EPLL>,
>> +				  <&clk VPLL>;
>> +		assigned-clock-rates = <800000000>,
>> +				       <266000000>,
>> +				       <180000000>,
>> +				       <500000000>,
>> +				       <102000000>;
>> +		nuvoton,pll-mode = <0>, <1>, <0>, <0>, <0>;
>> +		nuvoton,sys = <&sys>;
>> +	};
>> +
>> +	gic: interrupt-controller@50801000 {
>> +		compatible = "arm,gic-400";
>> +		#interrupt-cells = <3>;
>> +		interrupt-parent = <&gic>;
>> +		interrupt-controller;
>> +		reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
>> +			<0x0 0x50802000 0 0x2000>, /* GICC */
>> +			<0x0 0x50804000 0 0x2000>, /* GICH */
>> +			<0x0 0x50806000 0 0x2000>; /* GICV */
> reg is second property.


OK, I will fix it.


>
>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	uart0:serial@40700000 {
>> +		compatible = "nuvoton,ma35d1-uart";
>> +		reg = <0x0 0x40700000 0x0 0x100>;
>> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clk UART0_GATE>;
>> +		status = "okay";
> Why? Drop the line... or convert it to disabled. Otherwise, why every
> SoC has serial0 enabled? Is it used internally?


uart0 is on all the way since this SoC booting from the MaskROM boot code,

load arm-trusted-firmware, load bootloader, and finally load linux  kernel.

uart0 is also the Linux console.


>
> Best regards,
> Krzysztof


Best regards,

Jacky Huang


