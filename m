Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9E71101D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbjEYPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbjEYPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:54:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C3E6C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:54:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559c416b024so9786317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685030057; x=1687622057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDMfJuRmq9XZO6/bauwZ7gEniL7UaZKK/szKYWOECa4=;
        b=uMzuO2hejV9q/GN2+mr53TGXW2G+ALCx8dieU7LqMmMLbcaqzK1NaU8E2yc8PK0igu
         jFHKEAaHn6USjw1Oht6H19ZSLCERzzjA9yQ5NzU23BgBhevTKU2/RQnclcNfzmjZPRkJ
         PH0DyeRi8go2kvRzxdXV4sVjXux8EXvzbNTkU0oiVP4oPzOnP9yTyt9YtHpCPDBAyULl
         hsyGthIPgWmaC2JGf6OYQiQFbeOlj+CJhrllYORLxcMO6/aPCrN7sCa6MNCoaeEa42+1
         KMpimxF8pf5qhphDP1fpMcHC5tRUAnhGFoVpjOJH9ozC20ilS6SCH7hRcwJQ84UpFvtS
         opDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030057; x=1687622057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDMfJuRmq9XZO6/bauwZ7gEniL7UaZKK/szKYWOECa4=;
        b=azIkPt+6H/HxCqYhjJWeM0+pU7nAQVK9Amr1+nQL2GWD1lLjFQ664L+enJrzaKfgVb
         13FsQL3hGnFzlnnUyXZ64PuKgnD3ZDofQq9sONce0LGSbruKGCGDpaEzaHK+KYy7vEIk
         dpbUr5QffgY4Yj8iNCGeIupYDvLf0fRy4zwE8l2qAg/SUZ6xuO4rYr0wBeMYyG3tRT0O
         ugAPgTpmS6pHbX93/q6cMatuwU73IkFueXa/eKzEPzZJbqiEzoc2I6EfSAHBCYywuq/Z
         HPZl4Lh6ZgpUH5h5iuU/HUP1or2xEedC9ObVb1hPOzD0O7ivR/3oNtnDX9eH5h1lCA9I
         Y+HA==
X-Gm-Message-State: AC+VfDxrHAJbtX2YRjN8dS8axZP0yOmx2kcb/LVjZAHferHpaB5B7Gyi
        fiPoh8aQ7POfzD/cmlUJx2xUqMxs61Q=
X-Google-Smtp-Source: ACHHUZ5WNd8rnwxWFJ/9rjJtw4n6PnCBnYKp2t3jItxGv4IVuMiB2nneyF+evn/DmfL4ZExcKzHQYX87Xtg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5442:0:b0:ba8:8ab3:3806 with SMTP id
 i63-20020a255442000000b00ba88ab33806mr2419407ybb.13.1685030056585; Thu, 25
 May 2023 08:54:16 -0700 (PDT)
Date:   Thu, 25 May 2023 08:54:15 -0700
In-Reply-To: <ZG807ECX4TeBcE61@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230509134825.1523-1-yan.y.zhao@intel.com> <20230509135006.1604-1-yan.y.zhao@intel.com>
 <ZFsr9TynkA/CyPgg@chao-email> <ZFtQeLNuXP6tDMne@yzhao56-desk.sh.intel.com>
 <ZG1DhSdhpTkxrfCq@google.com> <ZG10zi6YtqGeik7u@yzhao56-desk.sh.intel.com>
 <ZG4kMKXKnQuQOTa7@google.com> <ZG807ECX4TeBcE61@yzhao56-desk.sh.intel.com>
Message-ID: <ZG+Epwp75nJ7tpXM@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: add a new mmu zap helper to indicate
 memtype changes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com
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

On Thu, May 25, 2023, Yan Zhao wrote:
> On Wed, May 24, 2023 at 07:50:24AM -0700, Sean Christopherson wrote:
> > bool __kvm_mmu_honors_guest_mtrrs(struct kvm *kvm, bool vm_has_noncoherent_dma);
> > 
> > static inline bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm)
> > {
> > 	
> > 	return __kvm_mmu_honors_guest_mtrrs(kvm, kvm_arch_has_noncoherent_dma(kvm));
> > }
> 
> This should work and it centralizes the comments into one place, though I dislike
> having to pass true as vm_has_noncoherent_dma in case of 1->0 transition. :)

Yeah, I don't love it either, but the whole 1=>0 transition is awkward.  FWIW,
KVM doesn't strictly need to zap in that case since the guest isn't relying on
WB for functionality, i.e. we could just skip it.

> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 41d7bb51a297..ad0c43d7f532 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -13146,13 +13146,19 @@ EXPORT_SYMBOL_GPL(kvm_arch_has_assigned_device);
> > > 
> > >  void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
> > >  {
> > > -       atomic_inc(&kvm->arch.noncoherent_dma_count);
> > > +       if (atomic_inc_return(&kvm->arch.noncoherent_dma_count) == 1) {
> > > +               if (kvm_mmu_cap_honors_guest_mtrrs(kvm))
> > > +                       kvm_zap_gfn_range(kvm, 0, ~0ULL);
> > 
> > No need for multiple if statements.  Though rather than have identical code in
> > both the start/end paths, how about this?  That provides a single location for a
> > comment.  Or maybe first/last instead of start/end?
> > 
> > static void kvm_noncoherent_dma_start_or_end(struct kvm *kvm)
> What does start_or_end or first_or_last stand for? 

Start/End of device (un)assignment, or First/Last device (un)assigned.  Definitely
feel free to pick a better name.
