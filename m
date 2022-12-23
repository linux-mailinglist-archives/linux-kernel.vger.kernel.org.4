Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E57654FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiLWMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiLWMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:01:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D493EAFB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:00:21 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so6830499lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nI2AU4o1rjXUcHSb6ceGhhVZddIcB3diHI1Vs6E0sA=;
        b=wYiUKAFBZEUkbsZwdujqm4J1yb5X29oD24XfGz46xCp9h/qSU+voasAkOmhjpuEjO6
         FlW9kE47xCidQdI/Y8Xt7fjpCk/BE8T4vb1Apm+0RW+2vz2k1BppYFsxldOXc8eiyUXq
         pzanpdYdUmYZUuhLt4KqyeGQXVF9TmtNMqAAXBMZSkkajwEEWoBP1EoLLUZtBq/dZkIy
         A1X1ii9m6dGEsIVHkCP2mztVBzuhE9xtSgUzsz4ePsKFua3K9xbtgKaKYSWt5hOTw8sZ
         R1nusnDS0zWTDmpd8qaSwagx+HkpfKZP4HYWS0Zjyc/WQ5YqfhoPcBMprsU+oPAfzlwl
         qZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nI2AU4o1rjXUcHSb6ceGhhVZddIcB3diHI1Vs6E0sA=;
        b=E0egsxhcjlg50B92g4galz7Xxh/Skx7hwDRTMyN2RwD2dTRtOVa8S26c2biGbixdsy
         g0T98z3Bo4xh4zpy8QOeXop0n6crOOTCqaxi6LJiua18YKOvrhrv6Fb7he5ye8sPV0YZ
         YW8LrphDINeCKyBZ5fVADxfkX+BC7GIGclm522JdvKmqVM1jzpa7J9j9fFVGklPjO9m+
         65IytC8WFGDFKJ2Sr/3unHkFje9uhdmNc9Wr2e3H6Hiv/ISwe525Dp510BO8IRN74whq
         OOEuFc4KdrtECCbEeAV6sQ4gfZkY6MEK17sGaUX7AY1McUrTf5WLVjynRbspbGnHrXbb
         oO0Q==
X-Gm-Message-State: AFqh2kp+/Uqg7uencpa96Utv5XS9fROoydme8ef8sHx8sF15lp4vkDwX
        FBYnxzqFmPZt1jvLp8ebkiheIg==
X-Google-Smtp-Source: AMrXdXug02SHrEVae3snmuyspNlzmnJVxG+7NJO2UAAxHzVtSBinSDncn8yFVh+3wYWsf/EjFHsiBA==
X-Received: by 2002:a05:6512:2508:b0:4b5:9b8f:cc82 with SMTP id be8-20020a056512250800b004b59b8fcc82mr2838920lfb.0.1671796820161;
        Fri, 23 Dec 2022 04:00:20 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b0047f7722b73csm497112lfr.142.2022.12.23.04.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:00:19 -0800 (PST)
Message-ID: <abd83b0c-ae33-98f7-a1e7-49f227246ebd@linaro.org>
Date:   Fri, 23 Dec 2022 13:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sm6125-seine: Provide regulators to
 SDHCI 1
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
 <20221222203636.250190-4-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222203636.250190-4-marijn.suijten@somainline.org>
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
> While SDHCI 1 appears to work out of the box, we cannot rely on the
> bootloader-enabled regulators nor expect them to remain enabled (e.g.
> when finally dropping pd_ignore_unused).
Unrelated, unused-yet-enabled (as far as Linux is concerned, anyway,
it doesn't know the state of smd rpm regulators unless you add
regulator-boot-on) regulators get swept by "regulator cleanup".

  Provide it the necessary l24
> and l11 regulators now that PM6125 regulators have been made available
> on this board.
> 
> As usual regulator voltages are decreased to the maximum voted by the
> downstream driver for safety.  No other hardware feeds off of these
> regulators anyway (except UFS, which isn't used on the seine board in
> favour of a DV6DMB eMMC card connected to SDHCI 1).
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 15b43cff210b..eaddbe522695 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -348,7 +348,8 @@ pm6125_l10: l10 {
>  
>  		pm6125_l11: l11 {
>  			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1952000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-allow-set-load;
>  		};
>  
>  		pm6125_l12: l12 {
> @@ -413,7 +414,8 @@ pm6125_l23: l23 {
>  
>  		pm6125_l24: l24 {
>  			regulator-min-microvolt = <2944000>;
> -			regulator-max-microvolt = <3304000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-allow-set-load;
>  		};
>  	};
>  };
> @@ -437,6 +439,8 @@ sd-cd-pins {
>  };
>  
>  &sdhc_1 {
> +	vmmc-supply = <&pm6125_l24>;
> +	vqmmc-supply = <&pm6125_l11>;
>  	status = "okay";
>  };
>  
