Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFB65242F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLTQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiLTQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:04:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B861D32E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:04:15 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so19265686lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DY1/ZbtXwe/kzCYxDha03m5dSPbCawqPHdgmiIc+QiY=;
        b=gtIaUHTnYckDE12y2FXxA+ytDpmXeyr6vKpt/CV+m0unqjPR23ySidgcdosjGyOv0q
         NDcyBYLJgzWPQfvNpsl0ZgtHFkuVeBxnPuBm2cXsfNT+OEqRXS1lE7RBU85IwU6saB3z
         1LKCtjUU/P6ou4O7rS/L7tJFIvzOuz6bThdCuylFWFw5Nusij0Hz7Q6hfWhmqvTEZfOQ
         ZcWYr/XMk8v2ZpupWoV6nGPObTp/2HO87hrrheF68+szsRFYCk/hbbTq/JbEPVFRDpU+
         Mg9L1r/ktqi67WliIEP5uOIjOljtMEoS4QIKDnPz5QIkQTsR+I5gHo8c6xPwum+OqKUU
         m5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY1/ZbtXwe/kzCYxDha03m5dSPbCawqPHdgmiIc+QiY=;
        b=k+/VD0+cFDCzumK3vtQNpzYMbwXpMVnJtYbst16tZSqUGbuDHzZTUqeFcATzhN8pmR
         uFMNTSGHZhQEtpdDraRZ9EzW0y/uWNQaMghby+nxSLruhmh6oyvdTnQBUGxdYZ6y7w3K
         8KoT4rlcalEFjp/RL+KV/hNpsA/UD+icJdV7BAh+ovJyLOZrZrTQ5G0luihkyYBrqgdB
         DwYHykSyYUYkuMnKrbwiybsSemVwRN9yxJnN1lrWacQ1eLvayg2XQ/Jetc+acv6Wik/g
         Y6zIR7CAP0uV89B5DOHECf7Y1dYNv69IQbHa5C8fn6yXOthZu7y3WcMSRE3rB0ycV1o0
         JKFg==
X-Gm-Message-State: ANoB5plLVhRJGD1xJrQE/tp1sTGD19MSe4ORNNhtqdMvBaZpWt7/5WA7
        VAfKp1wxBtwhqkQ4Es+sH7fRCQ==
X-Google-Smtp-Source: AA0mqf4h11u79tlu5JMN37htLFcnw9h0CeJfR2bQr1v6G9XjFQoOcPBjERCxyLEBbRSl/umlgz9OsQ==
X-Received: by 2002:a05:6512:3091:b0:4b5:a64a:4408 with SMTP id z17-20020a056512309100b004b5a64a4408mr24666667lfd.48.1671552253453;
        Tue, 20 Dec 2022 08:04:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512214700b004a91df49508sm1498007lfr.177.2022.12.20.08.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 08:04:13 -0800 (PST)
Message-ID: <dfd02af2-0a7b-2fc2-a0a0-160b690ac2cb@linaro.org>
Date:   Tue, 20 Dec 2022 17:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] New yaml file: tas2781
Content-Language: en-US
To:     Kevin Lu <luminlong@139.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com
References: <20221220144114.2137-1-luminlong@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220144114.2137-1-luminlong@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 15:41, Kevin Lu wrote:
> Add DTS discription for tas2781 driver code

1. Use subject prefixes matching the subsystem (git log --oneline -- ...).

2. Anyway that's not correct subject. Look at existing commits.

3. Run spell check.

4. Missing full stop.

> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  .../devicetree/bindings/sound/tas2781.yaml    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2781.yaml

Filename with vendor prefix, just like compatible.

> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2781.yaml b/Documentation/devicetree/bindings/sound/tas2781.yaml
> new file mode 100644
> index 000000000..96fa45bf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2781.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2781.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: Texas Instruments TAS2781 Smart PA
> +
> +maintainers:
> +  - Shenghao Ding <shenghao-ding@ti.com>
> +  - Kevin Lu <kevin-lu@ti.com>
> +
> +description: |
> +  The TAS2781 is a mono, digital input Class-D audio amplifier
> +  optimized for efficiently driving high peak power into small
> +  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
> +  Smart Amp speaker protection algorithm. The integrated speaker
> +  voltage and current sense provides for real time
> +  monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2781
> +      - ti,audev

That's not a correct (real) compatible. Drop.

> +    description: |
> +        ti,audev will disable the irq of tas2781.

Drop description.

Missing blank line.

> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be between 0x38 to 0x40.
> +
> +  reset-gpioN:

Nope, use existing property. See gpio-consumer-common

> +    maxItems: 4
> +    description: GPIO used to reset the device.

This does not work like that. You did not even test it, right?

> +
> +  ti,topleft-channel:
> +    maxItems: 1
> +    description: I2C Address for each specific device.

No clue what's this. You need to explain in details in description.

> +
> +  ti,topright-channel:
> +    maxItems: 1

Ditto and in all other places.

> +
> +  ti,bottomleft-channel:
> +    maxItems: 1
> +
> +  ti,bottomright-channel:
> +    maxItems: 1
> +
> +  ti,global-address:
> +    maxItems: 1
> +    description: This item is not mandatory. if the device support gloabel mode, this item should be active.

I have no clue what is gloabel mode but the field looks incorrect. Drop
or properly describe.

Also wrong line wrapping.

> +
> +  ti,irq-gpio:
> +    maxItems: 1
> +    description: GPIO used to interrupt the device.

No. Use interrupts.

> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c0 {

i2c

> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     codec: codec@38 {
> +       compatible = "ti,tas2781";
> +       reg = <0x38>;
> +       #sound-dai-cells = <1>;
> +       ti,topleft-channel = <0x38>;
> +       ti,topright-channel = <0x39>;
> +       ti,bottomright-channel = <0x3a>;
> +       ti,bottomright-channel = <0x3b>;
> +       ti,global-address = <0x40>;
> +       ti,reset-gpio0 = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +       ti,reset-gpio1 = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +       ti,reset-gpio2 = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +       ti,reset-gpio3 = <&gpio1 13 GPIO_ACTIVE_HIGH>;


Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

