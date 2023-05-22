Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045270C408
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjEVRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEVRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:09:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD8F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:09:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564eb7bc5a2so33055867b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684775382; x=1687367382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxGPTv7LM3oGgEhAUoDMYRGlbkDv2pfEAoiuJolvTqk=;
        b=t6LhhtzEqhvzy2TBVadbVEJ1vv8derp6b1zAtjSSm0RmHscI6wsGN76foziNXmt1d6
         M7zKju49MzXZFB5GfjZU+hDa/WwKy2PMhNVifigc+lI/sjWoV6rgRjh7/qKVQCUGGUzH
         s1KyYTLL58LKcnecbr2EBf3JYKfNm/2tYLBJFo/naB+p+zV0GfUUGvwnwydRPPzigSQ0
         D/72oTsL+RjgKgww4wE+dqTM7HiYNRAVQNi+wjl+0UESSc4deadQqXSMsVEolHNEt6/Z
         Ra9SL7MZK3LicAigPbYzoQS7fobojKykwng1a/ma0Y9FdKg6GoJS7X8xJNEaBhf0E0jH
         O8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684775382; x=1687367382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxGPTv7LM3oGgEhAUoDMYRGlbkDv2pfEAoiuJolvTqk=;
        b=dXxbXIomimJJ8xr7OvC0ixPd3JSAaEQMhpg+OPrjcN6QSKZm4BsPT/376UEJVzgany
         j3kXdUh1F4ZyYLNXImxyFCXB+K+9fjORH4EzoYwaaHFqoqS+Dg1qiiYnu0D0Y3MEZrug
         How4Lq3cFcsAaAMrz9nzZsTSHRxs9m36m5KJq49apBg4X+284s5OkotoC9GIWwN8HkV1
         uOK98NIUWzhE29FswSUIbDSirQnSz6cyNNC661pnW5ikKY+8HE0NzNdaa5fNdYkp2duR
         a9P/G18D/ExgzkesyNr7SVwzt/cxQsvRE2ZnmR/HamzZESsrpoR/SoudboDwQr2ngz2t
         Xlxw==
X-Gm-Message-State: AC+VfDz3qCBEbzHvo+c64HNygI08vJLeSuEX+kOIMda9bhdMNjfGpo8H
        ZEUrIsItRLP1hqeEGjjR0L48I9HQRpQ=
X-Google-Smtp-Source: ACHHUZ73BhFbQC+fWCY69yv+CkEbQX9Ne53cx/YvYNPIf7zUijTmoe57a0EmCHW0jOXGo8HuxvFq0GXXZ3Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:440b:0:b0:565:2bb:6860 with SMTP id
 r11-20020a81440b000000b0056502bb6860mr2419699ywa.4.1684775382361; Mon, 22 May
 2023 10:09:42 -0700 (PDT)
Date:   Mon, 22 May 2023 10:09:40 -0700
In-Reply-To: <20230522135036.wnvsmryhkvstwvw2@amd.com>
Mime-Version: 1.0
References: <ZD12htq6dWg0tg2e@google.com> <1ed06a62-05a1-ebe6-7ac4-5b35ba272d13@redhat.com>
 <ZD2bBB00eKP6F8kz@google.com> <9efef45f-e9f4-18d1-0120-f0fc0961761c@redhat.com>
 <ZD86E23gyzF6Q7AF@google.com> <5869f50f-0858-ab0c-9049-4345abcf5641@redhat.com>
 <ZEM5Zq8oo+xnApW9@google.com> <20230512002124.3sap3kzxpegwj3n2@amd.com>
 <ZF5+5g5hI7xyyIAS@google.com> <20230522135036.wnvsmryhkvstwvw2@amd.com>
Message-ID: <ZGuh1J6AOw5v2R1W@google.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, wei.w.wang@intel.com,
        Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023, Michael Roth wrote:
> On Fri, May 12, 2023 at 11:01:10AM -0700, Sean Christopherson wrote:
> > On Thu, May 11, 2023, Michael Roth wrote:
> I put together a tree with some fixups that are needed for against the
> kvm_gmem_solo base tree, and a set of hooks to handle invalidations,
> preparing the initial private state as suggested above, and a
> platform-configurable mask that the x86 MMU code can use for determining
> whether a fault is for private vs. shared pages.
> 
>   KVM: x86: Determine shared/private faults using a configurable mask
>   ^ for TDX we could trivially add an inverted analogue of the mask/logic
>   KVM: x86: Use full 64-bit error code for kvm_mmu_do_page_fault
>   KVM: x86: Add platform hooks for private memory invalidations

Hrm, I'd prefer to avoid adding another hook for this case, arch code already has
a "hook" in the form of kvm_unmap_gfn_range().  We'd probably just need a
kvm_gfn_range.is_private flag to communicate to arch/vendor code that the memory
being zapped is private.

That'd leave a gap for the unbind() case because kvm_unmap_gfn_range() is invoked
if and only if there's an overlapping memslot.  I'll chew on that a bit to see if
there's a way to cleanly handle that case without another hook.  I think it's worth
mapping out exactly what we want unbind() to look like anyways, e.g. right now the
code subtly relies on private memslots being immutable.

>   KVM: x86: Add platform hook for initializing private memory

This should also be unnecessary.  The call to kvm_gmem_get_pfn() is from arch
code, KVM just needs to ensure the RMP is converted before acquiring mmu_lock,
e.g. KVM has all the necessary info in kvm_tdp_mmu_page_fault().

The only reason to add another arch hook would be if we wanted to converted the
RMP when _allocating_, e.g. to preconvert in response to fallocate() instead of
waiting until #NPF.  But I think I would rather add a generic ioctl() to allow
userspace to effectively prefault guest memory, e.g. to setup the RMP before
running a vCPU.  Such an ioctl() would potentially be useful in other scenarios,
e.g. on the dest during live migration to reduce jitter.

>   *fixup (kvm_gmem_solo): KVM: Fix end range calculation for MMU invalidations

There was another bug in this path.  The math for handling a non-zero offsets into
the file was wrong.  The code now looks like:

	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
		struct kvm_gfn_range gfn_range = {
			.start = slot->base_gfn + start - slot->gmem.index,
			.end = slot->base_gfn + min(end - slot->gmem.index, slot->npages),
			.slot = slot,
			.pte = __pte(0),
			.may_block = true,
		};

		if (WARN_ON_ONCE(start < slot->gmem.index ||
				 end > slot->gmem.index + slot->npages))
			continue;

		kvm_mmu_invalidate_range_add(kvm, gfn_range.start, gfn_range.end);

		flush |= kvm_unmap_gfn_range(kvm, &gfn_range);
	}
