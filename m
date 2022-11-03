Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF4618ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKCVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:49:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A8E9A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:49:54 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n18so2055411qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8QtDCFHOraW9Y7IqsYd/UFa1rfIHZvfyAsyDi6Qwdg=;
        b=M2nVq5bVyFHCMBy3LqUUyoyGzcUx7+jYexrzLeiPhqXVvYrMuZx4hVoRzLWELLpmuu
         Cp6nK1CPv7uqIXsO3pva00le+/d1DYlERAhQDs+3+wSNquMOqYcZu0dgYUeH4ey9Rd7H
         WPs68ycKBrReM+k5Qw1mABUd8f3ciWdLxWOWwN6cJnFDXuV8jamOkHH97hSdjDufpjM8
         s9QhA0PbsNl2IW0LloQBtH0COrZSWvHhxIbs9FykBwLUboIkdUflEJHx/VF6N/4oocl2
         7XPe2KUftsDqCmjgzixrig+UPXZUkLQNo4GdNiaIsIssTduyvH7kHC1uiay1V+Gs+6Cp
         6rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8QtDCFHOraW9Y7IqsYd/UFa1rfIHZvfyAsyDi6Qwdg=;
        b=VGttH6wQI0V2rMUQyt4WyS0aCjSe/zdLPue1FqpTAoulSR3OcEzbNbt8ggkZfJdakq
         IPDWgvTDbxXjhg/O4H6gYLT/i2ZdbS09BQOGtOIOKVpbYlZXQ5BEoUT4HKoMKGr6bbTK
         MOfANpNQcWPySQhW5fcjzE+1d39PjOK1uwkTOhYNpWuAoQ0yz16xN+ajgz1uq2cdUnTK
         othGhvxtVBiMpkCKQGQwNmq0SkfqiqqhnxU90l53Keqw+w/cPNYYpoGPYWvtJTb3iqLe
         MnTz5TqARav72mhvX7iZoDH79yHtF8D9CTuBR3pjR8x49DIZNKAxtQkD7ZpuZGpH10mW
         GqTg==
X-Gm-Message-State: ACrzQf2xA6VAGFWHWie0oAPAtvzyou9hPBKN3mt7Q6RZeTBOos+OgDiZ
        trf7h8QxJIZWAe6Uok3YlHFGiANm05cjlA==
X-Google-Smtp-Source: AMsMyM4iQLYIldOnaf9wcMSRiHwQW1630DS9sQWvEOmcUONZV0/oQhuiJD+3J5g7vYXcQOIWH+AEWA==
X-Received: by 2002:a0c:e3d3:0:b0:4bb:c033:76fc with SMTP id e19-20020a0ce3d3000000b004bbc03376fcmr27528310qvl.117.1667512193313;
        Thu, 03 Nov 2022 14:49:53 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a139000b006aedb35d8a1sm1502448qki.74.2022.11.03.14.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:49:52 -0700 (PDT)
Message-ID: <9396ee97-d6f3-f13b-8929-56c3920ee395@linaro.org>
Date:   Thu, 3 Nov 2022 17:49:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v8 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
 <20221103213425.2474772-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103213425.2474772-2-Naresh.Solanki@9elements.com>
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

On 03/11/2022 17:34, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 

Subject: drop redundant (second) word "bindings"

> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Isn't this third version per day? That's too many. Please keep it one
per day (usually).


> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..25079c518f68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
> +
> +maintainers:
> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> +
> +description: |
> +  The smart switch provides no output regulation, but independent fault protection
> +  and voltage and current sensing.
> +  Programming is done through I2C bus.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max5970
> +      - maxim,max5978
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  leds:
> +    type: object
> +    description:
> +      Properties for single channel.

This description seems odd. You have here several leds, so what is the
single channel?

> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +
> +    additionalProperties: false
> +
> +  vss1-supply:
> +    description: Supply of the first channel.
> +
> +  vss2-supply:
> +    description: Supply of the first channel.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      Properties for single channel.

That's another odd description.

> +
> +    patternProperties:
> +      "^(SW[0-1])$":

This should be lowercase. You also do not need ().

> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +      shunt-resistor-micro-ohms:
> +        description: |
> +          The value of curent sense resistor in microohms.
> +          Must be specified for each channel.

Drop last sentence and instead add "required:" with proper indent.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +  - vss1-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - maxim,max5970
> +    then:
> +      properties:
> +        io-channels:
> +          items:
> +            - description: voltage first channel
> +            - description: current first channel
> +            - description: voltage second channel
> +            - description: current second channel
> +          description: |
> +            Voltage and current for first and second channel.

I do not understand the description.

Also, add it in the existing example.

> +      required:
> +        - vss2-supply
> +    else:
> +      properties:
> +        io-channels:
> +          items:
> +            - description: voltage first channel
> +            - description: current first channel
> +          description: |
> +            Voltage and current for first channel.

Same question for the description.

> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

