Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381A76E9124
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjDTKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjDTKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:54:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C3AF0D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a10so2290153ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987943; x=1684579943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF+cVHW65kn0EWZAdQ/XqSFuh4v3RZVo+MXissquD4E=;
        b=Ddijhu2LxSjHwtZUZNx7iOzXjXoNFjCGOfqxFlo312l0Hl+RNzMzI+3ghCDU3HwrFd
         PnVRFopHvrkKozEh/pQoqRy1iJc0Q6KYj8bPrQtHc3YncmyST2im5BGMezIP9dMg/h3i
         gQsFIN3PPhi0L0Uhsb3TyjiDAqv5HrLUsIF1+zLry4Fn0MtrwGQOoGVEOCGjSggUYdM2
         TVBVGWt/dUwKoSMrK/3zQNfylRdzi2FXsyz0W7fZHInBK3LK4pE53q1wZyHD0gJE+kxF
         5JkofNXc1XsxcDt0U+5cjTLNpTtwHwh+mihXYlIYeSoOk6s1C/qgA4PFMo8Mbtq1LBz2
         guEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987943; x=1684579943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF+cVHW65kn0EWZAdQ/XqSFuh4v3RZVo+MXissquD4E=;
        b=LEjoLD142F1zD1onU0RHniTKTWdbgM4ynzfdcc/oZR01Fho6g8pKcWqtkJe1/fXvbT
         rU68AkUrYKakGIyxDtYICR9hXc4KtfX4etLCo+2qwbAgeycWaCW4ovW4oy5lp04qQOHU
         VmSM2nM0XKVz/oR1elsWanCB3W+M/v/xmBZKW5Jq3Njcbey3sBauYo8LdUPGNGGnhcH4
         AQ7/vXw0pOJuPeJT3+gmEBsfdDmM0bz9jYtESckWVZVi1YLxVscjsuGRVN8PSjbD8xih
         phRxOECh3GPpPJO47/SItVV4P4XRn+3ddtClBaMu7JfEuLKk/USfDhIpUjEHIj3Qedbw
         jMsw==
X-Gm-Message-State: AAQBX9dbprZzvLIWNb8Snua8kTezIM+1X0Hm/4mo7k1yGAB4/WvoAvrL
        KGl+e7sxNVv9yQdmLHzOsHzeew==
X-Google-Smtp-Source: AKy350Zi7hXdxF/4h5UAC+6sxgKmxottK4/oTiDjxLS3WP3wfrC6tpU/ZNnsv/pI2s48yylyBVegCQ==
X-Received: by 2002:a2e:6e19:0:b0:2a7:77ae:2787 with SMTP id j25-20020a2e6e19000000b002a777ae2787mr344957ljc.20.1681987943072;
        Thu, 20 Apr 2023 03:52:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id n1-20020ac24901000000b004dc4c1e1e97sm173046lfi.264.2023.04.20.03.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:52:22 -0700 (PDT)
Message-ID: <997d79c9-93d9-2d68-0b3d-4b98c15a6f97@linaro.org>
Date:   Thu, 20 Apr 2023 12:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 03/18] arm64: dts: qcom: msm8916: correct MMC unit address
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
 <20230419211856.79332-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-3-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format error, expected "7824900"
>   Warning (simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format error, expected "7864900"
> 
> Fixes: c4da5a561627 ("arm64: dts: qcom: Add msm8916 sdhci configuration nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 894a99431158..f6ccce0dad4e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1554,7 +1554,7 @@ lpass_codec: audio-codec@771c000 {
>  			#sound-dai-cells = <1>;
>  		};
>  
> -		sdhc_1: mmc@7824000 {
> +		sdhc_1: mmc@7824900 {
>  			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>  			reg-names = "hc", "core";
> @@ -1572,7 +1572,7 @@ sdhc_1: mmc@7824000 {
>  			status = "disabled";
>  		};
>  
> -		sdhc_2: mmc@7864000 {
> +		sdhc_2: mmc@7864900 {
>  			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
>  			reg-names = "hc", "core";
