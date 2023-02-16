Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0256991D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBPKjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBPKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:39:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F4B775
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so2174026lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1Uh6UnIr1rZdCAl04sfUqzZT3t6zuycsH5e9znf6i8=;
        b=dscOv1oO2Gpn5k/t+7JAcEkMhchzgACTe3hK4E6j0erBPU4eB7s2tHkq3bPLwMMMT1
         IUMr+DoS14tlxbvcVxssapn9HgHoeA+gFsV0xqxUVcnoaWFkcHq7TZv5PIXzrBBcBBCk
         TabRxWjW+hFdFzBOR8Z+nI/QxIPVCznX8scjOWvG1GKMN/rqEg2oCTZD9L/+GLGYqT8q
         PWxCIMiursPql4nQv/kjkyKQiY5kgXA4y4L+F0aOcwubCdOmzlUrdQe05EXOvj1RpT73
         EQs2NncX25hgsjl7LyC8PRgG5ZfGwch9JHfDKqROxIKBFagdaaNOQ5Lj0IgFfd7Pc+uw
         ZAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Uh6UnIr1rZdCAl04sfUqzZT3t6zuycsH5e9znf6i8=;
        b=JV0rvOOz1fwITiASAI4WxRFDUOBiSI9cM6qsMVfk1OZH0A69TUA8GvBlsvbzSyRAwN
         E7CdI1YKoZl8JEJM3lx4HZhMjMNOKiP1UHLw/JRHhwVlHCi1ciEO1M4WlrvqT/fwDbzI
         8KoPGjRbm99b+0vKtYP8YmKfF75ltkok2THyhieNLhZfSMwm+Tjz8zfBR3zZGbPcf4/D
         frQW2FJtiwmaki/ZX3vGHTb5jfQCxMcAcqsJ1MQ1jez8X78Mmc1VE3G5YrsKpz4CYKYZ
         IoTTF6m7hkeHsznB45yiC3kfGFcltLjq4kcegBBcG0nJ28tKTXkEgThXBqRUbFJ/exFD
         TXWA==
X-Gm-Message-State: AO0yUKVoxvbs5/Ek5jL+BsEgZQV+LqeclSaPsTqr5FYKn4xUsUGUV/bW
        Jqni7/PrK/1mPYiBxdEsM5BkUA==
X-Google-Smtp-Source: AK7set8iml837526dfoScrbhXkJ9NlnSWP+4trFlux9OvGyL4kmCukxICaJuAsccOm1v1Y6bbCrgFQ==
X-Received: by 2002:ac2:5ec8:0:b0:4cc:7ff3:ab4d with SMTP id d8-20020ac25ec8000000b004cc7ff3ab4dmr1587296lfq.20.1676543948996;
        Thu, 16 Feb 2023 02:39:08 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id q14-20020ac246ee000000b004cb08ec4c30sm247919lfo.99.2023.02.16.02.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:39:08 -0800 (PST)
Message-ID: <f066cf9c-ca73-b534-3949-c9e59b676bf5@linaro.org>
Date:   Thu, 16 Feb 2023 11:39:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 09/12] arm64: dts: qcom: sm8350: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-10-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-10-manivannan.sadhasivam@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 0a422637b61f..1b423c42ec0d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -48,6 +48,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -69,6 +70,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -86,6 +88,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -103,6 +106,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -120,6 +124,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -137,6 +142,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -155,6 +161,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -172,6 +179,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo685";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 2>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
>  			qcom,freq-domain = <&cpufreq_hw 2>;
> @@ -2283,6 +2291,7 @@ cpufreq_hw: cpufreq@18591000 {
>  			clock-names = "xo", "alternate";
>  
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		ufs_mem_hc: ufshc@1d84000 {
