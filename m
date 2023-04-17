Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE946E42AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjDQIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjDQIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:35:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7C5260
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:35:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xi5so62010574ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681720516; x=1684312516;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOi5tK+OGPHQm6htXDR5U68ZReexAHOUaRN7I2oGD8k=;
        b=E0Kx67cEiCPHehDco2mDIZiGpabs3Max5Ma2CbbdHaWB96ceYQ1K/8mgvvo/7kcHAo
         SSsrNC5jnbLrZmpLWHwkNAfhTvLXXvzpxNeq96arEQdhR+eD60oiCFLJwSdXn/2IWgeC
         dBWUt4VvJykpacVnAGF2I/XVGDdMRYiSiVEN8esTohYaDuZsDoFQWFVGvmiClr9EW0hR
         UAloZtt0Zo011j9XU+db0bGxji3glFLyK/sn3shpOHMP4GkqvmntN92zixnqxgTxiHtm
         WZvzp3oo+blot76VZLHKcVGGRz9XTkLKIYK74jWioPtqPrua4y1+ZP6ep+NwiUj3hLh9
         Hp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720516; x=1684312516;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOi5tK+OGPHQm6htXDR5U68ZReexAHOUaRN7I2oGD8k=;
        b=R9ewmvcUIF966ehBFAdq+gBFzUt72e2hSUjhFTF7vAQFSbFdtf0EH4aZoi3RnaW3Or
         lIoo+oaw1YX5ePCNsZQeYdOiWvc2od9BTizt/iUNa6THxn3L/niwv6wmo3qqDoz7v2pd
         RWiSIeONj/evNeU6+HGH373qsi4VO/tJYm7DBRr19hcjD1jX1pwNGRrgFJlPutnWOsqL
         3gblxAaYBUccRnI//wyZpGvMGwtcgaBuVmDbdBOF9d9CPqAXDgqY+KI9vpGxkQVicDJ6
         kTUsyWAuulnLTUgTvDkpkRmAslMOUuxogPzwQfcM1mlTXJGam7FcgB43jsMliot0vDY1
         iB+A==
X-Gm-Message-State: AAQBX9dD/YcvHVYRtNRAYtfsjVf8RSC941MYSjmOh/7ibrgzhRqn7zcu
        G5SArfoXgvUlRgfRfZob6TfCZ/xEUvivD0HSZx8=
X-Google-Smtp-Source: AKy350YoaaDUDxlz8DqeHMiEL4jmIMDW5roQccOUuiMRDsiw6Rk8TxI/S7fcJSHDG0KUlsI2rAIyJw==
X-Received: by 2002:a17:906:8604:b0:94e:f176:43cc with SMTP id o4-20020a170906860400b0094ef17643ccmr6987784ejx.39.1681720516598;
        Mon, 17 Apr 2023 01:35:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906524f00b0094e1026bc66sm6393487ejm.140.2023.04.17.01.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:35:16 -0700 (PDT)
Message-ID: <1632bd15-c9b6-4bb8-13b2-d0c4b068315c@linaro.org>
Date:   Mon, 17 Apr 2023 10:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/18] dt-bindings: interrupt-controller: qcom-pdc: add
 compatible for sa8775p
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20230327125316.210812-1-brgl@bgdev.pl>
 <20230327125316.210812-4-brgl@bgdev.pl>
 <CAMRc=Mfe6gCM=Mz6Can6xsSsrjX-9T_aR2Yev+b57koky_az-A@mail.gmail.com>
 <CAMRc=Mfw+4Co8JPz51_E+DSawijO8EB6rMmFXEmM0e5F3Fg_8A@mail.gmail.com>
 <3877cb9e-9647-0acf-f705-d34fe2c731ff@linaro.org>
 <CAMRc=MeT4VLiLu5DJSXHqDdZv2gEoC-B7aPvoXVpc3SokQcrFg@mail.gmail.com>
 <b46028dc-b539-384c-78aa-2f5e6f6516f2@linaro.org>
In-Reply-To: <b46028dc-b539-384c-78aa-2f5e6f6516f2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 09:55, Krzysztof Kozlowski wrote:
> On 17/04/2023 09:27, Bartosz Golaszewski wrote:
>> On Sun, Apr 16, 2023 at 5:04 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 14/04/2023 11:33, Bartosz Golaszewski wrote:
>>>> On Thu, Apr 6, 2023 at 4:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>> On Mon, Mar 27, 2023 at 2:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>
>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Add a compatible for the Power Domain Controller on SA8775p platforms.
>>>>>> Increase the number of PDC pin mappings.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>>>> ---
>>>>>>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml     | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>>>>> index 94791e261c42..641ff32e4a6c 100644
>>>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
>>>>>> @@ -26,6 +26,7 @@ properties:
>>>>>>    compatible:
>>>>>>      items:
>>>>>>        - enum:
>>>>>> +          - qcom,sa8775p-pdc
>>>>>>            - qcom,sc7180-pdc
>>>>>>            - qcom,sc7280-pdc
>>>>>>            - qcom,sc8280xp-pdc
>>>>>> @@ -53,7 +54,7 @@ properties:
>>>>>>    qcom,pdc-ranges:
>>>>>>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>>>>      minItems: 1
>>>>>> -    maxItems: 32 # no hard limit
>>>>>> +    maxItems: 38 # no hard limit
>>>
>>> I don't think the limit is correct. I still see warnings with this
>>> patch. We already have 57 elements, so limit should be I guess 128 or
>>> something.
>>>
>>
>> You mean for other platforms? This limit applies to sa8775p as the
> 
> I see errors on sa8775p.

OK, so as you pointed out it's about other platform - sa8540p-ride.
Anyway you update now this line to bump the limit, so bump it to
something high instead of changing it in two patches.

Best regards,
Krzysztof

