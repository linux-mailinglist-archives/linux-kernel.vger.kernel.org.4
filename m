Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB96991C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBPKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBPKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:39:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BD7D8E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:01 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x29so1514935ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHwmWTNtOB1ulNHnV3goGyUCU/9M0hLT9M++kJtBc1o=;
        b=PmQyGCm1Dp4aA7RJSkj+BJg0rCSzFadjtCjXfaVUsiteVIawMPFW0uwOgdP6pHDwtf
         /qFaSn2JCUxrWsTPUXOQtbL2XnuTUjWrJL9+4YVf04IrNbYDnVG/SWTKdJ/r+EBsXRDR
         a2gpvoAPfZlxSFSn0s6I5P2hfj9Cyv+5lzdCCvEDuUr1gqMmP1d4RXv14uV2Kra3UPHg
         uNkm9M1ieIcu8WtVD0UHR8wZR2ls+8RMlpn02J6WqoBneqIqvYZY+FISochNNekbZ/7I
         jZCa92GDYYkVg6GlT6phypMN8XIG48AKsrFdBgnbqTdNIyP6q6uUC+d5VKrRP6gdn831
         VrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHwmWTNtOB1ulNHnV3goGyUCU/9M0hLT9M++kJtBc1o=;
        b=gesC0WySa1i+C9WsZMlGivEM18F8vXuQBKL8KVOxyQvFryi8mLKzMARRXNQzlXhqyd
         7E1I10Zqygdg3KgJCR4cv5vKHAna37NzKwdIQoGFYIqTFsFDqeW6aXS+HLziR65ZfGtk
         Z08xu8pmzSo8ToRPGJoFIZnssKgwe3cblX2WEh3h0uaNXyopOeL8yePqITIHC7WqVsda
         czhqHyDE81JSh/ZteWAYqprH5Ysy1PVREs7R4RJA3ofWVf1wkhDEMte0J+c8S050Y42O
         ZN9cawjHbfJBQLq9/+zj2zxo9mDwGSxiFl7k5V8AlHpBg4+WFQrn5jg3aWEEhYAiA9dN
         bWXg==
X-Gm-Message-State: AO0yUKVFaRzbSDavVfY8ktb8dlLAkYwWs3ZHDP4iIlo627/MSptQp0O3
        6DEDpcymN742L3FDUVD18vHPkQ==
X-Google-Smtp-Source: AK7set/UoKrYY4i2p2YWmdZm1jiw7t0IJEsVD5j3+hW4F0/PZ/dKZhXWTyZYh8xYYTmAEcwIv9hI2Q==
X-Received: by 2002:a2e:2c1a:0:b0:293:1565:4353 with SMTP id s26-20020a2e2c1a000000b0029315654353mr1635739ljs.10.1676543929912;
        Thu, 16 Feb 2023 02:38:49 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e2e0a000000b002934b8d115csm142380lju.51.2023.02.16.02.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:38:49 -0800 (PST)
Message-ID: <12e891b0-52aa-c5b0-e048-0830b0065233@linaro.org>
Date:   Thu, 16 Feb 2023 11:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 08/12] arm64: dts: qcom: sm8150: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-9-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index fd20096cfc6e..693d023d2629 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -48,6 +48,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> @@ -74,6 +75,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> @@ -97,6 +99,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> @@ -119,6 +122,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <488>;
>  			dynamic-power-coefficient = <232>;
> @@ -141,6 +145,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> @@ -163,6 +168,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> @@ -185,6 +191,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <369>;
> @@ -207,6 +214,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 2>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <421>;
> @@ -4273,6 +4281,7 @@ cpufreq_hw: cpufreq@18323000 {
>  			clock-names = "xo", "alternate";
>  
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		lmh_cluster1: lmh@18350800 {
