Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD96E2FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDOJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDOJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:11:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8925AD24
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:11:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud9so51335013ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681549860; x=1684141860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkqhhdKnhncpcXSMYex0XLHXcS1AhaZjY9ZDkZfJ5BM=;
        b=HDJgWSCZ6DECQVi7mecei8mGzS8DjvsskIRgELeqzfetwiRlukLBHsmYLdS8kI6CCG
         u+5HhGSAQCth1eFw20xgp/ExLFqMjeg8zDvWAMKKxVpFE95hnHZ+SuYXTcQo7/IZTPYZ
         yNpxnnA1y2iyqUj/Y4Msu8c2HwkrkLryv7S5/TwFBH+5pak7lVVF6N0GECEhOFLFc7RH
         oU0ZRA6ewAw3sKBUeRU4MOdlA7cKz46ngoaffBpv/B7usmSYR+ENBQBuP6LgW8EJWfYZ
         Ryh5sXmfNlTAo2yr0IQ5QTGvklujOvgB2njk+6tDdiHhTFecX9HRtYM7d8B18QZYrvrx
         VcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549860; x=1684141860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkqhhdKnhncpcXSMYex0XLHXcS1AhaZjY9ZDkZfJ5BM=;
        b=GfhHttm5O+wI2HgVcDTKVH3zhNBCWsVaJzx2o6SmPzVNoU9psSL9NHzXdwwdbQz73h
         hhOYqTCE+I7PhAANDQ8IMoCeKVr0YuJXU1unXM5k5dI16nuSDC5IBx8PrEUi1G82rNyi
         LTc54eIZBGz9X8D5lBN3/iSzFgqOVmaXgSrWR7LN9CFlJ3DD9l4Sx1OyN/M7GqxDZ/U7
         LEECr3MYSPg7jfHL4n+sWsnrFaem7YMK2fl3E13w/n+H8K58BBG6YeXDyrsRZi5sDlJr
         uZcyghAlye4ua3httYzsy2lZSDgR82HUCc7AgdN3w5nrRVYwOiZ9KOIkCfRIdWDmD8sB
         0cLw==
X-Gm-Message-State: AAQBX9cPTS5+BftCSZvukQcHnVKjzXWlX5c6P4yJo0juFCYnxWqz1+1t
        FqwN1aL53aA5TgK20kX48Y8+n2k/1RUclxBOtS4=
X-Google-Smtp-Source: AKy350ZFG3UTHm3sBP58Fno4kIsIdNDJ0dz7Z5ySjSVhbi2XZCOv8Pvqm17Zayd0KsIGaCYvzcSuAw==
X-Received: by 2002:a17:907:208c:b0:94e:547b:6322 with SMTP id pv12-20020a170907208c00b0094e547b6322mr1537489ejb.25.1681549860633;
        Sat, 15 Apr 2023 02:11:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a3bf:4ed:6c53:2a36? ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id gy23-20020a170906f25700b0094f31208918sm92340ejb.108.2023.04.15.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 02:11:00 -0700 (PDT)
Message-ID: <8a790966-d985-c0fc-498e-c17e69a6622e@linaro.org>
Date:   Sat, 15 Apr 2023 11:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add advanced
 sensitivity settings
Content-Language: en-US
To:     Jiri Valek - 2N <jiriv@axis.com>, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230414233815.4004526-1-jiriv@axis.com>
 <20230414233815.4004526-2-jiriv@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414233815.4004526-2-jiriv@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 01:38, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings and signal guard feature.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml     | 64 ++++++++++++++++++-
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 5fa625b5c5fb..08e28226a164 100644
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
>  
>    microchip,sensor-gain:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -70,6 +70,58 @@ properties:
>        open drain. This property allows using the active
>        high push-pull output.
>  
> +  microchip,sensitivity-delta-sense:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
> +      At the more sensitive settings, touches are detected for a smaller delta
> +      capacitance corresponding to a “lighter” touch.
> +
> +  microchip,sensitivity-base-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 256
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256]
> +    description: |
> +      Optional parameter. Controls data scaling factor.
> +      The higher the value of these bits, the larger the range and the lower
> +      the resolution of the data presented. These settings will not affect
> +      touch detection or sensitivity.
> +
> +  microchip,signal-guard:
> +    minItems: 3
> +    maxItems: 8
> +    enum: [0, 1]
> +    default: 0

This was not really tested. Missing ref, mixing scalar and array
properties. You want items with enum. And drop default.


> +    description: |
> +      Optional parameter supported only for CAP129x.

Then disallow it for others (allOf:if:then: ...
microchip,signal-guard:false)
> +      The signal guard isolates the signal from virtual grounds.
> +      If enabled then the behavior of the channel is changed to signal guard.
> +      The number of entries must correspond to the number of channels.
> +
> +  microchip,input-treshold:
> +    minItems: 3
> +    maxItems: 8
> +    minimum: 0
> +    maximum: 127
> +    default: 64
> +    description: |
> +      Optional parameter. Specifies the delta threshold that is used to
> +      determine if a touch has been detected.
> +      The number of entries must correspond to the number of channels.
> +
> +  microchip,calib-sensitivity:
> +    minItems: 3
> +    maxItems: 8
> +    enum: [1, 2, 4]
> +    default: 1
> +    description: |
> +      Optional parameter supported only for CAP129x. Specifies an array of
> +      numeric values that controls the gain used by the calibration routine to
> +      enable sensor inputs to be more sensitive for proximity detection.
> +      The number of entries must correspond to the number of channels.

Most of these properties do not look like hardware properties. Policies
and runtime configuration should not be put into DT. Explain please why
these are board-specific thus suitable for DT.


Best regards,
Krzysztof

