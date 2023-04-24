Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5376EC97F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjDXJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjDXJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:53:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74DAB6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:53:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3010889c6ebso2475756f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682330031; x=1684922031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVPhALJrCoU5a5TzkxQ02eTDQVTGy1JXUE3kOBuPy9U=;
        b=cH+5aVxjyXdp4N6qOqYqvD9EY9L9cMhwwWk8/OtzkVy8nVnYwMlexMYd8AC7O1APdT
         1uRLL9r0Q9rw982Z6efl/wRbj6Ud/7C0ZtnJ6J514kF1UhvLi/weRuOnIESg6h7d1PYl
         gLrtzH4MBI369mHIeMmj5mindbHMtIhLRBxX0A4S6kBSOtW/e0XTqXyFoR/bPhCVf8/C
         4lx7+p2Oto+8Rv34qNixq8r7YT/WvVgXzklh7ousCtRBgtKCrfQqEDxkSX+B/XvUgrBE
         uY3q5b2l/NV4mvnCZVoPLHxu+hS+OU2CJ6+YhKB0cZkxGaqdf6/5vrTu2v1JMexmXrJp
         qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330031; x=1684922031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVPhALJrCoU5a5TzkxQ02eTDQVTGy1JXUE3kOBuPy9U=;
        b=gGpg85KZZ4u3nHMsnshosMbCHtkqb9I4AUoHFGt1ea44mKyugLdnadXfwJOwEaSGgi
         j4Ch3aEf5vddY6oCzjyN9toupRUF9jftQhpTBBcrogefs3/X4LwDGOU5Y4BsgFAP29Ii
         VVl/CVB64UqgyxF7SXO1acAj7TNa3BIkxDNR3GUz2Kxsg2dWjvrJyYc6FiNBP6P+mEje
         u0svSSbkXQmauaXkplDOw5Dw1Mj6uLro35XbitjvRbLDKv/AJGhDEL8BuKIGTu0S3xOt
         0oFi4kZRatWm9nBDr2JB8c4Qo+T+cWlHOwDkFwGRrhdvwi5YAws+pT08dqpxY8zqVb/N
         FvPQ==
X-Gm-Message-State: AAQBX9etlvoOnNc2V10HV8s9orGTV8tktn4FmC+3lsDB0x+Qpi8YEDda
        gCHllJ202SwCNsbIelh+qcRUDg==
X-Google-Smtp-Source: AKy350YXhwIcFwNEjcyJcmueu1N5mpTuj3jp0eT5mMAWUHrjq5IbvZ7jDxvQscBYvU7wyIqQQ51o+g==
X-Received: by 2002:a05:6000:118e:b0:2ff:4b8a:6453 with SMTP id g14-20020a056000118e00b002ff4b8a6453mr9013700wrx.5.1682330031277;
        Mon, 24 Apr 2023 02:53:51 -0700 (PDT)
Received: from [192.168.29.232] ([49.37.170.173])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003ee443bf0c7sm15141850wms.16.2023.04.24.02.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:53:51 -0700 (PDT)
Message-ID: <88f9a008-2861-284c-76c4-7d416c107fbb@9elements.com>
Date:   Mon, 24 Apr 2023 15:23:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420111759.2687001-1-Naresh.Solanki@9elements.com>
 <76e57634-75dd-01e8-9c56-36ed7de17812@linaro.org>
 <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
 <be129c4f-3ad7-c54b-936e-08b142608ebc@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <be129c4f-3ad7-c54b-936e-08b142608ebc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 24-04-2023 03:12 pm, Krzysztof Kozlowski wrote:
> On 24/04/2023 11:18, Naresh Solanki wrote:
> 
>>>> Changes in V2:
>>>> - Update subject
>>>> - Drop blank lines
>>>> ---
>>>>    .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
>>>>    1 file changed, 52 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> new file mode 100644
>>>> index 000000000000..1aaedfd7cee0
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> @@ -0,0 +1,52 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Maxim max6639
>>>
>>> What is this device? fan controller?
>> Yes Fan controller.
>> Do you want me to update the title here as:
>> "Maxim MAC6639 2 channel fan controller & temperature monitor" ?
> 
> Enough would be:
> Maxim MAX6639 Fan Controller
Ack
> 
> 
>>
>>>
>>>> +
>>>> +maintainers:
>>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> +
>>>> +description: |
>>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>>> +  fan-speed controller.  It monitors its own temperature and one external
>>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>>> +
>>>> +  Datasheets:
>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - maxim,max6639
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  '#address-cells':
>>>> +    const: 1
>>>> +
>>>> +  '#size-cells':
>>>> +    const: 0
>>>
>>> Why do you need these two properties?
>> Ack. Will remove them.
>>>
>>> Anyway, the binding looks incomplete. Where are the supplies? Interrupts?
>> This patch just adds basic support to the existing platform driver.
>> Intention is to be able to call the driver from DT with basic
>> initialization from driver the existing driver.
> 
> Bindings should be rather complete. Here the datasheet is accessible and
> few properties quite obvious, so I don't see a reason to skip them.
I agree with you. But currently the driver which is already merged 
doesn't has it implemented.
And will be working on separate patch to include this later.
> 
> 
> Best regards,
> Krzysztof
> 

Regards,
Naresh.
