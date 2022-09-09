Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D925B321D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiIIIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIIIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:45:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7BC8B98C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:45:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m15so1506588lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZSXnk2kkT4RDB6r1y9rOYCpY5Yh7WRqMxlBS7mQ+NX4=;
        b=EW6l4VUKTQmo5nbMnx5ALSP2h2pfm9mA1GTx67eLPWIl9p1wcHW2eokPugIL8OTYoB
         rsR2EYm8TAhnbAQ5BDzAZpxi++EAeXCI7h+r0nMP2BRi1qvx+geiISU1FiOmEJEEPHkK
         QSAYXgmZg2ifces3aga5Cwvh9CoRywBGNlaO8aZnezaKcHyiP8Wq3fA63brrYQI3xHSs
         1BiMFNnBK3h6zB7gnYllqXTwelSURAK50oCkL91L6csUiqYTLKmMSJNMazlMQpzVSROQ
         O+biMxxdXb+PMMfxxWYVA047P+mSnHl3B0aHpLxze/+F4LCKrDTIlVbOWMVFfXhbzsyI
         XzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZSXnk2kkT4RDB6r1y9rOYCpY5Yh7WRqMxlBS7mQ+NX4=;
        b=MM6ift5QeGFjOxIUUCIw2U0mrjQx2jPfYAxUcJ2HIAnfVtSXO5kZfKfloq09JIuGnd
         /HwqrkWscbJYiCBgOwcdHSAfrm0Ymf5MyYX3+ycCp7ucqEWhd003wf3KbBwClaM3EmG6
         56uuj20IJmfS+aM9AhH2ogybLhslg2cKvTglYP6JIEPR2gQBmDYNuI4hyricdGITUkbG
         YFtrQnlBo45bpqIa6YWlW6TPUqEBM2JuSFXY3CBunmEGUMgKXXq3lyMDWvf0mr+djQMv
         W5blSXIM9kU01aOWw75P+Si2S3VRMYb8eOqXI5kaNW84Rdq3f6zENOyyjbBqQntCWK8S
         gfBw==
X-Gm-Message-State: ACgBeo3pmKmQ0PKsUKDE6m2GHVj0JRK+BKb0NDd9c68oGJrAQppFxdJ/
        Mb02EBGNzOBLN7Dkt4O45A+NoA==
X-Google-Smtp-Source: AA6agR7IWO5ppTJQJUDrlLe10NtRpPdhs1Ls7YIUiy+dNvD1kTX6h52BulmUCDgX6Sb7b9J3bq1LAw==
X-Received: by 2002:ac2:4e10:0:b0:498:f132:d5c1 with SMTP id e16-20020ac24e10000000b00498f132d5c1mr2146029lfr.648.1662713101149;
        Fri, 09 Sep 2022 01:45:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512060f00b00497a191bf23sm175671lfe.299.2022.09.09.01.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:45:00 -0700 (PDT)
Message-ID: <d3ed658e-88a2-f9cd-f7ab-56b660947b10@linaro.org>
Date:   Fri, 9 Sep 2022 10:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v7 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909071618.231246-1-Ibrahim.Tilki@analog.com>
 <20220909071618.231246-4-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909071618.231246-4-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 09:16, Ibrahim Tilki wrote:
> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---
>  .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> new file mode 100644
> index 000000000..003ec1317
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,max31760.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31760 Fan-Speed Controller
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +
> +description: |
> +  Analog Devices MAX31760 Fan-Speed Controller
> +  https://datasheets.maximintegrated.com/en/ds/MAX31760.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31760
> +
> +  reg:
> +    description: |

No need for |

> +      I2C address of slave device.

maxItems: 1

> +    items:
> +      minimum: 0x50
> +      maximum: 0x57
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {

Just i2c.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max31760@50 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +                reg = <0x50>;
> +                compatible = "adi,max31760";

Messed up indentation. 4 spaces for DTS example.

> +        };
> +    };


Best regards,
Krzysztof
