Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED775F2ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJCKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJCKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:35:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0513F26
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:34:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a12so1262885ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JvuDGMusQA+cnS7/q51g2t96p6j7dPQayCQD9t4XTZs=;
        b=D7upUYLEJQG0J/e3CxOcD6KbM1bfoT/xybtvcPrZm3D0imrNcb1AQKMpj44YuB9Cnm
         aC65EedpEGulW5cKWxjOJsIGP/l8CXd0Rej+LB5tPawt9HsORJIcbnAwZ0ITwU/BZtO+
         2wJfLJ24frIaJY5BkN4J1wU1M/X2cHI7cQv8UFJdLqCIJDxNrgw1HlijdsHqRZqAObzT
         /i95VKXJIFWGfjjBJHodPI2RYn5CS0mntDrAwgwOPqJIWGRTUauF0rE+2s5HOR2TtYbK
         twrmJ5KVINxvpXSaey3F8JyG1zSz3KP6VueCxGGauxJrb1vXvu7fBYlq2krtPA7qZB2z
         45Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JvuDGMusQA+cnS7/q51g2t96p6j7dPQayCQD9t4XTZs=;
        b=G3SC/P2e5NJuJzcbDo9F3MNk32OXzvkJQhz7mGjrV/bnUkunNj/HAMjnpKYKiGVjic
         2sX97GQcOqU3/0Xh1fs7aJ1tN2I8R3Ddrg2PUN1Crf9Pn+y20qWB+ZCkEDrruf6glCN9
         SQvR2s8TI8FFtRScZgnVPc1rvm7KIpKdjDb26qrcMCXQBf/xOtJjldLq00SscWI+mSoy
         w29vbQ7RpSTACXu5HfGDXmXm/1GRQepijY3BKa+czS/0luGe3jDaWU1b1XPpjqY8vu1F
         aJJo4J7OxQDS5IKcdp9ekKjrXTWd98tfQCJPpFvCBmN35wMvPXl2q+7Q1WU4gHaMuM+b
         SuEw==
X-Gm-Message-State: ACrzQf1VIzOgvw8dJBxgWYC+Wo107wVWWmrMDJ5r5eLLgq7SrNkDwAY/
        hJHCmUcjKYsWE4LRtq9t5Uoy2Q==
X-Google-Smtp-Source: AMsMyM4rI7dN/3MrRZ7mhBdoX2hY739UvijyYZ/SSgkKYV/ezA2hBwaaJcbKasqnbNbPgNXCG6xJlQ==
X-Received: by 2002:a2e:3809:0:b0:26b:e124:4d43 with SMTP id f9-20020a2e3809000000b0026be1244d43mr6273510lja.398.1664793297268;
        Mon, 03 Oct 2022 03:34:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b004994117b0fdsm1402411lfb.281.2022.10.03.03.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 03:34:56 -0700 (PDT)
Message-ID: <61455386-33ef-cb04-354e-32195ac6a7c3@linaro.org>
Date:   Mon, 3 Oct 2022 12:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221003092500.296-1-Ibrahim.Tilki@analog.com>
 <20221003092500.296-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003092500.296-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 11:24, Ibrahim Tilki wrote:
> Adding devicetree binding documentation for max11410 adc.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

(...)

> +  vref2n-supply:
> +    description: vref2n supply can be used as reference for conversion.
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +patternProperties:
> +  "^channel(@[0-9])?$":
> +    $ref: "adc.yaml"

No need for quotes.

> +    type: object
> +    description: Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 9
> +
> +      adi,reference:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          0: VREF0P/VREF0N
> +          1: VREF1P/VREF1N
> +          2: VREF2P/VREF2N
> +          3: AVDD/AGND
> +          4: VREF0P/AGND
> +          5: VREF1P/AGND
> +          6: VREF2P/AGND
> +          If this field is left empty, AVDD/AGND is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5, 6]
> +        default: 3
> +
> +      adi,input-mode:
> +        description: |
> +          Select signal path of input channels. Valid values are:
> +          0: Buffered, low-power, unity-gain path (default)
> +          1: Bypass path
> +          2: PGA path
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      diff-channels: true
> +
> +      bipolar: true
> +
> +      settling-time-us: true
> +
> +      adi,buffered-vrefp:
> +        description: Enable buffered mode for positive reference.
> +        type: boolean
> +
> +      adi,buffered-vrefn:
> +        description: Enable buffered mode for negative reference.
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
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            reg = <0>;
> +            compatible = "adi,max11410";
> +            spi-max-frequency = <8000000>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 2>;

What does the 2 stand for? I already asked to fix this.

Best regards,
Krzysztof

