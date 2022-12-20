Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1729651E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiLTKKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLTKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:10:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888732D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:10:14 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so17886368lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5nIqDU3UUGi3Rg5H51YN1/uE1UBBhaJzW8Igj65Eo0=;
        b=geKdNRxmbxPQocBMUjegJOuN9Cq+leOpLZZ0P+J2NArfjj/TE3jDUpm9b9lVGkpWEO
         uQ1RoqOUtIbvtuArjbnV4L+pxEfqEujcv5ynEh8aI+k+Wk9EhycH7zmat8LQuWOEQGgp
         wUL9F5oaMehJvvxOcGQB2pzFixYys95723dwkxkrGTaKsrSMlhxn0YGs+ZkMiV+qaqur
         FY+kgcl237aU+YuBwy/DQtEZMOQyqP2BeqPzz0jxVx/HBTk8GA4SjYdIheHWuA2KXlL3
         QjhQgdknXlYW3PjJ4LHHP172ce7lfaeqDtRhuPoR4X2iJBYxJA4ZT4Wf4/U6Golv+kvr
         22SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5nIqDU3UUGi3Rg5H51YN1/uE1UBBhaJzW8Igj65Eo0=;
        b=Z4B0QsT/91uEoOYmcWQQaXY5v012QENYbOvvo0cFU7O7/VLYsPjIITnvckETHE5HRI
         z7WKg2XJO+3xDBzGeOXIiNjlJh5/Nvu7iAE0v8ckRRKSUZ/m4HSAdBuMNFSjgEGbPTMA
         auNjdREiqUB+8p9zWQPVVn7qgbHScqBlz2/sBPTPq678zoDP4IYOaS7MgvOid3VzUBo2
         3E3ZK+9QLk8HsIKEbnZlOREWRpROY5aVdfwjcFXMltKVcyryq8eluX9fbpfkYyerLrtv
         a6QzkdR5Albxy+em+RZ6kCcZi+GbCJrE7RJFqaBUKpE5zjKloRP4+jrDpJUk147LW8iC
         qaPw==
X-Gm-Message-State: AFqh2ko3ghBq1S1FdlFpF94deJlN2zAz9DjHofbOUABMPSBkJR1eGquN
        2I0aPYka1EuY87wyxpxCA3mQDQ==
X-Google-Smtp-Source: AMrXdXvMErEP+dfsE5G/puEph/u8A7ysD6PEtYb76Tg/KI5fTVwbPfTulajPAEB3+aHtv3wp29wMIw==
X-Received: by 2002:a05:6512:3da2:b0:4b9:f5e5:8fb4 with SMTP id k34-20020a0565123da200b004b9f5e58fb4mr784949lfv.3.1671531013165;
        Tue, 20 Dec 2022 02:10:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f2-20020a2eb5a2000000b00279f213302bsm973530ljn.57.2022.12.20.02.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:10:12 -0800 (PST)
Message-ID: <ebb27bb2-158c-8207-7184-0d5b5ca0ce14@linaro.org>
Date:   Tue, 20 Dec 2022 11:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220011247.35560-7-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 02:12, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 411 +++++++++++++++++++++++
>  1 file changed, 411 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> new file mode 100644
> index 000000000000..64d260ea1f29
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +#include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +/ {
> +	compatible = "starfive,jh7110";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		S76_0: cpu@0 {
> +			compatible = "sifive,u74-mc", "riscv";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <8192>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <16384>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imac";
> +			tlb-split;
> +			status = "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		U74_1: cpu@1 {
> +			compatible = "sifive,u74-mc", "riscv";
> +			reg = <1>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		U74_2: cpu@2 {
> +			compatible = "sifive,u74-mc", "riscv";
> +			reg = <2>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		U74_3: cpu@3 {
> +			compatible = "sifive,u74-mc", "riscv";
> +			reg = <3>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		U74_4: cpu@4 {
> +			compatible = "sifive,u74-mc", "riscv";
> +			reg = <4>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <40>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <40>;
> +			mmu-type = "riscv,sv39";
> +			next-level-cache = <&ccache>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&S76_0>;
> +				};
> +
> +				core1 {
> +					cpu = <&U74_1>;
> +				};
> +
> +				core2 {
> +					cpu = <&U74_2>;
> +				};
> +
> +				core3 {
> +					cpu = <&U74_3>;
> +				};
> +
> +				core4 {
> +					cpu = <&U74_4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	osc: osc {

Node names should be generic, so why this is "osc" and other oscillators
are not "osc"?


> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	rtc_osc: rtc_osc {

No underscores in node names. Generic node names (so each of them
starting or ending with clock).

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	gmac0_rmii_refin: gmac0_rmii_refin {

Same problem... and actually you have way too many fixed clocks which do
nothing. It looks like you avoid to define proper clock controller.
What's the point for all these clocks? These are no-op.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	gmac0_rgmii_rxin: gmac0_rgmii_rxin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	gmac1_rmii_refin: gmac1_rmii_refin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	gmac1_rgmii_rxin: gmac1_rgmii_rxin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	i2stx_bclk_ext: i2stx_bclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	i2stx_lrck_ext: i2stx_lrck_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	i2srx_bclk_ext: i2srx_bclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	i2srx_lrck_ext: i2srx_lrck_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	tdm_ext: tdm_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	mclk_ext: mclk_ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clint: clint@2000000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "starfive,jh7110-clint", "sifive,clint0";
> +			reg = <0x0 0x2000000 0x0 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>;
> +		};
> +
> +		plic: plic@c000000 {

Node names should be generic, so interrupt-controller
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
> +			reg = <0x0 0xc000000 0x0 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			riscv,ndev = <136>;
> +		};
> +
> +		ccache: cache-controller@2010000 {
> +			compatible = "starfive,jh7110-ccache", "sifive,ccache0", "cache";
> +			reg = <0x0 0x2010000 0x0 0x4000>;
> +			interrupts = <1>, <3>, <4>, <2>;
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <2048>;
> +			cache-size = <2097152>;
> +			cache-unified;
> +		};
> +
> +		uart0: serial@10000000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x10000000 0x0 0x10000>;
> +			clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
> +				 <&syscrg JH7110_SYSCLK_UART0_APB>;
> +			clock-names = "baudclk", "apb_pclk";
> +			resets = <&syscrg JH7110_SYSRST_UART0_APB>;
> +			interrupts = <32>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +

Best regards,
Krzysztof

