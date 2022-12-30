Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0805F65873B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiL1WJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiL1WJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:09:08 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A2167DA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:08:52 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-45ef306bd74so238624417b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww/9HMSO5MvT/uNc4zof3Bf8xSdgUBtcepwAjta2Ulo=;
        b=tRtnRD+ifycdGiwnLte2WpnJlOhnD2FjtQF5KoBf6rV1S8eKBNRcfPRGl6k1fwclub
         HHIOwOLcoJpIKkcUJPy+VJZzyXc+AwSYy7RcBfrkkiTaSEqxXdIAtuLjhM9EIchMNV7h
         vutWj9FHbpPzyWiMnEhRkzBq9emqLnqTfGZCQvw3vNfWfd9IMdh3pF7yFkzGj/kNlW/d
         PrxdDeBHnYAe/lpzzyME6N2bv8te2Rjc0AhwgVeKINwhk1WKLOoV55jFkX4BKsZCgBDi
         U2sVtIe8a9mB29Y2vsFM+V3B+5XZPUuH4xJ/21ed7RGghe+hF2SrJGLw45jMT9a1Ywcw
         5USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww/9HMSO5MvT/uNc4zof3Bf8xSdgUBtcepwAjta2Ulo=;
        b=BT+JTT2Jr64x27s20ZzMOBAnaMpNAjw+zJchJl1AwIHeWq3rZKAFaETs+3SoDm6ymr
         BhXFAMV0apDDDx9n7SnyXx8CnvWXf4R5jSBiFgiLTnTRSy82tovm0u2XoABKJw6+Q5rT
         GXrVEnAJ1yUdX5jjWrOBlPf67bKH6F3jpgI0b7KPUHOzgpWkqM9gBP8qpk35X7ZI0epl
         NntsnUL5kpEw2cj5dWBwRbB524m6JHYRC4nhj3P312BYDUjrD7C6eE27X/HFAgIfhIay
         bJd3TVS/lI2ik0MShyStPYXNWylZYEdvNtZ85CpoJRrSKXk/OXiFeediT+d4Oer/BTrn
         UnHQ==
X-Gm-Message-State: AFqh2koirvT+1YVr2rOm9bhHwkNPaQhTGiOZMSJe7IE/mUs6G3WXCTgQ
        X+Qdwz9xPEojlovEUraDBoQ2Kr/c9PWZ2+HibyQO5w==
X-Google-Smtp-Source: AMrXdXsBOfKVcZkXidSa8Bc+gpXY51poRozZkyB5xeB++NvP2FAo4kIt38BrvtbJyv+rPmCutRG8sDnW1ua2+2gllo8=
X-Received: by 2002:a0d:d882:0:b0:36f:f251:213b with SMTP id
 a124-20020a0dd882000000b0036ff251213bmr1958607ywe.228.1672265331471; Wed, 28
 Dec 2022 14:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com> <20221222023457.1764-10-vipinsh@google.com>
 <CANgfPd9xu5yw+k4WfCQKVsouM5mKtMNG_Kd7_tokkJm=ha4JTA@mail.gmail.com>
In-Reply-To: <CANgfPd9xu5yw+k4WfCQKVsouM5mKtMNG_Kd7_tokkJm=ha4JTA@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 28 Dec 2022 14:08:15 -0800
Message-ID: <CAHVum0cSnVkeuLE0ddqGuBQebB3EsOd70CDM1m28nBQH2bFiJw@mail.gmail.com>
Subject: Re: [Patch v3 9/9] KVM: x86/mmu: Reduce default cache size in KVM
 from 40 to PT64_ROOT_MAX_LEVEL
To:     Ben Gardon <bgardon@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:52 AM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 6:35 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE is set to 40 without any specific
> > reason. Reduce default size to PT64_ROOT_MAX_LEVEL, which is currently
> > 5.
> >
> > Change mmu_pte_list_desc_cache size to what is needed as it is more than
> > 5 but way less than 40.
>
> Why do you say more than 5? At least to resolve a page fault we'll
> never need more than 4 pages on a system with 5 level paging since the
> root is already allocated.

Because of the comment in code:
> >         /* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
> > -       r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> > -                                      1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);

>
> >
> > Tested by running dirty_log_perf_test on both tdp and shadow MMU with 48
> > vcpu and 2GB/vcpu size on a 2 NUMA node machine. No impact on
> > performance noticed.
> >
> > Ran perf on dirty_log_perf_test and found kvm_mmu_get_free_page() calls
> > reduced by ~3300 which is near to 48 (vcpus) * 2 (nodes) * 35 (cache
> > size).
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >  arch/x86/include/asm/kvm_types.h | 2 +-
> >  arch/x86/kvm/mmu/mmu.c           | 7 ++++---
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
> > index 08f1b57d3b62..752dab218a62 100644
> > --- a/arch/x86/include/asm/kvm_types.h
> > +++ b/arch/x86/include/asm/kvm_types.h
> > @@ -2,6 +2,6 @@
> >  #ifndef _ASM_X86_KVM_TYPES_H
> >  #define _ASM_X86_KVM_TYPES_H
> >
> > -#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
> > +#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE PT64_ROOT_MAX_LEVEL
>
> Please add a comment explaining why this value was chosen.

Okay


>
> >
> >  #endif /* _ASM_X86_KVM_TYPES_H */
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 7454bfc49a51..f89d933ff380 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -677,11 +677,12 @@ static int mmu_topup_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
> >
> >  static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
> >  {
> > -       int r, nid;
> > +       int r, nid, desc_capacity;
> >
> >         /* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
> > -       r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> > -                                      1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
> > +       desc_capacity = 1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM;
> > +       r = __kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> > +                                        desc_capacity, desc_capacity);
> >         if (r)
> >                 return r;
> >
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
