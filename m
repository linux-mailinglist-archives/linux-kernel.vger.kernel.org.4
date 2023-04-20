Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A046E9134
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjDTK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjDTK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:56:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1D9013
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4edb26f762dso471178e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988039; x=1684580039;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzdfAkXwduKDIqEuaIkI3F605JrxVaA993NeOODfR1s=;
        b=ZDAqoP9Om2VtoWOjj0nNutIVDXQoXjo264rRm2Gp0x8R7Q49WAmMyb1Y/yv5YIWhqU
         j7MGRCEz550ONqWshlkfHcVKhx4sM2B9FMHdnOjlCnbaqRzKuaRBBVb4AY5wYnFey3ce
         hS+Yp15HQVMfiED4r0MVPVqt0WmM68P5Ab5IJLdY/h5oHZBcoj7gJFtMni+FTdKg2A3Q
         KfjtxcqeKqZuiAcpokKaTC2LvMJPLGtWa1xLQLRohvSzFai4Bec8LkRrgUGT+MQzxk2+
         s+4UWfLt4sDXRU5AAyAJByluUJvWrDjPw8xALddinC0jDSInvxqN3uwM2v3SvdbVWvqL
         PVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988039; x=1684580039;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzdfAkXwduKDIqEuaIkI3F605JrxVaA993NeOODfR1s=;
        b=Dkj9Vt3/v/M81JSbqaC+V4fk53bJyaxL1dScr/fy1tnHrfnJzyJmdYbVSFWN3QGrsy
         QTWkeCcV8WEA09VSDjp5q7Yv+w09wRLRO77MLYjTePH1t3SNHkb/lOuVHbf2YPtsac/f
         zhojaK/SLV2a4NTvycAx+sWGlqHVxR1d8Qzty+dHvY8taxHgswnXNZGA1hjsbWdjdfZ+
         Qxj2O1dL10wN6D0BaLhOxSqCoo8uYcWGrRMNEwZIniaZggIfmg6yiKaW3uJYxoOhcQCN
         dlcAW9wbgXM0g55NrPsyQt/qUSmlMUC6pC1aUN6k8X4c2e9NPMEoFfMZHtGWA+NmQCsC
         Ukfw==
X-Gm-Message-State: AAQBX9dsLSAOnh2A6GywdAPmEyHLlxKHFc/AuumVKC+PDRMA1PdDlFoN
        q/vN1fSENlQ0GlETLSC+nvm7cw==
X-Google-Smtp-Source: AKy350Z/fVL1xNAI7X0l15dWuxehZaNcGfXkeZUkFXCW5doEYQe8aFSZsQp8eor0Q0Ouizib41ZTdQ==
X-Received: by 2002:ac2:5329:0:b0:4eb:20f:99ee with SMTP id f9-20020ac25329000000b004eb020f99eemr383402lfh.63.1681988039786;
        Thu, 20 Apr 2023 03:53:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id r16-20020ac24d10000000b004ddaea30ba6sm173820lfi.235.2023.04.20.03.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:53:59 -0700 (PDT)
Message-ID: <b89b699e-398a-6a10-7df1-d641d289b2d5@linaro.org>
Date:   Thu, 20 Apr 2023 12:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] arm64: dts: qcom: msm8994: correct SPMI unit
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
 <20230419211856.79332-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/spmi@fc4c0000: simple-bus unit address format error, expected "fc4cf000"
> 
> Fixes: b0ad598f8ec0 ("arm64: dts: qcom: msm8994: Add SPMI PMIC arbiter device")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index bdc3f2ba1755..c5cf01c7f72e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -747,7 +747,7 @@ restart@fc4ab000 {
>  			reg = <0xfc4ab000 0x4>;
>  		};
>  
> -		spmi_bus: spmi@fc4c0000 {
> +		spmi_bus: spmi@fc4cf000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xfc4cf000 0x1000>,
>  			      <0xfc4cb000 0x1000>,
