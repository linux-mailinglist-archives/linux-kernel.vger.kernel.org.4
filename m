Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1536362D96B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiKQLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbiKQLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:31:50 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B048767
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:31:49 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k84so1518019ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i16ycnAEmJ+xybZKFB6Q2+GrX06wVG/BMACMYkIBt2s=;
        b=C47Xa9ZW/5/L8ez5vm/hz58W4yel04RsHFY0oVHQZstuW5uC7albeNC8iI0FsNoa4r
         mo8Xup1ZK3+s+CXSxW46r7pETxXCIw+Lm+MNSY1LPAmbtPI1ZUu8PlPT/RwC2Uc5LkyZ
         S97PATVg0e1M+tny2W4/rQ7EbgBus6GSlISfrOedhxoO77I8WRRfVJjXXvwAD2B35vME
         bMrXLTk/U7l07NvZUwaS5VR8sg+VMF5/b43SgK0BfIIIGhg/xAZXU63L4cfdLILmcoqy
         GcBS8obuq7T7m53mEfZYXl0cmyn608I+w0FeWXr0o5QRiFGokCKJbHX3KyPOAzlXlFKw
         FFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i16ycnAEmJ+xybZKFB6Q2+GrX06wVG/BMACMYkIBt2s=;
        b=QiZJvSUI3+cHb8b5NspQHu160x4GqbDcTP9OvzxXhcGQQL6aVwMvX4Ss4I68hI7388
         9kNt+TgCYnV7+sFLP6aScqLBoY07P6uq+fl/wSYsgca/VxeD+4XuK5OoryWrKrGlXzYU
         gXvpltMD7fA0HAlBKro9ozX772ZV6agOvJ6BDAlljd07M6AdodCrkaps3Kmf13T2bsPi
         w3KCwHqfNILmF0C7h+TXggzxbCOyEEh6yxM9jummZrSD07xGcl+UIgSqPXFwSH1fnr/5
         QINUYJ6A+CLMmra6uaWwgG/uZWrfY7tpLCC8M1zuXyTYFklAZ9LJQNI2Nt2UuIchEjzL
         RRXA==
X-Gm-Message-State: ANoB5plaLKhJqxrlHX6ptI26AyjfgW26PF2CeHshg4IWFl98iRhih9/D
        4RRlkdbsj9cXE5riKb/klLePyqsdJumPZfAxQ7y5UA==
X-Google-Smtp-Source: AA0mqf7dhQQoI+FNvfR2xXV2mX0PkabHdBgu77T4ArCRJbxRgdck4UFHQikdcC+sAw1loDrTnI1azfn+sU6Lfi0j1AE=
X-Received: by 2002:a25:880e:0:b0:6e6:e31e:3dc5 with SMTP id
 c14-20020a25880e000000b006e6e31e3dc5mr1685536ybl.534.1668684708480; Thu, 17
 Nov 2022 03:31:48 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Nov 2022 17:01:37 +0530
Message-ID: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
Subject: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46 kfence_protect
To:     kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunit test cases failed and found warnings while booting Linux next
version 6.1.0-rc5-next-20221117 on qemu-x86_64 [1].

It was working on Linux next-20221116 tag.

[    0.663761] WARNING: CPU: 0 PID: 0 at
arch/x86/include/asm/kfence.h:46 kfence_protect+0x7b/0x120
[    0.664033] WARNING: CPU: 0 PID: 0 at mm/kfence/core.c:234
kfence_protect+0x7d/0x120
[    0.664465] kfence: kfence_init failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on qemu_x86_64:[2]

    - kunit/test_use_after_free_read
    - kunit/test_invalid_access
    - kunit/test_double_free-memcache
    - kunit/test_krealloc
    - kunit/test_shrink_memcache
    - kunit/test_memcache_typesafe_by_rcu
    - kunit/test_use_after_free_read-memcache
    - kunit/test_invalid_addr_free-memcache
    - kunit/test_out_of_bounds_read-memcache
    - kunit/test_memcache_alloc_bulk
    - kunit/test_out_of_bounds_read
    - kunit/test_memcache_ctor
    - kunit/test_corruption-memcache
    - kunit/test_gfpzero
    - kunit/test_out_of_bounds_write
    - kunit/test_out_of_bounds_write-memcache
    - kunit/test_kmalloc_aligned_oob_read
    - kunit/test_free_bulk-memcache

[    0.663758] ------------[ cut here ]------------
[    0.663761] WARNING: CPU: 0 PID: 0 at
arch/x86/include/asm/kfence.h:46 kfence_protect+0x7b/0x120
[    0.663782] Modules linked in:
[    0.663788] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.1.0-rc5-next-20221117 #1
[    0.663795] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    0.663801] RIP: 0010:kfence_protect+0x7b/0x120
[    0.663811] Code: f1 f1 f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 25
28 00 00 00 48 89 45 d8 31 c0 e8 e0 0d ba ff 48 85 c0 74 06 83 7d a0
01 74 17 <0f> 0b 0f 0b c6 05 cb 97 1d 03 00 45 31 c0 c6 05 c0 97 1d 03
01 eb
[    0.663819] RSP: 0000:ffffffff9c407d98 EFLAGS: 00010002
[    0.663826] RAX: ffff8880adc01020 RBX: 00000000000001ff RCX: 80000001000001e3
[    0.663830] RDX: dffffc0000000000 RSI: ffff88811ac00000 RDI: ffff8880adc01020
[    0.663836] RBP: ffffffff9c407e18 R08: ffffffff997c8ef8 R09: ffffea00046b7f87
[    0.663841] R10: fffff940008d6ff0 R11: 0000000000000001 R12: 1ffffffff3880fb3
[    0.663845] R13: ffff88811ac00000 R14: ffffea00046b7fc0 R15: 0000000000000200
[    0.663852] FS:  0000000000000000(0000) GS:ffff88811b400000(0000)
knlGS:0000000000000000
[    0.663859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.663864] CR2: ffff88813ffff000 CR3: 00000000ac814000 CR4: 00000000000406b0
[    0.663869] Call Trace:
[    0.663871]  <TASK>
[    0.663876]  ? __pfx_kfence_protect+0x10/0x10
[    0.663886]  ? __pfx_set_memory_4k+0x10/0x10
[    0.663899]  kfence_init_pool+0x1ea/0x350
[    0.663909]  ? __pfx_kfence_init_pool+0x10/0x10
[    0.663919]  ? random_init+0xe9/0x13b
[    0.663930]  ? __pfx_random_init+0x10/0x10
[    0.663936]  ? _find_next_bit+0x46/0xe0
[    0.663947]  kfence_init+0x42/0x1e8
[    0.663959]  start_kernel+0x1fd/0x3a6
[    0.663970]  x86_64_start_reservations+0x28/0x2e
[    0.663978]  x86_64_start_kernel+0x96/0xa0
[    0.663986]  secondary_startup_64_no_verify+0xe0/0xeb
[    0.664001]  </TASK>
[    0.664003] ---[ end trace 0000000000000000 ]---
[    0.664032] ------------[ cut here ]------------
[    0.664033] WARNING: CPU: 0 PID: 0 at mm/kfence/core.c:234
kfence_protect+0x7d/0x120
[    0.664045] Modules linked in:
[    0.664049] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
   6.1.0-rc5-next-20221117 #1
[    0.664055] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    0.664058] RIP: 0010:kfence_protect+0x7d/0x120
[    0.664068] Code: f1 f1 c7 40 04 04 f3 f3 f3 65 48 8b 04 25 28 00
00 00 48 89 45 d8 31 c0 e8 e0 0d ba ff 48 85 c0 74 06 83 7d a0 01 74
17 0f 0b <0f> 0b c6 05 cb 97 1d 03 00 45 31 c0 c6 05 c0 97 1d 03 01 eb
4a 48
[    0.664074] RSP: 0000:ffffffff9c407d98 EFLAGS: 00010002
[    0.664080] RAX: ffff8880adc01020 RBX: 00000000000001ff RCX: 80000001000001e3
[    0.664085] RDX: dffffc0000000000 RSI: ffff88811ac00000 RDI: ffff8880adc01020
[    0.664090] RBP: ffffffff9c407e18 R08: ffffffff997c8ef8 R09: ffffea00046b7f87
[    0.664095] R10: fffff940008d6ff0 R11: 0000000000000001 R12: 1ffffffff3880fb3
[    0.664099] R13: ffff88811ac00000 R14: ffffea00046b7fc0 R15: 0000000000000200
[    0.664105] FS:  0000000000000000(0000) GS:ffff88811b400000(0000)
knlGS:0000000000000000
[    0.664112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.664116] CR2: ffff88813ffff000 CR3: 00000000ac814000 CR4: 00000000000406b0
[    0.664121] Call Trace:
[    0.664123]  <TASK>
[    0.664126]  ? __pfx_kfence_protect+0x10/0x10
[    0.664136]  ? __pfx_set_memory_4k+0x10/0x10
[    0.664146]  kfence_init_pool+0x1ea/0x350
[    0.664156]  ? __pfx_kfence_init_pool+0x10/0x10
[    0.664166]  ? random_init+0xe9/0x13b
[    0.664172]  ? __pfx_random_init+0x10/0x10
[    0.664179]  ? _find_next_bit+0x46/0xe0
[    0.664186]  kfence_init+0x42/0x1e8
[    0.664196]  start_kernel+0x1fd/0x3a6
[    0.664205]  x86_64_start_reservations+0x28/0x2e
[    0.664213]  x86_64_start_kernel+0x96/0xa0
[    0.664221]  secondary_startup_64_no_verify+0xe0/0xeb
[    0.664232]  </TASK>
[    0.664235] ---[ end trace 0000000000000000 ]---
[    0.664465] kfence: kfence_init failed

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: af37ad1e01c72483c4ee8453d9d9bac95d35f023
  git_describe: next-20221117
  kernel_version: 6.1.0-rc5
  kernel-config: https://builds.tuxbuild.com/2Hfb6n1z0frt4iBlIvqUzjMHiLm/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/697483979
  artifact-location: https://builds.tuxbuild.com/2Hfb6n1z0frt4iBlIvqUzjMHiLm
  toolchain: gcc-11


[1] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221117/testrun/13045566/suite/kunit/test/kfence/log
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221117/testrun/13045566/suite/kunit/tests/
[3] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221117/testrun/13045566/suite/kunit/test/test_invalid_access/history/



--
Linaro LKFT
https://lkft.linaro.org
