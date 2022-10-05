Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6F5F5A07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiJESml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiJESmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:42:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697AB80EAF;
        Wed,  5 Oct 2022 11:40:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 195so57375pga.1;
        Wed, 05 Oct 2022 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=+wOa8fJ0J/EJOCC9EWTKbrq74/PynTNYVHwSLWX6IDs=;
        b=pQqj0M8f9GQ9ylMie1+H1jtmAY/vbBHMYnkIQQM7ZlHGs8wByUrGiCR4KFZfF0+bBt
         5gQMqppDMKh9vIknP8W8WEaZcMrPQ+3EUrCZQ+cgrDNgefoJcR0SPiSqKBgQvUOHmbaZ
         XfiT++rDhg0t0+JYKnt9oXkKxaUFn+oD0I7rO3ZYgJnaDTHVxQq2AZB+0DzEpl9S2PiF
         try73ZmlltM8/f9gKP3uegyTO8/H9J7zGYICWP9HdpH9eoa6JGwWCv4yibgDJXlmyh7w
         hOntCU167p/OwUTEq5lRsPYhnfD7MExucDwYC8a+5OWLO/9Z2Fq6xEbv9hi69x/UpH+W
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+wOa8fJ0J/EJOCC9EWTKbrq74/PynTNYVHwSLWX6IDs=;
        b=3iRAdHsEPAi9X4LorshPN7whuInbEq6rH2B2bv+pU5ElXyfHBj0P/ta52N10kd13PP
         KQZGVIJyVg5MlRRBTSld0RUR8UrK6jFr54eLgh7oRy5f6gBtpNPuoa6ibJtF5jmCUvUw
         wgQCT8b9TufJ2OdROxy9AWIfzpblX66mzVxo1auznkaPt5TGl4lZisbrkOENpM8zZGYK
         onGkbiFvvB6dsuYmAzP78EjQx8UbAG3sSB+S04myxThIJSg9IIhBgi1y0S17NZmDEp4S
         Cr4+4a+baDtE4QZNgOfPH0NITWYGcdxAxmsjFwFxHKSIZ0GPHdZc/GM3Kr3/UPuPT+CE
         Y7oQ==
X-Gm-Message-State: ACrzQf2szSEeUlLX0v8monW6f1C1EOdHfIONG0jfh7P6+k0l4tJz2GF8
        m+Ro3Bvq9Nj2jXb5dZ6qGWNsiEWfx7Nozw==
X-Google-Smtp-Source: AMsMyM7jNoRpxYV4CeID6uC0kE4jBaOPm/DNUCAMUA5mGQ5OR+0IYMpQV1bgQYkIgVeU9XovOJSz/g==
X-Received: by 2002:a62:ea0d:0:b0:55f:8624:4d8b with SMTP id t13-20020a62ea0d000000b0055f86244d8bmr797379pfh.74.1664995227912;
        Wed, 05 Oct 2022 11:40:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a384b00b0020a8f44e52csm1429327pjf.38.2022.10.05.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:40:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a55d973b-4504-a104-a889-f9b7e264c1e9@roeck-us.net>
Date:   Wed, 5 Oct 2022 11:40:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20220922050718.1079651-1-Naresh.Solanki@9elements.com>
 <20220922050718.1079651-2-Naresh.Solanki@9elements.com>
 <3003378d-4283-6c05-50bf-29178c97ef8e@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
In-Reply-To: <3003378d-4283-6c05-50bf-29178c97ef8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 23:34, Krzysztof Kozlowski wrote:
> On 22/09/2022 07:07, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>> monitor with PWM fan-speed controller.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++++++++
>>   1 file changed, 112 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> new file mode 100644
>> index 000000000000..c845fb989af2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> @@ -0,0 +1,112 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim max6639
>> +
>> +maintainers:
>> +  - Roland Stigge <stigge@antcom.de>
> 
> Ack from Roland is needed here.
> 
>> +
>> +description: |
>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>> +  fan-speed controller.  It monitors its own temperature and one external
>> +  diode-connected transistor or the temperatures of two external diode-connected
>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max6639
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "fan@0"
>> +  - "fan@1"
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
> 
> This goes after properties.
> 
>> +  "^fan@[0-1]$":
>> +    type: object
>> +    description: |
>> +      Represents the two fans and their specific configuration.
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          The fan number.
>> +        items:
> 
> Skip items.
> 
>> +          minimum: 0
>> +          maximum: 1
>> +
>> +      pwm-polarity:
> 
> Why is this property of fan, not of PWM source?
> 

The chip provides pwm output to the fan. That typical for fan
controller chips. Typically they also have options to configure
the pwm frequency and either pwm or DC output (max6639 does not
have the latter option).

Guenter
