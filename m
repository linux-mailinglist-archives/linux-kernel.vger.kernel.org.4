Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAFE712E55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjEZUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEZUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:45:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9CA134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:45:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so1330695e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685133919; x=1687725919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQUsiUc283EYxtE5Hqiz7rkWe3kMRurlGcOAgw5fyIE=;
        b=MljjUl+Kqw50p2r/VrjVx80JauF+5TGhIvHb2vi2vnRRzEcWKSfNIGTNYhV68ceBj8
         yFAOJcV/FDNcd84TpcYfjUciCy55uo1yNRTJjr7JTqT8XV3LpzTPIGXM/TAFThTghnn9
         h1vpEtC1JTkXfnEEqoZXIbAOpaDn6xu8w8HV0vT236dJZyImq8wPmLK/MxQZRI+lyH/S
         6nyVACqE69v9aepMWqSbWjEeNECatICyGYy+TpmAAlMHSgXPwYVtLRklUqyACd3MQdzU
         64ofOZ2Hb5rE2ni1cLeYN3pLq7LSnZNg2N2Y1GjYFwzxYbQ9w0JTSyUrU5qB1YegHNYM
         MYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685133919; x=1687725919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQUsiUc283EYxtE5Hqiz7rkWe3kMRurlGcOAgw5fyIE=;
        b=dzCE/x/1PZn7HH96psIvv8dSmtooBkCK6QMEfktyFMc6HUR7jrzFdlpqAycXfXqIFW
         IEeFdQmfUdJekXXRue8V/iv/QlPJQorYiKzu6+yI3yHafL8dlZ6hrlrzejewh2F5D1ac
         bjDJHGQQGmdx3b7N8oWcd/QwSINYojlY/9NN7mHj6faxB8JKmNyPoZcyTedPz1AmT2Sp
         kJPmJvBxxcbvTRkbmIlOgp7xtw/HODukuFFFwW7t9EgKFs9B5KuEtkcMQtYkXZaLcKeL
         HTKsr5uGYzhbDpUOSL1/Ifqavdl+s6Xjdgr3lqPpAV42lzhodeN4/bG5A8F+W9uerBmH
         k9Zw==
X-Gm-Message-State: AC+VfDyAXL2Xyq1lRdx4D/DHqdAvS6L8zvj5BagQuYvV5B6zexezLxE9
        AE4XF1iR6qZZmGGOHz3vU/Nk4g==
X-Google-Smtp-Source: ACHHUZ6K/jZkIcAKfF4chTZsej4kPLtI4mwpztHg0Mrn5NNxpOZtb0oH+alw8UzI6F24gQDiI7UjCQ==
X-Received: by 2002:ac2:514c:0:b0:4e9:a3b7:2360 with SMTP id q12-20020ac2514c000000b004e9a3b72360mr1060267lfd.8.1685133919035;
        Fri, 26 May 2023 13:45:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id j5-20020ac253a5000000b004efae490c51sm769770lfh.240.2023.05.26.13.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:45:18 -0700 (PDT)
Message-ID: <61e81ac1-d7e2-a909-2e39-dad315acf8fe@linaro.org>
Date:   Fri, 26 May 2023 22:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for RDP453
 variant
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230526153152.777-1-quic_devipriy@quicinc.com>
 <20230526153152.777-3-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526153152.777-3-quic_devipriy@quicinc.com>
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



On 26.05.2023 17:31, Devi Priya wrote:
> Add the initial device tree support for the Reference Design Platform (RDP)
> 453 based on IPQ9574 family of SoCs. This patch adds support for Console
> UART, SPI NOR and SMPA1 regulator node.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


BTW what's the naming scheme for IPQ?

IPQabcd

'a' - tier
'b' - 0/5 - network generation dependent?
'cd' - model

?

Konrad
>  arch/arm64/boot/dts/qcom/Makefile           |  1 +
>  arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 80 +++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 834e790bec90..56ec3d84ad43 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> new file mode 100644
> index 000000000000..f01de6628c3b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 RDP453 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
> +	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
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
