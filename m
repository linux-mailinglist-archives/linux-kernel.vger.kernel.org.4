Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B006E28DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDNRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:00:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA444230
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:00:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so12707654a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681491638; x=1684083638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcVz7CUgiYkhjPKrULZ6Y+Q6MNzNGZWZZ2qZp+hF1YE=;
        b=CR9QspsCWtzKNvqnQ603pmM+6l4HqsfihOi5xyoIaanOI9D3sVSROgtrnxCxF6AvgW
         jAbr1g3t77RA2eMuIzUbIQd6mPR8SZDNu8DoPo13zJ4k4qGZIa4M+SzZmIixtnc+7Xvm
         bhXQMZibQ9v3ll1MzCkGynzn0HI+/8lLWEerhhF7jcV6w/B9nD5zFIvrKzt9NDlX5t9Z
         koRDQPEHGqKbL0nu/hKLJ0J/sYf3LKaaL9wFszBsaUSbUJcXlSaQwWY1h0ixGP0PitcT
         D2SUFetjeyaSW+cCVsX7lq2iMwREmwlTN+Jb9W29Qy09+ZWgNwLNLSvDuHMgZ3kI9DWU
         NVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491638; x=1684083638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcVz7CUgiYkhjPKrULZ6Y+Q6MNzNGZWZZ2qZp+hF1YE=;
        b=gcfUrfYpi1WgHymxcADQk5iY2Zov+gVKBqHdMtSESohWb9K8g2LHHyJ/JRIIW5KKzn
         fvk9OZuBPbAYm6Ek1mJYXMUEcBPbaBd7IU8V7QEB9DHxEi189ilIak/k+Ci1pQowOQY/
         xb5FujRu05uuDBwah1+0Wm/lyi3i589mbBtr221YQA0j1p6HdM3fV08MyucCIFaaUo4D
         i9R38euUSZ+zVTpvONeQKL6sMzJrbXZyLYRgWC/2w6fT9iqCVkyfNwFB/8gDlc2jEmqq
         xb2of0Z2t0CkgfchXBKT4Un4lovKxYpNuWiUIgeIUnyGX/di+F8hhG/RMD3WIbkrPwQM
         ZDig==
X-Gm-Message-State: AAQBX9dS6zNH2j5Oq4hdUN6UxE53HdrsBTmGshlgpqfQcJNX+jrbyRE+
        zJ9eCUlc+2LP/XBDsWn3f0Dlow==
X-Google-Smtp-Source: AKy350ZZUwNYw/gqt4ucoxJgVdnUzPsq4LA6OmDG8VF20owwn2Du/lQmxZOGY6pXpqgffpIDOkScGA==
X-Received: by 2002:a05:6402:653:b0:501:fe46:480b with SMTP id u19-20020a056402065300b00501fe46480bmr6234787edx.15.1681491637856;
        Fri, 14 Apr 2023 10:00:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id i25-20020aa7c719000000b00504ae3a5adfsm2345714edq.2.2023.04.14.10.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:00:37 -0700 (PDT)
Message-ID: <5544de12-396c-29d4-859c-a6e17b2e2de4@linaro.org>
Date:   Fri, 14 Apr 2023 19:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/9] dt-bindings: ASoC: Add chv3-i2s
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-3-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414140203.707729-3-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 16:01, Paweł Anikiel wrote:
> Add binding for chv3-i2s device.

Your subject needs improvements:
1. ASoC goes before bindings
2. You miss some meaningful title of device. "chv3-i2s" can be anything,
so add Google or Google Chameleon. Or use entire compatible.


> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-i2s.yaml       | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
> new file mode 100644
> index 000000000000..6f49cf059ac5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/google,chv3-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chameleon v3 I2S device
> +
> +maintainers:
> +  - Paweł Anikiel <pan@semihalf.com>
> +
> +description: |
> +  I2S device for the Google Chameleon v3. The device handles both RX
> +  and TX using a producer/consumer ring buffer design.
> +
> +properties:
> +  compatible:
> +    const: google,chv3-i2s

Missing blank line.

Is chv3 the name of your SoC? Where are the SoC bindings? What's exactly
the versioning scheme for it (compatibles must be specific, not generic).

> +  reg:
> +    items:
> +      - description: core registers
> +      - description: irq registers

As well...

> +  interrupts:
> +    maxItems: 1
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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2s0: i2s@c0060300 {
> +        compatible = "google,chv3-i2s";
> +        reg = <0xc0060300 0x100>,
> +              <0xc0060f00 0x10>;
> +        interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;

Isn't 0 also a known define?



Best regards,
Krzysztof

