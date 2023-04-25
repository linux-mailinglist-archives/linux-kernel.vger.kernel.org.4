Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD986EDF32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjDYJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDYJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:28:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EA42103
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:28:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso8231546a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682414915; x=1685006915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jATRlbjXv5J+rEp492wNPd1HzXNCpPqK/mHv12ah7jo=;
        b=U6wrCMhlhs3lK2GT2Q6zJRS74H8+DpdTbKJ7VhiKEkxpAbStuZUYTlajchnT2wyaK5
         S+8v3hlHMsjea0L6q/7bfM5OlzsT+uIb56SwiSqvJUyEKJVx449i9d/reE4qM8HG0kv/
         yNUV8Fk1D9eHz+wEDc6NatiLFSwOI75HZa3P/EkjgQz0qUWoxWLpjtai4AY5SpKHEk2k
         vUdKDkPz/5Z9ZfYm3EfOGw1R2NxNGs0zFABFduFJRiq728amWxtTKBKxVFi/tNbv9XQF
         PyIVwu7zedxxeJV9rVZJFC046JX0x+OM3CRdMd8B9R6oLe6ikNBYV0v3by5tVWO+pETS
         uxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682414915; x=1685006915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jATRlbjXv5J+rEp492wNPd1HzXNCpPqK/mHv12ah7jo=;
        b=VKevLTftZ2drtiafJ3t9rPjy4hkI66HccbBgAt/P33iufJuIAUcjHAd0rtgKHzN2/c
         d87YpzEj4qodhY0ZCiClR40f4Vd9zfKNI1X/KYVc3/rlNzOJ19jWwWMAz3X0Y4vWl7c6
         VhVnI14/OJL3QeQwpOu/AjIIhYf/sXtY8EXnHmq6NR9+OKeZubUZD1k4TH67ACwm8GGJ
         20cSmlSFiWANeEYnY4QEpLblM09pDwv/pnEGfeYqarZAR/adsxvHxLILDO4SDBW49Dv/
         arQnuXG6jS7PjDBCXNkK2Lz6umfvKfhc0cWKB+sN+rvtCr0o6O9cKrXPntBFv7hufAj4
         6VGA==
X-Gm-Message-State: AAQBX9fLtUC9kCUY7x7BcL/FxHyKS7eJz/TjYrCIhZu81lPOfG1yQcKr
        bIWy7CO6LF6w0JqlPl4EwQ7F4w==
X-Google-Smtp-Source: AKy350bpVOT/qCWlTtSfAS77lfzKvlDUH4Ja386ohyjISP/id/ad2bl27gQyQJ1quqMcOLW79J/yPA==
X-Received: by 2002:aa7:d494:0:b0:506:6c4d:3292 with SMTP id b20-20020aa7d494000000b005066c4d3292mr13157772edr.25.1682414914811;
        Tue, 25 Apr 2023 02:28:34 -0700 (PDT)
Received: from [192.168.9.102] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id t1-20020aa7d4c1000000b005066cadcc54sm5486122edr.43.2023.04.25.02.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 02:28:34 -0700 (PDT)
Message-ID: <9e7583be-ad4a-0ccc-08f6-cdf3fa4ed6bd@linaro.org>
Date:   Tue, 25 Apr 2023 11:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/43] dt-bindings: rtc: add DT bindings for Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-8-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424123522.18302-8-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 14:34, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> RTC block used in these SoCs.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/rtc/cirrus,ep93xx-rtc.yaml       | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> new file mode 100644
> index 000000000000..d4774e984e7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cirrus,ep93xx-rtc.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/cirrus,ep93xx-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx Real Time Clock controller
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-rtc

Why only one compatible? What about ep9307 and ep9312? The same question
for your previous patch - timer.

Anyway, if you want to keep it like that, then filename should match
compatible. Or merge it into trivial-rtc like Alexandre suggested.

Best regards,
Krzysztof

