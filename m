Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A9674E31
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjATHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjATHgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:36:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F479E81
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:36:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d2so4016106wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IyDksw4In571CMG1wQO8CYi8Ggw0R7q3N5yYBg7B80=;
        b=yGFKB2yCoa7rBZdl/X5DlREc1ebfEekTyb8kR28l1lR3AI99MccgbLInZimwawlDxQ
         c7dxvcCEwkTHz2yqpMNAsif6RgaiaX3S64lFZ9Kmf2OdsvnvXkCxe58B1AR+UiCVFRru
         Nw/nie2Mk+qTq7YlcQaKK6/m2nvIK6kBJ68Ju+b5At8o2nfImSB4KWtCoW8Pmyw3ZZe1
         zfjW0hfHLM2TTrkJbWp2LVMVuISVYDRNgI19Y5PLzzkefZpK2m/UZypTlB87jGzB5I/a
         bpUHe+yVVYGyOAYE7LDnHT/3178Zd1S09O+OAfodDIEv0NKMT/giSzWCHhLmqFe27ch3
         4tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IyDksw4In571CMG1wQO8CYi8Ggw0R7q3N5yYBg7B80=;
        b=VOh5LboDcTa6KQ2AGPdqBSqHVti291T4zfVtWnt8unPjjGfsOFcxeH4CMDBlicINc6
         86y2jx0gsfUomhcMjkFIvU1oWd7FB/QpnWJcDeHnNLlj+yFxjO5JM2Awf+RrcXWS5rJH
         haWqVlCpwjugnf3t4K0QGm8DU5zFYUEUG4JJ1caBXiBt6Yv1CHWrid0LtHtvwW5ASIRK
         P+acQ1sNn8apMw44ATZyiwAdXvBQ4gM/HJIOridWltk/x35M87U1LUsiqNOJbRt/xChL
         CQ4mBVR9cLgGtileXv0xyX52b4XKEe4Bj110iWQoPUWlv1iiKg89G4xMn+dAr88kiSB+
         zxug==
X-Gm-Message-State: AFqh2koFdY9dr5nUvwk/uaWYxgRBDWLuz2qnjtU8jhZTpWoV/qBpKa+W
        XeNG2NvT/+sBCvz3jwcIwtwKMA==
X-Google-Smtp-Source: AMrXdXtjqrKgOvxeYSKY4NTGLQ3QIOi1BfL2Gv8f+V7DJCc7vo/j/raBFSyvTQqbYDsLyWmjJMvfTQ==
X-Received: by 2002:a5d:5b18:0:b0:2bd:c2ce:dd5a with SMTP id bx24-20020a5d5b18000000b002bdc2cedd5amr25147724wrb.16.1674200158728;
        Thu, 19 Jan 2023 23:35:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b002be505ab59asm1865018wrb.97.2023.01.19.23.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:35:58 -0800 (PST)
Message-ID: <73767d6b-54ea-6ab6-7140-00ae96e0b1ba@linaro.org>
Date:   Fri, 20 Jan 2023 08:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm: dts: Add device-tree for Samsung Galaxy S5
 (Exynos)
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
References: <20230119185848.156502-1-markuss.broks@gmail.com>
 <20230119185848.156502-3-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119185848.156502-3-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 19:58, Markuss Broks wrote:
> Samsung Galaxy S5 (Exynos) was sold alongside Samsung Galaxy S5
> with Snapdragon SoC, however the Exynos version features a 3G
> capable Intel modem instead of Qualcomm version featuring LTE modem.
> This phone is based on Exynos5422. Currently, the touchscreen,
> USB, eMMC and the PMIC are enabled in the device-tree.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                   |   1 +
>  arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 676 +++++++++++++++++++
>  2 files changed, 677 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c014f4fc53c0..b3aa4ad73d52 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5422-odroidxu3.dtb \
>  	exynos5422-odroidxu3-lite.dtb \
>  	exynos5422-odroidxu4.dtb \
> +	exynos5422-samsung-k3g.dtb \
>  	exynos5800-peach-pi.dtb
>  dtb-$(CONFIG_ARCH_GEMINI) += \
>  	gemini-dlink-dir-685.dtb \
> diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> new file mode 100644
> index 000000000000..b1da32a6d41d
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> @@ -0,0 +1,676 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Galaxy S5 (Exynos) device-tree source
> + *
> + * Copyright (c) 2023 Markuss Broks
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/samsung,s2mps11.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>

Order these by name, so clock, gpio and then interrupt-controller.

> +#include "exynos5800.dtsi"
> +#include "exynos5422-cpus.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy S5 (Exynos)";

Samsung Galaxy S5 (GT-I.....)

This also applies to your binding patch. Do not introduce own style, use
existing style from other boards.

> +	compatible = "samsung,k3g", "samsung,exynos5800", \
> +			 "samsung,exynos5";

This does not look aligned.

> +
> +	chassis-type = "handset";
> +
> +	memory@20000000 {
> +		device_type = "memory";
> +		reg = <0x20000000 0x80000000>; /* 2 GiB */
> +	};
> +
> +	fixed-rate-clocks {
> +		oscclk {
> +			compatible = "samsung,exynos5420-oscclk";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	firmware@2073000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x02073000 0x1000>;
> +	};
> +
> +	tsp_vdd: tsp-vdd-en {

Generic node names, so regulator-tsp-vdd-en.

> +		compatible = "regulator-fixed";
> +		regulator-name = "tsp_vdd_en";> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpy3 5 0>;

Use GPIO flags.

> +		enable-active-high;
> +	};
> +
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
> +&gpu {
> +	status = "okay";
> +	mali-supply = <&buck4_reg>;
> +};
> +
> +&hsi2c_7 {
> +	status = "okay";
> +
> +	pmic@66 {
> +		compatible = "samsung,s2mps11-pmic";
> +		reg = <0x66>;
> +
> +		interrupt-parent = <&gpx0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&s2mps11_irq>;
> +
> +		s2mps11_osc: clocks {
> +			compatible = "samsung,s2mps11-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps11_ap",
> +					"s2mps11_cp", "s2mps11_bt";

Misaligned.

> +		};
> +

Best regards,
Krzysztof

