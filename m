Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387F66BD80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAPMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjAPMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:07:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA90196BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:07:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id h184so4053102iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=btqxdj2qYR3AcspG5TzORiD8Ae2hoP6388ovBCbCzvQ=;
        b=kfUFMt6bSOO3PRs7Bj1FxJ+7CsqSX1DIwrcuOKSvZSHb0T4BlZtfZdlJTFUcoCzZu7
         8fwP0zfvg1wi9LDSPb2Ib3hs4Bc1ki1SoPRJ2h/NLXS6SkmnDNoYa31GEYWLtJ0CNzRb
         E+FY/WsEMqg5TQC0FLvkPznJSlyqSjO4BX7BjAT61KZU9WBzGU68JTmjQ5IZHSJWj/g8
         LqyHJZlapgaANi4fUB1iNUjryz7aAF6VzStnPpR+aaBhsblQtxQxrWNQQAhRWUo1Mii2
         I80K7NQ5ESMOlMjU8V1FQIgILOo3FZigaIBeVStkNj3pc2DC9uYvklay/x/N6yUvkb5/
         K7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btqxdj2qYR3AcspG5TzORiD8Ae2hoP6388ovBCbCzvQ=;
        b=XgVxHYXdjnMWkDwBlHTAeP7+r2DheBUFoybvyBOPvT2eN8iMEWAYaQ9KcIs2JiTPCj
         brVytkF1E0xLS/L0icS7/lVeIzV7sHN+dZtrF6HD5sJLudqsRl+3VK2rMPtTmUUhQawt
         xEVunIdFO//lRwjGnuYCSbVGD4tMUYcSefQ/d1kdC0Nool0oUD/WM2MlK+DXv+11zSX/
         LvH3CzYhea9RJELbq5jRCAh02Kk58WBzOMxisVtNjhnTMNmHgKMPVQ6wRiLYmbK/6iGT
         yLWlq6Zl73l+5u6uzxNJM75WBQrZ9BiL50RR88DgspevaVZ/s1y9aIDPPXnCFtPFxF2b
         SsgA==
X-Gm-Message-State: AFqh2kpHno10tz8IjYXeEMHARqh/6fmr6d7z9wzu6CuX6fU6JF2W9M9q
        XgYhS87YJl0J6Ip7OC8zLgUyhj9OsR3OQwyOMfMjNw==
X-Google-Smtp-Source: AMrXdXtK8RA6kn9nd4h7X9buHkAUghEIkCs/DwCg551iJI3FGcpgeyjr5JVjeWDQXg3yMkN7hKb0zUp/NQjNqDJGwvA=
X-Received: by 2002:a05:6638:60c:b0:38c:886a:219a with SMTP id
 g12-20020a056638060c00b0038c886a219amr10328002jar.133.1673870855967; Mon, 16
 Jan 2023 04:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com> <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
In-Reply-To: <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jan 2023 13:06:59 +0100
Message-ID: <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
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

On Sun, Jan 15, 2023 at 8:07 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
> > No, that lockdep assert has to be there. Page table traversal is
> > allowed under any one of the mmap lock, the anon_vma lock (if the VMA
> > is associated with an anon_vma), and the mapping lock (if the VMA is
> > associated with a mapping); and so to be able to remove page tables,
> > we must hold all three of them.
>
> Okay, that's fair. I agree with the patch now. Maybe adjust the commit
> message a bit?

Just to make sure we're on the same page: Are you suggesting that I
add this text?
"Page table traversal is allowed under any one of the mmap lock, the
anon_vma lock (if the VMA is associated with an anon_vma), and the
mapping lock (if the VMA is associated with a mapping); and so to be
able to remove page tables, we must hold all three of them."
Or something else?

> Anyway:
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>

Thanks!

> BTW, I've noticied that you recently added tlb_remove_table_sync_one().
> I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
> good enough to serialize against GUP fast?

If that sent an IPI, it would be good enough; but
pmdp_collapse_flush() is not guaranteed to send an IPI.
It does a TLB flush, but on some architectures (including arm64 and
also virtualized x86), a remote TLB flush can be done without an IPI.
For example, arm64 has some fancy hardware support for remote TLB
invalidation without IPIs ("broadcast TLB invalidation"), and
virtualized x86 has (depending on the hypervisor) things like TLB
shootdown hypercalls (under Hyper-V, see hyperv_flush_tlb_multi) or
TLB shootdown signalling for preempted CPUs through shared memory
(under KVM, see kvm_flush_tlb_multi).
