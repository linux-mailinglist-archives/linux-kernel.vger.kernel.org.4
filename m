Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2273E35E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFZPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:32:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A710E6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:32:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so44675225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793527; x=1690385527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UotEKVGu4UicdFRFt8vn+mqKSPhJyyY8erAKccSLFS8=;
        b=OiVPY0SKcCbKeSILoHCmY/qT1E319c5b9eIcoYOSF8c1k8vSUoewSPFxtd2GMDUSEv
         7qGqpG+l3PBAgiP4ckxQoCzKIvwXF4hlGeP8/yyCjrqZFc00KH1/HH4JMwxrZdC4V2qg
         j333CfYYVQwgPNSX/ctAvOS118+Lrxb2KYg1Z5oPJFl3WSzUqKVvQDjimxbpRrdUg4TK
         60Ly4FS50ydNH0ooiZm4eoSmwxmn9YxoCYyCHx/52wHZSCKaZ6aMFIxzO3HghTfGGuLi
         iiQ3RB+WJZyxlAwMqw5RdxqQDku5fLPBVeLuZW2PwkFphHG0/rmutptD0oEBQbUY+/dh
         l1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793527; x=1690385527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UotEKVGu4UicdFRFt8vn+mqKSPhJyyY8erAKccSLFS8=;
        b=X/Tz+1/LHzdh74IiOI1f/8bIvKX2Z4CCg2Bk0St7GxBG8CyEcZ2TwWCjWshaqcld5j
         hKl2Mf3JU3cHPnoxurtCrRTuUwoTWU76CODt+9uqfGnIkim5gXooraFGLAYyWhlZ8z6i
         YDqm6WL1BIaKaYatDmxriT83TNKSU6kNWz5AjFyg4bzBOtKVE9TlV/r/RafUuKt5uy6U
         KYWIYdMLiV3Yr+lWj2sJgS2bSqutwvra4XlkJ05AqRtjQRwa7aD6o5VGw8QvE/sUmZhH
         7zAw6px76s+pRrMDfjRUcIbXz0NG5tHw84hq/D+yiIKuAxi6VjZ2ER5BW7CeG7Y8gmgb
         QGzg==
X-Gm-Message-State: AC+VfDx4bjbbxaRfvcE4I0nleQ3fVAkFVihRUVqDZCndrY9gSVQLj4Jb
        UYCF/tLGPbsvEBy3MYvDqWccVA==
X-Google-Smtp-Source: ACHHUZ5Go2QzsyA7PJ5u3USfatgPyu7gSb79h4oB9qw8x8KLefKL4zc8Uq/5/48twyYJ9y10B561jQ==
X-Received: by 2002:a7b:ce98:0:b0:3fa:7478:64be with SMTP id q24-20020a7bce98000000b003fa747864bemr10432370wmj.1.1687793526846;
        Mon, 26 Jun 2023 08:32:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003eddc6aa5fasm10864959wmc.39.2023.06.26.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:32:06 -0700 (PDT)
Message-ID: <92171465-d2ba-c3ba-aa55-0f705e924a0f@linaro.org>
Date:   Mon, 26 Jun 2023 17:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626110909.38718-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 13:09, Hal Feng wrote:
> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../sound/starfive,jh7110-pwmdac-dit.yaml     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
> new file mode 100644
> index 000000000000..bc43e3b1e9d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac-dit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Dummy PWM-DAC Transmitter
> +
> +maintainers:
> +  - Hal Feng <hal.feng@starfivetech.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pwmdac-dit
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  sound-name-prefix: true

Drop

> +
> +required:
> +  - compatible
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false

Instead: unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwmdac-dit {

pwmdac?

Best regards,
Krzysztof

