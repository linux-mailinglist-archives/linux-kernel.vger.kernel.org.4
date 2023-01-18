Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5453E671ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjAROEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjARODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B22A99E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:40:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so1435003wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjc4VCpZNQP556V0c7PmfHBKoB04p5vvZzElOaTdSEg=;
        b=XV8+LO/0KQENBbmt/brfX4pIAJEO8/CsQI3T5uXentjRlVKmeZ+Lez9yC3jGyXpH7S
         O98BAdGi3PF7LJ19YIl6AltWzzY6KDINRRbLEzyK+oXZ9peDaAEL8qewhOQ5TBIMLNvL
         cY17/rRQddElbgeeOmueS/vt+DJnU+0yT0Y5fJIBcsd4bmthmE91Bpa3asUxaI0H2P46
         Mp8gZ7WZCSG9TzLhYf8ZHbTkrYNPiMIBqWpdtq91zi70bdUI7YEzQTGCw3sLxg3/IIHp
         8njKqiHGKyTlN53ZXhE0CBTE4zcsEllgVNwM4Se39fxtfRUxj6J3uOLbS0wsXRYXJSjH
         daRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjc4VCpZNQP556V0c7PmfHBKoB04p5vvZzElOaTdSEg=;
        b=NHRzbVoHZf3v6KK9f483EVLe/1//NvuTIrGMgOSPVWl4C+lDY7srYQ2DTO2qkeV24H
         3lcoTlvzvLQPPzQSGl/xiglmEkCVnOUu/4BvdzR8etm2FJnx8sjRfIffDworvNUUy+38
         PnUlqcLoSj0965iU+Eg4MYyuSkm+01vpe93CEauxQAlyUWyvISlLoYvpzpP5VPEV7bIb
         QDETSBZVGIXOt9Q60bM8nGN7O8OOiTFXpcyEUnRdNddBppbA9m7I9dVNhlNwOzPb/BaK
         DGzu23TAF/A8Yn/W96UlL+aDcrgt3UIzK6EpIDkgfn08+BYu8eX3nAWJXdQmxwKTnPqs
         fZkw==
X-Gm-Message-State: AFqh2kpDi0gMXzz2YsH0Ocny6IGie+N1AAtJKaawn6Xz8Un9L/fbgD2H
        OICiDF6uN/ipfbhEgIV3gHKlgg==
X-Google-Smtp-Source: AMrXdXsYqqOpahJDdUdyjMPCRZYkQl34osNeO69nPzrNQAGp4jHjFNBdqZh1Sg7dDQ6W3H8ez7AfOQ==
X-Received: by 2002:a05:600c:181b:b0:3da:ff1f:e8d3 with SMTP id n27-20020a05600c181b00b003daff1fe8d3mr6684165wmp.15.1674049202461;
        Wed, 18 Jan 2023 05:40:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003d9b87296a9sm2024751wmo.25.2023.01.18.05.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:40:02 -0800 (PST)
Message-ID: <1a8c006d-c9b9-9fd0-147e-7e511cb236fe@linaro.org>
Date:   Wed, 18 Jan 2023 14:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20230118131002.15453-1-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118131002.15453-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 14:10, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Remove "items" between "compatible" and "const: kinetic,ktz8866"
>   - Change "additionalProperties" to "unevaluatedProperties"
> 
> Changes in v3:
>   - Add Krzysztof's R-b
> 
> Changes in v4:
>   - Drop Krzysztof's R-b
>   - Add some new properties
> 
> Changes in v5:
>   - Add missing enum under property description.
>   - Rename uncorrect properties.
> 
> Changes in v6:
>   - Correct wrong property suffix and description.
> 
>  .../leds/backlight/kinetic,ktz8866.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> new file mode 100644
> index 000000000000..ca0deba14523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTZ8866 backlight
> +
> +maintainers:
> +  - Jianhua Lu <lujianhua000@gmail.com>
> +
> +description: |
> +  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
> +  with dual lcd bias power.
> +  https://www.kinet-ic.com/ktz8866/
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: kinetic,ktz8866
> +
> +  current-num-sinks:
> +    description: Number of LED current sinks.
> +    enum: [1, 2, 3, 4, 5, 6]
> +
> +  current-ramping-time-ms:
> +    description: LED current ramping time in milliseconds.
> +    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
> +
> +  led-ramping-time-ms:
> +    description: |
> +      LED on/off ramping time in milliseconds, note that the case 0 will be mapped
> +      to 512μs because ktz8866 can't ramp faster than it.

Aren't you just missing supplies here and their ramp up time?

> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
> +
> +  enable-lcd-bias:
> +    description: Set if we want to output bias power supply for LCD.

Is it a generic property? I don't see any other users, so this looks
device specific thus needs vendor prefix.

This applies to all of the properties. They might be generic or might
not, I don't know the backlight hardware that much.

> +    type: boolean
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    backlight {
> +        compatible = "kinetic,ktz8866";
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&bl_en_default>;
> +
> +        current-num-sinks = <5>;
> +        current-ramping-time-ms = <128>;
> +        led-ramping-time-ms = <1>;
> +        enable-lcd-bias;
> +    };

Best regards,
Krzysztof

