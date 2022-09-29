Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0289F5EEE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiI2HHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiI2HGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:06:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF11114E7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:06:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k10so890990lfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kaeNPsRWMl3Iqw+3/K7c46xI8ltqOrZ2hG4WVH/9Q3A=;
        b=hKjEhVTZ5ga7vMXjhWjmzmPc2W/eEybKJTIDj0b1rj5ot00VMfjY22pdn4d13ksPmR
         HOSTpTI2cDxlceOUTXsaH0KZHpVhbsdxz1Tabcr7ms8U+zHBxoa4d3SV+jcXdPQuaTAW
         0PBw1kYnI4ofsntMqgUX2SMDyZFUOximqeqlyOnL3VMnCi7wzwhzMzc99nMvCf03tlzf
         7PlRAIGMRNxJkqpWUTEwI0V0C80aozNi40abRUGwd0BMmPJsXv45p92TZf8Q+cYE+DtZ
         F5CWEz6IXvgQT2tXNtrTY9gtDVvl1iDpKXePbfqKPZ96RyJCadlLZZuTnd03AxZu8TrC
         PZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kaeNPsRWMl3Iqw+3/K7c46xI8ltqOrZ2hG4WVH/9Q3A=;
        b=opyXnb63+wXLWLB8fhBvRGP90+MaBi8uufhE3YL/ipvT4dU/YIDvtAMb2OYkxCtqbX
         VCjkXTsT0g0n1lpf600IKZeCPCGrE6iohnXOdRUkm5dKIkIw7JrNLV6r0S1iCKkvyRO+
         NK9L7XaUGn1JPp9Q99/6FCfqYkB2GeNyg3jz/bqFycLA/cXNtbaOOQ6nZZzbk13vRerI
         ciaXdZz5KjBHWEiN9HyWF8N7gMdqcEuaAvcR17uGmpDfckBODBj3LJq+j2k6exxFmeA+
         Kx5WSdgFUT+oxav80YxjtA3fY3iMN0msi5byR/B5ulQiCn2EluFtu3QxpAwntSgrz4cv
         hUDg==
X-Gm-Message-State: ACrzQf3tJSfoRKFXVtCk/vZq9sbB16//uupBBQ69m42pcE3q3m9YxlK6
        sfT6929Hfxiu8rZFyVTcKHinSTs02dAB5A==
X-Google-Smtp-Source: AMsMyM5RSglTdnGHG03FMHcm8GTzJEO/zRHOg8h1SuPzp+9oy5QGv/Vx90N6IrsvwZoYzYLf2dZHVQ==
X-Received: by 2002:a05:6512:3409:b0:499:faa6:edb0 with SMTP id i9-20020a056512340900b00499faa6edb0mr716949lfr.682.1664435176026;
        Thu, 29 Sep 2022 00:06:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p19-20020ac24ed3000000b004a03d5c2140sm695157lfr.136.2022.09.29.00.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:06:15 -0700 (PDT)
Message-ID: <d6dc534f-2dc4-979c-ddad-c2122db7923a@linaro.org>
Date:   Thu, 29 Sep 2022 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
 <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
 <6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org>
 <2d6fac8d-0ac1-75bb-0b4c-c2c34583b09e@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2d6fac8d-0ac1-75bb-0b4c-c2c34583b09e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 04:20, Fenglin Wu wrote:
> 
> 
> On 2022/9/28 16:21, Krzysztof Kozlowski wrote:
>> On 28/09/2022 04:42, Fenglin Wu wrote:
>>> Add binding document for flash LED module inside Qualcomm Technologies,
>>> Inc. PMICs.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>
>> You did not Cc me on first patch, so difficult to say how much it
>> matches the driver... There is also no DTS.
> Thanks for reviewing the binding change, I sent the driver changes in 
> the same series and you can check it here:
> https://lore.kernel.org/linux-leds/6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org/T/#m97f71ce3f291f62d65f8107352d8ab9507093ab2
> 
> I will add you in email to list when sending next patchset.

Don't add just mine. Use instead scripts/get_maintainers.pl. For small
patchsets recipients should get everything. For big patchsets it is
usually split, where everyone receive only cover letter. It's not the
case here...

>>
>>> ---
>>>   .../bindings/leds/leds-qcom-flash.yaml        | 108 ++++++++++++++++++
>>>   1 file changed, 108 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>> new file mode 100644
>>> index 000000000000..52a99182961b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
>>
>>
>> Filename matching compatible if there is one fallback (e.g.
>> qcom,spmi-flash-led.yaml).
>>
> Sure, I will update the file name to match with the fallback compatible 
> string.
>>> @@ -0,0 +1,108 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/leds-qcom-flash.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
>>> +
>>> +maintainers:
>>> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
>>> +
>>> +description: |
>>> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
>>> +  The flash LED module can have different number of LED channels supported
>>> +  e.g. 3 or 4. There are some different registers between them but they can
>>> +  both support maximum current up to 1.5 A per channel and they can also support
>>> +  ganging 2 channels together to supply maximum current up to 2 A. The current
>>> +  will be split symmetrically on each channel and they will be enabled and
>>> +  disabled at the same time.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - qcom,spmi-flash-led
>>> +          - qcom,pm8150c-flash-led
>>> +          - qcom,pm8150l-flash-led
>>> +          - qcom,pm8350c-flash-led
>>
>> I doubt these are all different. You should use fallback, which also
>> will make use of the "items" you used...
> pm8150c and pm8150l are different PMIC variants which have same flash 
> LED module with 3 flash LED channels, while pm8350c has a different 
> flash LED module with 4 flash LED channels. They can all use 
> "qcom,spmi-flash-led" as the fallback because the driver has code logic 
> to detect HW sub-types. 

If driver binds to only one compatible, it is expected to be the
fallback for all others. There might be exception for this rule but it
does not look like here.

> But I was thinking to give out the PMIC names 
> here so anyone who is using the driver could easily identify if the 
> driver is suitable for the HW that he/she is using.

I did not say to remove other compatibles, but to use one fallback for
all of them.

Best regards,
Krzysztof

