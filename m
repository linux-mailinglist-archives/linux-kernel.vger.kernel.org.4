Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84F5ED793
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiI1IVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiI1IV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:21:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8D6DAD9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:21:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so19215454lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DtaeztIrrIzwT8HQvbhHdjPsoL/H4rgicGhMwxKC4II=;
        b=OxiiOTx9Pj3tiohl/bJruvaujHKf9ySjOM8OGkIdzuVJVuZMAGvhWIxAyP7vJZngPp
         OjEEMQbfdemj/bx2w8rAIUs9pauUoMZLvrKAhiEj6/twbrBIeqCerlN20Sc/Bb5p4qvV
         n7nGI/RWpIqlWKi8bHDp0cuLM5yucXIdN2JsOIQ2/CbLyNBzoLXwOMWc0wP0sNqcEiio
         KjwlM2bb7A8msH76qoQyTig+gjd1JguNzdwhirBBdZ5i6vPrtV5bGMogGJrH/5k2JuNy
         fMUt8Co4EjqCt5ZlTbeaT0N6eh+FzZiJznytT/j5Fcb27osx3Q26DaGS0ltLKncjpg/f
         4+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DtaeztIrrIzwT8HQvbhHdjPsoL/H4rgicGhMwxKC4II=;
        b=fsuaX2D+OSy8jwBoaeDwk+91VTenTelPQllslG+EwZRuib3DL+S6w6OfjB9QtwetuU
         Yp4WxNnlPsIguZCiEDlazDB0F6rqAWwZLpmHvz/llAStj9w0foGVA0Us8UG06h8Qhgl4
         QhHJ7og2rFY4Wo6EpnKOk2dQMjPYSjCGokfBX999X0sT0BUtplbAmNrNSPyH/bMqqWM1
         i/AWEP0NZNDg5NqdfTJCwA9C7hYcPSvo7zqXydpBVK3P6EzuAVAVeoYXM3PCcCpoQceB
         UnGB5EUyA4WBcVMv0lhNkz8f26D6jBVaIs71jn271K1+trZBgnC5rRv0WdOZe6uBkltf
         WXCA==
X-Gm-Message-State: ACrzQf2WPIj8PsGi+zSLA8kKShwPe0BRrOo6YcHkK1lPKIM5leyqQT1M
        2woBSWKVb/DRiHNBT/aWzKwQmCYBfHT6bQ==
X-Google-Smtp-Source: AMsMyM4Vww4M+L2QadcO2FI7avwu0F5XJAHW8f40JBLJky9T1PEbO0NYMRUU2pOvpAQF/d9npZfpcA==
X-Received: by 2002:a05:6512:280d:b0:498:fd40:51d4 with SMTP id cf13-20020a056512280d00b00498fd4051d4mr14146684lfb.167.1664353281518;
        Wed, 28 Sep 2022 01:21:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 5-20020a2eb945000000b0026c81c76294sm370168ljs.74.2022.09.28.01.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:21:21 -0700 (PDT)
Message-ID: <6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org>
Date:   Wed, 28 Sep 2022 10:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
 <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 04:42, Fenglin Wu wrote:
> Add binding document for flash LED module inside Qualcomm Technologies,
> Inc. PMICs.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>

You did not Cc me on first patch, so difficult to say how much it
matches the driver... There is also no DTS.

> ---
>  .../bindings/leds/leds-qcom-flash.yaml        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml
> new file mode 100644
> index 000000000000..52a99182961b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-flash.yaml


Filename matching compatible if there is one fallback (e.g.
qcom,spmi-flash-led.yaml).

> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-qcom-flash.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
> +
> +maintainers:
> +  - Fenglin Wu <quic_fenglinw@quicinc.com>
> +
> +description: |
> +  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
> +  The flash LED module can have different number of LED channels supported
> +  e.g. 3 or 4. There are some different registers between them but they can
> +  both support maximum current up to 1.5 A per channel and they can also support
> +  ganging 2 channels together to supply maximum current up to 2 A. The current
> +  will be split symmetrically on each channel and they will be enabled and
> +  disabled at the same time.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,spmi-flash-led
> +          - qcom,pm8150c-flash-led
> +          - qcom,pm8150l-flash-led
> +          - qcom,pm8350c-flash-led

I doubt these are all different. You should use fallback, which also
will make use of the "items" you used...

> +
> +  reg:
> +    description: address offset of the flash LED controller
> +    maxItems: 1
> +
> +patternProperties:
> +  "^led@[0-3]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Represents the physical LED components which are connected to the flash LED channels' output.

Does not look like wrapped at 80.

Other places as well.

> +
> +    properties:

Does not look like you tested the bindings...

You miss here reg.

> +      led-sources:
> +        description: The HW indices of the flash LED channels that connect to the physical LED
> +        allOf:
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2, 3, 4]
> +
> +      led-max-microamp:
> +        description: |
> +          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
> +          Valid values when an LED is connected to one flash LED channel:
> +            5000 - 500000, step by 5000> +          Valid values when an LED is connected to two flash LED
channels:
> +            10000 - 1000000, step by 10000

You need minimum and maximum.

> +
> +      flash-max-microamp:
> +        description: |
> +          The maximum current value when LED is operating in flash mode.
> +          Valid values when an LED is connected to one flash LED channel:
> +            12500 - 1500000, step by 12500
> +          Valid values when an LED is connected to two flash LED channels:
> +            25000 - 2000000, step by 12500

You need minimum and maximum.


> +
> +      flash-max-timeout-us:
> +        description: |
> +          The maximum timeout value when LED is operating in flash mode.
> +          Valid values: 10000 - 1280000, step by 10000

You need minimum and maximum.

> +
> +    required:
> +      - led-sources
> +      - led-max-microamp

reg.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    flash-led@ee00 {

Node name: led-controller

> +            compatible = "qcom,spmi-flash-led";
> +            reg = <0xee00>;
> +
> +            led@0 {

Test your bindings...

> +                    function = LED_FUNCTION_FLASH;

Use 4 spaces for indentation of example.

> +                    color = <LED_COLOR_ID_WHITE>;
> +                    led-sources = <1>, <4>;
> +                    led-max-microamp = <300000>;
> +                    flash-max-microamp = <2000000>;
> +                    flash-max-timeout-us = <1280000>;
> +                    function-enumerator = <0>;
> +            };
> +

Best regards,
Krzysztof

