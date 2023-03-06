Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434986ABD32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCFKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCFKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:48:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2795FA5EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:48:11 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi9so12142026lfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678099689;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73e/WG+VtnrvX7x6kSatJeWNroVFqRjNmAN7uDkkbYI=;
        b=c2eyF0FmWZnLgG5KJrO1gdMI2S/wuSRsTcqMUQh3arsVFLq+jgl7cDW9he/r9UrzcW
         a7D0fd77BJT+baZzFb/kBL5IYeYGUiBOFR5wqwVq1TtVaLveRhcvAZmWo6FXZiYme/Ao
         o4Yf5AU5gZlVrloFyAk2UrZkfCURcR3VX7+TpnSmkD1KxNBlZMriN9wdFnFH3l4dQl69
         2LDS+rk3CMRjqHCYmiUcNcJbEG3H+/ZUtnBYYM9dHMk2wzABj8wY36SCd9zpxRCrbYun
         e2HzsWyK5x1XTQacDrlVJcFATAmZmDZhmDx0Na96zEDHhf4dJbfJz/jWOBJVDei5BRLi
         5ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678099689;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73e/WG+VtnrvX7x6kSatJeWNroVFqRjNmAN7uDkkbYI=;
        b=wfs/VRAVYg9Dh6Yh9sspnMxCBjI4vgunGNBBFxb4gT6SmA7Zv+GVxjJ+1CBCIeJLt0
         YPZYQjeL65RZGqvkOIMER+qrgKc6fj8ValfAnzwo3sg0W2qxQ4UOwkC4+X9eATPhJyIO
         vRdjEUyU2EmriFe2Tg1Q5v37Cp5DhT9QfMfDsNDM0oRcBvQg170r3twtVWk+OWPBkRsk
         bxiSRc4zL2xzYKI+UhrJrsEXMlLMmWzYHymp9zNEaIQqNdyIsMf++uD359pfwEFAu8a2
         zFh24L/qL0a0kLyWI5OTeHeXcxmRpmXFNTI7Op+Qp5fcHlVuaqS8Er170T4DhwPpe22T
         lJOg==
X-Gm-Message-State: AO0yUKVBQVyU0LtOn0V+t281hnLUYBGSr4QsA8t7lUeZg+Ny5CaTkCf0
        JzwbkndDy16jcmyKXZhxcHyIuA==
X-Google-Smtp-Source: AK7set8bgSRTuS7uzz0ybq7yYc0bzPK3ua9+Yn3qHHr3aDONVkRQFF8o09aTDtfA09P9fmalm999Dg==
X-Received: by 2002:ac2:4886:0:b0:4dd:9fd8:3a36 with SMTP id x6-20020ac24886000000b004dd9fd83a36mr2987227lfc.1.1678099689400;
        Mon, 06 Mar 2023 02:48:09 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id s17-20020ac25fb1000000b004cc82b70809sm1587399lfe.150.2023.03.06.02.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:48:09 -0800 (PST)
Message-ID: <353565dd-6802-b0a5-c5d6-3833d3c9eb4f@linaro.org>
Date:   Mon, 6 Mar 2023 11:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] arm64: dts: qcom: drop incorrect cell-index from
 SPMI
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 13:59, Krzysztof Kozlowski wrote:
> The SPMI controller (PMIC Arbiter)) does not use nor allow 'cell-index'
> property:
> 
>   sm8150-microsoft-surface-duo.dtb: spmi@c440000: Unevaluated properties are not allowed ('cell-index' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 1 -
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 -
>  arch/arm64/boot/dts/qcom/sc7180.dtsi  | 1 -
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 1 -
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 1 -
>  arch/arm64/boot/dts/qcom/sm6125.dtsi  | 1 -
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 1 -
>  8 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 62d05d740646..f769e63c955c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -397,7 +397,6 @@ spmi_bus: spmi@200f000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		sdhc_1: mmc@7824900 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 2d360d05aa5e..712f80fc865c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -809,7 +809,6 @@ spmi_bus: spmi@200f000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		sdhc_1: mmc@7824000 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index adf7258b3269..d450fe69fe33 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1993,7 +1993,6 @@ spmi_bus: spmi@800f000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		usb3: usb@a8f8800 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ebfa21e9ed8a..51bb0a2f25ef 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3280,7 +3280,6 @@ spmi_bus: spmi@c440000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		sram@146aa000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 5827cda270a0..72d9a12b5e9c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1189,7 +1189,6 @@ spmi_bus: spmi@800f000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		usb3: usb@a8f8800 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 479859bd8ab3..dc43e438b64a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4924,7 +4924,6 @@ spmi_bus: spmi@c440000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		sram@146bf000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 65033227718a..fd577eb705f8 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -1134,7 +1134,6 @@ spmi_bus: spmi@1c40000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		apps_smmu: iommu@c600000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index fd20096cfc6e..f89abf131e01 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3935,7 +3935,6 @@ spmi_bus: spmi@c440000 {
>  			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
> -			cell-index = <0>;
>  		};
>  
>  		apps_smmu: iommu@15000000 {
