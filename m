Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA78F6D8272
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbjDEPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjDEPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:47:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1649E5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:47:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx10so19426335ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709617;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxSZTYnDcq5s93QjGt0L3XgCVNV0CavkH4ScS09zEU8=;
        b=xmb9RSub4xOC3+mtoNF99fZ6KiHrpV6FrYFEALIIG0bYj1LKC7/mqZg9F9a6rnqsNX
         Ha5rht9rzSAvwtTbiRg35h2tGPRgWH/9K6YyN3tDojfpBMi/XhKwiW8pyZrMcqHO6GI7
         eGGJRe+atnga41rSRnRd29rbg/+N0DtPowse9SH+j1zrARQ1vkz6h4pZDt1tl+SyFNhW
         vqpN3V/H2+HcDhZ74UqWm+sJ3I6KAcLovNLJuqf+COCHb/LpaEpXtOvtzP5HexzKstm0
         Pl1he+1oK9i9x0A8frK7bV0Ix6SFwXyNhct3lKNM9iioRRWS8Xahq0IgJhFtdZA2P0o5
         qL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709617;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxSZTYnDcq5s93QjGt0L3XgCVNV0CavkH4ScS09zEU8=;
        b=B/XNu/aAXoIxTk8v7yk7qKC7C7KLCXNfR5uhD5bWFm4dJmO50Y3RmNgCrCb3pYS4dy
         nIWiEStijzfax4sgE0jNd9CEapScj+8qh0TmmsSMUcH7MQI0rnQRXhauxmcVDfbMYX8Z
         Pyxx6Y//kip7pJ8BOkMA/Xun3jBx/gFDA0cfOxs/TCqyjfX/RelJXnR+UyQNVCMWUX/P
         PZWa9uQxya1fKqMjLTDQRdoxX+7IBU2p46a67rIL3mjyagPYLGVfgiqXFtZm6XqOvoGr
         /6gOs2xgI+gtVO9V5B5uxMgvTQe7nRS2+v9mHvk3nqCVY09hbp8MyrDH+HwnXy1L5esn
         4AYQ==
X-Gm-Message-State: AAQBX9fCZyDcAeBaa+wr5O6vGVXuMzmLUFOuqP2RL3yKNIiQ3wplC33P
        pDrf5G3yBbAd0kxemQUppXvclg==
X-Google-Smtp-Source: AKy350YnAa/sHazifyT3J9hcsEFG1SqVCFTYFoilpzg/MpP/TjDc1+ftvez2CGD5umA6Eq+UEcNEYg==
X-Received: by 2002:a2e:9bd8:0:b0:2a6:23ac:4e70 with SMTP id w24-20020a2e9bd8000000b002a623ac4e70mr2383740ljj.14.1680709616858;
        Wed, 05 Apr 2023 08:46:56 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2905499ljg.90.2023.04.05.08.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:46:56 -0700 (PDT)
Message-ID: <4feaadbe-966d-0c2a-d502-e758194bba5f@linaro.org>
Date:   Wed, 5 Apr 2023 17:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sc8280xp: label the Soundwire nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 08:09, Krzysztof Kozlowski wrote:
> Use labels, instead of comments, for Soundwire controllers.  Naming them
> is useful, because they are specialized and have also naming in
> datasheet/programming guide.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index cd38320dafda..c195a57fd180 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2497,7 +2497,6 @@ rxmacro: rxmacro@3200000 {
>  			status = "disabled";
>  		};
>  
> -		/* RX */
>  		swr1: soundwire-controller@3210000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03210000 0 0x2000>;
> @@ -2572,13 +2571,13 @@ wsamacro: codec@3240000 {
>  			status = "disabled";
>  		};
>  
> -		/* WSA */
>  		swr0: soundwire-controller@3250000 {
>  			reg = <0 0x03250000 0 0x2000>;
>  			compatible = "qcom,soundwire-v1.6.0";
>  			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&wsamacro>;
>  			clock-names = "iface";
> +			label = "WSA";
>  
>  			qcom,din-ports = <2>;
>  			qcom,dout-ports = <6>;
> @@ -2600,7 +2599,6 @@ swr0: soundwire-controller@3250000 {
>  			status = "disabled";
>  		};
>  
> -		/* TX */
>  		swr2: soundwire-controller@3330000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03330000 0 0x2000>;
