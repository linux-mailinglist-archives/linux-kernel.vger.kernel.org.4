Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A49601C74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJQWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiJQWal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:30:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE363C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:30:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so11059049wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7dizLwb/aHATK5NTVhbzHxjmngrs+WaOY2PFHmC8cY0=;
        b=k5amDsZUYP+FM8rXQgeHgEJTPije4fQP6xMIwfNl/4M8Ds3SukT2oFtYU9cTBegiD+
         dYG/cLDw5NCfLzSLPFt1317Zjzdho+DwaD2unMYVtYt27OaTBJOE0MJqm1MF8ckRjn1O
         McSHU8erigW3F9z2/TzX4IzlRKCfSe6ghVXzhIwR35OJ0de5ZMhPmCKNlV52CeorDvpV
         EKnU4OivF1Yt22zd/B+hSbXRvvMgpsi+U+WppznMlAFsQ10s1+K4lTwMGD5QqYjTX22P
         cWetlMlASQJTFasH9HU++dNb1X1EYYal/JmWXFWtXKWSURJae97if61luU3jRrkQdpt+
         UBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dizLwb/aHATK5NTVhbzHxjmngrs+WaOY2PFHmC8cY0=;
        b=rqQ/goGg65muj9MupRRM4XtmYT/8WEZbGfAh0MUECzMVkgs4X//upg14D/LtEfZgS4
         qzmP0VqiwZTwECT2XnO3CurGtFRIqMOWzxLzvgxJpJ+8Z7UwwVsAhuCjmP1v9NRqfS3q
         FA3yqNO1+zJGjGhgjh3X+4azg2FOnph1tTSdUEf5nH4dR3/nRYcj6tqhTEi/sL4QfXGt
         NwFsQWxwSYVE1OkhHPfDNr0BawMkECwy+840mM4asobPNnfIuWOP+4yv+7qG/nzU0xzl
         5bsqaAZWZHAFupPM+Rl7cLB3D8PLhimczp6sl7e54TLoNzEbXT/QTKeocmh3HsNU7Wpw
         9Agg==
X-Gm-Message-State: ACrzQf2xleipjaAdUsERoXAoln1e9fiuY2q9K5P4bWsLUB7eBFxH+dxB
        evrkYa4BBBsDWMRxmxxKIxN3OZIjELTWhunOt6vl0g==
X-Google-Smtp-Source: AMsMyM5k0UfAHA7LBXYIHsCZQ/SgZSBKMBHI572caBc/lY5faqsOJkGU96xiN3svxv51VW+SP9ENdxE87N5Ju64xHeI=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr21520134wmc.115.1666045809443; Mon, 17
 Oct 2022 15:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4oK8D-89QZnBC8eYS9TxOU48hY5JazTvF=4N2qdeRepbw@mail.gmail.com>
 <a21c90d5-5793-6b0d-e081-1ea450570774@infradead.org> <CA+QYu4oDz6FD9AwGEQXcoG7M-0dEmqhpbUtsMKdF=F+EBqQXLA@mail.gmail.com>
 <CAJkfWY7GTVnEd72Otzyvhyj_LEZwDmcHZ_dSL1uAAAs1J6Fz8g@mail.gmail.com>
In-Reply-To: <CAJkfWY7GTVnEd72Otzyvhyj_LEZwDmcHZ_dSL1uAAAs1J6Fz8g@mail.gmail.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Mon, 17 Oct 2022 15:29:57 -0700
Message-ID: <CAJkfWY7ipxCavNyMXACfqYjSZhmBY6gqR_RSDUytaCU5yrPwpA@mail.gmail.com>
Subject: Re: [6.0.0] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted a patch to fix this.
See: https://lore.kernel.org/all/20221017222620.715153-1-nhuck@google.com/T/#u

Thanks,
Huck

On Mon, Oct 17, 2022 at 12:59 PM Nathan Huckleberry <nhuck@google.com> wrote:
>
> Hello,
> On Mon, Oct 17, 2022 at 1:33 AM Bruno Goncalves <bgoncalv@redhat.com> wrote:
> >
> > On Sun, 16 Oct 2022 at 20:09, Randy Dunlap <rdunlap@infradead.org> wrote:
> > >
> > > [adding maintainers]
> > >
> > > Bruno- is this still an issue?
> >
> > Yes, we continue to reproduce it.
> >
> > Here is an example with 6.1-rc1
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9abf2313adc1ca1b6180c508c25f22f9395cc780)
> >
> > console log: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/17/redhat:668163532/build_x86_64_redhat:668163532_x86_64_debug/tests/1/results_0001/console.log/console.log
> > tarball: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/668163532/publish%20x86_64%20debug/3180162139/artifacts/kernel-mainline.kernel.org-redhat_668163532_x86_64_debug.tar.gz
> > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/668163532/build%20x86_64%20debug/3180162134/artifacts/kernel-mainline.kernel.org-redhat_668163532_x86_64_debug.config
> >
> >
> > Bruno
> > >
> > >
> > > On 10/3/22 00:16, Bruno Goncalves wrote:
> > > > Hello,
> > > >
> > > > recently we are hitting the following issue when booting using kernel
> > > > with debug options enabled:
> > > >
> > > > [  126.821761] CPU: 1 PID: 296 Comm: cryptomgr_test Not tainted 6.0.0 #1
> > > > [  126.824021] Hardware name: Red Hat KVM, BIOS 1.15.0-1.el9 04/01/2014
> > > > [  126.825721] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
> > > > [  126.827045] Code: df 11 c4 41 31 ef fb 48 83 c2 08 0f 84 eb 01 00
> > > > 00 48 89 d0 48 c1 e0 04 48 81 c7 80 00 00 00 48 29 c7 0f 10 06 66 41
> > > > 0f ef c7 <0f> 28 0f c4 63 71 44 f0 01 c4 e3 71 44 d0 10 c4 63 71 44 e0
> > > > 00 c4
> > >
> > > This is in 'partial_stride' handling at the 'movaps' instruction:
> > >
> > >   11:   48 89 d0                mov    %rdx,%rax
> > >   14:   48 c1 e0 04             shl    $0x4,%rax
> > >   18:   48 81 c7 80 00 00 00    add    $0x80,%rdi
> > >   1f:   48 29 c7                sub    %rax,%rdi
> > >   22:   0f 10 06                movups (%rsi),%xmm0
> > >   25:   66 41 0f ef c7          pxor   %xmm15,%xmm0
> > >   2a:*  0f 28 0f                movaps (%rdi),%xmm1             <-- trapping instruction
>
> It looks like the movaps here should be a movups. The keys are not
> guaranteed to be 16-byte aligned.
>
> I'll submit a patch at some point today.
>
> > >
> > > > [  126.831535] RSP: 0018:ffff88810ed779d8 EFLAGS: 00010282
> > > > [  126.832957] RAX: 0000000000000030 RBX: 0000000000000030 RCX: ffff88810ede19e8
> > > > [  126.834907] RDX: 0000000000000003 RSI: ffff8881094b8000 RDI: ffff88811483c408
> > > > [  126.836554] RBP: ffff8881094b8000 R08: ffffffffc0300835 R09: ffff88810ede19e8
> > > > [  126.838529] R10: ffffed1021dbc33f R11: 0000000000000000 R12: 0000000000000030
> > > > [  126.840526] R13: 0000000000000003 R14: ffff88810ede19e8 R15: ffff88810ede19e0
> > > > [  126.842702] FS:  0000000000000000(0000) GS:ffff888193d00000(0000)
> > > > knlGS:0000000000000000
> > > > [  126.844574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  126.846796] CR2: 0000564f48e04178 CR3: 000000010be88002 CR4: 0000000000370ee0
> > > > [  126.848934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [  126.850913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [  126.852879] Call Trace:
> > > > [  126.853703]  <TASK>
> > > > [  126.854436]  polyval_x86_update+0x102/0x1e0 [polyval_clmulni]
> > > > [  126.856092]  test_shash_vec_cfg+0x523/0x9d0
> > > > [  126.857360]  ? alg_test_aead+0x170/0x170
> > > > [  126.858682]  ? pointer+0x6a0/0x6a0
> > > > [  126.859752]  ? ___slab_alloc+0x910/0xf70
> > > > [  126.860950]  ? __alg_test_hash.constprop.0+0x200/0x430
> > > > [  126.862140]  ? __kmalloc+0x64/0x380
> > > > [  126.863233]  ? sprintf+0xb3/0xe0
> > > > [  126.864159]  ? rcu_read_lock_sched_held+0x3f/0x80
> > > > [  126.865560]  ? trace_kmalloc+0x33/0xf0
> > > > [  126.866716]  __alg_test_hash.constprop.0+0x2e7/0x430
> > > > [  126.867995]  ? test_ahash_vec_cfg+0xca0/0xca0
> > > > [  126.869389]  ? lockdep_hardirqs_on_prepare+0x230/0x230
> > > > [  126.870906]  ? lockdep_hardirqs_on+0x7d/0x100
> > > > [  126.872221]  ? alg_test_hash+0x8e/0x130
> > > > [  126.873398]  alg_test+0x60d/0x7d0
> > > > [  126.874463]  ? alloc_cipher_test_sglists+0xb0/0xb0
> > > > [  126.875867]  ? lock_release+0x233/0x470
> > > > [  126.876726]  ? __kthread_parkme+0x65/0xf0
> > > > [  126.877654]  ? reacquire_held_locks+0x270/0x270
> > > > [  126.878984]  ? mark_held_locks+0x24/0x90
> > > > [  126.879985]  ? preempt_count_sub+0xb7/0x100
> > > > [  126.881260]  ? crypto_acomp_scomp_free_ctx+0x70/0x70
> > > > [  126.882649]  cryptomgr_test+0x36/0x60
> > > > [  126.883786]  kthread+0x17e/0x1b0
> > > > [  126.884564]  ? kthread_complete_and_exit+0x20/0x20
> > > > [  126.885975]  ret_from_fork+0x22/0x30
> > > > [  126.887086]  </TASK>
> > > > [  126.887858] Modules linked in: polyval_clmulni(+) polyval_generic
> > > > virtio_blk(+) ghash_clmulni_intel floppy virtio_console serio_raw
> > > > ata_generic pata_acpi qemu_fw_cfg
> > > >
> > > >
> > > > full console log:
> > > > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/02/redhat:656405029/build_x86_64_redhat:656405029_x86_64_debug/tests/4/results_0001/console.log/console.log
> > > >
> > > > test logs: https://datawarehouse.cki-project.org/kcidb/tests/5344697
> > > > cki issue tracker: https://datawarehouse.cki-project.org/issue/1626
> > > >
> > > > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/build%20x86_64%20debug/3116060967/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.config
> > > > kernel tarball:
> > > > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/publish%20x86_64%20debug/3116060972/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.tar.gz
> > > >
> > > > We didn't bisect, but the first commit we tested that we hit the
> > > > problem is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46452d3786a82bd732ba73fb308ae5cbe4e1e591
> > > >
> > > > The last commit we tested and didn't hit the problem is
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1375562c0a87f0fa2eaf3e8ce15824696d4170a
> > > >
> > > > Thanks,
> > > > Bruno Goncalves
> > > >
> > >
> > > --
> > > ~Randy
> > >
> >
> Thanks,
> Huck
