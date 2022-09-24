Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDB5E89E1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiIXIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiIXIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:08:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BB215566F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:06:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd10so4876681ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hCUORxR2gsZaP6lSID3ElTRBapkJH9Mu3pWzwaOrkFU=;
        b=nCxSpcfW2xAB1LM+WDhyo+eRkORIHiAW8aH4lkeb5xhpl7jxZxfqFCKVC8He6+xWo5
         d5A0FiKYY1nEjua9ehMKYXDBVolSs2TaxC6vNZCH+2cuj4YRF1PAf2drK6y3CX34PZbz
         JIkfuZfr8a1WIjF/EmoVMk/+m7lgmdRCxPmWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hCUORxR2gsZaP6lSID3ElTRBapkJH9Mu3pWzwaOrkFU=;
        b=5dP00KJV2KbG2rfjTrXGFAJYlxp9hXPsf7SLuUK9o0D2WtP58mNzWoAW8bAkYMfiVh
         YmOSW7GP0ZmOsKfbfL3m8SQRCCyK84L2xb4iMzTKMgUmo5bTJY4pPa6aP3jHvwftvKT+
         zQL8IDPrUJQo2qqpSqT8ORPbAReC0y85FzTUsSO48X6CgHo+gEmp1S1UYC3ZRswsFSni
         6atDbUAImoKxm9VgFNwLNtcJw4SwfysRPZSZda66SqhHJgLNVrNgU7/lqikKuAkGrECc
         UICtC8YtWTlMeqFg69mQsShhLNHzn+i0JJzOnuXJwpVSqzmAJYra4DgqqMDmenajfeD8
         Wygg==
X-Gm-Message-State: ACrzQf2MrrF6qrIOaDTzhY6LuD8xAE1J/CEoVtB2RcRhxR8HPMTjqYdI
        bPdj9N+YufQMIYz8kav8fQR7SB68g9hphQ==
X-Google-Smtp-Source: AMsMyM5u0ZOXdFtpe/y4U8toxktWQ7XBEnPYDqofzd8di4UM7fKqW/8xREzgoqqZgkwQv90f3RJ6lA==
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id wv13-20020a170907080d00b0073d1e3f3d83mr9872136ejb.372.1664006750106;
        Sat, 24 Sep 2022 01:05:50 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906328600b0077f5e96129fsm5130200ejw.158.2022.09.24.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:47 -0700 (PDT)
Date:   Sat, 24 Sep 2022 10:05:43 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: px30-evb crash on 6.0.0-rc6, u2phy_otg, otg-port issue
Message-ID: <20220924080543.GA506834@tom-ThinkPad-T14s-Gen-2i>
References: <20220923152000.GA444697@tom-ThinkPad-T14s-Gen-2i>
 <8735cihvzn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735cihvzn.fsf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Fri, Sep 23, 2022 at 07:48:34PM +0300, Mikhail Rudenko wrote:
> 
> Hi Tommaso,
> 
> On 2022-09-23 at 17:20 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> 
> > Hello Heiko,
> > I'm playing with px30_mini_evb_v11_20190507 board on linux 6.0.0-rc6.
> > We have some problems on "rockchip,px30-usb2phy" driver in particular in
> > u2phy_otg: otg-port node (px30-evb.dts). Disabling this I'm able to boot
> > the board:
> >
> > &u2phy {
> > 	status = "okay";
> >
> > 	u2phy_host: host-port {
> > 		status = "okay";
> > 	};
> >
> > 	u2phy_otg: otg-port {
> > 		status = "disabled";
> > 	};
> > };
> >
> > In particular we have some problems here:
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index bd0b35cac83e3..42647cd660bbf 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -4084,7 +4084,9 @@ static int clk_nodrv_prepare_enable(struct clk_hw *hw)
> >
> > static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
> > {
> >       WARN_ON_ONCE(1);
> > }
> >
> > logs:
> >
> > [    1.269466] rockchip-usb2phy: probe of ff2c0000.syscon:usb2phy@100 failed with error 1
> > [    1.279044] ------------[ cut here ]------------
> > [    1.284135] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:4087 clk_nodrv_disable_unprepare+0x4/0x10
> > [    1.293913] Modules linked in:
> > [    1.297276] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc6-00220-gb82580766e4c #147
> > [    1.306172] Hardware name: Rockchip PX30 EVB (DT)
> > [    1.311338] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    1.318993] pc : clk_nodrv_disable_unprepare+0x4/0x10
> > [    1.324549] lr : clk_core_disable+0x60/0xb8
> > [    1.329152] sp : ffff80000a5eba20
> > [    1.332793] x29: ffff80000a5eba20 x28: 0000000000000007 x27: ffff800009b96068
> > [    1.340657] x26: ffff800009ad0400 x25: ffff80000a52b000 x24: 0000000000000000
> > [    1.348516] x23: ffff0000038f5300 x22: 0000000000000000 x21: 0000000000000000
> > [    1.356376] x20: ffff0000038f5300 x19: ffff0000038f5300 x18: ffff000002c76610
> > [    1.364240] x17: 000000005a2f9018 x16: 000000008b35b0bc x15: ffff000003097740
> > [    1.372100] x14: 0000000000000000 x13: ffff000002c76610 x12: ffff0000030976c0
> > [    1.379961] x11: 000000ffffffffff x10: ffff000002c76618 x9 : ffff000002c76610
> > [    1.387822] x8 : ffff0000038f5300 x7 : ffff000002ce0000 x6 : 0000000000000000
> > [    1.395683] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000a592748
> > [    1.403545] x2 : 0000000000000001 x1 : ffff8000086d7c88 x0 : ffff00000366f8a8
> > [    1.411407] Call trace:
> > [    1.414091]  clk_nodrv_disable_unprepare+0x4/0x10
> > [    1.419269]  clk_core_disable_lock+0x24/0x40
> > [    1.423967]  clk_core_disable_unprepare+0x18/0x38
> > [    1.429145]  __clk_set_parent_after+0x60/0x68
> > [    1.433940]  clk_core_set_parent_nolock+0x160/0x250
> > [    1.439311]  clk_unregister+0xe4/0x240
> > [    1.443443]  rockchip_usb2phy_clk480m_unregister+0x28/0x38
> > [    1.449482]  devm_action_release+0x14/0x20
> > [    1.453996]  release_nodes+0x40/0x70
> > [    1.457934]  devres_release_all+0x94/0xe0
> > [    1.462344]  device_unbind_cleanup+0x18/0x68
> > [    1.467043]  really_probe+0x1d0/0x2b8
> > [    1.471070]  __driver_probe_device+0x7c/0xe8
> > [    1.475771]  driver_probe_device+0x38/0x100
> > [    1.480373]  __driver_attach+0xa8/0x138
> > [    1.484595]  bus_for_each_dev+0x7c/0xd8
> > [    1.488816]  driver_attach+0x24/0x30
> > [    1.492750]  bus_add_driver+0x15c/0x210
> > [    1.496968]  driver_register+0x64/0x120
> > [    1.501190]  __platform_driver_register+0x28/0x38
> > [    1.506367]  rockchip_usb2phy_driver_init+0x1c/0x28
> > [    1.511733]  do_one_initcall+0x60/0x1f0
> > [    1.515957]  kernel_init_freeable+0x22c/0x2a0
> > [    1.520757]  kernel_init+0x24/0x130
> > [    1.524604]  ret_from_fork+0x10/0x20
> > [    1.528539] ---[ end trace 0000000000000000 ]---
> > [    1.562178] EINJ: ACPI disabled.
> >
> > and after a bit:
> >
> > [    3.280015] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > [    3.280034] Mem abort info:
> > [    3.280037]   ESR = 0x0000000086000004
> > [    3.280041]   EC = 0x21: IABT (current EL), IL = 32 bits
> > [    3.280048]   SET = 0, FnV = 0
> > [    3.280052]   EA = 0, S1PTW = 0
> > [    3.280056]   FSC = 0x04: level 0 translation fault
> > [    3.280061] [0000000000000000] user address but active_mm is swapper
> > [    3.280069] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > [    3.280077] Modules linked in:
> > [    3.280092] CPU: 0 PID: 9 Comm: kworker/u8:0 Tainted: G        W          6.0.0-rc6-00220-gb82580766e4c #147
> > [    3.280103] Hardware name: Rockchip PX30 EVB (DT)
> > [    3.280111] Workqueue: events_unbound async_run_entry_fn
> > [    3.280140] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    3.280150] pc : 0x0
> > [    3.280160] lr : call_timer_fn.isra.30+0x24/0x80
> > [    3.280171] sp : ffff80000a62b470
> > [    3.280175] x29: ffff80000a62b470 x28: 0000000000000010 x27: 0000000000000004
> > [    3.280190] x26: 0000000000000000 x25: 0000000000000000 x24: dead000000000122
> > [    3.280204] x23: ffff800009a03000 x22: ffff80000a1d7000 x21: 0000000000000000
> > [    3.280219] x20: 0000000000000101 x19: ffff000002d78000 x18: ffffffffffffffff
> > [    3.280234] x17: ffff800075f19000 x16: ffff800008004000 x15: 00009726b6a67ac4
> > [    3.280248] x14: 00000000000000c4 x13: 00000000000000c4 x12: ffff00007fb58d40
> > [    3.280262] x11: 4200000000000000 x10: ffff00007fb52070 x9 : 0000000000000001
> > [    3.280276] x8 : 0000000000000000 x7 : ffffffffffffffff x6 : 0000000000000000
> > [    3.280290] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000200
> > [    3.280303] x2 : 000000003fffffff x1 : 0000000000000000 x0 : ffff00000366fb10
> > [    3.280318] Call trace:
> > [    3.280322]  0x0
> > [    3.280329]  run_timer_softirq+0x3c0/0x408
> > [    3.280339]  __do_softirq+0x11c/0x288
> > [    3.280348]  irq_exit_rcu+0xe8/0x108
> > [    3.280361]  el1_interrupt+0x3c/0x70
> > [    3.280374]  el1h_64_irq_handler+0x18/0x28
> > [    3.280384]  el1h_64_irq+0x64/0x68
> > [    3.280391]  console_emit_next_record.constprop.47+0x1a8/0x2c8
> > [    3.280404]  console_unlock+0x1a0/0x1e0
> > [    3.280414]  vprintk_emit+0x1c4/0x2d0
> > [    3.280423]  dev_vprintk_emit+0x148/0x178
> > [    3.280431]  dev_printk_emit+0x64/0x88
> > [    3.280439]  __dev_printk+0x5c/0x7c
> > [    3.280447]  _dev_info+0x6c/0x90
> > [    3.280455]  dw_mci_setup_bus+0x114/0x218
> > [    3.280467]  dw_mci_set_ios+0x12c/0x270
> > [    3.280475]  mmc_power_up.part.21+0xa4/0xf8
> > [    3.280486]  mmc_start_host+0xac/0xb8
> > [    3.280494]  mmc_add_host+0x7c/0xe8
> > [    3.280503]  dw_mci_probe+0x970/0xfc8
> > [    3.280511]  dw_mci_pltfm_register+0xa0/0xd8
> > [    3.280520]  dw_mci_rockchip_probe+0x84/0x148
> > [    3.280530]  platform_probe+0x68/0xe0
> > [    3.280544]  really_probe+0xc0/0x2b8
> > [    3.280552]  __driver_probe_device+0x7c/0xe8
> > [    3.280561]  driver_probe_device+0x38/0x100
> > [    3.280570]  __driver_attach_async_helper+0x30/0x58
> > [    3.280579]  async_run_entry_fn+0x30/0xd8
> > [    3.280590]  process_one_work+0x1fc/0x350
> > [    3.280601]  worker_thread+0x44/0x440
> > [    3.280609]  kthread+0x10c/0x118
> > [    3.280617]  ret_from_fork+0x10/0x20
> > [    3.280639] Code: bad PC value
> > [    3.280652] ---[ end trace 0000000000000000 ]---
> > [    3.280661] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> > [    3.280667] SMP: stopping secondary CPUs
> > [    3.280747] Kernel Offset: disabled
> > [    3.280750] CPU features: 0x0000,00000020,00001086
> > [    3.280758] Memory Limit: none
> > [    3.696667] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> >
> > I'm missing something? Let me know.
> > Thanks in advance.
> 
> I had a similar issue on Rockchip 3399 [1], maybe it is related to your case?
> 
> [1] https://lore.kernel.org/linux-phy/6779635c-a162-0b7e-d124-d88d1ed9e162@sholland.org/

^ Many Thanks! This solve the issue :)

Regards,
Tommaso

> 
> >
> > Regards,
> > Tommaso
> 
> 
> --
> Best regards,
> Mikhail Rudenko

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
