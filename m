Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8446CAE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjC0TGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjC0TGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:06:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D8213A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:05:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i5so40581179eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679943956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BuTaW3J/AVyHqQTC99uJpLP3eB+1iZMX0oLrYWZybg=;
        b=rvtir/fKMe5BFCjaJdjHOfomSp4Suwz5z93QZbJCSSOZzdffa80//lK2r1VS6X8dBV
         Q3zezRWxrKQiVVwJvIDMvQd3VkEbUGUmwyb9jZkg1oU4xR9TXTgCxxgek85roq8Lmg0f
         Fr7ijPOnBZLJT8CPdKRSIFNQyLkK6klKoc+7AW2PhUFI0jo0EWutqEKd51EojBl+1Kg/
         i4k3Lk5ltnk3EtKcBA4Ht3dE4N4I5/cYfW3VNsX01ur+YApq1F8TbISjPvsEEQTZbWhv
         cOqZBzN5C8l0qbQnBnIA7MV3oP4FLqAzhw66qDHsNzurH/iYwboWnETkQOuHCwQZfz1y
         F+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BuTaW3J/AVyHqQTC99uJpLP3eB+1iZMX0oLrYWZybg=;
        b=iNakUPUk9o+gLKYupC4xu2a0Ow82RInZyeCDKxJKCXkq3W/DzRRNdRN9iisDlz4f1n
         8eO+VXcDxOfHKUdU/lQahVH8NtwuHOqgukoOWqOM32qbun4LJxzfoGqtSVF9uUnuxDQQ
         /NLhdkMKluqNtsWkpjIQ8JCoSAaLiHYd0EuuY/U8iIPR6J9yo4WBIqSahSpfmqMgqR92
         MXBv9HOQ31zr642MaqOMWFw9m3VqAOMdIt+RK2zRmu4eQryy3V2UPtLtgbNOdLAJPYyK
         tmt+cwsWQ56mVE9VTd97qdKIF9w9Mqz+ZGkdemqB2agxBf8zD3qb2AGqL+LkoViO+Eth
         Unlg==
X-Gm-Message-State: AAQBX9e0+Nf/8L5GBB7D+AptK6sbgzyhBNXqDGW5XzmekaWqe1b1/xli
        w8Vqf/SXv+IbRQUtEyckEkbv5A==
X-Google-Smtp-Source: AKy350Yk0SAFeqtvDmPlrfg7iYq7hca/kt9KOVLp+eQtXd3p2q9/r1Uucloa+XrwYBhRNKnXMxHopA==
X-Received: by 2002:a05:6402:1655:b0:501:d917:d52 with SMTP id s21-20020a056402165500b00501d9170d52mr11701917edx.8.1679943955993;
        Mon, 27 Mar 2023 12:05:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9314:a4b3:ce49:2c6b? ([2a02:810d:15c0:828:9314:a4b3:ce49:2c6b])
        by smtp.gmail.com with ESMTPSA id x93-20020a50bae6000000b004fbf6b35a56sm14997800ede.76.2023.03.27.12.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:05:55 -0700 (PDT)
Message-ID: <138820d9-5ff4-0cd1-88a9-6845ad85d157@linaro.org>
Date:   Mon, 27 Mar 2023 21:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-2-okan.sahin@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327130010.8342-2-okan.sahin@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 15:00, Okan Sahin wrote:
> Add ADI DS4520 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/gpio/adi,ds4520-gpio.yaml        | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
> new file mode 100644
> index 000000000000..69f90e59d415
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml

Filename matching compatible.

> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/adi,ds4520-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DS4520 I2C GPIO expander
> +
> +maintainers:
> +  - Okan Sahin <okan.sahin@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ds4520
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':

Use consistent quotes - either ' or ".

> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {

i2c


> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ds4520: gpio@50 {

Drop the label, not used here.

> +            compatible = "adi,ds4520-gpio";

As Rob's bot pointed...

Best regards,
Krzysztof

