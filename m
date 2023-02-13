Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061CC694452
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjBMLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBMLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:22:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C8C160
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:22:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so11783841wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGot4AgaaxOdpZoK7zokKt9GKtHGINSnsvFNFyCvKxY=;
        b=ek9RhYbXwGWaeObsrLGY3kHgRRkqrYahtV5ljY0nwx+qpNMKDIP91GUkHfK5EwU2J2
         qMyI4zJpFf8vrO/vbi05ZSIXrGSbpwsgZXA8Q64Gd3e+bVSv/3NRkzjOF0mVpgodgnLM
         DfLszSQTWSkRbbbszR9ubmRmYx0LKKREoBTKoCCdzngYaZXOnYPGu93hPd5EBTo824q5
         OAsql/BPmUqO204OEmNlQmrOdFq/KQByKtr/26H99zkyT9uUjoMmUZ68JK/KwDR5Pv0C
         puYgnG2Y0gHDTzrktrKuuvb5vFjHEGaxq1i/cmqJ81c60z5poC4KGCqFPNtvB6BHvphZ
         2Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGot4AgaaxOdpZoK7zokKt9GKtHGINSnsvFNFyCvKxY=;
        b=AFl7znRiyYdshKnS0V6cJmBq0NIWiLvoDeeaLoSt0JTQZQTtCIQ5RlmogNCTOrwZG2
         UZppo14e+8lsA+47lMZ0Fi1+QvrtJnnl2RAbkY1MY/6fXz9nb5nB3dSARWN53LoApzFo
         QLg/3L0bw8E4bRwCyJ9it8rOZlb235gc5s+uh6AwQtgT8+qxsWxZux+IfMvgeMqfuDsZ
         1Cq32yOaH4VQLgn1LfECAupy7gvA4dtY4g7uczOE4keBUJ8sZAnkCo1Od/M+fUxILZc0
         VlAkDx6cjF7lRLA/enkeWN+tldHfNiQEFThhBOBid+AAh/8BR2aG30HizXNdtUvphuQ5
         /xsQ==
X-Gm-Message-State: AO0yUKW5hDhSdJFhKDC+P8mc73nUw1z6jRyO5PCYGZ+3wXpix6z0mf6v
        h7EJv69YxsdUNLA4ov//fwiYdA==
X-Google-Smtp-Source: AK7set8QdqLpifM+cbX8d6wkcudWoURrmRDj41rTiScdwAy7OWLCoFD6/dAhSpiHK8ZVhnQRQKux2g==
X-Received: by 2002:a5d:4607:0:b0:2c5:5391:8ab1 with SMTP id t7-20020a5d4607000000b002c553918ab1mr3554368wrq.53.1676287333965;
        Mon, 13 Feb 2023 03:22:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002c5560a228bsm3341768wrm.95.2023.02.13.03.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:22:13 -0800 (PST)
Message-ID: <1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org>
Date:   Mon, 13 Feb 2023 12:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 17/17] arm64: dts: apple: t8112: Initial t8112 (M2) device
 trees
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-17-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-17-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> This adds device trees for the following devices:
>  - Macbook Air (M2, 2022)
>  - Macbook Pro 13" (M2, 2022)
>  - Mac mini (M2, 2023)
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/Makefile        |    3 +
>  arch/arm64/boot/dts/apple/t8112-j413.dts  |   71 ++
>  arch/arm64/boot/dts/apple/t8112-j473.dts  |   60 ++
>  arch/arm64/boot/dts/apple/t8112-j493.dts  |   60 ++
>  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
>  arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi      |  904 +++++++++++++++++++++++
>  7 files changed, 2320 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> index 5a7506ff5ea3..aec5e29cdfb7 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
> diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
> new file mode 100644
> index 000000000000..0e5b5add92cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple MacBook Air (M2, 2022)
> + *
> + * target-type: J413
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8112.dtsi"
> +#include "t8112-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
> +	model = "Apple MacBook Air (13-inch, M2, 2022)";
> +
> +	aliases {
> +		bluetooth0 = &bluetooth0;
> +		wifi0 = &wifi0;
> +	};
> +};
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +&port00 {
> +	bus-range = <1 1>;
> +	wifi0: wifi@0,0 {
> +		compatible = "pci14e4,4433";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-mac-address = [00 10 18 00 00 10];
> +		apple,antenna-sku = "XX";
> +		brcm,board-type = "apple,hokkaido";
> +	};
> +
> +	bluetooth0: bluetooth@0,1 {
> +		compatible = "pci14e4,5f71";
> +		reg = <0x10100 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-bd-address = [00 00 00 00 00 00];
> +		brcm,board-type = "apple,hokkaido";
> +	};
> +};
> +
> +/*
> + * Remove unused PCIe ports
> + */
> +
> +/delete-node/ &port01;

You should not delete devices just because they are unused. Externally
visible buses should be just disabled in DTSI and you enable them when
needed. Not the opposite way.

What's more, you must node delete nodes just because they are "not
used". This not anymore proper description of hardware.

> +/delete-node/ &port02;
> +/delete-node/ &port03;
> +
> +&i2c0 {
> +	/* MagSafe port */
> +	hpm5: usb-pd@3a {
> +		compatible = "apple,cd321x";
> +		reg = <0x3a>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8112-j473.dts b/arch/arm64/boot/dts/apple/t8112-j473.dts
> new file mode 100644
> index 000000000000..55950d0a73c5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8112-j473.dts
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple Mac mini (M2, 2023)
> + *
> + * target-type: J473
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;

(....)


> +
> +	ps_debug_switch: power-controller@b8 {
> +		compatible = "apple,t8112-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +		reg = <0xb8 4>;
> +		#power-domain-cells = <0>;
> +		#reset-cells = <0>;
> +		label = "debug_switch";
> +		apple,always-on; /* Core AON device */
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> new file mode 100644
> index 000000000000..974443913f6a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -0,0 +1,904 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple T8112 "M2" SoC
> + *
> + * Other names: H14G
> + *
> + * Copyright The Asahi Linux Contributors
> + */


(...)

> +
> +		aic: interrupt-controller@23b0c0000 {
> +			compatible = "apple,t8112-aic", "apple,aic2";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x2 0x3b0c0000 0x0 0x8000>,
> +				<0x2 0x3b0c8000 0x0 0x4>;
> +			reg-names = "core", "event";
> +			power-domains = <&ps_aic>;
> +
> +			affinities {
> +				e-core-pmu-affinity {
> +					apple,fiq-index = <AIC_CPU_PMU_E>;
> +					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
> +				};
> +
> +				p-core-pmu-affinity {
> +					apple,fiq-index = <AIC_CPU_PMU_P>;
> +					cpus = <&cpu_p0 &cpu_p1 &cpu_p2 &cpu_p3>;
> +				};
> +			};
> +		};
> +
> +		pmgr: power-management@23b700000 {
> +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";

Why this is simple-mfd?

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x2 0x3b700000 0 0x14000>;
> +		};


> +
> +		pmgr_mini: power-management@23d280000 {
> +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";

Why this is simple-mfd?

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x2 0x3d280000 0 0x4000>;
> +		};



Best regards,
Krzysztof

