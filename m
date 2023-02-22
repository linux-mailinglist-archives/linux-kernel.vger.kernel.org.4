Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3738A69F10E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBVJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjBVJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:13:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2C1554B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:13:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t13so6918722wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkY3+fA5exA5Ft5hxJp+6msoshzayibJtkPbdEoBQjA=;
        b=iX1FgI4n78XMb3xWIvCi6aaiDmyMYym3I/GjFQMirsg6gjzLdzXb0gScQs9JQb7LXj
         ZSzMvaSkGIBawDHrdVHCUg/e9P79wolm2spyoNWR8kFDawL4RkOVJzIHEEX/WFSWdf/M
         eKEZ/zN+U2JIv+FAjLhVJYN6DtguRSH0DhEwoOk8ZarsZWBjTXacFHggHFNsuDekx8JS
         xbHflz5Vh0obbQZNAyCUM1zzVB8rajon/nqu5nuK81LMh8kI9OMjoyIhHuyfhFjoVGgq
         FaDN+KCKCw78nDJFR+L6guVXQxltuIjAUKA4O3oO7z9LK1h/nrVk9b2GVaWJ0U0FBIHJ
         Bggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkY3+fA5exA5Ft5hxJp+6msoshzayibJtkPbdEoBQjA=;
        b=65MjDcs4c9DCrIC2DaW7M1+/iHuJgtdLR241RCJpniCqteEjY05vwfrvxaD/EowHal
         si9dq0WtXeM131v28mzhwcp4gnfcHT3RmMzk83seg+y3t/n35UC429zEZk93JoL4rvL0
         UNdyKUFYHWUKq3hq7FCvZ5bpXIeTJB7awB6OOSTYolmIG6uKAyLZx0WX4p0M9inK13CU
         bZopliAwDN4XHjb7/YzCP5huPoaDcvw23Fc8pVSPiYfdv3x1FW7SIpJyrTfj0SM52BO2
         xH5nmkI/p3gj+Qv8fWzXZ+D5vToIfWtBzGGIG6x91p8H3pRTieY3c4cam6yvoyZgkF45
         WjNQ==
X-Gm-Message-State: AO0yUKUoI589v26wQJMgzg3KyBBvJNoA0lL5iRUs/E9hMZnf8nDO01fN
        5SP9C9lS16BbknkgPrZshKorBQ==
X-Google-Smtp-Source: AK7set9NdN0jgccs0XCvI84qLhB/QtaTW7Q1bVfwm/0xYU+1PLcj/iDaoh0n6AnhTu7COH1UYeqHIw==
X-Received: by 2002:adf:f70b:0:b0:2c6:67c9:860a with SMTP id r11-20020adff70b000000b002c667c9860amr7122152wrp.44.1677057201532;
        Wed, 22 Feb 2023 01:13:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x4-20020adfdd84000000b002c556a4f1casm6329920wrl.42.2023.02.22.01.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:13:21 -0800 (PST)
Message-ID: <e4c2b711-7953-821b-4281-04e4b40154ea@linaro.org>
Date:   Wed, 22 Feb 2023 10:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 09/19] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-10-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221024645.127922-10-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 03:46, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

I don't know what is happening here as neither this nor other patchset
explains anything. Please stop writing what you do in the patches, but
explain why. What is easy to get.

(...)


> +
> +#define JH7110_SYSCLK_PLL0_OUT			190
> +#define JH7110_SYSCLK_PLL1_OUT			191
> +#define JH7110_SYSCLK_PLL2_OUT			192

NAK. Do not add incorrect bindings just to remove it THE SAME TIME.


Best regards,
Krzysztof

