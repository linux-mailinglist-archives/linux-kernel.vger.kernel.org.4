Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328A6DE3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDKSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDKSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:34:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D73AA8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:34:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m13-20020a170902db0d00b001a63c5ce31cso3670666plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681238065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzz/ozeVQf3oB9itOCR96Jt1Pb9+gGlg3JnJBxGTvCU=;
        b=htQmsm+G+2DBSM9XNrsalnLTlXwDcK7h7GaDNvRSzfmVJjKXjQiX2VRl3BLfjgqXbX
         BWz+Ex8uNSEffJ74b3HznJFOeJTpR4ZK61KMffBDxIUCYQHOpL0whynyINz7HFUu0ZpK
         uKMKrPqr0Dx6iY8VAYmQGH8fB5GoMUnjZ4224jdgCC/DVcJz0yaGNvUTyoYPK2RBP0nj
         Ja7PVYVNAIyKLPmDODylK2vjQiVU7tjZqkpS5Ovr/DJqIbDKXaiaXrVmAYH5g7xxQork
         9DHLhZYxPnaowDRFqcQ5J200Kb1dUVu3gLWPaYBEVMLUxuT+cNALoWyb6cHkMvQY9V2t
         eqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzz/ozeVQf3oB9itOCR96Jt1Pb9+gGlg3JnJBxGTvCU=;
        b=POkNz1QgeCQlVSSAN/W8eG4eTAlOepfcCPqL7Hc728+dAgQQUEW/9v8G5e3ipMsSVW
         0A4V2pkvEz5V5Q9ihlcs1IkQ4aUr1vhIcz01/uHR4iKkeiOyVRb3NIIpYguHSepl4Gu+
         SCO78GwPrSP1TBubK4KMUG+eNrPiN0vU6xJwByRQIFXEiJT8r5R3N+cRu9EGEpbjgR0h
         WjjDwhvV1DmgEVSRAEfqGZdvcPUDXcZ7aM6K1+W35nDzIJ5I+nQgsEIVRNEjsPohsHGd
         aJckghpdPS12lolPRSmKxwVULF4piye395BN32LJNcmPbHF3whC5lb+JiBfTe7YcqQBb
         sZqg==
X-Gm-Message-State: AAQBX9cVofGSIUVj2xrplNk1e9UoaK1uop2/DCRsahZFSqrGmU4eb2jo
        Z9napW77tmgCyjRtyM8c+38QxQJFvO0=
X-Google-Smtp-Source: AKy350bj7pd4sTy1uWs4sNsFnydS4MYjjhSE/GiNhA79fVNMQwPku6hINNGzdXsHMhyCB6X7gU/Nes/BKmY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:c104:0:b0:507:46cb:f45b with SMTP id
 w4-20020a63c104000000b0050746cbf45bmr50715pgf.1.1681238065535; Tue, 11 Apr
 2023 11:34:25 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:34:23 -0700
In-Reply-To: <SA1PR11MB673493A64E2BEAFA1A18ADE6A89A9@SA1PR11MB6734.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230410081438.1750-1-xin3.li@intel.com> <20230410081438.1750-34-xin3.li@intel.com>
 <ZDSEjhGV9D90J6Bx@google.com> <SA1PR11MB673493A64E2BEAFA1A18ADE6A89A9@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZDWoL6o5LYgWP14y@google.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023, Xin3 Li wrote:
> > 
> >  	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
> > -	vmx_do_interrupt_irqoff(gate_offset(desc));
> > +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> > +		vmx_do_fred_interrupt_irqoff(vector);
> > +	else
> > +		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base
> 
> 
> external_interrupt() is always available on x86_64, even when CONFIG_X86_FRED
> is not defined. I prefer to always call external_interrupt() on x86_64 for IRQ
> handling, which avoids re-entering noinstr code. how do you think? Too
> aggressive?

I think it's completely orthogonal to FRED enabling.  If you or anyone else wants
to convert the non-FRED handling to external_interrupt(), then do so after FRED
lands, or at the very least in a separate patch after enabling FRED in KVM.
