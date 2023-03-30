Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6A6D0D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjC3SPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3SPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:15:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAE6FF0B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:14:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5461fe3163eso65287527b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680200068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB5ZTsVoNxPMz0dHGvSZ4A3cFaTAioWOHMdoCN30OYY=;
        b=KpDWfc/Hbz8OMNADqY1RJe0dO5zNuBuQ0r3lHKdMBR0TbI1YApd6LezV8xZGJmb5NN
         HfueNZi4VloslgJEwinrKlUSrzfpfLjFsr7V++NGXwNXQgHw0K/LT3TCNKQBlLz/W8s3
         Rl24/dWc2u45kUD++uBuT62XUEjJD3X4iyOTanZlLITyEpsIj/SCnQ9s6ZWl7pNEqTmt
         ynG7NjFAgiaKAm583WgcUAF1h+lQ877bmjxnu85YbiPl0P5tR3HXEuYiABBfSi9knE8C
         eVYYjKwa00zg18pfLOw/Z64ugViCkHIf4G/NAWzJ/hRJ7RiDoa9aCM2RUdso7t3yi1ou
         zhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB5ZTsVoNxPMz0dHGvSZ4A3cFaTAioWOHMdoCN30OYY=;
        b=Cry+BAgDvGR1dbOIU9J2JvtuuRmrMFHxg+ySeMW2V+8XuzoSH4b8ZULfWSEcJsGDQQ
         92mULztQqcuu9kTkdrA+PzApaTymbX1qkNw9WgnbFjupRHoVcQ/4VoAW+HGXlAthd+p4
         VRrXV8yosfwPSap9PYYOtn9Jf8J0JSJIrcvIyZg3pC2bxgJuZlM9sWjE0/iY1zFwhOMk
         IBJRn0q923D7xzjPNuSP1TlPB8VartNljQz0/7a0VUAkY+OXsOfaGh7fTLtKfZ5u9JJ6
         44SNjGVXy3Ggccf9yYvJOHFR93OyurvH7hb9wjh1DaxmjbAVZfKyPGE6B/4+kDDJ7GAW
         dyXg==
X-Gm-Message-State: AAQBX9dspZJMX4y4tfnoYEJ3bCyEvZMuKmGPhXHzQk0hcZ4thWL0Va42
        rehCAKspdXYNWfQuLVgTzEzeJ/h0VZg=
X-Google-Smtp-Source: AKy350ba2CdUiadt7xCrcYmhzy8YIqjQ8WTC/tVnWPIeDm4lmQkqoUHznnxmf7TpGJV1Z9P6FYLEsxciCY0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:de0d:0:b0:541:a0ab:bd28 with SMTP id
 k13-20020a81de0d000000b00541a0abbd28mr3912009ywj.4.1680200068380; Thu, 30 Mar
 2023 11:14:28 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:14:27 -0700
In-Reply-To: <ZCVcvuddkEFKW/0p@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230313111022.13793-1-yan.y.zhao@intel.com> <ZB4uoe9WBzhG9ddU@google.com>
 <ZCOaHWE6aS0vjvya@yzhao56-desk.sh.intel.com> <75ae80f7-b86e-3380-b3da-0e2201df4b7f@redhat.com>
 <ZCVcvuddkEFKW/0p@yzhao56-desk.sh.intel.com>
Message-ID: <ZCXRgw5+5A7aluNc@google.com>
Subject: Re: [PATCH v3] KVM: VMX: fix lockdep warning on posted intr wakeup
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, Yan Zhao wrote:
> On Wed, Mar 29, 2023 at 01:51:23PM +0200, Paolo Bonzini wrote:
> > On 3/29/23 03:53, Yan Zhao wrote:
> > > Yes, there's no actual deadlock currently.
> > > 
> > > But without fixing this issue, debug_locks will be set to false along
> > > with below messages printed. Then lockdep will be turned off and any
> > > other lock detections like lockdep_assert_held()... will not print
> > > warning even when it's obviously violated.
> > 
> > Can you use lockdep subclasses, giving 0 to the sched_in path and 1 to the
> > sched_out path?
> 
> Yes, thanks for the suggestion!
> This can avoid this warning of "possible circular locking dependency".
> 
> I tried it like this:
> - in sched_out path:
>   raw_spin_lock_nested(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu), 1);
> 
> - in irq and sched_in paths:
>   raw_spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> 
> But I have a concern:
> If sched_in path removes vcpu A from wakeup list of its previous pcpu A,
> and at the mean time, sched_out path adds vcpu B to the wakeup list of
> pcpu A, the sched_in and sched_out paths should race for the same
> subclass of lock.
> But if sched_in path only holds subclass 0, and sched_out path holds
> subclass 1, then lockdep would not warn of "possible circular locking
> dependency" if someone made a change as below in sched_in path.
> 
> if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
>             raw_spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
>             list_del(&vmx->pi_wakeup_list);
> +            raw_spin_lock(&current->pi_lock);
> +            raw_spin_unlock(&current->pi_lock);
>             raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
> }
> 
> While with v3 of this patch (sched_in path holds both out_lock and in_lock),
> lockdep is still able to warn about this issue.

Couldn't we just add a manual assertion?  That'd also be a good location for a
comment to document all of this, and to clarify that current->pi_lock is a
completely different lock that has nothing to do with posted interrupts.

It's not foolproof, but any patches that substantially touch this code need a
ton of scrutiny as the scheduling interactions are gnarly, i.e. IMO a deadlock
bug sneaking in is highly unlikely.

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 94c38bea60e7..19325a10e42f 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -90,6 +90,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
         */
        if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
                raw_spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
+               lockdep_assert_not_held(&current->pi_lock);
                list_del(&vmx->pi_wakeup_list);
                raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
        }
