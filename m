Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1456F6943
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjEDKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:47:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BB4C3C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:47:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so474287a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683197243; x=1685789243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDUr+SdvpIiSP6qCRawb7YyHx7gIgkjLW8C3I6l0aaE=;
        b=M5L02rtq5Qei5mqUn254sUJrBGf9jx3pWpRXWA6JYYQwFt6LBCGKzPhdPKjhYaKvtn
         oS61bwhp7z6t3fMDCbBgH7uoRUiz1UXHDKDRJ4oJzasKN1UgShUNxeIhWR/9/juaooJB
         YxXJASaSs78VvAOQKAmkk1DJN21vg+GPG1Ww+muGa1YURyGRUV1Kw7p80oOwHK+M4ZRh
         yWEzdGsQPWd6K86T4L/kG5oshWbIts7EHmF5NMGekKL7oRQTwwA4GDJJc/SFwnlMdmf2
         x/inDbEgMZfxhMXovsB5o27TC6FNF20eGUqQyjZXA42y0CPLmRW3+FtujcMmC/9ihc+7
         Tplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197243; x=1685789243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDUr+SdvpIiSP6qCRawb7YyHx7gIgkjLW8C3I6l0aaE=;
        b=h/bDYoumm+3uzUnu/HwYlpnVRe4k2h4EYF1RH4fHuNIaxTL1BnNwWjNWRCQiLysUfz
         6DcPxu2kjCg+5FNGRcBQsmg3Tt/SgtQcI5LRs3Mcn91PN1xBXMU39rwdssJhGzcF8RN/
         6vUYgFY8ofXT4mIgHsyPlk2tAGZ/XXsDG0kWBp6quSg9LaoSncjr7YuL+YVXz5OK5f3W
         hI0I6RRiCHzUm6xDzYuXKSp4BGt0O2ZiUaDZf3SvSoveWjW3cgEfIL0gVSRFOQqG1ZSx
         qLR/PrvyM5Abd40WfaQnq/EkQG6ursy1u9rVtnjbb1ny6lw1WIbEREHDe705AoH/7OPt
         X6MQ==
X-Gm-Message-State: AC+VfDzYtN4TomTo2g2LM9M5AFdUFPrIu1Xp+eD7XeinIo39DEKnxsJw
        IG1NhYmByb+3/VA6unk6NFiuIm0HUyGAlw9VhDzyGw==
X-Google-Smtp-Source: ACHHUZ70/ErzHYXj4QS5QBI/TWmWKk1BXhP3YcX1PlCjQqCcnxqrV+mBi+XnXt9mXP60CKmC/T0xIg==
X-Received: by 2002:a17:907:3203:b0:953:43a1:1988 with SMTP id xg3-20020a170907320300b0095343a11988mr5536477ejb.46.1683197243060;
        Thu, 04 May 2023 03:47:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id ia10-20020a170907a06a00b00961277a426dsm7318940ejc.205.2023.05.04.03.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:47:22 -0700 (PDT)
Message-ID: <80b60de0-dcb5-303f-8d13-f4b1cf7d8521@linaro.org>
Date:   Thu, 4 May 2023 12:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
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
 <88f9a008-2861-284c-76c4-7d416c107fbb@9elements.com>
 <bd45ea5d-e6e4-403a-e855-376e0f647f91@9elements.com>
 <20eb1d0e-0aa2-9d41-7ba5-2feb148748d0@linaro.org>
 <9d989c4c-7c9e-9e95-133f-03741d07198b@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d989c4c-7c9e-9e95-133f-03741d07198b@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:47, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On 03-05-2023 09:48 pm, Krzysztof Kozlowski wrote:
>> On 03/05/2023 10:26, Naresh Solanki wrote:
>>> Hi Krzysztof,
>>>
>>> On 24-04-2023 03:23 pm, Naresh Solanki wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 24-04-2023 03:12 pm, Krzysztof Kozlowski wrote:
>>>>> On 24/04/2023 11:18, Naresh Solanki wrote:
>>>>>
>>>>>>>> Changes in V2:
>>>>>>>> - Update subject
>>>>>>>> - Drop blank lines
>>>>>>>> ---
>>>>>>>>     .../bindings/hwmon/maxim,max6639.yaml         | 52
>>>>>>>> +++++++++++++++++++
>>>>>>>>     1 file changed, 52 insertions(+)
>>>>>>>>     create mode 100644
>>>>>>>> Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>> b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..1aaedfd7cee0
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>> @@ -0,0 +1,52 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>> +
>>>>>>>> +title: Maxim max6639
>>>>>>>
>>>>>>> What is this device? fan controller?
>>>>>> Yes Fan controller.
>>>>>> Do you want me to update the title here as:
>>>>>> "Maxim MAC6639 2 channel fan controller & temperature monitor" ?
>>>>>
>>>>> Enough would be:
>>>>> Maxim MAX6639 Fan Controller
>>>> Ack
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>>>> +
>>>>>>>> +description: |
>>>>>>>> +  The MAX6639 is a 2-channel temperature monitor with dual,
>>>>>>>> automatic, PWM
>>>>>>>> +  fan-speed controller.  It monitors its own temperature and one
>>>>>>>> external
>>>>>>>> +  diode-connected transistor or the temperatures of two external
>>>>>>>> diode-connected
>>>>>>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>>>>>>> +
>>>>>>>> +  Datasheets:
>>>>>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    enum:
>>>>>>>> +      - maxim,max6639
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    maxItems: 1
>>>>>>>> +
>>>>>>>> +  '#address-cells':
>>>>>>>> +    const: 1
>>>>>>>> +
>>>>>>>> +  '#size-cells':
>>>>>>>> +    const: 0
>>>>>>>
>>>>>>> Why do you need these two properties?
>>>>>> Ack. Will remove them.
>>>>>>>
>>>>>>> Anyway, the binding looks incomplete. Where are the supplies?
>>>>>>> Interrupts?
>>>>>> This patch just adds basic support to the existing platform driver.
>>>>>> Intention is to be able to call the driver from DT with basic
>>>>>> initialization from driver the existing driver.
>>>>>
>>>>> Bindings should be rather complete. Here the datasheet is accessible and
>>>>> few properties quite obvious, so I don't see a reason to skip them.
>>>> I agree with you. But currently the driver which is already merged
>>>> doesn't has it implemented.
>>>> And will be working on separate patch to include this later.
>>> Please let me know if this approach is acceptable, or if there are any
>>> other suggestions or concerns that you have.
>>
>> You are adding new bindings, so what does the driver has to do with it?
> The reason for adding these new bindings is to enable the use of the 
> driver on my machine. Without the compatible string, it would not be 
> possible to use the driver.
> 
> Currently, the driver initializes the device with defaults, which is 
> good enough for my application. Also, as you previously pointed out, it 
> uses the optional 'fan-supply' which will be included in the next patch 
> revision.
> 
> I hope this clarifies my reasoning. Could you kindly confirm if we can 
> proceed with this approach?

No, we cannot, because we asked you to fix things there. Your entire
explanation about compatible and driver is not related to the comment
you received: bindings should be complete. You argue that bindings do
not have to be complete, because of something with driver. This is not
related. Bindings are not for driver.

Best regards,
Krzysztof

