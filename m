Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F736E9142
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjDTK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjDTK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:57:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633592D7F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec816c9b62so456779e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988082; x=1684580082;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUcJ/S5FIQy5sMfQQcxjZiNiAJcc8yGlyy+Yq8sepqo=;
        b=lMGekLaHRWvYIJh4QlGZ4JOliSQuYOKxK7Di6xiKzxj1bjf+/JeR1c+mESZOEZWdB/
         A2Ed40eIpk81jTRWAjGw2Z8QL1ruGVivRc5mXpEeAn+vbihYMRpCRPipST32OJCDxBvt
         y7rhChB5Fqpeebjgws5JzwJfs5n1/y6neHampW34uTVVwjX6brXcUb3XV2AlyP4eW6Jn
         UgmIyW2ImY5AQF5LqQZya7w5EIe6HxPc2Sp8J4YdAh4jGlqKiTa8ih8RQANBsS2RzQ/F
         +qO1qDmsNv2MA7x99BZrxnHYHvz7P9VSPxPCCFZ2DSYVAMnSEFyiV2jK1od625TyNRvh
         tX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988082; x=1684580082;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUcJ/S5FIQy5sMfQQcxjZiNiAJcc8yGlyy+Yq8sepqo=;
        b=UlYy5rqfyZ4hju/WDOjMxvUgXkwaKZ0ttiETuFS3Uv/DqrXRDxYLllMPzeJiYWLCR0
         jcK8A2lh2tQzo1W0MhJy9u/Ze4XR32wczzr8v9RYrruBuVVMSflPYvYjhVidhHyxy86l
         cAGUPP4vWgiafgEM/LzvvRuVcflHy12R3jfNia1IFGPxuuQHac4Tlx6TwFJQ0Ymt4aa0
         K5Vn96Ws5MisQ4uOwEPr5/suB+A2z/KQ66PDJKhMKMrWPlxDDkJoxWi1L3Q7x9b+lKsa
         Q24YqUDCg4R9DaMlSOAjHrga0mQOXDzvLYUsReUEbWkrBveYQnYd1EkN2WM0bs8J3b6F
         u3Hw==
X-Gm-Message-State: AAQBX9d6tIkWcRi9TrzvEzDthdimu4xIZff8VjYolkXjo+YwvSCHUvYW
        gS/JXTFufXlS1CxZ2x2gGYC3IA==
X-Google-Smtp-Source: AKy350bxZk1oZ9fuhN7CSzBAYt9mYTMr/zsJ11YgoB0W20eOxwuEMZTaevjqoDGMCNdpl51Gd1GfIA==
X-Received: by 2002:ac2:4358:0:b0:4ea:fa07:1182 with SMTP id o24-20020ac24358000000b004eafa071182mr349314lfl.14.1681988081907;
        Thu, 20 Apr 2023 03:54:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004eb4074f40fsm176565lfe.241.2023.04.20.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:54:41 -0700 (PDT)
Message-ID: <d5ce920b-c203-35b5-7dd6-d4e2ed75c029@linaro.org>
Date:   Thu, 20 Apr 2023 12:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/18] arm64: dts: qcom: sdm845: correct camss unit
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
 <20230419211856.79332-11-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-11-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/camss@a00000: simple-bus unit address format error, expected "acb3000"
> 
> Fixes: d48a6698a6b7 ("arm64: dts: qcom: sdm845: Add CAMSS ISP node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdeb05e95674..8f99e79ba3fd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4238,7 +4238,7 @@ videocc: clock-controller@ab00000 {
>  			#reset-cells = <1>;
>  		};
>  
> -		camss: camss@a00000 {
> +		camss: camss@acb3000 {
>  			compatible = "qcom,sdm845-camss";
>  
>  			reg = <0 0x0acb3000 0 0x1000>,
