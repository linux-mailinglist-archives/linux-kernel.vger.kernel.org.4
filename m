Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F562EC79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKRDtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:49:38 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF48F3F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:49:38 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i131so4267633ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CgJUQemp/f+PlGTIq0YX+TmFg52HbYStJmaJzWE+VoY=;
        b=SUp6YqzgYosJg+/9xNr+ggz5uHPqyABf5MdSAdKEofxZMLjOt8dv0Jcuovgcob651q
         CehG6KAzs2YhjA+aySdFOf7G93Ve+A5GupCsUFU/1HrODmB0uDS2+c79Jxbb4qIZdhv3
         /HbU3RnOZSNzwVe5rOZ3REc9NGP81flOV2TZsVNvoAtLEJbVHWLrZspdbPbwBs20ELjV
         IRw9+DZ+TAj3hMy3tYemVZ8p1521IzydCHJLXlKiBypchCNaVWP1zFTv9v4D3qK0/ln7
         8pEoNRP+MKFZMTghx0dTL4sEPo7b+HkChabyinzS8m8JSn2LTvK+PFLwRIeOzjjbWA4H
         gwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgJUQemp/f+PlGTIq0YX+TmFg52HbYStJmaJzWE+VoY=;
        b=bpvdj8zs7cft1g75ru+dJ9wvEGEen9LKEZQtggOsw2+REhyQZqtfFfYjf3rhaZQ5Xx
         lk6TEhicXwby72+CuT7pBlUmqbSggRw02SOz3Mtj2u+stq3ayCnoVwHE3l7F/wOeiWzX
         6i7PGZ7Wmr5SS7fODeCDSHVF5Tklt8BT8LzZfMsZTBRoNQa8A7Q6Kk6nTq9HSgFxIIEd
         q4SWZm4PNRGGLSmdzxMXcBMtHxBQxJP2Kw9IwPlZWD3w/6g2y9nQjaTdkXyTWdehoyzI
         xzwGu/xvBJG7Zd/BQImL5NSdHWulTEYU6EQiu8D5ttx58u1hlxKAo3PabUicw2OMF3UT
         Siow==
X-Gm-Message-State: ANoB5pnOl5D3t7Q37Mrq6AVp5/qXkJ7SBhF18FMHwWr7eosxANLVAqPw
        naG2ap+vnW7WlKqtjzIoA+XQf/5nhpyuhq2BInYbUg==
X-Google-Smtp-Source: AA0mqf6YTz+llOBvFtjHWCaxDT4oMdJda9zlD5qYJemlriRUfYxP+aGAKHadIvtDUdSb4BIPdGE9enBVtoS8udDjN2c=
X-Received: by 2002:a25:ae12:0:b0:6d0:704:f19f with SMTP id
 a18-20020a25ae12000000b006d00704f19fmr5330087ybj.191.1668743377371; Thu, 17
 Nov 2022 19:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20221117161449.114086-1-pbonzini@redhat.com> <CALzav=cxtgaVV2tORqDo93AuUW+5BSLdjsah=YASQdPMwnf2iA@mail.gmail.com>
 <11f5e652ca2c2a4507316c3426b25d0d5cd66120.camel@linux.intel.com>
In-Reply-To: <11f5e652ca2c2a4507316c3426b25d0d5cd66120.camel@linux.intel.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 17 Nov 2022 19:49:11 -0800
Message-ID: <CALzav=eeVJAOwUbg1QRnkWhhzn5WT8jgjWo2b-tu9uBJJKdG8A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: simplify kvm_tdp_mmu_map flow when guest
 has to retry
To:     Robert Hoo <robert.hu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, seanjc@google.com
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

On Thu, Nov 17, 2022 at 6:01 PM Robert Hoo <robert.hu@linux.intel.com> wrote:
>
> On Thu, 2022-11-17 at 10:43 -0800, David Matlack wrote:
> > On Thu, Nov 17, 2022 at 8:14 AM Paolo Bonzini <pbonzini@redhat.com>
> > wrote:
> > >                 if (is_shadow_present_pte(iter.old_spte))
> > > -                       ret = tdp_mmu_split_huge_page(kvm, &iter,
> > > sp, true);
> > > +                       r = tdp_mmu_split_huge_page(kvm, &iter, sp,
> > > true);
> > >                 else
> > > -                       ret = tdp_mmu_link_sp(kvm, &iter, sp,
> > > true);
> > > +                       r = tdp_mmu_link_sp(kvm, &iter, sp, true);
> >
> > Can this fix be squashed into [1]? It seems like a serious enough
> > bug.
> > If 2 threads race to update the same PTE, KVM will return -EBUSY out
> > to userspace from KVM_RUN, I think. I'm not sure about QEMU, but that
> > would be fatal for the VM in Vanadium.
> >
> > [1]
> > https://lore.kernel.org/kvm/20221109185905.486172-3-dmatlack@google.com/
> >
> I think in you patch it's all right, since then before
> kvm_tdp_mmu_map() returns, it must go through
> tdp_mmu_map_handle_target_level(), it returns RET_PF_* enum.

Ah that's right. kvm_tdp_mmu_map() won't actually return 0/-EBUSY,
because it either returns RET_PF_RETRY or goes through
tdp_mmu_map_handle_target_level().
