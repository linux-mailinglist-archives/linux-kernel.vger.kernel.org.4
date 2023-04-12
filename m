Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C496DF949
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDLPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjDLPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:03:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EA10FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:03:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f3e30726cso81077847b3.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681311829; x=1683903829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUVO/gMkeg1xl6zulvJnKfNsSX2e3aUthW4gcYUVCxQ=;
        b=f2VFv1bB/NHqYVxx4uFacoq5Jont4xGMhShIOILUXgXdyFYyCmwvxV08tP0JJdKCRe
         8GWexONOq1HviY4T6HRjE6bCO/pYgSPnIgHosrOFp6Q69PHuHLZ3rK7QouDvaaNp7SM7
         4sBEG0qNRnZRFgWiGbZ054rWQajKk1Hub9Mw4YMCIFVr4l5byCDPSt9Hq2fi/TQaFdXe
         BlDcQJkjoGMRHlMIRj3vooMXzCcyBgHTDL9bSotUKyvXse3ZnyDTJ63evORRtPYgzBEK
         UMqk3jyFXbKVdArbXP+25PWU3Gc4zVm983q1omqPZ2WsJ22XmpLbWLYR/XYzZ6qZS7/y
         s/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311829; x=1683903829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUVO/gMkeg1xl6zulvJnKfNsSX2e3aUthW4gcYUVCxQ=;
        b=Ua5D5TOfILuOYhsR2kGOdgzgkgm7GmWERcpnZqoqBsM469dFbL6Ziy5nDyyfJ42tdd
         2RARqBh0NBs8rikp/bG3GjQFrmAjYD8jOm4WlktMCUQ7AzZFroTXXKScQio9JC2O/kcI
         a+mDQxaAppDr4qaA4x9SgewatIQydQS4eTPA4ZmkMp/AoGsOvIA9KgxPAgCwtvOincYy
         1os014M5rhH8zsG+xA0jDsT9r1q/Obhj+8F0QRHaTioUX8N0Fg//jARp3049DlBdP6Ru
         ENgVrZIwUinAImZAqxovlt+jzKIImLgWxRaD9t0rb3agieP3M8MVTbDq2uXw5H0tb0Ct
         uUlw==
X-Gm-Message-State: AAQBX9dm7j4Yafe8Gil7w6gYV0lL+n2Z4F5RRKpJhklclo9sNoYAtneD
        L90ALAZaO8KB8ov3KTa3GQPHKNmgKdA=
X-Google-Smtp-Source: AKy350ZXDsTulRvANqBgPIrnaV9DDopRPXXXEk8Q3SnM/nYjBBq+XV0KRJrFDkk2HK/NAzkNlasMMNTJEgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b85:b0:54f:6aa5:7c4f with SMTP id
 ck5-20020a05690c0b8500b0054f6aa57c4fmr2445720ywb.3.1681311828836; Wed, 12 Apr
 2023 08:03:48 -0700 (PDT)
Date:   Wed, 12 Apr 2023 08:03:47 -0700
In-Reply-To: <f8beddb6-5139-07e7-c880-6767b1e9ba40@intel.com>
Mime-Version: 1.0
References: <20230410125017.1305238-1-xiaoyao.li@intel.com>
 <20230410125017.1305238-2-xiaoyao.li@intel.com> <ZDRDKsPGP9JI2MHA@google.com> <f8beddb6-5139-07e7-c880-6767b1e9ba40@intel.com>
Message-ID: <ZDbIU7uTmj7pCD47@google.com>
Subject: Re: [PATCH 1/2] KVM: VMX: Use kvm_read_cr4() to get cr4 value
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Apr 12, 2023, Xiaoyao Li wrote:
> On 4/11/2023 1:11 AM, Sean Christopherson wrote:
> > On Mon, Apr 10, 2023, Xiaoyao Li wrote:
> > > Directly use vcpu->arch.cr4 is not recommended since it gets stale value
> > > if the cr4 is not available.
> > > 
> > > Use kvm_read_cr4() instead to ensure correct value.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/vmx.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index d7bf14abdba1..befa2486836b 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -3431,7 +3431,7 @@ static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
> > >   void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
> > >   {
> > > -	unsigned long old_cr4 = vcpu->arch.cr4;
> > > +	unsigned long old_cr4 = kvm_read_cr4(vcpu);
> > 
> > Ha!  I've been tempted to change this multiple times, but always thought I was
> > just being a bit obsessive :-)
> > 
> > Patches look good, but I'm going to hold them for 6.5 just in case this somehow
> > causes a problem, e.g. if there's a bizzaro nested path that "works" because KVM
> > _doesn't_ decache info from the current VMCS.
> 
> so you will put it in kvm-next after 6.4 merge windows?

The likely candidate is "kvm-x86 vmx", and I probably won't apply the patches until
after v6.4-rc2 (rc2 being my preferred base for the next cycle).  But yes, the plan
is to apply the patches after the 6.4 merge window.

Are you asking because you want to know if you need to resend for 6.5?  Or does
the timing/location matter for some other reason, e.g. a dependency from another
patch/series?
