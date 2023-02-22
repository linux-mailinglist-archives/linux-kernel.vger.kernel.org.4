Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1069F924
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBVQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjBVQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:39:05 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D12A9A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:39:03 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e9-20020a170902ed8900b0019ca3beda2dso1840773plj.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXgaJI/j9VqE32P3+P9vI0Zcemav11hNqQd2XHiyolg=;
        b=jRJGnK4E2fY4GvsbcKBwGR7YXRVirER4oHtjA5fJF3UGZ9q6FZyFyIPiIHaFN2MHfT
         6zjzuKOn2BOdPV0Ur4SqicZgIZ+ea7STJrTUIH8CB3FmYaVoEZUZa8Ead/Zg44msUt3R
         Kg6cESWjAcu7ZUjHj9Ua/meVz9donOfSRbDqPWoZp2rHmOfmiTAmovV+STTertImDidB
         G9zxBCv2SDYFkQlRHHFG8FiaSo+6c85J8FWSKnHhR3yh+yOjvCfLz6J25qWcQsqT06uj
         bbqP8vYCehEkiVS2Fzk8Wl1oWs3WJPOIbgt7WuzNtIG6BYx+nfBFdLDG3Ec32nqEtYCP
         vFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXgaJI/j9VqE32P3+P9vI0Zcemav11hNqQd2XHiyolg=;
        b=kl2TJqcmAgcy/GKDBoTyF7mAv5biJZwMKkl85BMUb7sqxA8gzY+ZdpJFyAqC4d1oHa
         4hQy9pu0foxsMF5du5fpAjDA+7wsJ+qM6Tkjdu4WRL9lo92pXoV3OLjweUSZpTmFogHU
         QVtqdhoKKkALWjOk9wWYZ0+pTyWIKFNzzidJD+nbh/sF2BVzUAhHSj17aI2YiJ+G/ja1
         J3AQNAoiksqnpY4zMYR2d4bKYiGJMZmGdTTMXOFIMl6STdzJz7rAjlz2lgCoP8FjqSB7
         j1W8AQA8a2jcZo0c02LGosnTqMZc865LJsJjteOAmRm+0a0k0NVhI/Ulit1w2+4owgLd
         oyBw==
X-Gm-Message-State: AO0yUKXXNUhf6RXG5CSght/jwemxsShnxTb+Bq00/shhI5WQ2IvI3DxG
        VfZRcG+mOELS4YC49LaefbiaJUddPQ8=
X-Google-Smtp-Source: AK7set/e12i1snm1HK5N9SmoYRSKeJsIAJ000V9OqW6XjpY/L6IYgApozXDHfy8kanx3CGdwtgGVtdF/zvo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3750:0:b0:4fb:be1a:2074 with SMTP id
 g16-20020a633750000000b004fbbe1a2074mr1159464pgn.12.1677083942861; Wed, 22
 Feb 2023 08:39:02 -0800 (PST)
Date:   Wed, 22 Feb 2023 08:39:01 -0800
In-Reply-To: <20230222064931.ppz6berhfr4edewf@linux.intel.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com> <20230217231022.816138-9-seanjc@google.com>
 <20230221152349.ulcjtbnvziair7ff@linux.intel.com> <20230221153306.qubx7tfmasnvodeu@linux.intel.com>
 <Y/VYN3n/lHePiDxM@google.com> <20230222064931.ppz6berhfr4edewf@linux.intel.com>
Message-ID: <Y/ZFJfspU6L2RmQS@google.com>
Subject: Re: [PATCH 08/12] KVM: nSVM: Use KVM-governed feature framework to
 track "vVM{SAVE,LOAD} enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Maxim

On Wed, Feb 22, 2023, Yu Zhang wrote:
> On Tue, Feb 21, 2023 at 03:48:07PM -0800, Sean Christopherson wrote:
> > On Tue, Feb 21, 2023, Yu Zhang wrote:
> > > > Sorry, why guest_cpuid_is_intel(vcpu)? Is it becasue that a AMD host with virtual
> > > > VMSAVE/VMLOAD capability will always expose this feature for all AMD guests? 
> > > 
> > > Oh, sorry. I missed the guest_cpuid_has() in kvm_governed_feature_check_and_set().
> > > So please just ignore my 2nd question.
> > > 
> > > As to the check of guest_cpuid_is_intel(), is it necessary?
> > 
> > Yes?  The comment in init_vmcb_after_set_cpuid() says:
> > 
> > 		/*
> > 		 * We must intercept SYSENTER_EIP and SYSENTER_ESP
> > 		 * accesses because the processor only stores 32 bits.
> > 		 * For the same reason we cannot use virtual VMLOAD/VMSAVE.
> > 		 */
> > 
> > but I'm struggling to connect the dots to SYSENTER.  I suspect the comment is
> > misleading and has nothing to do 32-bit vs. 64-bit (or I'm reading it wrong) and
> > should be something like:
> > 
> > 	/*
> > 	 * Disable virtual VMLOAD/VMSAVE and intercept VMLOAD/VMSAVE if the
> > 	 * guest CPU is Intel in order to inject #UD.
> > 	 */
> > 
> > In other words, a non-SVM guest shouldn't be allowed to execute VMLOAD/VMSAVE.
> 
> Yes. Such interpretation makes sense. And vmload/vmsave shall be intercepted
> if guest CPU is Intel and #UD shall be injected. I guess this is done indirectly
> by judging the EFER_SVME not set in EFER in nested_svm_check_permissions()?

Nope, my interpretation is wrong.  vmload_vmsave_interception() clears the upper
bits of SYSENTER_{EIP,ESP}

	if (vmload) {
		svm_copy_vmloadsave_state(svm->vmcb, vmcb12);
		svm->sysenter_eip_hi = 0;
		svm->sysenter_esp_hi = 0;
	} else {
		svm_copy_vmloadsave_state(vmcb12, svm->vmcb);
	}

From commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"):
    
    3. Disable vmload/vmsave virtualization if vendor=GenuineIntel.
       (It is somewhat insane to set vendor=GenuineIntel and still enable
       SVM for the guest but well whatever).
       Then zero the high 32 bit parts when kvm intercepts and emulates vmload.

Presumably AMD hardware loads only the lower 32 bits, which would leave garbage
in the upper bits and even leak state from L1 to L2 (again ignoring the fact that
exposing SVM to an Intel vCPU is bonkers).

I'll opportunistically massage the comment to make it more explicit about why
VMLOAD needs to be intercepted.
 
That said, clearing the bits for this seems wrong.  That would corrupt the MSRs
for 64-bit Intel guests.  The "target" of the fix was 32-bit L2s, i.e. I doubt
anything would notice.

    This patch fixes nested migration of 32 bit nested guests, that was
    broken because incorrect cached values of SYSENTER msrs were stored in
    the migration stream if L1 changed these msrs with
    vmload prior to L2 entry.

Maxim, would anything actually break if KVM let L1 load 64-bit values for the
SYSENTER MSRs?

> And as to X86_FEATURE_V_VMSAVE_VMLOAD, should the guest_cpuid_has() return true
> at all for a Intel guest?

Yes, because guest CPUID is userspace controlled.  Except for emulating architectural
side effects, e.g. size of XSAVE area, KVM doesn't sanitize guest CPUID.
