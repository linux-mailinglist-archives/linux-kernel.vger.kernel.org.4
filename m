Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7E5E97C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiIZBnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiIZBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:43:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0C22286
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:43:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso6567134wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TXypzlgba8Zg3Bw+ufq5o3Y7uUVrGlJmf5mQqKp3w8E=;
        b=AXPxiZpebfmDuNVIIpFcl61O6FMrbNWBmHwpS/s9kimT/KmoHFSK0xzsJsLQFOv5RO
         zXQi332g+PC4JIz5hRD93r95j5P+w2jzfnqklen0MZ4WjkfA+g4Hv1AHvoxZ28DDPVwf
         W5bbsiUP01wXZh+3P7JTvV7sGLT1hCdmjFViUOnOpxSBEBuGrXYMa7EzAJUgkdZ2qEts
         BEbQ2EijoF7n4RbSUsok/5pwf+Q1uvPsmEAyVF8g9b7+7K94m1euEqo2jlxHJuQrm9UG
         p8saAI0pHn5U7oxS2QHDmqG/lP6JINOmTS7J3autxovS/tY2gqDkcvVnQeeK5l8o01Lt
         Brjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TXypzlgba8Zg3Bw+ufq5o3Y7uUVrGlJmf5mQqKp3w8E=;
        b=SwuVnsiouFGtJddn1IeQcOflkUB2TeTloAXAtDZFIvGUk+Mtyku2xX5cw4Y5TlmFZA
         RhYgeA91FPR6PzxjHy0QK1j1VJ/1yvGw4KG0VupVPtGSWqWjuNx0VPliuXqWa+0bHJAl
         vJQkghXEEVrqjCmCQKdCytfPJEH00fbFMpZ/YFxlAL8EkBKy4aFLQwQjLszde/utwyxn
         zAiixDhqWYL4BHaat0yQ6uycy4n4EieDLAgbnCxzxUl8DhigA8NgUNMX8xL/J9A5KIIX
         BYPMIuMDCm5YG5QuJKNgjfIZd5W0svJi4mClGopQbBOaVh+P5CH+0Wi9foP1IqhP5DkX
         VAFw==
X-Gm-Message-State: ACrzQf360ge39tf0DPsHdPURAu6+rPfxp7tULVH2Vam2buBjxtjTdw2t
        fzalakzSsbqYOSiLwAz+IZFGEbOyoGIAvhHHOTHk+NLOjr8=
X-Google-Smtp-Source: AMsMyM4uXxdw8hSXJcrKU7D1Irudn2PDOysdVx3GKVPXMGmyCViP+I4gZVoaoykVuRFCp5DJxEMVLwTYBkpRthQLEN4=
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id
 l17-20020a1ced11000000b003b4d3e10becmr13251362wmh.196.1664156613212; Sun, 25
 Sep 2022 18:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
 <CAOf5uwnfCCwHjSXTurMtyEpZc_tF8bH=fxfwBzOtHcfM_S4tYg@mail.gmail.com>
 <CAOf5uw=_+WQO7qH_Bxs5qEBn2_nemzuLiXdYe8+W_+OnFZNYkw@mail.gmail.com>
 <fb52982c-745e-ef9b-6258-0870d00a744b@linaro.org> <CAOf5uwnVZxYGDfph6wKKpF413obt3786WPMn8mnSdizKe=XkzQ@mail.gmail.com>
 <ebca0c67-43f6-ce57-372b-f6ddaac69914@linaro.org>
In-Reply-To: <ebca0c67-43f6-ce57-372b-f6ddaac69914@linaro.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 25 Sep 2022 21:43:20 -0400
Message-ID: <CAMdYzYrqVSNmOASDUXK0MaJVy56gmRkHweb9Bs7J76O4HZn2NQ@mail.gmail.com>
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Heiko St??bner" <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 5:51 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> after a painful git bisect, the kernel panic happens with:
>
> commit 8dc60f8da22fdbaa1fafcfb5ff6d24bc9eff56aa (refs/bisect/bad)
> Author: Peter Geis <pgwipeout@gmail.com>
> Date:   Tue Jun 21 20:31:40 2022 -0400
>
>      phy: rockchip-inno-usb2: Sync initial otg state
>
>      The initial otg state for the phy defaults to device mode. The actua=
l
>      state isn't detected until an ID IRQ fires. Fix this by syncing the =
ID
>      state during initialization.
>
>      Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
>      Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>      Reviewed-by: Samuel Holland <samuel@sholland.org>
>      Link:
> https://lore.kernel.org/r/20220622003140.30365-1-pgwipeout@gmail.com
>      Signed-off-by: Vinod Koul <vkoul@kernel.org>
>
> Reverting it fixes the issue

Good Evening,

A fix has been submitted and accepted, it is currently sitting in -next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/d=
rivers/phy/rockchip/phy-rockchip-inno-usb2.c?id=3Df340ed8664a55a467850ec168=
9996e63d9ee971a

Very Respectfully,
Peter

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@@@`0` @`@@ @@@@@@@[    3.566365] Unable to handle kernel NULL pointer
> dereference at virtual address 0000000000000000
> [    3.567182] Mem abort info:
> [    3.567440]   ESR =3D 0x0000000086000006
> [    3.567783]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [    3.568264]   SET =3D 0, FnV =3D 0
> [    3.568544]   EA =3D 0, S1PTW =3D 0
> [    3.568833]   FSC =3D 0x06: level 2 translation fault
> [    3.569275] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000024be00=
0
> [    3.569854] [0000000000000000] pgd=3D0800000001725003,
> p4d=3D0800000001725003, pud=3D0800000000f11003, pmd=3D0000000000000000
> [    3.570912] Internal error: Oops: 86000006 [#1] PREEMPT SMP
> [    3.571421] Modules linked in:
> [    3.571712] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.19.0-rc1+ #795
> [    3.572303] Hardware name: 96boards Rock960 (DT)
> [    3.572722] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    3.573354] pc : 0x0
> [    3.573567] lr : call_timer_fn.constprop.0+0x24/0x80
> [    3.574037] sp : ffff80000a703a50
> [    3.574339] x29: ffff80000a703a50 x28: 0000000000000005 x27:
> 0000000000000000
> [    3.575002] x26: ffff80000a3379c0 x25: ffff0000f7798de8 x24:
> ffff80000a703ae0
> [    3.575664] x23: 0000000000000000 x22: dead000000000122 x21:
> 0000000000000101
> [    3.576325] x20: ffff0000006b6200 x19: 0000000000000000 x18:
> 0000000000000000
> [    3.576986] x17: ffff8000ed773000 x16: ffff80000801c000 x15:
> 00003d0900007d00
> [    3.577648] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
> [    3.578308] x11: 0000000000000004 x10: ffff8000ed773000 x9 :
> ffff0000f7798e30
> [    3.578970] x8 : 0000000000000001 x7 : ffffffffffffffff x6 :
> 0000000000000000
> [    3.579630] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> 0000000000000200
> [    3.580290] x2 : 0000000000000200 x1 : 0000000000000000 x0 :
> ffff000001025310
> [    3.580951] Call trace:
> [    3.581178]  0x0
> [    3.581359]  __run_timers.part.0+0x1f0/0x234
> [    3.581759]  run_timer_softirq+0x3c/0x7c
> [    3.582130]  _stext+0x124/0x2a0
> [    3.582430]  __irq_exit_rcu+0xe4/0x100
> [    3.582790]  irq_exit_rcu+0x10/0x1c
> [    3.583117]  el1_interrupt+0x38/0x70
> [    3.583454]  el1h_64_irq_handler+0x18/0x24
> [    3.583835]  el1h_64_irq+0x64/0x68
> [    3.584156]  cpuidle_enter_state+0x130/0x2f0
> [    3.584560]  cpuidle_enter+0x38/0x50
> [    3.584901]  do_idle+0x214/0x29c
> [    3.585210]  cpu_startup_entry+0x28/0x30
> [    3.585578]  secondary_start_kernel+0x13c/0x150
> [    3.586002]  __secondary_switched+0xa0/0xa4
> [    3.586408] Code: bad PC value
> [    3.586699] ---[ end trace 0000000000000000 ]---
> [    3.587119] Kernel panic - not syncing: Oops: Fatal exception in
> interrupt
> [    3.587732] SMP: stopping secondary CPUs
> [    3.588230] Kernel Offset: 0x80000 from 0xffff800008000000
> [    3.588725] PHYS_OFFSET: 0x0
> [    3.588991] CPU features: 0x800,00127811,00001082
> [    3.589420] Memory Limit: none
> [    3.589724] ---[ end Kernel panic - not syncing: Oops: Fatal
> exception in interrupt ]---
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
