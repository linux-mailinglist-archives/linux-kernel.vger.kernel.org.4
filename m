Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5346977B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjBOICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjBOICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:02:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF830B09
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:02:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so18128723wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaiBcOzxld67Ci61NEUfuZ2DZ55AC03hwShyEjS7OtE=;
        b=kYGEfiy5gFejdg1V+1pQGvx4tzgnY1MnURCNh61BMTk0CVpUM4cMziQ5O8YA8qAV60
         jKFkuJKB7moT9Agw4jmlfwl0Nkm8lBJiO8PEUtpOhk5fc/LeJXUq6Y14O4m1PXxopkIh
         cBdpHxy08Nqwc7K7f7jbr2LZgCDR6Gd+rGrJQJbDQ+iGFJjU6W5emSwLPOzn9/oZ6G2d
         W7OGNBA7luatRuhutScf/LhXwSNjEH2AjRjDpFl9kZQe/Eyhpt7J8xGsj2kFVuh5WkM2
         bn5VUdnXOkdq3QcKAMChrh37Jl2zGlbR89QqeyBNnJa6i/+2YVlsPHLOAan53Hynmqwy
         GRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaiBcOzxld67Ci61NEUfuZ2DZ55AC03hwShyEjS7OtE=;
        b=oAPHDsvL5Rfty0DQ/vbZ1SBLT7tVnpWk7KhKsuG2Za2jHJyKktqHQkGgPi784E5AkU
         mlmCJ9hEPcXxrieHcXxR/iVBnXYj6iHBbqWCwX2iaY4e+4Q247aoz08H3tnZMi6sprsD
         aU/QfLk1OZxebuoBj84Sf1e9jucy05TUTCMGfE6v9M3lRaKIyJEvlUgJE7C8TX8Xq1DY
         5ztksKcOWkXrdbOlwoqtuq3QejEBydN9zR5iL6zjYPdB5dE0QhguFlDPYocq4e9oCZuT
         TQFJeT+j4EARoA7clHGU8+mpHxwNpeT8hwFNAFSXF7DBFFiSoI23tssUl3LLN/gHXGQ4
         cVoQ==
X-Gm-Message-State: AO0yUKW+GFGhEPHzcj1nPF57QG2YDsXH9nA8NSfOt6qGJ9CeTcW8mQiF
        M3UFG35X+qQ1nTCqk+A4AR7vkQ==
X-Google-Smtp-Source: AK7set+lNAXXc/wAxk8uTD1inQtiOoShB2k++cZsVQsrDEF4rF5ozabr+hFlpRVyX+QRIfoaAjkW2w==
X-Received: by 2002:a05:6000:c4:b0:2c5:557a:d7d3 with SMTP id q4-20020a05600000c400b002c5557ad7d3mr1017175wrx.18.1676448122561;
        Wed, 15 Feb 2023 00:02:02 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g17-20020a5d5411000000b002c558f58c5bsm6866155wrv.28.2023.02.15.00.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:02:02 -0800 (PST)
Message-ID: <ae31e027-2d21-af47-8c85-a88d45c8e5de@linaro.org>
Date:   Wed, 15 Feb 2023 09:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-next: duplicate patches in the clockevents tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230215152907.238e0ba1@canb.auug.org.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230215152907.238e0ba1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 05:29, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the tip tree as different commits
> (but the same patches):
> 
>    e09903cea09e ("clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback")
>    f243533b29c5 ("clocksource/drivers/sh_cmt: Mark driver as non-removable")
>    596846da9f03 ("clocksource/drivers/timer-microchip-pit64b: Drop obsolete dependency on COMPILE_TEST")
>    8e148217ffb9 ("clocksource/drivers/riscv: Increase the clock source rating")
>    969ec81d5a96 ("clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT")
>    98ce3981716c ("dt-bindings: timer: Add bindings for the RISC-V timer device")
>    245fe5328dc7 ("RISC-V: time: initialize hrtimer based broadcast clock event device")
>    8cf50035875e ("dt-bindings: timer: rk-timer: Add rktimer for rv1126")
> 
> These are commits
> 
>    3aff0403f814 ("clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback")
>    c3daa4754f3c ("clocksource/drivers/sh_cmt: Mark driver as non-removable")
>    8d17aca90bcf ("clocksource/drivers/timer-microchip-pit64b: Drop obsolete dependency on COMPILE_TEST")
>    674402b0098b ("clocksource/drivers/riscv: Increase the clock source rating")
>    8932a9533a9c ("clocksource/drivers/timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT")
>    e2bcf2d876fd ("dt-bindings: timer: Add bindings for the RISC-V timer device")
>    8b3b8fbb4896 ("RISC-V: time: initialize hrtimer based broadcast clock event device")
>    b3cbfb792792 ("dt-bindings: timer: rk-timer: Add rktimer for rv1126")

Updated the tree, thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

