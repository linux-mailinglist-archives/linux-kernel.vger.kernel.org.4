Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618EA6C7D76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCXLsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:48:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94540272C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:48:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so6889463edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679658525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8LtNo9O+N2urrNpkv74xPVkcVBPtljyRPq/ezfzVBE=;
        b=rI+XgDA/H+XuKYBqgGmgj0mj37fzfUDe7gDew0ugQBK+ayvpgkpx0sKAgfpQrVgVPc
         2ioMJcGrktbmW2Lv37II6n2IDGxydQIqCzQjcaag2dpAGzpm7WrrowwTJH57ajwq382f
         ZD+mKdkJhlJM9gueKNoCXDDh59imz8rUhYn/NiO1k3q3jZeoseDkK58MkhaDuAIW/UEZ
         obz+ZnJAzSNBTr8fOcquo3Ok15UO5YW75gr3WgVyYoD6NRmuCfUXz1QhFyVPP62Ofb91
         lSQ7khRiYqgksVeyH8fOWS9NJIQaARz1RQsVvrccon3nTti/TygLjD1/Ducxw2gm1ITK
         rFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8LtNo9O+N2urrNpkv74xPVkcVBPtljyRPq/ezfzVBE=;
        b=YP8xq7f9P3vaLzssbm2bkiV26BEBtAUxyDHGU9bltwKh/uupm1rFD5qM/hjkWBNbEk
         lAG77HTFdoROq1U72MVh/IWP+oX8EWZaz8EQ4gTEcxinGzn0UK3+Lsmm7JDdxD9j3k4h
         4c5XvofPO2I5oQKPgibgboCPvvL0Gje3w0u3pA8lMScH2wHMJv7AtgnnkGYSn+zmUSR1
         0eZ6uV0bERA4uNllsKX1E/VQXDssxzTEPrVo19Q8CMrHf3/ehgENGlkkKdPp7uVjCVWU
         7oe2j35DMbr8u9c940APFjwH9ze3pmGEGuE+WfwainXZ3rPPWrqljHD2CUda94rL8bzG
         si7w==
X-Gm-Message-State: AAQBX9fbFcV+B2kN2BFmJ9G2IZK/iGDP3yuyYRnIP5m1ZGWZR0KUG+nR
        0A/18bT0yBQNqgJJkpfMpo8OSg==
X-Google-Smtp-Source: AKy350Y+nkI7+I9GQMdFtSG2iD87jfm69SH6LIPv9KX3N+Z4mg0ptJ3fVUsTNB68LSUeqAJXiOf4tA==
X-Received: by 2002:a17:906:580b:b0:931:20fd:3d09 with SMTP id m11-20020a170906580b00b0093120fd3d09mr2415525ejq.17.1679658524922;
        Fri, 24 Mar 2023 04:48:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm8084789ejr.163.2023.03.24.04.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:48:44 -0700 (PDT)
Message-ID: <4f90e84b-1a9e-bc96-c9b3-12f95ea7bcff@linaro.org>
Date:   Fri, 24 Mar 2023 12:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6] ASoC: dt-bindings: Add tas2781 DT documenting that
 binding along with the driver
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        x1077012@ti.com, peeyush@ti.com, navada@ti.com
References: <20230324110929.27710-1-13916275206@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324110929.27710-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 12:09, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>

Where is the driver? Why are you sending these separate? You already got
comment about wrong threading, so I really expect some improvements.
> 
> ---
> Changes in v6:
>  - Remove all the "|" after "description:".
>  - Drop the reset-gpios description.
>  - Be consistent on the I2C.
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 000000000000..af37595f3a6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,84 @@
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
> +description:
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
> +    description:
> +      I2C address of the primary device.

What happened here? Rob's comment seems ignored and now we have
description without anything useful.

> +
> +  reset-gpios:
> +    maxItems: 1
> +

Best regards,
Krzysztof

