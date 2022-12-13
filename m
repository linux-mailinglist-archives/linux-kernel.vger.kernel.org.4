Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0533E64BA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiLMREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiLMRDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:03:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04B23E8C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:01:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so5906954lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZkkTB2vVZy5PFl0F2Kz7lMoOg/jX2YmaB9YFMk1IuU=;
        b=D36Tk+AKZRb1HHf7I8HW3An/qmmMmOAp8Mk/nupG82DmaofvnIRpwFofAP7Td9KVj3
         zCzv/ARz/g+HYtxK2zxvNQ/qbP0peQUwYQYS4AkNNp0CjBPtKJ0b9tSVCYEqFZZruzqV
         vkYUP+XXW+5ZaNOXMGW/jlXPEThpPGINVj1gBzKa44Zyrtbfftazjuf9WcXZX64sBT8n
         bPb6NQb1oRtkduSfECFo85TQINt0fmnYk293oMXCDfCuLodRx69ynQoGeJB1jiIXhAyq
         neDeWbbr7VoFOq1Zgh21G/MfixoggnEZm9SWIP03O2ZOmexyImHVI+xpuke1IqC5n0pH
         U3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZkkTB2vVZy5PFl0F2Kz7lMoOg/jX2YmaB9YFMk1IuU=;
        b=upbIZE+DURVzsm1t1F7NDBhenZTqin+og2flMkVH5YZu5lOZ8647OphOg/fztJdteY
         gm30lFDu+3JHuI/d9WT+KNoUx7ZgPDnpdUXTf7kEPgQv6hOt5+wWQaQkMy2YP1cIUfUg
         WHo/sEjSUv9UoIo0RkGjd7gQChmA/a4WtPi2DXDaHoyj/SrR+mPErZ45/H9BZBTdTVA/
         /4/XL7zMDM0+9sJpHeEq3YvUGVCiG1gqYNpnO12PxLIS3UULTx7sTKZJdCrbya36cNVM
         /69G6wD8W366MhMPqCMBOvX7ciCrNS0NQPQ24L28ILgO7je0ngCsm+R2FjhDKY7498/g
         t/wg==
X-Gm-Message-State: ANoB5pk8wzv5YcatLdqpsegw8aEW63YuLgYfK0IKNB7j0E5heLuddLR0
        bPF8FAJLibfFoUxF81SVyrsv8g==
X-Google-Smtp-Source: AA0mqf6IsyLAWx1ryfbYJap6V4JVf8QaCT3d/ZARAIXp+XyrWMM+lZo/jDkWivsgVkvxm17PzWv42Q==
X-Received: by 2002:a05:6512:2829:b0:4b6:f30c:c7a9 with SMTP id cf41-20020a056512282900b004b6f30cc7a9mr2249509lfb.1.1670950873219;
        Tue, 13 Dec 2022 09:01:13 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id z2-20020a056512370200b004b5766f48d8sm443208lfr.19.2022.12.13.09.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:01:12 -0800 (PST)
Message-ID: <b289a9c5-54de-5ca4-b247-90751be05fa9@linaro.org>
Date:   Tue, 13 Dec 2022 18:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] dt-bindings: i2c: qcom,i2c-cci: Fall back to common
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213115628.105149-1-konrad.dybcio@linaro.org>
 <b8be66e0-f987-b3ec-b78e-5be8bf54b05e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b8be66e0-f987-b3ec-b78e-5be8bf54b05e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 17:58, Krzysztof Kozlowski wrote:
> On 13/12/2022 12:56, Konrad Dybcio wrote:
>> Almost every compatible string in the CCI driver is a duplicate. Adjust
>> the bindings to include a common (first-soc-implementing-vX) compatible
>> to remove the need to keep adding superfluous compatible strings.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml | 25 +++++++++++++------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> index cf9f8fda595f..65cf7860a9a0 100644
>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> @@ -12,14 +12,23 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - qcom,msm8226-cci
>> -      - qcom,msm8916-cci
>> -      - qcom,msm8974-cci
>> -      - qcom,msm8996-cci
>> -      - qcom,sdm845-cci
>> -      - qcom,sm8250-cci
>> -      - qcom,sm8450-cci
>> +    oneOf:
> 
> Except missing test,
Hm? I tested this locally with dt_binding_check and it passed..

how about also adding a comment to the driver, that
> list of compatibles should not grow when not needed?
Sure.

Konrad
> 
> Best regards,
> Krzysztof
> 
