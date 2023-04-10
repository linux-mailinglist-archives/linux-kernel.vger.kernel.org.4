Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFF6DC88F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDJPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDJPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:34:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1666EB8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:34:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ga37so13669745ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140842;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqtoN0OKgoyUeb8t5u3oNJm4LieXPZgqxU17hzS/9gQ=;
        b=fF5XvSpx0zslDPXSB/uQtorXfgA0CJVWQSI3PrMvgsylTl5Ht3d1s+3XySk5bt5xYk
         lhqlfsT4aKSnjIYtBAGg4YZUCGFzo8BDDP91u8IFb+UGKEOLb+BkMEF7kKBfp4WfM0ok
         juQ5BsGN0o7psWMQ8E/kYUG7aP5lbBmOCIr50rAIbWTGANCOCHyOqhgbsQ+5dQLTvq9O
         QqgzNnhESNBzVjSRLlqF12X8a2XNfE2dmPsEPgMGoiZQhDE5A1l1IZlHOxi5+torbuZ2
         ckRZ6ha0VYHZdvBdwzRZTLMWT80iUNbze5XK0d/kFGrreBnz3XWFUaKVMllIKTIKi/OB
         orBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140842;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqtoN0OKgoyUeb8t5u3oNJm4LieXPZgqxU17hzS/9gQ=;
        b=J0v4FdaOqqMQp2Nj7XNFeCmDRFCX5bm5IItGlLvMZkwLDApwwxdLRlbTVAfwUomiOl
         V66BJHtFjTRP3bhAXStRi1X/bjU09J/C1msjkGRa3sRXS+4DU5Aw8Cl6Xw+JPX5vw+f1
         rt7NZibM7QfBf7Wc1U74R9sgqI3qTFBBuhZLmc/HRX4JC9kEYIU0U2s9Ou4rWsX7spaO
         gG/zX6ti2xifXoh6cX4lhw1UE71vcXVOjvVE7mDuytPx0jQQsB1mPocfVwSFOCbguzl0
         /91qq0skdkvDpsNEpMP1DW8I6mmo4mjeV1R5och9a5K9BjAB31WK31MKUe9DHnsa3PUQ
         OPzA==
X-Gm-Message-State: AAQBX9ei81RIdLwFFR+MtzCLYfBxuaIyGchyKtg2rEXCD9fjPPtBHo7i
        9VkLbk3IFhtE2dGmZv34X/I/cnz9AvGBpTl4/myiUQ==
X-Google-Smtp-Source: AKy350YFKRsLWRh4bwiLgUNwYtlrqIPpRVMDQA3iKKi6yhZ6JiwSwZjdcKLSrkM897T8RTwHSFdG7A==
X-Received: by 2002:a17:906:f8c2:b0:949:f4fb:9923 with SMTP id lh2-20020a170906f8c200b00949f4fb9923mr8408823ejb.34.1681140842133;
        Mon, 10 Apr 2023 08:34:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906529100b009447277c26fsm5174272ejm.72.2023.04.10.08.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:34:01 -0700 (PDT)
Message-ID: <a16a8071-3c67-0f40-d7da-3459f7dc584d@linaro.org>
Date:   Mon, 10 Apr 2023 17:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
References: <20230407050803.170773-1-andreas@kemnade.info>
 <20230407050803.170773-2-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407050803.170773-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 07:08, Andreas Kemnade wrote:
> Document ROHM BD2606MVV LED driver devicetree bindings.

Subject: maybe drop "driver" (suggests it is for Linux drivers, although
maybe it matches the actual hardware here?) and add missing verb, e.g.
"Add ROHM ..."

> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/leds/rohm,bd2606mvv.yaml         | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> new file mode 100644
> index 0000000000000..7f53d09e7b054
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BD2606MVV LED controller

ROHM BD....

> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description:
> +  The BD2606 MVV is a programmable LED controller connected via I2C that can
> +  drive 6 separate lines. Each of them can be individually switched on and off
> +  but the brightness setting is shared between two of them.
> +
> +  Datasheet is available at
> +  https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
> +
> +properties:
> +  compatible:
> +    const: rohm,bd2606mvv
> +
> +  reg:
> +    description: I2C slave address of the controller.

Drop description, it's obvious.

> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: GPIO pin to enable/disable the device.
> +
> +patternProperties:
> +  "^led@[0-6]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 6
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
Drop blank line

> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c0 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@66 {
> +            compatible = "rohm,bd2606mvv";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x66>;

reg is always second property in DTS.

> +
> +            led@0 {
> +                color = <LED_COLOR_ID_RED>;
> +                function = LED_FUNCTION_POWER;
> +                reg = <0x0>;

Ditto



Best regards,
Krzysztof

