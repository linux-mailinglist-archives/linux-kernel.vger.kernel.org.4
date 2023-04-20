Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89E6E9120
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjDTKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjDTKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:54:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5230658B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so4011621fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987923; x=1684579923;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vyyE/47mJulpJLu8DqqFKha4qSGs/Z9UKpwUHI8gTY=;
        b=TK/ktyymdcTw4seyT+uhNJDv2JjGGagkYptn2JnRXT1InQ5XlwEG/josDDGOn6duIj
         XQI8SSg4fGNX3WAx5y7BwaPQDiMJpnN9rM384I8kDxVoPa5yy2hEwX6YXrlAsO5kdGun
         +pv+6AnapTlJfd/OZtaYQYsKXtTQ0yQ3/WF9OmXVPyhBu6T3yBxXW094ED6d7RUPy/mo
         sDbP5JB2ETHe7PKWosLdLhI3bFup2isndGoEsqvC/iVVTGajO5E06iIAgetcPaaUpf2b
         M+Kz9rHI8jPPO2wMQRLYbR6DLcBlbdcarHs3RWXERo3PdCaGb/d3mSvDVHAXgVi2EnDQ
         iNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987923; x=1684579923;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vyyE/47mJulpJLu8DqqFKha4qSGs/Z9UKpwUHI8gTY=;
        b=YQEC61+O4jGyeAVQ1KWCyoI8WW4MHIUSe9O/M2Z6uW5Tgq9Xv4GYJuu/tQ/cG0JfFC
         wZvYvVW4rSq4PWcUDsc83uioUzxlVLcG91kuGsURT/k7umxf06WH7v2XwUohwMkvYJ08
         d76xFcOXW74ZMz/WbH2FuoIPsli7WD66gNzJD/xxs9RAQRWEJh8geOogtZ8GAxttlz8O
         dvt0pWqMxOy9/RsyBJbyHZIHxF1KMMX1fTHL2GxQxOhciuC7SdwOd0q0+up+ZeK9v/4f
         DYfv8aTRZADSbW7yCFImFaM4zq3GwStishOi9NgS2qDVce0LvGTyR2rIHeuLNWxC8po9
         3qDw==
X-Gm-Message-State: AAQBX9dMlY+a/SlJNuvX995RubkvUEclWoM1ApTQdrT3/ql/SJaXMRfz
        +ybgESKvaXf99kgIYstwc3T+8g==
X-Google-Smtp-Source: AKy350ZWf+fEzly9izyar1voGeWVVk6oVKSW54et+TXegMZ84W0NyO/qIJE0TQ976ECkyUD4vIjNWQ==
X-Received: by 2002:ac2:5611:0:b0:4e8:3fc7:9483 with SMTP id v17-20020ac25611000000b004e83fc79483mr394970lfd.23.1681987923457;
        Thu, 20 Apr 2023 03:52:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id l13-20020ac24a8d000000b004eb3b6acfe6sm175113lfp.213.2023.04.20.03.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:52:03 -0700 (PDT)
Message-ID: <b037a41c-c8d4-d1a1-ede1-00b938d4a902@linaro.org>
Date:   Thu, 20 Apr 2023 12:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/18] arm64: dts: qcom: msm8916: correct camss unit
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
 <20230419211856.79332-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-2-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/camss@1b00000: simple-bus unit address format error, expected "1b0ac00"
> 
> Fixes: 58f479f90a7c ("arm64: dts: qcom: msm8916: Add CAMSS support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 834e0b66b7f2..894a99431158 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1162,7 +1162,7 @@ dsi_phy0: phy@1a98300 {
>  			};
>  		};
>  
> -		camss: camss@1b00000 {
> +		camss: camss@1b0ac00 {
>  			compatible = "qcom,msm8916-camss";
>  			reg = <0x01b0ac00 0x200>,
>  				<0x01b00030 0x4>,
