Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E436619F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKDRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiKDRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:50:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25AA45EC5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:50:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e15so3690874qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UzKnlUxnrpJ9zu52HZyYlQwOpPI3vn+8hh0aFP52SA=;
        b=nlIBGooiHUABn0hJuXoH8n/vAlgiEQMETdbLmrcP5+mUCntw806PBYE8bAJ042EB3B
         Xm+HyXIfLatbnMONPhv/EWg8lx+mkQ1FwI8upMMsDBJSkBvyFYMeurDXxOn6ZMxxRz34
         N/TlXzNYrDEH5/3h618Sm9fzGRwWpyWkzD0AJI4lbG+p16YZlqSeDAlrDSF5RSyAKreL
         Dut89I7e5a0y60bz0ASgsJtahk9W5nutW/AFTMst44mrVnE8kD01gCvQsW0D7DCsFpG4
         GrMpZ195m3nJaK573PMN6fry3T69e0v0rp/MWgCzufCddbWTO4JSssQwFbDn3FDdRVbv
         qJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UzKnlUxnrpJ9zu52HZyYlQwOpPI3vn+8hh0aFP52SA=;
        b=az2/XbaekzSwD6kQUDoCot6lMH3mQhLhiqLkphWFV8cdzPd8f0erfeP4uZkXAjAaSn
         3AxS8+fS34BlK2MeuP5Nbw8SKJKaxIQLLIipxN1iXdbSLFJdruU4i8AzGJAakkF+ifOn
         AnyN1IMC26WwniqNG4wKKJQHOZim6dU6ITe5Dc0FNA3PysZ2QaBbWmzieXtpSHIBYkZ4
         dnBJLNQMh9FmruUXWTFyHR1o56evRwm0rC8J1InPxjM+zZpEZr6vXqWj+d3tmavouhRD
         JfbSkH4fU7k+S9dQlF/aqaJWUxDYW5VVF0Jhy8v6BwpedjpnK6XzJst8vMiOltwaBqdo
         p0XQ==
X-Gm-Message-State: ACrzQf3GukhFNWnJ3aaltx04ZdWhyoS+TvC/j8KMVFxGxAUiCsbB/11m
        eAn46jg91k7ioQpus7gnfLyefw==
X-Google-Smtp-Source: AMsMyM7RXjIEhSLeOBYzaW08L/T92KzKvMCjXKCfR5p4yahLt+xB1SbQv/pVuun/OfqEFIrWBLmq+A==
X-Received: by 2002:ad4:5941:0:b0:4b4:46b5:e36b with SMTP id eo1-20020ad45941000000b004b446b5e36bmr32685943qvb.33.1667584245644;
        Fri, 04 Nov 2022 10:50:45 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id c14-20020a05620a164e00b006cbc00db595sm3246411qko.23.2022.11.04.10.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:50:44 -0700 (PDT)
Message-ID: <f3624107-249d-e7e6-8c02-379cd4081899@linaro.org>
Date:   Fri, 4 Nov 2022 13:50:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104172343.617690-1-ciprian.regus@analog.com>
 <20221104172343.617690-2-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172343.617690-2-ciprian.regus@analog.com>
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

On 04/11/2022 13:23, Ciprian Regus wrote:
> Add devicetree bindings documentation for the AD5754 DAC driver.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Thank you for your patch. There is something to discuss/improve.
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-3])$":
> +    type: object
> +    description: Configurations for the DAC channels

    additionalProperties: false

(on this level of indentation)

> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        maxItems: 1
> +
> +      adi,output-range-microvolt:
> +        description: |
> +          Voltage range of a channel as <minimum, maximum>.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000, 10800000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -10800000
> +              - const: 10800000
> +
> +    required:
> +      - reg
> +      - adi,output-range-microvolt
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad5722
> +              - adi,ad5732
> +              - adi,ad5752
> +              - adi,ad5722r
> +              - adi,ad5732r
> +              - adi,ad5752r
> +    then:
> +      patternProperties:
> +        "^channel@([0-3])$":
> +          type: object
> +          properties:
> +            reg:
> +              description: Channel number
> +              enum: [0, 1]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad5724
> +              - adi,ad5734
> +              - adi,ad5754
> +              - adi,ad5724r
> +              - adi,ad5734r
> +              - adi,ad5754r
> +    then:
> +      patternProperties:
> +        "^channel@([0-3])$":
> +          type: object
> +          properties:
> +            reg:
> +              description: Channel number
> +              enum: [0, 1, 2, 3]
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        status = "okay";

Drop status



Best regards,
Krzysztof

