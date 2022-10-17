Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CC60084A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJQIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:03:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50175B7BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:03:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so14868646edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38hhdSBAiDrIRtNOL5jTKXTvlsXAaYH5Uwz2cmGC3kI=;
        b=hiuEHSkHTJ92z+H6PEhj/xzrZcOoLUK0JTXdmM5idjPic4ooLkswYBgOy8oz7deldC
         3H1JKiycBTnCCafZ4S3a1zkemG0EPJ6u77BhX08FAHpQs7Mbt8nf0vFkXI+oSwi4rIap
         3yqqtObd/QjRrRgS1p0uCOvGiXmyV6bwZ3yNKmyzomHLJ3Th4Y7uYszZL41zfrxA3HUj
         zJfPOaTMUwExrc4TBDTqq/966Q8XddrGynLlO7NwlAEDAJV7qBw3LHsRwjGYkm9qvLpT
         1Wgp5rf1Kc8t2hcUfJWCEB6yL8xFz9ZsI6/9AKPvmeCMyl+pWg6RKoJ57UqC7GYgCZib
         eiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38hhdSBAiDrIRtNOL5jTKXTvlsXAaYH5Uwz2cmGC3kI=;
        b=ppenQt+xc7FGsLp+AAwgghc/6bOuSUvh4tVxplRpcX8+xYwthYYgHMqdNkjFtuT9am
         NuLrJrhZPwHJdH58EWIWFirRvG4C90z26umcE9Rn1XO06yv8iQn7x2MV+hrntio0f4T0
         hM/FadLIyrAkGkzbGVje8P6dtyfQSX3kV6qQbbo63+rEjMHNb6FbLyRqDbQFwMaMzAa/
         Wh2fnmyGGoCkHp0x+d07NDMkGajPco5I/sHRV8XcJ06T7UXwXGdYVnVdsVCes327bGSZ
         V51NGYXQhBmUHlMiDKT83ygphmwFkj21WhorGWUC30ZFmHASzwAAFgs74uhBZclQebAZ
         Sp4A==
X-Gm-Message-State: ACrzQf1H4FHlUlJs5tw3eKFIKTpRcREhhda2Z6H55Vx4E4D27NFohznZ
        AzjIXGB2VpBuQG0628IJQYIZ5v+Xv6U=
X-Google-Smtp-Source: AMsMyM6RsDtz57xPcOaAgKDs1dDOM0FifoC+/HbDRZGAi51LVMiX3fGxlPVO7IK3Kpa/W/JHmEQ4JQ==
X-Received: by 2002:a05:6402:11c7:b0:45d:9775:d423 with SMTP id j7-20020a05640211c700b0045d9775d423mr3280062edw.257.1665993815871;
        Mon, 17 Oct 2022 01:03:35 -0700 (PDT)
Received: from [192.168.2.4] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cw18-20020a056402229200b00458c07702c1sm6805534edb.23.2022.10.17.01.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 01:03:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------eANQyjHRzIHbujtCvpIyYAdH"
Message-ID: <7b61d027-6cb9-f35e-fdd0-c5bba9389783@gmail.com>
Date:   Mon, 17 Oct 2022 10:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: [BUG] [PATCH v2 1/2] clocksource: arm_global_timer: implement rate
 compensation whenever source clock changes
Content-Language: en-US
To:     Andrea Merello <andrea.merello@gmail.com>, tglx@linutronix.de,
        daniel.lezcano@linaro.org, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
References: <20210406130045.15491-1-andrea.merello@gmail.com>
 <20210406130045.15491-2-andrea.merello@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20210406130045.15491-2-andrea.merello@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------eANQyjHRzIHbujtCvpIyYAdH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrea,

Your patch contribution causes a kernel panic on MK808 with Rockchip rk3066a SoC.
Would you like to contribute to fix this issue?
The psv variable divides with 0 and more things might be wrong.
A revert makes it work again.


Johan

=====

[   13.087809] ------------[ cut here ]------------
[   13.110701] kernel BUG at drivers/cpufreq/cpufreq.c:1480!
[   13.134378] Internal error: Oops - BUG: 0 [#1] SMP ARM
[   13.157793] Modules linked in:
[   13.178760] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.0.0-next-20221013 #1
[   13.205990] Hardware name: Rockchip (Device Tree)
[   13.228793] PC is at cpufreq_online+0x8fc/0xa1c
[   13.251421] LR is at __wake_up_common_lock+0x98/0xc4
[   13.274536] pc : [<c06883d8>]    lr : [<c0171c50>]    psr: a0000013
[   13.299046] sp : f0821c50  ip : f0821b70  fp : f0821c9c
[   13.322445] r10: 00000000  r9 : 00000000  r8 : c0f9b800
[   13.345887] r7 : 000493e0  r6 : c115ef18  r5 : c1005058  r4 : c2055e00
[   13.370714] r3 : b4aeb193  r2 : b4aeb193  r1 : 60000013  r0 : fffffff0
[   13.395373] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   13.420948] Control: 10c5387d  Table: 6000404a  DAC: 00000051
[   13.444914] Register r0 information: non-paged memory
[   13.468230] Register r1 information: non-paged memory
[   13.491289] Register r2 information: non-paged memory
[   13.514135] Register r3 information: non-paged memory
[   13.536767] Register r4 information: slab kmalloc-512 start c2055e00 pointer offset 0 size 512
[   13.563712] Register r5 information: non-slab/vmalloc memory
[   13.587158] Register r6 information: non-slab/vmalloc memory
[   13.610385] Register r7 information: non-paged memory
[   13.632699] Register r8 information: non-slab/vmalloc memory
[   13.655529] Register r9 information: NULL pointer
[   13.677204] Register r10 information: NULL pointer
[   13.698865] Register r11 information: 2-page vmalloc region starting at 0xf0820000 allocated at kernel_clone+0xc0/0x3b0
[   13.727678] Register r12 information: 2-page vmalloc region starting at 0xf0820000 allocated at kernel_clone+0xc0/0x3b0
[   13.756320] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[   13.779523] Stack: (0xf0821c50 to 0xf0822000)
[   13.800858] 1c40:                                     00000000 00000001 ef7c5050 00000001
[   13.826719] 1c60: c10da900 00000002 c115ef18 c2055f20 c0942224 00000000 ef7c5050 c1004ec8
[   13.852544] 1c80: c20d7b40 c10da884 c1005058 c1004f14 f0821cb4 f0821ca0 c0688590 c0687ae8
[   13.878330] 1ca0: c10da570 c10cf8a8 f0821ce4 f0821cb8 c0595080 c0688524 c14f7958 c1645434
[   13.904232] 1cc0: 00000000 b4aeb193 00000060 c10da900 c115ef18 c10da434 f0821d0c f0821ce8
[   13.930231] 1ce0: c06859e0 c0594fdc c10da8ec ef7c5050 c20d7b40 00000002 c10da8ec ef7c5050
[   13.956321] 1d00: f0821d8c f0821d10 c068b9a4 c068589c c0b161cc c1004ec8 00000000 c0b7b718
[   13.982392] 1d20: c14e3400 00000000 c20d7b48 00000001 c033f608 c20da5d8 c20da688 c160c688
[   14.008446] 1d40: c0b8bd28 00000001 c0c47d54 c111b000 f0821d84 00000000 00000000 b4aeb193
[   14.034637] 1d60: c14e3410 c14e3410 00000000 c10da898 00000000 c20d7ab8 c0c47d54 c111b000
[   14.060896] 1d80: f0821dac f0821d90 c0599424 c068b68c c14e3410 00000000 c10da898 00000000
[   14.087313] 1da0: f0821dcc f0821db0 c0596cd0 c05993c4 c14e3410 c10da898 c14e3410 00000000
[   14.113601] 1dc0: f0821de4 f0821dd0 c0596f8c c0596c04 c115dd68 c14e3410 f0821e04 f0821de8
[   14.139950] 1de0: c0596fe8 c0596ec0 00000000 c14e3410 c10da898 c059741c f0821e2c f0821e08
[   14.166351] 1e00: c0597490 c0596fb4 c1546ab4 c1004ec8 c10da898 c059741c c20d7ab8 c0c47d54
[   14.192790] 1e20: f0821e5c f0821e30 c0594c2c c0597428 f0821e68 c14f7858 c1546ab4 b4aeb193
[   14.219273] 1e40: c10da898 c10cf808 c20d7a80 00000000 f0821e6c f0821e60 c0596528 c0594bb4
[   14.245875] 1e60: f0821e9c f0821e70 c0595e60 c0596508 c0b7b7c8 00000000 f0821e9c c10da898
[   14.272550] 1e80: c1004ec8 c0c28e84 00000000 c1456854 f0821eb4 f0821ea0 c0597c80 c0595cc0
[   14.299270] 1ea0: c110cec0 c1004ec8 f0821ec4 f0821eb8 c0599130 c0597c08 f0821ed4 f0821ec8
[   14.326125] 1ec0: c0c28ea8 c0599110 f0821f4c f0821ed8 c0102180 c0c28e90 c03318e4 c0b14f30
[   14.352912] 1ee0: c0b14f10 c0b14f00 c0b2bc78 c1004ec8 00000000 c0b855d0 00000006 00000006
[   14.379805] 1f00: 00000000 c0b76eb0 c0c0055c c0bebf78 c0953a9c c154665b 00000000 b4aeb193
[   14.406665] 1f20: c0181cb8 b4aeb193 000000c6 c0c82160 00000007 c0c47d34 c1546600 000000c6
[   14.433661] 1f40: f0821f94 f0821f50 c0c01a48 c0102134 00000006 00000006 00000000 c0c0055c
[   14.460621] 1f60: c0c0055c c0bebf78 c1588000 00004ec0 c096ea48 00000000 00000000 00000000
[   14.487681] 1f80: 00000000 00000000 f0821fac f0821f98 c096ea6c c0c01884 00000000 c096ea48
[   14.514695] 1fa0: 00000000 f0821fb0 c0100148 c096ea54 00000000 00000000 00000000 00000000
[   14.541771] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   14.568615] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   14.595194] Backtrace: 
[   14.615207]  cpufreq_online from cpufreq_add_dev+0x78/0x84
[   14.638819]  r10:c1004f14 r9:c1005058 r8:c10da884 r7:c20d7b40 r6:c1004ec8 r5:ef7c5050
[   14.665198]  r4:00000000
[   14.685514]  cpufreq_add_dev from subsys_interface_register+0xb0/0xfc
[   14.710558]  r5:c10cf8a8 r4:c10da570
[   14.732076]  subsys_interface_register from cpufreq_register_driver+0x150/0x2d8
[   14.758094]  r6:c10da434 r5:c115ef18 r4:c10da900
[   14.780943]  cpufreq_register_driver from dt_cpufreq_probe+0x324/0x49c
[   14.806283]  r6:ef7c5050 r5:c10da8ec r4:00000002
[   14.829299]  dt_cpufreq_probe from platform_probe+0x6c/0xc8
[   14.853499]  r10:c111b000 r9:c0c47d54 r8:c20d7ab8 r7:00000000 r6:c10da898 r5:00000000
[   14.880388]  r4:c14e3410
[   14.901252]  platform_probe from really_probe+0xd8/0x2bc
[   14.925473]  r7:00000000 r6:c10da898 r5:00000000 r4:c14e3410
[   14.949898]  really_probe from __driver_probe_device+0xd8/0xf4
[   14.974546]  r7:00000000 r6:c14e3410 r5:c10da898 r4:c14e3410
[   14.998855]  __driver_probe_device from driver_probe_device+0x40/0xd0
[   15.024426]  r5:c14e3410 r4:c115dd68
[   15.046857]  driver_probe_device from __driver_attach+0x74/0x120
[   15.072380]  r7:c059741c r6:c10da898 r5:c14e3410 r4:00000000
[   15.097388]  __driver_attach from bus_for_each_dev+0x84/0xc4
[   15.122444]  r9:c0c47d54 r8:c20d7ab8 r7:c059741c r6:c10da898 r5:c1004ec8 r4:c1546ab4
[   15.150131]  bus_for_each_dev from driver_attach+0x2c/0x30
[   15.175532]  r7:00000000 r6:c20d7a80 r5:c10cf808 r4:c10da898
[   15.201134]  driver_attach from bus_add_driver+0x1ac/0x1f8
[   15.226772]  bus_add_driver from driver_register+0x84/0x11c
[   15.252559]  r8:c1456854 r7:00000000 r6:c0c28e84 r5:c1004ec8 r4:c10da898
[   15.279483]  driver_register from __platform_driver_register+0x2c/0x34
[   15.306523]  r5:c1004ec8 r4:c110cec0
[   15.329801]  __platform_driver_register from dt_cpufreq_platdrv_init+0x24/0x28
[   15.357500]  dt_cpufreq_platdrv_init from do_one_initcall+0x58/0x20c
[   15.384159]  do_one_initcall from kernel_init_freeable+0x1d0/0x22c
[   15.410635]  r8:000000c6 r7:c1546600 r6:c0c47d34 r5:00000007 r4:c0c82160
[   15.437567]  kernel_init_freeable from kernel_init+0x24/0x144
[   15.463573]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c096ea48
[   15.491869]  r4:00004ec0
[   15.514022]  kernel_init from ret_from_fork+0x14/0x2c
[   15.539079] Exception stack(0xf0821fb0 to 0xf0821ff8)
[   15.563943] 1fa0:                                     00000000 00000000 00000000 00000000
[   15.592459] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   15.620836] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   15.647222]  r5:c096ea48 r4:00000000
[   15.670196] Code: e1a00004 ebfff74d e3500000 0a00001a (e7f001f2) 
[   15.696086] ---[ end trace 0000000000000000 ]---
[   15.720522] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   15.748404] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


On 4/6/21 15:00, Andrea Merello wrote:
> This patch adds rate change notification support for the parent clock;
> should that clock change, then we try to adjust the our prescaler in order
> to compensate (i.e. we adjust to still get the same timer frequency).
> 
> This is loosely based on what it's done in timer-cadence-ttc. timer-sun51,
> mips-gic-timer and smp_twd.c also seem to look at their parent clock rate
> and to perform some kind of adjustment whenever needed.
> 
> In this particular case we have only one single counter and prescaler for
> all clocksource, clockevent and timer_delay, and we just update it for all
> (i.e. we don't let it go and call clockevents_update_freq() to notify to
> the kernel that our rate has changed).
> 
> Note that, there is apparently no other way to fixup things, because once
> we call register_current_timer_delay(), specifying the timer rate, it seems
> that that rate is not supposed to change ever.
> 
> In order for this mechanism to work, we have to make assumptions about how
> much the initial clock is supposed to eventually decrease from the initial
> one, and set our initial prescaler to a value that we can eventually
> decrease enough to compensate. We provide an option in KConfig for this.
> 
> In case we end up in a situation in which we are not able to compensate the
> parent clock change, we fail returning NOTIFY_BAD.
> 
> This fixes a real-world problem with Zynq arch not being able to use this
> driver and CPU_FREQ at the same time (because ARM global timer is fed by
> the CPU clock, which may keep changing when CPU_FREQ is enabled).
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/clocksource/Kconfig            |  13 +++
>  drivers/clocksource/arm_global_timer.c | 122 +++++++++++++++++++++++--
>  2 files changed, 125 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d01e05..19fc5f8883e0 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -358,6 +358,19 @@ config ARM_GLOBAL_TIMER
>  	help
>  	  This option enables support for the ARM global timer unit.
>  
> +config ARM_GT_INITIAL_PRESCALER_VAL
> +	int "ARM global timer initial prescaler value"
> +	default 1
> +	depends on ARM_GLOBAL_TIMER
> +	help
> +	  When the ARM global timer initializes, its current rate is declared
> +	  to the kernel and maintained forever. Should it's parent clock
> +	  change, the driver tries to fix the timer's internal prescaler.
> +	  On some machs (i.e. Zynq) the initial prescaler value thus poses
> +	  bounds about how much the parent clock is allowed to decrease or
> +	  increase wrt the initial clock value.
> +	  This affects CPU_FREQ max delta from the initial frequency.
> +
>  config ARM_TIMER_SP804
>  	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
>  	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 88b2d38a7a61..60a8047fd32e 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -31,6 +31,10 @@
>  #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
>  #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
>  #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
> +#define GT_CONTROL_PRESCALER_SHIFT      8
> +#define GT_CONTROL_PRESCALER_MAX        0xF
> +#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
> +					 GT_CONTROL_PRESCALER_SHIFT)
>  
>  #define GT_INT_STATUS	0x0c
>  #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
> @@ -39,6 +43,7 @@
>  #define GT_COMP1	0x14
>  #define GT_AUTO_INC	0x18
>  
> +#define MAX_F_ERR 50
>  /*
>   * We are expecting to be clocked by the ARM peripheral clock.
>   *
> @@ -46,7 +51,8 @@
>   * the units for all operations.
>   */
>  static void __iomem *gt_base;
> -static unsigned long gt_clk_rate;
> +struct notifier_block gt_clk_rate_change_nb;
> +static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
>  static int gt_ppi;
>  static struct clock_event_device __percpu *gt_evt;
>  
> @@ -96,7 +102,10 @@ static void gt_compare_set(unsigned long delta, int periodic)
>  	unsigned long ctrl;
>  
>  	counter += delta;
> -	ctrl = GT_CONTROL_TIMER_ENABLE;
> +	ctrl = readl(gt_base + GT_CONTROL);
> +	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
> +		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
> +	ctrl |= GT_CONTROL_TIMER_ENABLE;
>  	writel_relaxed(ctrl, gt_base + GT_CONTROL);
>  	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
>  	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
> @@ -123,7 +132,7 @@ static int gt_clockevent_shutdown(struct clock_event_device *evt)
>  
>  static int gt_clockevent_set_periodic(struct clock_event_device *evt)
>  {
> -	gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
> +	gt_compare_set(DIV_ROUND_CLOSEST(gt_target_rate, HZ), 1);
>  	return 0;
>  }
>  
> @@ -177,7 +186,7 @@ static int gt_starting_cpu(unsigned int cpu)
>  	clk->cpumask = cpumask_of(cpu);
>  	clk->rating = 300;
>  	clk->irq = gt_ppi;
> -	clockevents_config_and_register(clk, gt_clk_rate,
> +	clockevents_config_and_register(clk, gt_target_rate,
>  					1, 0xffffffff);
>  	enable_percpu_irq(clk->irq, IRQ_TYPE_NONE);
>  	return 0;
> @@ -232,9 +241,28 @@ static struct delay_timer gt_delay_timer = {
>  	.read_current_timer = gt_read_long,
>  };
>  
> +static void gt_write_presc(u32 psv)
> +{
> +	u32 reg;
> +
> +	reg = readl(gt_base + GT_CONTROL);
> +	reg &= ~GT_CONTROL_PRESCALER_MASK;
> +	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
> +	writel(reg, gt_base + GT_CONTROL);
> +}
> +
> +static u32 gt_read_presc(void)
> +{
> +	u32 reg;
> +
> +	reg = readl(gt_base + GT_CONTROL);
> +	reg &= GT_CONTROL_PRESCALER_MASK;
> +	return reg >> GT_CONTROL_PRESCALER_SHIFT;
> +}
> +
>  static void __init gt_delay_timer_init(void)
>  {
> -	gt_delay_timer.freq = gt_clk_rate;
> +	gt_delay_timer.freq = gt_target_rate;
>  	register_current_timer_delay(&gt_delay_timer);
>  }
>  
> @@ -243,18 +271,81 @@ static int __init gt_clocksource_init(void)
>  	writel(0, gt_base + GT_CONTROL);
>  	writel(0, gt_base + GT_COUNTER0);
>  	writel(0, gt_base + GT_COUNTER1);
> -	/* enables timer on all the cores */
> -	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> +	/* set prescaler and enable timer on all the cores */
> +	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
> +		GT_CONTROL_PRESCALER_SHIFT)
> +	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>  
>  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> -	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
> +	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
>  #endif
> -	return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
> +	return clocksource_register_hz(&gt_clocksource, gt_target_rate);
> +}
> +
> +static int gt_clk_rate_change_cb(struct notifier_block *nb,
> +				 unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +
> +	switch (event) {
> +	case PRE_RATE_CHANGE:
> +	{
> +		int psv;
> +

> +		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
> +					gt_target_rate);
> +

> +		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
> +			return NOTIFY_BAD;

This psv variable can become a 0 divider.

> +
> +		psv--;
> +
> +		/* prescaler within legal range? */
> +		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> +			return NOTIFY_BAD;
> +
> +		/*
> +		 * store timer clock ctrl register so we can restore it in case
> +		 * of an abort.
> +		 */
> +		gt_psv_bck = gt_read_presc();
> +		gt_psv_new = psv;
> +		/* scale down: adjust divider in post-change notification */
> +		if (ndata->new_rate < ndata->old_rate)
> +			return NOTIFY_DONE;
> +
> +		/* scale up: adjust divider now - before frequency change */
> +		gt_write_presc(psv);
> +		break;
> +	}
> +	case POST_RATE_CHANGE:
> +		/* scale up: pre-change notification did the adjustment */
> +		if (ndata->new_rate > ndata->old_rate)
> +			return NOTIFY_OK;
> +
> +		/* scale down: adjust divider now - after frequency change */
> +		gt_write_presc(gt_psv_new);
> +		break;
> +
> +	case ABORT_RATE_CHANGE:
> +		/* we have to undo the adjustment in case we scale up */
> +		if (ndata->new_rate < ndata->old_rate)
> +			return NOTIFY_OK;
> +
> +		/* restore original register value */
> +		gt_write_presc(gt_psv_bck);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_DONE;
>  }
>  
>  static int __init global_timer_of_register(struct device_node *np)
>  {
>  	struct clk *gt_clk;
> +	static unsigned long gt_clk_rate;
>  	int err = 0;
>  
>  	/*
> @@ -292,11 +383,20 @@ static int __init global_timer_of_register(struct device_node *np)
>  	}
>  
>  	gt_clk_rate = clk_get_rate(gt_clk);
> +	gt_target_rate = gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
> +	gt_clk_rate_change_nb.notifier_call =
> +		gt_clk_rate_change_cb;
> +	err = clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
> +	if (err) {
> +		pr_warn("Unable to register clock notifier\n");
> +		goto out_clk;
> +	}
> +
>  	gt_evt = alloc_percpu(struct clock_event_device);
>  	if (!gt_evt) {
>  		pr_warn("global-timer: can't allocate memory\n");
>  		err = -ENOMEM;
> -		goto out_clk;
> +		goto out_clk_nb;
>  	}
>  
>  	err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
> @@ -326,6 +426,8 @@ static int __init global_timer_of_register(struct device_node *np)
>  	free_percpu_irq(gt_ppi, gt_evt);
>  out_free:
>  	free_percpu(gt_evt);
> +out_clk_nb:
> +	clk_notifier_unregister(gt_clk, &gt_clk_rate_change_nb);
>  out_clk:
>  	clk_disable_unprepare(gt_clk);
>  out_unmap:
--------------eANQyjHRzIHbujtCvpIyYAdH
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0001-Revert-clocksource-drivers-arm_global_timer-Remov.patch"
Content-Disposition: attachment;
 filename*0="v2-0001-Revert-clocksource-drivers-arm_global_timer-Remov.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMjgzNTIxZGY5MDBiZTUyMDVhYjZkN2YyZTYyYWUxMTc3MGU4ZjU2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbiBKb25rZXIgPGpieDYyNDRAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEzIE9jdCAyMDIyIDIwOjM0OjMwICswMjAwClN1YmplY3Q6IFtQQVRD
SCB2MiAxLzVdIFJldmVydCAiY2xvY2tzb3VyY2UvZHJpdmVycy9hcm1fZ2xvYmFsX3RpbWVy
OiBSZW1vdmUKIGR1cGxpY2F0ZWQgYXJndW1lbnQgaW4gYXJtX2dsb2JhbF90aW1lciIKClRo
aXMgcmV2ZXJ0cyBjb21taXQgZjk0YmMyNjY3ZmIyMDRkN2MxMzFhYzM5ZDllYTM0MmJkMTYx
MTZkYy4KLS0tCiBkcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9nbG9iYWxfdGltZXIuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2dsb2JhbF90aW1lci5jIGIvZHJp
dmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVyLmMKaW5kZXggNDRhNjFkYzZmOTMy
Li42OGIxZDE0NGE0MTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2ds
b2JhbF90aW1lci5jCisrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2dsb2JhbF90aW1l
ci5jCkBAIC0xMDQsNyArMTA0LDcgQEAgc3RhdGljIHZvaWQgZ3RfY29tcGFyZV9zZXQodW5z
aWduZWQgbG9uZyBkZWx0YSwgaW50IHBlcmlvZGljKQogCWNvdW50ZXIgKz0gZGVsdGE7CiAJ
Y3RybCA9IHJlYWRsKGd0X2Jhc2UgKyBHVF9DT05UUk9MKTsKIAljdHJsICY9IH4oR1RfQ09O
VFJPTF9DT01QX0VOQUJMRSB8IEdUX0NPTlRST0xfSVJRX0VOQUJMRSB8Ci0JCSAgR1RfQ09O
VFJPTF9BVVRPX0lOQyk7CisJCSAgR1RfQ09OVFJPTF9BVVRPX0lOQyB8IEdUX0NPTlRST0xf
QVVUT19JTkMpOwogCWN0cmwgfD0gR1RfQ09OVFJPTF9USU1FUl9FTkFCTEU7CiAJd3JpdGVs
X3JlbGF4ZWQoY3RybCwgZ3RfYmFzZSArIEdUX0NPTlRST0wpOwogCXdyaXRlbF9yZWxheGVk
KGxvd2VyXzMyX2JpdHMoY291bnRlciksIGd0X2Jhc2UgKyBHVF9DT01QMCk7Ci0tIAoyLjIw
LjEKCg==
--------------eANQyjHRzIHbujtCvpIyYAdH
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0002-Revert-clocksource-drivers-arm_global_timer-Make-.patch"
Content-Disposition: attachment;
 filename*0="v2-0002-Revert-clocksource-drivers-arm_global_timer-Make-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxYzFlZDY1OTI4MDM4MzIxZmE5MmU4OGQ2NzMyOWUyNTVlYzc3MTQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbiBKb25rZXIgPGpieDYyNDRAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEzIE9jdCAyMDIyIDIwOjM2OjM1ICswMjAwClN1YmplY3Q6IFtQQVRD
SCB2MiAyLzVdIFJldmVydCAiY2xvY2tzb3VyY2UvZHJpdmVycy9hcm1fZ2xvYmFsX3RpbWVy
OiBNYWtlCiBzeW1ib2wgJ2d0X2Nsa19yYXRlX2NoYW5nZV9uYicgc3RhdGljIgoKVGhpcyBy
ZXZlcnRzIGNvbW1pdCBiZTUzNGY4ZWUxMzdiOTUwNDZkN2M1M2M4MjAwZmZkY2YwNTc4MWE3
LgotLS0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2dsb2JhbF90aW1lci5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVyLmMgYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL2FybV9nbG9iYWxfdGltZXIuYwppbmRleCA2OGIxZDE0NGE0MTIuLjYw
YTgwNDdmZDMyZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFs
X3RpbWVyLmMKKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVyLmMK
QEAgLTUxLDcgKzUxLDcgQEAKICAqIHRoZSB1bml0cyBmb3IgYWxsIG9wZXJhdGlvbnMuCiAg
Ki8KIHN0YXRpYyB2b2lkIF9faW9tZW0gKmd0X2Jhc2U7Ci1zdGF0aWMgc3RydWN0IG5vdGlm
aWVyX2Jsb2NrIGd0X2Nsa19yYXRlX2NoYW5nZV9uYjsKK3N0cnVjdCBub3RpZmllcl9ibG9j
ayBndF9jbGtfcmF0ZV9jaGFuZ2VfbmI7CiBzdGF0aWMgdTMyIGd0X3Bzdl9uZXcsIGd0X3Bz
dl9iY2ssIGd0X3RhcmdldF9yYXRlOwogc3RhdGljIGludCBndF9wcGk7CiBzdGF0aWMgc3Ry
dWN0IGNsb2NrX2V2ZW50X2RldmljZSBfX3BlcmNwdSAqZ3RfZXZ0OwotLSAKMi4yMC4xCgo=

--------------eANQyjHRzIHbujtCvpIyYAdH
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0003-Revert-clocksource-drivers-arm_global_timer-Imple.patch"
Content-Disposition: attachment;
 filename*0="v2-0003-Revert-clocksource-drivers-arm_global_timer-Imple.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3NDJjNGNjMTg1M2UyNTI5ZDdiMGQwMjBjMDM4NzAzOGY5NzliZjA3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbiBKb25rZXIgPGpieDYyNDRAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEzIE9jdCAyMDIyIDIwOjQ1OjM3ICswMjAwClN1YmplY3Q6IFtQQVRD
SCB2MiAzLzVdIFJldmVydCAiY2xvY2tzb3VyY2UvZHJpdmVycy9hcm1fZ2xvYmFsX3RpbWVy
OgogSW1wbGVtZW50IHJhdGUgY29tcGVuc2F0aW9uIHdoZW5ldmVyIHNvdXJjZSBjbG9jayBj
aGFuZ2VzIgoKVGhpcyByZXZlcnRzIGNvbW1pdCAxNzFiNDVhNGE3MGVlZjJmZDM2YmI3OTRj
ZTRmNWE0OGM0NDAzNjFlLgotLS0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyAgICAg
ICAgICAgIHwgIDE0IC0tLQogZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVy
LmMgfCAxMjIgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAxMjYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbG9ja3NvdXJjZS9LY29uZmlnIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnCmlu
ZGV4IDQ0NjllN2Y1NTVlOS4uN2IwMGVmYTU5ZmZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Ns
b2Nrc291cmNlL0tjb25maWcKKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnCkBA
IC0zNzUsMjAgKzM3NSw2IEBAIGNvbmZpZyBBUk1fR0xPQkFMX1RJTUVSCiAJaGVscAogCSAg
VGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgQVJNIGdsb2JhbCB0aW1lciB1
bml0LgogCi1jb25maWcgQVJNX0dUX0lOSVRJQUxfUFJFU0NBTEVSX1ZBTAotCWludCAiQVJN
IGdsb2JhbCB0aW1lciBpbml0aWFsIHByZXNjYWxlciB2YWx1ZSIKLQlkZWZhdWx0IDIgaWYg
QVJDSF9aWU5RCi0JZGVmYXVsdCAxCi0JZGVwZW5kcyBvbiBBUk1fR0xPQkFMX1RJTUVSCi0J
aGVscAotCSAgV2hlbiB0aGUgQVJNIGdsb2JhbCB0aW1lciBpbml0aWFsaXplcywgaXRzIGN1
cnJlbnQgcmF0ZSBpcyBkZWNsYXJlZAotCSAgdG8gdGhlIGtlcm5lbCBhbmQgbWFpbnRhaW5l
ZCBmb3JldmVyLiBTaG91bGQgaXRzIHBhcmVudCBjbG9jawotCSAgY2hhbmdlLCB0aGUgZHJp
dmVyIHRyaWVzIHRvIGZpeCB0aGUgdGltZXIncyBpbnRlcm5hbCBwcmVzY2FsZXIuCi0JICBP
biBzb21lIG1hY2hzIChpLmUuIFp5bnEpIHRoZSBpbml0aWFsIHByZXNjYWxlciB2YWx1ZSB0
aHVzIHBvc2VzCi0JICBib3VuZHMgYWJvdXQgaG93IG11Y2ggdGhlIHBhcmVudCBjbG9jayBp
cyBhbGxvd2VkIHRvIGRlY3JlYXNlIG9yCi0JICBpbmNyZWFzZSB3cnQgdGhlIGluaXRpYWwg
Y2xvY2sgdmFsdWUuCi0JICBUaGlzIGFmZmVjdHMgQ1BVX0ZSRVEgbWF4IGRlbHRhIGZyb20g
dGhlIGluaXRpYWwgZnJlcXVlbmN5LgotCiBjb25maWcgQVJNX1RJTUVSX1NQODA0CiAJYm9v
bCAiU3VwcG9ydCBmb3IgRHVhbCBUaW1lciBTUDgwNCBtb2R1bGUiIGlmIENPTVBJTEVfVEVT
VAogCWRlcGVuZHMgb24gR0VORVJJQ19TQ0hFRF9DTE9DSyAmJiBIQVZFX0NMSwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVyLmMgYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL2FybV9nbG9iYWxfdGltZXIuYwppbmRleCA2MGE4MDQ3ZmQzMmUuLjg4
YjJkMzhhN2E2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFs
X3RpbWVyLmMKKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fZ2xvYmFsX3RpbWVyLmMK
QEAgLTMxLDEwICszMSw2IEBACiAjZGVmaW5lIEdUX0NPTlRST0xfQ09NUF9FTkFCTEUJCUJJ
VCgxKQkvKiBiYW5rZWQgKi8KICNkZWZpbmUgR1RfQ09OVFJPTF9JUlFfRU5BQkxFCQlCSVQo
MikJLyogYmFua2VkICovCiAjZGVmaW5lIEdUX0NPTlRST0xfQVVUT19JTkMJCUJJVCgzKQkv
KiBiYW5rZWQgKi8KLSNkZWZpbmUgR1RfQ09OVFJPTF9QUkVTQ0FMRVJfU0hJRlQgICAgICA4
Ci0jZGVmaW5lIEdUX0NPTlRST0xfUFJFU0NBTEVSX01BWCAgICAgICAgMHhGCi0jZGVmaW5l
IEdUX0NPTlRST0xfUFJFU0NBTEVSX01BU0sgICAgICAgKEdUX0NPTlRST0xfUFJFU0NBTEVS
X01BWCA8PCBcCi0JCQkJCSBHVF9DT05UUk9MX1BSRVNDQUxFUl9TSElGVCkKIAogI2RlZmlu
ZSBHVF9JTlRfU1RBVFVTCTB4MGMKICNkZWZpbmUgR1RfSU5UX1NUQVRVU19FVkVOVF9GTEFH
CUJJVCgwKQpAQCAtNDMsNyArMzksNiBAQAogI2RlZmluZSBHVF9DT01QMQkweDE0CiAjZGVm
aW5lIEdUX0FVVE9fSU5DCTB4MTgKIAotI2RlZmluZSBNQVhfRl9FUlIgNTAKIC8qCiAgKiBX
ZSBhcmUgZXhwZWN0aW5nIHRvIGJlIGNsb2NrZWQgYnkgdGhlIEFSTSBwZXJpcGhlcmFsIGNs
b2NrLgogICoKQEAgLTUxLDggKzQ2LDcgQEAKICAqIHRoZSB1bml0cyBmb3IgYWxsIG9wZXJh
dGlvbnMuCiAgKi8KIHN0YXRpYyB2b2lkIF9faW9tZW0gKmd0X2Jhc2U7Ci1zdHJ1Y3Qgbm90
aWZpZXJfYmxvY2sgZ3RfY2xrX3JhdGVfY2hhbmdlX25iOwotc3RhdGljIHUzMiBndF9wc3Zf
bmV3LCBndF9wc3ZfYmNrLCBndF90YXJnZXRfcmF0ZTsKK3N0YXRpYyB1bnNpZ25lZCBsb25n
IGd0X2Nsa19yYXRlOwogc3RhdGljIGludCBndF9wcGk7CiBzdGF0aWMgc3RydWN0IGNsb2Nr
X2V2ZW50X2RldmljZSBfX3BlcmNwdSAqZ3RfZXZ0OwogCkBAIC0xMDIsMTAgKzk2LDcgQEAg
c3RhdGljIHZvaWQgZ3RfY29tcGFyZV9zZXQodW5zaWduZWQgbG9uZyBkZWx0YSwgaW50IHBl
cmlvZGljKQogCXVuc2lnbmVkIGxvbmcgY3RybDsKIAogCWNvdW50ZXIgKz0gZGVsdGE7Ci0J
Y3RybCA9IHJlYWRsKGd0X2Jhc2UgKyBHVF9DT05UUk9MKTsKLQljdHJsICY9IH4oR1RfQ09O
VFJPTF9DT01QX0VOQUJMRSB8IEdUX0NPTlRST0xfSVJRX0VOQUJMRSB8Ci0JCSAgR1RfQ09O
VFJPTF9BVVRPX0lOQyB8IEdUX0NPTlRST0xfQVVUT19JTkMpOwotCWN0cmwgfD0gR1RfQ09O
VFJPTF9USU1FUl9FTkFCTEU7CisJY3RybCA9IEdUX0NPTlRST0xfVElNRVJfRU5BQkxFOwog
CXdyaXRlbF9yZWxheGVkKGN0cmwsIGd0X2Jhc2UgKyBHVF9DT05UUk9MKTsKIAl3cml0ZWxf
cmVsYXhlZChsb3dlcl8zMl9iaXRzKGNvdW50ZXIpLCBndF9iYXNlICsgR1RfQ09NUDApOwog
CXdyaXRlbF9yZWxheGVkKHVwcGVyXzMyX2JpdHMoY291bnRlciksIGd0X2Jhc2UgKyBHVF9D
T01QMSk7CkBAIC0xMzIsNyArMTIzLDcgQEAgc3RhdGljIGludCBndF9jbG9ja2V2ZW50X3No
dXRkb3duKHN0cnVjdCBjbG9ja19ldmVudF9kZXZpY2UgKmV2dCkKIAogc3RhdGljIGludCBn
dF9jbG9ja2V2ZW50X3NldF9wZXJpb2RpYyhzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpl
dnQpCiB7Ci0JZ3RfY29tcGFyZV9zZXQoRElWX1JPVU5EX0NMT1NFU1QoZ3RfdGFyZ2V0X3Jh
dGUsIEhaKSwgMSk7CisJZ3RfY29tcGFyZV9zZXQoRElWX1JPVU5EX0NMT1NFU1QoZ3RfY2xr
X3JhdGUsIEhaKSwgMSk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTE4Niw3ICsxNzcsNyBAQCBz
dGF0aWMgaW50IGd0X3N0YXJ0aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1KQogCWNsay0+Y3B1
bWFzayA9IGNwdW1hc2tfb2YoY3B1KTsKIAljbGstPnJhdGluZyA9IDMwMDsKIAljbGstPmly
cSA9IGd0X3BwaTsKLQljbG9ja2V2ZW50c19jb25maWdfYW5kX3JlZ2lzdGVyKGNsaywgZ3Rf
dGFyZ2V0X3JhdGUsCisJY2xvY2tldmVudHNfY29uZmlnX2FuZF9yZWdpc3RlcihjbGssIGd0
X2Nsa19yYXRlLAogCQkJCQkxLCAweGZmZmZmZmZmKTsKIAllbmFibGVfcGVyY3B1X2lycShj
bGstPmlycSwgSVJRX1RZUEVfTk9ORSk7CiAJcmV0dXJuIDA7CkBAIC0yNDEsMjggKzIzMiw5
IEBAIHN0YXRpYyBzdHJ1Y3QgZGVsYXlfdGltZXIgZ3RfZGVsYXlfdGltZXIgPSB7CiAJLnJl
YWRfY3VycmVudF90aW1lciA9IGd0X3JlYWRfbG9uZywKIH07CiAKLXN0YXRpYyB2b2lkIGd0
X3dyaXRlX3ByZXNjKHUzMiBwc3YpCi17Ci0JdTMyIHJlZzsKLQotCXJlZyA9IHJlYWRsKGd0
X2Jhc2UgKyBHVF9DT05UUk9MKTsKLQlyZWcgJj0gfkdUX0NPTlRST0xfUFJFU0NBTEVSX01B
U0s7Ci0JcmVnIHw9IHBzdiA8PCBHVF9DT05UUk9MX1BSRVNDQUxFUl9TSElGVDsKLQl3cml0
ZWwocmVnLCBndF9iYXNlICsgR1RfQ09OVFJPTCk7Ci19Ci0KLXN0YXRpYyB1MzIgZ3RfcmVh
ZF9wcmVzYyh2b2lkKQotewotCXUzMiByZWc7Ci0KLQlyZWcgPSByZWFkbChndF9iYXNlICsg
R1RfQ09OVFJPTCk7Ci0JcmVnICY9IEdUX0NPTlRST0xfUFJFU0NBTEVSX01BU0s7Ci0JcmV0
dXJuIHJlZyA+PiBHVF9DT05UUk9MX1BSRVNDQUxFUl9TSElGVDsKLX0KLQogc3RhdGljIHZv
aWQgX19pbml0IGd0X2RlbGF5X3RpbWVyX2luaXQodm9pZCkKIHsKLQlndF9kZWxheV90aW1l
ci5mcmVxID0gZ3RfdGFyZ2V0X3JhdGU7CisJZ3RfZGVsYXlfdGltZXIuZnJlcSA9IGd0X2Ns
a19yYXRlOwogCXJlZ2lzdGVyX2N1cnJlbnRfdGltZXJfZGVsYXkoJmd0X2RlbGF5X3RpbWVy
KTsKIH0KIApAQCAtMjcxLDgxICsyNDMsMTggQEAgc3RhdGljIGludCBfX2luaXQgZ3RfY2xv
Y2tzb3VyY2VfaW5pdCh2b2lkKQogCXdyaXRlbCgwLCBndF9iYXNlICsgR1RfQ09OVFJPTCk7
CiAJd3JpdGVsKDAsIGd0X2Jhc2UgKyBHVF9DT1VOVEVSMCk7CiAJd3JpdGVsKDAsIGd0X2Jh
c2UgKyBHVF9DT1VOVEVSMSk7Ci0JLyogc2V0IHByZXNjYWxlciBhbmQgZW5hYmxlIHRpbWVy
IG9uIGFsbCB0aGUgY29yZXMgKi8KLQl3cml0ZWwoKChDT05GSUdfQVJNX0dUX0lOSVRJQUxf
UFJFU0NBTEVSX1ZBTCAtIDEpIDw8Ci0JCUdUX0NPTlRST0xfUFJFU0NBTEVSX1NISUZUKQot
CSAgICAgICB8IEdUX0NPTlRST0xfVElNRVJfRU5BQkxFLCBndF9iYXNlICsgR1RfQ09OVFJP
TCk7CisJLyogZW5hYmxlcyB0aW1lciBvbiBhbGwgdGhlIGNvcmVzICovCisJd3JpdGVsKEdU
X0NPTlRST0xfVElNRVJfRU5BQkxFLCBndF9iYXNlICsgR1RfQ09OVFJPTCk7CiAKICNpZmRl
ZiBDT05GSUdfQ0xLU1JDX0FSTV9HTE9CQUxfVElNRVJfU0NIRURfQ0xPQ0sKLQlzY2hlZF9j
bG9ja19yZWdpc3RlcihndF9zY2hlZF9jbG9ja19yZWFkLCA2NCwgZ3RfdGFyZ2V0X3JhdGUp
OworCXNjaGVkX2Nsb2NrX3JlZ2lzdGVyKGd0X3NjaGVkX2Nsb2NrX3JlYWQsIDY0LCBndF9j
bGtfcmF0ZSk7CiAjZW5kaWYKLQlyZXR1cm4gY2xvY2tzb3VyY2VfcmVnaXN0ZXJfaHooJmd0
X2Nsb2Nrc291cmNlLCBndF90YXJnZXRfcmF0ZSk7Ci19Ci0KLXN0YXRpYyBpbnQgZ3RfY2xr
X3JhdGVfY2hhbmdlX2NiKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsCi0JCQkJIHVuc2ln
bmVkIGxvbmcgZXZlbnQsIHZvaWQgKmRhdGEpCi17Ci0Jc3RydWN0IGNsa19ub3RpZmllcl9k
YXRhICpuZGF0YSA9IGRhdGE7Ci0KLQlzd2l0Y2ggKGV2ZW50KSB7Ci0JY2FzZSBQUkVfUkFU
RV9DSEFOR0U6Ci0JewotCQlpbnQgcHN2OwotCi0JCXBzdiA9IERJVl9ST1VORF9DTE9TRVNU
KG5kYXRhLT5uZXdfcmF0ZSwKLQkJCQkJZ3RfdGFyZ2V0X3JhdGUpOwotCi0JCWlmIChhYnMo
Z3RfdGFyZ2V0X3JhdGUgLSAobmRhdGEtPm5ld19yYXRlIC8gcHN2KSkgPiBNQVhfRl9FUlIp
Ci0JCQlyZXR1cm4gTk9USUZZX0JBRDsKLQotCQlwc3YtLTsKLQotCQkvKiBwcmVzY2FsZXIg
d2l0aGluIGxlZ2FsIHJhbmdlPyAqLwotCQlpZiAocHN2IDwgMCB8fCBwc3YgPiBHVF9DT05U
Uk9MX1BSRVNDQUxFUl9NQVgpCi0JCQlyZXR1cm4gTk9USUZZX0JBRDsKLQotCQkvKgotCQkg
KiBzdG9yZSB0aW1lciBjbG9jayBjdHJsIHJlZ2lzdGVyIHNvIHdlIGNhbiByZXN0b3JlIGl0
IGluIGNhc2UKLQkJICogb2YgYW4gYWJvcnQuCi0JCSAqLwotCQlndF9wc3ZfYmNrID0gZ3Rf
cmVhZF9wcmVzYygpOwotCQlndF9wc3ZfbmV3ID0gcHN2OwotCQkvKiBzY2FsZSBkb3duOiBh
ZGp1c3QgZGl2aWRlciBpbiBwb3N0LWNoYW5nZSBub3RpZmljYXRpb24gKi8KLQkJaWYgKG5k
YXRhLT5uZXdfcmF0ZSA8IG5kYXRhLT5vbGRfcmF0ZSkKLQkJCXJldHVybiBOT1RJRllfRE9O
RTsKLQotCQkvKiBzY2FsZSB1cDogYWRqdXN0IGRpdmlkZXIgbm93IC0gYmVmb3JlIGZyZXF1
ZW5jeSBjaGFuZ2UgKi8KLQkJZ3Rfd3JpdGVfcHJlc2MocHN2KTsKLQkJYnJlYWs7Ci0JfQot
CWNhc2UgUE9TVF9SQVRFX0NIQU5HRToKLQkJLyogc2NhbGUgdXA6IHByZS1jaGFuZ2Ugbm90
aWZpY2F0aW9uIGRpZCB0aGUgYWRqdXN0bWVudCAqLwotCQlpZiAobmRhdGEtPm5ld19yYXRl
ID4gbmRhdGEtPm9sZF9yYXRlKQotCQkJcmV0dXJuIE5PVElGWV9PSzsKLQotCQkvKiBzY2Fs
ZSBkb3duOiBhZGp1c3QgZGl2aWRlciBub3cgLSBhZnRlciBmcmVxdWVuY3kgY2hhbmdlICov
Ci0JCWd0X3dyaXRlX3ByZXNjKGd0X3Bzdl9uZXcpOwotCQlicmVhazsKLQotCWNhc2UgQUJP
UlRfUkFURV9DSEFOR0U6Ci0JCS8qIHdlIGhhdmUgdG8gdW5kbyB0aGUgYWRqdXN0bWVudCBp
biBjYXNlIHdlIHNjYWxlIHVwICovCi0JCWlmIChuZGF0YS0+bmV3X3JhdGUgPCBuZGF0YS0+
b2xkX3JhdGUpCi0JCQlyZXR1cm4gTk9USUZZX09LOwotCi0JCS8qIHJlc3RvcmUgb3JpZ2lu
YWwgcmVnaXN0ZXIgdmFsdWUgKi8KLQkJZ3Rfd3JpdGVfcHJlc2MoZ3RfcHN2X2Jjayk7Ci0J
CWJyZWFrOwotCWRlZmF1bHQ6Ci0JCXJldHVybiBOT1RJRllfRE9ORTsKLQl9Ci0KLQlyZXR1
cm4gTk9USUZZX0RPTkU7CisJcmV0dXJuIGNsb2Nrc291cmNlX3JlZ2lzdGVyX2h6KCZndF9j
bG9ja3NvdXJjZSwgZ3RfY2xrX3JhdGUpOwogfQogCiBzdGF0aWMgaW50IF9faW5pdCBnbG9i
YWxfdGltZXJfb2ZfcmVnaXN0ZXIoc3RydWN0IGRldmljZV9ub2RlICpucCkKIHsKIAlzdHJ1
Y3QgY2xrICpndF9jbGs7Ci0Jc3RhdGljIHVuc2lnbmVkIGxvbmcgZ3RfY2xrX3JhdGU7CiAJ
aW50IGVyciA9IDA7CiAKIAkvKgpAQCAtMzgzLDIwICsyOTIsMTEgQEAgc3RhdGljIGludCBf
X2luaXQgZ2xvYmFsX3RpbWVyX29mX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAp
CiAJfQogCiAJZ3RfY2xrX3JhdGUgPSBjbGtfZ2V0X3JhdGUoZ3RfY2xrKTsKLQlndF90YXJn
ZXRfcmF0ZSA9IGd0X2Nsa19yYXRlIC8gQ09ORklHX0FSTV9HVF9JTklUSUFMX1BSRVNDQUxF
Ul9WQUw7Ci0JZ3RfY2xrX3JhdGVfY2hhbmdlX25iLm5vdGlmaWVyX2NhbGwgPQotCQlndF9j
bGtfcmF0ZV9jaGFuZ2VfY2I7Ci0JZXJyID0gY2xrX25vdGlmaWVyX3JlZ2lzdGVyKGd0X2Ns
aywgJmd0X2Nsa19yYXRlX2NoYW5nZV9uYik7Ci0JaWYgKGVycikgewotCQlwcl93YXJuKCJV
bmFibGUgdG8gcmVnaXN0ZXIgY2xvY2sgbm90aWZpZXJcbiIpOwotCQlnb3RvIG91dF9jbGs7
Ci0JfQotCiAJZ3RfZXZ0ID0gYWxsb2NfcGVyY3B1KHN0cnVjdCBjbG9ja19ldmVudF9kZXZp
Y2UpOwogCWlmICghZ3RfZXZ0KSB7CiAJCXByX3dhcm4oImdsb2JhbC10aW1lcjogY2FuJ3Qg
YWxsb2NhdGUgbWVtb3J5XG4iKTsKIAkJZXJyID0gLUVOT01FTTsKLQkJZ290byBvdXRfY2xr
X25iOworCQlnb3RvIG91dF9jbGs7CiAJfQogCiAJZXJyID0gcmVxdWVzdF9wZXJjcHVfaXJx
KGd0X3BwaSwgZ3RfY2xvY2tldmVudF9pbnRlcnJ1cHQsCkBAIC00MjYsOCArMzI2LDYgQEAg
c3RhdGljIGludCBfX2luaXQgZ2xvYmFsX3RpbWVyX29mX3JlZ2lzdGVyKHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbnApCiAJZnJlZV9wZXJjcHVfaXJxKGd0X3BwaSwgZ3RfZXZ0KTsKIG91dF9m
cmVlOgogCWZyZWVfcGVyY3B1KGd0X2V2dCk7Ci1vdXRfY2xrX25iOgotCWNsa19ub3RpZmll
cl91bnJlZ2lzdGVyKGd0X2NsaywgJmd0X2Nsa19yYXRlX2NoYW5nZV9uYik7CiBvdXRfY2xr
OgogCWNsa19kaXNhYmxlX3VucHJlcGFyZShndF9jbGspOwogb3V0X3VubWFwOgotLSAKMi4y
MC4xCgo=

--------------eANQyjHRzIHbujtCvpIyYAdH--
