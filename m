Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875672AD50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFJQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFJQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:33:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8083588
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:33:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso5012850a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686414827; x=1689006827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l50ztdy803Rs9JFTnKYE2HhzZPCqwSZFYHkaw2+qQnQ=;
        b=bWgDopw0O6HoJAvCfQ8hW4m4bLt9ezB6Eu+AJPVf1UKhoQoUlHEbVxXfxrZyfiFwBE
         6k4UgkH1JGCEZArRbwb8AOhR3cGepM6XA/qeX3Ny3bZ9N1nYAIgMZVSYrmEb97xnHHWF
         Bt+QbKgMPRAVbm7+O9oqS0iRnVNiMop9PblAr7SlwdPwyZDb/RIgXzrONsIwz3af+Bbh
         gUOZAr2RQk3lTh6bY+JqR0LgnkMUIySg8ajKtLlGveveS8J6IpcAkF+xrikRW99ep0Ss
         LiQLx5ogqkJjbvgbL/crn/J3mWgJQooQON7OQ8V+MPYAmMO/KIwLJIgA+Stl14O34Xwr
         f4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686414827; x=1689006827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l50ztdy803Rs9JFTnKYE2HhzZPCqwSZFYHkaw2+qQnQ=;
        b=c6i9npqaVAf1U+TpQ7KQuHwLtfet1Bp6z/2XFD09wC6wEkAJ9X2qsAlHbWQBrPJ6iR
         YCQomIPJ44pQoPcxe9Lns0zV9OZfYIlYUj0rRRgZXbKOKzaBPzCOLt/yKoC1opV5dABd
         3lys3UBkufV5gv/oRp5gSlyipgmaKNkMCil5OLD4WuPXLbWGOLyu/k3uapJyJtWcDILf
         fQws0MB64poRnFIImxO+BTWRP9wmqKlpl+h7tLAnH74XWyJHktzYVKr8ejmh9ftGPNPG
         scYGXzwo2g8AUQ5/k225w72JlAGF/hamXmtN00frH350rb+Unkj9ANoc0nGuOXZ6z9p/
         3TkQ==
X-Gm-Message-State: AC+VfDwUlj/VDAww+NXiLXBn+CzQnJ4TRqTNYLcaWBldGpnoAXSf1NcT
        LHvpOmBWNfNX9qFf7dQE25b6Uw==
X-Google-Smtp-Source: ACHHUZ6F9rno3bFUANVMaUF61hEAO1cBPieqGMKrRjs677ZGAHjB3OeBzY8fUW14V9MhS4cW4sQycQ==
X-Received: by 2002:aa7:d358:0:b0:514:a650:99fb with SMTP id m24-20020aa7d358000000b00514a65099fbmr1750166edr.23.1686414827478;
        Sat, 10 Jun 2023 09:33:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b00518286f5837sm919118edr.58.2023.06.10.09.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:33:47 -0700 (PDT)
Message-ID: <95aca760-c17c-eb96-bcfb-85f20124812b@linaro.org>
Date:   Sat, 10 Jun 2023 18:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 4/4] ASoC: dt-bindings: Add tas2781 amplifier
Content-Language: en-US
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com, tiwai@suse.de
References: <20230610141821.576926-1-13916275206@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610141821.576926-1-13916275206@139.com>
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

On 10/06/2023 16:18, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>

We keep telling you that your email threading is broken. It still is
makes reviewers life more difficult. Maintainer as well as applying is
not straightforward.

Why this is not improved?

> 
> ---
> Changes in v5:
>  - remove ti,broadcast-addr
>  - remove address-cells
>  - remove size-cells
>  - put compatible item first in properties
>  - change the maxItems of reg from 4 to 8
>  - remove white space around <>
>  - correct the reg format to <0x38>, <0x3a> etc
>  - remove '\t' in the file
>  - correct a comment in the example
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 000000000000..61db14a39630
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,73 @@
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
> +
> +description:
> +  The TAS2781 is a mono, digital input Class-D audio amplifier
> +  optimized for efficiently driving high peak power into small
> +  loudspeakers. Integrated an on-chip DSP supports Texas Instruments
> +  Smart Amp speaker protection algorithm. The integrated speaker
> +  voltage and current sense provides for real time
> +  monitoring of loudspeaker behavior.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2781
> +
> +  reg:
> +    description:
> +      I2C address, in multiple tas2781s case, all the i2c address
> +      aggreate as one Audio Device to support multiple audio slots.
> +    maxItems: 8
> +    items:
> +      minimum: 0x38
> +      maximum: 0x3f

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

You miss here minItems.


Best regards,
Krzysztof

