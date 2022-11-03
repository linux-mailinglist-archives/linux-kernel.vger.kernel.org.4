Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB6617DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKCNNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiKCNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:13:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B1FE3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:13:21 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c8so1036485qvn.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAwv5pVuHPh2HWRN8QElP8yISKr8Z4y4F+eLXOpxHSw=;
        b=N7k7ZCf/Z56m45wIbweMUAbkl4/OdW3aPhkdTk3WKcemN0fhRFG8pQ9uo8xQfm5/mZ
         SEX0toaGhFjEoVyaDB8edQYAFOrBuAvrf3nPff0QUXCSE71JNPUCN6HRxsfuiLgNIsJB
         LhW61T0Eu6ZVVunvIB+l4s3HVzHhpvt6XNVBXr5wT1+UQUSMUTVSipYtakO2vva7HKe/
         5Tg/LKE1Bkjxg5qIpqjOWczatOsOTg+IIsghM9pPt6qnKaUSI+M/L/WYLB0ufisJ3C/G
         0K/JJmOKWC17dQbfM6AJ2kMAiS26VS73SDlsuZRGkQu4izl/3QO3x9v6tboYXwDqmMve
         +rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAwv5pVuHPh2HWRN8QElP8yISKr8Z4y4F+eLXOpxHSw=;
        b=Qub7n/cfYphwCG0S5nCuAQ7wuZg+xtj+Cmq4TT32xPJ6gJyBmCXq9Jdc/zXo2PvW55
         eOGXAixqbZmNVmVoIt/wVqpKxwuWl1/WqPXh3HmiyqyADEdhy4n0nI8zO2l4PTPN+yHg
         RqlPZ98TkWH9ix464b1yGJRiWGBG8YnWl50jXZ7UglvWfc7dhwixDeY4VONYg3Nrxjny
         MKwOScJIrOG0e5U9+mfBQqsTQZu8iM0uvED8Gg7eVgjMCLc1c39fAy/gtsVJT4HGBIhF
         djDUO0Eskb85xJPGialAWwdIvB6euYLTvXUkvarYWq+ImoDh1CrPDnTW54tGDFoYbM0l
         QKUA==
X-Gm-Message-State: ACrzQf2trISwHkQB5m8jqwIS1rheJ+mPl2C/52T2fb/9K5vS1mlIrLga
        D0tyTu1Yia8om1f8M5RvVp7bSA==
X-Google-Smtp-Source: AMsMyM4zBsi1eFnqnwyIs3CkXy7J5tFp34bs+8/IFq4ef7X6E3Wbe46k4jkzwfs9g9CmbIRSjJa94g==
X-Received: by 2002:ad4:5fc5:0:b0:4bb:6360:e80 with SMTP id jq5-20020ad45fc5000000b004bb63600e80mr26039109qvb.63.1667481200638;
        Thu, 03 Nov 2022 06:13:20 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id v20-20020a05622a189400b003a540320070sm535368qtc.6.2022.11.03.06.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:13:20 -0700 (PDT)
Message-ID: <0c23e569-61e1-3eba-f9fc-4b42ed228b52@linaro.org>
Date:   Thu, 3 Nov 2022 09:13:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
 <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
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

On 03/11/2022 04:05, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> new file mode 100644
> index 000000000000..fc9d6d3647b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/max5970.yaml#

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

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
> +
> +    patternProperties:
> +      "^led@[0-3]$":
> +        $ref: /schemas/leds/common.yaml#
> +        type: object
> +
> +    additionalProperties: true
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
> +
> +    patternProperties:
> +      "^(sw[0-1])$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +      shunt-resistor-micro-ohms:
> +        description: |
> +          The value of curent sense resistor in microohms.
> +          Must be specified for each channel.
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +  - vss1-supply
> +
> +

Just one blank line.

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
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        regulator@3a {
> +           compatible = "maxim,max5978";
> +           reg = <0x3a>;
> +           vss1-supply = <&p3v3>;
> +
> +           regulators {
> +               sw0_ref_0: SW0 {

No improvements here.

Best regards,
Krzysztof

