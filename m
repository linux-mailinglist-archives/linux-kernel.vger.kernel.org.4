Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E371709E04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjESR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:28:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55ABBC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:28:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af1c884b08so13793451fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684517306; x=1687109306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxGxnPUJjHuZyUcS7YnICwHCISjOXoTWhWv3CA+SKBY=;
        b=jpzsIx3rnDzYUkMrMBBF4JPwVn/S114JDwpjPJ3UO3swndpZJ1H+ilPS6O1THlLZs3
         1VyXjONvKGFtVb1oHJlFH3SafHWsgm+035QG7+zlO2XQjhR50LGd7MCVUjPmQXs63+gz
         +l/L0GnCF5sB8ZwE7lqp5RQl90B2/TOhWiyjXRBcKzNJ36syLfLAXpelHMuk2IyfMBKY
         j1Bc6ANyG4QLoe49gmF3R27sU8dHjqmkImPODlDX3ZQjg/M+D+UTMegO+i3iHiLAyNr+
         PrBS9XLvX/hcL0K1jjyfT6kmIqfMxDYu8lGX8ARvWpnsqGvldmEgM0Zl/hJIikcEfCAq
         EmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517306; x=1687109306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxGxnPUJjHuZyUcS7YnICwHCISjOXoTWhWv3CA+SKBY=;
        b=EbUhwMqyzr0ME2OXAqaQ0L1a+UHcLeDdQRBnclqfRvwoBW4LJK5MoNTw3SiF0SmKwR
         CptkelQ8f2idrwaSiyLGBtuGBPpb2AUfSv6vDipVFBg9u9ejcLEG4plaSVCDAC/8fAD6
         KgLqY50FplW9/SY2gkZ7ZL8vQVViXWS87DEGEaOmnfbln0yI3CPbagV2Fw+HNJ2973J5
         0CH7r6mspfN+sdHivC5XzUomPY2aPADCM5Wp29eDsk8Urp3AAL3pBxBoKuMJBQAUb82O
         61z020a1020xKUR+Sw1lWDrAKKCkInFCu0GXKRTVLqnH6lGzTv8oORWyqCGhTKMzqXP7
         E0CQ==
X-Gm-Message-State: AC+VfDxwf641LxOXFUytCpoamvIy3/5pxqVo35f3VtykeUuINwMr3zWm
        jw1DQcjdSJeoXHP4sRyky0QJog==
X-Google-Smtp-Source: ACHHUZ7rRMfyzJGZjCUTiXFmMObwN1i0P6LQUBk4gM6jpz/Kl0kOj3YR2P7dv9Rpo3TcnP5KH8Oy/w==
X-Received: by 2002:a2e:8559:0:b0:2ae:d911:1fb4 with SMTP id u25-20020a2e8559000000b002aed9111fb4mr1093179ljj.14.1684517306080;
        Fri, 19 May 2023 10:28:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a2-20020a2e8302000000b002a7853b9339sm904102ljh.119.2023.05.19.10.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:28:25 -0700 (PDT)
Message-ID: <405186ab-46df-fcf1-2894-a08c4b42c069@linaro.org>
Date:   Fri, 19 May 2023 19:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add SDX75 platform and IDP board
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robimarko@gmail.com,
        quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1684487350-30476-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 11:09, Rohit Agarwal wrote:
> Add basic devicetree support for SDX75 platform and IDP board from
> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
> the Application Processor Sub System (APSS) along with standard Qualcomm
> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
> etc..
> 
> This commit adds basic devicetree support.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile      |   1 +
>  arch/arm64/boot/dts/qcom/sdx75-idp.dts |  19 ++
>  arch/arm64/boot/dts/qcom/sdx75.dtsi    | 534 +++++++++++++++++++++++++++++++++
>  3 files changed, 554 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d42c595..4fd5a18 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> new file mode 100644
> index 0000000..e2e803b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sdx75.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SDX75 IDP";
> +	compatible = "qcom,sdx75-idp", "qcom,sdx75";
> +	qcom,board-id = <0x2010022 0x302>;
You should be able to get by without qcom,{msm,board}-id.

> +
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <110 6>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> new file mode 100644
> index 0000000..c2b8810
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * SDX75 SoC device tree source
> + *
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	qcom,msm-id = <556 0x10000>;
> +	interrupt-parent = <&intc>;
> +
> +	chosen: chosen { };
> +
> +	memory {
The memory node should have a unit address.

> +		device_type = "memory";
> +		reg = <0 0 0 0>;
> +	};
> +
> +	clocks { };
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
[...]

> +
> +		CLUSTER_PD: power-domain-cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0 &CX_RET &CLUSTER_SLEEP_1>;
Is CLUSTER_SLEEP_1 deeper than CX retention?

> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-sdx75", "qcom,scm";
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gunyah_hyp_mem: memory@80000000 {
reserved memory subnodes should have meaningful node names, e.g.

hypervisor@800...

> +			reg = <0x0 0x80000000 0x0 0x800000>;
> +			no-map;
> +		};
> +
[...]

> +
> +	smem: qcom,smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	soc: soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
Are the SoC buses limited to 32b addresses?

> +		compatible = "simple-bus";
Compatible should go first.

> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sdx75-pdc", "qcom,pdc";
> +			reg = <0x0 0xb220000 0x0 0x30000>,
> +			      <0x0 0x174000f0 0x0 0x64>;
> +			qcom,pdc-ranges = <0 147 52>,
> +					  <52 266 32>,
> +					  <84 500 59>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,sdx75-tlmm";
> +			reg = <0x0 0x0f000000 0x0 0x400000>;
> +			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 133>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			wakeup-parent = <&pdc>;
> +		};
> +
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sdx75-smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x15000000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
Many newer SoCs have dma-coherent SMMUs. Is this the case here?

> +		};
> +
> +		intc: interrupt-controller@17200000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			reg = <0x0 0x17200000 0x0 0x10000>,
> +			      <0x0 0x17260000 0x0 0x80000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		timer@17420000 {
> +			compatible = "arm,armv7-timer-mem";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			reg = <0x0 0x17420000 0x0 0x1000>;
> +			clock-frequency = <19200000>;
clock-frequency is discouraged, unless strictly necessary.

Since gh is running, the timer is already programmed so it should be
fine to drop this.

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;
Ditto

Konrad
> +	};
> +};
