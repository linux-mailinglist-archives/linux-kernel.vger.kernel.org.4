Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA746F6A20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjEDLg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:36:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338459D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:36:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aae5c2423dso3088815ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1683200211; x=1685792211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUHArhlcp3qSfySTPqT1ZPP2t/W0eOsOr4roXo47DNw=;
        b=J/rrtMF5eCYfqJL/HfPD3lLSqeolJkc1WqXkA+11V/xw5p59FxZsSiSfU5fDFdgioK
         fWR/Nu3fnyEVoFMzsBNx4N4P6YXKBy3wOThnXz60Eme/oAbDCdl4aYLNdXeOahywONLc
         ibszmyZKUmKA2JBc6aE8bpSO9vjWVIvQXK48A5uGFeOX8AjERGohb97ZwXqqlsP1/mmD
         PiFn3vbrnTYHeSVJs/Y7BQYTGDkRF0MQEFtH/Qd2MQ+0YRPv39iurrd5sG0J3kn7a7Wn
         YshYzlnop5x/oUxl1bX87LSTCad/d4lRxdIDPib3Tmt9/Coj8vlgZo+pcVYEQmxTGuJr
         s6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200211; x=1685792211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUHArhlcp3qSfySTPqT1ZPP2t/W0eOsOr4roXo47DNw=;
        b=ABFuq9O1NXHugUmZ4bwQgpqNhuU5WBM6nvPeBZXsw5qftqHOa8J/yNzjkI4OEenn0W
         55ll5WfwVsAiWbqo0ANQWBuNho5iIyN054Y677JM7IHUeb9+TDAoSG+mHSYOHzJIdMe/
         +m3AFI6JjStGl98EeYQeGVpr4/KIOCKiMTRkp6OfM6lt2h/rkbwMuHDfn8qYztLoU159
         RW7ECm5Uhi45JdaJax0HR/nB+CVncufsvcdiR8nG7NXlKIy3tlAnFrc00wzl+n0o97pD
         SGyUoXKNCRG4EJwvXj9YlQqqCq6flmgeUF8glp4XP9GHhfwb1xu2oLzx7Bkis0MLyAQI
         46NQ==
X-Gm-Message-State: AC+VfDw+ulb2I8xNHwP61NrgL+Sbhw8/C2cIlGabNbtyFYHj5ObHvWd4
        WN6MkHbewa61zXnHKiUUkHvh4NrsvZeSpmwEmYY=
X-Google-Smtp-Source: ACHHUZ4reHpy6jWeeqIb6ngwMygitIdCsQkqiY1aIy5R9QV1Oa/nx+X0X9zQP6eTsEh/Lhn2ZXAzQw==
X-Received: by 2002:a17:902:b591:b0:1ab:8f4:af3a with SMTP id a17-20020a170902b59100b001ab08f4af3amr2860275pls.39.1683200210820;
        Thu, 04 May 2023 04:36:50 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001a9b29b6759sm12996966plx.183.2023.05.04.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:36:50 -0700 (PDT)
Message-ID: <45236017-22d2-f9f8-0069-77195e49221d@9elements.com>
Date:   Thu, 4 May 2023 17:06:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
Content-Language: en-US
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
 <88f9a008-2861-284c-76c4-7d416c107fbb@9elements.com>
 <bd45ea5d-e6e4-403a-e855-376e0f647f91@9elements.com>
 <20eb1d0e-0aa2-9d41-7ba5-2feb148748d0@linaro.org>
 <9d989c4c-7c9e-9e95-133f-03741d07198b@9elements.com>
 <80b60de0-dcb5-303f-8d13-f4b1cf7d8521@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <80b60de0-dcb5-303f-8d13-f4b1cf7d8521@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 04-05-2023 04:17 pm, Krzysztof Kozlowski wrote:
> On 04/05/2023 11:47, Naresh Solanki wrote:
>> Hi Krzysztof,
>>
>> On 03-05-2023 09:48 pm, Krzysztof Kozlowski wrote:
>>> On 03/05/2023 10:26, Naresh Solanki wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 24-04-2023 03:23 pm, Naresh Solanki wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 24-04-2023 03:12 pm, Krzysztof Kozlowski wrote:
>>>>>> On 24/04/2023 11:18, Naresh Solanki wrote:
>>>>>>
>>>>>>>>> Changes in V2:
>>>>>>>>> - Update subject
>>>>>>>>> - Drop blank lines
>>>>>>>>> ---
>>>>>>>>>      .../bindings/hwmon/maxim,max6639.yaml         | 52
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>      1 file changed, 52 insertions(+)
>>>>>>>>>      create mode 100644
>>>>>>>>> Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>>> b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..1aaedfd7cee0
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>>>>>> @@ -0,0 +1,52 @@
>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>>>> +%YAML 1.2
>>>>>>>>> +---
>>>>>>>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>> +
>>>>>>>>> +title: Maxim max6639
>>>>>>>>
>>>>>>>> What is this device? fan controller?
>>>>>>> Yes Fan controller.
>>>>>>> Do you want me to update the title here as:
>>>>>>> "Maxim MAC6639 2 channel fan controller & temperature monitor" ?
>>>>>>
>>>>>> Enough would be:
>>>>>> Maxim MAX6639 Fan Controller
>>>>> Ack
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +maintainers:
>>>>>>>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>>>>>>>> +
>>>>>>>>> +description: |
>>>>>>>>> +  The MAX6639 is a 2-channel temperature monitor with dual,
>>>>>>>>> automatic, PWM
>>>>>>>>> +  fan-speed controller.  It monitors its own temperature and one
>>>>>>>>> external
>>>>>>>>> +  diode-connected transistor or the temperatures of two external
>>>>>>>>> diode-connected
>>>>>>>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>>>>>>>> +
>>>>>>>>> +  Datasheets:
>>>>>>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    enum:
>>>>>>>>> +      - maxim,max6639
>>>>>>>>> +
>>>>>>>>> +  reg:
>>>>>>>>> +    maxItems: 1
>>>>>>>>> +
>>>>>>>>> +  '#address-cells':
>>>>>>>>> +    const: 1
>>>>>>>>> +
>>>>>>>>> +  '#size-cells':
>>>>>>>>> +    const: 0
>>>>>>>>
>>>>>>>> Why do you need these two properties?
>>>>>>> Ack. Will remove them.
>>>>>>>>
>>>>>>>> Anyway, the binding looks incomplete. Where are the supplies?
>>>>>>>> Interrupts?
>>>>>>> This patch just adds basic support to the existing platform driver.
>>>>>>> Intention is to be able to call the driver from DT with basic
>>>>>>> initialization from driver the existing driver.
>>>>>>
>>>>>> Bindings should be rather complete. Here the datasheet is accessible and
>>>>>> few properties quite obvious, so I don't see a reason to skip them.
>>>>> I agree with you. But currently the driver which is already merged
>>>>> doesn't has it implemented.
>>>>> And will be working on separate patch to include this later.
>>>> Please let me know if this approach is acceptable, or if there are any
>>>> other suggestions or concerns that you have.
>>>
>>> You are adding new bindings, so what does the driver has to do with it?
>> The reason for adding these new bindings is to enable the use of the
>> driver on my machine. Without the compatible string, it would not be
>> possible to use the driver.
>>
>> Currently, the driver initializes the device with defaults, which is
>> good enough for my application. Also, as you previously pointed out, it
>> uses the optional 'fan-supply' which will be included in the next patch
>> revision.
>>
>> I hope this clarifies my reasoning. Could you kindly confirm if we can
>> proceed with this approach?
> 
> No, we cannot, because we asked you to fix things there. Your entire
> explanation about compatible and driver is not related to the comment
> you received: bindings should be complete. You argue that bindings do
> not have to be complete, because of something with driver. This is not
> related. Bindings are not for driver.

I understand that complete bindings are important, but as the driver is 
already merged and functional, my immediate goal is to enable its use on 
my machine. I will work on a separate patch to include the interrupts in 
both binding & driver.

> 
> Best regards,
> Krzysztof
> 
