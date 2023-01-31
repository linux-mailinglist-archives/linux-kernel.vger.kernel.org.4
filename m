Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85637683484
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjAaR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjAaR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:59:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB2510AB3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:59:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so4126518wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/szpvn7y9gec1tyWJQBadgKS8WeEN4pwAXM4ABHxKUU=;
        b=SsXUyMMSeCP/y7sVGkHIr+wpXtG+lNexPqRpKCZMGeB2LOgMxzjBwleq77KDiUrHwp
         SNs3p6Z2ZLyYZyDrWO99h05TxvEa3nX9dSE2k+4IWs1ABGkpDK0yH3ARbya2Y2DQLBLQ
         PvOrQ+aPNQM49D/a08vbA2DJI9XwdMVecs7CvJnVw6kN7/HNI1cny2fSHFE8B17TNitz
         Hrk8XloenIKFWf8a2/EWU+eLCsv9MyWD/I1S/EQ3F4d0Jk3E9cK1fhDH/4Ol0DOOkqwO
         MwVpmttmVDVLqScMFYgRYN0BrQ6Qgvr2Y2fyTQw/ths+an/9+uhimFl0fZk2bfFQXVLQ
         U9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/szpvn7y9gec1tyWJQBadgKS8WeEN4pwAXM4ABHxKUU=;
        b=PJM8tQBX6t/vaBHLxhOUwUIEl/a8e0awXk9L+caWWlqZz7aHkI7bu7cYc62errOkLl
         9cttdb+u7LGraMwW9dq/yTTjp1Bn0bZnnnbmHT9k+918hrVtPcJVaEYuA+HqM0mPr1Yp
         /tOiv4vPvZOjoupsBqljoKY0fOU2C/RSNSB+1SJZIkQ6hGV4y61NP7JPpOsG00U/eahe
         5gD9B3XP+HGy13R3LqCDKBaTEYzDugBKXnAcGFLYIUj14JoARCH8GR48ym/MtNg88PCG
         Kqz5zhD/Ddrnm+dnww/ltJBz9CPoLCcU4ZGkXsDSU8uz9kg8556VL0aLNHZmWapkQwro
         K1bQ==
X-Gm-Message-State: AO0yUKVd2Br5YpgdM34IonhxRZ8bQ+MPAYvFgCKxRt4rdDPWcf5FaJIN
        72Rj9c6m+AyOab4nH2SxhcKY4A==
X-Google-Smtp-Source: AK7set/mH8G8arPE9aWgo+oZwj285W4mdjXlicy8LcplDLyXvEcpmpH/9UUR/d6w07g+gluxQr8aGQ==
X-Received: by 2002:a7b:c853:0:b0:3dc:5342:4132 with SMTP id c19-20020a7bc853000000b003dc53424132mr10709426wml.4.1675187964539;
        Tue, 31 Jan 2023 09:59:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p7-20020a1c5447000000b003dc433355aasm13191576wmi.18.2023.01.31.09.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:59:24 -0800 (PST)
Message-ID: <5ecabe9e-84f2-cc3a-c213-3b623f90842e@linaro.org>
Date:   Tue, 31 Jan 2023 18:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5] ASoC: dt-bindings: Add tas2781 amplifier.
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131131735.7118-1-13916275206@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131131735.7118-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 14:17, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.

You treat my feedback selectively... some things improved, but not
everything. I am literally repeating the same and expect different
results from you... isn't that the definition of insanity?

Let me paste ignored parts:

1. Your patches are still not correctly threaded. There is no threading
at all.

I said it multiple times. What else should I say here?

2. Subject: ASoC: dt-bindings: Add tas2781 amplifier
(drop the full stop - why did you add it there?)

3. Missing changelog under ---.
I mentioned it already few times, didn't I?

> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 000000000..9a440d29f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TAS2781 SmartAMP
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
> +  reset-gpios:
> +    maxItems: 1
> +    description: |
> +      A GPIO line handling reset of the chip. As the line is active high,
> +      it should be marked GPIO_ACTIVE_HIGH (see ../gpio/gpio.txt)

Drop the reference to gpio.txt.

I give up. I spent too much time on it while being also ignored a bit
too much.


Best regards,
Krzysztof

