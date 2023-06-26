Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213373E37B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFZPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFZPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:36:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D4F3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:36:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso32579345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687793783; x=1690385783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnVw1NqNJcB00wQMw/uTf6e21wRfweiPK9JrGx6RcVs=;
        b=D9mwgzNM/+uNromAIaOtv+8vCdJcxZGi2RkJpT8Xes9k32j6KEUBg8ZKxL33kbAaCO
         YtZd/Iie+psdVOLf1tA7YXJrbVYWhHMNb8fPmHFSN8Y+neyEhjj+RNTCzW2BBsbImRR8
         WU97HivRP0HDcLUv1IKfOgsNrRQ7w1/7iyu+v74DMsxZM2AXR9oH/OWA7Gqo19hwNTRz
         1R9FC6W4bDN38ki+xEOV+cDVd0qR9P5RJy8uVW+tthHX17xTAdMhqmmqwH0QKT7qGpdi
         IYWZ4kBybxrzzyrk9425FfOt8ztGjwmUGNTGzf6I3cJmKfkDX45pKA0ackIBOnIW9MaP
         WPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793783; x=1690385783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnVw1NqNJcB00wQMw/uTf6e21wRfweiPK9JrGx6RcVs=;
        b=Cd0/7fRP7i5+XZIQBiQcQRZLcUcbCaMtsu7dinwhVSNVDUGAEGXnbHDr6WXt7WSOt7
         nyMdwDYTofPrDBvHq84qL9Mw5d8tLJ6zjdzv+zviZ8mPra5I+CkW9w1qX7w6rIxPKvLo
         gEaatrUCD9TImtvdTuyfRTYmIZ93vfQUvUEJUC37Ws56Drj5oapJ1CEmuIm7gCc1zn2l
         HxDJ4S3tOSe5jD0tBtdFgX8rSQoPb7T27NhbobfeWVqavRmAL5c6KDMQo5//ynY//KWa
         C+odKMysz39F+s5ElXsdGfVXf7OB1CqVmwjM/1FDiSoqNzeuBcGKVnFP//h9tgvnN9DN
         HY7Q==
X-Gm-Message-State: AC+VfDwGt8iqKv58TfTbEpVJaNYuDb1+cIXeoE6J6YusUGvL/3JIDHBf
        N9ZO65P610rQQ17jD+eFKwuLnA==
X-Google-Smtp-Source: ACHHUZ4FEXp87ZB3EcU+bYZN9wHCNNB8g6R8m5tOeOJIbVYlTsm0uefU0pHye2INl7YnnWSdeOC3YA==
X-Received: by 2002:a1c:4c14:0:b0:3f9:b0c2:9ff7 with SMTP id z20-20020a1c4c14000000b003f9b0c29ff7mr15585537wmf.30.1687793782804;
        Mon, 26 Jun 2023 08:36:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s4-20020adfea84000000b002ca864b807csm7910245wrm.0.2023.06.26.08.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:36:22 -0700 (PDT)
Message-ID: <fc726c72-0503-b407-cad1-f24422f02ab2@linaro.org>
Date:   Mon, 26 Jun 2023 17:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/5] ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC
 controller
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
 <20230626110909.38718-4-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626110909.38718-4-hal.feng@starfivetech.com>
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
> Add bindings for the PWM-DAC controller on the JH7110
> RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../sound/starfive,jh7110-pwmdac.yaml         | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
> new file mode 100644
> index 000000000000..91a4213f2bd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PWM-DAC Controller
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The PWM-DAC Controller uses PWM square wave generators plus RC filters to
> +  form a DAC for audio play in StarFive JH7110 SoC. This audio play controller
> +  supports 16 bit audio format, up to 48K sampling frequency , up to left

No space before ,

> +  and right dual channels.
> +
> +maintainers:
> +  - Hal Feng <hal.feng@starfivetec


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

