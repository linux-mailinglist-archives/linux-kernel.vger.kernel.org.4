Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7566B17D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjAOOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAOOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:24:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257C113EB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:24:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x36so2842770ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IoZ76KwUCL1cqVizi7jor5ObAdKymPi7IVnSChtivQ=;
        b=O+rd/HyGIpwbOvRxpAzEL5hycb7Ldd05Bkmc0ReGQ8J3DLFmCxOVR/WNeC8e23xeuy
         Q70w1Ve61QDIiy0fvvO735BWccQ3jmt+M3atp7dE9miRsE1M7U5c+Cf41gnoreHBfpdD
         u8ztvUNn3GRY0m1FdAi6TG601JxxmvJVLhntpTIPcltG18S0DRpgCLmWK6cW15ajm/TF
         E96EcQONl1IZdEcy1N5tGq1b1FAIgxzzofPCTgy6vEqx+P77Lse67Y8Pe5NNvr3bbhqb
         7pePfPw2hsgUQXH7ZFmWj6ZHcCBxBqi0QH0X+QE6VHNAYPOM3yiDDRuRb61bIfdVXRRd
         byAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IoZ76KwUCL1cqVizi7jor5ObAdKymPi7IVnSChtivQ=;
        b=cmsM5GZdSNaGRn64fg+2MLLyU9UMCQckx61KthyCTCzp/0UQUQ2YdVTaQ71qaWiixQ
         EkYsog0tiU5AX6nViKetU6dMIVqvO/6O+w3tddhuwnFQQQRMJfajzSOCX5HIMrqyzVr4
         qGo84VnsySMcusSWJ78tM40QOHfrddVTu+NYLubCesNf4UZtRicHYMK4ULLqujMVP/kK
         wxnStXwln3mX7u3/J2vwMJa4xBgmj2LBUiyVj9oRE7ZEUdD1IoN5F+Entuq+vhPCA2QL
         gsnsyp2ehfa23GiVxF7mrxwRtc80oMvHKvGDAzsKEHpyVZKE2of0+3EB2melgtCg9IDV
         5RPQ==
X-Gm-Message-State: AFqh2kppSntci5yhcm3BHCCvQaVyFXfGWJlhAfYFx0GBiPVRqjemI06R
        3Qlm7ATLqtWxPRGBTjE5B253FzT176Rq+b2Y
X-Google-Smtp-Source: AMrXdXvqARNALDKkdSGT8usje4vt7FpVeTK0wvt4xJZxCeTFNVA+7h7GVWmhNdfN9x+EJ/hbYPXIOA==
X-Received: by 2002:a05:6402:241b:b0:461:2288:6808 with SMTP id t27-20020a056402241b00b0046122886808mr81710853eda.21.1673792686842;
        Sun, 15 Jan 2023 06:24:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b2-20020a0564021f0200b0048c85c5ad30sm10329632edb.83.2023.01.15.06.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:24:46 -0800 (PST)
Message-ID: <c3d5b577-2810-7ce1-3136-b0bc6c9171a5@linaro.org>
Date:   Sun, 15 Jan 2023 15:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] Asoc: dt_bindings: Add tas2781 yaml
Content-Language: en-US
To:     Kevin Lu <luminlong@139.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com
References: <20230115121629.2420-1-luminlong@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230115121629.2420-1-luminlong@139.com>
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

On 15/01/2023 13:16, Kevin Lu wrote:
> Complete the DTS for tas2781

1. This is not a v1 but v2.
2. Subject - still wrong.
3. Commit msg - does not make sense to me. I don't understand it.
4. Other comments - also not implemented.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.



> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 0000000..7d73f46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      I2C address of the device can be in range from 0x38 to 0x40.
> +
> +  ti,audio-slots:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      This item is used to store the i2c address of the device
> +      for deifferent audio slots. It is not required for Mono case.
> +
> +  ti,global-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      This item is used to store the generic i2c address of
> +      all the tas2781 devices for I2C broadcast during the multi-device
> +      writes, useless in mono case.
> +
> +  ti,reset-gpios:

I asked you to use existing property. Drop prefix.

> +    minItems: 1
> +    maxItems: 4
> +    description: GPIO specifier for the reset pin.
> +
> +  ti,irq-gpio:
> +    maxItems: 1
> +    description: GPIO used to interrupts the device.

So you ignored around 3 or four my comments. I'll stop the review - it
does not make sense.

NAK - this is not correct property. Implement the feedback.

Best regards,
Krzysztof

