Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE86E9157
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjDTK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjDTK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:59:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA258698
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edc7cc6f46so476388e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988199; x=1684580199;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JItaNzprm4HFYrhw4bwOLtcJNsYYg9Vq3+YNSfZSbMY=;
        b=Scm9eYTNdkpaAYK0O6jhuvKjrG0c50HAjukJ+GI+1u+klvfGKx4ikRxD8jruKj8gIa
         tsx3956WMeH5Y0HfNmB2BNnaUKDbiyjm63p3+oEVrF2ps89Aqp2l8Bg5QGOfQdmR8it9
         NpZFLfYXx+iULuwiQ0kDuHUk0Ki19H4gFeHpmzECMteSsbUVXowdbgilpjXCVti/r+9V
         xkDtwdN2Rzv9VLbqPHuOWoQ9kXIB6Rxhk3yGHAj4CHJc9i0zVpIodrsOUD7dXF6r9VC2
         2jce8xz1fM2EmikHCpNXOAJJ2K4wpH9t+igAhxm+48r+VS6diOpfGH4tx95dmnrgU9GS
         7faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988199; x=1684580199;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JItaNzprm4HFYrhw4bwOLtcJNsYYg9Vq3+YNSfZSbMY=;
        b=f5D/FuHgtL3OJ2sTGcELFvthQGis42z7lenPTg8iOqBcsNQXIZFTaHq4yISRs4BZD3
         NqRrD1ZmC5Ws9FRXfO0O1x9vovLD1AmybvLpS84GYAPLMLgm9YOm/MVAn5tq/AQjfcBD
         +oRMNCT9k/P2eMEloMj/j3WpIC4bz7T6cRB0hTD/F4bLRHFKky0GnBs33Z0bg7beqm1E
         5FlZ74HcbWE/0WzpONmMKKZWL+le0afZHHXxcO0mULAC9Bt5l/lgXSaR7G7mxTtb746T
         fBscG4E2bvncgnOVTkB4bz5rEfyf1Djak4crdzEIzSD8KH0akEJOxqnOG9/zfGdOJApD
         AAqQ==
X-Gm-Message-State: AAQBX9ff74k/5dBvZ4xaeiLbTr2plPEKZw0kGGrZ+LPGrbjG1UQzBbcd
        GKKORLgZWZcJLSaQvH6DT9U5nw==
X-Google-Smtp-Source: AKy350Yko0p459Oj4pTbmoWkeSSSZcbJyUaXz/WXKgzEeFNo5hvcTdolvJSXyF/Cbcm/3YrZkNtwXQ==
X-Received: by 2002:ac2:4a8c:0:b0:4eb:982:adf with SMTP id l12-20020ac24a8c000000b004eb09820adfmr331502lfp.26.1681988199408;
        Thu, 20 Apr 2023 03:56:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24828000000b004ecad67a925sm179625lft.66.2023.04.20.03.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:56:39 -0700 (PDT)
Message-ID: <5c27d6f0-fe0f-c321-58b9-7d4205f2f544@linaro.org>
Date:   Thu, 20 Apr 2023 12:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 16/18] arm64: dts: qcom: sm8550: correct crypto unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
 <20230419211856.79332-16-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-16-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc@0/crypto@1de0000: simple-bus unit address format error, expected "1dfa000"
> 
> Fixes: 433477c3bf0b ("arm64: dts: qcom: sm8550: add QCrypto nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 43192ef21aec..90d2b7057b75 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1858,7 +1858,7 @@ cryptobam: dma-controller@1dc4000 {
>  				 <&apps_smmu 0x481 0x0>;
>  		};
>  
> -		crypto: crypto@1de0000 {
> +		crypto: crypto@1dfa000 {
>  			compatible = "qcom,sm8550-qce", "qcom,sm8150-qce", "qcom,qce";
>  			reg = <0x0 0x01dfa000 0x0 0x6000>;
>  			dmas = <&cryptobam 4>, <&cryptobam 5>;
