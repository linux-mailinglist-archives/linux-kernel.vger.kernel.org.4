Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6E6DDB50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDKM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:56:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56BC40C8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:56:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e11so10220887lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681217769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p59U/MidztXKvUHX3x4iKgmMCkXfcEm0tuGKGeli3EQ=;
        b=cucQ3h4DO0/QUJTeJK2Z6K1Y3AmBhtS9dIxDq9CZh2AOpGfoRVsKwU35FBq616tuED
         Z6Q1cB1nEL0g+1qHs6Zdhn4YNWSm2HXqpjjxmbmDshXZ8T2Jvan1Q2b3cA0kR0hmPkko
         asEGupj1WPZ43KapY4CTBn0ypdDXnlbRR1jOlakm+yFaR1mwq7MHf4qDSfuERBm/bMSI
         OaI5gps5unremrp0xfuMx2HO0EsSxZ3a+SZewcQ7Pel99vKUQAXvxrYWNfLiVN3PFtFX
         TXz6JJy1vUJNHeBQbDG1gSHkCs0Pmo8rBwBfMO4D7VwliY9YTXfblA4vNCoCbw2NkgSB
         VQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p59U/MidztXKvUHX3x4iKgmMCkXfcEm0tuGKGeli3EQ=;
        b=LlLLmJK1AZN7IhbmF2WwJTOLraqOwwC3z4DbbQf8xxxRDSew3vid8bWrzlBVD7E3k5
         eiiDOZsCGY7TCGrG7E4VgRlQC1ifwHvJwwDECejm4WjPqBxI/pMSnFOMWt2AUk0Q4yvc
         gWfH8kWwrHBxwiLJ6+2uvcOaBtg4XWCXXkfRvAyLJJeuYKa5pI9AaXEzL6/PqY3/3w0j
         bwdemiaAJGoj6oM/EWG6oenQNYg564QQUKsxHSUOA2ryCOHE87Hn1IDDIGvCZYkj2mjD
         lVKFqYJ3ZO3Isna8MPqvTOkqSqawTqTU3tQcTV5BeoHIQqKu3rpnSKLFKUC0pAC8PjhO
         81Yg==
X-Gm-Message-State: AAQBX9cWgh1idmgoWFIKAmK/59EK7ceG/AogKK3RjOh7kaLLmXNfR7VK
        YC8lMGny6cTfS6w3WYpriWSMcQ==
X-Google-Smtp-Source: AKy350a/nlAv6EQaVMDDtX7UwvD9JRmUg+BukSidmParaor5epxiPNDYQWuKjpm8YL65cdtci6mT9Q==
X-Received: by 2002:a19:700b:0:b0:4e9:cb57:8fdc with SMTP id h11-20020a19700b000000b004e9cb578fdcmr4049342lfc.46.1681217768995;
        Tue, 11 Apr 2023 05:56:08 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25a47000000b004e846175329sm2522743lfn.202.2023.04.11.05.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 05:56:08 -0700 (PDT)
Message-ID: <9130c1cb-4081-b21c-7c1b-2e0c9879e66a@linaro.org>
Date:   Tue, 11 Apr 2023 14:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-3-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411072840.2751813-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 09:28, Bhupesh Sharma wrote:
> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
> 
> This adds debug uart, emmc, uSD and tlmm support along with
> regulators found on this board.
> 
> Also defines the 'xo_board' and 'sleep_clk' frequencies for
> this board.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 +++++++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index e0e2def48470..d42c59572ace 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> new file mode 100644
> index 000000000000..c9c6e3787462
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
> +	compatible = "qcom,qrb4210-rb2", "qcom,qrb4210", "qcom,sm4250";
> +
> +	aliases {
> +		serial0 = &uart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
> +		vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
> +		vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
> +		vdd-l6-l8-supply = <&vreg_s5a_0p848>;
> +		vdd-l9-l11-supply = <&vreg_s7a_2p04>;
> +		vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
> +		vdd-l12-l16-supply = <&vreg_s7a_2p04>;
> +		vdd-l23-l24-supply = <&vph_pwr>;
> +
> +		vreg_s5a_0p848: s5 {
I think going with pmicname_regulatorname (e.g. pm6125_s5) here
and adding:

regulator-name = "vreg_s5a_0p848"

would make this more maintainable.

[...]

> +&sdhc_1 {
> +	vmmc-supply = <&vreg_l24a_2p96>;
> +	vqmmc-supply = <&vreg_l11a_1p8>;
> +	no-sdio;
> +	non-removable;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
This comment is still pretty much spam.

> +	vmmc-supply = <&vreg_l22a_2p96>;
> +	vqmmc-supply = <&vreg_l5a_2p96>;
> +	no-sdio;
> +
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
> +			       <49 1>, <52 1>, <54 1>,
> +			       <56 3>, <61 2>, <64 1>,
> +			       <68 1>, <72 8>, <96 1>;
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
This is not the correct SE for the production board. People
booting this will get a tz bite.

LGTM otherwise.

Konrad
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
