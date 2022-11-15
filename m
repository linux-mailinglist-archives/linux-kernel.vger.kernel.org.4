Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBD62951D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKOKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiKOJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:59:59 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DB24083
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:59:53 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u11so16768994ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=we5icLF5qMbtdyi+O3fAzjYqkzl4E8jlaLkt16W+v8Y=;
        b=UIzFfmDJK39st7JSIT5v2XYzdCLguFhqQa4GDHWXZgztsgu4AnwMAMhxqvyiTZCKJA
         9Pddz+uMl5M3gmWWvkAQmHgbGk4v6fzwlMvb1HhuVnJWLRWi3ePD8RtR4hMHXNs0x/Q/
         g936CDTJp/vP0E4a/DXDiHvGDC52Ji6EY7CirgMQ61VDvrgWTSIXM9BS8KLPMe7ZFYnX
         AhZVmGK13uu2ppQzD9HJEodFV6Ve8+rbPRBSqr/8vtpfQTdiDvBuFQvJpB3slutHGL8+
         OYo3dF3L/EIvpNHyKii1kP7RH423eHgJhz+EVBygoO+5bfHkMiGgV7FPwRASQeWB5gN2
         c3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we5icLF5qMbtdyi+O3fAzjYqkzl4E8jlaLkt16W+v8Y=;
        b=EVRAzPVAYMFR0JJKkYLbrmdODw+l46E3r6SpwuN2XesaZmuy34T5TsTjO/KCBH8nxr
         el+17Opai8/UpkxKRBrmFMusdXHG10FJYeAL8SPNZURqgAiofDeKQlMdWAqiX18npRkq
         8+dCEafdlH7eMF6VZETQkG6BE/x5NaSCtjSiLA6N6Jn22ClZlNVaw+cJt9+RlGJ4uWxZ
         JgxXIBlS3W6NFR9yqyZ30/yYgFJoMDyuKDjUt4vXsAMhLx5nFJSVcrwLonYoZw+vn4y2
         OdulDDQTI90IDIy6dvitHNpgN4RUn21acDdrC4Bj0IZRV375KtZraFb6tMBsYU0ml6uU
         pdBg==
X-Gm-Message-State: ANoB5pkPi3Kxi69h7ZUVtkKXWpGM3QYIOSMMFIELBWz0BV0guyjGRaA3
        WpHaQmbHv64RPBs/e10bFsO6/A==
X-Google-Smtp-Source: AA0mqf5kKzTZwy3o3Cf4h9p/7Ric73X3MaF+6pxIjfDZhcnddYTepNSi9exl7I5gdGM8r5bEH3I+iA==
X-Received: by 2002:a2e:7217:0:b0:26d:fe34:6dc0 with SMTP id n23-20020a2e7217000000b0026dfe346dc0mr6088126ljc.477.1668506392241;
        Tue, 15 Nov 2022 01:59:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v4-20020a2ea604000000b0027713ef5360sm2434920ljp.71.2022.11.15.01.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:59:51 -0800 (PST)
Message-ID: <d88f85af-0de3-ab2a-b507-58ac3f8c5518@linaro.org>
Date:   Tue, 15 Nov 2022 10:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add BIQU CB1
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Andrew Lunn <andrew@lunn.ch>,
        Conley Lee <conleylee@foxmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221114214452.1993744-1-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114214452.1993744-1-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 22:44, Martin Botka wrote:
> Add a name & compatible for BIQU CB1
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add compatible and name to dt-bindings
> Changes in V3:
> None
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 3ad1cd50e3fe..d886924023f5 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -151,6 +151,11 @@ properties:
>            - const: roofull,beelink-x2
>            - const: allwinner,sun8i-h3
>  
> +      - description: Biqu CB1
> +        items:
> +          - const: biqu,cb1

Undocumented vendor prefix. Did you run checkpatch?

Best regards,
Krzysztof

