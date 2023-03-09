Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2686B1F49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCIJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCIJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:04:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA75F51F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:03:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so4097682edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678352609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J13gHYDlv4WDpdSt2jqL/HFsRwgMCyNGuFbdGGUpBc8=;
        b=hyZU0D0mPXAuQMeiHccn7a96QYFyaNF9exQeTmpkqYY7OMEbEniJa0ffiXaPTAua25
         A7tYoMnBFrsaFDYlguDNmLVhoL74poM1/QI5SxLzTa9n1YiUPKjinVli4u/5WfK5cqre
         N/vmvbJeU+NVDQsWKVYO9blVyS+Xai4xhPpBFYkxO1+VJRKIa10tz018ixjM1AGSHtrd
         1OfuIHYc7NaJCh/p9En9bSBCBQKEUait8HHMZAG8ldGQ67v9tkuA1Hwqh38dCg8vAPCQ
         2Zo/4gpEFMOWbyY3VlxBC7n6ida1dhchu/Z/JY9crHdU1V1GpWIved+yiAn2AuGf0zks
         F4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J13gHYDlv4WDpdSt2jqL/HFsRwgMCyNGuFbdGGUpBc8=;
        b=scz5MaKnynlLmNuSrx0LsLFmT7m9H4HHIR/mxxJuRZMVAO+O7dDprOAXuyBHIAwxyE
         xKLKtw1ARSmVmRpfljP7uMqVUURBZOefkV2UV7u15GJS50xkJwf0GqdkechcXPmMAiD9
         xo8W4MKj4XLhn3N0Ncil8FPBOhGeywcNMatJt8AVSN8GpGqXsn/OA7UmCs+OUSK427Fd
         iLiOcf+jzV71NSlfHYedVPq3u+JPyZW9ebdoDnALnISrzQBbKLqWcHyJ9eoERJRVbnrM
         cdkq6KlW4NfoCAAfyFQ0HN/gy7wQcYgDbVdNbizuv0t+ebdgiIAzrCYJBSGGtLg3Gbm8
         AshQ==
X-Gm-Message-State: AO0yUKWbayGsfTJVkSPMakf8EWduozmeUOI4HCX69ZzkYAnMEgTJ7FtO
        MXnqQhDni9KRrVJVqUYjDIXlkw==
X-Google-Smtp-Source: AK7set+kWzmQGaH/zQoMoebD1FaMml7XgdXOf46OEdW8iOoWVqfpX99gvKoTw9CnwHwy9YugrEvoWg==
X-Received: by 2002:a50:ee8c:0:b0:4ac:b32d:3dab with SMTP id f12-20020a50ee8c000000b004acb32d3dabmr19282464edr.29.1678352608924;
        Thu, 09 Mar 2023 01:03:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id k22-20020a50ce56000000b004c07b11deb8sm9255484edj.64.2023.03.09.01.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:03:28 -0800 (PST)
Message-ID: <c0ec5137-ed86-d695-7335-d1564d814862@linaro.org>
Date:   Thu, 9 Mar 2023 10:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Document rohm,bd65b60 bindings
Content-Language: en-US
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:14, Bogdan Ionescu wrote:
> Hi all,
> 
> This is my first patch to the kernel, so I expect to have made
> some mistakes. I did my best to follow the documentation and
> submitting patches guidelines, but if I missed something, please
> let me know.
> 
> I wasn't sure if I had to add myself to the MAINTAINERS file for such a
> small patch, so I didn't.
> 
> Patch begins here:

This all goes to cover letter. Patch begins with first line. `git am`
this patch so you will see the issues.

> 
> Added devicetree bindings documentation for the rohm,bd65b60
> led driver.
> 
> Signed-off-by: Bogdan Ionescu <bogdan.ionescu.work@gmail.com>

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> ---
>  .../bindings/leds/rohm,bd65b60-leds.yaml      | 77 +++++++++++++++++++
>  include/dt-bindings/leds/leds-bd65b60.h       | 20 +++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
>  create mode 100644 include/dt-bindings/leds/leds-bd65b60.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml b/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml
> new file mode 100644
> index 000000000000..f69d7acd39c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/rohm,bd65b60-leds.yaml

Drop "-leds". This should match compatible.

> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/rohm,bd65b60-leds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD65B60 device tree bindings

Drop "device tree bindings"

> +
> +maintainers:
> +  - Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>
> +
> +description: |
> +  BD65B60 is a white LED driver IC that integrates PWM
> +  step-up DC/DC converter with boost-capability of up to
> +  maximum 28.5V and current driver with drive capability of up
> +  to 25mA(Typ.) maximum setting. Precise brightness can be
> +  controlled at wide ranges through the external PWM pulse
> +  input.
> +
> +properties:
> +  compatible:
> +    const: rohm,bd65b60
> +
> +  reg:
> +    maxItems: 1
> +
> +  led:

Drop led object. There is no real need for it, is it?

> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      rohm,enable-outputs:
> +        description:
> +          Select which leds are being controlled.
> +          Values defined in <dt-bindings/leds/leds-bd65b60.h>

I don't understand why do you need this property. You should use
generic/existing properties, if possible.

> +        $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes

> +        enum: [ 0, 1, 4, 5 ]
> +
> +      rohm,ovp:
> +        description:
> +          Select Over-Voltage-Portection level.
> +          Values defined in <dt-bindings/leds/leds-bd65b60.h>
> +        $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes

> +        enum: [ 0, 8, 16 ]
> +        default: 16

What are the units? percent? Volts? Then use unit suffix in property
name. Your other file suggests volts so make it microvolts.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml


> +
> +    required:
> +      - rohm,enable-outputs
> +
> +required:
> +  - compatible
> +  - reg
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/leds/leds-bd65b60.h>
> +
> +    i2c {
> +

Drop blank line

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +        led_controler@64 {

No underscores in node names

> +            compatible = "rohm,bd65b60";
> +            reg = <0x64>;
> +
> +            backlight_led: led {
> +                function = LED_FUNCTION_BACKLIGHT;
> +                color = <LED_COLOR_ID_WHITE>;
> +                rohm,enable-outputs = <BD65B60_ENABLE_LED1>;
> +                default-state = "keep";
> +                linux,default-trigger = "backlight";
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/leds/leds-bd65b60.h b/include/dt-bindings/leds/leds-bd65b60.h
> new file mode 100644
> index 000000000000..8634faae58f4
> --- /dev/null
> +++ b/include/dt-bindings/leds/leds-bd65b60.h

Filename matching binding, but I think entire file will be gone.

> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides macros for the ROHM BD65B60 device tree bindings.
> + *
> + * Copyright (C) 2023 Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_LEDS_BD65B60_H
> +#define _DT_BINDINGS_LEDS_BD65B60_H
> +
> +#define BD65B60_ENABLE_NONE 0
> +#define BD65B60_ENABLE_LED1 1
> +#define BD65B60_ENABLE_LED2 4
> +#define BD65B60_ENABLE_BOTH (BD65B60_ENABLE_LED1 | BD65B60_ENABLE_LED2)

I don't understand this.

> +
> +#define BD65B60_OVP_25V 0
> +#define BD65B60_OVP_30V 0x08
> +#define BD65B60_OVP_35V 0x10

Drop, register values are not bindings.

> +
> +#endif /* _DT_BINDINGS_LEDS_BD65B60_H */

Best regards,
Krzysztof

