Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79DC6E9118
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjDTKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjDTKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:53:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3F1719
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:51:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8c51ba511so3870211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987876; x=1684579876;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EIxJH2yrLBRrFwXgWbwZYnw9Goigez16D5eZr76hWs=;
        b=WuRVK8evm0fEryO9tqGyYRLjGFn7Olze/Cz2LbtDVh1N6K32SZMUc8k3HPz3U5eRyI
         G/tpDvTjtF8OhFfo07be4CUd6O0dgWnNSs4m7dpJU3NhiwB9/UBCWHcqEkFT0kU6mgq/
         QObw2Z61Wj0lmUFhSI3VLfRW8RR4lLxZPAn6JKYZNGJmE+lVxJ9lGQvoJomuzQLJacg/
         mVMa9xjanSVyAxdS0FwCeOTNW7PC79b/K49aaloI/2e+G+puDpX9iIeRAKrAdyAqzZtV
         HIb8EVzZ2x9mqvMtN6BuftOGpHH18DBxKBUHWtM+LpJN454VfyG0hDsKms0PnYKjBjpR
         l4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987876; x=1684579876;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EIxJH2yrLBRrFwXgWbwZYnw9Goigez16D5eZr76hWs=;
        b=fwkmhv8hzrD95aiHMzYnQfBO4R/f6JbRJ80IT6UsUg2N/OWq8KbGf0Vbu7vJpFH7UB
         Y8UjmzMxL2dcnkdQagpveCS//c8CYr4tasFDx1GeD4o5Y/H3f0y8IYd1UfIOI9yAhpL/
         9oXOFY/YzFSR0BU8skOVFWrlv/pilu6BTiCtkjHM4ADizCTNTki4Nw6Ub9mW2LJd1WUn
         8AEOEhspueZij9G1N/YUwsgmewH4nDa6h/gNQkhC+Vr+OqlGweyMddtCtG3otPQVfIvz
         1kOq+d4L1Bx/LyDTYMzl2SgIFY0F0rHZ3rZBx2wflSHvgTR/uG0cbZzMo1t4jhF0Rkiq
         hKdA==
X-Gm-Message-State: AAQBX9eDjG4z/WSLE0KDPrXzFqkMYpqGJlGgOZhIvIBf8v+5pmHnZI3m
        wDpK6abHVcayoMtGmi4iWtdJEKJTnVnMgBFHtfg=
X-Google-Smtp-Source: AKy350YoN/3dzemidDrvN0eNtWUZw1nWFrfv1fLiYAAidH5xw4/qgloWCgQgMhKs7N9BTE54tqzwvQ==
X-Received: by 2002:a05:6512:11d2:b0:4e8:5e39:6238 with SMTP id h18-20020a05651211d200b004e85e396238mr355519lfr.42.1681987876564;
        Thu, 20 Apr 2023 03:51:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id x6-20020a19f606000000b004eaf41933a4sm177831lfe.59.2023.04.20.03.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:51:16 -0700 (PDT)
Message-ID: <ee727e03-4cfc-e4b5-7909-07b579dd5dc0@linaro.org>
Date:   Thu, 20 Apr 2023 12:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/18] arm64: dts: qcom: ipq6018: correct qrng unit
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc/qrng@e1000: simple-bus unit address format error, expected "e3000"
> 
> Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 54af7cb3c7a8..992e8ed64617 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -302,7 +302,7 @@ mdio: mdio@90000 {
>  			status = "disabled";
>  		};
>  
> -		prng: qrng@e1000 {
> +		prng: qrng@e3000 {
>  			compatible = "qcom,prng-ee";
>  			reg = <0x0 0x000e3000 0x0 0x1000>;
>  			clocks = <&gcc GCC_PRNG_AHB_CLK>;
