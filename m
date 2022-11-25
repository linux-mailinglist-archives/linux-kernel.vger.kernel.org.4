Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF830638534
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKYI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKYI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:29:25 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057F31208
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:29:23 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h5so136879ljk.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbfwrVz027Kn0FHAJfS+jf/DBbMwmEQoqxG1FAyNFnY=;
        b=CZyayG2rb8XXbW8TRWf1De/qC1oDKa3sdzUGz7CFZJGCUJ3hke8Pcv0SeBip81FJ+x
         JusaXlEkx99owAXC/ie/A2BEOiz9lo96sXqrH9PrILlr9fm7Q74h5txF9/7pdiaQJQaf
         IwGvVohyPx+WhA5YDvNeNiUqDO5bg5Rr/TOYTB0INb39o0KHXAkCsX+BcJTiEyMe+OWz
         ndkUFRZtWXJL/+favQy+K7bgw5rgQXLzi+OAa9afoF1GgZzDIeFsJsnNgPtTrGCr5yxx
         +3b8l72SWqhmqBYEORw5J8iVlxU8K2JmLb1yHTHHBMMiFs3iRUvegzmFBZW5g5ESBZc5
         PMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbfwrVz027Kn0FHAJfS+jf/DBbMwmEQoqxG1FAyNFnY=;
        b=5+MHyYpZNBejuRwd/Zl07lIdpG+pE88ekmqD3NtEaBxUuFFYQ0GOxY2VLSqckDhHUO
         nKgXjzPF1Gnm0kAd5O3CfRHGmH6JMu/0TAZZ02UcE6t3XkBmTb74dth3oGliruiFC2CT
         Ypbp91GfgQQc8pk7G1tQgzNKqZP3sD6XFUft7+RpNTtpjwIuBdfsqZze+VunuWiKnx2T
         XTRBYl73CRMjGYvI+A+HFbIBKEnm5jSCs2vnRlCUH6DAtL7sascuZAIih/MC+3STNV+h
         3Ea25hWA1DMNgAkV3931XdssyJ7TZZD6qEQovG2x5L/uSrfDnns4O3OXrhpMOToA/Prl
         lmew==
X-Gm-Message-State: ANoB5plUdlRTEpf+fG+RF9Uo9Ri2YVjmelzD+wXweZm4b/sz/s8eyDDn
        l9y4AlkFbHu9CshCGZ/UWyZsnA==
X-Google-Smtp-Source: AA0mqf5FUk43GbJYwwcX9qThwDXMqvjhHMe9EIo5ni6bShbP7bgEsHNhrO3aT3+GkPVltba10RRQsQ==
X-Received: by 2002:a05:651c:1797:b0:277:1caf:679e with SMTP id bn23-20020a05651c179700b002771caf679emr6321914ljb.115.1669364961806;
        Fri, 25 Nov 2022 00:29:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t24-20020a056512209800b004ae24559388sm433351lfr.111.2022.11.25.00.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:29:21 -0800 (PST)
Message-ID: <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
Date:   Fri, 25 Nov 2022 09:29:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel@sberdevices.ru
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 21:48, Martin Kurbanov wrote:
> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
> led driver.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  .../bindings/leds/leds-aw200xx.yaml           | 110 ++++++++++++++++++
>  include/dt-bindings/leds/leds-aw200xx.h       |  48 ++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
>  create mode 100644 include/dt-bindings/leds/leds-aw200xx.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml b/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
> new file mode 100644
> index 000000000000..3bdadcbc2ee2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml

Filename based on compatibles, so "awinic,aw200xx.yaml"

> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-aw200xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AWINIC AW200XX LED Driver

What does the "Driver" mean? Linux Driver? If yes, then drop it. Same in
other places.

> +
> +maintainers:
> +  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
> +
> +description: |
> +  This controller is present on AW20036/AW20054/AW20072.
> +  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> +  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +  3 pattern controllers for auto breathing or group dimming control.
> +
> +  For more product information please see the link below:
> +  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
> +  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
> +  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - awinic,aw20036
> +      - awinic,aw20054
> +      - awinic,aw20072
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  display-size:

Is it a standard property? Does not look like. Non-standard properties
need vendor prefix and type ($ref).

> +    maxItems: 1
> +    description:
> +      Leds matrix size, see dt-bindings/leds/leds-aw200xx.h

But judging by your constants, you have the same number of columns, just
rows differ, so probably you want to describe here number of rows.

> +
> +  imax:
> +    maxItems: 1
> +    description:
> +      Maximum supply current, see dt-bindings/leds/leds-aw200xx.h

No. Use existing properties from common.yaml. This looks like
led-max-microamp and it is per LED, not per entire device.

> +
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#

unevaluatedProperties: false

> +
> +    properties:
> +      reg:
> +        description:
> +          LED number
> +        maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - display-size
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/leds/leds-aw200xx.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@3a {
> +            compatible = "awinic,aw20036";
> +            reg = <0x3a>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            interrupt-parent = <&gpio_intc>;
> +            interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +
> +            display-size = <AW20036_DSIZE_3X12>;
> +            imax = <AW200XX_IMAX_60MA>;
> +
> +            led@0 {
> +                reg = <0x0>;
> +                color = <LED_COLOR_ID_RED>;
> +            };
> +
> +            led@1 {
> +                reg = <0x1>;
> +                color = <LED_COLOR_ID_GREEN>;
> +            };
> +
> +            led@2 {
> +                reg = <0x2>;
> +                color = <LED_COLOR_ID_BLUE>;
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/leds/leds-aw200xx.h b/include/dt-bindings/leds/leds-aw200xx.h
> new file mode 100644
> index 000000000000..6b2ba4c3c6b1
> --- /dev/null
> +++ b/include/dt-bindings/leds/leds-aw200xx.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Dual license, like bindings.

> +/**
> + * This header provides constants for aw200xx LED bindings.
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> + */
> +#ifndef _DT_BINDINGS_LEDS_AW200XX_H
> +#define _DT_BINDINGS_LEDS_AW200XX_H
> +
> +/* Global max current (IMAX) */
> +#define AW200XX_IMAX_3_3MA  8
> +#define AW200XX_IMAX_6_7MA  9

No. Bindings are not for storing register constants. Feel free to store
here IDs (ID start from 0 or 1 and is incremented by 1)... but how the
IMAX even matches any need for "ID"?

> +#define AW200XX_IMAX_10MA   0
> +#define AW200XX_IMAX_13_3MA 11
> +#define AW200XX_IMAX_20MA   1
> +#define AW200XX_IMAX_26_7MA 13
> +#define AW200XX_IMAX_30MA   2
> +#define AW200XX_IMAX_40MA   3
> +#define AW200XX_IMAX_53_3MA 15
> +#define AW200XX_IMAX_60MA   4
> +#define AW200XX_IMAX_80MA   5
> +#define AW200XX_IMAX_120MA  6
> +#define AW200XX_IMAX_160MA  7
> +
> +/* Display size for aw20036 */
> +#define AW20036_DSIZE_1X12 0
> +#define AW20036_DSIZE_2X12 1
> +#define AW20036_DSIZE_3X12 2
> +
> +/* Display size for aw20054 */
> +#define AW20054_DSIZE_1X9 0
> +#define AW20054_DSIZE_2X9 1
> +#define AW20054_DSIZE_3X9 2
> +#define AW20054_DSIZE_4X9 3
> +#define AW20054_DSIZE_5X9 4
> +#define AW20054_DSIZE_6X9 5
> +
> +/* Display size for aw20072 */
> +#define AW20072_DSIZE_1X12 0
> +#define AW20072_DSIZE_2X12 1
> +#define AW20072_DSIZE_3X12 2
> +#define AW20072_DSIZE_4X12 3
> +#define AW20072_DSIZE_5X12 4
> +#define AW20072_DSIZE_6X12 5

Drop all constants and instead use number of rows without specifying it
in binding.

So in total entire file can be dropped.

> +
> +#endif /* !_DT_BINDINGS_LEDS_AW200XX_H */

Best regards,
Krzysztof

