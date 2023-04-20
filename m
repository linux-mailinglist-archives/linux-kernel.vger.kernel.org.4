Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA36E9148
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjDTK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjDTK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:57:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB15591
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:55:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec81245ae1so481954e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988115; x=1684580115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Om948J/OEKQMwB1gI5FlTpsAl9g7ZZdyVGlzA67pa0=;
        b=zjgRd62pNEBvxg5aQUN1n/Vz+SgbgACPAAGtTD8JQxLpHjfZ70Q0deSy09zVAsXJzM
         EZeJStMVJi2kcDi2ZFgcupeJPazG2FZLURGC6OEjdZ+R9JcquRc/egEcS0XQZw05DwRt
         4UFETHvTLreSnwqNnBT/y9wLnj98fHJ55mUe6N31MmGrygnNttYUuHkZdd5IjZHGYb1c
         jOP+aOujU2pCrk1dt4vRQn4JFQU+l0/t6u4Ceg8+HEiJQA9id6CXskcivF/ioKfxvJzA
         ocvk1ZewEA6Hk68aao0qTsTdw5E7YItZ/cximveUOWyim7IA2LDKIv9Yvb0NIhFm/f0C
         gLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988115; x=1684580115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Om948J/OEKQMwB1gI5FlTpsAl9g7ZZdyVGlzA67pa0=;
        b=F4KqHeQd1qRw5TW/PYT7cxXcXB0Y/doU0tBw6FwgDM4XYizhqn+wlsYrbEF4uhOKeM
         Nx8QgF65sVnVPAaqZsBwedY0ET0Zqd6y/yXfDp2blls2dVQyLjRUHQA5zdPppd6UhSJV
         gjMSeRkIpDfEvmvghaZI2WL7rZK3mIpC4kVZLiqNC4RNkRsy/nHkDW5aF7oGEbmSW92H
         3vkSb9vGKwZ32VrhuShomkI3WwrQu/WuxTQjT+n6RVWs8ytOUQnnta7Za4ufdadoe8ko
         Tw4UPJ0umtooLy+vmzrG/JBS+hRAthU0ZSVsAvj0dhucgEN0indB6P1qeCGbcV/lWWTL
         +rCA==
X-Gm-Message-State: AAQBX9epcC7xKB5cjeO85U/wpnQ9lH+aLSaP5dW7BTlm4Tpj9FBpyjLf
        Nn5544FT2LxO1f8pZn/szHuWCg==
X-Google-Smtp-Source: AKy350YgYeAv00bHfwLOBmmLMT4YMu99Qexo5kA6xpWYXjf9xuu6O8KFQ5inAMUvsTtWaAvhDh8ivA==
X-Received: by 2002:ac2:532c:0:b0:4d5:8306:4e9a with SMTP id f12-20020ac2532c000000b004d583064e9amr353085lfh.46.1681988115152;
        Thu, 20 Apr 2023 03:55:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512014400b004e8483bff82sm170335lfo.271.2023.04.20.03.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:55:14 -0700 (PDT)
Message-ID: <4c58abb4-be97-8419-2e3e-493c3d060726@linaro.org>
Date:   Thu, 20 Apr 2023 12:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 13/18] arm64: dts: qcom: sm8350: correct DMA controller
 unit address
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
 <20230419211856.79332-13-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-13-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/dma-controller@900000: simple-bus unit address format error, expected "9800000"
> 
> Fixes: bc08fbf49bc8 ("arm64: dts: qcom: sm8350: Define GPI DMA engines")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 3efdc03ed0f1..a9af730e0b1c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -907,7 +907,7 @@ spi19: spi@894000 {
>  			};
>  		};
>  
> -		gpi_dma0: dma-controller@900000 {
> +		gpi_dma0: dma-controller@9800000 {
>  			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
>  			reg = <0 0x09800000 0 0x60000>;
>  			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
