Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC136FD89E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbjEJHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjEJHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:52:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA7CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:52:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so13162428a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705146; x=1686297146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buV1oS+q5zSYMCb+Vk5Sei3x9AdpdZjHmxNoX6GDBRE=;
        b=Q4XRlsa/ttO62lIK4GlvTimIidf2aZ8yWta4S1EEsfZMxipw4+4vFyoxAMvBO3WFtg
         SLnrwwacDR91Ltcs6KRK2lB9oz5WNqvkCQ2r6BV2RpFVUuC+bxpxblT5dd1LJ0HuGM1c
         TZyR+ILO+ItOWB7mfM/2AI9FVgrklZOFMsO7BVyxebCvru0hF4K69Fsh3eWXZrE/vsZD
         y0IxnpRhuCHlpspg1zMQXxJhTmu+Qy7RveEvP23D77fHuQv/9vJA/T3WaPr1ZxkGLMQv
         sSPrTIdo2yJeKQnWlS76VfEDyHdcHtENmMxvaKlxhk5Kz2kkyib3R7XGcdbfKOvEZUDW
         6NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705146; x=1686297146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buV1oS+q5zSYMCb+Vk5Sei3x9AdpdZjHmxNoX6GDBRE=;
        b=M1x1VGhrYeVurgNdsdlmoo6o/xTLxQphk7wJyl7Ztvaj/zId3jDjuv7+OVf+Iid7BY
         o3Rw8khXmylc5RaWvQUGEj3FgQo1x3dWD3F4dX8pMgl96Mhn8rsS26TWuy+CPeAPnvpO
         7BZUgpODMlukDThhD1QAm8BW5RGLE9WW1JQK+Tpf5yRyjeIg8zRBggxtyNw8NzqJ8G00
         HxlSXzXnErPdJbNcZz0hz9X2ex7zHwXX9Aevls/bmTmUqZ+Gy/z6dOm4UcNcic1WFBsf
         Y8XzPrh2eIHG6qd2uigcl1QPWKmHJMPk59vExm4o0yT23fmPgO1+bZf+egDBYBrNZdXn
         5gUQ==
X-Gm-Message-State: AC+VfDyX1ZCoGhb/0yVLjK7UuJwsMugq+TxTv+BGkxoLxHu11h3cTIm/
        T9H1TmRVG1Gd3WGZPBa2a/r7bg==
X-Google-Smtp-Source: ACHHUZ4PkilMztZzdtCbud0lGz7T8NDnLixfG28NHHOUaUz/5BDZAb+4ZEG6FXuOIsei4a4hftLJhQ==
X-Received: by 2002:a17:906:fe07:b0:953:8249:1834 with SMTP id wy7-20020a170906fe0700b0095382491834mr13901254ejb.16.1683705145939;
        Wed, 10 May 2023 00:52:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906b01400b0096165b2703asm2338115ejy.110.2023.05.10.00.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:52:24 -0700 (PDT)
Message-ID: <a575e8df-4882-79bc-ea1b-005961afb77f@linaro.org>
Date:   Wed, 10 May 2023 09:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 8/9] ASoC: dt-bindings: mediatek,mt8188-afe: correct
 clock name
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
 <20230510035526.18137-9-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510035526.18137-9-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 05:55, Trevor Wu wrote:
> The original clock names are different from the list in driver code.
> Correct the mismatched binding names in the patch.
> 
> Because no mt8188 upstream dts exists, it doesn't affect the existing
> dts file.
> 
> Fixes: 692d25b67e10 ("ASoC: dt-bindings: mediatek,mt8188-afe: add audio afe document")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mediatek,mt8188-afe.yaml   | 36 +++++++++----------


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

