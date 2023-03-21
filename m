Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A101F6C34FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjCUPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCUPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:03:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E782596C;
        Tue, 21 Mar 2023 08:03:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso1929870pjf.0;
        Tue, 21 Mar 2023 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679410997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4P7a0/rXTyc57id8CDTnxqxhaZ2GzBVxFhFkoIR7uk=;
        b=j0uZLcvL7n5o9c8Kh7uq/gnpjJ7g2Y48whQ6tE8UruQFrEmushobctNeWdOTkqKZbW
         sZX6fcP/Gp2jP9ryQDTIYzK8JD491Ym+Q8HYztA3nQwOq21sgXCuftBGYSQSYOvgqW22
         rvJ4QdtPkIZ3qKsC+r6qZyIWRdXP3Uacc9b+wWZnEJw7eQMBcd1CgTglmvb1VnZQa18R
         Wqt9GYcu0VAs/QG6bYBANPa2et5//XCUB2n81LvoUzszRwDWOiAPpMVa4ms4gVBl22xO
         QVOfyu2k9B6pnWS8lAGwfEHLObFIupo7+lttCTDMgWU5DXwiBN3wyreROYD9M37Y7kB1
         oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4P7a0/rXTyc57id8CDTnxqxhaZ2GzBVxFhFkoIR7uk=;
        b=tHPUqT7wZgG0rLLWyUCR29rG8pMRIHsQTFgcGruE6zSv9kF8yFAcE93HE11lapBStm
         BIrbEasMOWD+8pRe7ADaTGv+NDHEg8BhI+Ogy4iayBQnRqbNfoT1jrvtDelN7oy26y+W
         3oZETEJIa8WhSLcv90oKlIx7mrYUgfXxvTJoeYEJVpA7K52SoG+tH3VphJpJdK3oqIr8
         71HpUge7BL4htjXMHITS0e/0/tRaHFKFMDIvvcjeGSY61hX46ythbCvDqNodQmYJ2xhr
         e95UNTsphLV8yXxTuu4d466lb5bx+egWneLDc9vIqnwpGd6+5e8nXKHI0dOt6aSFnlX/
         BRwA==
X-Gm-Message-State: AO0yUKW7b3UCQLxUEEi2M8yrf2inm/omOeJEjZxf6G6FwPL2MHlJ8Ixi
        MYXYpiXDDfYzYN3YQDHWVkv/fhX5mQ8=
X-Google-Smtp-Source: AK7set99Pc5eg5pmBA+wYuNn07qDtLUwAn/dSaqIvVkGyhs+4JyZ/kfNWOZkFp0QMhUA4h2baD0WxA==
X-Received: by 2002:a05:6a20:8c02:b0:d6:ba0b:c82c with SMTP id j2-20020a056a208c0200b000d6ba0bc82cmr2140408pzh.38.1679410996661;
        Tue, 21 Mar 2023 08:03:16 -0700 (PDT)
Received: from [192.168.1.101] (1-160-162-168.dynamic-ip.hinet.net. [1.160.162.168])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b005cdbd9c8825sm8325299pfi.195.2023.03.21.08.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:03:16 -0700 (PDT)
Message-ID: <d59489d2-e801-a4a9-7bb4-bc80ffd0469a@gmail.com>
Date:   Tue, 21 Mar 2023 23:03:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-13-ychuang570808@gmail.com>
 <8b5854d3-2793-bc33-137e-5a2673d72329@linux.intel.com>
 <00c3748b-61fa-f14b-f92c-b60fd9d6b4ee@gmail.com>
 <9115473c-2e88-da76-9631-ca19b9129be4@linux.intel.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <9115473c-2e88-da76-9631-ca19b9129be4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilpo,


On 2023/3/20 下午 06:31, Ilpo Järvinen wrote:
> On Sun, 19 Mar 2023, Jacky Huang wrote:
>
>> On 2023/3/16 下午 11:56, Ilpo Järvinen wrote:
>>> On Wed, 15 Mar 2023, Jacky Huang wrote:
>>>
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> The clock controller generates clocks for the whole chip, including
>>>> system clocks and all peripheral clocks. This driver support ma35d1
>>>> clock gating, divider, and individual PLL configuration.
>>>>
>>>> There are 6 PLLs in ma35d1 SoC:
>>>>     - CA-PLL for the two Cortex-A35 CPU clock
>>>>     - SYS-PLL for system bus, which comes from the companion MCU
>>>>       and cannot be programmed by clock controller.
>>>>     - DDR-PLL for DDR
>>>>     - EPLL for GMAC and GFX, Display, and VDEC IPs.
>>>>     - VPLL for video output pixel clock
>>>>     - APLL for SDHC, I2S audio, and other IPs.
>>>> CA-PLL has only one operation mode.
>>>> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
>>>> operation modes: integer mode, fraction mode, and spread specturm mode.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>> +};
>>>> +
>>>> +#define to_ma35d1_adc_clk_divider(_hw)	\
>>>> +	container_of(_hw, struct ma35d1_adc_clk_divider, hw)
>>> static inline
>>
>> I will modify these "static" functions as "static inline".
> No, that's not what I meant. Make the container_of define static inline
> function instead, no other functions. (Or if you have more than one of
> such, all of them of course).
>
>>>> +}
>>>> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c
>>>> b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>>>> new file mode 100644
>>>> index 000000000000..79e724b148fa
>>>> --- /dev/null
>>>> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
>>>> @@ -0,0 +1,534 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>>>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/bitfield.h>
>>>> +
>>>> +#include "clk-ma35d1.h"
>>>> +
>>>> +#define to_ma35d1_clk_pll(clk) \
>>>> +	(container_of(clk, struct ma35d1_clk_pll, clk))
>>> static inline
>>
>> I am sorry cannot get "static inline" refer to which one.
>>
>> Would you give more advice here?
>>
>> Thank you.
> static inline struct ...type_here... *to_ma35d1_clk_pll(struct ...type_here... *clk)
> {
> 	return container_of(clk, struct ma35d1_clk_pll, clk);
> }
>

OK, I got it. Thank you very much.


>>>> +	} else {
>>>> +		pr_err("Failed to set rate %ld\n", u64PllFreq);
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	u64P = (u64FCLKO >= VSIPLL_FCLK_MIN_FREQ) ? 1 :
>>>> +	       ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
>>>> +		((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));
>>> Ditto.
>>>
>>> Is here some ...ROUND_UP() trick hidden too?
>>
>> This follows the description of PLL spec.
> Right but I was looking into what the math does. To me this looks like
> rounding up:
>   VSIPLL_FCLK_MIN_FREQ / u64FCLKO + (VSIPLL_FCLK_MIN_FREQ % u64FCLKO ? 1 : 0)
>
> When modulo is > 0, add one, which is round up, no?
>
> There are helpers which you should use for rounding up, search for
> *_ROUND_UP. I think math64.h had one 64-bit one.


Yes, it is a round up. We will find out all the occurrence and use 
ROUND_UP() macro instead.


>>>> +	u64X = u64tmp % 1000;
>>>> +	u32FRAC = ((u64X << 24) + 500) / 1000;
> I missed this earlier, is this rounding? ...Use a helper if it is.
> Otherwise define what 500 is. (No need to answer despite question mark,
> just do the change).
>
>>>> +
>>>> +	u64SSRATE = ((PllSrcClk >> 1) / (u32Fmod * 2)) - 1;
>>>> +	u64SLOPE = ((u64tmp * u32SR / u64SSRATE) << 24) / 100 / 1000;
>>>> +
>>>> +	u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;
>>> Is some *SEC_PER_*SEC define relevant for 1000 ?
>>>
>>> Or some other units, e.g., HZ related?
>>
>> 1000 is for kHz to MHz, and 100 is for percentage.
> Okay, then use KHZ_PER_MHZ from linux/units.h.
>
> We don't have anything for percents under include/ I think so that can be
> left as literal.


Sure, we are rewriting the pll calculation routine and add formula 
comments to make it more readable.


>>>> +	switch (pll->mode) {
>>>> +	case VSIPLL_INTEGER_MODE:
>>>> +		u64PllClk = CLK_CalPLLFreq_Mode0(PllSrcClk, u64PllFreq,
>>>> +						 u32Reg);
>>> One line.
>>
>> It will exceed 80 characters in one line.
> Yeah, the semicolon won't fit to 80 chars :-) which means there won't be
> significant information loss even on 80 chars terminal. This kind of cases
> is why checkpatch won't complain until 100 chars. Use common sense (don't
> hide most of the logic to 80-100 but don't be afraid of breaking the 80
> chars where the information loss is not significant issue).
>
> Besides, once you removed the types from variable names, it will be
> shorter anyway.
>
Got it. Thanks for your kind help and detailed explanation.


Best regards,

Jacky Huang


