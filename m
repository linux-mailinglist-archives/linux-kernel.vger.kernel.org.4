Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9003B5BEE81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiITUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:25:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F93BC55
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:25:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l10so3535449plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=Hhzw/+V9iVrvl5RWt8Pn/WRdDYAxI/t2BJb6Fd4obMg=;
        b=8Diilrodc7suR4h15QOFnAbn0scp0txZFNuN2MUeFaRTkHy4mFRpHsIOZoV5KcTNDX
         ISCJimTPQHfhEqeGAmXJ5HEuV+L374kX6Ol+YHqeTPVrivmBj42qYPJG6YQpxWD6y1Dp
         flrOfhaZhwXLKwlijv2SmnwvSNwWZneJpNui2c6uUGXVjR/X+IYdBw+F9m+fpQrsG7Cp
         WckFZUjfrZsD8lAi54zqLYHkPjcvEDNIZMLN2GL5yumCkc1klHk48neH8Q9Bq+jrZFFw
         xWVOGMbC6PnxP3TNOGSZ2gt/sldfsz5Oh8VzuG7ELUpPtsnKmJjKSkrI/BgMMivodPeB
         YTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Hhzw/+V9iVrvl5RWt8Pn/WRdDYAxI/t2BJb6Fd4obMg=;
        b=uScEKhJKe2Ui+9vxUAPaRwqH41NRKsKvHHGSYBuzuWA991kW7kljxb1E/Mp7mWe6nW
         qcx78Am5ZcD61prcCr9lCAn/mZRik8f4ATxQWQHwqDO3yZFUUTifeXL1d9v0Lc2Fq8aJ
         54DpgJhQNrbsRv3rufbBX+IAXL9sRPOe6FCo3RNvd5E1u/Cvat9WY3A+IrX8kdQtI4ik
         n7NqGUQQ3K4QouX3jexDk2nhbiiE/uFjWqm90wluU5UJWYeitfQB4S5/9nxPOdNaToTE
         m3nhgst1Tv6vhmfnKDQlF707GpGHGa0tfTF1yz+NABrrz2ZDXOLUAd6G4SwKmQiHe3Ar
         KQzg==
X-Gm-Message-State: ACrzQf2mm7YdP2hvftZdH96NhSjvQp7TXoJ9La5fbnMcBr8YXSkLfrR7
        RszMPv/+sJjqs6SuiFni6IhNTA==
X-Google-Smtp-Source: AMsMyM4MPKUkOwANVIDYJ65PwXYIOWMWuodaHX0rAgRNrWcRpMAbq+HyXA2xEgq5R+eQl8k1+dqotg==
X-Received: by 2002:a17:902:e74e:b0:178:b4c4:5ac4 with SMTP id p14-20020a170902e74e00b00178b4c45ac4mr1315799plf.11.1663705502349;
        Tue, 20 Sep 2022 13:25:02 -0700 (PDT)
Received: from localhost (p57a238e9.dip0.t-ipconnect.de. [87.162.56.233])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001768517f99esm282541plf.244.2022.09.20.13.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:25:01 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:25:01 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Sep 2022 13:24:57 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
In-Reply-To: <20220813155851.GA187510@roeck-us.net>
CC:     heinrich.schuchardt@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, guoren@kernel.org,
        mchitale@ventanamicro.com, arnaud.pouliquen@foss.st.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-3d4c5572-e386-45d8-9ed5-fd6971a60237@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 08:58:51 PDT (-0700), linux@roeck-us.net wrote:
> On Wed, Jun 08, 2022 at 02:02:51AM +0200, Heinrich Schuchardt wrote:
>> The defconfig kernel should be able to run Docker.
>>
>> Enable the missing settings according to [1].
>> make savedefconfig eliminates CONFIG_STACKTRACE
>> which is enabled by default.
>>
>> Many of the settings are also needed to run a defconfig kernel
>> on default distro installations or to run snaps.
>>
>> [1] https://github.com/moby/moby/blob/master/contrib/check-config.sh
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> This patch results in (or exposes) the following boot warning with all
> riscv32 and riscv64 qemu boots.
>
> [   12.278014] DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
> [   12.278218] WARNING: CPU: 0 PID: 140 at kernel/locking/lockdep.c:5510 check_flags+0xe2/0x1c2
> [   12.278446] Modules linked in:
> [   12.278623] CPU: 0 PID: 140 Comm: S01syslogd Tainted: G                 N 5.19.0-14184-g69dac8e431af #1
> [   12.278791] Hardware name: riscv-virtio,qemu (DT)
> [   12.278931] epc : check_flags+0xe2/0x1c2
> [   12.279024]  ra : check_flags+0xe2/0x1c2
> [   12.279092] epc : ffffffff80a8ea50 ra : ffffffff80a8ea50 sp : ff200000107f3cb0
> [   12.279180]  gp : ffffffff819fec50 tp : ff600000049895c0 t0 : ffffffff81833520
> [   12.279287]  t1 : 0000000000000001 t2 : 2d2d2d2d2d2d2d2d s0 : ff200000107f3cd0
> [   12.279395]  s1 : ffffffff81a00130 a0 : 0000000000000030 a1 : ffffffff818925e8
> [   12.279502]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
> [   12.279608]  a5 : 0000000000000000 a6 : ffffffff80066d80 a7 : 0000000000000038
> [   12.279714]  s2 : ffffffff81a024e0 s3 : ffffffff818935b0 s4 : ff200000107f3e28
> [   12.279825]  s5 : ffffffff80e27708 s6 : 0000000200000022 s7 : ffffffffffffffff
> [   12.279932]  s8 : ffffffff8249da18 s9 : 0000000000001000 s10: 0000000000000001
> [   12.280037]  s11: 0000000000000001 t3 : ffffffff824740af t4 : ffffffff824740af
> [   12.280142]  t5 : ffffffff824740b0 t6 : ff200000107f3aa8
> [   12.280227] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [   12.280382] [<ffffffff80a8eba8>] lock_is_held_type+0x78/0x14a
> [   12.280505] [<ffffffff8003d648>] __might_resched+0x26/0x232
> [   12.280608] [<ffffffff8003d892>] __might_sleep+0x3e/0x66
> [   12.280690] [<ffffffff8002262c>] get_signal+0xa6/0x8f6
> [   12.280771] [<ffffffff800051da>] do_notify_resume+0x68/0x418
> [   12.280863] [<ffffffff80003af4>] ret_from_exception+0x0/0x10
> [   12.280978] irq event stamp: 2900
> [   12.281041] hardirqs last  enabled at (2899): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
> [   12.281176] hardirqs last disabled at (2900): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
> [   12.281303] softirqs last  enabled at (1860): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
> [   12.281435] softirqs last disabled at (1843): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc
> [   12.281564] ---[ end trace 0000000000000000 ]---
> [   12.281735] possible reason: unannotated irqs-on.
> [   12.281815] irq event stamp: 2900
> [   12.281875] hardirqs last  enabled at (2899): [<ffffffff80a9761c>] _raw_spin_unlock_irqrestore+0x54/0x62
> [   12.282004] hardirqs last disabled at (2900): [<ffffffff8000812c>] __trace_hardirqs_off+0xc/0x14
> [   12.282125] softirqs last  enabled at (1860): [<ffffffff80a98092>] __do_softirq+0x3e2/0x51c
> [   12.282242] softirqs last disabled at (1843): [<ffffffff80016fc8>] __irq_exit_rcu+0xb4/0xdc
>
> Reverting this patch fixes the problem. Bisect log attached.

Sorry for having missed this report, but I don't see this now and don't 
remember having seen it before.  Are you still seeing the issue?

>
> Guenter
>
> ---
> # bad: [69dac8e431af26173ca0a1ebc87054e01c585bcc] Merge tag 'riscv-for-linus-5.20-mw2' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag 'mm-stable-2022-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect start 'HEAD' '6614a3c3164a'
> # bad: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect bad 24cb958695724ffb4488ef4f65892c0767bcd2f2
> # good: [a3b5d4715fd5a839857f8b7be78dff258a8d5a47] Merge tag 'asoc-v5.20-2' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
> git bisect good a3b5d4715fd5a839857f8b7be78dff258a8d5a47
> # good: [1d239c1eb873c7d6c6cbc80d68330c939fd86136] Merge tag 'iommu-updates-v5.20-or-v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect good 1d239c1eb873c7d6c6cbc80d68330c939fd86136
> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix kexec build error
> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
> # good: [ea0c39260d0c1d8e11d89c9d42ca48e172d1c868] Merge tag '9p-for-5.20' of https://github.com/martinetd/linux
> git bisect good ea0c39260d0c1d8e11d89c9d42ca48e172d1c868
> # bad: [d77771c926671e0362af3fe792391be66072b242] Merge tag 'mips_6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect bad d77771c926671e0362af3fe792391be66072b242
> # good: [3f1901110a89b0e2e13adb2ac8d1a7102879ea98] RISC-V: Add fast call path of crash_kexec()
> git bisect good 3f1901110a89b0e2e13adb2ac8d1a7102879ea98
> # good: [d3164e2f3b0ac003c401d419cda2da0571724352] MIPS: Remove VR41xx support
> git bisect good d3164e2f3b0ac003c401d419cda2da0571724352
> # good: [534ea58b3ceb41d668adf18c4e68a846e770a6c8] Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"
> git bisect good 534ea58b3ceb41d668adf18c4e68a846e770a6c8
> # bad: [ba6cfef057e1c594c456627aad81c2343fdb5d13] riscv: enable Docker requirements in defconfig
> git bisect bad ba6cfef057e1c594c456627aad81c2343fdb5d13
> # good: [9c2ea4a36364bfb5cf068c6fbea5c40292b119a5] riscv: convert the t-head pbmt errata to use the __nops macro
> git bisect good 9c2ea4a36364bfb5cf068c6fbea5c40292b119a5
> # good: [f4361718f7654f31fee6bf323147e7062d825599] riscv: Add macro for multiple nop instructions
> git bisect good f4361718f7654f31fee6bf323147e7062d825599
> # first bad commit: [ba6cfef057e1c594c456627aad81c2343fdb5d13] riscv: enable Docker requirements in defconfig
