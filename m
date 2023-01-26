Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0467CAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjAZMga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbjAZMg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:36:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36563855
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:36:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n7so1626909wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wo60df5cmJCZEeoz3PXILA4sT5vfxlhLvp0duE7lf1s=;
        b=EADzRIu7lym21hOMnZvS+sMMct8/ZA/xoKBHbgkl9ZCl8AXwaxtBx1nL7SVYZvAP1P
         V0WpbSKizSG3gb8Tx0bP4k2s5D8BnsWgMmVii7/xz6DiFI5xaD4i70VyNi/aR53L4KtP
         HeGhXiWVenGdkittg1Rag7fB7qDIh8pEfMLezkCMwrrz7+4ZOkhgE3kdDtoXNx6HsjzE
         rj6xPbcCX14erCpbVDDO6M2wn88dwOJycbU7CLj8JwYfu7TH/ok/lOKDXQoANpOtuGdG
         i57k4eBlnaBp1HfUOcTPh1PqcvpTvERBo1rfNByEE4wwynr6pMMpdoeDXpiESZB3gLb0
         SI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo60df5cmJCZEeoz3PXILA4sT5vfxlhLvp0duE7lf1s=;
        b=fGd0FbO0zqQotbQgkCxKNlXBlxcdgfIXEldqmERrL+CL0z7Fg2LsKHKIBWojS8Se3V
         RTA7duNDQ2yIz6/oMWgkTWiSLPnsBs6zC5vasj9KVrU6neSMI31d7iVS/mj4GTRRVYyy
         6Uor3Q1EDzLL4J/qf6GXtpSM1a41xqv6zcBklvCZfP5BCLJpiLeW/zYZ8m6eGwIRHPSb
         y+G7awCP0UZqesDaS1k1XaFNvt8rzyHQ/46SNrgrrUlYlmH1gosEeWW+iGLT5U1rUgoM
         02SbK7TjpB4xcD2NHP7Y1pVrPMj/vrI0SY7pqFUVQEOS6fza9UJZfioNdcT7++pKHbuk
         sCfg==
X-Gm-Message-State: AFqh2kql3EpYa12Vt3+CAR5OnkJ2tcj0hpw79Iu0qjgH29aEfaYYmOk8
        rbz1kgCMk8aNtZrfbf0iFHp55A==
X-Google-Smtp-Source: AMrXdXuNVegLRJr6/oQKdCFpXOMON9Yqa+ZGh5kux8Fj0IGtNLS5318NED0H8g007dO7cTnthbbffw==
X-Received: by 2002:adf:8b45:0:b0:2bd:e8c9:bcd5 with SMTP id v5-20020adf8b45000000b002bde8c9bcd5mr29446034wra.61.1674736583113;
        Thu, 26 Jan 2023 04:36:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d44c4000000b002bfcc9d9607sm112694wrr.68.2023.01.26.04.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:36:22 -0800 (PST)
Message-ID: <c519afe0-0a6f-e262-7a85-a3072a828e62@linaro.org>
Date:   Thu, 26 Jan 2023 13:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v8 4/5] dt-bindings: input: pwm-beeper: add volume
Content-Language: en-US
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <20230126091825.220646-1-manuel.traut@mt.com>
 <20230126091825.220646-5-manuel.traut@mt.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126091825.220646-5-manuel.traut@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 10:18, Manuel Traut wrote:
> Adds an array of supported volume levels and a default volume level.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>

This is the second patch. Bindings must be introduced before you start
using them.

> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> index 351df83d5cbe..f1f9283ca855 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -26,6 +26,24 @@ properties:
>    beeper-hz:
>      description: bell frequency in Hz
>  
> +  volume-levels:

use -bp suffix:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml#L44

which will mean the unit is 1/100 of %, not 1/10. Then you can also drop
the $ref.


> +    description: >
> +      Array of PWM duty cycle values that correspond to
> +      linear volume levels. These need to be in the range of
> +      0 to 500, while 0 means 0% duty cycle (mute) and 500
> +      means 50% duty cycle (max volume).
> +      Please note that the actual volume of most beepers is
> +      highly non-linear, which means that low volume levels
> +      are probably somewhere in the range of 1 to 30 (0.1-3%
> +      duty cycle).
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  default-volume-level:

I propose to use just the value, not the index, so the name should
finish with '-bp' and the $ref can be dropped.

> +    description: >
> +      The default volume level (index into the array defined
> +      by the "volume-levels" property).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  required:
>    - compatible
>    - pwms
> @@ -45,4 +63,6 @@ examples:
>        compatible = "pwm-beeper";
>        pwms = <&pwm0>;
>        amp-supply = <&beeper_amp>;
> +      volume-levels = <0 8 20 40 500>;
> +      default-volume-level = <4>;
>      };

Best regards,
Krzysztof

