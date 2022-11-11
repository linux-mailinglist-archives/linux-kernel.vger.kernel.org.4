Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9D62553C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiKKI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiKKI14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:27:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7B7C8D9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:27:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so3913102pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6/R+5coguWTvlN/9lIu/MDWB5I1C/01DprdHlXRTcs=;
        b=bgqJ3zVA74hTY+s4RsbU6C18De2j1JIywbWX1Ss18nyD2bRwxSm7Lp3zZvW68dPa+8
         daYIkPUd+N4zE+PKa0obS66HhMK3xI3ThhtrC9o/WA+zertEgXgSCNY5AgbEHucDAlKP
         PpSTL3wjhiBpcoluBVIF2kBw9vxUx1jTJgQ/BJQ3PspWw555Umw9QP0QUJK2yddA6SG1
         GucewfQCDhnyi8c0YQ/5x1sGy73QNcxnnstgN91LSUenlNDit8yeJE3ToKTXALdSs9E6
         CjsojxK2wHpXpLjmdfQ1FSMd0jx5o9XRubpSJvA1YsCkAAEhox436gZBljw5XvW0rz8R
         IueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6/R+5coguWTvlN/9lIu/MDWB5I1C/01DprdHlXRTcs=;
        b=V5n96fnQyajobpSB/T0MN5RP9xLNfVUJHMUBg2U8Nn/tah1GycnwbbjlWLK7ckXKXA
         zIxbOgIxZx4Ma17tg/RB3efxYhC9ARTq7DFZPGwcraCVz0GjZPnvuXpcMo04Qiw6HOxA
         nnMiCaQfPCRf2SDmdw9xJ9bWbdJlV4wCYB2/WDHrv5ySVzz1qBKYPiZXLXHW4d68p1mH
         eiDCXdl/oyCy9k5xrHQDZUBOnzeaWV+kl9RRMvi5MiicxQeHlTZgvOjVHp9PeNv1sMCy
         KpSjyZj28LyZWWy+8ybrAOiUjx/LaT+U5W5bBuT0VaZ0Mk/AioPLMkObPrHPaUMd/OLS
         prgQ==
X-Gm-Message-State: ANoB5plDgJGU4l43Vq/qFGE/NWs/5xhRf/iy1pSuhfIqhCKk6atw0vUP
        IgMJUcgl0I4l5qV3T1RqsFKJdQ==
X-Google-Smtp-Source: AA0mqf4jUVqD9Wu04JHELKbmEPSzlH4gptMgu8vyDZhjKTf1kZdd1R0eL+j44mKUsA9p5eVPgEseXw==
X-Received: by 2002:a63:5115:0:b0:46f:a989:ad72 with SMTP id f21-20020a635115000000b0046fa989ad72mr726477pgb.430.1668155270258;
        Fri, 11 Nov 2022 00:27:50 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id n8-20020aa79848000000b005627868e27esm984075pfq.127.2022.11.11.00.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:27:49 -0800 (PST)
Message-ID: <d857ba1c-4248-5542-580c-ab814ef4124d@9elements.com>
Date:   Fri, 11 Nov 2022 13:57:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
 <20221103213425.2474772-2-Naresh.Solanki@9elements.com>
 <9396ee97-d6f3-f13b-8929-56c3920ee395@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <9396ee97-d6f3-f13b-8929-56c3920ee395@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 04-11-2022 03:19 am, Krzysztof Kozlowski wrote:
> On 03/11/2022 17:34, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
> 
> Subject: drop redundant (second) word "bindings"
> 
>> The MAX597x is a hot swap controller with configurable fault protection.
>> It also has 10bit ADC for current & voltage measurements.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> Isn't this third version per day? That's too many. Please keep it one
> per day (usually).
> 
> 
>> ---
>>   .../bindings/mfd/maxim,max5970.yaml           | 170 ++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> new file mode 100644
>> index 000000000000..25079c518f68
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> @@ -0,0 +1,170 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
>> +
>> +maintainers:
>> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
>> +
>> +description: |
>> +  The smart switch provides no output regulation, but independent fault protection
>> +  and voltage and current sensing.
>> +  Programming is done through I2C bus.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max5970
>> +      - maxim,max5978
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  leds:
>> +    type: object
>> +    description:
>> +      Properties for single channel.
> 
> This description seems odd. You have here several leds, so what is the
> single channel?
> 
There are four leds. Will update in next revision.
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^led@[0-3]$":
>> +        $ref: /schemas/leds/common.yaml#
>> +        type: object
>> +
>> +    additionalProperties: false
>> +
>> +  vss1-supply:
>> +    description: Supply of the first channel.
>> +
>> +  vss2-supply:
>> +    description: Supply of the first channel.
>> +
>> +  "#io-channel-cells":
>> +    const: 1
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      Properties for single channel.
> 
> That's another odd description.
> 
Update. Willbe part of next version.
>> +
>> +    patternProperties:
>> +      "^(SW[0-1])$":
> 
> This should be lowercase. You also do not need ().
> 
Done.
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        type: object
>> +
>> +      shunt-resistor-micro-ohms:
>> +        description: |
>> +          The value of curent sense resistor in microohms.
>> +          Must be specified for each channel.
> 
> Drop last sentence and instead add "required:" with proper indent.
> 
Fixed. Will be part of next version.
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - regulators
>> +  - vss1-supply
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - maxim,max5970
>> +    then:
>> +      properties:
>> +        io-channels:
>> +          items:
>> +            - description: voltage first channel
>> +            - description: current first channel
>> +            - description: voltage second channel
>> +            - description: current second channel
>> +          description: |
>> +            Voltage and current for first and second channel.
> 
> I do not understand the description.
> 
> Also, add it in the existing example.
> 
Have removed them because not being used by the driver.

>> +      required:
>> +        - vss2-supply
>> +    else:
>> +      properties:
>> +        io-channels:
>> +          items:
>> +            - description: voltage first channel
>> +            - description: current first channel
>> +          description: |
>> +            Voltage and current for first channel.
> 
> Same question for the description.
> 
>> +
>> +additionalProperties: false
>> +
> 
> Best regards,
> Krzysztof
> 
