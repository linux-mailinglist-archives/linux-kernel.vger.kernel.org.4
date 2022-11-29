Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBFE63BB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiK2II7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiK2II5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:08:57 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E953ED1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:08:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bn5so15931219ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyQezi0/J2KyskoRyI6bR8Ni9hlnp2xfvLQVd8nenLw=;
        b=YMy7OXY8z0RXA3F9hAit19mlpsv1NovMvIOVgqid1RiwOTaNE60CK+ctxvmY5/YUl4
         UIqNl9Mh5EPflHQmwCXILhkC96lv+g2f51zrefV7PnXXoKlQopbFKr+BwInQio9DXyHO
         yxCbBSoRL15TWXMN3kmjIM9GpE6tIYtiXwanNevPKPQKbylmo1eMHGkYtAxKRDMrxldC
         l6fR0jTI4QhFYEhYVXKjj3stOdeuFt+JXX/wTDfzuavOmEvMtUn1eVVAceWBnWGVoarT
         KhNnZZCh4SztKAd/A7OL6Z5rV7+4tZ9Y0ywlYdKWyLt0qE8BPJYkWaPPWmu8x3dgHpDc
         G1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyQezi0/J2KyskoRyI6bR8Ni9hlnp2xfvLQVd8nenLw=;
        b=JGoDYD0JKWlcLC3dGyCjszGt1K2TRkL2LV6nEWwWJj5bL2oJXxbXJwEt4mCPel0yJ5
         pI4OCxUpupxA4ZmKDuba0i0Y6b5m02yp6h2F1w16YRNDLB67IuPU85Rumj02Al9ev1BZ
         fM+7n+OzGF5w+mfl1LbDqGCVqTTnJjGmYeHtW94y46JyfT7WfRdmBHuKQD9ISKdupdaL
         xUG7b+Uj25F2F7dZlK29vf4ZpwijvhPS2haP28jaGCfyLqixXvYaiyAEIoi8CtM157sX
         /cEMUcHreO2sb2QNlFbEKR52HsBnnJWwF4MY3AC0vg7B2FKEIP+GqZDdcmzAmxtSBemm
         hP5g==
X-Gm-Message-State: ANoB5pk7A5LTMmgAbuoy17hfpPIn8fhEbjK5vsaCE+pIMNGHaGmJehyb
        S4kZzQzNa3DbRrFhTUlFg9nnjg==
X-Google-Smtp-Source: AA0mqf7IQGcYq6JZxyQ9gjLLRjHcHeH1Ia5EOQO5Ps8RYsyCz9Cqm+9sqNoTPtXfJLG0wRmeYjO6sQ==
X-Received: by 2002:a05:651c:1195:b0:279:941e:15ae with SMTP id w21-20020a05651c119500b00279941e15aemr5949207ljo.179.1669709334645;
        Tue, 29 Nov 2022 00:08:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c200500b00279aca77a54sm215985ljo.60.2022.11.29.00.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:08:54 -0800 (PST)
Message-ID: <85b638f0-57dd-3114-6cac-42b0ccca49ac@linaro.org>
Date:   Tue, 29 Nov 2022 09:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 22:36, Naresh Solanki wrote:
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
>       $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..1954882eed77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties

If there is going to be resend - capitalize title, so:

Common Fan Properties

> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulses-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwms:
> +    description:
> +      PWM provider.

Isn't this object? If so, maybe:
  type: object



Best regards,
Krzysztof

