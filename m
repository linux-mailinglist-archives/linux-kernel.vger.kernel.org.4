Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B825BF9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiIUIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIUIuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:50:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01B1D312
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:49:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i26so7991995lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4QwLoqXQJIVld16rvncEZy/cs6i90XoomSteD4cxMO8=;
        b=mmA3z54EmS9Skp+HiQqXq+0GsdbMOR3L15dcNT+vmdRzLjTab06tKhYMKojzA5otmD
         wPYdQDeDFBCkFDbFMC0L+EQZ/H9oUnTQBhGoiw9kKttL99ZDXoZC/5ZQu4KH+OL5+m8r
         WX/KaX7ZR1S2xVsHSzIegA9hef/2AE9eMYNuYsbSGDcbIaIAhHKUngCjVon3L9ergEx1
         gwwJSHT2HM9ys6ecakn72MSoXO3Fbm0unwrjmcYMwmkeFHAzANEXg8oX1ahB7Rea6+9K
         w6HGvfS1u48WG7HRe/78knJLv0RX1YazWdI5WNhwUUW4OMagCuO2gdvdPxOs/jy1l82u
         e1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4QwLoqXQJIVld16rvncEZy/cs6i90XoomSteD4cxMO8=;
        b=jBYQT9g6gTC31Oix0nhUDXcMXY+QAh4eW2yKHVmaND+8FeV+0195qqI7+yVQbMzyXg
         WJ55+Tc5b9mPrY/yqYjnpDwM065T4ookCIj7lIFnaFFADSsehmy3DI1dvLX2+aXoW8yU
         Or4OdXP2DiCpwUE4EJH2al/kvUao0Fnaf28joCwcKL49LIgCUb1UOEFgUbjVxcLW4SF+
         kgmBsfkml302PnDZTkCAgDAbiJPxyhryy6AFdW7olMRtWSC6Ia0zTh6VchC/hv/1fGG+
         L6+svoZIgTbEiS+/jLS54wdFZBPYFU3zqm5Nhh9knusEO8x+PodoiCp5c8yFfFGWF/p0
         +KCw==
X-Gm-Message-State: ACrzQf1vpnlK5YaR/uWoRqKpT+e5h9UKeOJXTd41TMNqygGa8dDme4iP
        rr3nu0Wih/mn/BtgzyCTxFjHqw==
X-Google-Smtp-Source: AMsMyM4TDna3pUYqRiIQMis25vK3jwOSFPr7sPWVimAB7AulEcG6GpaexLEYrqZQjhq/n6D6ilkkIg==
X-Received: by 2002:a19:5f4f:0:b0:49f:543b:190e with SMTP id a15-20020a195f4f000000b0049f543b190emr8894544lfj.547.1663750182237;
        Wed, 21 Sep 2022 01:49:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e1513000000b002618e5c2664sm326954ljd.103.2022.09.21.01.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:49:41 -0700 (PDT)
Message-ID: <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
Date:   Wed, 21 Sep 2022 10:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 09:46, Geert Uytterhoeven wrote:
>         Hi Rob, Krzysztof,
> 
> This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> suggested to bring it up with you.

I guess you also need SoC maintainers as well (+Cc Arnd and Olof). :)

> 
> The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
> cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
> To avoid duplication, we would like to have:
>   - <riscv-soc>.dtsi includes <base-soc>.dtsi,
>   - <arm-soc>.dtsi includes <base-soc>.dtsi.
> 
> Unfortunately RISC-V and ARM typically use different types of interrupt
> controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
> possibly using different interrupt numbers.  Hence the interrupt-parent
> and interrupts{-extended} properties should be different, too.
> 
> Possible solutions[1]:
>   1. interrupt-map
> 
>   2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
>      <base-soc>.dtsi, with
>        - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
>        - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
>      Note that the cpp/dtc combo does not support arithmetic, so even
>      the simple case where nr = 32 + na cannot be simplified.

What do you mean? Macros support string concatenation and simple
arithmetic like adding numbers. I just tested it.

> 
>   3. Wrap inside RISCV() and ARM() macros, e.g.:
> 
>         RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
>         ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
> 
>      Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
>      to express the same operation using plain ARM or ARM Thumb
>      instructions.
> 
> Personally, I'm leaning towards the third solution, as it is the most
> flexible, and allows us to extend to more than 2 interrupt controllers.
> 
> Note that this is actually not a new issue.  For years, ARM SoCs have
> existed with multiple types of cores on the same die, using Cortex-A
> cores for the application, and Cortex-R/SuperH/V850/... cores for
> real-time and/or baseband operation.  So far this wasn't an issue, as
> only the Cortex-A cores ran Linux, and we ignored the other cores (and
> the related interrupt controllers and hierarchy) in DT.
> 
> What do you think?
> Thanks for your comments!


If it is doable with a macro (option 2), I would vote for this. Assuming
of course that the interrupts differ only by GIC_SPI/PPI and base
number. I guess this should be the case if this is the same SoC?

Best regards,
Krzysztof

