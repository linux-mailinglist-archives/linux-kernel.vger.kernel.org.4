Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5C6375B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKXJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKXJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:57:43 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80610B49
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:57:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z24so1421078ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I1o6volX+RUUsGHfsMyw2b887nAq2ZLugLHYOJPxlY=;
        b=z18kdr9GDZG9iwQuRU+lJM34ZIb8yZsUN0LMmzNVGr6J8/R6dJ4ljXINp7fjjIZHpO
         R6hABNLq65bmiFgOxY6sTkEjgV8UOVJgHI///PRjmRxRQYw9y4eqOyPRTe3FGuIdsdIp
         crgRrj7jUCIXqQ1dWyBH47MGAOpY5rIbnM+El1aMOGkwJqIk9z+S/aIgj7zbAJAR2mB2
         P048RNcfHuUKVsEypyRrNUYkG5PygwES0iMhVmdBD24BJydmVsY5g8ErkClFDmhS/nQl
         ndnAJjXWUNWLp/jcwFlQnrN6ayEgYPMAPXDsEuJlvY1U6olFezDJ417kPsGDOB0fy2tI
         e3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1o6volX+RUUsGHfsMyw2b887nAq2ZLugLHYOJPxlY=;
        b=SWCPpMDg2+cXF8KFLLX9tJu4BLCcFCHKkx+5nWxhS0d0iXnx3RvcFNivByI8PWkaiR
         ntXlml3+sekJbK5WERgN5VTJ/dOSpt2Y/AQlLIiUdVELwZNC/Abr+DNc1BIwI85gZACo
         jXr8b/tRqlMOleBKSJY1pTtuneaD2q041FqEQm43HjUq5y40spL6Ts1c393LGMkCm8tq
         +35ntuulbFKgsIKUkslCii4fdv9Cp2fU0Ve7i3naGANnQGElKuGy9hBoTnHNrfIuoOXu
         nClHjHDKCiBR4YIScLF4DPemZN5qryhaQBQlZpSd928Dl8ueil0D6hphdtQW+CtJKTkH
         yXEw==
X-Gm-Message-State: ANoB5pkA9UWaOSMK/U/cIkS6pq48sW2RnSpVOHVXqdsL8d+graHIA3HC
        tgd38H+OaKe52KIp6ViHdHm6ANCEHGZm09sU
X-Google-Smtp-Source: AA0mqf6Jc+qkD0wdFx7K1LD9ZggUPCtkQaVkxSK919XpFPLsgT8bVNJyrJwZKQWX9FngOW7q2+sMcA==
X-Received: by 2002:a05:651c:119c:b0:279:7164:a0aa with SMTP id w28-20020a05651c119c00b002797164a0aamr3647679ljo.318.1669283857568;
        Thu, 24 Nov 2022 01:57:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e3c08000000b0027976ad6ab6sm59512lja.58.2022.11.24.01.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:57:37 -0800 (PST)
Message-ID: <c2b0686a-802c-1373-8746-dac6b42430ed@linaro.org>
Date:   Thu, 24 Nov 2022 10:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: qcom: Add SM8550 pinctrl
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
 <20221123152001.694546-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123152001.694546-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 16:19, Abel Vesa wrote:
> Add device tree binding Documentation details for Qualcomm SM8550
> TLMM device
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * based on recent bindings, like Krzysztof asked
>  * changed gpio-line-names maxItems to 210
>  * moved required and additionalProperties below
>  * dropped *-hog since there are no such nodes yet on SM8550
>  * switch to double quotes everywhere
>  * dropped qcom,i2c-pull
>  * dropped if clause for ^gpio*
>  * added tlmm label
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

