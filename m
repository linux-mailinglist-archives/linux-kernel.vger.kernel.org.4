Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822EF6FBF28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjEIGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjEIGSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:18:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1797E70
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:18:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so8252353a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683613097; x=1686205097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apXwfMR8TTZYSL3Z+8JPoDod3IpeRtMiYvOMKSanre4=;
        b=cNSG2zKXrbZG0zgki2yny0n65hFaO/rT27kimKn4JNV9asf3q9q+1vXUNmKUVd1AUT
         yCNJ1OAzqttFSfRv7GsJu01tsKOrqZzmnDlvV66iXpy+f45m66XWtqZe0MMHfo/tcIZ/
         ZqXqROvQQ8vQEftsqL1aEW8JYVkQFJJIFD0ExDurzAJ3Gr0LrpjuDiPzBWoIBTq5Drws
         GdROmvPHrQA1yIgZVHs1bsLSGihMzZq5NlHcex8agnaO5BmnR2sUV0UiJ3igrhb6fLdL
         je1cml0NN6rGr6OgTALcX7f/WCbIHYVAdEXEV77vE2Qca9bzYP6Fc1J8SHkprlau9wMA
         eqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613097; x=1686205097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apXwfMR8TTZYSL3Z+8JPoDod3IpeRtMiYvOMKSanre4=;
        b=VXKGogeDnQP06cC7QsqhFmk0BR6T+O1N0YRSDmdTxTq/ySigoCjLFegR0vGuCI2s00
         vB/jcX/XxOjETjuew0NzHpDzOOvMKTfQQcRGV5RnGLr6ZtN7mA7V+x3GFr1NnOaDnBBw
         PeqD4U58fy+491Ibm1x9xb5/PNERExGMSWas9EzEe4SYe81miZLJFUbxwopJh8RvmehJ
         y3VEr5XlHkU/PqTPDrtss8jYfJEvguEo33vdXANiHmoC/LFY8rSD3tu7lMjivvVhwd9k
         DFE5OzplX0O3e93PPmcdVJ1TrdgxAJ8TiaC2L5TJ6GwOwjdtxb0boR+1WtMKxuQzZTf3
         K66Q==
X-Gm-Message-State: AC+VfDwQ9Oe4qtzCenpGWIkYLEryPHMULSg6rq4DcNpe+7QBdrbaQRwJ
        W2f3oRrWyY92I6RdllP0iZfK6w==
X-Google-Smtp-Source: ACHHUZ7Nlm3c3jrfo5Xh8gNy+uRRTtsjIw2hFGSA5pPqL+C2s1Q+FtoCu9NFnwOajuiCY2P17/4IlA==
X-Received: by 2002:a05:6402:352:b0:50b:c804:46c2 with SMTP id r18-20020a056402035200b0050bc80446c2mr10313721edw.23.1683613097444;
        Mon, 08 May 2023 23:18:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402089300b0050bd9d3ddf3sm357264edy.42.2023.05.08.23.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:18:17 -0700 (PDT)
Message-ID: <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org>
Date:   Tue, 9 May 2023 08:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3 audio
 codec
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508113037.137627-5-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 13:30, Paweł Anikiel wrote:
> Add binding for google,chv3-codec device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-codec.yaml     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-codec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,chv3-codec.yaml b/Documentation/devicetree/bindings/sound/google,chv3-codec.yaml
> new file mode 100644
> index 000000000000..5329dc140b1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,chv3-codec.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/google,chv3-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chameleon v3 audio codec
> +
> +maintainers:
> +  - Paweł Anikiel <pan@semihalf.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: google,chv3-codec
> +
> +  "#sound-dai-cells":
> +    const: 0

No supplies? How do you get power?

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

unevaluatedProperties: false, because you might want to use name-prefix.

> +
> +examples:
> +  - |
> +    audio-codec {
> +        compatible = "google,chv3-codec";

Extend the example with dai-cells.

> +    };

Best regards,
Krzysztof

