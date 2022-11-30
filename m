Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813A563D966
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiK3PZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiK3PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:25:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A17E439
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:24:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so27505024lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0BCcjLSSdMLqYLWjpCC6aMjjhEkfHkguLFqsvsQY2M=;
        b=wJEYzJPvPNQ+WbLH5BwUtMd05wUMgMjQWoAv4Jerr2yHAPrNp4ZusglHKI/ze3DxYt
         uRdq00ofY59stTD86gAEsOM0DRIOMhFYFyuMfhXYR2pIVJfb7cGMaIrBz4nVp/u1yUlU
         8ohuAcGWqkYc7fMy4yjb3l/uo38F6JEPfDtn5b8Ypmvn4KnkVM6kQ+89ELgZ62yxiqLr
         6EogoyS8H7IRZga3ZYSFnBQYgO8RkyqPrjjazvgEhPpxZWL7qozn1TSn+hPf4lt3PwZU
         TjWa4mIB6vYdfBa1ZQRTfPj6wpuC1hQ36q4VuJs9vchihf8CUgEpww2Ect3ngxtgVHHL
         VTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0BCcjLSSdMLqYLWjpCC6aMjjhEkfHkguLFqsvsQY2M=;
        b=relAxTZ2/3EclLjST/1WIAj4mLdH2oni+cPmV2KYe+bWXmFZEDDh7fwOZi+0pXeVbB
         M7QNkDVgRkrA59afNqseHrMp/t2Yp+DtfBjBqWwANDS2y0XEKyVHhpOykDOCfmb0gbia
         zFH7M+bk1xetS5vYAlJUm6CSvgnOtON+CLdEELjh4PT91yEW+Aw+rijAeQziby9GAFJN
         ObghqaQw2eVtQPG8tsOcO7UDSHHJlRtotrwWYX/y2QhStcwFCk+PdIjLCeC9Z59VMKEz
         sJZyEEE+gqKGPlomontwtSxm41zLTuCPCR/1RQS/IDeO1roSJREm46E2ll3YGi4cvjpc
         9qOQ==
X-Gm-Message-State: ANoB5ple7Ew/2lLdWkiKY8+2y/yE+59hZFNhrvk06824qSXAUt5KqK8a
        ZdzJ+ZLmvGppGipI7L5EVEJEAQ==
X-Google-Smtp-Source: AA0mqf4bPQ8Fltgiqp+JUq+K+K68Yb7F2StiWajMAq5Uz7JQnjaz8QbZr0Bb2QSbmHgNT0hgnKgMLw==
X-Received: by 2002:a05:6512:3e2a:b0:4ab:534b:1b2c with SMTP id i42-20020a0565123e2a00b004ab534b1b2cmr15709904lfv.426.1669821897312;
        Wed, 30 Nov 2022 07:24:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b00492e5d31201sm297593lfs.7.2022.11.30.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:24:56 -0800 (PST)
Message-ID: <cb76a56f-6492-5209-be30-e31aa075ce8e@linaro.org>
Date:   Wed, 30 Nov 2022 16:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/8] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
 <ce1b5859-4ca6-6d2d-19bc-e33e48165093@linaro.org>
 <adee56c4-6932-9272-3319-e003ab8413b5@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <adee56c4-6932-9272-3319-e003ab8413b5@socionext.com>
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

On 30/11/2022 09:59, Kunihiko Hayashi wrote:
>>> +maintainers:
>>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> +
>>> +description: |+
>>> +  System controller implemented on Socionext UniPhier SoCs has multiple
>>> +  functions such as clock control, reset control, internal watchdog
>>> timer,
>>> +  thermal management, and so on.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - socionext,uniphier-ld4-sysctrl
>>> +          - socionext,uniphier-pro4-sysctrl
>>> +          - socionext,uniphier-pro5-sysctrl
>>> +          - socionext,uniphier-pxs2-sysctrl
>>> +          - socionext,uniphier-ld6b-sysctrl
>>> +          - socionext,uniphier-sld8-sysctrl
>>> +          - socionext,uniphier-ld11-sysctrl
>>> +          - socionext,uniphier-ld20-sysctrl
>>> +          - socionext,uniphier-pxs3-sysctrl
>>> +          - socionext,uniphier-nx1-sysctrl
>>
>> All of them can have children or only some?
> 
> In case of this system controller,
> all SoCs has clock-controller, reset-controller and watchdog.
> 
> However, some SoCs don't have thermal-sensor and
> their register addresses are reserved.

OK

> 
>>> +          - socionext,uniphier-sysctrl

What about this one? What SoC is this? Looks too generic.


Best regards,
Krzysztof

