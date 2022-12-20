Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0D65232D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiLTOy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiLTOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:54:15 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DC1AA2B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:54:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so18924852lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpNRpO9wa9stwssfJtyLudHPW4w/SlfVzYpf2TY5wXw=;
        b=qmspUH8EQvvCbrbdWy1eZ2Kl+G8Ef6clk3GUnGWJhxrfkEKF/qtlnI6mufTZZ4Wi+d
         FkY9N1XkwWeh/yrG/uoow2svYQQMrMwyBeARY6QTS3036Yqs4mMKVRWiqNRH8SH1zsuq
         5vWN94KS9IXJIkdcsQYOv7FsBho4cmozIgMrcmY7JoeMt5RBjk4Am7r8Iz43fVlY7+Gc
         LR0QItfv1S7tnQQehVv29JTrs2NRJe5oj0vo8RZSa9YYtbiVVwKzwSmewcTdYtlJc4th
         hD4rA58+p4fan4Di2bnVrtXTn3qE2rmqkr0EGDX11XKgDdslDm9kUTpwGH6/wsVhd1Q1
         UVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpNRpO9wa9stwssfJtyLudHPW4w/SlfVzYpf2TY5wXw=;
        b=lRCNsgBJHQTn3chm/0Ifx8iicBMH0CESWNrbVqJwdeBHJ9+KTpphetZIVRxGxqBMfk
         NQofx1PS1TkrDDKKaelO84DVCpCXT9AQhq0FriZbyY0Bq16l8sj+TH3XcdvCaww9hykn
         bmx/1ij9YsDopVuTEI9ALuQZsNm9TUxwx/uZjSo1nGm10hG47lOb6rUJMIPHvwlXEJPi
         F+T+BVFn0KFmdUHCbPvQPppGBwD61lfQ+5zXJaHKeVthKx65+i07j9UwXG2uNBPCccgh
         qQU7g5qprcgKKOnj3YDnFBYd/LpWBf4s5uMjx0J/zaZRWqgM7vnJkamiu3x65Hqvj4HS
         2i6A==
X-Gm-Message-State: AFqh2krJMDbJrIxGzMjXaMJmo7qpMLoGag9aJrQxjJN4J0RQHE6dmc4I
        C20uNSiZeDFIlQdYsJs4eGAS5w==
X-Google-Smtp-Source: AMrXdXs3MjWU/d2BMKBSMrPV3puVinkewStaqEJThI3KvVlGwi+i8CEnNWpd0NY8YOmO/6Xom1daqA==
X-Received: by 2002:a05:6512:3b2c:b0:4a4:68b7:deab with SMTP id f44-20020a0565123b2c00b004a468b7deabmr1102337lfv.7.1671548052179;
        Tue, 20 Dec 2022 06:54:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512214c00b00498f00420e9sm1477486lfr.194.2022.12.20.06.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:54:11 -0800 (PST)
Message-ID: <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
Date:   Tue, 20 Dec 2022 15:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 14:22, Zeynep Arslanbenzer wrote:
> This patch adds device tree binding documentation for MAX77659 charger.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77659-charger.yaml    | 42 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml
> new file mode 100644
> index 000000000000..24f8b5a2bd84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77659-charger.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,max77659-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger for MAX77659 PMIC from ADI.

Drop full stop.

> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This module is part of the MAX77659 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77659.yaml.
> +
> +  The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +properties:
> +  compatible:
> +    const: adi,max77659-charger
> +
> +  reg:
> +    maxItems: 1
> +
> +  adi,fast-charge-timer:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Fast-charge safety timer value (in hours).

No, use suffixes for common units.

> +
> +  adi,fast-charge-microamp:
> +    description: Fast-charge constant current value.

> +
> +  adi,topoff-timer:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Top-Off timer value (in minutes).

No, use suffixes for common units.


Best regards,
Krzysztof

