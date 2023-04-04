Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8376D584E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjDDF7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjDDF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:59:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FED1BCD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:59:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so126029722edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680587958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiB8f+utJ+hMeKGr19vY1AW8IT5CgpavMZTAW8CfDo8=;
        b=LWTekgtcYnpbuZIaVWv1QyVwvaglD4P2iektNFDuOxM5mrqAwrYKqA+BPIgSOL03eM
         SJda9KY/tHhzaDB4EwFImm4vXfvNYQWn4mMr8cQEZjXqERYdQOIQ+3XbuDwYSGUKwCNN
         g8N2JQqo9jifsK6G0Z9PzIiK3DQ9befm5eahQAy7aN0eTE7nUKi7uNsZQuBmFkQPk4ja
         Jk5iTVHpSMRuL1MguJDv8JXqKEEWLODwyO7q8QnBIUv0UfjR9FqasZRjaJlH8FpOnQ3g
         R9ftdW5MfW9tW+xFvgbRgOcGaUejyOYeYeFeIGxBnSTaXdjCisMIdE6visvyWyWn4o5v
         b5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiB8f+utJ+hMeKGr19vY1AW8IT5CgpavMZTAW8CfDo8=;
        b=NMVfkRVZxv+itb1hI02mq4+CF0xkKloC8lckyEUfjsR90RUtyW4PTLQaLJf6MPel00
         vFwuxSepHMHr6bvjh/ek1op+E2YvLHvGUptQDgVa3Y2ta8H1KXW7ho9nk9uQEDAhwqyJ
         WGB90ieb/et7+ZcUd8NNJY528676pdC3jhL5xQN9DLT2OtjhCZaNBHXwzNQtlXvGaOFu
         guAQA3kkh1dGzG6e1Kk/YJMjhI+HTY03NK8tlZFeVkqvpKI8Lv3uC9TMbQoUkoug7fWn
         DpE8+E72Ri9SMe9NAqx1HUccCgAvdljrTgqc/MPFJIpsnJCKYEVN/xa9EW1JSBKQlRAz
         LoGg==
X-Gm-Message-State: AAQBX9cghdFaFKpkwjgcMH7W26CMzBcPsYa1FSN9/eMzZAKtWLg/sCx6
        ercjcJcAo3bht5qI0y3L9zKqyg==
X-Google-Smtp-Source: AKy350Zjo5JyIPdPVntAKk8hSDAAoeHUNUAJjySaQFV09xKFNyvBWdycJ19uxRDC8bj0CbRgMxB3QA==
X-Received: by 2002:a17:907:33cf:b0:93e:9fb9:183b with SMTP id zk15-20020a17090733cf00b0093e9fb9183bmr916720ejb.73.1680587957768;
        Mon, 03 Apr 2023 22:59:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id ld10-20020a1709079c0a00b00949173bdad1sm286721ejc.213.2023.04.03.22.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:59:17 -0700 (PDT)
Message-ID: <9dc60868-b3f2-e30f-f4fe-d2fbd551d948@linaro.org>
Date:   Tue, 4 Apr 2023 07:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 11:06, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  License update
>  Don't need to show providers
>  Make example complete
>  Decrease beeper hz

Why?

>  Misc update
> 
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 -----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> deleted file mode 100644
> index 8fc0e48c20db..000000000000
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* PWM beeper device tree bindings
> -
> -Registers a PWM device as beeper.
> -
> -Required properties:
> -- compatible: should be "pwm-beeper"
> -- pwms: phandle to the physical PWM device
> -
> -Optional properties:
> -- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
> -- beeper-hz:  bell frequency in Hz
> -
> -Example:
> -
> -beeper_amp: amplifier {
> -	compatible = "fixed-regulator";
> -	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> -};
> -
> -beeper {
> -	compatible = "pwm-beeper";
> -	pwms = <&pwm0>;
> -	amp-supply = <&beeper_amp>;
> -};
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> new file mode 100644
> index 000000000000..a3797f338f46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM beeper
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    const: pwm-beeper
> +
> +  pwms:
> +    description: Phandle to the physical PWM device

Drop description.

> +    maxItems: 1
> +
> +  amp-supply:
> +    description: Phandle to a regulator that acts as an amplifier for the beeper

Drop "Phandle to a regulator that acts as "

> +
> +  beeper-hz:
> +    description: bell frequency in Hz
> +    minimum: 1
> +    maximum: 4

default is 1000, so how constraints can be lower than default? Also -
missing default.

Best regards,
Krzysztof

