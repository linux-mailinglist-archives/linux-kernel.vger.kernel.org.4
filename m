Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D56991D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBPKkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBPKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:40:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B9F252A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j17so2242688lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL42bsRHEUJtEtWn/UTVJ+freKBFdp/B09z6m0okci8=;
        b=gvhWe1g9FNTqvMEcFCzQvCICHh4QeLAej+BV8tNvZdFfz6MJTWcdD4BQ1cGrkC8mI2
         NpUF2kPQhYzCfvKi197uvJLlitAfTj0VOfn3HNvUaFEKqWCLj6jTyLs45/uxGUCK2T9f
         Vagfo3qN5ZmeJJowDeYP1L2AdPCSeO9Imf9Lh0sEgYX8YrL0V5mTj5k7wee7Kz5mGMgv
         btMULiLL10C+dsGAW1YW6keemgznJcTg67Q4XKpZaLexoiTkfiUQVZF5g4q+KHE/9c6E
         jNfhjeM0k681Wp9DN4djJ4TKL38meO+dqOES+zsxLQzaHYqKI/AqYRn9Tcv+ItSg60Mf
         0NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL42bsRHEUJtEtWn/UTVJ+freKBFdp/B09z6m0okci8=;
        b=BfkMN8nP+d83K3iNv6ogQ0pfihTtn7gN7dwAXPt4NJuaXSfwVGWRqvIlJBTRkvuazw
         d/gi9VBFppW5kaZXMaklUJ1uJBsdJtvHQAuU5UW595+zDPB4pIEjsKXK7swqC9ImHfao
         IpkyVz9CUE0IKssxwZnKzeH5nxy+Tpw1ERPaLbXITvn8oKX+Pen0NPxiSoD9MdGsECwm
         LtxzllolIy6Dl/088FFVydMjt6K4UxL4HzPfjKZMKnTfl/zSSVE6VCsuVYQOBjSeJqg1
         kkS/wEyWfNpT3id13lu4VylIM42DWYKZiIpkjZjZk1LN2dSg/QyG3J3pAqDHPMGjD3j5
         JvGw==
X-Gm-Message-State: AO0yUKXrTh1rKtD1huqpAUzlp7lXn3/1qf+/lSw8g27j0230r49l8cfB
        PYcjQ3rGyBLPfcjIzWVwbUZMhA==
X-Google-Smtp-Source: AK7set8vVvoh8Wm2b9RTMy1wgzJ2mn0+dDugPdu3Wz9clJoJwYzFG7ttbYcOzNYJrD5qEMW8i2ALVQ==
X-Received: by 2002:ac2:4898:0:b0:4db:3605:9bd3 with SMTP id x24-20020ac24898000000b004db36059bd3mr1306523lfc.17.1676543974544;
        Thu, 16 Feb 2023 02:39:34 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w18-20020ac24432000000b00498f23c249dsm245461lfl.74.2023.02.16.02.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:39:34 -0800 (PST)
Message-ID: <cb69610f-88df-5660-34f8-b1141d12ea15@linaro.org>
Date:   Thu, 16 Feb 2023 11:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 10/12] arm64: dts: qcom: sc8280xp: Supply clock
 from cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-11-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 08:03, Manivannan Sadhasivam wrote:
> Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
> to the CPU cores. But this relationship is not represented in DTS so far.
> 
> So let's make cpufreq node as the clock provider and CPU nodes as the
> consumers. The clock index for each CPU node is based on the frequency
> domain index.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 813fb168801f..a1eb9e333699 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -45,6 +45,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <602>;
>  			next-level-cache = <&L2_0>;
> @@ -69,6 +70,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <602>;
>  			next-level-cache = <&L2_100>;
> @@ -89,6 +91,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <602>;
>  			next-level-cache = <&L2_200>;
> @@ -109,6 +112,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <602>;
>  			next-level-cache = <&L2_300>;
> @@ -129,6 +133,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_400>;
> @@ -149,6 +154,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_500>;
> @@ -169,6 +175,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_600>;
> @@ -189,6 +196,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			next-level-cache = <&L2_700>;
> @@ -3875,6 +3883,7 @@ cpufreq_hw: cpufreq@18591000 {
>  			clock-names = "xo", "alternate";
>  
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		remoteproc_nsp0: remoteproc@1b300000 {
