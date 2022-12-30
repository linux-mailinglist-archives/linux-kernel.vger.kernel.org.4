Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A1658737
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiL1WJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiL1WIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:08:52 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6108D165A7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:08:43 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v126so18814061ybv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+UOSzbZJcOyA+Yr8ZuOksrZ5gFAaTY64UTht37oO0B4=;
        b=eTW398TrmSNE2m6sbh3hE6JKhRNkQGk4VPV1XgAQ+qF0b8+a8j96yQrjRd264+ik5q
         5jklRWdjO0u2yZUaZO3m4eBZFo5mjCp8XHDx3GsIlMBOnBswAlykg5xOo+oeryBXGiJE
         12J1A4lmjvHc6jd9uWsaqq3DnMb6XOJMqfxpOh0t7DLik2fnflrMuXXFE2465UcMF3VW
         Q3fQf1WA1uTTn6iqjoBYzWsnueXhvh78rvxCc9WNEDlL3ejd+hGYqILKJPNzuozcAjEj
         BO8ab7tjIABPbXSNEUixp2uoRtZgmUAjGy8uaGRc/iWnIvtgYHxUXLIrLWy3ihUQMLUO
         CkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UOSzbZJcOyA+Yr8ZuOksrZ5gFAaTY64UTht37oO0B4=;
        b=bXAVFR8ifSwgMXZl149PXc/vifNXNhDtYrQUwlGmaPEiWKP0n2Q0afhLntrch+50qM
         9QWXFjyqaURsiHHpgrXNhCzupIBrv/CzSMb+RBtWqmU6Y0OZJuyErJBl94wX7/J4qGpS
         zYiUkA2sBdjXcCA3PNl6utfMOcn1vh1K4tthzszoA4mCMvLSIMJOHrQkNrF6LT8vE9Qw
         1hDyCr5njY51XH1Y+hezHEmglPF3X6yKvH7QYKAMt0vLHjrLVp1yhRGFEdC45DCq8sqB
         hVMDwWL8f4+3+B9i6DsvKc4GBX1FquDjFNtU19O+AmkCDtlnw4qdCqzdRuWwL6GAwY8J
         yUWA==
X-Gm-Message-State: AFqh2komnh20wDZPVjRV8tBKWdePmuCYv4jsELI8mz8kR18lxXXgs/jU
        K68xdm8HSnqvmaAMy12kJl2XUE+4Q0xxnpMS3T/hNA==
X-Google-Smtp-Source: AMrXdXukx3AKz5U/a3mn7prmrwoJOCzEmLQLgdrYP6ahxHsXsSrNM1v3lu+RM8aXvGzJub+K1aAIuQurIp1zm8/ncmk=
X-Received: by 2002:a25:da14:0:b0:707:34cf:b4b1 with SMTP id
 n20-20020a25da14000000b0070734cfb4b1mr2609772ybf.123.1672265322235; Wed, 28
 Dec 2022 14:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com> <20221222023457.1764-8-vipinsh@google.com>
 <CANgfPd_iktQYfRc0=zp4wsrADPQhPQNKo_MBZ0djzeeYi+w6aw@mail.gmail.com>
In-Reply-To: <CANgfPd_iktQYfRc0=zp4wsrADPQhPQNKo_MBZ0djzeeYi+w6aw@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 28 Dec 2022 14:08:06 -0800
Message-ID: <CAHVum0dU5C7Nrs1GPMzrWcg6juz6xYKoEPbvUj4h_VLiov4z0w@mail.gmail.com>
Subject: Re: [Patch v3 7/9] KVM: x86/mmu: Allocate page table's pages on NUMA
 node of the underlying pages
To:     Ben Gardon <bgardon@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 27, 2022 at 11:34 AM Ben Gardon <bgardon@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 6:35 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > Page table pages of a VM are currently allocated based on the current
> > task's NUMA node or its mempolicy. This can cause suboptimal remote
> > accesses by the vCPU if it is accessing physical pages local to its NUMA
> > node but the page table pages mapping those physcal pages were created
> > by some other vCPU which was on different NUMA node or had different
> > policy.
> >
> > Allocate page table pages on the same NUMA node where underlying
> > physical page exists. Page table at level 5, 4, and 3 might not end up
> > on the same NUMA node as they can span multiple NUMA nodes.
>
> A page table at any level could map memory spanning multiple NUMA
> nodes, it just becomes more likely at higher levels.
> We're only guaranteed that a page table maps memory all on the same
> node if it's a split hugepage.

Even in this case, it is a best effort.

> This change can only guarantee that the page table pages are allocated
> on the same node as at least some of the memory they map.
> Of course in practice, the above is absolutely correct since we'd
> expect to have multi-GB continuous ranges of GFNs allocated on the
> same node via huge pages.
>
> And since the root pages are allocated based only on where the thread
> allocating them is running, they're not actually guaranteed to be on
> the same node as any of the memory they map. (Though they probably
> will be.)
>

I will add more details in the commit in the next version.

> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  2 +-
> >  arch/x86/kvm/mmu/mmu.c          | 63 ++++++++++++++++++++++-----------
> >  arch/x86/kvm/mmu/paging_tmpl.h  |  4 +--
> >  arch/x86/kvm/mmu/tdp_mmu.c      | 11 +++---
> >  virt/kvm/kvm_main.c             |  2 +-
> >  5 files changed, 53 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 293994fabae3..b1f319ad6f89 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -782,7 +782,7 @@ struct kvm_vcpu_arch {
> >         struct kvm_mmu *walk_mmu;
> >
> >         struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
> > -       struct kvm_mmu_memory_cache mmu_shadow_page_cache;
> > +       struct kvm_mmu_memory_cache mmu_shadow_page_cache[MAX_NUMNODES];
> >         struct kvm_mmu_memory_cache mmu_shadowed_info_cache;
> >         struct kvm_mmu_memory_cache mmu_page_header_cache;
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 23a3b82b2384..511c6ef265ee 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -677,24 +677,29 @@ static int mmu_topup_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
> >
> >  static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
> >  {
> > -       int r;
> > +       int r, nid;
> >
> >         /* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
> >         r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> >                                        1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
> >         if (r)
> >                 return r;
> > -       r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
> > -                                     &vcpu->arch.mmu_shadow_page_cache_lock,
> > -                                     PT64_ROOT_MAX_LEVEL);
> > -       if (r)
> > -               return r;
> > +
> > +       for_each_online_node(nid) {
> > +               r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
> > +                                             &vcpu->arch.mmu_shadow_page_cache_lock,
> > +                                             PT64_ROOT_MAX_LEVEL);
> > +               if (r)
> > +                       return r;
> > +       }
> > +
> >         if (maybe_indirect) {
> >                 r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_shadowed_info_cache,
> >                                                PT64_ROOT_MAX_LEVEL);
> >                 if (r)
> >                         return r;
> >         }
> > +
> >         return kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
> >                                           PT64_ROOT_MAX_LEVEL);
> >  }
> > @@ -715,9 +720,14 @@ static void mmu_free_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
> >
> >  static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
> >  {
> > +       int nid;
> > +
> >         kvm_mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
> > -       mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
> > -                                &vcpu->arch.mmu_shadow_page_cache_lock);
> > +
> > +       for_each_node(nid)
> > +               mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
> > +                                        &vcpu->arch.mmu_shadow_page_cache_lock);
> > +
>
> Was just trying to think if there could be any issue with memory
> leakage if the online nodes changed, though IDK if any hardware does
> that.
> Still, it might be more robust to use ARRAY_SIZE and cover the whole array.

for_each_node() goes through all of the possible nodes on the system,
whereas, for_each_online_node() goes through only online nodes.
Current code seems right to me, let me know if I am overlooking
something.

>
> >         kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
> >         kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
> >  }
> > @@ -2256,11 +2266,12 @@ static struct kvm_mmu_page *__kvm_mmu_get_shadow_page(struct kvm *kvm,
> >
> >  static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
> >                                                     gfn_t gfn,
> > -                                                   union kvm_mmu_page_role role)
> > +                                                   union kvm_mmu_page_role role,
> > +                                                   int nid)
> >  {
> >         struct shadow_page_caches caches = {
> >                 .page_header_cache = &vcpu->arch.mmu_page_header_cache,
> > -               .shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache,
> > +               .shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache[nid],
> >                 .shadowed_info_cache = &vcpu->arch.mmu_shadowed_info_cache,
> >                 .shadow_page_cache_lock = &vcpu->arch.mmu_shadow_page_cache_lock
> >         };
> > @@ -2316,15 +2327,19 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
> >
> >  static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
> >                                                  u64 *sptep, gfn_t gfn,
> > -                                                bool direct, unsigned int access)
> > +                                                bool direct, unsigned int access,
> > +                                                kvm_pfn_t pfn)
> >  {
> >         union kvm_mmu_page_role role;
> > +       int nid;
> >
> >         if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
> >                 return ERR_PTR(-EEXIST);
> >
> >         role = kvm_mmu_child_role(sptep, direct, access);
> > -       return kvm_mmu_get_shadow_page(vcpu, gfn, role);
> > +       nid = kvm_pfn_to_page_table_nid(pfn);
> > +
> > +       return kvm_mmu_get_shadow_page(vcpu, gfn, role, nid);
> >  }
> >
> >  static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
> > @@ -3208,7 +3223,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >                 if (it.level == fault->goal_level)
> >                         break;
> >
> > -               sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
> > +               sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true,
> > +                                         ACC_ALL, fault->pfn);
> >                 if (sp == ERR_PTR(-EEXIST))
> >                         continue;
> >
> > @@ -3636,7 +3652,7 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
> >         WARN_ON_ONCE(quadrant && !role.has_4_byte_gpte);
> >         WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
> >
> > -       sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
> > +       sp = kvm_mmu_get_shadow_page(vcpu, gfn, role, numa_mem_id());
> >         ++sp->root_count;
> >
> >         return __pa(sp->spt);
> > @@ -5952,7 +5968,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
> >
> >  int kvm_mmu_create(struct kvm_vcpu *vcpu)
> >  {
> > -       int ret;
> > +       int ret, nid;
> >
> >         INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_pte_list_desc_cache,
> >                                   pte_list_desc_cache, NUMA_NO_NODE);
> > @@ -5960,8 +5976,9 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
> >         INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_page_header_cache,
> >                                   mmu_page_header_cache, NUMA_NO_NODE);
> >
> > -       INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadow_page_cache,
> > -                                 NULL, NUMA_NO_NODE);
> > +       for_each_node(nid)
> > +               INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadow_page_cache[nid],
> > +                                         NULL, nid);
> >         spin_lock_init(&vcpu->arch.mmu_shadow_page_cache_lock);
> >
> >         vcpu->arch.mmu = &vcpu->arch.root_mmu;
> > @@ -6692,13 +6709,17 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
> >  }
> >
> >  static unsigned long mmu_shrink_cache(struct kvm_mmu_memory_cache *cache,
> > +                                     int cache_count,
> >                                       spinlock_t *cache_lock)
> >  {
> >         unsigned long freed = 0;
> > +       int nid;
> >
> >         spin_lock(cache_lock);
> > -       if (cache->nobjs)
> > -               freed = kvm_mmu_empty_memory_cache(cache);
> > +       for (nid = 0; nid < cache_count; nid++) {
> > +               if (node_online(nid) && cache[nid].nobjs)
>
> Is there any reason to keep the cache if !node_online(nid)?
> Actually, I'd also just drop the cache_count argument and always
> iterate over the entire array, only checking nobjs. There's no
> guarantee I'm aware of that the set of nodes has a sequential series
> of IDs starting at 0 and you'd get a bug if that wasn't the case since
> it only iterates to  nid < cache_count here but some of the earlier
> nids might not have been online.
>

This is just temporary and will be removed in the next patch in the series.

mmu_shrink_cache() is used for both split_shadow_page_cache (single
object) and mmu_shadow_page_cache[MAX_NUMANODES].

In next patch of this series, I used for_each_online_node(nide), I
will change it to for_each_node() in the next version.

> > +                       freed += kvm_mmu_empty_memory_cache(&cache[nid]);
> > +       }
> >         spin_unlock(cache_lock);
> >         return freed;
> >  }
> > @@ -6721,13 +6742,15 @@ mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >                 list_move_tail(&kvm->vm_list, &vm_list);
> >
> >                 freed += mmu_shrink_cache(&kvm->arch.split_shadow_page_cache,
> > +                                         1,
>
> So lonely.
> One.
> All by itself,
> with only a coma for company.
>
> NIT: This could be merged to the previous or subsequent lines.

This is a strong and independent '1'.

>
> >                                           &kvm->arch.split_shadow_page_cache_lock);
> >
> >                 if (freed >= sc->nr_to_scan)
> >                         break;
> >
> >                 kvm_for_each_vcpu(i, vcpu, kvm) {
> > -                       freed += mmu_shrink_cache(&vcpu->arch.mmu_shadow_page_cache,
> > +                       freed += mmu_shrink_cache(vcpu->arch.mmu_shadow_page_cache,
> > +                                                 MAX_NUMNODES,
> >                                                   &vcpu->arch.mmu_shadow_page_cache_lock);
> >                 }
> >
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > index e5662dbd519c..1ceca62ec4cf 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -652,7 +652,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >                 table_gfn = gw->table_gfn[it.level - 2];
> >                 access = gw->pt_access[it.level - 2];
> >                 sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
> > -                                         false, access);
> > +                                         false, access, fault->pfn);
> >
> >                 if (sp != ERR_PTR(-EEXIST)) {
> >                         /*
> > @@ -708,7 +708,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >                 validate_direct_spte(vcpu, it.sptep, direct_access);
> >
> >                 sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
> > -                                         true, direct_access);
> > +                                         true, direct_access, fault->pfn);
> >                 if (sp == ERR_PTR(-EEXIST))
> >                         continue;
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 376b8dceb3f9..b5abae2366dd 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -259,12 +259,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
> >                     kvm_mmu_page_as_id(_root) != _as_id) {              \
> >                 } else
> >
> > -static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu)
> > +static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu, int nid)
> >  {
> >         struct kvm_mmu_page *sp;
> >
> >         sp = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
> > -       sp->spt = kvm_mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache,
> > +       sp->spt = kvm_mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache[nid],
> >                                                 &vcpu->arch.mmu_shadow_page_cache_lock);
> >
> >         return sp;
> > @@ -317,7 +317,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
> >                         goto out;
> >         }
> >
> > -       root = tdp_mmu_alloc_sp(vcpu);
> > +       root = tdp_mmu_alloc_sp(vcpu, numa_mem_id());
>
> Might be worth calling out somewhere that the root page is just
> allocated based on where the thread allocating it runs.
>

How about a comment just up here or do you prefer at tdp_mmu_roots in
struct kvm_arch{}?

> >         tdp_mmu_init_sp(root, NULL, 0, role);
> >
> >         refcount_set(&root->tdp_mmu_root_count, 1);
> > @@ -1149,7 +1149,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >         struct kvm *kvm = vcpu->kvm;
> >         struct tdp_iter iter;
> >         struct kvm_mmu_page *sp;
> > -       int ret = RET_PF_RETRY;
> > +       int ret = RET_PF_RETRY, nid;
> >
> >         kvm_mmu_hugepage_adjust(vcpu, fault);
> >
> > @@ -1178,11 +1178,12 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >                     !is_large_pte(iter.old_spte))
> >                         continue;
> >
> > +               nid = kvm_pfn_to_page_table_nid(fault->pfn);
> >                 /*
> >                  * The SPTE is either non-present or points to a huge page that
> >                  * needs to be split.
> >                  */
> > -               sp = tdp_mmu_alloc_sp(vcpu);
> > +               sp = tdp_mmu_alloc_sp(vcpu, nid);
> >                 tdp_mmu_init_child_sp(sp, &iter);
> >
> >                 sp->nx_huge_page_disallowed = fault->huge_page_disallowed;
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index d96c8146e9ba..4f3db7ffeba8 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -415,7 +415,7 @@ static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
> >         if (mc->kmem_cache)
> >                 return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
> >         else
> > -               return (void *)__get_free_page(gfp_flags);
> > +               return kvm_mmu_get_free_page(mc->node, gfp_flags);
>
> You could do part of this change in the commit that introduced
> kvm_mmu_get_free_page too.

Yeah, I can do it there as well. No strong opinions. I will update in
the next version.

> >  }
> >
> >  int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min)
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
