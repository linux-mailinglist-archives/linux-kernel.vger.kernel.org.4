Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0B717B15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjEaJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjEaJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:03:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4AE59
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:02:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f850b32caso1022158866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523747; x=1688115747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLGOgCTdN9b0I3RzLK+qTsPeSIXwIOR+lUiYzHLyqkA=;
        b=hl/FuLnQZIjxtgYC0n4FAzTYUV3krumKQ/xsy+UH7E/f3dgqeMgPN/5AWK3SEAbCIr
         FI5o6PsmvyimDsqt5v5W0X8JCTWp4IIqZ8x4bJAK1WuGUur4LrMbrSLlB4RyvOnzIWpj
         UnB3gYbhh4tVYaSM44gFg9i9Vmw/5b+wvnLAVnsq+U/bFznueJbE05QomY6GoS+Thfyi
         92yxam3PqKLAhtN2FkiFthHuejjWHvOd2bLzYlJhwaQRKPfYLKleciRdi3ZkGUkRYYwx
         li9VHUt3YJlo2ixD5iK57yOeNvKQ5dkacN1nQ4J0gD5U8MxsmtBUBfgxsazERnuF8oTC
         IkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523747; x=1688115747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLGOgCTdN9b0I3RzLK+qTsPeSIXwIOR+lUiYzHLyqkA=;
        b=HnA/hlOjMMqvwrZ0p3QJmXYR1ORm5GquHyeK6BlJg+DE+bx/qk6qdTzYsKfFGIDnwv
         +G15cXBZwxlBiGP3EMM36r4+4U3IRw2MeNmQxlvW7Bv+MlLOTC8LTLDxtd78iN8tb7QA
         xt6LK5G4C7NJxp1iNhebiEVtRTmklHryvmVFShpmlijSXIOe+Bzmha6S2bqvJtsDYfw3
         rC5HNyMGxcNoMTh3g21vCo2W6Xus6VhhVu1OB+IkyHMOGPMliTJnfhwNeVo4CSm42Oy7
         36IdQ++mhRL1lWMtfiZ2vn/PYIeBpKYMKDTUyuWJK4MDBo5jWXX5aASJn0V+R1ySjWMP
         O/sA==
X-Gm-Message-State: AC+VfDwyy4a2YFY2nQT8mNMNlinLlvi2s1O8N2IZHA7eMmQJ8kWkGj+g
        Xw2B6Sk9hc7yOpgwou4BK/yaFA==
X-Google-Smtp-Source: ACHHUZ6y49DNKKcWtbOKQ31f6lJ93szs/HfhYKInuhEAs8m2uleiHDoOT2aH1n4H9RrcakuD5WjtOg==
X-Received: by 2002:a17:907:7da5:b0:966:4d75:4a44 with SMTP id oz37-20020a1709077da500b009664d754a44mr4305321ejc.24.1685523747328;
        Wed, 31 May 2023 02:02:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709065e4d00b00965e9b435dfsm8560598eju.65.2023.05.31.02.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:02:26 -0700 (PDT)
Message-ID: <eef819db-4de3-06fe-8fe6-b0fe87ab5d84@linaro.org>
Date:   Wed, 31 May 2023 11:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/6] dt-bindings: sound: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-3-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530122112.1314458-3-ckeepax@opensource.cirrus.com>
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

On 30/05/2023 14:21, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a YAML DT binding document for this device.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thank you for your patch. There is something to discuss/improve.


> +  clocks:
> +    items:
> +      - description: Synchronous audio clock provided on mclk_in.
> +
> +  clock-names:
> +    const: mclk
> +
> +  cirrus,bias-low:
> +    type: boolean
> +    description:
> +      Select a 1.8V headset micbias rather than 2.8V.
> +
> +  cirrus,bias-sense-ua:

"ua" looks like microamp. If so, microamp instead:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Current at which the headset micbias sense clamp will engage, 0 to
> +      disable.
> +    enum: [ 0, 14, 23, 41, 50, 60, 68, 86, 95 ]
> +    default: 0
> +
> +  cirrus,bias-ramp-ms:
> +    description:
> +      Time in milliseconds the hardware allows for the headset micbias to
> +      ramp up.
> +    enum: [ 10, 40, 90, 170 ]
> +    default: 170
> +
> +  cirrus,detect-us:
> +    description:
> +      Time in microseconds the type detection will run for. Long values will
> +      cause more audible effects, but give more accurate detection.
> +    enum: [ 20, 100, 1000, 10000, 50000, 75000, 100000, 200000 ]
> +    default: 10000
> +
> +  cirrus,button-automute:
> +    type: boolean
> +    description:
> +      Enable the hardware automuting of decimator 1 when a headset button is
> +      pressed.
> +
> +  cirrus,buttons-ohms:
> +    description:
> +      Impedance in Ohms for each headset button, these should be listed in
> +      ascending order.
> +    minItems: 1
> +    maxItems: 6
> +
> +  cirrus,tip-debounce-ms:
> +    description:
> +      Software debounce on tip sense triggering in milliseconds.
> +    default: 0
> +
> +  cirrus,tip-invert:
> +    type: boolean
> +    description:
> +      Indicates tip detect polarity, inverted implies open-circuit whilst the
> +      jack is inserted.
> +
> +  cirrus,tip-disable-pullup:
> +    type: boolean
> +    description:
> +      Indicates if the internal pullup on the tip detect should be disabled.
> +
> +  cirrus,tip-fall-db-ms:
> +    description:
> +      Time in milliseconds a falling edge on the tip detect should be hardware
> +      debounced for. Note the falling edge is considered after the invert.
> +    enum: [ 0, 125, 250, 500, 750, 1000, 1250, 1500 ]
> +    default: 500
> +
> +  cirrus,tip-rise-db-ms:
> +    description:
> +      Time in milliseconds a rising edge on the tip detect should be hardware
> +      debounced for. Note the rising edge is considered after the invert.
> +    enum: [ 0, 125, 250, 500, 750, 1000, 1250, 1500 ]
> +    default: 500
> +
> +  cirrus,use-ring-sense:
> +    type: boolean
> +    description:
> +      Indicates if the ring sense should be used.
> +
> +  cirrus,ring-invert:
> +    type: boolean
> +    description:
> +      Indicates ring detect polarity, inverted implies open-circuit whilst the
> +      jack is inserted.
> +
> +  cirrus,ring-disable-pullup:
> +    type: boolean
> +    description:
> +      Indicates if the internal pullup on the ring detect should be disabled.
> +
> +  cirrus,ring-fall-db-ms:
> +    description:
> +      Time in milliseconds a falling edge on the ring detect should be hardware
> +      debounced for. Note the falling edge is considered after the invert.
> +    enum: [ 0, 125, 250, 500, 750, 1000, 1250, 1500 ]
> +    default: 500
> +
> +  cirrus,ring-rise-db-ms:
> +    description:
> +      Time in milliseconds a rising edge on the ring detect should be hardware
> +      debounced for. Note the rising edge is considered after the invert.
> +    enum: [ 0, 125, 250, 500, 750, 1000, 1250, 1500 ]
> +    default: 500
> +
> +  pinctrl:
> +    type: object
> +
> +    allOf:

Drop allOf, just "$ref: ......"

> +      - $ref: /schemas/pinctrl/pinctrl.yaml#
> +
> +    additionalProperties: false

Also drop blank lines between these three above.

> +
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      gpio-ranges:
> +        items:
> +          - description: A phandle to the CODEC pinctrl node
> +            minimum: 0
> +          - const: 0
> +          - const: 0
> +          - const: 3
> +
> +    patternProperties:
> +      "-state$":

Use consistent quotes, either " or ' everywhere

> +        oneOf:
> +          - $ref: "#/$defs/cirrus-cs42l43-state"
> +          - patternProperties:
> +              "-pins$":
> +                $ref: "#/$defs/cirrus-cs42l43-state"
> +            additionalProperties: false
> +
> +  spi:
> +    type: object
> +
> +    allOf:
> +      - $ref: /schemas/spi/spi-controller.yaml#
> +
> +    unevaluatedProperties: false

Same comments here.

> +
> +$defs:
> +  cirrus-cs42l43-state:
> +    type: object
> +



Best regards,
Krzysztof

