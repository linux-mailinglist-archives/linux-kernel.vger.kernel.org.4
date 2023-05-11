Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58606FEDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjEKIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEKIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:39:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8615FC9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:39:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3063afa2372so7671544f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683794357; x=1686386357;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TBlErrl7gnhIiZO37qzjtqIBcMLNUDzoJ4wQ0ZgBLGw=;
        b=kTDgVm+zIAYKB5YYNqGxK+poZ+fA+0wO1SHPlF1X/qFkaxdX1AuAwOipB4S4e3M2MN
         W7UAzSh1cmQUYrpmruLq4m5Kfxcc8AbVI8GaW5+9JKS7yIJ8IsAH+zX6oNzSn4TXM9ro
         Yqjfo/68312Ekw7V5FNGbF7L9rjBIOMZp8sox89f5E6+IVhSflAANHoJ8L5Tq6DNPKr3
         lnTGtkImYFCkpA9LcbFvQPElRFgthIvdtcGFcuaEyxn43OXF5h5bRm692gK2oW0jtYOw
         woLbVMng6DYG+OuqOcVqDjLjmRepE7PdWU2EI/ZHB/mVaOHBLgqHsS4QczWwa3De7gcy
         iwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683794357; x=1686386357;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBlErrl7gnhIiZO37qzjtqIBcMLNUDzoJ4wQ0ZgBLGw=;
        b=eajlZ9Ar699ykPhWlPZRlAStf3j3Nlr/OE9Mrg/cKs885GCbBe77zvCLecS08RRASC
         CLlv5QoLgmGdC8AzgYMTDhV+o7WHZCl2+XFPiqGzYSe3fv4vGo7fO+XT79iTqPspbOeH
         7Vfx2hMoDkZNS9L7jWGXOgILiw0mY2SRfxFQ1KGF9MXaI47z6mR8WkfJV0KuGA9Q/0gX
         yMAnCf7l3TQ4ogGDNB5/LyH6AMw6P4uiJ5mMR2YPu6u3+5mGft0s5j/H2W6NuiqTqU4a
         nNOZmoztEHUzqoZpVFdxWpqOLeBdJTTRK5dzudznw2c9VPYSh/sLeWldZ861jTYL90cR
         66lA==
X-Gm-Message-State: AC+VfDz1CtjVJ4uMXuNsya/5n/FyRcsUObgM3APrhOQQT01+ofdMUt+o
        6V8+wsFLJbueDpLpHbp3iH8wiQ==
X-Google-Smtp-Source: ACHHUZ4Zj10EOYnAvH4Gr3kJOCqNVm6j4etcsCQ8ktADUB/UwHDdmfdkqsRgFiHiREwVtFpbTlrEqA==
X-Received: by 2002:adf:e943:0:b0:306:2cf5:79dc with SMTP id m3-20020adfe943000000b003062cf579dcmr16913427wrn.35.1683794357482;
        Thu, 11 May 2023 01:39:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:182d:9e6c:b8ff:5a99? ([2a01:e0a:982:cbb0:182d:9e6c:b8ff:5a99])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003ee5fa61f45sm24910493wmb.3.2023.05.11.01.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:39:17 -0700 (PDT)
Message-ID: <b2bdb00f-63de-40a9-ebe6-32f83607b5d8@linaro.org>
Date:   Thu, 11 May 2023 10:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V4] arm64: dts: add support for C3 based Amlogic AW409
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/05/2023 11:11, Xianwei Zhao wrote:
> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
> applications.
> 
> Add basic support for the C3 based Amlogic AW409 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Link: https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com
> Link: https://lore.kernel.org/all/20230307222651.2106615-2-martin.blumenstingl@googlemail.com
> 
> V3 -> V4: Move Link under the --- before the changelog.
> V2 -> V3: Remove '256m' from filename;
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

This should be:

	compatible = "amlogic,meson-g12a-uart", "amlogic,meson-gx-uart"

to match the amlogic,meson-uart.yaml bindings.

Please run :
make CHECK_DTBS=1 amlogic/amlogic-c3-c302x-aw409.dtb

With that fixed, please add on v5:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

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

