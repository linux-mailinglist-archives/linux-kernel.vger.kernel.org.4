Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDE6E914D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjDTK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjDTK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:58:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9997AAA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:55:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r9so2255751ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988141; x=1684580141;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmstLDHPX1AXBNphqkdUm4Bpie7LqMTEvGBUn3qyueU=;
        b=yNnpm++4lV026RGlT3FLY5bNlmCb+IhFhsrLV92bP6i5Ef4YiZbunb7Zv02/R2jGXB
         m0DzHFchuNzuPNuUhr7Ponbd/tt4DCmjWYNDObSrN9o2H7JfJO1V+GpnhyBbBV5fbwaA
         NYUewHh6x1KBjOrL0LJWriIWGUIguRUk75IR5dm/rxQU5zMqmz32bGP15caCfMzE+IWp
         eXKh84Z9T71B/fNZLgJXEJ2NGVYrGRQMnc+vTQ+eya/7Rix4IzXwEHWWWF68fKX3LXtR
         j7hpphRAHjs+RDI577wG9X5VGJOyDv3O9XMJORmK0VXD3dkGvS76dqvSNPBE2NEVwy7o
         IjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988141; x=1684580141;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmstLDHPX1AXBNphqkdUm4Bpie7LqMTEvGBUn3qyueU=;
        b=WKRZezxMKyRpGmW1AhgV8lTcGBay3bOhsh7le5AuSX12ORmEYJ81x/AdzNcUoWUqRt
         wyFaIdWnYU/F9BQHpGNpKsvG445DPjsglx9hmzrDCvbTWibPzOr0IZxTg59mdad2+TQd
         fviryy3eq1dwmuO7fGLBtcxESZJbMGrD7ltsCMxKeKojCIvTkAR7piW4SZceSZSsUTbs
         ikC8HAiwSUBkkrFTApD9UGXarwOQAjAZa2/g5/QD0T9JjYZLa6hZCisGwY33IwdWXyIW
         MY8QeS+Qzcvm/i6tPUf0CtO+AGT2lQv268iMKq2o2iWj/OkJrPxiygsSvT1venHytDcS
         qsMg==
X-Gm-Message-State: AAQBX9exnFYJEBvglCBNv3C2TQMeehH6unDs5AKwfJz3JDGKGnbtkJHX
        Xbr5ZxFdnF9SJIBhO/FH/al4LQ==
X-Google-Smtp-Source: AKy350bJd+L2t/fxNsOHgxEFVGEl+TKC4YFAPa8eGfBfQfDzT/wkXRlCd9SZB2qTj3d5BEvMEXPd0Q==
X-Received: by 2002:a2e:88d9:0:b0:2a7:a5a4:b878 with SMTP id a25-20020a2e88d9000000b002a7a5a4b878mr297562ljk.50.1681988141209;
        Thu, 20 Apr 2023 03:55:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w6-20020a2e3006000000b002a8aa82654asm193168ljw.60.2023.04.20.03.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:55:40 -0700 (PDT)
Message-ID: <098b2fa9-c3c0-85ab-d550-007ecb0e20bc@linaro.org>
Date:   Thu, 20 Apr 2023 12:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 14/18] arm64: dts: qcom: sm8350: correct PCI phy unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
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
 <20230419211856.79332-14-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-14-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/phy@1c0f000: simple-bus unit address format error, expected "1c0e000"
> 
> Fixes: 6daee40678a0 ("arm64: dts: qcom: sm8350: add PCIe devices")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index a9af730e0b1c..5ca21cd1cbec 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1638,7 +1638,7 @@ pcie1: pci@1c08000 {
>  			status = "disabled";
>  		};
>  
> -		pcie1_phy: phy@1c0f000 {
> +		pcie1_phy: phy@1c0e000 {
>  			compatible = "qcom,sm8350-qmp-gen3x2-pcie-phy";
>  			reg = <0 0x01c0e000 0 0x2000>;
>  			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
