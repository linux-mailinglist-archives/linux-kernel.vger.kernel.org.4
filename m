Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBC6F8701
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjEEQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEEQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:48:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE315EE1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:48:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so3033594a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683305300; x=1685897300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzAMX4Kz9IJKO+zvZ0xc8kUOpcxC2lFYPzqNj8WVdAs=;
        b=MAbdQFhdJO0A+Ih6Eoq3XWdlI0+r8kLA925xdP3fJdPqzm3HPm7ERSKbLG+M0FB7ha
         c9FVpnAhpMKU44vxnx7PEd6OheCBrCsYgk370n5Uy/uM1LHOzZ8F4SEt+0QaGgLsH4rc
         aMd4C5aUpWkoea62w9Nbv6dDz57I5ikSYd9zJjDqYdzgAZxNgn75oCFpO++zLSDz1bDt
         CNsBCXO5Z6zvO+qJfu9lAx/cqkGNhHuFVK+O5eQ3PRaHhEiAxALVEU8aGQeObYVC+f80
         /Qrs7I8/1xsUgk5rrSC1uR4QvE1LwtC7tO+vZx4eL5WBgkthlQMrmDvQUGsKW1tahY4P
         KNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305300; x=1685897300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzAMX4Kz9IJKO+zvZ0xc8kUOpcxC2lFYPzqNj8WVdAs=;
        b=LGs4RbtM/gWZYzE043cyAPgTDmnw8Oc5x2TSU19yvU04Z0+32/TkX918GagrsXDzsl
         mkYAfaDUMG4uJBaepMfYpHbu6m03CVwuF35QyG2a3jFEmq2HxOLv7OWK9sGh4hH/8lLp
         UdaegV0OPT0+OIjyE20eY4mYJiRMDrzKCMXpkL9VcGI62sRLHYCttj++zehsbwjg9njb
         5fR16Y9u1iAf/FAUPkiv5vmFQMvxIcMHW6qmQIOCC6vqWP4/kT2Y1tdZhUkdudIpHxnB
         4GXK31dmhHy4x8ImUNCJoTeM1TQQjOQQlPVsu/WQpVObin2DPoWevZw+8Z3yBVxx6MD6
         UDlA==
X-Gm-Message-State: AC+VfDyvMDO+7KiD3uYxU3sogJrTUIKiaQ2x4lArgEzokKJ4P5WT+fo+
        xKxCnR/DVf2OnfrBC1auVhUqKA==
X-Google-Smtp-Source: ACHHUZ6qLQDbAdXWLOl8HQxIAXGdgKXK+tKEcWtC8K+v9wpTVrXIZhvS6P2QN4oC0XkkQogQbitwYA==
X-Received: by 2002:a17:907:6e1c:b0:94f:2249:61d4 with SMTP id sd28-20020a1709076e1c00b0094f224961d4mr1778686ejc.34.1683305300480;
        Fri, 05 May 2023 09:48:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id kg20-20020a17090776f400b0094f3e169ca5sm1142063ejc.158.2023.05.05.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:48:19 -0700 (PDT)
Message-ID: <3af0c3a9-70b8-4c2b-8ab9-dd43c531b3b6@linaro.org>
Date:   Fri, 5 May 2023 18:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Content-Language: en-US
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZFUC6Tsku+aWod/+@arbad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFUC6Tsku+aWod/+@arbad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 15:21, Andreas Klinger wrote:
> Honeywell mprls0025pa is a pressure sensor series. There are many
> different models with different pressure ranges, units and transfer
> functions.
> 
> The range and transfer function need to be set up in the dt. Therefore
> new properties honeywell,pmin-pascal, honeywell,pmax-pascal,
> honeywell,transfer-function are introduced.
> 
> Add dt-bindings.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> new file mode 100644
> index 000000000000..84a61721b597
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mprls0025pa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Honeywell mprls0025pa pressure sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Honeywell pressure sensor of model mprls0025pa.
> +
> +  This sensor has an I2C and SPI interface. Only the I2C interface is
> +  implemented.
> +
> +  There are many models with different pressure ranges available. The vendor
> +  calls them "mpr series". All of them have the identical programming model and
> +  differ in the pressure range, unit and transfer function.
> +
> +  To support different models one need to specify the pressure range as well as
> +  the transfer function. Pressure range needs to be converted from its unit to
> +  pascal.
> +
> +  The transfer function defines the ranges of numerical values delivered by the
> +  sensor. The minimal range value stands for the minimum pressure and the
> +  maximum value also for the maximum pressure with linear relation inside the
> +  range.
> +
> +  Specifications about the devices can be found at:
> +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
> +      products/sensors/pressure-sensors/board-mount-pressure-sensors/
> +      micropressure-mpr-series/documents/
> +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> +
> +properties:
> +  compatible:
> +    const: honeywell,mprls0025pa
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Optional GPIO for resetting the device.
> +      If not present the device is not resetted during the probe.
> +    maxItems: 1
> +
> +  honeywell,pmin-pascal:
> +    description:
> +      Minimum pressure value the sensor can measure in pascal.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  honeywell,pmax-pascal:
> +    description:
> +      Maximum pressure value the sensor can measure in pascal.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  honeywell,transfer-function:
> +    description:

Here you need | to preserve formatting.

> +      Transfer function which defines the range of valid values delivered by the
> +      sensor.
> +      1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> +      2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> +      3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +required:
> +  - compatible
> +  - honeywell,pmax-pascal
> +  - honeywell,pmin-pascal
> +  - honeywell,transfer-function
> +  - reg
> +  - vdd-supply

Keep the same order as they appear in properties:.

Rest looks good, so with these fixes:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

