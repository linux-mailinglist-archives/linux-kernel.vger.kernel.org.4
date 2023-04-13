Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F156E136D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:24:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCA083EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:24:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8b46f399so67128867b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681406661; x=1683998661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P68aUjnSl/2TMcJV3ExmCjoczPTpBFoVydSlTQqjeqQ=;
        b=WMsfvwTht9FwMICDLMY9jE7jT4HQfI8yqVs9NpDWq5On+a+0vjn9zOSB/If4bGVrsk
         EBUmRCup6/sTLkoVk19iB6PLeB7QtZCxC6jTtFX8WlRUJ7HpZPtdtMcARA2KoFha4SGJ
         SVtzJWfHLPNlEAwYsYZqpuB6hJZ4jzsU376kyCnB0lsyRt4rX/MGsjgCH2Z3kp59/O5k
         owBbg3jEfGmzSjFYtel6nvO5TMZeT4BXWfL5BNMO/AxpEEUz9OFrOE7JD+mMwt2KQ+k0
         WQnO/A21QXRja6VfjYxYnNKunZUuwdHfR803s3hpvtecHAj/WGy32xnMWqmbTHiFiLGi
         3aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406661; x=1683998661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P68aUjnSl/2TMcJV3ExmCjoczPTpBFoVydSlTQqjeqQ=;
        b=cLISK0UbepaD9Ky9mXh+3n3tPeP5RtP2HpzBSi1FIxQj8PhNoXA2sJInJT/NAuXtjV
         GvtFfJ41GEI0Q+nIApuLzZ+RjuwTWP7SDusp3zX2f8SFX7xusiowQpF0rTmNM+lL1BVG
         2CXzY3U9/YqpirCHnhsHIyA8VuMxzs9B3YX++xM6Q8Q5RjQFyLR2QGmW+XBVblK/B5hq
         bhuGzISOj++Ee7DpUzG1Cn+JUU+QFIeJjOGEGf6y8hvJ4VIvDWaOO5JssZgVI8UKMCRm
         /nA7pHXbLSi3NwH+qOeo/4QCyEKsG9uVXOIiaACoNd0mINoVSsbzG2qRo3FQslGOqe1y
         pCBw==
X-Gm-Message-State: AAQBX9c3SP7lCTq4+UXyCZbRT+YLR5zkMHdL6u5n7ojmfr1L5z3MqoRh
        psiYh69bgbYUFK4LM7dWTs0cdjWTc7o=
X-Google-Smtp-Source: AKy350ZqCLy51A73efjWsfbY09LkrgU4kYNu8DdHRLcga09DyT0GFQezl7PuJ2s/gDJPXPRcI0ZkuV9fnys=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b649:0:b0:54f:646d:19bf with SMTP id
 h9-20020a81b649000000b0054f646d19bfmr1968057ywk.1.1681406661451; Thu, 13 Apr
 2023 10:24:21 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:24:19 -0700
In-Reply-To: <61d131da-7239-6aae-753f-2eb4f1b84c24@linux.microsoft.com>
Mime-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com>
 <ZAd2MRNLw1JAXmOf@google.com> <959c5bce-beb5-b463-7158-33fc4a4f910c@linux.microsoft.com>
 <ZDSa9Bbqvh0btgQo@google.com> <ecd3d8de-859b-e5dd-c3bf-ea9c3c0aac60@linux.microsoft.com>
 <ZDWEgXM/UILjPGiG@google.com> <61d131da-7239-6aae-753f-2eb4f1b84c24@linux.microsoft.com>
Message-ID: <ZDg6w+1v4e/uRDfF@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
From:   Sean Christopherson <seanjc@google.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023, Jeremi Piotrowski wrote:
> On 4/11/2023 6:02 PM, Sean Christopherson wrote:
> > By default, yes.  I double checked that L2 has similar boot times for KVM-on-KVM
> > with and without the TDP MMU.  Certainly nothing remotely close to 2 minutes.
> 
> Something I just noticed by tracing hv_track_root_tdp is that the VM appears to go through
> some ~10000 unique roots in the period before kernel init starts (so grub + kernel decompression).
> That part seems to take a long time. Is this kind of churn of roots by design?
> 
> The ftrace output for when the root changes looks something like this, kvm goes through smm emulation
> during the exit.
> 
>  qemu-system-x86-18971   [015] d.... 95922.997039: kvm_exit: vcpu 0 reason EXCEPTION_NMI rip 0xfd0bd info1 0x0000000000000000 info2 0x0000000000000413 intr_info 0x80000306 error_code 0x00000000
>  qemu-system-x86-18971   [015] ..... 95922.997052: p_hv_track_root_tdp_0: (hv_track_root_tdp+0x0/0x70 [kvm]) si=0x18b082000
>  qemu-system-x86-18971   [015] d.... 95922.997133: kvm_entry: vcpu 0, rip 0xf7d6b
> 
> There are also root changes after IO_INSTRUCTION exits. When I look at non-tdp-mmu it seems to cycle between two
> roots in that phase time, and tdp-mmu allocates new ones instead.

#$&*#$*& SMM.  I know _exactly_ what's going on.

When KVM emulates something that invalidates _all_ TLB entries, e.g. SMI and RSM,
KVM unloads all of the vCPUs roots (KVM keeps a small per-vCPU cache of previous
roots).  Unloading roots is a simple way to ensure KVM flushes and synchronizes
all roots for the vCPU, as KVM flushes and syncs when allocating a "new" root
(from the vCPU's perspective).

In the shadow MMU, KVM keeps track of all shadow pages, roots included, in a per-VM
hash table.  Unloading a "shadow" root just wipes it from the per-vCPU cache; the
root is still tracked in the per-VM hash table.  When KVM loads a "new" root for the
vCPU, KVM will find the old, unloaded root in the per-VM hash table.

But unloading roots is anathema for the TDP MMU.  Unlike the shadow MMU, the TDP MMU
doesn't track _inactive_ roots in a per-VM structure, where "active" in this case
means a root is either in-use or cached as a previous root by at least one vCPU.
When a TDP MMU root becomes inactive, i.e. the last vCPU reference to the root is
put, KVM immediately frees the root (asterisk on "immediately" as the actual freeing
may be done by a worker, but for all intents and purposes the root is gone).

The TDP MMU behavior is especially problematic for 1-vCPU setups, as unloading all
roots effectively frees all roots.  Wwhereas in a multi-vCPU setup, a different vCPU
usually holds a reference to an unloaded root and thus keeps the root alive, allowing
the vCPU to reuse its old root after unloading (with a flush+sync).

What's happening in your case is that legacy BIOS does some truly evil crud with
SMM, and can transition to/from SMM thousands of time during boot.  On *every*
transition, KVM unloads its roots, i.e. KVM has to teardown, reallocate, and rebuild
a new root every time the vCPU enters SMM, and every time the vCPU exits SMM.

This exact problem was reported by the grsecurity folks when the guest toggles CR0.WP.
We duct taped a solution together for CR0.WP[1], and now finally have a more complete
fix lined up for 6.4[2], but the underlying flaw of the TDP MMU not preserving inactive
roots still exists.

Aha!  Idea.  There are _at most_ 4 possible roots the TDP MMU can encounter.
4-level non-SMM, 4-level SMM, 5-level non-SMM, and 5-level SMM.  I.e. not keeping
inactive roots on a per-VM basis is just monumentally stupid.  Ugh, and that's not
even the worst of our stupidity.  The truly awful side of all this is that we
spent an absurd amount of time getting kvm_tdp_mmu_put_root() to play nice with
putting the last reference to a valid root while holding mmu_lock for read.

Give me a few hours to whip together and test a patch, I think I see a way to fix
this without a massive amount of churn, and with fairly simple rules for how things
work.

[1] https://lkml.kernel.org/r/20220209170020.1775368-1-pbonzini%40redhat.com
[2] https://lore.kernel.org/all/20230322013731.102955-1-minipli@grsecurity.net
