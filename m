Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D36B6B91
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCLU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCLU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:57:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B428D38
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:57:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so11588123edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/BYuAhpT1ImLYYppOi6bO5xFNSIeIPiH8VsW85cixU=;
        b=ud/9lsVqnNiML2sSeRl1HRB7vyDYcqZsOgxGYOopUuAK04W81tMInIMSS61+Y8V4qq
         W3D0fOHng3D1mxN9b8Jjp6bRkaRIMtRfgvz9rLoTSFDptnSkUxTZVZ0k38s7z77mcUIj
         6hbLX40iyXZ1YSMsRwbrpHlAHKNENlVtgcL1haeKV15skD9niLbWRcJxSXJIW4NCED8N
         8ruKKsYc/7c2/uXVZjy2Lyl/NAVQKJ60Gg1Xfs/SjkHrCFGRYQa9IP65UhktpNPBHk+b
         Ei6e0yvsWYTLn6GrWHDiG8u/B0Qwt1jEyQnI0cMSPCyr1QMfwyvI4UJkN0L+1HzLL+bF
         z+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/BYuAhpT1ImLYYppOi6bO5xFNSIeIPiH8VsW85cixU=;
        b=OyrRt6td6pdFq+O2gTagTvNdmFY6G5wEOU9XKpLd4mYMoYhLh+ZH3aYTDsE6JjmnBY
         rTAD09Mz2ioCUO3cWGM6364DEWqJfDUOr9adRbM8NAr2Ynb/WrErsdFXpuW+5nGEZQls
         5pwGPzLLbHQyaeM0GPYgbrzjyJQu+1nlf1tiii8xvqenOsEe03cyonPLY1kQXw7VUd6P
         QFvc2GlziVTPRYdaUJYJkfUYJa+UnlfcS7oJT6rOOu+6rJcQCKm094kfkuQku8dEuHLx
         pTQDYs79QDmGtYgeVY1h9ijzWr7xtOmVWk9XhnyRHVnDXkDCu/PkST+EIhBBpJPf09uM
         yg4Q==
X-Gm-Message-State: AO0yUKXtndMIKr/4gL2/Fch2NJxUcSvOYqrPAWjrhOdyEAxa1YLQ1Wze
        fa4D8wiW+Y4b4hSXe4xV/AUcfw==
X-Google-Smtp-Source: AK7set+zY4WfV4JPUy9KG6Q/TUK4N0pd8ygY5c0mzm1YQfsNtCrzgJ1NegaMkj3Q3Jyp6GpNsvwo3Q==
X-Received: by 2002:a05:6402:383:b0:4ac:bd84:43d8 with SMTP id o3-20020a056402038300b004acbd8443d8mr30431879edv.8.1678654625483;
        Sun, 12 Mar 2023 13:57:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b0092499bb0324sm1430956ejc.12.2023.03.12.13.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:57:05 -0700 (PDT)
Message-ID: <7747168a-1b4a-9c79-d447-020a7de7bd89@linaro.org>
Date:   Sun, 12 Mar 2023 21:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-3-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312004445.15913-3-blarson@amd.com>
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

On 12/03/2023 01:44, Brad Larson wrote:
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Thank you for your patch. There is something to discuss/improve.

>    interrupts:
>      maxItems: 1
> @@ -120,6 +119,27 @@ required:
>    - interrupts
>    - clocks
>  
> +allOf:
> +  - $ref: mmc-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Host controller registers
> +            - description: Elba byte-lane enable register for writes
> +      required:
> +        - resets
> +    else:
> +      properties:
> +        resets: false

I don't think this passed the tests... You disallow resets for everyone
else. Why? Drop this line.

> +        reg:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

