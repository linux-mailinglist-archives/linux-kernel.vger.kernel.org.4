Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C76569CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiL0LTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiL0LTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:19:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA0AFD6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:19:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bf43so19210334lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9nrjlYiy/vWImxtO/AVSnSHUaNLd3pDszdmeAktSk8=;
        b=rcgMJHaSKcCnqFmhBpD1k38GYZdyCNFCNzIlYzgrk5BkwD3pjxkPb5jlGUCX1oC57t
         jiXdlhSDzCAJ6DSuEh9hBsgmc9Wdp7a8yz6584NL2KdHwJEee/pnq/q53MRsCf/aBeMd
         xHiuUdI7HSYA2m1Nxh5pxxZEqsDzY5MefxnDNw13QUD0fQuBz7gspGk+xHrjlwQzfZlJ
         DlCSlC49QKGGjT8PO/K/U4IMcmt2/D+JMtXaByopTpPMGdVXf+7qa211pbP5f4z+mwz9
         VKxvdSQCtFxn5PA/5hrpYWMOjR6CByEsk8EoJGWPnDVEWHgESpKByWRUWufyMOQZVOSY
         tnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9nrjlYiy/vWImxtO/AVSnSHUaNLd3pDszdmeAktSk8=;
        b=UYPWX936tiMyq5w3tXf9Wtjhe4hCqnFnnrr+Ai2b3QkMR/gRwUTST0d6XMm2CPUmo9
         4cKe9iHkX1NydW+I6CJdBPMKT8EH/G7anDSbX2hCfJTCA/poTNyRegyerO8sOISwMBtV
         NxrqA1i8PEm4Jnb2DS+A+BuUk8MDzU4tVSID8suCFubjF/LFT0aIMbhZgkRhEUbX99bN
         I1WT2TkyFJmHxEDYdiLJP3MFge5zOr154ITgcjdB97xbEtWgyj+AOSSZetEf7uggpEiP
         Pdapff+18wMRRemI/zXBeVaNLi02qCS5zxKaPhmIyDu2PJ4HCbWmsIkNv+3gZH4luehA
         wl8Q==
X-Gm-Message-State: AFqh2kqXSeRU0rPMxid+btVIhwZLyENN+Ti5/aRsnRiHZJO1BXgzPmRp
        wbzn4zqlXiZjsYkTvmZe4XQa5w==
X-Google-Smtp-Source: AMrXdXtIl1pRlqr0CKOuy8Uq8DyPhVO4MUPow1HHUkjb9bj/jswV8KdzR70HtMuqOZvjux4XWa/OSw==
X-Received: by 2002:ac2:47f5:0:b0:4b5:adf4:7192 with SMTP id b21-20020ac247f5000000b004b5adf47192mr6498013lfp.17.1672139968248;
        Tue, 27 Dec 2022 03:19:28 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512214700b004b57bbaef87sm2202046lfr.224.2022.12.27.03.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:19:27 -0800 (PST)
Message-ID: <4f4b0f99-8538-22a5-1e77-9ce7a4b6e1de@linaro.org>
Date:   Tue, 27 Dec 2022 12:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: align OPP table node name with DT
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
 <20221225115844.55126-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221225115844.55126-2-krzysztof.kozlowski@linaro.org>
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



On 25.12.2022 12:58, Krzysztof Kozlowski wrote:
> Bindings expect OPP tables to start with "opp-table".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi      | 4 ++--
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi     | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> index 5728583af41e..929bdcd45d02 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> @@ -19,7 +19,7 @@ / {
>    * features get enabled upstream.
>    */
>  
> -gpu_opp_table_3_0: gpu-opp-table-30 {
> +gpu_opp_table_3_0: opp-table-gpu30 {
>  	compatible = "operating-points-v2";
>  
>  	opp-624000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> index a88452c20d05..4a990fda8fc3 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -10,7 +10,7 @@
>  /delete-node/ &cpu4_opp_table;
>  
>  / {
> -	cpu0_opp_table: cpu0-opp-table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -92,7 +92,7 @@ opp-2246400000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4-opp-table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 109c9d2b684d..89004cb657e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -33,7 +33,7 @@ sleep_clk: sleep-clk {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0-opp-table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -123,7 +123,7 @@ opp-2438400000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4-opp-table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -591,7 +591,7 @@ CLUSTER_PD: cpu-cluster0 {
>  		};
>  	};
>  
> -	qup_opp_table_100mhz: qup-100mhz-opp-table {
> +	qup_opp_table_100mhz: opp-table-qup100mhz {
>  		compatible = "operating-points-v2";
>  
>  		opp-75000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 65032b94b46d..ba48adc01170 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4619,7 +4619,7 @@ port@1 {
>  					};
>  				};
>  
> -				dp_opp_table: dp-opp-table {
> +				dp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-162000000 {
