Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3E6EC895
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjDXJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDXJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:18:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3381AE7B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:18:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso7658315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682327910; x=1684919910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GKb2MfFHqAxRiWVMxosJOA3T0vRRUpNHRuZO4/Hffw=;
        b=S6zdTQg3wxGbgDEGRPfw8cxHmqLs0+/2um6Euw0O8amsm8UP/LLESZeB+OWVwDrYj0
         E6IaigWqifPuEqkVEg324o9AK0vH1UPRbMpFoNip37c08I+jbTSu7r7PW+FnosSN+Iba
         YbP6bRPs2B7NMokSd6vENMKHDnyYaip7ufuJKyhMejayoKoWwzUUGAbzS3RI5dr5ljom
         d/UYPe5HjNIIYrHIr58pAFYArrByMnP6jO+w5G+pIetSNkg681Ke/kTol4tLNfgBsSxJ
         U1XTNWCep9QBcwrxEoBfEFzprBigBxh+DwvluZV1BEQPqf5Ecs8oGtADgucR6SLlT6tz
         9iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327910; x=1684919910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GKb2MfFHqAxRiWVMxosJOA3T0vRRUpNHRuZO4/Hffw=;
        b=ABkELewoaOc75bX1qX/EPpvAyr0dH0wS6uSA2FDiKEo0A6r8Cl/i0czVKpH+D0EWPI
         lwiHfXJaX8rh4Jb2iOpLWjYEwaVYkn5ILPXzRFm6MgQoodrauvUMQog6K/v9nKR0vIYG
         lAnbcl5CQ34kEJIGLvI96BlblIi7UncEgIlv+LOXW5CX9DOWE3zC+HucyMaPWYPHHpAS
         Cdp/QjxaJ0R/0G/DHWKIzIc9CCe4fbiiXxRmZOebYG0qbEi3/P83ldb/DPSfXBibRNS9
         1hoq88XfKa4DryCKLMXe2mmefB+b7z99AZONJxM10lz7Y7S6f5ukG/tuV4NwH2Ect758
         wV+w==
X-Gm-Message-State: AAQBX9cHgCbTyKx4b0Ajs6R5xCkssUnPz1m3gidQX6NIxKK1HV7RSG2z
        gdLTRLJmjfbBVc9mF1vLALUm7g==
X-Google-Smtp-Source: AKy350YPeUoY+IEjaaF2haqXti0vS0NgSAVN/8bb/anHZSftdw3PG/29tzDzaK4hXU3je9qmwqhOkg==
X-Received: by 2002:a05:600c:22da:b0:3f1:79b3:a594 with SMTP id 26-20020a05600c22da00b003f179b3a594mr7699418wmg.3.1682327910421;
        Mon, 24 Apr 2023 02:18:30 -0700 (PDT)
Received: from [192.168.29.232] ([49.37.170.173])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d6e8d000000b002fae2a08089sm10421597wrz.70.2023.04.24.02.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:18:30 -0700 (PDT)
Message-ID: <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
Date:   Mon, 24 Apr 2023 14:48:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <76e57634-75dd-01e8-9c56-36ed7de17812@linaro.org>
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


On 21-04-2023 01:07 pm, Krzysztof Kozlowski wrote:
> On 20/04/2023 13:17, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>> monitor with PWM fan-speed controller.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ...
> 
> Wrong syntax. '...' do not mean anything, it's ---
Ack
> 
>> Changes in V2:
>> - Update subject
>> - Drop blank lines
>> ---
>>   .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> new file mode 100644
>> index 000000000000..1aaedfd7cee0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim max6639
> 
> What is this device? fan controller?
Yes Fan controller.
Do you want me to update the title here as:
"Maxim MAC6639 2 channel fan controller & temperature monitor" ?

> 
>> +
>> +maintainers:
>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
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
> 
> Why do you need these two properties?
Ack. Will remove them.
> 
> Anyway, the binding looks incomplete. Where are the supplies? Interrupts?
This patch just adds basic support to the existing platform driver.
Intention is to be able to call the driver from DT with basic 
initialization from driver the existing driver.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      fan-controller@10 {
>> +        compatible = "maxim,max6639";
>> +        reg = <0x10>;
>> +      };
>> +    };
>> +...
>>
>> base-commit: b8610e0fe08f1476895f141be60f8dd842f0adac
> 
> Best regards,
> Krzysztof
> 
Regards,
Naresh
