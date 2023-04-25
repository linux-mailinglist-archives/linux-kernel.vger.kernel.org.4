Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0796EDF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjDYJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjDYJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:26:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA643A85
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:26:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f7a0818aeso823450866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682414794; x=1685006794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pH6FPHWIW0XS7+bwLbI0s6luSIIgHdAHfI9/lmBodQ=;
        b=b+W7nr7Ees1AVpg7PU/ykcUnpfaAUa90/zCyHPwmsWTxr8zcnt7h88JevfHwn0nz+e
         68/L73ed1+eup81dsY56NzUq9Wk1SaKPqFO+tn0rgGvWtiN6FrgBjfHyJeh9ALbI8C36
         D9DhEHer+jJoLFXOgmrKew2fhXU8gY4JveVP4wRQC0Ku5fZE7mgrSdI493HAVWm13mMh
         qECsyA5cfF6tBOjcv4f2Bjff0bzpdt2GvWOXlK5gSxndhU6Lrb0cb9fTo+2VdIS+HQad
         L7GOnDYpxxS7A/HofdHXHhal+GG2Lp0Q2K/gHx/G0wXOo6DI2XpQoFGys3iwhidsgHYi
         T6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682414794; x=1685006794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pH6FPHWIW0XS7+bwLbI0s6luSIIgHdAHfI9/lmBodQ=;
        b=KNQVXYNBJa8kGkhVaQjgPAEEAbE5/5VD/cjgcV8mytqgE1voenG9Q138oc2H44ZCKa
         4G+9nRkWQrWxU4zLN7gtf56vhMIhKsOdHIo46sp6rP1kzm+fnVYlbwP4r5AgaegDASDD
         qFBowT5UcT0mYj/mZCzZGME2Sma4TESmLtOPo+gX3Raq2zUM/Dhp1AxgoBclRV5IdGc+
         4nav+yrumUUoyUUHBg5DWQ+KT3dSQ8r+v1Mzg1Jkja5Us6wAFq765yeYAESnvQZvKHmo
         2XSYy3sF2P4jJcuuPpedepaTv5Zf4DnQ45yzkEU8AjivjkEODUHCM3VhC/VahM89PIbc
         /SxA==
X-Gm-Message-State: AAQBX9er0PDgzs/PRVR8llu6lWJmfk6ZApXCjLRODEXSkSDYWsLXNlYU
        YazPPk3Tv/pp3ktTC0uEmjVcnA==
X-Google-Smtp-Source: AKy350aTn9VOm04WoLNuxRYSs5Ax06mp+atUV527FkgipMfk40qFAa74De7KAYWvl3ZPG93vgYoDjw==
X-Received: by 2002:a17:906:3550:b0:957:12b6:8918 with SMTP id s16-20020a170906355000b0095712b68918mr12541308eja.75.1682414794270;
        Tue, 25 Apr 2023 02:26:34 -0700 (PDT)
Received: from [192.168.9.102] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id bh20-20020a170906a0d400b0094fbb76f49esm6631925ejb.17.2023.04.25.02.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 02:26:33 -0700 (PDT)
Message-ID: <0a6a8fe3-fa21-a017-de2c-41039a72af11@linaro.org>
Date:   Tue, 25 Apr 2023 11:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/43] dt-bindings: timers: add DT bindings for Cirrus
 EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-6-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424123522.18302-6-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 14:34, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> timer block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Subject: drop second/last, redundant "DT bindings for". The
"dt-bindings" prefix is already stating that these are bindings. In all
patches.

> ---
> 
> Notes:
>     Arnd Bergmann:
>     - replaced ep93xx wildcard with ep9301
> 
>  .../bindings/timer/cirrus,ep93xx-timer.yaml   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
> new file mode 100644
> index 000000000000..ce8b8a5cb90a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/cirrus,ep93xx-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx timers bindings

Drop "bindings". In all patches.
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: cirrus,ep9301-timer
> +

With two fixes above:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

