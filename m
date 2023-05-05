Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13A6F7F82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjEEJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjEEJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:05:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1504718DDF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:05:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30771c68a9eso1012775f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683277529; x=1685869529;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDL7XPmEwUl+fFh31zFWiv2/Mqp74XR+Juk+mzZvZAU=;
        b=nb0tHhS9S85ueOB/JuaLsabg/n5h0xp+OIJlrE7NGhpuuGHMbIPVLFFQdrz4rZm0mH
         /IoBK7FeBkwVgUlo4BuRDKriMWvz4FBjx2wHdfpDDWUIzgAuZpzTn9E1FHCwqZ5mt6V1
         1MgMBy9FDcATrqw5x63axFO91LgH22+fTanQnGkvPHoSqsLhfEmo/pYEVzMlwaPRd8VS
         Jd2K9AgyemzsaGTRw1hc69dMOxZPjJmgFPlhe8xw8rIVbfs2Gps1N1A/nGjOIs++W12n
         tb6MWT4AyXqXnWRAaM2XKcnasVIEwttRdtxTK5gH9CQ2zUHBJzGujuqH7vgDRlEuKVBm
         RmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683277529; x=1685869529;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDL7XPmEwUl+fFh31zFWiv2/Mqp74XR+Juk+mzZvZAU=;
        b=Bvh5+hlV6gWFQKdgocd8xtIjODl5m1X6wlHf0RtvGkVfw39ic54/RAMBGiT6xLTaXN
         GNAXlK8z1zgT8eWGf15vglRHSI06IDH9Pxrp3uMOE5o7yhu9Ym/W4MzCFFEckOtPP8qf
         UEXgtbHF33jQ9cZr3DJjIVEbUxHigkdbotKn4mcCsVtnLUwFxvVH/zMl8/wkG13HdPzk
         1K4td0NPTIT4pso3SYRieLdw30J4mUw1zoe2PSffGgsWU3ghiY7fiNiqSrWTzy4BYnme
         Uasd2BmIKAnBoPdn513GFw+o9N2RebRczkzHPRtuBcjrqnCsvtNqFjU8XuSZMd4dhR5j
         YkxQ==
X-Gm-Message-State: AC+VfDzRBVLABVebrU1AUUC70Q6wOvfl2SkpXgeZltdtRPOUp1SRH9Il
        rPG7FlkwGhq71/GJvh+JBnHuHA==
X-Google-Smtp-Source: ACHHUZ6xSwXm09DJM5jnbJvL9hg11bHmawAn92n/wjPBtBUG8ey+BW3w90alAz5Fj1Q9nbONmGA9tw==
X-Received: by 2002:adf:f4c3:0:b0:2ef:bc0b:e70 with SMTP id h3-20020adff4c3000000b002efbc0b0e70mr813485wrp.54.1683277529508;
        Fri, 05 May 2023 02:05:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f548:bbaf:d95f:43ff? ([2a01:e0a:982:cbb0:f548:bbaf:d95f:43ff])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4252000000b00304aba2cfcbsm1761312wrr.7.2023.05.05.02.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 02:05:29 -0700 (PDT)
Message-ID: <ca4c87f4-c496-7fa6-2945-45e4fd9c2020@linaro.org>
Date:   Fri, 5 May 2023 11:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V3] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230505071254.2571429-1-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230505071254.2571429-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 09:12, Xianwei Zhao wrote:
> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
> applications.
> 
> Add basic support for the C3 based Amlogic AW409 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Link: https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com
> Link: https://lore.kernel.org/all/20230307222651.2106615-2-martin.blumenstingl@googlemail.com

What are those links ? If they are dependencies, please add them under the --- before the changelog.

Thanks,
Neil

> ---
> v2 -> V3: Remove '256m' from filename;
>            Keep alphabetical order of Makefile.
> V1 -> V2: Remove new arch, and use ARCH_MESON;
>            Modify node name, and delete superfluous blank line.
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>   .../dts/amlogic/amlogic-c3-c302x-aw409.dts    | 29 +++++++
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 86 +++++++++++++++++++
>   3 files changed, 116 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index cd1c5b04890a..6f61798a109f 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
> new file mode 100644
> index 000000000000..edce8850b338
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-c3.dtsi"
> +
> +/ {
> +	model = "Amlogic C302 aw409 Development Board";
> +	compatible = "amlogic,aw409", "amlogic,c3";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart_b;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x10000000>;
> +	};
> +};
> +
> +&uart_b {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> new file mode 100644
> index 000000000000..93b335aef605
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@fff01000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xfff01000 0 0x1000>,
> +			      <0x0 0xfff02000 0 0x2000>,
> +			      <0x0 0xfff04000 0 0x2000>,
> +			      <0x0 0xfff06000 0 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb4: bus@fe000000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xfe000000 0x0 0x480000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> +
> +			uart_b: serial@7a000 {
> +				compatible = "amlogic,meson-g12a-uart";
> +				reg = <0x0 0x7a000 0x0 0x18>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +			};
> +
> +		};
> +	};
> +};
> 
> base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833

