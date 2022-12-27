Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEDC6569C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiL0LR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0LR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:17:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A279F6F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:17:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so19164269lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2P8LOZ4fD2kwjPbljAyl6MPnOtwfF+5ImWAPJzWUcXI=;
        b=fVsM0AWuBtSFIcg8OBnXVzLIifgFbfqKn1mg1aHhhBv+CRouGpAK0YbRaUwApHVQhq
         TC4roBAaRdzk9XCkm8cIKdpLHQvN9a4Bl1W1+rOxnTCgK7+BlhtVwuRtlMqGBr2abtE4
         5nhoofJHZIjWJWPBEkvYX31VilpDn7c5gdAd6WtTempVrO/YS+k7oUgBC4n6Qj+2OHQF
         EBsFYBTYRSqnSqfF59wKbSgkN9b3Id4hHbtnCYbR46LtAPIyhM61NJ6Un0EJJtHiqhHG
         JpETpqih0MHz5v56MObmDKsD/3IQywrlATDZjIdDWyzjNW0xkVxHRQbIGNFKFpnBVYJE
         ppUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P8LOZ4fD2kwjPbljAyl6MPnOtwfF+5ImWAPJzWUcXI=;
        b=nz1sD2+QVebJWlmC7m4tvAQshj9ScmYIWDsr9XT+kI3B4sbwyw1vGInPGaScJuqvs/
         Gg9gPEECWy67SuwV+I5S4xhaQ8xlK1NDIweVcEVEQwx2k+w1tVNXW0lCONvcKXVAFBKn
         ZxNguGfC4A3VhYdhru0jQJ4JiAPhnhVPSx219DpfWTRI27IoSWnTz7RMarIwlnw2heNY
         4cvojTt4Y3v/V1NYNMbH9mmmDdp56TFD+genuMACerBF/71L/BQVgPrRELN/auptrZFs
         zdCGsHyjbuGSBg3pchDTK5GK4XgHqiHiB8hhAxScf+KbhutaIJ74U3KwqyO4MghnBzgx
         7BQQ==
X-Gm-Message-State: AFqh2kqiqOtbbA7Mm2LYe6/pnszfpX5tKRw7YxmknLUE3+aUyhyAymk8
        eouqFeIQUWjFbz0XlaOgyreV1A==
X-Google-Smtp-Source: AMrXdXunAKSTpX2dZ0bVI1jzGsq9ACWSTDGIe9mgEt+Ca15cUOlZnQN2V2SpKXRLLp+e35FVyGHurw==
X-Received: by 2002:ac2:5604:0:b0:4c6:4ff7:ba04 with SMTP id v4-20020ac25604000000b004c64ff7ba04mr5419751lfd.2.1672139843761;
        Tue, 27 Dec 2022 03:17:23 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b004b5323639d8sm2197520lfr.155.2022.12.27.03.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:17:23 -0800 (PST)
Message-ID: <9b17c480-db10-3e57-d071-8382e4989d1b@linaro.org>
Date:   Tue, 27 Dec 2022 12:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: correct SDHCI interconnect
 arguments
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221224214351.18215-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221224214351.18215-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.12.2022 22:43, Krzysztof Kozlowski wrote:
> The interconnect providers accept only one argument (cells == 1), so fix
> a copy&paste from SM8450:
> 
>   sm8350-hdk.dtb: mmc@8804000: interconnects: [[74, 9, 0], [75, 1, 0], [76, 2, 0], [77, 36, 0]] is too long
> 
> Fixes: 60477435e4de ("arm64: dts: qcom: sm8350: Add SDHCI2")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
This patch is correct, but if 8350 dts mdss [1] gets merged, it will become
unnecessary, as it changes icc-cells to 2. Apply with caution i guess :D


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

[1] https://lore.kernel.org/linux-arm-msm/CAG3jFyuoXekXN48jAgXxLMy8yGAzK9oJH_1HHYAuRLBCzyordQ@mail.gmail.com/T/#mdd42dd600f0818ec103daa27c63add6700db86d3
> 
> Fix for v6.2-rc merge window.
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 4fc15cc69b8c..0726930c9e28 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2382,8 +2382,8 @@ sdhc_2: mmc@8804000 {
>  				 <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "iface", "core", "xo";
>  			resets = <&gcc GCC_SDCC2_BCR>;
> -			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> -					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
> +					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_SDCC_2>;
>  			interconnect-names = "sdhc-ddr","cpu-sdhc";
>  			iommus = <&apps_smmu 0x4a0 0x0>;
>  			power-domains = <&rpmhpd SM8350_CX>;
