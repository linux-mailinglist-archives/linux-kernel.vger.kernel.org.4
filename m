Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED931659E99
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiL3Xnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiL3XnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:43:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66C31DF28
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so33558970lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ce8sXtLInYl99I5ByWTpCKTjPaoI/Ho1kj93QrNo0Mg=;
        b=NpHhtB97jP2jbL4ovO18e5gkTsKdj1S8OXp6f/dTF2FwU3cqVjdPDP6dVvzuRv+zaX
         6TvlswzGduWkIyw6mcQvT6fYpc6OsCtupRiM3YZCAxorC2u6TNUV8xfS92G6eujoSRx8
         fsWASe+ZpAD+aSrSuqHd2QMAEzF3DIOToPoefDP5kM3C9rSSiuKztqJOF1IpanENsHBv
         9+PlCLIc3Baq5oTANMJ4Mnu5Tr/WkcduA8BoEbG/pF0xZ1SFRh4XsASCBfptdgHeFXTl
         EN23pHpP6Idk86freLfIU3LgeXRkEdLdfZ60WGRJp1Fqn5EZyvpn/meisnBCnPTs/YGr
         eh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce8sXtLInYl99I5ByWTpCKTjPaoI/Ho1kj93QrNo0Mg=;
        b=EQPINddNUg/BdyOSQSAJONIOtdlVcArBUO0XZ+PvK5lbaauskNvxe5BMmPrp8+2RBz
         RHPzCv9ujrVqtDrCsFkpgtHuaOkGWGdqChcpo2V1E1Z81WZVPV2wIdlWDTpnnv2hqnZ5
         BYAJsjV2EEE8sEmf9ScsLxhQOpm17hdh8JAVzy2rGnqzBkfQZcQYsptLXmnXLh7U/1aQ
         PskEnYhQS/pmA2JfVdJLfjeHoVOq8YYQ/09bQbpx/p+adI7aE6uRbz+ouprqq+r2qaUq
         2aVLqZtc3pqp/DCVB5c9TbdeJ3gRPQ9svCG90/UkYxyBIL8p+qS+A0BStSg4ALJ484S1
         GSCg==
X-Gm-Message-State: AFqh2kotEpPesKXkB677Tikp05J918b3WVl4Qh+T/g2mPOi2v+qEbDHG
        UybCHe8jTbdQl5gC2Vsnod3aXQ==
X-Google-Smtp-Source: AMrXdXtBn4FWSFSbDgdkS3hqSxQ+WZU7VLbgH6dS4Z3PJ7RocAGVPLUm9/hi5eyj6Syr9JUGI4+Oxw==
X-Received: by 2002:a05:6512:3b91:b0:4a9:9827:68e8 with SMTP id g17-20020a0565123b9100b004a9982768e8mr11290558lfv.7.1672443796318;
        Fri, 30 Dec 2022 15:43:16 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b004b55da14ba8sm3628163lfr.291.2022.12.30.15.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:43:15 -0800 (PST)
Message-ID: <3fc6398a-f08a-040d-16b5-a6fc1c6edaab@linaro.org>
Date:   Sat, 31 Dec 2022 00:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8250: align PSCI domain names
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
 <20221230160103.250996-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230160103.250996-5-krzysztof.kozlowski@linaro.org>
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



On 30.12.2022 17:01, Krzysztof Kozlowski wrote:
> Bindings expect power domains to follow generic naming pattern:
> 
>   sm8250-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
>     'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 6c7adce6c9b8..b101b7000034 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -677,55 +677,55 @@ psci {
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
