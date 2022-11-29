Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F263C403
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiK2PpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiK2PpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:45:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31295C0FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:45:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w23so13775659ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwqgbXWFd8mNBQRKaBAwSj1zbltG8JixRsOoLI1NOpw=;
        b=OiDuD58ffbgMKGWLix+Hs4KWO4EX6iwpciWkUWNnprPWAB2SNUxjbx9ynkiuVXRPcc
         uRMrTExILOjhUuN5cP3m4khovPjZGSuhDmOdTzzcUtVmmXlY+3ex6JgCgEwQStAjhztQ
         6+kJw7vZTOL2I+DgfcekGZjaMBYJ6ZqBsfhpF8wC1GnHa5gEDH1wumTqeQwlc6y6cqNP
         cqchmliBu/LF3x4QIZ6U7NxTVbGH5SiPXZV8dZmDU814CFlZ5P05f6nmu9vOCEBnTroR
         NePSqvN4UMhTzeMSoWjyRF0OE1er47RID7fApsZufoEtLpTPk4W1Qfmfyb3q2eJ3wOtz
         /D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwqgbXWFd8mNBQRKaBAwSj1zbltG8JixRsOoLI1NOpw=;
        b=GKi6pmDQn6zoMgTgUyVHBDJ0lkjYCVo/w7IZxwv1gB4UMvGIsO1UPRswC/t6IJBALr
         vEoL59YKMKDXjV4V+N+F2fAK7yjQ9S3wlWzq3XVJmsmb9BUWwQ5gvuQzg2xDwcw7N2Im
         HnxVpYOc5E7m97foFsqCY2tiqL/c2M2X8bNaDk1dlNxS3Ye9RiT4xIV1chRz0d8wqcP+
         X1Inyk+aq8Au74NT3ne3v7RooRQcR6L/3OwNmNjIM+UUKb/JwG58Buf50yUwHPq3Y61E
         60ySZFOJWDz9uKDROmkqoQVGCeXrb31aqFDZy7cX6POngjWPwvuT6Ilmsf6Bl6xq/Pt8
         AUwA==
X-Gm-Message-State: ANoB5pmFJ/vXR4ox5v0ke1/L00lgE3DtMgij2mmiEMlfY5zHXtoAmcMk
        cIv/Hi1nwaqkEc8lugrEi5nqzg==
X-Google-Smtp-Source: AA0mqf7Kn+irBBoSCnzUZKzpClwlJn/lbklZFWE7Q0QNHmYB17lMFRt3fPT8y0h1+7JXyWBrQWvKcw==
X-Received: by 2002:a17:90b:3c4c:b0:218:a8a1:933a with SMTP id pm12-20020a17090b3c4c00b00218a8a1933amr45792753pjb.14.1669736718180;
        Tue, 29 Nov 2022 07:45:18 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001766a3b2a26sm11027094pli.105.2022.11.29.07.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:45:17 -0800 (PST)
Message-ID: <840daaaf-5c0b-e462-eec6-b87c54036acc@9elements.com>
Date:   Tue, 29 Nov 2022 21:15:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
 <85b638f0-57dd-3114-6cac-42b0ccca49ac@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <85b638f0-57dd-3114-6cac-42b0ccca49ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 29-11-2022 01:38 pm, Krzysztof Kozlowski wrote:
> On 16/11/2022 22:36, Naresh Solanki wrote:
>> Add common fan properties bindings to a schema.
>>
>> Bindings for fan controllers can reference the common schema for the
>> fan
>>
>> child nodes:
>>
>>    patternProperties:
>>      "^fan@[0-2]":
>>        type: object
>>        $ref: fan-common.yaml#
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../devicetree/bindings/hwmon/fan-common.yaml | 42 +++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> new file mode 100644
>> index 000000000000..1954882eed77
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common fan properties
> 
> If there is going to be resend - capitalize title, so:
> 
> Common Fan Properties
> 
Sure
>> +
>> +maintainers:
>> +  - Naresh Solanki <naresh.solanki@9elements.com>
>> +
>> +properties:
>> +  max-rpm:
>> +    description:
>> +      Max RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      The number of pulse from fan sensor per revolution.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  target-rpm:
>> +    description:
>> +      Target RPM the fan should be configured during driver probe.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  pwms:
>> +    description:
>> +      PWM provider.
> 
> Isn't this object? If so, maybe:
>    type: object
With make dt_binding_check, I'm getting error for this.
Looking at other available examples in documentation, type object is not 
used.

Example:
   pwms:
     maxItems: 1

One pwm per fan.
> 
> 
> 
> Best regards,
> Krzysztof
> 
Regards,
Naresh
