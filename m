Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB168ECCB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBHK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBHK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:27:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DEC46084
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:27:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1090614wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNlwtYEZjLANMp/AP7c3hByeovMdMuVM3EFC+uWhNo4=;
        b=y25OptXtltvh6MB4sqwW9x1mc3nKSfDjytjnTyqQno0VuI8wq4t3VafZ4xPhLLbU5m
         Am83uM3NAbFbil1fiCUKtIXR/Sz4jgH6maPn2yp0k02VxemxIF2xDEhbKNWmWYzpe6tU
         Vlg3tpvEyhgFGR1pgu8NiBGrGUykScOKVZwxIv2jTJXZEhSFoNWOvLt9Szg2JmU+V7Jm
         zoZhdMQfSPRFvwPfkoWSyp5U0Mob504FwdojuNfSPT+rdm3f8ysj0hLhTeJ2Zagk5SDS
         PFKwfeluD/nLAnyBbG/viwLb1ldCFZqeWAuXtMuBKAJQJUb3k4/gPUbXkCGG/287CYzO
         BzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNlwtYEZjLANMp/AP7c3hByeovMdMuVM3EFC+uWhNo4=;
        b=ZLqlW3QdhrOKkLLfc5p+U+y0gr+ZvEA6FRcE4RRbahjTULmABQJT4SIgANRveUrm1e
         vcHj2aQWj9ujd107gKehil4Yn38fLInfuRcq3QVWMEdhQnPVKtTqgJ15sVjTNwUqtEiB
         FEbgNZP8rRyT2/RfxfGnXum7upCgCBggErtbIYIak18gJyFnJnEZteeezwdSC5VjfKAE
         8Rg2YRLyxbJ9epHWmBDI6FesaIRgzblhxQ05o+QDRk+3gx5Dbf/R6BSEBa4RvaZgjtJ5
         nrKLD+quDiEAvxl43BLM9i9vIufKIdJPshfW8ztELtYAQL4zMcCOXR7XqYdOQulF5cul
         o7Gw==
X-Gm-Message-State: AO0yUKU89Kx+TFgUGzXDJQRpI1scxyRljbl5QGu7hvT9GjwGUZ3t6HRr
        4fq2RD5l1pEGlT3wY5WbA14s2g==
X-Google-Smtp-Source: AK7set+/7ikTlR7eB0N9rz7Gn66qLVFhWVzYy3+NRSQ9K4SSEaJnnT9MI7w2Lllxd1gAOm/3ryO3vw==
X-Received: by 2002:a05:600c:16d6:b0:3e1:541:2b55 with SMTP id l22-20020a05600c16d600b003e105412b55mr1761902wmn.16.1675852043773;
        Wed, 08 Feb 2023 02:27:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003e0015c8618sm1545407wmb.6.2023.02.08.02.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:27:23 -0800 (PST)
Message-ID: <8b41827a-605a-3a65-5384-130fb0555b33@linaro.org>
Date:   Wed, 8 Feb 2023 11:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     li chen <lchen@ambarella.com>,
        michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        krzysztof kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        arnd bergmann <arnd@arndb.de>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
 <33c2038b-5e06-4eb2-82b8-007bb735bfb1@linaro.org>
 <186267bd495.c0d336602542450.72693939722996463@linux.beauty>
 <8b164c2f-b7b9-c5df-3b9c-ea39bd3eb424@linaro.org>
 <186273b85d1.e6e326dd2609909.4901324458297607618@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <186273b85d1.e6e326dd2609909.4901324458297607618@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 15:57, Li Chen wrote:
> Hi Krzysztof,
>  ---- On Mon, 06 Feb 2023 21:41:44 +0800  Krzysztof Kozlowski  wrote --- 
>  > On 06/02/2023 12:28, Li Chen wrote:
>  > > Hi Krzysztof ,
>  > > 
>  > >  ---- On Fri, 27 Jan 2023 23:08:09 +0800  Krzysztof Kozlowski  wrote --- 
>  > >  > On 27/01/2023 15:48, Li Chen wrote:
>  > >  > >  > 
>  > >  > >  > but what you are saying is that there is no separate clock controller
>  > >  > >  > device with its own IO address but these clocks are part of rct_syscon.
>  > >  > >  > Then model it that way in DTS. The rct_syscon is then your clock
>  > >  > >  > controller and all these fake gclk-core and gclk-ddr nodes should be gone.
>  > >  > > 
>  > >  > > Ok, I will remove these fake nodes, and model the hardware as:
>  > >  > > 
>  > >  > > rct_syscon node
>  > >  > > | clock node(pll, div, mux, composite  clocks live in the same driver)
>  > >  > > | other periphal nodes
>  > >  > 
>  > >  > You need clock node if it takes any resources. If it doesn't, you do not
>  > >  > need it.
>  > > 
>  > > If the only hardware resource the clock node can take is its parent clock(clocks = &osc;),
>  > > then can I have this clock node?
>  > 
>  > I am not sure if I understand. osc does not look like parent device, so
>  > this part of comment confuses me.
> 
> Sorry for the confusion. I mean osc is the root of clock tree:
> 
> osc
>   | pll A
>   | pll B
>   | ...
> 
> So if I have a clock node under rct_syscon node, I think it should take osc as the parent(node) clock:
> rct_syscon {
>     ......
>     clock_controller {
>           clocks = <&osc>;
>           ......
> 
> You have said "You need clock node if it takes any resources. ", do you think osc here can be counted as a used resource?

Yes, in that matter osc should be the input to this clock controller.

Best regards,
Krzysztof

