Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15763C02D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiK2MgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiK2MgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:36:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351B5E9E8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:36:02 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z24so16647156ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LQJ+cCc9NOa8jrY4H9ep7uK2jfhtra5Brk7j5Z7ahw=;
        b=rlOXqhcK6HcETIcR46fo7JqvEoGuf+bvwebPal7lLKieOwvwnhXNtinRImZDGZn2gn
         THV9vcrmuM7pkSZvLlZ9yj0io2FwwgTyaP5QE6wLb66SV365f5IBEqRC24hP6hnKxve2
         W0+vS1k5fiXuzcNUwH5kzDW9XyGWSj51UzaRqA4xTw4h3SPcE8+ctwxyE57YkGKRThFX
         rlEMDMMg4MQfW05pK1G1tl4V8AuRjVA8qXGOyLfFaAdyuh0V8dOywMefcdRbo+S7XCe3
         wn4PGsi8FIiXAIwAAw8JylnN2I3arCnfMErQcwqQMYlkXftmlsw0nb63gYl5wJxFGSnI
         hRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LQJ+cCc9NOa8jrY4H9ep7uK2jfhtra5Brk7j5Z7ahw=;
        b=glebPMCXoUaXKEBy16bWpdY4xNQOFhQdRHjkU4sy9h2SCrtFHaX85TzbdrnFjn2gI8
         HZfTJRJcWGKugjZWmusyDeDMfSzN6tjgtSQEqhmTwzjoX+PqGVIcBQjAmJBcdEmsD4uj
         yXRJhVBxo3HAPuesFiTxw9qpMHtyGpO6uLuQWWuNHPELIaefDeVjZK+aZ51ZjuWZLKKe
         E0lPb/3Df+5x5tEfLBxs1nsx6HcZStTCbDHi+vwyLABZkHfNBxC8Iwh84fkFGywhykLN
         ylOh+1U3sd60Zf1TdOJ8yWPEuymFa7wy4I0kjCKtIwfBVqYCPHo6lH/+gS7Hx98yKxrO
         Z89g==
X-Gm-Message-State: ANoB5pmz6JtDHGpeKd0ZG22UNeFjlhvP78gPueATW0gcoTnRg3qWa0LC
        iViaGL1COiSkqmebauw0cdmK0A==
X-Google-Smtp-Source: AA0mqf4Wzd+tkSR0h0HrNP/m2vp/ZfQGB+dbeW5OT0nfwAntTmPs+0PYKNNHM76ZgEDCmFPOD5IEIA==
X-Received: by 2002:a2e:2c0e:0:b0:279:8d29:193c with SMTP id s14-20020a2e2c0e000000b002798d29193cmr7855968ljs.167.1669725361364;
        Tue, 29 Nov 2022 04:36:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b0026de0c8098csm1511874ljq.26.2022.11.29.04.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:36:00 -0800 (PST)
Message-ID: <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
Date:   Tue, 29 Nov 2022 13:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less
 confusing
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122111124.6828-3-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 12:11, Christoph Niedermaier wrote:
> The current comment on wakeup-source is a bit confusing, because it isn't
> clear at first sight which property is actually deprecated.
> Change the comment to one that is less confusing.

It's still confusing - you mention some non-existing property. I don't
think it's worth to touch it. If you insist, drop entire comment...

> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 802e3ca8be4d..a921442c6c1d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -293,7 +293,7 @@ properties:
>      description:
>        SDIO only. Preserves card power during a suspend/resume cycle.
>  
> -  # Deprecated: enable-sdio-wakeup
> +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

Best regards,
Krzysztof

