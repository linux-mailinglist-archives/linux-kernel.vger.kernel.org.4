Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B574557E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGCGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCGcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:32:36 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B771BA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:32:34 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44387d40adaso2956993137.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688365953; x=1690957953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLZEXNRXU41vg/UOksxsix8MjjWkPYTtHif0vE+q5HI=;
        b=fU8jH2SDmFcEkK3fa8zHSWk+O9xL1Xx+W2BJXqRbGG1hcOa/lv8oUkpyxfmm31/2Ml
         Ygbj2KLO+LgVTBhOPI34R0ryA93+BDImvL8geKWFGcs2D2Auk5WEcGCKvjEiPUD64rHf
         dRzEQH9cvm0ovoSFUcgIkjN0MQ9HYnEw12+pJLHEfsXcSTIli+OShx3jGgB9FEO2v6aJ
         n6GlXrME6oWz0ucZhXe2cii2TwZqBN1oa0UWdH+OZacv9z0VLARXo1jjX7xhWYK83CvA
         WNYZJDKt2ZkHrJ5nQaYw0WmwzE1eG7zAi3Rn17AP21LnRZ7Xxu6BCQPK0UXWP9le4u7g
         7rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365953; x=1690957953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLZEXNRXU41vg/UOksxsix8MjjWkPYTtHif0vE+q5HI=;
        b=SjEr+zdrNME6jZTwHXT3vgDweF+0frxUZS0tN7g3h+3Ion6hc7uQkFZmYrGPY+6f9N
         vdosMo2n2jP2p9Y0hL9+9WkRkVubLD5tiLuxhPAZDcBgrjMmcESQ/2bKfoY9Q93XYjAX
         DrKhIO4YiT9Bq4nVf+XmFw5+PT3U4OtfVGU8C9VvBWUjQ6KJ9ca0PkbaGWvgcz1EPH7k
         Nj0Hq2QtRWfedpxvDZtaXQYlwx4l8kr+y+JeuTy9bl1t+rGw8DaEaYNVguwQWgK1StYi
         x4c8tTi4y9mPkOG8V4ObUN7QK3Icopq4GIAn1I5F4yHxoMHfzdViNwEVgguaGena1RE0
         a6tg==
X-Gm-Message-State: ABy/qLbEHcsbPpmltHRZhbiWz6kD9OkqSe0vjqzKzPTJZKXSWqq/BNPT
        GlMkrvtnQ6ScFN+/5HZh86lVTxUgMsWfg4MFL88tZA==
X-Google-Smtp-Source: APBJJlGGKxNK+VoUNPvxquxE5FV0Yn7Xb57pAsc+XEVFS2yRj1SEwLVf2SAYPbrg5cGkxDYbuypZ4K0nKVXy9zwerNE=
X-Received: by 2002:a67:f60d:0:b0:443:7549:1ab7 with SMTP id
 k13-20020a67f60d000000b0044375491ab7mr3065989vso.17.1688365953258; Sun, 02
 Jul 2023 23:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
 <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
In-Reply-To: <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 3 Jul 2023 12:02:22 +0530
Message-ID: <CA+G9fYt0Sh-0vFQSWjJz0di-vAc-Ke-bwjqyGM=d_M==x6OnOg@mail.gmail.com>
Subject: Re: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING:
 CPU: 3 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 at 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jul 1, 2023, at 10:42, Naresh Kamboju wrote:
>
> > Links:
> >  -
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999853/suite/log-parser-test/tests/
> >  -
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999906/suite/log-parser-test/tests/
>
> I can't see which build artifacts correspond to the logs. Can you link to the
> vmlinux file?

Here is the build artifacts location with kselftest merge configs.
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/

log links,
https://lkft.validation.linaro.org/scheduler/job/6561246#L1267
https://lkft.validation.linaro.org/scheduler/job/6561242#L1735


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: e55e5df193d247a38a5e1ac65a5316a0adcc22fa
  git_describe: v6.4-8686-ge55e5df193d2
  kernel_version: 6.4.0
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/config
  build-url:
    https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/916784989
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/
  toolchain: gcc-11

Crash log:
----
# #  RUN           global.user_notification_child_pid_ns ...
[   56.149118] Unexpected kernel BRK exception at EL1
[   56.149721] Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
[   56.150153] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
[   56.151781] CPU: 0 PID: 438 Comm: seccomp_bpf Not tainted 6.4.0 #1
[   56.152043] Hardware name: linux,dummy-virt (DT)
[   56.152396] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   56.152667] pc : alloc_pid+0x3b4/0x3c8
[   56.154243] lr : alloc_pid+0x140/0x3c8
[   56.154399] sp : ffff8000809b3960
[   56.154539] x29: ffff8000809b3960 x28: 0000000001200000 x27: 0000000000000001
[   56.155081] x26: ffffb7df5f7830c8 x25: ffff0000c5f18008 x24: ffffb7df5f756140
[   56.155481] x23: ffffb7df5f783000 x22: 0000000000000000 x21: ffff0000c9ecc0b0
[   56.155880] x20: ffff0000c5f18008 x19: 0000000000000001 x18: ffffb7df5e2c3280
[   56.156210] x17: ffffb7df5c6d7418 x16: ffffb7df5c9a8b80 x15: ffffb7df5c9a8080
[   56.156483] x14: ffffb7df5c9a7b48 x13: ffffb7df5dceb680 x12: ffffb7df5c62d204
[   56.156761] x11: ffffb7df5c62d194 x10: a1f68cf70798a66b x9 : ffffb7df5c6d74f0
[   56.157079] x8 : ffff8000809b3878 x7 : 0000000000000000 x6 : 0000000000000220
[   56.157343] x5 : 0000000000000001 x4 : ffffb7df5f75f000 x3 : ffffb7df5f75f2e8
[   56.157617] x2 : 0000000000000000 x1 : ffff0000c9031180 x0 : 0000000100000000
[   56.158001] Call trace:
[   56.158155]  alloc_pid+0x3b4/0x3c8
[   56.158352]  copy_process+0xd20/0x1590
[   56.158487]  kernel_clone+0x94/0x3f8
[   56.158623]  __do_sys_clone+0x74/0xb8
[   56.158883]  __arm64_sys_clone+0x2c/0x40
[   56.159150]  invoke_syscall+0x8c/0x120
[   56.159370]  el0_svc_common.constprop.0+0xf4/0x120
[   56.159529]  do_el0_svc+0x44/0xb8
[   56.159705]  el0_svc+0x30/0x98
[   56.159884]  el0t_64_sync_handler+0x13c/0x158
[   56.160053]  el0t_64_sync+0x190/0x198
[   56.160343] Code: 17ffff74 52800041 9419763f 17ffff7e (d4207d00)
[   56.160919] ---[ end trace 0000000000000000 ]---
[   56.161210] note: seccomp_bpf[438] exited with irqs disabled
[   56.161775] note: seccomp_bpf[438] exited with preempt_count 1
[   56.169001] ------------[ cut here ]------------
[   56.169423] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128
ct_kernel_exit.constprop.0+0x108/0x120
[   56.169952] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
[   56.170978] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
   6.4.0 #1
[   56.171408] Hardware name: linux,dummy-virt (DT)
[   56.171708] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   56.172134] pc : ct_kernel_exit.constprop.0+0x108/0x120
[   56.172354] lr : ct_idle_enter+0x10/0x20
[   56.172617] sp : ffffb7df5f753d40
[   56.172833] x29: ffffb7df5f753d40 x28: 00000000426120ac x27: 0000000000000000
[   56.173255] x26: 0000000000000000 x25: ffffb7df5f76bd00 x24: 0000000000000000
[   56.173675] x23: 0000000000000000 x22: ffffb7df5f75eba0 x21: ffffb7df5ecc9b78
[   56.173963] x20: ffffb7df5f75eac0 x19: ffff0000ff573c60 x18: ffffb7df5e2c3280
[   56.174260] x17: ffffb7df5dceaf80 x16: ffffb7df5c63b820 x15: ffffb7df5c623834
[   56.174643] x14: ffffb7df5c6235ac x13: ffffb7df5c62d00c x12: ffffb7df5c6a85b4
[   56.175266] x11: ffffb7df5c6a8544 x10: e1769a2bf2c5b3d9 x9 : ffffb7df5c7a1730
[   56.175720] x8 : ffffb7df5f753ca8 x7 : 0000000000000000 x6 : 0000000000000001
[   56.176028] x5 : 4000000000000002 x4 : ffff4821a08ac000 x3 : ffffb7df5f753d40
[   56.176315] x2 : ffffb7df5ecc7c60 x1 : 4000000000000000 x0 : ffffb7df5ecc7c60
[   56.176652] Call trace:
[   56.176791]  ct_kernel_exit.constprop.0+0x108/0x120
[   56.177073]  ct_idle_enter+0x10/0x20
[   56.177238]  default_idle_call+0x44/0x168
[   56.177398]  do_idle+0x244/0x2b8
[   56.177565]  cpu_startup_entry+0x2c/0x40
[   56.177722]  rest_init+0xfc/0x108
[   56.177873]  arch_call_rest_init+0x18/0x20
[   56.178128]  start_kernel+0x55c/0x6d8
[   56.178290]  __primary_switched+0xbc/0xd0
[   56.178560] ---[ end trace 0000000000000000 ]---



- Naresh

>
>        Arnd
