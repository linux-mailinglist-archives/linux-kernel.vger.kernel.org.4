Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B243725E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjFGMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjFGMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:13:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2C1BD4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:13:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so1269430a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686139990; x=1688731990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxeLXXBCAzKSF9EaKSeDGi9QZ7gj28djOqBeKfbqbww=;
        b=PRLqBcz5NVG99Nufi6ltzVRN5RxfSwKsMxJn5jW+WKz4ba1VxKdUbld4Fh7WvaSKrl
         GIQfPA6zDkXHT5/dkrqkMge3s4s6+fXRH68XjHOx3sPFkBdYhGKr1OCVBSNjclnWLjKy
         ZF3kQJlR8cnpzNnQBm51kgUC1POmKuF1QDQ3TEyVeKyZ/sZkd2TCz+OgUSV93Kh72fGv
         rugYNUfQwNLut4vKgDZ/3GqHn1Iefu1lh+aCHCxhTXCSl4foyZYeSXa/U5VDds2TKRu1
         BrNT0ea+IsyCJm/liIeRyLwnfBbIO8IiB4e22smE8IUJPY2L7eZ3kM0I2abmzmdSxmEQ
         srjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686139990; x=1688731990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxeLXXBCAzKSF9EaKSeDGi9QZ7gj28djOqBeKfbqbww=;
        b=V4DihpgYCvWLPSdrtuMgaajHNJ3Avly28si+GS1C9L9QBKuWnY4AKB2Xr/mqOxWK7I
         HbC9xLoTHQQbQw6DZXMG9eRMLSN2ntcxM4LPX1z7IWujV0v4/8XqqlysYsKRJfLwDhbo
         MCn58pvW9gVdH6v07iovQtq/Du7aggWrPmDcKT2xkE01SirEykMNwApDDBMK4UeM/K7p
         FtzaM0UyQhvl6NMmy9eEWOkqx6Bj9K2eB9s0IxUW0S29sOoXsUOYcJXl6g3tyDuX6D4F
         gpAPLhmTHPh0NFsPLuCF8cRqqUnvsSH54rQ8ImczREdGBkkeELb/asJK/y/2F7tj0pG2
         BuSg==
X-Gm-Message-State: AC+VfDwQcRzX3YE7YJFIgTYq87x2MkMC04l97Jkfoqmx9t6yUkOgNKM0
        X+5hlcueMQA4vn1XhdL8P0PpDA==
X-Google-Smtp-Source: ACHHUZ42spwVdZjLjycyHXug82mcqDdkwMeE5tGPXGVrQgoGU66w8PIL/qaCRjSGYRAnzna2OaKakg==
X-Received: by 2002:a05:6402:50:b0:510:6ccf:84aa with SMTP id f16-20020a056402005000b005106ccf84aamr4549921edu.32.1686139990621;
        Wed, 07 Jun 2023 05:13:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7c653000000b005149b6ec1bdsm6072041edr.29.2023.06.07.05.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 05:13:09 -0700 (PDT)
Message-ID: <e45d3d3b-a31d-5ad0-b43f-7193add4ee66@linaro.org>
Date:   Wed, 7 Jun 2023 14:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add SDX75 platform and IDP board
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        maz@kernel.org, mani@kernel.org, robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1686138469-1464-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686138469-1464-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1686138469-1464-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 13:47, Rohit Agarwal wrote:
> Add basic devicetree support for SDX75 platform and IDP board from
> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
> the Application Processor Sub System (APSS) along with standard Qualcomm
> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
> etc..
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile      |   1 +
>  arch/arm64/boot/dts/qcom/sdx75-idp.dts |  33 ++
>  arch/arm64/boot/dts/qcom/sdx75.dtsi    | 660 +++++++++++++++++++++++++++++++++
>  3 files changed, 694 insertions(+)
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
> index 0000000..cbe5cdf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
> @@ -0,0 +1,33 @@
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
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +};
> +
> +&chosen {
> +	stdout-path = "serial0:115200n8";
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <110 6>;
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> new file mode 100644
> index 0000000..40fa579
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * SDX75 SoC device tree source
> + *
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sdx75-gcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&intc>;
> +
> +	chosen: chosen { };
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <76800000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
> +			enable-method = "psci";
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			next-level-cache = <&L2_0>;
> +
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;

You miss properties like level and unified. Maybye you tested it with
some old (half year ago) dtschema?

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

