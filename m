Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8993F671701
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjARJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjARJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:04:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424671554B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:23:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so23861386wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sC4oSthDqU9cf3u2CS4pwyGd5dXVv3IJrMPqW08SHjU=;
        b=PHK37/6BC93sa2U8vVLffIfZLoLfvLEUdjc5PDUnIWHanPCuBFvmeXTAOktMipPju/
         MU3gG/0WYsWu7craUR8r9AFY8IpVJkypg0GfImeoDwL3hHsytzJi1Z2T/rusVjmUVmuH
         TOyoyatn5wIxzEFPbE4IzyrOApadPH5x2K1fj6ZvvgS0TiF8XZyROf7UL3p4x54xHmfD
         Tb8TRj9VgeAsQjgOon9jeSOLFfurjByG2hHNeKHrvHskT30x6sAJ9+451BL1PuVJMa+z
         kCmADvdlrDNL3a5NCbCv7bGv43HKl32uBS++n+tltJ6n/feVL9saJhXnTddedBUQ0Xg5
         dngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sC4oSthDqU9cf3u2CS4pwyGd5dXVv3IJrMPqW08SHjU=;
        b=Qvme2l+n2t9vkd+7w/0C/r/VfiOW2AytceP/VhH4tDoqZekBZVLoh8Jz/qnuEc5wsu
         YJFF9LIwuScuub1zh1o30oCE+Ja35B57Gb2091vajEg4PtJvbHkmaO0njoSZFzEVTdKX
         lO+pcI2p2hONK5mMwcQvbe9vzR/gcD6tDVXMxJvci+TlDhf3A/jzzWrTqtwHhNznKtk3
         nDFxrXXDPCFf04eE8ibkJqCobzYBly0xjnG7cPII9TJPKDA3egWsiohmas4J7GPxLBBM
         yMxzQsOB7tTs99rBHZ72S8IWnmSQ7GkQzcAU6FmYVS6kAHuD0UKgWXvHZZeNAxu3LCf2
         yoFg==
X-Gm-Message-State: AFqh2krRH91QFzfTj1hjUCrtSJLtMv2S7gbEwfGu3yVHzq/E+y7afTQL
        IN7GAON2LYhW1yJAqDx0pMDVIQ==
X-Google-Smtp-Source: AMrXdXvOicajt2IQqs1cr0S7TxfA67bKcXWin0mWuNxnzOwgUl0pT6dXcK/3bL8CyUYii8kYqIashQ==
X-Received: by 2002:adf:f703:0:b0:2bd:dd96:b06a with SMTP id r3-20020adff703000000b002bddd96b06amr5342051wrp.48.1674030183084;
        Wed, 18 Jan 2023 00:23:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b002423edd7e50sm30440470wrz.32.2023.01.18.00.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:22:59 -0800 (PST)
Message-ID: <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
Date:   Wed, 18 Jan 2023 09:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118063822.14521-3-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 07:38, Okan Sahin wrote:
> Add ADI MAX77541/MAX77540 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77541.yaml | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,max77541.yaml b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> new file mode 100644
> index 000000000000..91d15e9ca2e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,max77541.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77540/MAX77541 PMIC from ADI
> +
> +maintainers:
> +  - Okan Sahin <okan.sahin@analog.com>
> +
> +description: |
> +  MAX77540 is a Power Management IC with 2 buck regulators.
> +
> +  MAX77541 is a Power Management IC with 2 buck regulators and 1 ADC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77540
> +      - adi,max77541
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: /schemas/regulator/adi,max77541-regulator.yaml#

No improvements regarding bisectability - this patch fails. If you
tested this patch, you would see it.

Instead of ignoring comments, either implement them or ask for
clarification.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,max77540
> +    then:
> +      properties:
> +        regulator:

You do not have 'regulator' property.

> +          properties:
> +            compatible:
> +              const: adi,max77540-regulator
> +    else:
> +      properties:
> +        regulator:

Same problem.

> +          properties:
> +            compatible:
> +              const: adi,max77541-regulator
> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

