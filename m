Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5576EEC24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjDZByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbjDZByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:54:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A596D319
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:54:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1a6ee59714aso41573165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682474047; x=1685066047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuo9lsV/w25nTsJMZpgNSE51tcTodcboYXn0Ddla4Mo=;
        b=KRCNuJUNQ38TuCEtJ9LT1EcD695yXHdoNi22XwJbsTMwf5xEFwpIvLSvBGr1ec/ki9
         Oou13yWeG6Vnh1OwJdxyFiDARD3h7d4PdOcL6lEXT20J/8GbIOdy3C6BMnBEKuKzAw6b
         tr74DCn1t6UEUGAkjWBtmeTW1eKTW+Klz4PH3ISPlO6m/9uSzJSm3GUcIyISNp51mvNO
         mLE1A4tj6koLbcmstmyJhM/258jA0jkRx9PDNi69SQEKJXipstfPxvCA9Y+wGHvsKg3O
         XJgZ9/ZAxyCsNGMPUUk+JLF9i6JLrIs71sSXBemqIKij8fAoJhgfV0iDv2KqKQgYsGwv
         e0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682474047; x=1685066047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuo9lsV/w25nTsJMZpgNSE51tcTodcboYXn0Ddla4Mo=;
        b=mBSkv8CqjmhDnTfEPq1Tm9ikgXCJfBVMKgBfzP3Igu/48PK0PjWD5JkI13+u/RX0kI
         iMAprlm+ZL1blMtLBUN22MwRrjxSHJLHstHJT5AjXqxEE89byFyVgNN0u3ADKxPxSfIK
         fP5eJAUqFgP/YxVqxF0Hl+gJzDNSuTTT7MQcRiPWrPC+6OimmPGVtl70DsOHVVqVhYKd
         ps6yk+HEzQLbQHyfmDwGqBs6bGSlpAC2isNujnspz6YdVxYV4ZbkMytXi89+F6SwYstB
         cq+FrIxBkiBN6/HSP6M8AlerM0t4cEOgMaV1LPG4wOnlx04SIwqe6WPO+Pc/DxLFdHBq
         vpyA==
X-Gm-Message-State: AAQBX9e/L6K78MmcNRF6I4l3/mlj/sdYkpBvJ6D5Ah/lE1c1M127B5aO
        sYe3mQPVkpFhXGz2roQV6yb2lqfAzfc=
X-Google-Smtp-Source: AKy350Zuzv2Xoz9yT0aJ67ZZIZ6TP6n3E503nfZ3vbBJSkZe9vXaMvyAPPRQl7lZ8S9b3tUyWnqBVxE7QZo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32cd:b0:1a9:41df:16ba with SMTP id
 i13-20020a17090332cd00b001a941df16bamr5132129plr.7.1682474047518; Tue, 25 Apr
 2023 18:54:07 -0700 (PDT)
Date:   Tue, 25 Apr 2023 18:54:05 -0700
In-Reply-To: <ZEhN0D1zZyRDeyYz@google.com>
Mime-Version: 1.0
References: <20230421214946.2571580-1-seanjc@google.com> <CALzav=f=TFoqpR5tPDPOujoO6Gix-+zL-sZyyZK27qJvGPP9dg@mail.gmail.com>
 <ZEM+09p7QBJR7DoI@google.com> <CALzav=cOB5rdwutrAa3eqFzHbdR-Dct0BAJWbExf1cTjUq2Mjw@mail.gmail.com>
 <ZEcglWoeGS3pc5kK@google.com> <ZEhN0D1zZyRDeyYz@google.com>
Message-ID: <ZEiEPVR7d+fwQ75y@google.com>
Subject: Re: [PATCH v2] KVM: x86: Preserve TDP MMU roots until they are
 explicitly invalidated
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023, David Matlack wrote:
> On Mon, Apr 24, 2023 at 05:36:37PM -0700, Sean Christopherson wrote:
> > On Mon, Apr 24, 2023, David Matlack wrote:
> > > It'd be nice to keep around the lockdep assertion though for the other (and
> > > future) callers. The cleanest options I can think of are:
> > > 
> > > 1. Pass in a bool "vm_teardown" kvm_tdp_mmu_invalidate_all_roots() and
> > > use that to gate the lockdep assertion.
> > > 2. Take the mmu_lock for read in kvm_mmu_uninit_tdp_mmu() and pass
> > > down bool shared to kvm_tdp_mmu_invalidate_all_roots().
> > > 
> > > Both would satisfy your concern of not blocking teardown on the async
> > > worker and my concern of keeping the lockdep check. I think I prefer
> > > (1) since, as you point out, taking the mmu_lock at all is
> > > unnecessary.
> > 
> > Hmm, another option:
> > 
> >  3. Refactor the code so that kvm_arch_init_vm() doesn't call
> >     kvm_tdp_mmu_invalidate_all_roots() when VM creation fails, and then lockdep
> >     can ignore on users_count==0 without hitting the false positive.
> > 
> > I like (2) the least.  Not sure I prefer (1) versus (3).  I dislike passing bools
> > just to ignore lockdep, but reworking code for a "never hit in practice" edge case
> > is arguably worse :-/
> 
> Agree (2) is the worst option. (3) seems potentially brittle (likely to
> trigger a false-positive lockdep warning if the code ever gets
> refactored back).
> 
> How about throwing some underscores at the problem?

LOL, now we're speaking my language.

I think I have a better option though.  The false positives on users_count can be
suppressed by gating the assert on kvm->created_vcpus.  If KVM_CREATE_VM fails then
it's impossible for the VM to have created vCPUs.  I like this option in particular
because it captures why it's safe for the KVM_CREATE_VM error path to run without
mmu_lock (no vCPUs == no roots).

I'll manually test this against the error path tomorrow:

	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
	    refcount_read(&kvm->users_count) && kvm->created_vcpus)
		lockdep_assert_held_write(&kvm->mmu_lock);
