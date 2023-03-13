Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D306B71A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCMIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCMIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:53:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA928E80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:50:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j11so14640235lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678697432;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kISuTIdSWojYVUO7a44Ca9HM94avYwnCGGlE/PB0uQ=;
        b=sBn4UTeJ8hrREsyBq5FazN2Ya2hXACUc2wyfokH9aQ9DFJbxe3H/wrSpSsrdOwCiOx
         uDMJVFoehjD/7ZigJe9GyCUZbWe2qgVR0Vz4nuIuo/L1YDnXWPQIsVJX0t8qjMRyhL1y
         ZD5qATvWJBpQgbNVC2LUfFhbheFpOUCUqeMLMm0Z2wbpzNQfat/F88DDJ1hFA36aWA7L
         yU5poCMAqAH6t9ApMmgc1DjCYDAcEkNUm1+42dXRPx8OjVlY37E2BMSeHVpbof2PeRrE
         BWrYFGokdWx04EKO5bF+bIplQvl/+aYiFNXckUpIPTGUC6ujyB9f15rYK4DOAOsR//UT
         MEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697432;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kISuTIdSWojYVUO7a44Ca9HM94avYwnCGGlE/PB0uQ=;
        b=GSLSHLqz4zt6aWHGhQDaO95F6KRxvIDAg/h1waUWN8TklmpiPENu+JwaCFxuvZDG96
         fwuhgeXeb3XJaXLmDeQpL4FuBkuxRQU7TIALUt6FSO3jMxTpaqBz531a51VgMHhxgZwH
         1R4wgSpHpq2CIvW8bZjRPwGRVpDnteQ26cunrdzjuIjFjy6QjJRIK2qCcS/21nCmNBNB
         dATDOCNLZfsoqSDXA5qSMWAO7Cp9safBENjazvBBa/s4OSQBgJO9WKnglScrkQ7BloI+
         Q4lJtLka8FRm2sj+N+IXb+ZSQL8uZDWMBp7nCirEOf0GGk89X2MKrDbr4ZbXpLkB8SBx
         vvHA==
X-Gm-Message-State: AO0yUKW9qEJZD+LkA4V9qz9YGS0KDz21wfcEe/pElZ1d/QXSUKV9cOu9
        O/HDU+ThGcJ4WWyGF8zApwwR6g==
X-Google-Smtp-Source: AK7set+TXMOG4+OAxi5JOlc0sgZmdeoPEOpFMTcExto9iRF2c+GNU0RXiuwWr1M4QjFvBoF+/kjlOg==
X-Received: by 2002:ac2:4c99:0:b0:4df:8235:25a4 with SMTP id d25-20020ac24c99000000b004df823525a4mr9560996lfl.53.1678697432314;
        Mon, 13 Mar 2023 01:50:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id l23-20020ac24317000000b004d8584970b8sm894391lfh.226.2023.03.13.01.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:50:31 -0700 (PDT)
Message-ID: <af9489db-4de2-5cd1-07ab-4f38e34832b9@linaro.org>
Date:   Mon, 13 Mar 2023 09:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/8] arm64: dts: qcom: msm8998-oneplus-cheeseburger:
 revert "fix backlight pin function"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
 <20230312183622.460488-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230312183622.460488-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.03.2023 19:36, Krzysztof Kozlowski wrote:
> This reverts commit 46546f28825cf3a5ef6873b9cf947cd85c8a7258 because it
> mistakenly took PMIC pinctrl/GPIO as TLMM.  The TLMM pinctrl uses "gpio"
> function, but PMIC uses "normal", so original code was correct:
> 
>   msm8998-oneplus-cheeseburger.dtb: pmic@2: gpio@c000:button-backlight-state: 'oneOf' conditional failed, one must be fixed:
>     'gpio' is not one of ['normal', 'paired', 'func1', 'func2', 'dtest1', 'dtest2', 'dtest3', 'dtest4', 'func3', 'func4']
> 
> Fixes: 46546f28825c ("arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin function")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Eh, embarrassing. I would say to myself - use dtbs_check on patches, but
> I think that time there were too many errors coming from Qualcomm
> pinctrl bindings.
It's good that we have schema at all though.. It helps a lot!

> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> index d36b36af49d0..fac8b3510cd3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> @@ -34,7 +34,7 @@ led-keypad-backlight {
>  &pmi8998_gpios {
>  	button_backlight_default: button-backlight-state {
>  		pins = "gpio5";
> -		function = "gpio";
> +		function = "normal";
>  		bias-pull-down;
>  		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
>  	};
