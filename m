Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC76B52E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCJVaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCJVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:30:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB03EB6B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:29:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n17-20020a056a000d5100b005e5e662a4ccso3443701pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678483778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NRguOP2zNz+rcqAlWCi8GtUfH0GjcY6QWbkvWJbEk=;
        b=q9w0i9uQa/+sRPvL5iX8dShJc2phPtRT84HXt0uFfamTY/kJcvK69SPzfpS1nzU0+T
         zAKEg8gFVdyvQe5K9eoS7PIaqxzqaBGmql2RH1bJqycseRJPY9KvnuxT4Tr91QLDqdqq
         r1VBjubPAXfBWj1o6v+m9f4ZPn2Q2amjI9FEWCHQsr8/cdOWHEkl4GXXDhfNfeNRWnAy
         JOp0CUe5Hx23Mjg5co8QP5563HxvWfEJ3un0QzGZqhj/3BnfOqwKi8GL4LUOrWle7/EF
         VWshNW5Urkz6Ca9va28LsA+4xptSXu1ICKRe0QTmpiMTghv/51D3xSaN33XhGcesjeXH
         Tmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NRguOP2zNz+rcqAlWCi8GtUfH0GjcY6QWbkvWJbEk=;
        b=5I5L4BiNo5ggE5xWE6pKh1r8lwUz9HATd9EJ0qSQNxGKwsnB40uIvtPyMRyX+5BDbw
         ErJbEMo5Lk371iXDDj3dRQ7/unIpRz16NIh17ZnwZe2AWRPDEjweNl2w+cCvRmYqZGSB
         sgSY1bQJUE2gSiSrlvayQn10mJmJbzTDtSO7tBRetAFwqya+An3QL526GSK8ZJvcGLfG
         4ibWVkiGVsm0FhKa8HyL0YlR409dInNF17WFcKUItsIeOz/Z042ta28XewzJl1ymJkdJ
         C7FKi3tHIZ8zpXJwbYXEwQ6+Q+jkebuNIugu5KsC70dMjXrrvOeoeOwX9wewTmZp8QY/
         ZOog==
X-Gm-Message-State: AO0yUKWPw4X4+uAh1LZKSNfVfHPPjKuL+8FXm45TUrxx8OIfU+f0mVCl
        AOS7bK1hlFwak76TwOGBk2IThRm+enw=
X-Google-Smtp-Source: AK7set9ZO92lLsOGzTCMxGnzucv0gdqM7MkOUO01WC33Ufz8FTZEZigzsrX1kGl1K+T/3GV5NzM/LPHiQ9g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:893:b0:237:7edd:2e08 with SMTP id
 bj19-20020a17090b089300b002377edd2e08mr9977285pjb.0.1678483778185; Fri, 10
 Mar 2023 13:29:38 -0800 (PST)
Date:   Fri, 10 Mar 2023 21:29:36 +0000
In-Reply-To: <20230310161354.1889b539@gandalf.local.home>
Mime-Version: 1.0
References: <cover.1678474914.git.jpoimboe@kernel.org> <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
 <ZAucD8gHx8Xp8Dlb@google.com> <20230310161354.1889b539@gandalf.local.home>
Message-ID: <ZAuhQNS8mjRt1bOG@google.com>
Subject: Re: [RFC][PATCH 5/5] x86/kvm: Simplify static call handling
From:   Sean Christopherson <seanjc@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, Mar 10, 2023, Steven Rostedt wrote:
> On Fri, 10 Mar 2023 13:07:27 -0800
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > "KVM: x86:" please, "x86/kvm" is for guest-side changes.
> > 
> > On Fri, Mar 10, 2023, Josh Poimboeuf wrote:
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 1dfba499d3e5..612531e1c478 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -1789,8 +1789,6 @@ extern struct kvm_x86_ops kvm_x86_ops;
> > >  
> > >  #define KVM_X86_OP(func) \
> > >  	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
> > > -#define KVM_X86_OP_OPTIONAL KVM_X86_OP
> > > -#define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
> > >  #include <asm/kvm-x86-ops.h>
> > >  
> > >  int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
> > > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > index 6accb46295a3..5f7f860c5f17 100644
> > > --- a/arch/x86/kvm/pmu.c
> > > +++ b/arch/x86/kvm/pmu.c
> > > @@ -77,20 +77,15 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
> > >  #define KVM_X86_PMU_OP(func)					     \
> > >  	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,			     \
> > >  				*(((struct kvm_pmu_ops *)0)->func));
> > > -#define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
> > >  #include <asm/kvm-x86-pmu-ops.h>
> > >  
> > >  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
> > >  {
> > >  	memcpy(&kvm_pmu_ops, pmu_ops, sizeof(kvm_pmu_ops));
> > >  
> > > -#define __KVM_X86_PMU_OP(func) \
> > > -	static_call_update(kvm_x86_pmu_##func, kvm_pmu_ops.func);
> > >  #define KVM_X86_PMU_OP(func) \
> > > -	WARN_ON(!kvm_pmu_ops.func); __KVM_X86_PMU_OP(func)  
> > 
> > I would much prefer to keep KVM mostly as-is, specifically so that we don't lose
> > this WARN_ON() that guards against a vendor module neglecting to implement a
> > mandatory callback.  This effectively gives KVM "full" protection against consuming
> > an unexpectedly-NULL function pointer.
> 
> As in my reply to patch 0/5, I suggested that static_call_update(NULL)
> would trigger a WARN_ON() always. Then this could be cleaned up and still
> get that warning.

I don't think that provides the functionality KVM wants/needs.  KVM only disallows
NULL updates for select mandatory hooks.  For optional hooks, KVM needs to support
NULL updates in some capacity to handle the scenario where a vendor module is
reloaded with different settings, e.g. loading kvm_intel with enable_apicv=0 after
running with enable_apicv=1.

WARN_ON() a static_call_update(..., NULL) should be ok, but I believe KVM would
still need/want macro shenanigans, e.g.

#define __KVM_X86_OP(func) \
	static_call_update(kvm_x86_##func,
			   kvm_x86_ops.func ? kvm_x86_ops.func : STATIC_CALL_NOP);
#define KVM_X86_OP(func) \
	WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
#define KVM_X86_OP_OPTIONAL __KVM_X86_OP
#define KVM_X86_OP_OPTIONAL_RET0(func) __KVM_X86_OP
