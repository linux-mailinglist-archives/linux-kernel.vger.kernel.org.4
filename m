Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7761325A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJaJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:15:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39AD2E8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:15:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o12so18248144lfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1tjqjP0f5c5NtuHeHtjfjYtvba1hL3hwsHwqOPFWzQ=;
        b=ZfplkGbmdtl6fkRU1Mc5XVnelJ1pZmw2UXH8LCXm7DlRWlxP9ZBqAEQW9wy8l36Qow
         NiYZV8p5cq9CtnTXvTgCkR5lZcKokyNlokWrxNGk5V03S4PkLZdZ8vyA/y6gm2x6uXeU
         +/mf7G4iGdJoB7BvtWc/CoYc2cqnyQrEH0Av0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1tjqjP0f5c5NtuHeHtjfjYtvba1hL3hwsHwqOPFWzQ=;
        b=ZPet4jQKqnWScNzAPByvUCctNWdZ9gvtssQ3q8XN2VzRIrKOBm0qlV/uQzLxSATLTB
         pSCSPwa5ijRZ55nYiRWb4XjQ1DjDZpMgmCJReNubfJfjg3roCxsrPOerL1h40giGBOWF
         0kESZ1LsFcdKn24eBznYArHdIhB3uiIfbWDEMY8OltmjFQRsfsr0r+NP5i0kiTkbRl+t
         4l9T777JPOMqmfjR4vdcsxf1pqZLlmvaKyEzq18R2rGtI/A0AJa2BFhNHOPmwGhlj619
         yqv1CYH6pwDyMBl8wp+i86FVToUaiP2WXjo7Wf9PjVWSO75a23nbQWLeEBwFcG2u9BiR
         YyEQ==
X-Gm-Message-State: ACrzQf0SYVft9WBMiwa0P020BkaqyV76x0INPHfIUmHUYt20q2yEeQ7l
        nHhBD0uUjrjsJGqhRtoQDmdBEw==
X-Google-Smtp-Source: AMsMyM7tphVaAwqd2wHznUPi3TaqV761nJu3BjP/W0g/L34stybwhDqQIkk6GpTfPhAkAIluU/Gddg==
X-Received: by 2002:a05:6512:32b7:b0:4aa:8d5a:2f53 with SMTP id q23-20020a05651232b700b004aa8d5a2f53mr4667511lfe.362.1667207748090;
        Mon, 31 Oct 2022 02:15:48 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bf13-20020a056512258d00b004a22599c4ddsm1188060lfb.268.2022.10.31.02.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 02:15:47 -0700 (PDT)
Message-ID: <9723c439-fa24-f44b-2158-f0fad9c24960@rasmusvillemoes.dk>
Date:   Mon, 31 Oct 2022 10:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <20221027232914.2F51DC43470@smtp.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221027232914.2F51DC43470@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 01.29, Stephen Boyd wrote:
> Quoting Rasmus Villemoes (2022-09-28 05:41:08)
>> We have an imx8mp-based board with an external gpio-triggered
>> watchdog. Currently, we don't get to handle that in time before it
>> resets the board.
> 
> How much time does your bootloader give you to pet the watchdog? 

The bootloader has no say; it's a simple piece of hardware with a
hardcoded threshold. In this particular case 1 second. Most, if not all,
custom designed industrial boards I've worked with has always been
equipped with such an external watchdog (the threshold may be different,
but the basic functionality and requirement is the same). In some cases,
it's a matter of certifications, in others it's a requirement from
certain end customers. But the hardware designers certainly never add
this just for fun (obviously they want to keep complexity and BOM cost
down).

Why is
> the timeout short enough to trigger? Or is deferring probe slowing down
> boot so significantly that boot times are bad?

I wouldn't say that deferring probe slows down the boot as such (it
does, but not by a lot), but the fact that the watchdog device gets
deferred (because it depends on the gpio and in turn the clk IP blocks
in the SOC) is a problem.
>>
>> The probe of the watchdog device gets deferred because the SOC's GPIO
>> controller is not yet ready, and the probe of that in turn gets deferred
>> because its clock provider (namely, this driver) is not yet
>> ready. Altogether, the watchdog does not get handled until the late
>> initcall deferred_probe_initcall has made sure all leftover devices
>> have been probed, and that's way too late.
>>
>> Aside from being necessary for our board, this also reduces total boot
>> time because fewer device probes get deferred.
> 
> This is a game of whack-a-mole. If we decide to move device population
> from DT (of_platform_default_populate_init) to device_initcall() level
> we may run into a similar problem.

That's a red herring, because such a patch would be a regression for a
lot of existing and working boards with an external gpio-wdt watchdog.

>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> It would probably be reasonable to do the same to the other imx8m* clk
>> drivers, but I don't have any such hardware to test on.
>>
>>  drivers/clk/imx/clk-imx8mp.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
>> index e89db568f5a8..9ddd39a664cc 100644
>> --- a/drivers/clk/imx/clk-imx8mp.c
>> +++ b/drivers/clk/imx/clk-imx8mp.c
>> @@ -734,7 +734,19 @@ static struct platform_driver imx8mp_clk_driver = {
>>                 .of_match_table = imx8mp_clk_of_match,
>>         },
>>  };
>> -module_platform_driver(imx8mp_clk_driver);
>> +
>> +static int __init imx8mp_clk_init(void)
>> +{
>> +       return platform_driver_register(&imx8mp_clk_driver);
>> +}
>> +arch_initcall(imx8mp_clk_init);
> 
> Furthermore, there isn't any comment about why this is arch_initcall
> level. The next reader of this code can only assume why this was done or
> go on a git archaeology dig to figure out that we're registering this
> device early for some imx8mp-based board (is it upstream? What board is
> it?). Please help people reading the code.

Sure, I could add a comment here.

But if we take a step back, doesn't it make sense in general to make
sure a central IP block like the SOC's primary clk source is probed
early, before various other dependent IP blocks and peripherals?
Initializing such a core part of the SOC certainly sounds to me like an
arch-level thing. And it's not like this would be the first SOC-specific
clk driver with init called at arch_initcall, without any comment why it
happens at that time. E.g. clk_mt7629_init. IMO, that doesn't require a
comment, it's really just common sense.

As I said, I think this change would make sense for at least all the
imx8m drivers, and I'm happy to extend the patch to cover those for
consistency.

It also gives a small but measurable improvement in total boot time, but
that by itself is not why I want to make this change - it's simply a
necessary patch to make my customer's new imx8mp-based boards boot.

Rasmus

