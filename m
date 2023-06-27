Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E273FA64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjF0Kn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjF0Knv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:43:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08A10D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:43:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso35750481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687862628; x=1690454628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWx+Cvg7fGLiUN0UHNa9akbC0yyZ4jvvZZEielabtws=;
        b=tfBG+d57iR76VoyZ2eueTj0VFGBfdIKHuhmvIs3qwW07rtgOzn7w+1cbBtBP2mkRNJ
         6B5Tc2UPqgxkqNMYcXnPaTFScURrD+/vkrr6wP7eEOIbAbJYSTBHXyVo4ssqSkdi2+ef
         80d3pZXmi4blYHXU1hK0AyBH33Gi/X36bR8itXUydxd/LLWt+8cg+skJjp+rgvvqxcPJ
         okUb48oLxfsBdZOCIfsDAsvkUYSSTZi2CrHy1LIty+WK88TaQu0qf56oG8DJPgkp9nl9
         ZDpnKmcfipBsPvomwuaqSHROYsgyK4Afs90wYZE3dqYE+NOlYlbg4TLAaCBdgXQ7kaE0
         rBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687862628; x=1690454628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWx+Cvg7fGLiUN0UHNa9akbC0yyZ4jvvZZEielabtws=;
        b=S184Mj0SCjFm2oVrY2pVkrmUZbNSA277t8Or5brkFehq6djyG9PtSIgG/rNBzt2U/x
         9ZpmqD/Q3uPZa3nJ8BpSEW+pZNC16BLLGM773mCZenDvOMk6Z7OjyEWH0fubnlPFp5dl
         8X82ZiMg5ypyvZ2CxLHb5gewa79792efJ2awF4fVX4AqfXV7VSEJJjvCs/wlopB0y5Ab
         BAnubyDpB3ag1+khYKwSgFB8yQopjRtrOxiWkpl2fGUVQv/bjXL1g4yUH0oM6FfSbL1L
         rBLKCEdAaxM4sv51itHmuWjC5LfqCu5nLhiuAkU/VmfRNZ8hA3BNY6glUUBsMyXiFaxQ
         Z80Q==
X-Gm-Message-State: AC+VfDzBe9d5Go2Yv7DexEszCzJrQZY/se8rUJqUGtQv7iUJK9TaJIp6
        KdU8328Kshhd1zl6YKBAqGPT3g==
X-Google-Smtp-Source: ACHHUZ7kMozIsFQ0DZHdyTsa18Av0i6quxlKGv9VfDtJi1F8n6noENvECmPT9t5iP2UFVZN45JwRNQ==
X-Received: by 2002:a05:6512:455:b0:4fb:8939:d962 with SMTP id y21-20020a056512045500b004fb8939d962mr427410lfk.19.1687862628022;
        Tue, 27 Jun 2023 03:43:48 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id b28-20020a056512025c00b004f86ec7b992sm1455924lfo.114.2023.06.27.03.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:43:47 -0700 (PDT)
Message-ID: <a584a43b-e414-0c21-f269-c48b6bb96d95@linaro.org>
Date:   Tue, 27 Jun 2023 12:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Wildt <patrick@blueri.se>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230627085306.6033-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 10:53, Johan Hovold wrote:
> Unless explicitly specified the interrupt-parent property is inherited
> from the parent node on Linux even though this may not be in full
> compliance with the devicetree specification.
> 
> Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> Specify interrupt parent explicitly"), add an explicit interrupt parent
> also for the PMIC RTC node for the benefit of other operating systems
> which may be confused by this omission.
> 
> Note that any such OS must still implement a fallback to the root
> interrupt domain as most devicetrees are written under the assumption
> that the interrupt parent is inherited.
> 
> Reported-by: Patrick Wildt <patrick@blueri.se>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Maybe a warning in of core should be introduced..

Or maybe dtc could learn not to compile such DTS :P

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index a0ba535bb6c9..80ee12ded4f4 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -101,7 +101,7 @@ pmk8280_rtc: rtc@6100 {
>  			compatible = "qcom,pmk8350-rtc";
>  			reg = <0x6100>, <0x6200>;
>  			reg-names = "rtc", "alarm";
> -			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
> +			interrupts-extended = <&spmi_bus 0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
>  			wakeup-source;
>  			status = "disabled";
>  		};
