Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B886DFECB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDLThy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDLThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:37:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A2268B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:37:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u11-20020a17090341cb00b001a22d27406bso6002510ple.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681328269; x=1683920269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGPFGa6a5AyBKhKxp6OsNW9GYoSIZ4PdLtwW24G9FKo=;
        b=MiYEWqDhRnABU3naI6gHGiNu4DYRKpHa8WFmvFxco7fq+UveqF9VTOD3pMUQoJhtY9
         gBS+kqy6r9ZUqV3QawGdB8Z1/JwvugouPseU4SF9+JWAAIs91Y7iV1/TGGkdM+NAm/zD
         x6CYFn0/ENR3xGwdsUiZU/VMYKxjOgk94myuDcWagH1E6zefkuKyPF+iEKis/pjAly5O
         AL7LGiPhVMF4ulprtosfJ3xVqJc8dNZ55xB7vO1s3cJIeF0MWx5pCoeLbtbQa1wd7l6V
         SwWym1Kd3wvEmChDkp/w07zOkZOFJxOLI7uU1BecWorn+0CmoK3YZKsHBifMW3/y1Ldb
         zdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328269; x=1683920269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGPFGa6a5AyBKhKxp6OsNW9GYoSIZ4PdLtwW24G9FKo=;
        b=k7+KVANSvWA3vkjzmbGDYs+Ol2MPm+O1AkuDrI+A434svSgGDeVaOpVxeyNlz3VwnE
         gnvKXPgHIV0pl3MQEe4v41XvMRtCSGvQtGNlaw+9eFUtiqadqTC2u4i/s8xsHWieEnc2
         +ZZkfn8bqpXJ74tWEF3ftinA3uslJFe0FFTlTZmk/iwqcnK4DqEN4oemc9Gvgjb58Vli
         Nm5PCEgXRou1MEcc7PdkkP/jh/Jkmyiw9/Gk1OWKR6mUhZOXuCONNup1XgShJcQlcHV5
         oQ9m45MgFsF/Ga2meZQXDhYcHk8DrHLGAjFIjdieyQ8lM7ZmAFiy4cXsT8MI7m+/WWIW
         iQDQ==
X-Gm-Message-State: AAQBX9ebNdawIXXQT3WoVQr11fObDkXUsQT7CiSp9y8N7nT/a3GQNK0/
        M2Gxjrba2nkHrAcQRPBge2/KXvQj4Cg=
X-Google-Smtp-Source: AKy350ZeYSUnY3rkhOuQXtXKS+M/PQ1H/WWYcUufEfimNOsKQ0XLXzLQ/pdHOg6715P0xJONOorpoo0jx74=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:211d:0:b0:519:ad33:fa96 with SMTP id
 h29-20020a63211d000000b00519ad33fa96mr2166203pgh.12.1681328269200; Wed, 12
 Apr 2023 12:37:49 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:37:48 -0700
In-Reply-To: <SA1PR11MB6734897C0BC0FC7481333E29A89B9@SA1PR11MB6734.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230410081438.1750-1-xin3.li@intel.com> <20230410081438.1750-34-xin3.li@intel.com>
 <ZDSEjhGV9D90J6Bx@google.com> <SA1PR11MB6734897C0BC0FC7481333E29A89B9@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZDcIjF/QnCZNkXJ8@google.com>
Subject: Re: [PATCH v8 33/33] KVM: x86/vmx: refactor VMX_DO_EVENT_IRQOFF to
 generate FRED stack frames
From:   Sean Christopherson <seanjc@google.com>
To:     Xin3 Li <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        Shan Kang <shan.kang@intel.com>
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

On Wed, Apr 12, 2023, Xin3 Li wrote:
> 
> > And then this is equally gross.  Rather than funnel FRED+legacy into a single
> > function only to split them back out, just route FRED into its own asm subroutine.
> > The common bits are basically the creation/destruction of the stack frame and
> > the CALL itself, i.e. the truly interesting bits are what's different.
> 
> I try to catch up with you but am still confused.
> 
> Because a FRED stack frame always contains an error code pushed after RIP,
> the FRED entry code doesn't push any error code.
> 
> Thus I introduced a trampoline code, which is called to have the return
> instruction address pushed first. Then the trampoline code pushes an error
> code (0 for both IRQ and NMI) and jumps to fred_entrypoint_kernel() for NMI
> handling or calls external_interrupt() for IRQ handling.
> 
> The return RIP is used to return from fred_entrypoint_kernel(), but not
> external_interrupt().

...

> > +	/*
> > +	* A FRED stack frame has extra 16 bytes of information pushed at the
> > +	* regular stack top compared to an IDT stack frame.
> > +	*/
> > +	push $0         /* Reserved by FRED, must be 0 */
> > +	push $0         /* FRED event data, 0 for NMI and external interrupts */
> > +	shl $32, %rax
> > +	orq $__KERNEL_DS | $FRED_64_BIT_MODE, %ax
> > +	push %rax	/* Vector (from the "caller") and DS */
> > +
> > +	push %rbp
> > +	pushf
> > +	push \cs_val
> 
> We need to push the RIP of the next instruction here. Or are you suggesting
> we don't need to care about it because it may not be used to return from the
> callee?

...

> > +	push $0 /* FRED error code, 0 for NMI and external interrupts */
> > +	PUSH_REGS
> > +
> > +	/* Load @pt_regs */
> > +	movq    %rsp, %_ASM_ARG1
> > +
> > +	call \call_target

The CALL here would push RIP, I missed/forgot the detail that the error code needs
to be pushed _after_ RIP, not before.

Unless CET complains, there's no need for a trampoline, just LEA+PUSH the return
RIP, PUSH the error code, and JMP to the handler.  IMO, that isn't any weirder than
a trampoline, and it's a bit more obviously weird, e.g. the LEA+PUSH can have a nice
big comment.
