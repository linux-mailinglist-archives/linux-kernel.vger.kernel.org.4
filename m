Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85FA600501
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJQCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJQB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:59:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF4E67
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:59:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b25so5863280qkk.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omRydYZA9aJNALXkr3g45BBv4ROOFDq6mM01S3sORaE=;
        b=j89ntIV0ou3/qPjBndxvbln2uPiu2Cv12m8jCYS80jg90E6W4AiaasHGcePIKfUsBt
         NQkzezZTMEHoG7DZcTIZybHjNLEbqzc5ggsvep0wEOAo/NOJdqcTqcD2XEJYESya9Tqq
         ziZcrFvqiJ9JnlSxHjlxMa8NbvdJb6VCi5tAXZRcE63mb3fVewZo6l7JuaxlpCeEcs4i
         j0+bqzRAejmj1D8OxGs0LVPPEhhtcNlvTD77QAtXqPmFkLolooKbqbbMZ/kN0N3AF93T
         0wllsHdZt1JSH/BTzWRrlJDeeSg18VwQB1xFEX00V4dymLLhv6+Aj8+lmP6wU5Xld53g
         jscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omRydYZA9aJNALXkr3g45BBv4ROOFDq6mM01S3sORaE=;
        b=69jNhmx9OJaeE7Hwg7jG0ECsZUIfAg2l98q9mH2srn76OUmNdrMF0mhQ5T5udmq+m5
         MpB9C2F4oXCeR54NKeVPmiszc88pS/ZgnkTtPa4ze0QV6s9Pt7U6uRpV6jn5LHhxTexO
         Qen2wFkIg2BES+6+YBj1QxjUWQ0Lo2esegpvH/kD/YhXiCwwdSuhS7eYo1bwXxGiUiVW
         IsxZyYsGMx7zbOuU27jh+WjmGOvGdDHHTaaYcQEWgbKBBDxlzhQbpUdo369/oESVpGoX
         QDZYxvzi5bDSg3V5I2R3i9y4OLlGrHgmrYCb2niPQrw0M8ysA9iAWQ0mUholDRSMoxsC
         RzQA==
X-Gm-Message-State: ACrzQf0Z3OhH7Niqj13LG/zzustC1z4fE2PUYtYkg+shN04qnOVSdubY
        TkaGWE2Das4Z0JYTZBL9u7QRzw==
X-Google-Smtp-Source: AMsMyM4mFIwVjf145GAdLdaPciG2d3l1afIwrB/FL2lo5wEUIoKHfmgbJNYxMh4R27pib6tWS94HNg==
X-Received: by 2002:ae9:f50a:0:b0:6e3:3b4f:2ab1 with SMTP id o10-20020ae9f50a000000b006e33b4f2ab1mr6114581qkg.314.1665971996577;
        Sun, 16 Oct 2022 18:59:56 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:bb7d:1aa4:bef8:ec27? ([2601:42:0:3450:bb7d:1aa4:bef8:ec27])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a280400b006ec59941acasm8313384qkp.11.2022.10.16.18.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 18:59:55 -0700 (PDT)
Message-ID: <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
Date:   Sun, 16 Oct 2022 21:59:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support more
 parts
Content-Language: en-US
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
 <20221014123724.1401011-3-demonsingur@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014123724.1401011-3-demonsingur@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 08:37, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Add support for the following parts:
>  * LTC2984
>  * LTC2986
>  * LTM2985
> 
> The LTC2984 is a variant of the LTC2983 with EEPROM.
> The LTC2986 is a variant of the LTC2983 with only 10 channels,
> EEPROM and support for active analog temperature sensors.
> The LTM2985 is software-compatible with the LTC2986.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 63 +++++++++++++++++--
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 722781aa4697..c33ab524fb64 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -4,19 +4,27 @@
>  $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices LTC2983 Multi-sensor Temperature system
> +title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
>  
>  maintainers:
>    - Nuno Sá <nuno.sa@analog.com>
>  
>  description: |
> -  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
> +  Temperature Measurement Systems
> +
>    https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
>  
>  properties:
>    compatible:
>      enum:
>        - adi,ltc2983
> +      - adi,ltc2984
> +      - adi,ltc2986
> +      - adi,ltm2985
>  
>    reg:
>      maxItems: 1
> @@ -26,7 +34,7 @@ properties:
>  
>    adi,mux-delay-config-us:
>      description:
> -      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
> +      The device performs 2 or 3 internal conversion cycles per temperature
>        result. Each conversion cycle is performed with different excitation and
>        input multiplexer configurations. Prior to each conversion, these
>        excitation circuits and input switch configurations are changed and an
> @@ -145,7 +153,7 @@ patternProperties:
>        adi,three-conversion-cycles:
>          description:
>            Boolean property which set's three conversion cycles removing
> -          parasitic resistance effects between the LTC2983 and the diode.
> +          parasitic resistance effects between the device and the diode.
>          type: boolean
>  
>        adi,average-on:
> @@ -353,6 +361,41 @@ patternProperties:
>          description: Boolean property which set's the adc as single-ended.
>          type: boolean
>  
> +  "^temp@":

There is already a property for thermocouple. Isn't a thermocouple a
temperature sensor? IOW, why new property is needed?

> +    type: object
> +    description:
> +      Represents a channel which is being used as an active analog temperature
> +      sensor.
> +
> +    properties:
> +      adi,sensor-type:
> +        description:
> +          Identifies the sensor as an active analog temperature sensor.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 31
> +
> +      adi,single-ended:
> +        description: Boolean property which sets the sensor as single-ended.

Drop "Boolean property which sets" - it's obvious from the type.



> +        type: boolean
> +
> +      adi,custom-temp:
> +        description:
> +          This is a table, where each entry should be a pair of

"This is a table" - obvious from the type.

> +          voltage(mv)-temperature(K). The entries must be given in nv and uK

mv-K or nv-uK? Confusing...

> +          so that, the original values must be multiplied by 1000000. For
> +          more details look at table 71 and 72.

There is no table 71 in the bindings... It seems you pasted it from
somewhere.

> +          Note should be signed, but dtc doesn't currently maintain the
> +          sign.

What do you mean? "Maintain" as allow or keep when building FDT?  What's
the problem of using negative numbers here and why it should be part of
bindings?

> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +        minItems: 3
> +        maxItems: 64
> +        items:
> +          minItems: 2
> +          maxItems: 2

Instead describe the items with "description" (and maybe constraints)
like here:

https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml#L278

> +
> +    required:
> +      - adi,custom-temp
> +
>    "^rsense@":
>      type: object
>      description:
> @@ -382,6 +425,18 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ltc2983
> +              - adi,ltc2984
> +    then:
> +      patternProperties:
> +        "^temp@": false
> +
>  additionalProperties: false
>  
>  examples:

Best regards,
Krzysztof

