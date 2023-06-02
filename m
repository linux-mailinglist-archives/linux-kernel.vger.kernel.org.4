Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808971FCF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjFBJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjFBJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:02:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDF134
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:02:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so25198531fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696545; x=1688288545;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7V9lCN7RYFFflPIQCfpUeBeuUHFu7FYCcxKeI+r/oME=;
        b=IrhH4YX43I7WT405xlqdu74wl6smrpyB3jcFQcY4++dtlntgW7voSzgPWc3Dl4CIR6
         p9WwqOiuA/yPiGomsmh0fW347ugVW2u/zohKjPvRAf8GlGm6tXZpUYRq4UC4nzgGpvaL
         T2oLyd2UeLa9FRkg5SGHV2qEmTD+2zMPetSfuKOBQilEra3TY2wpnDx7eJ5kwwMGj+MT
         jXE9qDT4YnAELN3y6TQdT9lEVTWKTUkSnFBIpi41xgHK2vusRQIF++VQ4Jds8dcJhLW7
         871r3776vT90yNz5sdT/Xym0xvOrVuq3LZ64P0QU9+Bq3rwRaOVRNgcciJOgoQ9K5NpD
         cBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696545; x=1688288545;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7V9lCN7RYFFflPIQCfpUeBeuUHFu7FYCcxKeI+r/oME=;
        b=d4AWGbMDSen4ZHkGl/ZpTUS1ZfOk2jcvwAASl3hf7LNHVNa3rlHurszH1OIS2iSJF2
         dVfpZGcwHpkUXsoAX9GuUIMq0Ugvq98glSOa2vvI1q6odsB/fHD+hSnNvqwO2rNk2yWx
         nBp7+/LS+6Ul4MoFh/lRw+epJfzBIDb+dCd4OfFQGscchn0A6mLJjd59WHMeVam5MwBo
         oDEmA7lp+SfZHIQwjsNrorMH66HbpdFWS7KK/afQpQF/h3b5K650SNMrAj95UXOIDtLh
         ASqOrJ3Zrms5vWegJ2WQisO7epREnb2EDRoQ/L/FQ2RI6jXBsxitDMqLz97izFfhdk8n
         nXvA==
X-Gm-Message-State: AC+VfDzwvSGsYAvhFmzBvHmaDYABwYnGn8fKqBUyCw3txG3e9RCASwu5
        TMQ21jj+r1k1w15kfKOj/CBNAqBD/gloBixxW/U=
X-Google-Smtp-Source: ACHHUZ5RnsRmrGsdO/88w6h3TzBffygLoQDCXy7CexKgeXYyaVLveIl1oexVZmG8sy79AgCIOMH7Eg==
X-Received: by 2002:a2e:a603:0:b0:2af:2088:2548 with SMTP id v3-20020a2ea603000000b002af20882548mr1579132ljp.21.1685696545199;
        Fri, 02 Jun 2023 02:02:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u3-20020a2e2e03000000b002ada919a09asm147174lju.73.2023.06.02.02.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:02:24 -0700 (PDT)
Message-ID: <967be763-9125-b23d-b02a-506b4c1facca@linaro.org>
Date:   Fri, 2 Jun 2023 11:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/8] pinctrl: qcom: correct language typo (Technologies)
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601152026.1182648-3-krzysztof.kozlowski@linaro.org>
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



On 1.06.2023 17:20, Krzysztof Kozlowski wrote:
> Correct typo: Tehcnologies->Technologies.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/pinctrl/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 9f957d16cd68..b03a62ecdc07 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -270,7 +270,7 @@ config PINCTRL_QCOM_SSBI_PMIC
>  	 devices are pm8058 and pm8921.
>  
>  config PINCTRL_QDU1000
> -	tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
> +	tristate "Qualcomm Technologies Inc QDU1000/QRU1000 pin controller driver"
>  	depends on GPIOLIB && OF
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PINCTRL_MSM
