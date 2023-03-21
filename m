Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C646C2A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCUGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCUGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:13:12 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18E55AB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:13:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s1so12519739vsk.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679379187;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tk6T/JF5stfU3rdTmfDo9zZ6+TwEuHGE24J497BOBKo=;
        b=JfckQyRAHA6v9q8LFqub52VHR7oM1MRrQcgKId1twhtxP79NGNbeXf+wRF+w3kuLfJ
         EskrWboQr7+LpamzKDD1i262iZ5Ca/3AG79xL2tA3RNSsRhb3fwmGsQsXCCBr6X46J7x
         nnAXab5Kn5BWyovZerycVQGffI+NSw0aKrkppxuc9D5nE4vL/8UYKegrOprGh9WvXjdg
         0HNMFGyQwG/nmlJ7b5tre6DWGKaXL8m67IsFxEfdni73qxxgeHnoU/VHN5UobqIDKQnE
         D6BHybCQG6Rhc+SbLqeai/vEMPpiaFgkgDfYZK/fA31QU8OLzikHYqN0NV6DOSSaz6A8
         zPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379187;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tk6T/JF5stfU3rdTmfDo9zZ6+TwEuHGE24J497BOBKo=;
        b=df/B/B7tWSvxRDtzD+Yj/uJ4RmB+kEI8BihiqA7+t7oel9Uc+57Tzel28op43C3dwx
         b1aMdNAoFzCsnEPZJT1fvf/YNuXsTb+qlJmaihJeakugEMeq7p1BZ0+h3EaAvXsDIsRs
         OWb3Mn3P4BcdFVOpzh5elV3hmuy5zG2yCC1plPUqtmUJgUq0SUK2QWqIgk9+5eeqiN7L
         Sxx4lSEuH/4dT1FzkNPLgRRWkD9KzRW1fWbqEZQJIhhT5ezAgc7fKG5ErqqPOicvzAKP
         6tQwTIzlLcLEvyS+AP6Ww2XLnkFZ7+6ja+20ztfmMwaKbz/DxCHfef00+I3CONGPAIXP
         v/cw==
X-Gm-Message-State: AO0yUKUv5orlboJ6DXAJxtu3fFgGfXWTCYGF65nyvAfvXLaNuu3hw5hM
        Iikqy2cs9MVnSg9hDC5UmZShercJzlHaU4fTrHxb/JBNnrbdDxU+oNg=
X-Google-Smtp-Source: AK7set/J7RDgS2V66ZPuxd7qim5Ey6SYIy2vIoczovGbXWsiFgmM1acsyEqIRYps9mVmB8CfkxpSuWfWx4dOBeRyHi4=
X-Received: by 2002:a67:cc1b:0:b0:425:d52d:f5cb with SMTP id
 q27-20020a67cc1b000000b00425d52df5cbmr882989vsl.1.1679379187131; Mon, 20 Mar
 2023 23:13:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Mar 2023 11:42:56 +0530
Message-ID: <CA+G9fYsTk0GPOTEMm1KG2iJvMLG0SqUfG0JSenRYFHuOQTpuxw@mail.gmail.com>
Subject: next-20230321: arm64: Unable to handle kernel paging request at
 virtual address
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following kernel crash was noticed on arm64 Juno-r2 and Raspberry Pi 4
Model B on Linux next-20230321.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

log:
----
[    3.071500] Unable to handle kernel paging request at virtual
address 0000000000001000
[    3.079432] Mem abort info:
[    3.082225]   ESR = 0x0000000096000004
[    3.085977]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.091295]   SET = 0, FnV = 0
[    3.094350]   EA = 0, S1PTW = 0
[    3.097491]   FSC = 0x04: level 0 translation fault
[    3.102373] Data abort info:
[    3.105252]   ISV = 0, ISS = 0x00000004
[    3.109089]   CM = 0, WnR = 0
[    3.112055] [0000000000001000] user address but active_mm is swapper
[    3.114230] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    3.118418] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    3.118426] Modules linked in:
[    3.134717] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
6.3.0-rc3-next-20230321 #1
[    3.142126] Hardware name: ARM Juno development board (r2) (DT)
[    3.148052] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.155027] pc : string (lib/vsprintf.c:644 lib/vsprintf.c:726)
[    3.158443] lr : vsnprintf (lib/vsprintf.c:2817)
[    3.162196] sp : ffff80000b34b8f0
[    3.165511] x29: ffff80000b34b8f0 x28: ffff800009d7b1ca x27: ffff80000b34bab0
[    3.172666] x26: ffff800009d7b1ca x25: 0000000000000020 x24: 0000000000000008
[    3.179820] x23: 00000000ffffffd8 x22: ffff8000099858a0 x21: ffff80000b34bc30
[    3.186973] x20: ffff80000b34ba90 x19: ffff80000b34ba98 x18: 000000003c98bfdd
[    3.194127] x17: 000000000000001c x16: 00000000eec48da2 x15: 00000000a9dbdd17
[    3.201280] x14: ffff80000b0242e8 x13: 0000000057a049ef x12: 00000000cfa47237
[    3.208433] x11: 0000000000000001 x10: 00000000bd5b8780 x9 : ffff80000812cbec
[    3.215586] x8 : 00000000ffffffff x7 : 0000000000000002 x6 : ffff80000b34ba98
[    3.222739] x5 : ffffffffffffffff x4 : 0000000000000000 x3 : ffff0a00ffffff04
[    3.229891] x2 : 0000000000001000 x1 : 0000000000000000 x0 : ffff80000b34bab0
[    3.237044] Call trace:
[    3.239489] string (lib/vsprintf.c:644 lib/vsprintf.c:726)
[    3.242551] vsnprintf (lib/vsprintf.c:2817)
[    3.245954] vprintk_store (kernel/printk/printk.c:2200)
[    3.249712] vprintk_emit (kernel/printk/printk.c:2297)
[    3.253381] vprintk_default (kernel/printk/printk.c:2328)
[    3.257137] vprintk (kernel/printk/printk_safe.c:50)
[    3.260198] _printk (kernel/printk/printk.c:2341)
[    3.263257] sysctl_err (fs/proc/proc_sysctl.c:1109)
[    3.266577] __register_sysctl_table (fs/proc/proc_sysctl.c:1140
fs/proc/proc_sysctl.c:1383)
[    3.271202] __register_sysctl_init (fs/proc/proc_sysctl.c:1462)
[    3.275569] memory_failure_sysctl_init (mm/memory-failure.c:152)
[    3.280281] do_one_initcall (init/main.c:1306)
[    3.280453] hub 1-1:1.0: USB hub found
[    3.284123] kernel_init_freeable (init/main.c:1378 init/main.c:1395
init/main.c:1414 init/main.c:1634)
[    3.284133] kernel_init (init/main.c:1526)
[    3.288246] hub 1-1:1.0: 4 ports detected
[    3.292239] ret_from_fork (arch/arm64/kernel/entry.S:871)
[ 3.292250] Code: 91000400 110004e1 eb08009f 540000c0 (38646845)
All code
========
   0:* 00 04 00              add    %al,(%rax,%rax,1) <-- trapping instruction
   3: 91                    xchg   %eax,%ecx
   4: e1 04                loope  0xa
   6: 00 11                add    %dl,(%rcx)
   8: 9f                    lahf
   9: 00 08                add    %cl,(%rax)
   b: eb c0                jmp    0xffffffffffffffcd
   d: 00 00                add    %al,(%rax)
   f: 54                    push   %rsp
  10: 45                    rex.RB
  11: 68                    .byte 0x68
  12: 64                    fs
  13: 38                    .byte 0x38

Code starting with the faulting instruction
===========================================
   0: 45                    rex.RB
   1: 68                    .byte 0x68
   2: 64                    fs
   3: 38                    .byte 0x38
[    3.309416] ---[ end trace 0000000000000000 ]---
[    3.314037] note: swapper/0[1] exited with irqs disabled
[    3.319392] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    3.327060] SMP: stopping secondary CPUs
[    3.331189] Kernel Offset: disabled
[    3.334678] CPU features: 0x400002,0c3c0400,0000421b
[    3.339649] Memory Limit: none
[    3.342708] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

links:
----
 - https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20230321/testrun/15765295/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20230321/testrun/15765168/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20230321/testrun/15765168/suite/log-parser-test/test/check-kernel-panic/details/

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: f3594f0204b756638267242e26d9de611435c3ba
  git_describe: next-20230321
  kernel_version: 6.3.0-rc3
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NJ83YzjXEfP00u1LgnjMjjZfxo/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/812627412/
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NJ83YzjXEfP00u1LgnjMjjZfxo
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
