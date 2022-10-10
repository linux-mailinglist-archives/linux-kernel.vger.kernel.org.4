Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAD5F9D67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiJJLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJJLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:15:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E14DB6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:15:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z18so6922016qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/A6R+RaVI+GYMUHqfwCFuqrzI7fApq42tphdgeMu9w=;
        b=IzKZElHr3hNBLx0hm/iEZcUDMQ8P/NijsVO5z0aXgNyALMc5OgTk1tQcCp0lg7CxD+
         ij0o5NWtvWwvqoIsHtigAn3hjgql9+Ltoc83gr1eK6YhfTWBbNjqeMo0a+zXcy5DImUj
         qjm2+xKo4lgD7PXEZBor1mxBynsOZpHUgKDqTED5SvdBBBTUzB4WbfMOfFjvmnYMzOrQ
         lonzVSVgq+unAwps4QJNgyVzeM8zowvAVAZo89CnsVLTa2R8TgLQn5LDhIVyJ/4yUGwR
         l3oqMpXH6zm6xkSRY+gI50OHmOjM3GkK2ZRGYLS52nxAwWeCH5TGAc1LtSGglNiGKRsN
         5KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/A6R+RaVI+GYMUHqfwCFuqrzI7fApq42tphdgeMu9w=;
        b=2LmtNnvYGDB773Oc85fHZHnOjkHK5Z0arX08vGLOQB8Krjfb21xydWkWTbKpolWN9Y
         g6RxqR3+WswaqXZXkgRQi2OiQDDNQ5cmFxEi0dNh+bi8JGmyIQS2B7P7FKiBtrRnYqbv
         7n4RFk1zpcmTlpCax8FlNhC6zKozY5fjEINBBiEnKCREaj+ljmuLkxZzRQ5JtrdpxSDa
         OQKXNSTEEPMfW1/xa7t64FeVk18aCGeVgTBI/mC0Cp1aZa9F5eGazgot9GPFKisW0EGW
         1xdu0C1FaaB6ZutOuZBYx61Jeid9ZEwFaKZYKV9DO4xFwAzKN27nyLqT7pyLVfoLoxat
         j80w==
X-Gm-Message-State: ACrzQf0+0cd8/cbsC15G9TkAG/b33BgBWtxcm3Tlv3UIrcp3QBIJYbU1
        bU2ejfZGLB+IylPCtpOyljesoQ==
X-Google-Smtp-Source: AMsMyM7o6XnoIw0wUDhjjvlAG6mgUAlZ5OTgVKjitQKpM0nAdGJU7XSZcBOAsYZHvvTETJPLXfdbtQ==
X-Received: by 2002:a05:6214:d8c:b0:4b1:7bfa:1f93 with SMTP id e12-20020a0562140d8c00b004b17bfa1f93mr14530080qve.70.1665400546182;
        Mon, 10 Oct 2022 04:15:46 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006bbc09af9f5sm9727164qko.101.2022.10.10.04.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:15:45 -0700 (PDT)
Message-ID: <0769c6c8-567d-68c0-323a-9aaee1241e13@linaro.org>
Date:   Mon, 10 Oct 2022 07:13:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-6-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007125904.55371-6-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 08:58, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The document currently states a maximum of 1 interrupt, but the DT
> has 2 specified causing a dtbs_check error. Replace the maximum limit
> with a minimum and add per-interrupt descriptions to pass the check.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> index 73ae6e11410b..a3a3f7fb9605 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> @@ -47,7 +47,10 @@ properties:
>  
>    interrupts:
>      description: The interrupt outputs to sysirq.
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: EINT interrupt
> +      - description: EINT event_b interrupt

Is second interrupt really optional or you just wanted to silence the
warning?

Best regards,
Krzysztof

