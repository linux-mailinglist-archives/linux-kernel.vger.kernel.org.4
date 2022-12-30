Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C6659E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiL3XnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiL3XnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:43:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F391DF34
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f20so23386822lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFs2IesDQ4Y5m5snUaF7yicHMcvliqmR/kjI4vjDJQU=;
        b=DKE+GotVJXCc1ZhLPHVsy38NaPAlJW8lw1uoPNTFCey9VfV60bjzdicxvxtByj4ze/
         DdUltsee6v6dLKXTVm+gDyIb4sjf7RezjwKRGlBkl7eByDZxEIgNM9jqZXrgUrm2MabR
         n/Q7jnoFQiPLCgifZx8pj7HVRwHNvV/Id/UsLVGZkcn79kHhstTpo5GXexHdjtxHJrjG
         HEIUTD06qZxabpIvdcKTdNU8bDx9uwHFMJJAxO6+KXQhxSNm4p3UqJCfH9XBZsIl8zRS
         rNhI53+AFnQNaqje5ZorFWM8JftyuFRp6FRpGlS4yN/i5P+Gw9RkQeG3eT3XP0J5yozU
         mVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFs2IesDQ4Y5m5snUaF7yicHMcvliqmR/kjI4vjDJQU=;
        b=iZblT5pxHpL6QZzf5osJ396R6/Fpp6BBDkmrMd2Oy+aZwWpoaEhjuWjLD8TdXa9oy2
         FBCoZx+5EA+bFNZwEWW9ZPmxcVCeUufrX/2emUWlIhY6qrokDm5x+LQ+QYrGBxOpH4bL
         wimEQurEx3M08/jypSg0wn7VfVBLkR1u2iW5faaLxpG1E0TrAC1nYhzwxQssq1gusaqV
         QeQjKScqAl4ZMr1Wx9bDAVrmVh/J9Ook/7ldic+jPfZ8b3saxfSQ5FdcHPyYGwHg+p+r
         NOm8RItXlMAgN59es7RjsPh5GezmPm+dryM8gITuyO3JySfAy3ZMLoSLSNG3vaFs9Msb
         S9VA==
X-Gm-Message-State: AFqh2kqyfOTKMMX/J7y+1D3n+VW1pPyEmKgzJllkJTjd+Z8QcRfmZYOX
        iYqCPSecfrjoDtDxB+zHHy5SIQ==
X-Google-Smtp-Source: AMrXdXuMdzUclCQcrnUhnLS/0DT60ozKAR2/vT9tRMlSFh72eQ5lAsAeF6Sv1iD3JX54+1tVXPdAkQ==
X-Received: by 2002:a2e:b5c4:0:b0:279:dc94:4670 with SMTP id g4-20020a2eb5c4000000b00279dc944670mr8091515ljn.16.1672443779352;
        Fri, 30 Dec 2022 15:42:59 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id w4-20020a05651234c400b0049d0a98f73csm3620483lfr.154.2022.12.30.15.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:42:58 -0800 (PST)
Message-ID: <78774951-caa3-d5c8-c4aa-2db6bc1dd4a5@linaro.org>
Date:   Sat, 31 Dec 2022 00:42:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sm8150: align PSCI domain names
 with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
 <20221230160103.250996-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230160103.250996-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 17:01, Krzysztof Kozlowski wrote:
> Bindings expect power domains to follow generic naming pattern:
> 
>   sm8150-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
>     'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 5886710b3c65..08f8ff359b84 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -610,55 +610,55 @@ psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
>  
> -		CPU_PD0: cpu0 {
> +		CPU_PD0: power-domain-cpu0 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD1: cpu1 {
> +		CPU_PD1: power-domain-cpu1 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD2: cpu2 {
> +		CPU_PD2: power-domain-cpu2 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD3: cpu3 {
> +		CPU_PD3: power-domain-cpu3 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD4: cpu4 {
> +		CPU_PD4: power-domain-cpu4 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD5: cpu5 {
> +		CPU_PD5: power-domain-cpu5 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD6: cpu6 {
> +		CPU_PD6: power-domain-cpu6 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD7: cpu7 {
> +		CPU_PD7: power-domain-cpu7 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&BIG_CPU_SLEEP_0>;
>  		};
>  
> -		CLUSTER_PD: cpu-cluster0 {
> +		CLUSTER_PD: power-domain-cpu-cluster0 {
>  			#power-domain-cells = <0>;
>  			domain-idle-states = <&CLUSTER_SLEEP_0>;
>  		};
