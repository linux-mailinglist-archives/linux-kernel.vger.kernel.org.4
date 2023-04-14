Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847666E1D86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:52:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8855BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:52:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qb20so43121332ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458760; x=1684050760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fmp8ZchOpiNG2bgVM43cfy9xBWr8LX0uUR8ohtYJtM=;
        b=NhTG8MUt4iHQzYV6YPU7qTPMofyphuSSGfhtCRTm04PdA21nzE3WKgV7lTo8RvLHT/
         shbLR4LH7iSxoJ4P6+DPJiNCp63R9ttGSrGPP9Y5fERIoFW3dKpeyvEIrzpiljn67qWa
         JQYWYuKcqaH6p9+i6hAbeobR3eNWvRlxfK0faxtqfvZgzpu0QoPVVrxuV7tEivsD6GXg
         k1AiMYpviS7qw3F64GKi1/KUdpk6k6qMvec6dviOfnnmzIk+AeuW+AMJTWPZ6AuUDwfz
         MrswjXWz7fujQRjuRbYOChHhJPIkxgSs+ckj2mXX9CaF2jmcb3xzPLJJUFKg92/bfG3O
         hIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458760; x=1684050760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fmp8ZchOpiNG2bgVM43cfy9xBWr8LX0uUR8ohtYJtM=;
        b=JIISyvuIjMH4n/4tyvkUAEeUZKiSqAUIj/WfyuDLd8kyvK7qHR8QmYQQjJ3cWLMGJ+
         x6VDhOkfU9/H20I4fhEU7NzMQkKtefji0QYskfZa2QVFjzPIAuwJG4ewnqJ+Fx9dtmdf
         3k7Dy7T7yl5vug+pZDG0McDnYiBD8wOEaIHnYT58JrIJy31vB95Ue81gNeU3cIrerdwh
         D3xUDFXW5Yl4KvXjd8okkpQCvJTKqz2PMGqV63dfZHK4tP9yI+6MwrcTgwsMo8B0+cMY
         HDd5giWFPxQi1Gn8qiT50M3MfiwVQtE1GNWiVRlzsF+v1QiyYJQ4paSagFGFsuLth4+o
         yQLw==
X-Gm-Message-State: AAQBX9fxBcatQiIvwdsMrbmEb7I8IflaVXl4aSrzeg543RZ4yf34mX+u
        jUMmI/O7OlNgO+ytLGm1y/GBNQ==
X-Google-Smtp-Source: AKy350YRsKtcInsagYhjMIH/3kqN+TRsFF3Y3YqqByEyRxT3vMGvMkCd8dpb/v4jEQkCj6iATO+xUw==
X-Received: by 2002:a17:906:3a42:b0:947:a6d7:e2b4 with SMTP id a2-20020a1709063a4200b00947a6d7e2b4mr5115571ejf.8.1681458760511;
        Fri, 14 Apr 2023 00:52:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709063a0a00b0094a6cf3b642sm2076345eje.142.2023.04.14.00.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:52:40 -0700 (PDT)
Message-ID: <7f2716c6-ea0c-d55b-490c-7fe0e0a14c65@linaro.org>
Date:   Fri, 14 Apr 2023 09:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230401185717.1b971617@jic23-huawei>
 <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org> <ZDkAYZV9z6cKCZQo@arbad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZDkAYZV9z6cKCZQo@arbad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 09:27, Andreas Klinger wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> schrieb am Sa, 01. Apr 11:42:
>> On 01/04/2023 11:09, Andreas Klinger wrote:
>>> Honeywell mpr is a pressure sensor family. There are many different
>>> types with different pressure ranges. The range needs to be set up in
>>> the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
>>> introduced.
>>>
>>> Add dt-bindings.
>>>
>>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>>> ---
>>>  .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
>>>  1 file changed, 74 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
>>> new file mode 100644
>>> index 000000000000..d6fad6f841cf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
>>> @@ -0,0 +1,74 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Honeywell mpr pressure sensor
>>> +
>>> +maintainers:
>>> +  - Andreas Klinger <ak@it-klinger.de>
>>> +
>>> +description: |
>>> +  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C
>>
>> Doesn't look wrapped according to Linux coding style (see Coding style).
>>
>>> +  interface is implemented.
>>> +
>>> +  There are many subtypes with different pressure ranges available. Therefore the minimum and
>>> +  maximum pressure values of the specific sensor needs to be specified in Pascal.
>>> +
>>> +  Specifications about the devices can be found at:
>>> +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
>>> +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
>>> +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
>>
>> Lines are not continued, so drop \
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: honeywell,mpr
>>
>> You need device specific compatible, not some generic one. Rename also
>> then the filename (should match the compatible).
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  reset-gpios:
>>> +    description:
>>> +      Optional GPIO for resetting the device. If not present the device is not resetted.
>>
>> Are you sure it is wrapped properly?
>>
>>> +    maxItems: 1
>>> +
>>> +  honeywell,pmin:
>>> +    description:
>>> +      Minimum pressure value the sensor can measure in pascal.
>>
>> Use standard unit suffix:
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
> There are only kilopascal as standard unit suffix. But with kilopascal as
> integer the accuracy of the driver is very rough. Therefore I would like to use
> pascal. E. g.:
> 
> honeywell,pmin-pascal
> 
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  honeywell,pmax:
>>> +    description:
>>> +      Maximum pressure value the sensor can measure in pascal.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Same.
>>
>> Why these values are suitable for DT?
> 
> Technically from the software perspective the sensors are identical with the
> only difference of having different pressure ranges, measurement units and
> transfer functions.
> 
> If we omit the pressure values and transfer function we'll need 96 compatibles
> and also 96 I2C ids.

Compatibles are expected to be specific. You used something generic, so
not correct, although I understand the reason behind.

If we go with generic compatible, do you guarantee that all Honeywell
mpr sensors - now and in 50 years - will be 100% compatible with this
set here?

Your description calls it "type mpr", not "model mpr", so I assume you
can have entirely different sensors coming soon which will not be
compatible.

> 
> But there are also custom sensor types. For covering them we'll need another
> compatible and just for this case the pressure values and transfer function.

OK, but isn't this the case in all devices? I could accept family of
identical devices with identical programming model where difference in
supported measurement range is described via this property.

Unfortunately you did not model it that way. Instead it represents all
possible devices even with incompatible programming model.

Best regards,
Krzysztof

