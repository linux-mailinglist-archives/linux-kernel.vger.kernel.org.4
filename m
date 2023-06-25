Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698AF73D1DA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFYPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:48:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CA10E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:48:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so683966a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687708100; x=1690300100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FHDF4JQDFMpiAmZ5U0BX7uerXMnjpIEAdOE5eTh2lk=;
        b=XVy9W9Mnb1ZxcR/oXJXA71VriIHqlMWClr3UF6wVHCFWDJ6+GJfbuBGhQm0TSbRvVd
         h3ji5fmc0B/ITHKfFG8tlFVJMgtM6Tt4QubZ4voOAhr1nUDLb8PDDtpltsN2ZaHULQ6P
         KRozrgPs5asTDjdSbVsq7G5oxv6STdAtrHzT9CfsLOUQquVxIcBSCER8hQIHkQBdI+WB
         ITUFPyPf9AO0VaOPz53HOGoswazzrF5DUczJkp3p4oRltlX2E4uC9ahoX/zBF5MYFDJM
         NHJsZKMj0jCnTSr4fr4nMKdvnk4DXw9NhFYVB+tKqp5bLMxb9T8koVhSh9OgXz4XM951
         eGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687708100; x=1690300100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FHDF4JQDFMpiAmZ5U0BX7uerXMnjpIEAdOE5eTh2lk=;
        b=Le0NJSPjfx28fg/IqzLoAb96pSN3Lkj3FDPSLPHHtpYDdxO7FaI1fgu8RyJ9IPS2Tf
         9CgiPyUPFARBTZIfFT1hM79/TZRpq/I4o5/lp7BXxb7MkTi9rnl5mdJCUo9lbVFSqyn8
         gSe7yWjDmipUg8RNqC5/7ArFgFzLyZvhRMRUJWxgwctBeD3yxRhv5R5ew1iBfIR/vKlb
         rBK2vlyM5taS1jdDq0dZscX6giJGCWsljnChnK0pVUP4IHQW6ciWwe85zzuMMIK5brAz
         lDM+lWIR5XIhtDhqf8izCugxdqg4mlxjeGIPSFTzVEdDLsQw169ManICHgJ43qQ40c7q
         ECzA==
X-Gm-Message-State: AC+VfDwas08zKlt6jZPYRF7qwbkig9GPfF31vyj2BB6nX6fb4LXvTFee
        lAhDfDHhRxDkp759erkT5do0rw==
X-Google-Smtp-Source: ACHHUZ5dc/5i/DnUe0Qkl576dckEiI0C7tQ2Yw3h0oT4Y8zmPyjT546jAOEXeRG8O6KYrv56RAHLfw==
X-Received: by 2002:a05:6402:1b0e:b0:514:9df0:e3f3 with SMTP id by14-20020a0564021b0e00b005149df0e3f3mr20374649edb.0.1687708099754;
        Sun, 25 Jun 2023 08:48:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b0051d9246f963sm1007326edy.9.2023.06.25.08.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 08:48:19 -0700 (PDT)
Message-ID: <43b5fd53-e67a-7d51-3f14-ecd7189ccd7e@linaro.org>
Date:   Sun, 25 Jun 2023 17:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] dt-bindings: pps: pps-gpio: introduce pulse-width
 properties
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, giometti@enneenne.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com
References: <20230625142134.33690-1-farbere@amazon.com>
 <20230625142134.33690-5-farbere@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230625142134.33690-5-farbere@amazon.com>
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

On 25/06/2023 16:21, Eliav Farber wrote:
> Add two new optional properties to calculate PPS pulse-width in nano
> seconds:
>  - assert-pulse-width
>  - clear-pulse-width
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 6 ++++++

No, no, one new property could sneak in, but three are a no go. DT schema.

>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> index 8d588e38c44e..9ecfd5fb3b63 100644
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> @@ -18,6 +18,12 @@ Optional properties:
>                   opposite of the assert edge (if assert is rising-edge then
>                   clear is falling-edge and if assert is falling-edge then
>                   clear is rising-edge).
> +- assert-pulse-width: when present, assert pulse width will be calculated in
> +                      nano seconds.
> +                      It should be enabled only if 'capture-clear' is enabled.
> +- clear-pulse-width: when present, clear pulse width will be calculated in
> +                     nano seconds.
> +                     It should be enabled only if 'capture-clear' is enabled.


I don't understand the description. Property name suggests there is some
units (so you need to use common property unit suffix), but description
suggests that you change the units to nanoseconds. That's very confusing.

Best regards,
Krzysztof

