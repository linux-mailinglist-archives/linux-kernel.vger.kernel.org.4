Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80A6990A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBPKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBPKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:03:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA673A093
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:03:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id fj20so2052669edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MNk+N+FPh906nbSA6gdVy2qNPnVA6IBf/TJsfB7Coo=;
        b=N3U3Jty8e8wshJjZddf06gVT/9xE+hM6FmlBZPEKZ326EkoqUpiMINKtCZoagtrpIV
         xCG7iFgimslIOsULNr6jzeAMZjQUSg+1ag3malW4xt62JNac8OQkVRz8kqelk6cxP99h
         Epd9CMcRVqUxvRMHqGEF3IvGtJmYUh6Uv8d8+mKJdDshdxekPnG8KLhbZTGiWGOFYIwe
         m3A0jRXwf5+ao3DqrRVYcI9DuPP5G6PrO+30yuQhZbyN4D92m3yZu1LGFLJaODputzlm
         gH8jaKE4cNGm0nH44HKPf688XodCyi3Oa8UpLw6WMo7dWCIwkRUmWAIRKHaYA+IG4Kv+
         i//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MNk+N+FPh906nbSA6gdVy2qNPnVA6IBf/TJsfB7Coo=;
        b=NKQfmAA+JZ9yAOdcl8Ms0Z1HRobjRGInAWSdnXypVyahlJ9YywUodOIzQUucy//cIm
         HgccMXobHQtnXKEnQIQfSk8ncGAUD+FuP5+ZmOhJzw4IrUqgqE8NYkH/KgqIVUoHv9rj
         tVAKF6VNEFb5KFfdOO3qWfGpR5pRFD6SDirheZSISoSUUkQHUOaexUBY7HjGXdE8XmiC
         rpYNVaxI3vNVVpxMWbH8bOT52jlAmi2nSnAXuS/YPcm55K+Usi/9v4JPr7h0VgLn1Kma
         CMp8NRm18rO0mLSukMUtpjN3mSUzOeyB/GCoY4+gp/GH79WOolrrmQOal6VjKcQ8VgkX
         /AKA==
X-Gm-Message-State: AO0yUKU9MobkZ/+eavnDT66VC2Gusc5jYzQN6wkda0L6uNElh0KDvMCw
        tTkX0BF1WMeGYd1Do7O5i/dyzQ==
X-Google-Smtp-Source: AK7set9QKdl6+sYhEGzGPg25Wn1X7CiO91MgYy/8ehCtpSMckDA0cKkQdX8vvZ1xfmz3DNoRKn/A2g==
X-Received: by 2002:a05:6402:3890:b0:4ab:4410:ae1a with SMTP id fd16-20020a056402389000b004ab4410ae1amr1134284edb.15.1676541821824;
        Thu, 16 Feb 2023 02:03:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q11-20020a50c34b000000b004ad601533a3sm258643edb.55.2023.02.16.02.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:03:41 -0800 (PST)
Message-ID: <38824a96-804d-84a2-2750-be1325b2e1d2@linaro.org>
Date:   Thu, 16 Feb 2023 11:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5739
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        u0084500@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1676426457-1389-1-git-send-email-cy_huang@richtek.com>
 <1676426457-1389-2-git-send-email-cy_huang@richtek.com>
 <9c1f4d0e-83c9-014e-bdb1-38b4b0fb2bbf@linaro.org>
 <20230216095714.GA14578@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216095714.GA14578@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 10:57, ChiYuan Huang wrote:
> On Thu, Feb 16, 2023 at 10:12:15AM +0100, Krzysztof Kozlowski wrote:
>> On 15/02/2023 03:00, cy_huang@richtek.com wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add the binding document for Richtek RT5739.
>>
>> Subject: drop second/last, redundant "bindings for". The "dt-bindings"
>> prefix is already stating that these are bindings.
>>
> Then, refine it to "dt-bindings: regulator: Add Richtek RT5739 document" 

I propose also to drop "document" - it is also redundant. Can bindings
be something else than document?


>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  .../bindings/regulator/richtek,rt5739.yaml         | 80 ++++++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
>>> new file mode 100644
>>> index 00000000..7dc4f78
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/richtek,rt5739.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Richtek RT5739 2.4MHz 3.5A Step-Down Converter
>>> +
>>> +maintainers:
>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>> +
>>> +description: |
>>> +  The RT5739 is a step-down switching voltage regulator that delivers a
>>> +  digitally programmable output from an input voltage supply of 2.5V to 5.5V.
>>> +  The output voltage is programmed through an I2C interface capable of
>>> +  operating up to 3.4MHz.
>>> +
>>> +  Using a proprietary architecture with synchronous rectification, the RT5739
>>> +  is capable of delivering 3.5A continuously at over 80% efficiency,
>>> +  maintaining that efficiency at load current as low as 10mA. The regulator
>>> +  operates at a normal fixed frequency of 2.4MHz, which reduces the value of
>>> +  the external components. 
>>
>> Can we drop the marketing from kernel? Last part of sentence is not
>> related to this submission at all. The internal frequency also looks
>> unrelated to the topic...
>>
> Okay, too much marketing text. I'll shorten it and simply describe the function or
> voltage range only. 
>>> Additional output capacitance can be added to
>>> +  improve regulation during load transients without affecting stability.
>>> +
>>> +allOf:
>>> +  - $ref: regulator.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - richtek,rt5739
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  enable-gpios:
>>> +    maxItems: 1
>>> +
>>> +  richtek,vsel-active-high:
>>> +    description: |
>>> +      If property is present, use the 'VSEL1' register group for buck control.
>>> +      Else, use the 'VSEL0' register group. This depends on external hardware
>>> +      'VSEL' pin connecton.
>>> +    type: boolean
>>> +
>>> +  regulator-allowed-modes:
>>> +    description: |
>>> +      buck allowed operating mode
>>> +        0: Auto PFM/PWM mode
>>> +        1: Forced PWM mode
>>> +    maxItems: 2
>>> +    items:
>>> +      enum: [0, 1]
>>
>> So you always require two items? Thus I wonder what's the point of
>> having it in DT? To skip the property entirely if none of the modes are
>> allowed?
>>
> Not always need two. So does it mean no need to describe the 'maxItems' and 'Items'.

Your minItems is 2, so you always need two. If you accept one, the add
minItems: 1.



Best regards,
Krzysztof

