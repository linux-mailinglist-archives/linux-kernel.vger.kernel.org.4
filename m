Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BA646A18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLHIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:06:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5994C5477A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:06:04 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h10so708368ljk.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7u/88vG7XZa4vAH6mLsoYNV0uw6Ahu+wcvp0KHUwzqw=;
        b=UGr/szUAygo3dmWdI1Txj6LLFnJFbH+38MiH5i7VvWniYX4Pc/wHwY5JejfdcejHmk
         BXfR350df2uUN0YH94Pvv9JLKc3TvidwVk+KweAVRaKmNr72ni3Ms69X7Yr208lZYtLP
         phecYdFh+UApy78dsfJF4VcyVFMCfw/7VAhF0F15VoD+2173b8WtbM5IX2Ypcebd9U7C
         /pFG5s6BnQiUOUHIrkPjdvI7FBoYVq37eHeQBirq2UaPvaADYaSQHf3G8O/NzZW/ykiB
         ip3UNz/1jPmUUUuWjpODBDk4BTQ3dTNCWThY6xSAmPZYhdST1yBWNs28zK58i33Vk+Qu
         +/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7u/88vG7XZa4vAH6mLsoYNV0uw6Ahu+wcvp0KHUwzqw=;
        b=idTYduTBHaIULOmTXr5n+l1+JX/YquMK3Dl5kiAcfDMzS5GrZZLJyNvlqeZeysC4yE
         bdgOYZ0/DKgF3+zsf0Y+F62b2KDmQd0Fufy6kdEalo3JCb/55ZKnxjlc1fZu36BaNslC
         AepmZDH+0WvVV4FJZPpyDtv7fe4Z55xAOjRnklKekgX1OmdUWpCSojvPWhwgYHcVTJtU
         nS9Hu7XSGJVbn90Sqn5xV1vbuG2h3LykchrLdL+7LOSMLrApFzVIEV+RcUPwdIvfgXJI
         t2j7fV5YEXIvWirWFEQObKLL8TR0NUgDh85ez0ejAL9nZcGVLdAqu5qoJqLO0SEPDeXE
         9lEQ==
X-Gm-Message-State: ANoB5pnwu3WNFbo3HqAmi7Wp+2HSsqwCVN9aORbt0QhcMwH2fufy9ohP
        tMtoYUjMmXb060XLUEst/943Jagz1R6XS/p0xQg=
X-Google-Smtp-Source: AA0mqf7Q2WP7HWGn4EgBpD6vXpK9CyXpetJ7Brto08p49kkV7N2jF7lx1m8uRoulMebxY7Ceozo4Kw==
X-Received: by 2002:a05:651c:883:b0:277:34b:1bfe with SMTP id d3-20020a05651c088300b00277034b1bfemr29992013ljq.8.1670486762678;
        Thu, 08 Dec 2022 00:06:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512214c00b004a45edc1de2sm3213990lfr.239.2022.12.08.00.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:06:02 -0800 (PST)
Message-ID: <c2782196-6dae-522a-50d5-5e5223e66e56@linaro.org>
Date:   Thu, 8 Dec 2022 09:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: Fix node descriptions in
 uniphier-clock example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-2-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 06:53, Kunihiko Hayashi wrote:
> Prior to adding dt-bindings for SoC-dependent controllers, rename the
> clock nodes their parent nodes to the generic names in the example.
> 
> And also fix the missing compatible string.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../clock/socionext,uniphier-clock.yaml       | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> index 9a0cc7341630..672450a1ecda 100644
> --- a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> @@ -61,11 +61,12 @@ required:
>  
>  examples:
>    - |
> -    sysctrl@61840000 {
> -        compatible = "socionext,uniphier-sysctrl", "simple-mfd", "syscon";
> +    syscon@61840000 {
> +        compatible = "socionext,uniphier-ld11-sysctrl",
> +                     "simple-mfd", "syscon";
>          reg = <0x61840000 0x4000>;
>  
> -        clock {
> +        clock-controller {
>              compatible = "socionext,uniphier-ld11-clock";
>              #clock-cells = <1>;
>          };
> @@ -74,11 +75,12 @@ examples:
>      };
>  
>    - |
> -    mioctrl@59810000 {
> -        compatible = "socionext,uniphier-mioctrl", "simple-mfd", "syscon";
> +    syscon@59810000 {
> +        compatible = "socionext,uniphier-ld11-mioctrl",
> +                     "simple-mfd", "syscon";
>          reg = <0x59810000 0x800>;
>  
> -        clock {
> +        clock-controller {
>              compatible = "socionext,uniphier-ld11-mio-clock";
>              #clock-cells = <1>;
>          };
> @@ -87,11 +89,12 @@ examples:
>      };
>  
>    - |
> -    perictrl@59820000 {
> -        compatible = "socionext,uniphier-perictrl", "simple-mfd", "syscon";
> +    syscon@59820000 {
> +        compatible = "socionext,uniphier-ld11-perictrl",
> +                     "simple-mfd", "syscon";
>          reg = <0x59820000 0x200>;
>  
> -        clock {

These are all three same examples (no differences except compatibles),
so you can as well keep only one. You can also skip parent node,
otherwise you might keep getting warnings for this schema. The parent is
not that relevant here and its bindings (e.g.
socionext,uniphier-sysctrl.yaml) should include complete example -
parent with all the children.

Best regards,
Krzysztof

