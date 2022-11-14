Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578136277FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiKNIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiKNIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:45:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299D19C23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:45:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j16so18076121lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVmwIG2s4EyBaQ0ZMDJcfx3U/7J7QX25R/a+LsVxmaQ=;
        b=alrOU5uP7aHB2OFLmG9pJgp21eMFCOH3j4AkhDcS2sO5Yizu6MhR4FQah7F2cKfipz
         iD0Gh4I810N5WEy6laL4piM6oHiTDJYl8vW6zlEYX3KKRJBksbXi5iuGhuQ/0swEK4fV
         GZjkloAP+/m4KHm2r0U+FD+pa4+4uWk+ooj8ROfxFRT5fEmY4Fy4Vf4ElgusOVZF+AQx
         xwxSyhjAGg97ufFF6xLK6u0YBZPeE+TfXWTf6Zd+1/oAIoJD9YNyNGleEbbjv1uyZjqG
         rEshg9X5fh7HXIK/rz80rtkH4Iq7v4J9ducjDJNdMIh4s8vQRJRendfxMsh68Uchrtau
         p7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVmwIG2s4EyBaQ0ZMDJcfx3U/7J7QX25R/a+LsVxmaQ=;
        b=2Ld+eqKzgSU3Lcq1Wi/KZemb6w7FIEXrcoR2qa8PY5+WCxxPJxJPbUfVA57QML7Xtl
         Q6BRdSVIT24IF4N9Mm1F70jny7N4mMAkBYofLZSym/Jr1feZIJCzjcl27QDBDbcn/3u/
         GUBKkp7t5mjJAxs7C1KxyLUjibHzI7YqYvMLwnIh0jWGpr/tLxSbcxCc0CY98RCZSdI4
         S7U0haJnilT6RqIyvPJ7Z/fq+8pEPWPrJ+awq4s6usxz60bQKjdp1/3q1cA7/6stuORU
         xQuFzQzn1x06ElTup6UkzltMjbJvGd0PSaDkcEvJV4kKbCI+NdTzjdMLM6zu1vLbDX9j
         htUQ==
X-Gm-Message-State: ANoB5pmbX7izSeLknTObarbpG+DOqv/9QeuhmNsNn8e0iES4IxoU0kC1
        IE+iWcRvyMIHPh5mLhH8qEBVBQ==
X-Google-Smtp-Source: AA0mqf6q4FegMx0hyfkYq/jghX+kjt+/o7dthzyPPPyfPesctUBSYTYFvjnnMmZKzmBu7YqYCN99Mw==
X-Received: by 2002:a05:6512:3f28:b0:4a2:2aab:5460 with SMTP id y40-20020a0565123f2800b004a22aab5460mr3548905lfa.62.1668415522033;
        Mon, 14 Nov 2022 00:45:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a2ea230000000b0027710117ebdsm1907109ljm.121.2022.11.14.00.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:45:21 -0800 (PST)
Message-ID: <5f012334-1815-2ef6-7dc0-08b4d60f754f@linaro.org>
Date:   Mon, 14 Nov 2022 09:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/12] dt-bindings: sound: Add Cirrus Logic CS48L31/32/33
 codecs
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org, tglx@linutronix.de,
        maz@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-12-rf@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109165331.29332-12-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 17:53, Richard Fitzgerald wrote:
> Codecs in this family have multiple digital and analog audio I/O that
> support a variety of external hardware connections and configurations.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs48l32.yaml        | 96 +++++++++++++++++++
>  include/dt-bindings/sound/cs48l32.h           | 25 +++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
>  create mode 100644 include/dt-bindings/sound/cs48l32.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
> new file mode 100644
> index 000000000000..70fb294c6dc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,cs48l32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS48L31/32/33 audio CODECs
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  This describes audio configuration bindings for these codecs.

Don't start with "This". Instead describe the hardware.

> +
> +  See also the core bindings for the parent MFD driver:
> +
> +    Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml

Same comment as for pinctrl patch.

> +
> +  and defines for values used in these bindings:
> +
> +    include/dt-bindings/sound/cs48l32.h
> +
> +  The properties are all contained in the parent MFD node.
> +
> +properties:

Missing compatible. What's the point to organize bindings like that? The
schema on its own does nothing - does not match anything.

> +  '#sound-dai-cells':
> +    const: 1
> +
> +  cirrus,in-type:
> +    description:
> +      A list of input type settings for each input. A maximum of 8 cells,
> +      with four cells per input in the order INnL_1, INnR_1 INnL_2 INnR_2.
> +      (where _1 and _2 are the alternative mux selections for that INn).
> +      If the array is shorter than the number of inputs the unspecified
> +      inputs default to CS48L32_IN_TYPE_DIFF.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"

Drop quotes.

> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      items:
> +        - description:
> +            The first cell is INnL_1 input type. One of the CS48L32_IN_TYPE_xxx.
> +            For non-muxed inputs this sets the type of INnL.

What is the "input type"? Referring to constants is not enough,
especially that they are not descriptive. Explain here the values.

> +            minimum: 0
> +            maximum: 1
> +        - description:
> +            The second cell is INnR_1 input type. One of the CS48L32_IN_TYPE_xxx.
> +            For non-muxed inputs this sets the type of INnR.
> +            minimum: 0
> +            maximum: 1
> +        - description:
> +            The third cell is INnL_2 input type. One of the CS48L32_IN_TYPE_xxx.
> +            For non-muxed inputs this cell must be 0.
> +            minimum: 0
> +            maximum: 1
> +        - description:
> +            The fourth cell is INnR_2 input type. One of the CS48L32_IN_TYPE_xxx.
> +            For non-muxed inputs this cell must be 0.
> +            minimum: 0
> +            maximum: 1
> +
> +  cirrus,max-channels-clocked:
> +    description:
> +      Maximum number of channels that clocks will be generated for. When using
> +      multiple data lines, every sample slot can transfer multiple channels
> +      (one per data line). This pdata sets the maximum number of slots.
> +      One cell for each ASP, use a value of zero for ASPs that should be
> +      handled normally.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      default: 0
> +
> +  cirrus,pdm-sup:
> +    description:
> +      Indicates how the MICBIAS pins have been externally connected to DMICs
> +      on each input. One cell per input (IN1, IN2, ...). One of the
> +      CS48L32_MICBIAS_xxx values.
> +      See the INn_PDM_SUP field in the datasheet for a description.

No, explain here.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +
> +examples:
> +  - |
> +        cs48l32@0 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +                compatible = "cirrus,cs48l32";
> +

Use 4 spaces for example indentation.

> +                cirrus,in-type = <
> +                        CS48L32_IN_TYPE_DIFF CS48L32_IN_TYPE_DIFF /* IN1[LR]_1 differential */
> +                        CS48L32_IN_TYPE_SE   CS48L32_IN_TYPE_SE   /* IN1[LR]_2 single-ended */
> +                        CS48L32_IN_TYPE_DIFF CS48L32_IN_TYPE_DIFF /* IN2[LR]_1 differential */
> +                >;
> +                cirrus,max-channels-clocked = <2 0 0>;
> +        };
> diff --git a/include/dt-bindings/sound/cs48l32.h b/include/dt-bindings/sound/cs48l32.h
> new file mode 100644
> index 000000000000..0b774da0a6c8
> --- /dev/null
> +++ b/include/dt-bindings/sound/cs48l32.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

> +/*
> + * Device Tree defines for CS48L32 codec.
> + *
> + * Copyright (C) 2016-2018, 2022 Cirrus Logic, Inc. and
> + *               Cirrus Logic International Semiconductor Ltd.
> + */
> +
> +#ifndef DT_BINDINGS_SOUND_CS48L32_H
> +#define DT_BINDINGS_SOUND_CS48L32_H
> +
> +#define CS48L32_IN_TYPE_DIFF		0
> +#define CS48L32_IN_TYPE_SE		1
> +
> +#define CS48L32_PDM_SUP_VOUT_MIC	0
> +#define CS48L32_PDM_SUP_MICBIAS1	1
> +#define CS48L32_PDM_SUP_MICBIAS2	2
> +#define CS48L32_PDM_SUP_MICBIAS3	3
> +
> +#define CS48L32_PDM_FMT_MODE_A_LSB_FIRST	0x0000
> +#define CS48L32_PDM_FMT_MODE_B_LSB_FIRST	0x4000
> +#define CS48L32_PDM_FMT_MODE_A_MSB_FIRST	0x8000
> +#define CS48L32_PDM_FMT_MODE_B_MSB_FIRST	0xc000

Register values do not belong to bindings.

> +
> +#endif

Best regards,
Krzysztof

