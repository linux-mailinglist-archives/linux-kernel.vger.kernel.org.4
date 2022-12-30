Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464D659E98
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiL3Xnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiL3Xni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:43:38 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E31DF2A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m6so23160271lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=862I2TD1EQ7J/TWCINRSGRvQqbyFoXTMH97n/yq/UIU=;
        b=tWPX2awYawi+TrH58Kn1D0gbVrXzj9gCb3NsempBw7BXnlcdDWLg6cl8WuKiYc5xrf
         eT5a4Lb08pE27wWTJcbvwb3vyEIft5hQkIclJZSJrReWZH80m3tw/CQTkH0Ve6ZKqoe9
         pB6B+cm6OCQULBsxUhIlvu9RfUTVdrmR9TiDOvqTKo0b+pQUujuVdLtSN2IEMKsoiZnn
         rQN3WVIwsQj2rNHBx3q/aJdOkj7LqQLBb8lgR4CkdIdPec/6oUCg8jlz5M0UC2jdOmb2
         f10IikqXbtCdNN1DYuVDrmIAMme5/hA9XN8lyMBGDkuUFWtYoyAB7yIYRJk6QtHVA+Ya
         dbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=862I2TD1EQ7J/TWCINRSGRvQqbyFoXTMH97n/yq/UIU=;
        b=R/rzg+oCwEqHxARFvxJ9ZPlmjxM1Rfl3h63+j8sEjPnKrXHVTsMqaB6EBvH6EfjQik
         Mv1tlcglnMmK7Jprw/pFtqm/N3iRJvWUuHnOitPpQBZ2QEJOzOMrww1t0B9xIMfdLtXR
         /ln4jGCjo4+sSzX4AAWmUUaeaHwtr8scHR8ToY5kj21mHSaERcIAdEVkW9RuA3q9mLSm
         2exXlWy57oHSJv50JV03P8v3LPvJVoVMXNNOWCWC2CEk44GWRTeO9vGjvtDQzM84f8nZ
         BszdKj4PcGdjseiUWQbl4eYAXZnkFkbC7TdqU0ZJ4BEzCpmJ5M79vj4B530vgcF2MluG
         CeZw==
X-Gm-Message-State: AFqh2kroV9yeTLOtI3de06yA46AK/ygVAPuUBdrjJSdtHDLYmdR9dlWo
        4J9IABpOwM2SOalDm0FWLwJ/Eg==
X-Google-Smtp-Source: AMrXdXsSm5J9QQvMNe7QDx2WtyFboGYDn3NHcaU+z8wWxYHre4hnNNH0dWmegTCjLgwwD4jSetIfiA==
X-Received: by 2002:a05:6512:10c3:b0:4b6:e64c:aec6 with SMTP id k3-20020a05651210c300b004b6e64caec6mr11770271lfg.63.1672443816023;
        Fri, 30 Dec 2022 15:43:36 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512214700b004b57bbaef87sm3643400lfr.224.2022.12.30.15.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:43:35 -0800 (PST)
Message-ID: <036ce9f8-f24d-0255-e623-3612af09cd51@linaro.org>
Date:   Sat, 31 Dec 2022 00:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8350: align PSCI domain names
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
 <20221230160103.250996-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230160103.250996-6-krzysztof.kozlowski@linaro.org>
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
>   sm8350-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
>     'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index a7da48b7e788..743ca0c80ac3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -297,55 +297,55 @@ psci {
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
