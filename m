Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF8744D95
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGBM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:27:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF52127
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:27:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso1794200b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300859; x=1690892859;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXacy/ibfEE4463MMOkzH0g2Qngy9APl/d9Z2BDtCxo=;
        b=HTHDYOKcfKX0L7TZwlsiGResZFtHUFuWE9/61jqpVmVZ0cBbmrJAfD3TfV06vq8auO
         LoYEOFXWQP9dYEvnRvrjmeiQSi+W2bK9C/t1IcnAkXjbMAdFA9/aLoPSyeHjrjw36DKo
         Y9K+P0NEVXc+vwZ7U6G/fIz8xOU6R5eryq5+EBbq5wfMrgzGECz+7ldZW9yplHzNJ1rD
         1OhZUZVIlTREUM841n6UBFWz3yMAZDHhwRf+eIN+3k84cbE9CzC44fBcz1YTEbhCcwkg
         ONfjRdMhTxeXXrgn2G5TyxCV64ZhhrmRB5DHTjChBssRI2ibmPbIyfko3XVQYmeQmXnQ
         f9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300859; x=1690892859;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zXacy/ibfEE4463MMOkzH0g2Qngy9APl/d9Z2BDtCxo=;
        b=OnlDIWDUj5eU8SvRCKQ9SjnKnPOFQ5iPqth4FKPNzdDJdXIczJgz/UD0tb3TgZnUOd
         AkfB3XfVBPGX7PcjOcwmOq4LkK7xd8ISg0Q++oCtS0WMGvXXBb+gK7b1LG31KDvnVqGt
         rivA+iFITaBXCkuXdviDb3xmheGUMaCIKDqXLUr4rVEhPStElHFdfHbAf99RLZb4WB8T
         QFRLHVF+cRxZW0waDN+14O06XRK+ZqmTytNlBjkFTtOvMZ3ZXmqh+qUVWdUrQo/rO2i6
         0JxuFbSjjGadZXEg3TtQV4UKV9scteg+EAx9eq85zJKOrHOHgaI4x8NgTtI8NMp0CMuB
         XtgA==
X-Gm-Message-State: ABy/qLYnCerGFqp/mvXH5eYIDUudF+aCZQ8L/VElSTw35LD7UfXeLaIl
        1Ljdb6zUWyETrbOchTv7o40=
X-Google-Smtp-Source: APBJJlFyk3HIH5rOtkgOujWwazVhnbb78+e3ETKdDoKg9fiJKbMQx7gEgmT9fyzAW8TTws0ZIQt1QQ==
X-Received: by 2002:a05:6a00:b81:b0:662:f0d0:a77d with SMTP id g1-20020a056a000b8100b00662f0d0a77dmr8629430pfj.30.1688300859135;
        Sun, 02 Jul 2023 05:27:39 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79109000000b0066a31111ccdsm6522887pfh.65.2023.07.02.05.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 05:27:38 -0700 (PDT)
Message-ID: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
Date:   Sun, 2 Jul 2023 19:27:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Memory corruption in multithreaded user space program while
 calling fork
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> After upgrading to kernel version 6.4.0 from 6.3.9, I noticed frequent but random crashes in a user space program.  After a lot of reduction, I have come up with the following reproducer program:
> 
> $ uname -a
> Linux jacob 6.4.1-gentoo #1 SMP PREEMPT_DYNAMIC Sat Jul  1 19:02:42 EDT 2023 x86_64 AMD Ryzen 9 7950X3D 16-Core Processor AuthenticAMD GNU/Linux
> $ cat repro.c
> #define _GNU_SOURCE
> #include <sched.h>
> #include <sys/wait.h>
> #include <unistd.h>
> 
> void *threadSafeAlloc(size_t n) {
>     static size_t end_index = 0;
>     static char buffer[1 << 25];
>     size_t start_index = __atomic_load_n(&end_index, __ATOMIC_SEQ_CST);
>     while (1) {
>         if (start_index + n > sizeof(buffer)) _exit(1);
>         if (__atomic_compare_exchange_n(&end_index, &start_index, start_index + n, 1, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) return buffer + start_index;
>     }
> }
> 
> int thread(void *arg) {
>     size_t i;
>     size_t n = 1 << 7;
>     char *items;
>     (void)arg;
>     while (1) {
>         items = threadSafeAlloc(n);
>         for (i = 0; i != n; i += 1) items[i] = '@';
>         for (i = 0; i != n; i += 1) if (items[i] != '@') _exit(2);
>     }
> }
> 
> int main(void) {
>     static size_t stacks[2][1 << 9];
>     size_t i;
>     for (i = 0; i != 2; i += 1) clone(&thread, &stacks[i] + 1, CLONE_THREAD | CLONE_VM | CLONE_SIGHAND, NULL);
>     while (1) {
>         if (fork() == 0) _exit(0);
>         (void)wait(NULL);
>     }
> }
> $ cc repro.c
> $ ./a.out
> $ echo $?
> 2
> 
> After tuning the various parameters for my computer, exit code 2, which indicates that memory corruption was detected, occurs approximately 99% of the time.  Exit code 1, which occurs approximately 1% of the time, means it ran out of statically-allocated memory before reproducing the issue, and increasing the memory usage any more only leads to diminishing returns.  There is also something like a 0.1% chance that it segfaults due to memory corruption elsewhere than in the statically-allocated buffer.
> 
> With this reproducer in hand, I was able to perform the following bisection:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
> git bisect bad 6995e2de6891c724bfeb2db33d7b87775f913ad1
> # status: waiting for good commit(s), bad commit known
> # good: [457391b0380335d5e9a5babdec90ac53928b23b4] Linux 6.3
> git bisect good 457391b0380335d5e9a5babdec90ac53928b23b4
> # good: [d42b1c47570eb2ed818dc3fe94b2678124af109d] Merge tag 'devicetree-for-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> git bisect good d42b1c47570eb2ed818dc3fe94b2678124af109d
> # bad: [58390c8ce1bddb6c623f62e7ed36383e7fa5c02f] Merge tag 'iommu-updates-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect bad 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> # good: [888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0] Merge tag 'sysctl-6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux
> git bisect good 888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0
> # bad: [86e98ed15b3e34460d1b3095bd119b6fac11841c] Merge tag 'cgroup-for-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
> git bisect bad 86e98ed15b3e34460d1b3095bd119b6fac11841c
> # bad: [7fa8a8ee9400fe8ec188426e40e481717bc5e924] Merge tag 'mm-stable-2023-04-27-15-30' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 7fa8a8ee9400fe8ec188426e40e481717bc5e924
> # bad: [0120dd6e4e202e19a0e011e486fb2da40a5ea279] zram: make zram_bio_discard more self-contained
> git bisect bad 0120dd6e4e202e19a0e011e486fb2da40a5ea279
> # good: [fce0b4213edb960859dcc65ea414c8efb11948e1] mm/page_alloc: add helper for checking if check_pages_enabled
> git bisect good fce0b4213edb960859dcc65ea414c8efb11948e1
> # bad: [59f876fb9d68a4d8c20305d7a7a0daf4ee9478a8] mm: avoid passing 0 to __ffs()
> git bisect bad 59f876fb9d68a4d8c20305d7a7a0daf4ee9478a8
> # good: [0050d7f5ee532f92e8ab1efcec6547bfac527973] afs: split afs_pagecache_valid() out of afs_validate()
> git bisect good 0050d7f5ee532f92e8ab1efcec6547bfac527973
> # good: [2ac0af1b66e3b66307f53b1cc446514308ec466d] mm: fall back to mmap_lock if vma->anon_vma is not yet set
> git bisect good 2ac0af1b66e3b66307f53b1cc446514308ec466d
> # skip: [0d2ebf9c3f7822e7ba3e4792ea3b6b19aa2da34a] mm/mmap: free vm_area_struct without call_rcu in exit_mmap
> git bisect skip 0d2ebf9c3f7822e7ba3e4792ea3b6b19aa2da34a
> # skip: [70d4cbc80c88251de0a5b3e8df3275901f1fa99a] powerc/mm: try VMA lock-based page fault handling first
> git bisect skip 70d4cbc80c88251de0a5b3e8df3275901f1fa99a
> # good: [444eeb17437a0ef526c606e9141a415d3b7dfddd] mm: prevent userfaults to be handled under per-vma lock
> git bisect good 444eeb17437a0ef526c606e9141a415d3b7dfddd
> # bad: [e06f47a16573decc57498f2d02f9af3bb3e84cf2] s390/mm: try VMA lock-based page fault handling first
> git bisect bad e06f47a16573decc57498f2d02f9af3bb3e84cf2
> # skip: [0bff0aaea03e2a3ed6bfa302155cca8a432a1829] x86/mm: try VMA lock-based page fault handling first
> git bisect skip 0bff0aaea03e2a3ed6bfa302155cca8a432a1829
> # skip: [cd7f176aea5f5929a09a91c661a26912cc995d1b] arm64/mm: try VMA lock-based page fault handling first
> git bisect skip cd7f176aea5f5929a09a91c661a26912cc995d1b
> # good: [52f238653e452e0fda61e880f263a173d219acd1] mm: introduce per-VMA lock statistics
> git bisect good 52f238653e452e0fda61e880f263a173d219acd1
> # bad: [c7f8f31c00d187a2c71a241c7f2bd6aa102a4e6f] mm: separate vma->lock from vm_area_struct
> git bisect bad c7f8f31c00d187a2c71a241c7f2bd6aa102a4e6f
> # only skipped commits left to test
> # possible first bad commit: [c7f8f31c00d187a2c71a241c7f2bd6aa102a4e6f] mm: separate vma->lock from vm_area_struct
> # possible first bad commit: [0d2ebf9c3f7822e7ba3e4792ea3b6b19aa2da34a] mm/mmap: free vm_area_struct without call_rcu in exit_mmap
> # possible first bad commit: [70d4cbc80c88251de0a5b3e8df3275901f1fa99a] powerc/mm: try VMA lock-based page fault handling first
> # possible first bad commit: [cd7f176aea5f5929a09a91c661a26912cc995d1b] arm64/mm: try VMA lock-based page fault handling first
> # possible first bad commit: [0bff0aaea03e2a3ed6bfa302155cca8a432a1829] x86/mm: try VMA lock-based page fault handling first
> 
> I do not usually see any kernel log output while running the program, just occasional logs about user space segfaults.

See Bugzilla for the full thread.

Jacob: Can you repeat bisection please? Why did you skip VMA lock-based
page fault commits in your bisection?

Anyway, I'm adding it to regzbot:

#regzbot introduced: 0bff0aaea03e2a..c7f8f31c00d187 https://bugzilla.kernel.org/show_bug.cgi?id=217624
#regzbot title: Memory corruption in multithreaded user space program while calling fork (possibly caused by trying VMA lock-based page fault)

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217624

-- 
An old man doll... just what I always wanted! - Clara
