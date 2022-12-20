Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E542652333
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiLTOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiLTOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:55:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4321A5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:55:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v11so12621071ljk.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uW33jwDELgyifIlOmrFnOAcTY9sX6eDLte3xh/fS64=;
        b=BuSd/1xUhhuYWEHJ4j0G243EPKhduqoDU90y9Vzu2TvGr1QAyoltMopFsvxhgoSmg4
         xH7OH0ivwTnehzuACKM0cdZkWFaHGj6pHC7u+gN9MRJ/d+0xXJckKheHuDrbK4gSOMkS
         nPQ39/axOJ+/vxnt6r6owpfQugXxblTDJJcXSvSq3kKgvEQol7+UxQkJ7nxEkNjDQ4z/
         ikgXO1fIbLrOEdvEJk2CIsn0/f4OLmVl2J0LbU7ns16lOE74MaftWrrWZeiUvURr0SPj
         Put5KHjcxFi3GNeRjJ7kVPi4d93h6isEq4K0vF8gOVp8KIhWVj0R9ichdR3Nw8oHGhdo
         Mdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uW33jwDELgyifIlOmrFnOAcTY9sX6eDLte3xh/fS64=;
        b=jTmkEBMzE+L6VtREvKRBV/MJfWnBpmmtEYL9XKqLxgGsHLpajutfvYB9LdnKBbnce3
         UKyybzj0+nvMZXfcvSGL0Q3MZtZ7PXJU96djChE3MMacSAmzrJk6BVoLtli486Sosb1M
         KrVw3gWeN3ocgggjiRkTmj6++JDcj7/AqG37Oi+oLXBu4AFRztOGk7fESTm0IRHPgIiN
         IqmMsKTRkRh2KJKUhlBEl8yuFz/f7jW7n6tQMlDoSZ9WdQGyGjd0R9ah4k7d2WmEUbLE
         QP6DAZUyiFL2giRRBh/OvXrzkKXCZguu4wCewAs89dzTD9Q9TDGI4n/wVgfHEwR3TtR/
         2bnQ==
X-Gm-Message-State: AFqh2krwID7I0h0EdICnyuLwOrMn/wX303fi/Y7e2Woi7BM7Kfzd6ejM
        ZOZ8QAGiXpSI1SmjCvunwO9pmQ==
X-Google-Smtp-Source: AMrXdXtHsnA1I4DZEO8UsCzaa1oL2KIP37sv76nO2NvXT5H5nLksDQ2J6JnZKZ6DreHjxOvP79n2rw==
X-Received: by 2002:a05:651c:1722:b0:27a:51d:53d0 with SMTP id be34-20020a05651c172200b0027a051d53d0mr710858ljb.11.1671548124047;
        Tue, 20 Dec 2022 06:55:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v6-20020ac258e6000000b0048afb8b8e53sm1485123lfo.80.2022.12.20.06.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:55:23 -0800 (PST)
Message-ID: <34c48a5a-fa49-6725-c640-ee1f8130b921@linaro.org>
Date:   Tue, 20 Dec 2022 15:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/6] dt-bindings: regulator: add MAX77659 regulator
 binding
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-7-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220132250.19383-7-Zeynep.Arslanbenzer@analog.com>
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
> This patch adds device tree binding documentation for MAX77659 regulator.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../regulator/adi,max77659-regulator.yaml     | 31 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77659-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/adi,max77659-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77659-regulator.yaml
> new file mode 100644
> index 000000000000..c1e2d88be25b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,max77659-regulator.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,max77659-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator driver for MAX77659 PMIC from ADI.

It's not a driver. Drop.
Also full stop

> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This module is part of the MAX77659 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77659.yaml.
> +
> +  The regulator is represented as a sub-node of the PMIC node on the device tree.
> +
> +properties:
> +  compatible:
> +    const: adi,max77650-regulator
> +
> +  regulator-boot-on: true
> +  regulator-always-on: true
> +

Missing reference to regulator schema.

Best regards,
Krzysztof

