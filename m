Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EEA659E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiL3Xml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiL3Xmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:42:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524D1DF1A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:42:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so33543029lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLrnsQ1eOmHmsIwEqP5zlFk//c4n3hKPLBzlzHX1l40=;
        b=DqFk0FZFywhp/wCLw8VMnoe/ydSKS03wJCbtJm2qgyCyTK/ZDls/nU21jIG/+0u72D
         R5BcYfih4fFS2D/po86Ry8Ma5SqMe+BOi84cthfR5y4ScimWvFwUwI5CdQz98W/J4KEz
         QtQjjyvDn4/d8CCfjDrogBgexJFm4up/mutImIoIJ02WF0geX55p1hzs+e4cEVEfY1x9
         cYpYAkLuzr+iaUue/45DSQiRidVrvj+A2myDY24moK9QrVzUVu4npRSKsVzNXfczq60I
         DDFD9etGuuaNzw1+gV8wsYhXcp9gv4cPNZ411PwqpEUrcuvWl/2yI0LdgV66R8d4ZmTK
         G26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLrnsQ1eOmHmsIwEqP5zlFk//c4n3hKPLBzlzHX1l40=;
        b=vmNlP8N/0D7U5/dovhNEbWgV17mCmgC3iCk/QQ2KUJH1XZL3X8FPJ6RAbuP/lmkte6
         i53VPklvWjDyAWAXsBFzWEbHwHmX/xuhCgdW8WUAA8qC2E4BO2VsZRsH3XvVtmB8rtZT
         cSPpb7ZfBX92NVixEWA5KPVDzuMdnhCxwRVVghfzoTUdJsAcweEU60Agg2LRTxx8deo/
         ur3j23ckzwC0TR581S/5JRmiHeuVByFWH4mSpgyMFz5TaXFq0lTdQ+y/2SlW1GvzTNNc
         7GvWvcEgsTDAsVFOCfwK90qfqiOJQDu9fiodKOEGANb8AZ71WfaE//etBHTfOlIB4PKe
         dgvw==
X-Gm-Message-State: AFqh2koqT1BcCRTSWxmh16zxROopQR71EQpEfkXP5wUfCj2yvVNzZiTi
        BTxg5Jy6rbkD6tA+9udSKRUuaA==
X-Google-Smtp-Source: AMrXdXv3OZWrdowYrnbhewO3XRhqIhJjdlklFI8XJ361JT+dRoKkkaaa8MN9/9BliAKCAuRMEy9d+g==
X-Received: by 2002:a05:6512:b25:b0:4b4:b8fc:4ac5 with SMTP id w37-20020a0565120b2500b004b4b8fc4ac5mr10567970lfu.3.1672443754180;
        Fri, 30 Dec 2022 15:42:34 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25f61000000b0049f54c5f2a4sm3660796lfc.229.2022.12.30.15.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:42:33 -0800 (PST)
Message-ID: <541b8ba4-0779-2080-4516-40283e5de047@linaro.org>
Date:   Sat, 31 Dec 2022 00:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sm6375: align PSCI domain names
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
 <20221230160103.250996-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230160103.250996-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 17:00, Krzysztof Kozlowski wrote:
> Bindings expect power domains to follow generic naming pattern:
> 
>   sm6375-sony-xperia-murray-pdx225.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
>     'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6375.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 12cf5dbe5bd6..31b88c738510 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -264,55 +264,55 @@ psci {
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
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		CPU_PD5: cpu5 {
> +		CPU_PD5: power-domain-cpu5 {
>  			#power-domain-cells = <0>;
>  			power-domains = <&CLUSTER_PD>;
>  			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
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
