Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E47204F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjFBOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjFBOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:54:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF155E4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:54:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso3099281a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685717642; x=1688309642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xMbXrKiLyyuLN8qCy2zxwaeNTTxFej7ZJUbtFNTsHs=;
        b=enocWQlxi9aM7lEuM5cN4/5zbO4CCWDNMrAfeR8/SPxRriqSpXdhvvVYM6ffSl0PQU
         wWUwXgr5KgwtRHsyQGkk3kfOQmO8CWT6IV/iSLruyn0af5kGbOOPtMfHqugtqzFMS+Ef
         jQ0/65+BahEfMOw1leNNB495ugWsxV+HM90T32C+CMDxcRoEDmOytz47MsNKiuEeaxWg
         jxdGwx2pHXUc+c88xcbw7rqnRErEn6Li2e41mTRV4YrSHNdOk3GguAsbFZ/cgpAh0FMx
         2qNhiMOIeALU/Cu+9zcPrKIYF89IwORU0Csiwt0SMikp2F+Xn5Mm0jlaUeRnhMa96j5s
         agBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717642; x=1688309642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xMbXrKiLyyuLN8qCy2zxwaeNTTxFej7ZJUbtFNTsHs=;
        b=j2JyjrBO6h9L6Vl6NXIEPDYmkcE1FP67nF93WqVtCcc1inJEc7XRY8VGdgI6Hw9UpD
         W+0G3xvLmM5BGBDiYOffABcqjlwiULhpSExO8vOBW380TD4c7OB8A43zdtqnSoPJt4uW
         rvcDjzb2m566tMXlbKVEqNtqS/gKlH4vnPJmQMJCCJGiy+xTf2Jk0yqS5IwsUKtLeU97
         amZv2EEnd1sNjrc3B2pchFYwi2KYbgos+gGc8bL22dPRD+tg3ZMiE5xHhtk+gvj538BI
         +jgMdSrbHekjycHzT3x46u9hbLNHRUZYU++hV/do8f3zaRwdw+8+DFCADUz6lA0OoEwP
         osQQ==
X-Gm-Message-State: AC+VfDxvxww+z5P8bfYaUSKMeP9FnDQfOIa1gxPF/LvVHiWNiy1wu6xS
        o1+9O1tQxjKbNbeU4r52peVbuA==
X-Google-Smtp-Source: ACHHUZ6elBIFjqsTmLfob/zz/7BgFRCLZ7+L3B38jyfwZr1xbGmbrmk+HoW5Dntk5AIUM0bteKC70g==
X-Received: by 2002:a05:6402:718:b0:4be:b39b:ea8f with SMTP id w24-20020a056402071800b004beb39bea8fmr2097721edx.2.1685717642397;
        Fri, 02 Jun 2023 07:54:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id n8-20020a05640204c800b005106975c7a1sm777664edw.23.2023.06.02.07.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 07:54:01 -0700 (PDT)
Message-ID: <c0e49551-4c69-3f17-aa6d-9e983bf80849@linaro.org>
Date:   Fri, 2 Jun 2023 16:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230524123528.439082-4-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 14:35, Claudiu Beznea wrote:
> Convert Atmel SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC DT node
> (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with its
> compatible. There is no usage of this syscon in the current code but it
> may be necessary in future as some registers of SHDWC are accessed in
> different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
> Thus update the YAML with it to make DT checkers happy.
> 



> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SAMA5D2 SHDWC Shutdown Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel SHDWC shutdown controller controls the power supplies VDDIO and VDDCORE
> +  and the wake-up detection on debounced input lines.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,sama7g5-shdwc
> +          - const: syscon
> +      - items:

These are not items, but just enum. This could not work as intended.

> +          enum:
> +            - atmel,sama5d2-shdwc
> +            - microchip,sam9x60-shdwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  debounce-delay-us:
> +    description:
> +      Minimum wake-up inputs debouncer period in microseconds. It is usually a
> +      board-related property.
> +
> +  atmel,wakeup-rtc-timer:
> +    description: enable real-time clock wake-up
> +    type: boolean
> +
> +patternProperties:
> +  "^input@[0-15]$":
> +    description:
> +      Wake-up input nodes. These are usually described in the "board" part of
> +      the Device Tree. Note also that input 0 is linked to the wake-up pin and
> +      is frequently used.
> +    type: object
> +    properties:
> +      reg:
> +        description: contains the wake-up input index
> +        minimum: 0
> +        maximum: 15
> +
> +      atmel,wakeup-active-high:
> +        description:
> +          The corresponding wake-up input described by the child forces the
> +          wake-up of the core power supply on a high level. The default is to
> +          be active low.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,sam9x60-shdwc
> +              - microchip,sama7g5-shdwc
> +    then:
> +      properties:
> +        atmel,wakeup-rtt-timer:
> +          description: enable real-time timer wake-up
> +          type: boolean

Don't define properties in allOf. This should be in top-level.


Missing additionalProperties: false.

Best regards,
Krzysztof

