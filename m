Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0495E8F69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiIXSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiIXSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:48:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0141D21
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:48:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so4585712wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1SloNiMp786X2/xuqKiZdnsDiOxKqBmN1OwZoG5Zg/4=;
        b=s6p3Osv3PS44ZndFuV4YV+gFUmymU1awcYWHUmEPqhrxbdgP88tPDHz2YgB4L0+J2n
         twoQxWQFO0DkaN2HqlVWgE1CiwBLdMpPSea4bPEfjHct1bUhd5r+xYPU7FNR3jbBtvCG
         cfVKaMhP97LgVH7uYwNQ5/UtFwX69p6Rj5vY8Qa848XNeoob/t/z5LNZhiNWRQdO5mgl
         jTEOZWobup44U585RlO5FT523URWRNjSKMY4Qu/5CYT2uEQ3HP83RlpuM3oJmaziw/p5
         rP545v70Ck6hQ9Y2VWMEjTsJrMl+HCKObd10EGwmpYXv0+rRTCAz20Qw9Iy0UNt6euFC
         Bf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1SloNiMp786X2/xuqKiZdnsDiOxKqBmN1OwZoG5Zg/4=;
        b=QWkuVgtyvcO8FJZAA8kmUz5pdzVAqWw7D54Pndoh3HtiJ8+2sSJg76QWH+LsIw0Efy
         YcQ/t+mou5sdOD7DvoZieQ0nnLwRAu89KwAK5PFCopxy87aQ3yNdQJpxFnhbyGz/FR/M
         lBoLp+B5pkb/9OoOUFVtNM69ZR1el8ksoxO1Hqai4+rQji51o0RMUTl9ovVAJnU2dAKW
         eRVrDqipxMKMpGt2fsmczQxc9+KG2krtAubj1gUFXoASnNfUNDTp7ivI0Ez/ljYs4DYm
         9a32QzZUSvmiu76ihaNiYhz30lEdyK0qLwvp1s6HnT/eTrlbS2iYdX0JiYgmwZBwc43T
         XYeQ==
X-Gm-Message-State: ACrzQf1IUXeZOkg31ZsXHZ/iFo+JWziVzVP+8ianVM3b7VKggYbbFhVw
        /1JK4pdh7BHYASBxLNwi0rjyG1hlpK955Q==
X-Google-Smtp-Source: AMsMyM6BTKNWRNW4fi5SCqBKlwFG+My7AlvvpQP1+l5Q6DLyg/NX61GGE5UAVATm57uh7NxyD+GNqw==
X-Received: by 2002:a5d:4c4c:0:b0:22a:35bd:84a9 with SMTP id n12-20020a5d4c4c000000b0022a35bd84a9mr8310432wrt.103.1664045314397;
        Sat, 24 Sep 2022 11:48:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bw25-20020a0560001f9900b0022ac1be009esm10761143wrb.16.2022.09.24.11.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 11:48:33 -0700 (PDT)
Message-ID: <fb52982c-745e-ef9b-6258-0870d00a744b@linaro.org>
Date:   Sat, 24 Sep 2022 20:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic
Content-Language: en-US
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Heiko St??bner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
 <CAOf5uwnfCCwHjSXTurMtyEpZc_tF8bH=fxfwBzOtHcfM_S4tYg@mail.gmail.com>
 <CAOf5uw=_+WQO7qH_Bxs5qEBn2_nemzuLiXdYe8+W_+OnFZNYkw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAOf5uw=_+WQO7qH_Bxs5qEBn2_nemzuLiXdYe8+W_+OnFZNYkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 20:01, Michael Nazzareno Trimarchi wrote:
> On Sat, Sep 24, 2022 at 7:58 PM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>>
>> Hi Daniel
>>
>> On Sat, Sep 24, 2022 at 7:43 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> there is a kernel panic on a rock960 board:
>>>
>>> After git bisecting, I have:
>>>
>>> commit 14facbc1871ae15404666747b5319c08e04b875a
>>> Merge: f5c97da8037b 32346491ddf2
>>> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Date:   Mon Jul 11 08:32:58 2022 +0200
>>>
>>>       Merge 5.19-rc6 into char-misc-next
>>>
>>>       We need the misc driver fixes in here as well.
>>>
>>>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> Any clue?
>>
>> That code receive 3-4 commits for one fix
>>
>> diff --git a/sound/soc/rockchip/rockchip_i2s.c
>> b/sound/soc/rockchip/rockchip_i2s.c
>> index f5f3540a9e18..a32a45b09b03 100644
>> --- a/sound/soc/rockchip/rockchip_i2s.c
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> @@ -803,7 +803,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>>
>>          i2s->bclk_ratio = 64;
>>          i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
>> -       if (!IS_ERR(i2s->pinctrl)) {
>> +       if (!IS_ERR_OR_NULL(i2s->pinctrl)) {
>>                  i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl, "bclk_on");
>>                  if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
>>                          i2s->bclk_off =
>> pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
> 
> I don't sure if you can get null from there, but you have two
> lookup_state on that function


Hmm, actually, I think it is not the same kernel panic I'm observing on 
v6.0-rc6.

I've been puzzled by different kernel panics from different issues when 
git bisecting.

The one happening is:

[    2.471037] rk808-rtc rk808-rtc: setting system clock to 
2022-09-24T18:41:07 UTC (1664044867)
[    2.485859] usbcore: registered new interface driver uvcvideo
[    3.726846] Unable to handle kernel execute from non-executable 
memory at virtual address ffff80000a516530
[    3.728032] Mem abort info:
[    3.728308]   ESR = 0x000000008600000f
[    3.728667]   EC = 0x21: IABT (current EL), IL = 32 bits
[    3.729169]   SET = 0, FnV = 0
[    3.729466]   EA = 0, S1PTW = 0
[    3.729770]   FSC = 0x0f: level 3 permission fault
[    3.730223] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000005f42000
[    3.730846] [ffff80000a516530] pgd=10000000f7fff003, 
p4d=10000000f7fff003, pud=10000000f7ffe003, pmd=10000000f7ff9003, 
pte=0078000006516f03
[    3.732063] Internal error: Oops: 8600000f [#1] PREEMPT SMP
[    3.732588] Modules linked in:
[    3.732918] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.0.0-rc1+ #730
[    3.733532] Hardware name: 96boards Rock960 (DT)
[    3.733971] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    3.734635] pc : extcon_dev_list+0x0/0x10
[    3.735056] lr : call_timer_fn.constprop.0+0x24/0x80
[    3.735551] sp : ffff80000a733ab0
[    3.735869] x29: ffff80000a733ab0 x28: 0000000000000005 x27: 
ffff80000a516530
[    3.736574] x26: ffff80000a3779c0 x25: ffff0000f776dde8 x24: 
ffff80000a733b40
[    3.737277] x23: 0000000000000000 x22: dead000000000122 x21: 
0000000000000101
[    3.737977] x20: ffff000000644600 x19: ffff80000a516530 x18: 
ffffffffffffffff
[    3.738677] x17: ffff8000ed713000 x16: ffff80000800c000 x15: 
0000000000004000
[    3.739377] x14: 0000000000000000 x13: 0000000000000000 x12: 
0000000000000000
[    3.740073] x11: 00000000000000b7 x10: ffff8000ed713000 x9 : 
ffff0000f776de30
[    3.740771] x8 : 0000000000000001 x7 : ffffffffffffffff x6 : 
0000000000000000
[    3.741469] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 
0000000000000200
[    3.742164] x2 : 0000000000000200 x1 : ffff80000a516530 x0 : 
ffff0000007e7310
[    3.742865] Call trace:
[    3.743107]  extcon_dev_list+0x0/0x10
[    3.743477]  __run_timers.part.0+0x1f0/0x234
[    3.743908]  run_timer_softirq+0x3c/0x7c
[    3.744306]  _stext+0x124/0x2a4
[    3.744627]  __irq_exit_rcu+0xcc/0xfc
[    3.745008]  irq_exit_rcu+0x10/0x20
[    3.745372]  el1_interrupt+0x38/0x70
[    3.745733]  el1h_64_irq_handler+0x18/0x24
[    3.746140]  el1h_64_irq+0x64/0x68
[    3.746484]  arch_cpu_idle+0x18/0x2c
[    3.746843]  default_idle_call+0x34/0x70
[    3.747243]  do_idle+0x240/0x2bc
[    3.747576]  cpu_startup_entry+0x24/0x30
[    3.747969]  secondary_start_kernel+0x12c/0x140
[    3.748421]  __secondary_switched+0xb0/0xb4
[    3.748879] Code: 0a516520 ffff8000 0a516520 ffff8000 (007e7320)
[    3.749461] ---[ end trace 0000000000000000 ]---
[    3.749911] Kernel panic - not syncing: Oops: Fatal exception in 
interrupt
[    3.750548] SMP: stopping secondary CPUs
[    3.751094] Kernel Offset: 0x80000 from 0xffff800008000000
[    3.751609] PHYS_OFFSET: 0x0
[    3.751889] CPU features: 0x2000,0824f021,00001082
[    3.752354] Memory Limit: none
[    3.752655] ---[ end Kernel panic - not syncing: Oops: Fatal 
exception in interrupt ]---



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
