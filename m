Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C8631BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKUIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiKUIpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:45:34 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F57FC0D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:45:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b9so13723907ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGxw8oU0grRMxGkzDQfX5OPAjWzxKp/cmBJBZE2lbSE=;
        b=nBNkjGO+UfQSSASIQvgHi9XYpH8VG48D+hGvza3RC74eld+iuol1zjzmv/YIgTXprN
         wpZf6NPPJP7RZr2RQKFh30UG773ELwvUOXvPnT2wltkPyadrnnaDbf70NHRKN2CGtu7S
         LamrjPlYS0TNjgpumKMHj+pZOGF4/AZLbY3ZWP5Yh+ZaFMhqf9LIflxKVRI3tTX5Azwp
         m81UfdeKfFrSWc5UQ3Yd5plB+Gkb9LmwAhzk5TgiH9DtZUKhoTmHVgLo9D6bXgXh7LSd
         M48z6SZmMFnJxT4NHjfPYpG6ad+k24KJwnntnhO0URbdFOI+HDDGBBoXCHhqjqJO2C4T
         /qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGxw8oU0grRMxGkzDQfX5OPAjWzxKp/cmBJBZE2lbSE=;
        b=aIvWAXRJ2dGJjJbkinH/fmAru6zqObiUF7WrtQyb0klaR+NYRAuAtxBtuiCiechtGa
         WXvL58SmNO4tflPjuZv3Tj5ig9QASSBj+NSFf0kYEJTRFDIp2r5fqjywCYWlm/deedof
         369VXE1i8HEim02+6cZD0c1zXH+NjWYkAxOKVCxmUlYhViOLYCnUGFx674rCDCwx37Cs
         vPHgyoy0mpqiMvGqT0Sc1SdbyYQMkAIJCgMKKUzat1vaduSBAC+kz5chvsYeoQbFKjER
         ufttU2GStSpNRWFHaPoWi5YGvp2WMYjFxQEqDe3JKGFepZL3ZHXA3w+aaT6MAyNY8/Yk
         qm9A==
X-Gm-Message-State: ANoB5pkEs4i1XJaX+AUeQvqegZQKBjhxIoQSToTYkaKPmPlxrglFpUmy
        rP/w2AjJ79+O4WrSiJKuRg9mJg==
X-Google-Smtp-Source: AA0mqf69rMGUenhpYORaEyxbqbvUN24UYXtECG0wneW+MPaIJDQp7hjHwvwhcIEoBMImVWp9l/bqWw==
X-Received: by 2002:a2e:bc10:0:b0:277:11ec:ff2a with SMTP id b16-20020a2ebc10000000b0027711ecff2amr5745943ljf.163.1669020331540;
        Mon, 21 Nov 2022 00:45:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q5-20020a2e2a05000000b0027765fd616asm1376623ljq.20.2022.11.21.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:45:31 -0800 (PST)
Message-ID: <5ef383a7-aab2-dd4d-ad60-ac631345f38a@linaro.org>
Date:   Mon, 21 Nov 2022 09:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/14] dt-bindings: reset: Add StarFive JH7110 system
 and always-on reset definitions
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-9-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118010627.70576-9-hal.feng@starfivetech.com>
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

On 18/11/2022 02:06, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add resets for the StarFive JH7110 system (SYS) and always-on (AON)
> reset controller.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS                                 |   5 +-
>  include/dt-bindings/reset/starfive-jh7110.h | 154 ++++++++++++++++++++
>  2 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/starfive-jh7110.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e97dac9c0ee4..eeab26f5597c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19614,12 +19614,13 @@ F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
>  F:	drivers/pinctrl/starfive/
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>  
> -STARFIVE JH7100 RESET CONTROLLER DRIVERS
> +STARFIVE RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> +M:	Hal Feng <hal.feng@starfivetech.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:	drivers/reset/starfive/
> -F:	include/dt-bindings/reset/starfive-jh7100.h
> +F:	include/dt-bindings/reset/starfive*
>  
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
> diff --git a/include/dt-bindings/reset/starfive-jh7110.h b/include/dt-bindings/reset/starfive-jh7110.h

Filename based / the same as compatible (or bindings filename).


Best regards,
Krzysztof

