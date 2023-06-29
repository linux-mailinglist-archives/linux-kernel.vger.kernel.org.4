Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD2742942
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF2PQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjF2PQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:16:39 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21D1BD3;
        Thu, 29 Jun 2023 08:16:38 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-78362f57500so33350339f.3;
        Thu, 29 Jun 2023 08:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051797; x=1690643797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yYf5unE82HQU5zdhq4SDOKtiWOXlUCb+r9zxuFce2k=;
        b=E6qGiwoD7wJKHthJVIlos/TCERX3quUusd1A9jOTsR0Zl0anjkeiXgW4jPwWz+ogdG
         0cdRajckR305M64/Ui8CAiSNDSi0DTBe+sajakpT6qS66cXD5qd7kDF12M3P6Q8+92aF
         YRoD5pAGUlMyOyi+ajNLCJBdrlUFMnbPUUdsTlr5ITfcCyE5Jzy/ljq41gEYDqkLnqRp
         XqVHziCikYs4EtvnuQ8ON1kDwsd3y4lPhhifz7ASZp0IzG9WC26xDZMAnmWOvIMQKwlc
         /pnhSl1OSddLbam0KyqNTxv3pgK6YnjX9X6VYn/CRZcax2NP9nrSBxo4sUWeZwM3cSS2
         GrSg==
X-Gm-Message-State: AC+VfDw49XVrVHXSy6FTOQMoPZed1hB7BGMQtBI38EiqWLxP0soWcv8S
        bJoOzH/7DFTS0lUe/HHMUA==
X-Google-Smtp-Source: ACHHUZ5U9UVQbTAUVWIC66Yomz/Nun21h36jybZhE6vvGCn8AppClylklh5mm22nnepr7qOXF5xS+Q==
X-Received: by 2002:a5e:a51a:0:b0:783:62af:fbdf with SMTP id 26-20020a5ea51a000000b0078362affbdfmr11243399iog.14.1688051797580;
        Thu, 29 Jun 2023 08:16:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a16-20020a056638005000b00418ba399842sm2824504jap.13.2023.06.29.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:16:36 -0700 (PDT)
Received: (nullmailer pid 3050930 invoked by uid 1000);
        Thu, 29 Jun 2023 15:16:35 -0000
Date:   Thu, 29 Jun 2023 09:16:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v4 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Message-ID: <20230629151635.GA3003066-robh@kernel.org>
References: <20230627065316.1065911-1-jiriv@axis.com>
 <20230627065316.1065911-2-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627065316.1065911-2-jiriv@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:53:15AM +0200, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings and signal guard feature.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml     | 77 +++++++++++++++++--
>  1 file changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 5fa625b5c5fb..b69dac1fba0e 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -45,13 +45,13 @@ properties:
>        Enables the Linux input system's autorepeat feature on the input device.
>  
>    linux,keycodes:
> -    minItems: 6
> -    maxItems: 6
> +    minItems: 3
> +    maxItems: 8
>      description: |
>        Specifies an array of numeric keycode values to
>        be used for the channels. If this property is
>        omitted, KEY_A, KEY_B, etc are used as defaults.
> -      The array must have exactly six entries.
> +      The number of entries must correspond to the number of channels.

This change seems unrelated? Or maybe advanced sensitivity means more 
channels? If so, explain this in the commit msg.

>  
>    microchip,sensor-gain:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -70,6 +70,55 @@ properties:
>        open drain. This property allows using the active
>        high push-pull output.
>  
> +  microchip,sensitivity-delta-sense:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +    description:
> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
> +      At the more sensitive settings, touches are detected for a smaller delta
> +      capacitance corresponding to a “lighter” touch.
> +
> +  microchip,signal-guard:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 1
> +    description: |
> +      Optional parameter supported only for CAP129x.
> +      0 - off
> +      1 - on
> +      The signal guard isolates the signal from virtual grounds.
> +      If enabled then the behavior of the channel is changed to signal guard.
> +      The number of entries must correspond to the number of channels.
> +
> +  microchip,input-treshold:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 127
> +    description:
> +      Optional parameter. Specifies the delta threshold that is used to
> +      determine if a touch has been detected.
> +      The number of entries must correspond to the number of channels.
> +
> +  microchip,calib-sensitivity:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    maxItems: 8
> +    items:
> +      minimum: 1
> +      maximum: 4
> +    description:
> +      Optional parameter supported only for CAP129x. Specifies an array of
> +      numeric values that controls the gain used by the calibration routine to
> +      enable sensor inputs to be more sensitive for proximity detection.
> +      The number of entries must correspond to the number of channels.
> +
>  patternProperties:
>    "^led@[0-7]$":
>      type: object
> @@ -98,10 +147,23 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - microchip,cap1106
> +              - microchip,cap1188
>      then:
>        patternProperties:
> -        "^led@[0-7]$": false
> +        "^led@[0-7]$": true
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,cap1293
> +              - microchip,cap1298
> +
> +    then:
> +      properties:
> +        microchip,signal-guard: true
> +        microchip,calib-sensitivity: true

This 'if' doesn't do anything. These properties are already allowed. You 
need an if for the cases they aren't allowed.

>  
>  required:
>    - compatible
> @@ -122,6 +184,11 @@ examples:
>          reg = <0x28>;
>          autorepeat;
>          microchip,sensor-gain = <2>;
> +        microchip,sensitivity-delta-sense = <16>;
> +
> +        microchip,signal-guard = <0>, <0>, <0>, <0>, <0>, <0>;
> +        microchip,input-treshold = <21>, <18>, <46>, <46>, <46>, <21>;
> +        microchip,calib-sensitivity = <1>, <2>, <2>, <1>, <1>, <2>;
>  
>          linux,keycodes = <103>,	/* KEY_UP */
>                           <106>,	/* KEY_RIGHT */
> -- 
> 2.25.1
> 
