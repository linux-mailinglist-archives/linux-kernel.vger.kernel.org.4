Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778AC5E9BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiIZIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiIZIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:16:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180373340C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id iv17so3921267wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=hXgMAhBZ3je78rW+jzSF79si3Ei/05gOqISb2zwsqUg=;
        b=fC1tPWHmIw2H58iwKgU5IEngD15tz3fcVkYf10e/5tjktnuvvNwgCoZ6rlEyCKDylh
         sjhb73evCL2V4vbAMhlnG9tg34+xBHalQm288oDVy1azUNWdxEabAuNQMXn/xm1FlcNd
         ThwVsOPVyNbh6BvcYOuMAy32lcPk1YW6VJh9oss84CrsAix7Ewy6ct8m9TNgyb3PGLr5
         L7JbtQe7P+tNruGuq7uY57SSgOn/NbFzN8bH7ccmqjmcmSot8G1qmRS7uxEgAESfm0Hv
         qV+p9y9Ecg7qPNRgKcf9lYgSFAIL9DS5EJkhRfn/r4w4zwnS1E1qpYpIFozYGP5JO6T2
         kQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hXgMAhBZ3je78rW+jzSF79si3Ei/05gOqISb2zwsqUg=;
        b=RtJgMQOvMoRTZBCn3nSwWg3zldwfphjGc7h68wPCypyarnEm4bvN93/fzQQDz0Mq9j
         OvxOZrvQVXB57oi/YrhwyHV56hJTNOFyqIhOum0eNZHHxpiymLr+FEfepNqsKb9pdz7l
         78aBgJrucywFj/H9zWUOlRLjlgNV8aotQd3YmR3Ph2YgzGIZXI6rd9fSGrHxyhQYjf8J
         fNdm34ctM1wYy/x3kcnhAh7S4SBhoLNGK1T1RhSKeteDCqidIX7Oap6UztRU5JlJXpoH
         os3NEmBGJ29i6J7KsYpLdDx+caAtec/Js25h6fLa0jzuSjVGC6Kba9qoxXTw6n6bTyD2
         9q9Q==
X-Gm-Message-State: ACrzQf15G3kpaXAr2XRy/Ptlom99CjD9AL/713Ea6e+hi/djSC5ius2K
        jZqAlPP3RQnBbS2QqhP/cFvqFQ==
X-Google-Smtp-Source: AMsMyM6uzgMtfU4SLhYrmDdl546xzoIrz4OEcHyRsVRlrip6JtqHNWd+qC3oP3wXDx+gjPBTHCRLkQ==
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id u8-20020a7bc048000000b003b4fb26f0f3mr17434203wmc.115.1664180194884;
        Mon, 26 Sep 2022 01:16:34 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id w21-20020a1cf615000000b003a604a29a34sm10123238wmc.35.2022.09.26.01.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:16:34 -0700 (PDT)
Message-ID: <3ef8bbb0-078d-ff40-88b6-db043b274add@linaro.org>
Date:   Mon, 26 Sep 2022 10:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] arm64: defconfig: enable rest of Qualcomm ARMv8
 SoCs pinctrl drivers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220925112123.148897-1-krzysztof.kozlowski@linaro.org>
 <20220925112123.148897-2-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925112123.148897-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 13:21, Krzysztof Kozlowski wrote:
> Enable rest of Qualcomm ARMv8 SoCs pin controller drivers (MSM8953,
> MSM8976, QCM2290).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Enable MSM8976 (Stephan)
> ---
>   arch/arm64/configs/defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5a4ba141d15c..1138386952b5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -529,9 +529,12 @@ CONFIG_PINCTRL_MSM=y
>   CONFIG_PINCTRL_IPQ8074=y
>   CONFIG_PINCTRL_IPQ6018=y
>   CONFIG_PINCTRL_MSM8916=y
> +CONFIG_PINCTRL_MSM8953=y
> +CONFIG_PINCTRL_MSM8976=y
>   CONFIG_PINCTRL_MSM8994=y
>   CONFIG_PINCTRL_MSM8996=y
>   CONFIG_PINCTRL_MSM8998=y
> +CONFIG_PINCTRL_QCM2290=y
>   CONFIG_PINCTRL_QCS404=y
>   CONFIG_PINCTRL_QDF2XXX=y
>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
