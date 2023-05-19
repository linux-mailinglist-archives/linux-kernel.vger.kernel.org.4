Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3945709E31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjESRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjESRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:32:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F1139
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:32:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4013597e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684517520; x=1687109520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRNkViIBcVngZF9w4Pz0rznZyK0rQOFGPWbrvdFSlBc=;
        b=YfyphSIfy1w7G6XJaW5c5X2PuFN+tuOc5Rc8YeSKAetfqBO1rSyQhwLZISoAZvJlvz
         bgn9WGskOXkNks8Ts1pEk0rZcPIVLkw9hrhK+jiFTIpe4bfUFFYaQNdb/4+2qV7YfAtV
         fus494xU6ylpSEiSmbisnMNP0rXgD/8+wgPxv3dLcK2qGFEhcTHmd7Y8jdoQ8AxzgB42
         dIdUBFTxQkqaAgx4upmg8wTU3WWETDMVLnkwsBbvalDlffmUbfkLoS7LNIRaohZqJsr/
         KWRHeDqU/nswnGJTqeoBkPlDcy4o3Q2fLRu5FlWMLfwit/ZZ7O0ZyCkznCAjTCDiG+T4
         afGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517520; x=1687109520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRNkViIBcVngZF9w4Pz0rznZyK0rQOFGPWbrvdFSlBc=;
        b=LlYli3mW8SIPCbidaVsYFLIX3gehzQ+g4h2D5W2V0YDO+Gk9yO/BoW19YvyHaykxNx
         lhb53NeKEBRxKvjNk2lhOIM2MlUEmrIl1DXOsgGvaS1r2WjRgaYvOPFJ5C+VNkq7ydIA
         tJFr/wHDv///VZ+XR4dmy0gU8RQswgZL5t/Dsu2dhiWiFEAHvny0P1HJqBLQINeAEJbX
         C85CIJ7FjK9OPxdXOrEnIwF/PYyR+ZuAdSE9XtmfpX7j86YyvhMjR245I24b9vjh63pV
         ECpRZUN05HX1rANEdJ+mvjnSYt2Q3AUYAM39xQq0ebnuY40m4GAl3Pk/gxHjY33J+Nbq
         myfg==
X-Gm-Message-State: AC+VfDxmR2YjQ8dKXbbSwjfFNmMx7s+rsuLgFUUGXx/gnHHTyRhgJ86f
        BY75gmxargck8MgQ7F+rs6MkEA==
X-Google-Smtp-Source: ACHHUZ7KYzQnGYIEeP5HppjP6/x2/IWr7cIsDzgUkRWRsvigZ2yGOMl2V98pK3XFreWEVHAnnlOAjA==
X-Received: by 2002:a05:6512:4d9:b0:4f3:b215:ef7c with SMTP id w25-20020a05651204d900b004f3b215ef7cmr476389lfq.23.1684517519934;
        Fri, 19 May 2023 10:31:59 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z17-20020a19f711000000b004d4d7fb0e07sm658442lfe.216.2023.05.19.10.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:31:59 -0700 (PDT)
Message-ID: <8a5df35a-2429-3880-6a1e-795c13c3b3d1@linaro.org>
Date:   Fri, 19 May 2023 19:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for RDP454
 variant
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230519103128.30783-1-quic_poovendh@quicinc.com>
 <20230519103128.30783-3-quic_poovendh@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519103128.30783-3-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 12:31, Poovendhan Selvaraj wrote:
> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
> 
> Add the initial device tree support for the Reference Design Platform (RDP)
> 454 based on IPQ9574 family of SoCs. This patch adds support for Console
> UART, SPI NOR and SMPA1 regulator node.
> 
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |  1 +
>  arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts | 92 +++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7b5466395f46..834e790bec90 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> new file mode 100644
> index 000000000000..b3e853a9cc94
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 RDP454 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9";
> +	compatible = "qcom,ipq9574-ap-al02-c9", "qcom,ipq9574";
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +/* In AL02-C9, the max supported CPU Freq is 1.5 GHz. Disabling frequencies beyond 1.5GHz*/
In -> On

GHz*/ -> GHz */

Disabling -> Disable

Can this not be determined based on fuse values?

> +&cpu_opp_table {
> +	opp-1800000000 {
> +		opp-supported-hw = <0>;
> +	};
> +
> +	opp-2208000000 {
> +		opp-supported-hw = <0>;
> +	};
> +};
> +
> +/* Disable IPQ9574 integrated radio's reserved memory */
?

Konrad
> +&blsp1_spi0 {
> +	pinctrl-0 = <&spi_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-mp5496-regulators";
> +
> +		ipq9574_s1: s1 {
> +		/*
> +		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
> +		 * During regulator registration, kernel not knowing the initial voltage,
> +		 * considers it as zero and brings up the regulators with minimum supported voltage.
> +		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
> +		 * the regulators are brought up with 725mV which is sufficient for all the
> +		 * corner parts to operate at 800MHz
> +		 */
> +			regulator-min-microvolt = <725000>;
> +			regulator-max-microvolt = <1075000>;
> +		};
> +	};
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	spi_0_pins: spi-0-state {
> +		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> +		function = "blsp0_spi";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <24000000>;
> +};
