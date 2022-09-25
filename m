Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087A5E963E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIYVvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:51:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D126AE4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:51:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id iv17so3339910wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8W/8vKYwkXDyZf6kmPk/cuu68RlPeqrtdVnVl7E0RE0=;
        b=dSzKB+J/H1svyzXSTyrgd1+KHBBR0YNon8uJ/2Gs5JAugJLozOXsjpRZmjJLFC1Vl6
         tf5TnQVi1nT79LFIluu1r1hLHWDTOixxy6ApUtR//bhS3F/PKhJGyXBAGGzRaYhp46yP
         SjFi94xav4UsKJ4WQ5CYyY5cWLoRrqFDZdYMmsOV/77iFq9NLZsejs1jDlX04dj8FElZ
         MPq5HDmgyDSZ6NmT3sfgv5/IarNB0zYSeYXLrrhYJDlCe1dtS63LkyopORvWa/g5sDou
         TE/3f0QDVYiHpQ6aoCakZ2xWD02SHaJEkDlObh7fOd3IhZmDnzUd3cD7KZMGt+0L8j3q
         Hnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8W/8vKYwkXDyZf6kmPk/cuu68RlPeqrtdVnVl7E0RE0=;
        b=VuKOQwDQ4bwM0zhBROysUpeee5Enj9r2Dfl8AHGuDq3Y3u1QI/j61eA0Yxg7SDKr/k
         XtVpXehhwFAiRZPR7xgm4GpFfDBofxZsHcH6SoWppXmAJeRREtg4hizsdLns6TKaIpdn
         42f8j6JMxbXytSDfrkfPVXKdikM+FDbvNNfd4FXQ5Btsk5Vzpj48NqSXg71X7hrFgjtT
         jxXKVKWWCvZ8Ltxv01pZ54HxP/2mqQdKTcdV+t6znD9GQ4NUCvaW+/NV4/Fb2g46qk/H
         rV3l8kyso8XXYAoRiOI7/tjdEWy3NnOPvXh6TFbys9pmolqvyuYG5KZ6pNnxMY22WGpK
         8pkg==
X-Gm-Message-State: ACrzQf21scUP/h7sN9MYmhJ5j2dxp3T7wO0IqjnswyMcA+As64kImhU4
        n1liRAZoJH+oT3W6KDMingAoKA==
X-Google-Smtp-Source: AMsMyM4i01gZmvF6v/OejPkAJ//OyJZA3+DEhlQ1k4bKLB9pFOxg+zP9ltV/KI/NoV/To5eWm7Kx0g==
X-Received: by 2002:a05:600c:3d8e:b0:3b4:a61c:52cc with SMTP id bi14-20020a05600c3d8e00b003b4a61c52ccmr20898067wmb.7.1664142695145;
        Sun, 25 Sep 2022 14:51:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c3-20020a5d63c3000000b0021e51c039c5sm12541823wrw.80.2022.09.25.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 14:51:34 -0700 (PDT)
Message-ID: <ebca0c67-43f6-ce57-372b-f6ddaac69914@linaro.org>
Date:   Sun, 25 Sep 2022 23:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Heiko St??bner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
 <CAOf5uwnfCCwHjSXTurMtyEpZc_tF8bH=fxfwBzOtHcfM_S4tYg@mail.gmail.com>
 <CAOf5uw=_+WQO7qH_Bxs5qEBn2_nemzuLiXdYe8+W_+OnFZNYkw@mail.gmail.com>
 <fb52982c-745e-ef9b-6258-0870d00a744b@linaro.org>
 <CAOf5uwnVZxYGDfph6wKKpF413obt3786WPMn8mnSdizKe=XkzQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAOf5uwnVZxYGDfph6wKKpF413obt3786WPMn8mnSdizKe=XkzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

after a painful git bisect, the kernel panic happens with:

commit 8dc60f8da22fdbaa1fafcfb5ff6d24bc9eff56aa (refs/bisect/bad)
Author: Peter Geis <pgwipeout@gmail.com>
Date:   Tue Jun 21 20:31:40 2022 -0400

     phy: rockchip-inno-usb2: Sync initial otg state

     The initial otg state for the phy defaults to device mode. The actual
     state isn't detected until an ID IRQ fires. Fix this by syncing the ID
     state during initialization.

     Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
     Signed-off-by: Peter Geis <pgwipeout@gmail.com>
     Reviewed-by: Samuel Holland <samuel@sholland.org>
     Link: 
https://lore.kernel.org/r/20220622003140.30365-1-pgwipeout@gmail.com
     Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reverting it fixes the issue

=======================================================================

@@@@`0` @`@@ @@@@@@@[    3.566365] Unable to handle kernel NULL pointer 
dereference at virtual address 0000000000000000
[    3.567182] Mem abort info:
[    3.567440]   ESR = 0x0000000086000006
[    3.567783]   EC = 0x21: IABT (current EL), IL = 32 bits
[    3.568264]   SET = 0, FnV = 0
[    3.568544]   EA = 0, S1PTW = 0
[    3.568833]   FSC = 0x06: level 2 translation fault
[    3.569275] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000024be000
[    3.569854] [0000000000000000] pgd=0800000001725003, 
p4d=0800000001725003, pud=0800000000f11003, pmd=0000000000000000
[    3.570912] Internal error: Oops: 86000006 [#1] PREEMPT SMP
[    3.571421] Modules linked in:
[    3.571712] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.19.0-rc1+ #795
[    3.572303] Hardware name: 96boards Rock960 (DT)
[    3.572722] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    3.573354] pc : 0x0
[    3.573567] lr : call_timer_fn.constprop.0+0x24/0x80
[    3.574037] sp : ffff80000a703a50
[    3.574339] x29: ffff80000a703a50 x28: 0000000000000005 x27: 
0000000000000000
[    3.575002] x26: ffff80000a3379c0 x25: ffff0000f7798de8 x24: 
ffff80000a703ae0
[    3.575664] x23: 0000000000000000 x22: dead000000000122 x21: 
0000000000000101
[    3.576325] x20: ffff0000006b6200 x19: 0000000000000000 x18: 
0000000000000000
[    3.576986] x17: ffff8000ed773000 x16: ffff80000801c000 x15: 
00003d0900007d00
[    3.577648] x14: 0000000000000000 x13: 0000000000000000 x12: 
0000000000000000
[    3.578308] x11: 0000000000000004 x10: ffff8000ed773000 x9 : 
ffff0000f7798e30
[    3.578970] x8 : 0000000000000001 x7 : ffffffffffffffff x6 : 
0000000000000000
[    3.579630] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 
0000000000000200
[    3.580290] x2 : 0000000000000200 x1 : 0000000000000000 x0 : 
ffff000001025310
[    3.580951] Call trace:
[    3.581178]  0x0
[    3.581359]  __run_timers.part.0+0x1f0/0x234
[    3.581759]  run_timer_softirq+0x3c/0x7c
[    3.582130]  _stext+0x124/0x2a0
[    3.582430]  __irq_exit_rcu+0xe4/0x100
[    3.582790]  irq_exit_rcu+0x10/0x1c
[    3.583117]  el1_interrupt+0x38/0x70
[    3.583454]  el1h_64_irq_handler+0x18/0x24
[    3.583835]  el1h_64_irq+0x64/0x68
[    3.584156]  cpuidle_enter_state+0x130/0x2f0
[    3.584560]  cpuidle_enter+0x38/0x50
[    3.584901]  do_idle+0x214/0x29c
[    3.585210]  cpu_startup_entry+0x28/0x30
[    3.585578]  secondary_start_kernel+0x13c/0x150
[    3.586002]  __secondary_switched+0xa0/0xa4
[    3.586408] Code: bad PC value
[    3.586699] ---[ end trace 0000000000000000 ]---
[    3.587119] Kernel panic - not syncing: Oops: Fatal exception in 
interrupt
[    3.587732] SMP: stopping secondary CPUs
[    3.588230] Kernel Offset: 0x80000 from 0xffff800008000000
[    3.588725] PHYS_OFFSET: 0x0
[    3.588991] CPU features: 0x800,00127811,00001082
[    3.589420] Memory Limit: none
[    3.589724] ---[ end Kernel panic - not syncing: Oops: Fatal 
exception in interrupt ]---


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
