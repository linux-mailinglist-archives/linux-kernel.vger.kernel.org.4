Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB473654FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiLWMBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiLWMBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:01:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635C3EAFD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:01:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x11so4783557ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1aNKlBIziXpmLydIr0jJUQXVMvYMyv68eRxTgy5p6Y=;
        b=r/H2RdTv7mw258Cku7x7bpkH32f6hz5mvwEZLIaRG2bv8/4A5LEuu0K4zEVMMTkntJ
         L8sKVmcMv3QNLH/Y+g7FEQ0AxQnJ2qld5iE1liiPswa1o/wKD76QOd/rX5wQI0ei18ju
         n2zDj6itGEAfk/N0UEwhL8PCvrG6t1l79bOvu7EwRza9xGUzsdlfDVJi2m/dxxuvOaVI
         F7L2vZdDK55WZFo4Ysjbz4PlAFEBxwfol6bHAtnuByU0vv3yuj+jCB/n0C2d7/cBz3Vi
         eUlbgLPuX9V7B5ibAsFQcSLoQQQo6gojWUU9IYi8p66tSBCDB0CjoRnoEtRHqZO6Ni5v
         IqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1aNKlBIziXpmLydIr0jJUQXVMvYMyv68eRxTgy5p6Y=;
        b=M5g16npWdJJ69873YiS1pHkMouTuftfK+mhl2qDHmdCfxkck2maw8VcfwTSRgATKMx
         uG9mhlHR39m/KKaRbk1i77MhhdgUHhgfSJUBEq48vDhNCWZdBwG4uYBPMsyoQigdrvcY
         4qSekW1bNWApCzZaBvqvNVJGOSuXsyXZF+aNvJ3bunwzI29OFwNe82im+gQIddkZQp9f
         G0QitzaPukTO9vFeelsbYHJetiLyqxMGjNhVnE0Lhubfhx9qhlTysURVqyMyrFt9mcbg
         dBQadr15tTfDyzVSK+YWR7x+7Rz+zxhztZOcCUBt2x6CWQtB9S2xvXv63RJFsN3tKRMY
         uaEg==
X-Gm-Message-State: AFqh2kpYIlolMzlNDAtxbu1UY/JCweh1RXi26DS1Bmn3mjahpEsR56KK
        BowhS39qE2aVlHU25Li46Y0FZA==
X-Google-Smtp-Source: AMrXdXtQcMgU0pyjzHRHZ0uL6+TvsbRA+E+3Dl7Ry9EwQQ2HRqceuKKtK2BdlmML4/CztnMqUcTgug==
X-Received: by 2002:a05:651c:48b:b0:27f:81f4:bcb with SMTP id s11-20020a05651c048b00b0027f81f40bcbmr2130319ljc.29.1671796860967;
        Fri, 23 Dec 2022 04:01:00 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9f52000000b0027a099ad7efsm392685ljk.35.2022.12.23.04.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:01:00 -0800 (PST)
Message-ID: <53e5ee81-6ee7-66cc-c7d8-2a0e72974d59@linaro.org>
Date:   Fri, 23 Dec 2022 13:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm6125-seine: Configure SD Card
 slot on SDHCI 2
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
 <20221222203636.250190-5-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222203636.250190-5-marijn.suijten@somainline.org>
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



On 22.12.2022 21:36, Marijn Suijten wrote:
> Sony's seine board features an SD Card slot on SDHCI 2, that is to be
> powered by l5 and l22.  The card detect pin is already biased via
> updates on the generic sdc2_*_state pinctrl nodes.
> 
> As usual regulator voltages are decreased to the maximum voted by the
> downstream driver for safety.  SDHCI 2 is the only hardware block
> feeding off of these.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts  | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index eaddbe522695..4c9b8ad77dd9 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -318,7 +318,8 @@ pm6125_l4: l4 {
>  
>  		pm6125_l5: l5 {
>  			regulator-min-microvolt = <1648000>;
> -			regulator-max-microvolt = <3104000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
>  		};
>  
>  		pm6125_l6: l6 {
> @@ -404,7 +405,8 @@ pm6125_l21: l21 {
>  
>  		pm6125_l22: l22 {
>  			regulator-min-microvolt = <2944000>;
> -			regulator-max-microvolt = <3304000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
>  		};
>  
>  		pm6125_l23: l23 {
> @@ -444,6 +446,15 @@ &sdhc_1 {
>  	status = "okay";
>  };
>  
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
> +	vmmc-supply = <&pm6125_l22>;
> +	vqmmc-supply = <&pm6125_l5>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <22 2>, <28 6>;
>  
