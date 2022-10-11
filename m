Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C845FB878
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJKQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:46:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B91A5717;
        Tue, 11 Oct 2022 09:46:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 3so12493228pfw.4;
        Tue, 11 Oct 2022 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTbRnfl89ade6OCV6TvnorRTh5pmmrQFCO3InValYks=;
        b=gx+CzTleAu6ybh2TLBk82o/4m29LCQlY4Yi437f5iok6SdHZ2HZA+cVn8hkrjdYwZF
         Av7nJeCNOeAm/67BxgscaeR0r5be8waLfpvJ7nUyN1AZ2nof9olcQjCA6kDdvGSlfYc2
         VjxH+TLXyTaprs4Xnnnn564ysjquhJFHbhG1yZa+UwaH7/wCYfM8ey73Q6hTh5NsrKs/
         eUUOIQtvuR8r5FUaxzhJczH0a+H7eKYfd1ykZJGtPwNIOICjLQolEnVRi4Fu4S9luAQS
         1/xbqzQIrV/DxDo3TUFP4ba8k9SDE5MFrWjzVMszNSaTGp7gu5Xbi34IdmjFLG4Pq7uv
         X8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTbRnfl89ade6OCV6TvnorRTh5pmmrQFCO3InValYks=;
        b=c4IB+m2O32U7obSMYfbJwKCsz2BBwhXQcuWIfzGTUXmNRGD1UdqoMQjiThP2hc0rnJ
         swKO3izI76pyHhC0zJiYldnNWKQ9Td1vSVZ+h7OQJdCf8e1a6M8qo7H6qFcSp8U0IiR7
         X9iFnW6DtCFFLWKr8mZNtzO/QfzEWESgFmxZkse/+mEZIBAUKmbt7+PFimWElq7Webnz
         cWHHdenk7dVPnz0IpXX6S6xyAZjQjIwWSFn4e/mIWgwpTpQ8phOgW70kpn8jRB/BrZC3
         jVl1gxsuWQCPAK4qRG8DyYxIHdFwmvvGpzSi9RqtZTmaYM8qPODRoA0x0iQ6SEPUv1tV
         yPeQ==
X-Gm-Message-State: ACrzQf3bQneQ3ZuqQrZJRKijP6M89lG/bvkM3bqmp/0joQxaJT54hpIB
        Kl2Hm21Yn/h02ZWC8uJIEx4=
X-Google-Smtp-Source: AMsMyM7gxpUohfDaALGn+/FVZx0EpsFzEGlgPIx31VsUDTszYAqNYynTzsghGITzbo2REsDXNhxZlQ==
X-Received: by 2002:a63:e254:0:b0:459:a2cd:cbfc with SMTP id y20-20020a63e254000000b00459a2cdcbfcmr22591603pgj.275.1665506773634;
        Tue, 11 Oct 2022 09:46:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090a119700b00200461cfa99sm11297619pja.11.2022.10.11.09.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:46:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d2e905b-8669-b7ec-c7c0-1b0d78fded92@roeck-us.net>
Date:   Tue, 11 Oct 2022 09:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-2-Naresh.Solanki@9elements.com>
 <d2c83c4f-653c-438e-a91a-d17b846dec5b@roeck-us.net>
 <CABqG17hBJBU2rZSq4qy6Fn=pDH9ezwL=Fjh5vhj_G0cge-07mQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <CABqG17hBJBU2rZSq4qy6Fn=pDH9ezwL=Fjh5vhj_G0cge-07mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 09:12, Naresh Solanki wrote:
> Hi Guenter,
> 
> fan-common is intended for fan properties. i.e., those derived from
> fan datasheets.
> For min-rpm, some fans have minimum non zero rpm like 1900rpm below which
> the fan cannot run.
> 

I would argue the properties are for fan controllers, not for fans.
Fans don't have or depend on specific pwm frequencies. Fan controllers
do. Fans don't have a configurable pwm polarity. Fan controllers do,
to match the hardware on a board. Fans don't have or rely on
a target rpm. That is a system property, configured into the
fan controller. And so on.

If this is for fans, we'll need another set of properties for
fan controllers. The driver for max6639, being a fan controller,
would need to implement those properties.

Also, as implemented in the MAX6639, max-rpm is the fan's
rpm range, not the actual rpm. Your implementation is just
confusing, including the example in the bindings. Valid values
should be what the chip accepts, not some random value.

Really, I don't understand where you are going with this.

Guenter

> But not sure what the best approach is but for chip specific setting
> it should be in
> chip specific DT schema. Suggestion?
> 
> Regards,
> Naresh Solanki
> 
> 
> 
> 9elements GmbH, Kortumstraße 19-21, 44787 Bochum, Germany
> Email:  naresh.solanki@9elements.com
> Mobile:  +91 9538631477
> 
> Sitz der Gesellschaft: Bochum
> Handelsregister: Amtsgericht Bochum, HRB 17519
> Geschäftsführung: Sebastian Deutsch, Eray Basar
> 
> Datenschutzhinweise nach Art. 13 DSGVO
> 
> On Tue, 11 Oct 2022 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/11/22 03:47, Naresh Solanki wrote:
>>> Add common fan properties bindings to a schema.
>>>
>>> Bindings for fan controllers can reference the common schema for the
>>> fan
>>>
>>> child nodes:
>>>
>>>     patternProperties:
>>>       "^fan@[0-2]":
>>>         type: object
>>>         allOf:
>>>           - $ref: fan-common.yaml#
>>>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>    .../devicetree/bindings/hwmon/fan-common.yaml | 80 +++++++++++++++++++
>>>    1 file changed, 80 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>> new file mode 100644
>>> index 000000000000..abc8375da646
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Common fan properties
>>> +
>>> +maintainers:
>>> +  - Naresh Solanki <naresh.solanki@9elements.com>
>>> +
>>> +properties:
>>> +  max-rpm:
>>> +    description:
>>> +      Max RPM supported by fan
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  pulse-per-revolution:
>>> +    description:
>>> +      The number of pulse from fan sensor per revolution.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  target-rpm:
>>> +    description:
>>> +      Target RPM the fan should be configured during driver probe.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  pwm-frequency:
>>> +    description:
>>> +      PWM frequency for fan.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  pwm-polarity-inverse:
>>> +    description:
>>> +      PWM polarity for fan.
>>> +    type: boolean
>>> +
>>> +  label:
>>> +    description:
>>> +      Optional fan label
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +
>>
>> Same question as before:
>>
>> How are additional common bindings, such as min-rpm or fan-divider
>> (also sometimes called fan-prescale) supposed to be handled ?
>> As additions to this schema, or individually in each driver needing/
>> using them ?
>>
>> Thanks,
>> Guenter

