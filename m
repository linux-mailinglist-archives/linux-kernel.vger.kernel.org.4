Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA496126DE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3CRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3CRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:17:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2348C88
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:17:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 192so7917773pfx.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djv+whaK1JGhd2WY4lOcGGGnfZ6VWdKZ6NPedavrXCY=;
        b=iJCDcU7Gxo45Ku9v8qILGkQh56006GIFb+azCyZl79MfFSSAsilKzdNVrORAkTWLTT
         2AaXfyWUMDdh4EQnN7c0EeT2yS+WR1OovYe0ujBvqx3gFcUUK7W+qmpYGYEB/AwVlF8i
         9Z7ZTWDBbgO5ti5X0/ejQxRv+BxsyRKyQYNDABBa+trrrNTEJ13Iml5SeKHgmaUTRWUm
         w5GATdaOf0ERFGjTdyf9313Npb+mUBYICcnNjtFCepJhIGsqa6vZu7AdWD3Dl0My8AEu
         eop2VH7ecx6tSRhzRt2TJ1GFx0I9EMujU/TDrT88zGFagRHNI+fNXE9bqc8cCAcwJZEK
         ENCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djv+whaK1JGhd2WY4lOcGGGnfZ6VWdKZ6NPedavrXCY=;
        b=0i/xebeCAR2w6OPlpcx6v1MWebftufcN38pZkBJd7v9icSOMhfwmeMVVgkwme9jB3a
         EOSBF9afKitwzgnroWg28CUd9AviRr3NfdE52uRRGvClSUU3RLT6whxbfFgNLzPTClTx
         bJllTLnqE3Jyq+02cL8ydewJN0LkNWfUvY7CFsNOaWyXwL13Tci56r1hCpmhW+m71PbN
         2SE1C1GEf3Efz8hM+uGkj1zZkK13W8tmWq99oyXa1lVB+kO9dJ5zT5FDbphRS4O6GW9M
         R8G61F0E/VjtCgmBSTQbxHH71rhwNN24ODImcHcpqgK3UsgnfDvBmd12yxLlJD4Y025P
         v9PQ==
X-Gm-Message-State: ACrzQf0zqO72nagQdarYQgwt4y16H5AOAj+gdbFEDjxIzt1Q7xZSrih1
        j2sJkKdqnzVTBl2tQthQK80=
X-Google-Smtp-Source: AMsMyM7CiTVlySeX5jhzGzHkC0JoJc2m/Z6NrrOPKBNx+Ki+uc7nK4N446dUSGCdy7bpiC/rqpPebA==
X-Received: by 2002:aa7:8883:0:b0:56c:6c76:cbc2 with SMTP id z3-20020aa78883000000b0056c6c76cbc2mr6809383pfe.25.1667096264927;
        Sat, 29 Oct 2022 19:17:44 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm1873016pfp.19.2022.10.29.19.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 19:17:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
Date:   Sat, 29 Oct 2022 19:17:42 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2022, at 11:58 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> On Sat, Oct 29, 2022 at 11:36 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Anyway, I think the best documentation for "this is what I meant" is
>> simply the patch. Does this affect your PoC on your setup?
>=20
> Here's a slightly cleaned up set with preliminary commit messages, and
> an explanation for why some of the 'struct page' declarations were
> moved around a bit in case you wondered about that part of the change
> in the full patch.
>=20
> The end result should be the same, so if you already looked at the
> previous unified patch, never mind. But this one tries to make for a
> better patch series.
>=20
> Still not tested in any way, shape, or form. I decided I wanted to
> send this one before booting into this and possibly blowing up ;^)

Running the PoC on Linux 6.0.6 with these patches caused the following =
splat
on the following line:

	WARN_ON_ONCE(!folio_test_locked(folio) && =
!folio_test_dirty(folio));

Although I did not hit the warning on the next line =
(!folio_buffers(folio)),
the commit log for the warning that actually triggered also leads to the
same patch of Jan Kara that is intended to check if a page is dirtied
without buffers (the scenario we are concerned about).


  Author: Jan Kara <jack@suse.cz>
  Date:   Thu Dec 1 11:46:40 2016 -0500

    ext4: warn when page is dirtied without buffers
   =20
    Warn when a page is dirtied without buffers (as that will likely =
lead to
    a crash in ext4_writepages()) or when it gets newly dirtied without =
the
    page being locked (as there is nothing that prevents buffers to get
    stripped just before calling set_page_dirty() under memory =
pressure).=20



[  908.444806] ------------[ cut here ]------------
[  908.451010] WARNING: CPU: 16 PID: 2113 at fs/ext4/inode.c:3634 =
ext4_dirty_folio+0x74/0x80
[  908.460343] Modules linked in:
[  908.463856] CPU: 16 PID: 2113 Comm: poc Not tainted 6.0.6+ #21
[  908.470521] Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS =
2.13.0 05/14/2021
[  908.479202] RIP: 0010:ext4_dirty_folio+0x74/0x80
[  908.484489] Code: d5 ee ff 41 5c 41 5d 5d c3 cc cc cc cc be 08 00 00 =
00 4c 89 e7 e8 bc 03 e0 ff 4c 89 e7 e8 f4 f8 df ff 49 8b 04 24 a8 08 75 =
bc <0f> 0b eb b8 0f 0b eb c6 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41
[  908.505851] RSP: 0018:ffff88a1197df9a8 EFLAGS: 00010246
[  908.511826] RAX: 0057ffffc0002014 RBX: ffffffff83414b60 RCX: =
ffffffff818ceafc
[  908.519964] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: =
ffffea00fffd9f40
[  908.528103] RBP: ffff88a1197df9b8 R08: 0000000000000001 R09: =
fffff9401fffb3e9
[  908.536239] R10: ffffea00fffd9f47 R11: fffff9401fffb3e8 R12: =
ffffea00fffd9f40
[  908.544376] R13: ffff88a087d368d8 R14: ffff88a1197dfb08 R15: =
ffff88a1197dfb00
[  908.552509] FS:  00007ff7caa68700(0000) GS:ffff8897edc00000(0000) =
knlGS:0000000000000000
[  908.561731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  908.568299] CR2: 00007ff7caa67ed8 CR3: 00000020cc970001 CR4: =
00000000001706e0
[  908.576437] Call Trace:
[  908.579252]  <TASK>
[  908.581683]  folio_mark_dirty+0x69/0xa0
[  908.586097]  set_page_dirty+0x2a/0x90
[  908.590301]  tlb_flush_mmu+0xc1/0x320
[  908.594517]  tlb_finish_mmu+0x49/0x190
[  908.598822]  unmap_region+0x1fa/0x250
[  908.603029]  ? anon_vma_compatible+0x120/0x120
[  908.608110]  ? __kasan_check_read+0x11/0x20
[  908.612926]  ? __vma_rb_erase+0x38a/0x610
[  908.617547]  __do_munmap+0x313/0x770
[  908.621669]  mmap_region+0x227/0xa50
[  908.625774]  ? down_read+0x320/0x320
[  908.629874]  ? lock_acquire+0x19a/0x450
[  908.634285]  ? __x64_sys_brk+0x4e0/0x4e0
[  908.641552]  ? thp_get_unmapped_area+0xca/0x150
[  908.649404]  ? cap_mmap_addr+0x1d/0x90
[  908.656373]  ? security_mmap_addr+0x3c/0x50
[  908.663781]  ? get_unmapped_area+0x173/0x1f0
[  908.671248]  ? arch_get_unmapped_area+0x330/0x330
[  908.679231]  do_mmap+0x3c3/0x610
[  908.685519]  vm_mmap_pgoff+0x177/0x230
[  908.692303]  ? randomize_page+0x70/0x70
[  908.699133]  ksys_mmap_pgoff+0x241/0x2a0
[  908.706011]  __x64_sys_mmap+0x8d/0xb0
[  908.712594]  do_syscall_64+0x3b/0x90
[  908.719090]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  908.727201] RIP: 0033:0x7ff7cbf868e6
[  908.733559] Code: 00 00 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b =
55 48 89 fd 53 89 cb 48 85 ff 74 37 41 89 da 48 89 ef b8 09 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 62 5b 5d c3 0f 1f 80 00 00 00 00 48 8b 05 71
[  908.759522] RSP: 002b:00007ff7caa67ea8 EFLAGS: 00000206 ORIG_RAX: =
0000000000000009
[  908.770475] RAX: ffffffffffffffda RBX: 0000000000008011 RCX: =
00007ff7cbf868e6
[  908.780919] RDX: 0000000000000003 RSI: 0000000000200000 RDI: =
00007ff7cbc00000
[  908.791344] RBP: 00007ff7cbc00000 R08: 0000000000000003 R09: =
0000000000000000
[  908.801751] R10: 0000000000008011 R11: 0000000000000206 R12: =
00007ffed51cbc4e
[  908.812118] R13: 00007ffed51cbc4f R14: 00007ffed51cbc50 R15: =
00007ff7caa67fc0
[  908.822523]  </TASK>
[  908.827213] irq event stamp: 4169
[  908.833101] hardirqs last  enabled at (4183): [<ffffffff8133f028>] =
__up_console_sem+0x68/0x80
[  908.844884] hardirqs last disabled at (4194): [<ffffffff8133f00d>] =
__up_console_sem+0x4d/0x80
[  908.856622] softirqs last  enabled at (4154): [<ffffffff83000430>] =
__do_softirq+0x430/0x5db
[  908.868167] softirqs last disabled at (4149): [<ffffffff8125fd89>] =
irq_exit_rcu+0xe9/0x120
[  908.879611] ---[ end trace 0000000000000000 ]---

