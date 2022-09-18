Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA95BBD2E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIRJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIRJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:54:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF342983A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:51:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so30283184lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PKBg5ng7PnWT5G7IkXOVZef3/wyXg4tjFKeAtGbo5Lk=;
        b=Wp0ZjomX491U2rtytMCDb+CR94gy+1DIlxKK12p7ND8SR/hx3X3hdiRuZ1MbpphJTq
         txKv40nzT3myoEkSuZB1SCD7vGdILwv6DZ4hzYb4gxbV4wsNef/3Lx435X7KZ3k1YIvH
         y1EQPXAGFXLS1Q2xdTZJLGMegi4lSAkwQ+UHP9fasg0ftekSOBRryTwXZYncYwsfLJru
         Nm+ipzZAl93L75RmHQ006JdD2JgzIkpfYFjLjLJQ01dkevVf59iASAz0N5YS9fFD+4uG
         uUQ7oznjf8vQ+duVO8RWaXxjbVZGU93lGdI8uvCgaJyiwqfxZ1GmxfMwH2DI65MlGw1S
         9++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PKBg5ng7PnWT5G7IkXOVZef3/wyXg4tjFKeAtGbo5Lk=;
        b=zNetLYsv114oFZNrU8B/6yS5KVw7vDR/kmSomQxBfw8897qMoiOxoIBzrFNlFcuhrG
         I4RjSJUrxNnm6UOtlFyF4JqQ2OCbKYhq1MkT9GIT2RAroHIKK0i6n+fDwCCsWp68dvyT
         3H+6byScn7WD+LHWV6K+8EirUkkInXhPXxvEojzOak36L0+LnXfWgbTRJORGnvEqennG
         Z8eY/HGyYZBXVHhLjVc8AwOf8UnUlTGQv/VKKZoJor2H4apEHKa13viCAtY9pt142ZxF
         BR7Yd52toygO+xocwaJbYJfE3d4KM4uQJvMgMGwTv7xNgia/i5tmFenE/w3ce1iF4iQu
         Za2A==
X-Gm-Message-State: ACrzQf1s64f/SAUPKN1/ZSIYVKmBIQonuMFDcZPeCOqNfwDXjfvxeKly
        7xuBrwsdbpf4Rvnqtryi7Bff4w==
X-Google-Smtp-Source: AMsMyM5fLqyeOXxhQHdX+OOxELBYD3ckReSg83MxwbqlwSMZaQyVVpAnIOHc9SP/XraIp0pF3FQnyQ==
X-Received: by 2002:a19:6b05:0:b0:49f:53b9:abb0 with SMTP id d5-20020a196b05000000b0049f53b9abb0mr3821048lfa.166.1663494648565;
        Sun, 18 Sep 2022 02:50:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512308f00b004977e865220sm4574286lfd.55.2022.09.18.02.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:50:47 -0700 (PDT)
Message-ID: <d264ff4f-3aa3-8dd4-26fc-9cffe950f386@linaro.org>
Date:   Sun, 18 Sep 2022 10:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: ts3a227e: convert to yaml
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@axis.c, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>,
        devicetree@vger.kernel.org
References: <20220915113955.22521-1-astrid.rost@axis.com>
 <20220915113955.22521-2-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915113955.22521-2-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 12:39, Astrid Rost wrote:
> Convert from ts3a227e.txt to yaml.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  .../devicetree/bindings/sound/ts3a227e.txt    | 30 --------
>  .../devicetree/bindings/sound/ts3a227e.yaml   | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 30 deletions(-)


> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ts3a227e.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/ts3a227e.yaml#"


Filename based on compatible, so ti,ts3a227e.yaml

> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both lines above.

> +
> +title: Texas Instruments TS3A227E
> +  Autonomous Audio Accessory Detection and Configuration Switch
> +
> +maintainers:
> +  - Dylan Reid <dgreid@chromium.org>
> +
> +description: |
> +  The TS3A227E detect headsets of 3-ring and 4-ring standards and
> +  switches automatically to route the microphone correctly. It also
> +  handles key press detection in accordance with the Android audio
> +  headset specification v1.0.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ts3a227e
> +
> +  reg:
> +    description: I2C address of the device.

Skip description, it's obvious.

> +    const: 0x3b
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Interrupt number for /INT pin from the ts3a227e.

Skip description

> +
> +  ti,micbias:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Intended MICBIAS voltage (datasheet section 9.6.7).
> +    enum:
> +      - 0 # 2.1 V
> +      - 1 # 2.2 V
> +      - 2 # 2.3 V
> +      - 3 # 2.4 V
> +      - 4 # 2.5 V
> +      - 5 # 2.6 V
> +      - 6 # 2.7 V
> +      - 7 # 2.8 V
> +    default: 2

Old bindings said default is 1. It this was intended, please mention in
commit msg deviations from pure conversion.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

This header is not used.

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {

Node name just "i2c"

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec: ts3a227e@3b {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

audio-controller? audio-switch?

> +            compatible = "ti,ts3a227e";
> +            reg = <0x3b>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +
> +...


Best regards,
Krzysztof
