Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C25FB845
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJKQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJKQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:27:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776419AFF2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:27:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so3934689qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVU7T8zXZ3dnHtwPltGFnYzlQYV0x0jp6yZDw8wiFyk=;
        b=it+c3O0vf2/KCZ/oSlQJXuOWSAdN9PpaRv02eUb5iTrhEpnwHc4ryQWh1CZpr0peht
         0MHp7HOaHm9MS/k48k4Iy5a96el65vpobNkLJ+FKnyQpJ9LADGJKZgMxeL/H7+w7kOzO
         kVZU1Iq7E+7SiLTMRyu8KRR0S/EhwFAnpX0T3ig++I/EqAT6VL6qUjRtreRUhC03MoTW
         7fMNbzw9FCgjetibUhyPajGW2Kzta2djZS8Ut8pFEi62KRPudt9psCl1Ru4V8eVP68hp
         OaKMoqdLyaU5yRcWxeUrr4KjzVsDhCJXDKlZO4oAri83zztVc534voYF/1+Dsg8xXuaH
         /J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVU7T8zXZ3dnHtwPltGFnYzlQYV0x0jp6yZDw8wiFyk=;
        b=cHlQzWUbV2GwHyaY+NLnA35tfHkB4aLlayd023EvHFGi6y8rcjHmBS/aDufkvwFWyp
         yYlYVhiun6XR7vSLik7EesMD25oXm9AqwvW1k3Z2RGtma/L90BnO850gyf8uREyYqo3W
         fyF/sJvGizNaqgr/9QdfWGtTvqQ++J4mXOiHbovHd749ZVoRWAhFdz0iIhLravoTb5ux
         2Fo/JVwI8wXQlm0hmnVFGoBbTlrMiNZsRrmNccz0i6S2WQP2rlh/9Dt/yINjVJkb58YS
         YGvTKVmaQE+juMdKG+GCt7bVR5HlnyfZ7KfesyuvwKBBPV2EA1jxTZSAC0Y3Xf3Dmkoh
         nJrA==
X-Gm-Message-State: ACrzQf2XLT5onPyyPGVlcWTpQ15W9IUw+Rw6lSWSkzJgiECDESG8oSti
        jvq8ScwWQCAZLTvo1+VAfTJ4vw==
X-Google-Smtp-Source: AMsMyM4ye4f25pcUUQ/dOEkTnHJBaSYKXOttne42Mwd08vdpxJ0YvisjQu1QT2Og0e0CP2gZWDSqAw==
X-Received: by 2002:a05:622a:164a:b0:35c:b87f:4839 with SMTP id y10-20020a05622a164a00b0035cb87f4839mr19759717qtj.219.1665505630480;
        Tue, 11 Oct 2022 09:27:10 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a24d300b006cbb8ca04f8sm14135948qkn.40.2022.10.11.09.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:27:09 -0700 (PDT)
Message-ID: <628d3a58-0baf-73d0-7933-a737c2ad99d3@linaro.org>
Date:   Tue, 11 Oct 2022 12:24:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011104739.53262-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 06:47, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       allOf:
>         - $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..abc8375da646
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties

Is a fan a hardware monitoring device? Maybe this should not be called a
fan?

> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulse-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.

I think target depends on conditions, e.g. it is rarely one target.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-frequency:
> +    description:
> +      PWM frequency for fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use common units, so -hz

However I wonder if frequency is appropriate here - I thought PWMs are
rather configured via duty cycles.

> +
> +  pwm-polarity-inverse:
> +    description:
> +      PWM polarity for fan.

Rather: Inversed PWM polarity for the fan.

> +    type: boolean
> +
> +  label:
> +    description:
> +      Optional fan label
> +    $ref: /schemas/types.yaml#/definitions/string

Ref is not needed, core brings it.

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +
> +

Drop unneeded empty lines.

> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan-controller@30 {
> +            compatible = "maxim,max6639";
> +            reg = <0x30>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            fan@0 {
> +                reg = <0>;
> +                label = "CPU0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +
> +            fan@1 {
> +                reg = <1>;
> +                label = "PCIe0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +

Drop unneeded empty lines.

> +        };
> +    };
> +
> +...
> 
> base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4

Best regards,
Krzysztof

