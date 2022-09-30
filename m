Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92CE5F09C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiI3LQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiI3LQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:16:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA69248FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:59:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t16so4410793ljh.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4hzPE9oTqY0sNAFbbyjx8cS0M/EZm+X3v2vFWwcKWqU=;
        b=vHOu28gZ/slIidoNmyLNGLt7JE69UEMTGNGAWTKkHaLClmTVqAidQOmwKnur/460Px
         ViPf7eVqpKBG654mWEePVJGSUuM6vdQwL2NOQr9ZrySEs1hvEkkLw20ev0TNyWv1qUaa
         ipmWGB2IhttXt5NrkcgQC5BI67lAOLe5xRjxpCQGJaPt9xYUpX9SQbZntCYlbE+WIvCX
         JgfXC4DChU4hOlKIaZBYBgb2/EaQ538yLHmKLYDYpAxiiDB79+ax0cW+UnPIamoiOWub
         6PZgIJkw0dIXycpSq2e4gIeuhcbAegWj8Vbu8K4i2U3MfmgIh89THvGV15ZinYhFop1V
         lyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4hzPE9oTqY0sNAFbbyjx8cS0M/EZm+X3v2vFWwcKWqU=;
        b=dsaGYEHKsPfEi2DNyTq/LEG7y8jtoI/o6jaTMo11c/chsJNiVXPh2H3KP2WDaFnRbW
         KhvdMaaLuFUWA9VKU53Hux5QLKvC+NYeI27J7yHgXxyj5xaYEl0sVd/aLGXVTYdMWW4x
         TsnystKZIKJU1DPiFvjyY/5mrGt12c2sZPYUAXP/yerhdfNwEaxByYhFNlQGNf7DJHp6
         JzYLdlJPziT/603hVJGAgCmuZ1hOTcbe4eC0QaKy3rk50f4zf7pP8u9SZX+vcNPAEHsc
         yF7OuxjemNeWYEFDZTpGwF9YtvbQWTj9Sqf+evOieltnkj89LulJeg3PQJMtamefSwdW
         XqKg==
X-Gm-Message-State: ACrzQf3EfZCBalhVfF9NYYY5HxEHy5caiWwRiizAWbc1DKVWYDjmOFVZ
        YZ2EiImppUV73XLw3pDjg9TnkQ==
X-Google-Smtp-Source: AMsMyM7/M35hE/mV3r6usdYHywAzNP/Z+T+a0YioD4qkM0GJQ/nt2HYQISleBq7PKvTlVL9mhfKOuQ==
X-Received: by 2002:a2e:2e0b:0:b0:26b:f760:1c51 with SMTP id u11-20020a2e2e0b000000b0026bf7601c51mr2670898lju.494.1664535543106;
        Fri, 30 Sep 2022 03:59:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d10-20020ac2544a000000b00492f45cbbfcsm250893lfn.302.2022.09.30.03.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 03:59:02 -0700 (PDT)
Message-ID: <ff493398-7786-db0d-ae94-b52207e2a56c@linaro.org>
Date:   Fri, 30 Sep 2022 12:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 20/30] dt-bindings: clock: Add
 starfive,jh7110-clkgen-aon bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 07:56, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the always-on clock generator on the JH7110
> RISC-V SoC by StarFive Technology Ltd.
> 

(...)

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110-sys.h>
> +
> +    aoncrg: clock-controller@17000000 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

