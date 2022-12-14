Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508364CE89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiLNRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiLNRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:00:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B020F5B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:00:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so11492860lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lvd2yKCxN/cWI7hKHlLa8cJjk+ps/lRVDsToMSf8tOg=;
        b=BW3IyTwR01kc+dH1hnbs7li3oFVb2chs6RVIFA2xJhgglw1bx/SZ3Mn7T30fspgpRJ
         rOgWd+zeyEFpXGQKeD+vfZppdNjsPjdM0CgSpNh+Lvp6HrTOoxMLa1g5eDSoNaqcgv0m
         oqBED1QZ3UskYFcDkkDDvGrN23dIXwNfH9760TsARKdTaxMXIq/D/TRVj51amENCd587
         sf8a9rLheuux/ZNC8nujss3cWHG9P3PJYLgCAz4hkAJQCPCZvg6OOiQ4qXZH12FJ2/8V
         9+cR4I5+sxAD/CEcACJfXfRa2UJ4sAHUikHgMxVD6I9WGCDQLSHQ7Rgqg9Fu3CO8GXeD
         I40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvd2yKCxN/cWI7hKHlLa8cJjk+ps/lRVDsToMSf8tOg=;
        b=CzNPCM8uzKhOwEBGHIfUUaQt7xC8JBAHXDMmbq83OmeloaTxOizlIEOi/cgYvxDPKq
         /IBa1+89UBBHcv7qXRaWJz2ZruhJcysgA1oxk7xpQoS+TisfBwkDgpl/2AnDJ/A146jS
         AUogWLrIXPY1TgwDOobwxMZGRe7OsEMYWmqy6Jdl2xrJC+gHocSkEhmdbwAcejvceeXI
         hAOz2KRAKlYSesH+qYEm0DR8BDgPVlLPaoyweUGh65PTao+GKMKBQYi2xtR6OLVon5+c
         s7V9uBlkSNGxMpqTLEvWHw55pKIxGHq6egFay8pYa6rG/PBWYYfhXyGGpoAGICwcD/R4
         JL0w==
X-Gm-Message-State: ANoB5pnIacXcog5eOw4OhTdkyQP/6m5B3y/K+2mwlWJqyGg2NcrDt8qu
        KNcP7TxaDTj4FRmia813MUwJyg==
X-Google-Smtp-Source: AA0mqf4mABnqZl7/+BzWI1hOTFIk5UPhZ/K7k+NH9eQxXgxiXKyPbLEF853q1jLsfbrbTV5vlrJM3g==
X-Received: by 2002:a19:6405:0:b0:4b5:b268:dbc8 with SMTP id y5-20020a196405000000b004b5b268dbc8mr5539381lfb.45.1671037205985;
        Wed, 14 Dec 2022 09:00:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l11-20020ac24a8b000000b004b55e16931fsm865442lfp.259.2022.12.14.09.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:00:04 -0800 (PST)
Message-ID: <386e3717-a063-a2ea-6028-19d11b5838b0@linaro.org>
Date:   Wed, 14 Dec 2022 18:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: Add bindings for max31732
Content-Language: en-US
To:     Sinan Divarci <Sinan.Divarci@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-4-Sinan.Divarci@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214142206.13288-4-Sinan.Divarci@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 15:22, Sinan Divarci wrote:
> Adding bindings for max31732 quad remote temperature sensor

Full stop.

Subject: drop second, redundant "bindings for".

> 
> Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
> ---
>  .../bindings/hwmon/adi,max31732.yaml          | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> new file mode 100644
> index 000000000..c701cda95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31732.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,max31732.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31732 Temperature Sensor Device Driver

Drop "Device Driver"

> +
> +maintainers:
> +  - Sinan Divarci <Sinan.Divarci@analog.com>
> +
> +description: Bindings for the Analog Devices MAX31732 Temperature Sensor Device.

Drop "Bindings for". Actually, either drop entire description or write
something else than title.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31732
> +
> +  reg:
> +    description: I2C address of the Temperature Sensor Device.

Drop description.

> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: Name of the interrupt pin of max31732 used for IRQ.

Drop description.

> +    minItems: 1
> +    items:
> +      - enum: [ALARM1, ALARM2]
> +      - enum: [ALARM1, ALARM2]

This should be fixed, not flexible. Why it's flexible?

lowercase letters only

> +
> +  adi,alarm1-interrupt-mode:
> +    description: |
> +      Enables the ALARM1 output to function in interrupt mode.
> +      Default ALARM1 output function is comparator mode.

Why this is a property of DT/hardware? Don't encode policy in DT.

> +    type: boolean
> +
> +  adi,alarm2-interrupt-mode:
> +    description: |
> +      Enables the ALARM2 output to function in interrupt mode.
> +      Default ALARM2 output function is comparator mode.

Same question.

> +    type: boolean
> +
> +  adi,alarm1-fault-queue:
> +    description: The number of consecutive faults required to assert ALARM1.

Same question - why this number differs with hardware?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    default: 1
> +
> +  adi,alarm2-fault-queue:
> +    description: The number of consecutive faults required to assert ALARM2.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    default: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensor@1c {
> +            compatible = "adi,max31732";
> +            reg = <0x1c>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>, <27 IRQ_TYPE_EDGE_BOTH>;
> +            interrupt-names = "ALARM1", "ALARM2";
> +            adi,alarm1-fault-queue = <4>;
> +            adi,alarm2-fault-queue = <2>;
> +            adi,alarm2-interrupt-mode;
> +      };

Messed indentation.


> +    };

Best regards,
Krzysztof

