Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4750D6D2F74
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDAJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDAJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:42:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F733A97
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 02:42:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l27so24721347wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680342137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fu9gPLfW7KtEv2IIXvaOXu6pnvnnIoGSqbS5YRQSMzA=;
        b=ucK0Cs/61lk20Ig8uaid8/nFHg/p8O1F9ptRB99lJXNPHCCkL6emOD9PdVgrHSPI2+
         ZS25kl5VhzjR3qpLixn5UWt7LdllMyYcIF/bCdYrXmRRd6Rxocg2l1ZeRzY3aOtcMaWT
         XHb25UeW++5WBKdRRG8uvByqoqnzCdcKQfvz6RR7Z0Nqm5A4h27XeV6WPB1mbvgiY+2U
         zp98QeXst9VUm/uZEurKOyiQmTedV24uHTRVGFl67pUqxE89EyvfJa/YUbddEzgK6pYs
         +hxOkpWzrL+yaiLKIMDnNWcH+19dt4rg1nY0dZq5wvjkWAC3PVfLA/+5C+d5GKUlDdw+
         XNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu9gPLfW7KtEv2IIXvaOXu6pnvnnIoGSqbS5YRQSMzA=;
        b=TG8AL6W2ii5u7R7VUwTI+r+CCXqt9Z0LWt8Zfen0Gh9Ayou/t5h7eX2sO3VsJTZF9X
         YdihhFdWZyCA5CvKTXsqsEykVqBHUEdlqz9gNbmfOGqtoa89pppmwkzjrr2xIioqq2FL
         JByZt7cbtMsnoJTJmLAsTFNew3GCNisSWX/SBCH+Xy97ek2tvXKoGc4yBvo/yVF84ep1
         qN+KcrcS5WZvM/GyfnAxov+OSYAGRz8d5243gLNlsTEa/P0SJfNW4D24KgPDKZpq0eOc
         7gEpnq7lbZ5Q84bngsITHEDnlHZO7JrPH2ad8ilBawtDd3hB3AAjCK1J5D0tpvhU9qHr
         XeCw==
X-Gm-Message-State: AAQBX9frs80BhTMszAMtRuCoAVUpNoP4/7motyCwbbUN7kq0+CKP4sM1
        hXhjiu2jYPBKjiXw0gktK0teNw==
X-Google-Smtp-Source: AKy350ZNywWmraefRumCeoc7z8qpk9hbW1aIxktKLZVn7vMJFr6GDtmm5oKw4VPswANZcnL/llP7ow==
X-Received: by 2002:adf:fd51:0:b0:2ce:adda:f45a with SMTP id h17-20020adffd51000000b002ceaddaf45amr21986074wrs.62.1680342137511;
        Sat, 01 Apr 2023 02:42:17 -0700 (PDT)
Received: from [172.50.14.32] (5-226-109-132.static.ip.netia.com.pl. [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id h14-20020adffd4e000000b002c71a32394dsm4404362wrs.64.2023.04.01.02.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 02:42:16 -0700 (PDT)
Message-ID: <27a1d0f4-3a02-c7fd-36a0-07729a136e20@linaro.org>
Date:   Sat, 1 Apr 2023 11:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZCf01btsJRXcIOce@arbad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCf01btsJRXcIOce@arbad>
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

On 01/04/2023 11:09, Andreas Klinger wrote:
> Honeywell mpr is a pressure sensor family. There are many different
> types with different pressure ranges. The range needs to be set up in
> the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
> introduced.
> 
> Add dt-bindings.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> new file mode 100644
> index 000000000000..d6fad6f841cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Honeywell mpr pressure sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C

Doesn't look wrapped according to Linux coding style (see Coding style).

> +  interface is implemented.
> +
> +  There are many subtypes with different pressure ranges available. Therefore the minimum and
> +  maximum pressure values of the specific sensor needs to be specified in Pascal.
> +
> +  Specifications about the devices can be found at:
> +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
> +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
> +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf

Lines are not continued, so drop \

> +
> +properties:
> +  compatible:
> +    const: honeywell,mpr

You need device specific compatible, not some generic one. Rename also
then the filename (should match the compatible).

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Optional GPIO for resetting the device. If not present the device is not resetted.

Are you sure it is wrapped properly?

> +    maxItems: 1
> +
> +  honeywell,pmin:
> +    description:
> +      Minimum pressure value the sensor can measure in pascal.

Use standard unit suffix:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  honeywell,pmax:
> +    description:
> +      Maximum pressure value the sensor can measure in pascal.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Same.

Why these values are suitable for DT? Does it depend on type of sensor
(thus it is implied from compatible) or on system setup?

> +
> +required:
> +  - compatible
> +  - reg
> +  - honeywell,pmin
> +  - honeywell,pmax
> +


Best regards,
Krzysztof

