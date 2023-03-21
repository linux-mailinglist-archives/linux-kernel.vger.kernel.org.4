Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33666C3659
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCUP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCUP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:57:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC872E1B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:57:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y32-20020a634960000000b0050fa03fa554so976734pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679414258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TuyGVvWAn55aYhNiXLfxVytcsj8nJb6xC8tKSkb4wQk=;
        b=U/zU5H++KR0gIcnwTxdhnXzHjcEi5S2Oy5auyA6COWM+geGdf7hbBiBI2xbEgGJzFd
         5Wc44M3kv+D+13PpmMBtwE2c0KRA4v6LxFC7d8tmKbblcyB+sFSB2pRKDtSwuN/bavhK
         tCE7ZQBlE9AKsOqG668/OeKioiLpowfs6AxS25M8YkjzomcSQA3KJ9Q9aD/8C4NXYigd
         WrBxnmXQiO4P+vAMd2Bxv6izjbtr3oKVb7ioxEg8wm5SNeGl0KmW7g9J/3SH/H4AcdCz
         B7rm2iCdy47B9ZPiLJPE9dYj6RMukAobg/jJbOtCZgzkKJOEnixSwwcYTIHzUhZucqE4
         N6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679414258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuyGVvWAn55aYhNiXLfxVytcsj8nJb6xC8tKSkb4wQk=;
        b=G9HT6uxD0Y4Pa4/5tEtVgOTDDV58Zwh50xvAzBXRMSLHhRuFm7lbyThZGQdod0TSUR
         dQDicCso9MWW/no9R62bg6o8Cv/iH2WRzHgYgckjSnE6zpDYGyJQ9VSwzqpI0a73VEFE
         uH4dUB8zirQacpUsZM8VxNx9MxM+Z1BEdUDQyGSwyqoa5LCB+H7dma6tBRdnIWpYyr+l
         0cSDrGKDAHWNCvQ35VtiPe8I4fgcep0fR4VMH2hHSocgPHrv3HA506+zNRlnUtTRm5Nu
         xrVxSyqMDn2G2bQb9voTagvt+yvqjLc4yLy/E3+3jg/DfioWQwkqKkwG/gKeCZsX+g4r
         5Czg==
X-Gm-Message-State: AO0yUKWUTvkBYv2qL9m5riHkH2+fSnUgo/qMxGdt7658mJRwkCDVDbQE
        jpK/493uHjX9xALCWBOpV1EiS/LoNPc=
X-Google-Smtp-Source: AK7set+ptGadWzmRjzpcteGPVaH7/ZML7PoMG36ojaji+Q3hAwLbhUQy6qndT9djtwX8nZfExjOV2eg8hbs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:851:b0:628:30d:2d2f with SMTP id
 q17-20020a056a00085100b00628030d2d2fmr181003pfk.5.1679414258343; Tue, 21 Mar
 2023 08:57:38 -0700 (PDT)
Date:   Tue, 21 Mar 2023 08:57:37 -0700
In-Reply-To: <7b428c85-5f20-a077-70b6-f361d2e7ffe7@grsecurity.net>
Mime-Version: 1.0
References: <20230201194604.11135-1-minipli@grsecurity.net>
 <20230201194604.11135-5-minipli@grsecurity.net> <ZBJEGfmv42MA6bKh@google.com> <7b428c85-5f20-a077-70b6-f361d2e7ffe7@grsecurity.net>
Message-ID: <ZBnT8XhO9WuQFFK0@google.com>
Subject: Re: [PATCH v3 4/6] KVM: x86: Make use of kvm_read_cr*_bits() when
 testing bits
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, Mar 20, 2023, Mathias Krause wrote:
> On 15.03.23 23:18, Sean Christopherson wrote:
> > On Wed, Feb 01, 2023, Mathias Krause wrote:
> >> Make use of the kvm_read_cr{0,4}_bits() helper functions when we only
> >> want to know the state of certain bits instead of the whole register.
> >>
> >> This not only makes the intend cleaner, it also avoids a VMREAD in case
> >> the tested bits aren't guest owned.
> >>
> >> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> >> ---
> >>  arch/x86/kvm/pmu.c     | 4 ++--
> >>  arch/x86/kvm/vmx/vmx.c | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >> index d939d3b84e6f..d9922277df67 100644
> >> --- a/arch/x86/kvm/pmu.c
> >> +++ b/arch/x86/kvm/pmu.c
> >> @@ -439,9 +439,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
> >>  	if (!pmc)
> >>  		return 1;
> >>  
> >> -	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
> >> +	if (!(kvm_read_cr4_bits(vcpu, X86_CR4_PCE)) &&
> > 
> > Purely as an FYI, I proposed adding helpers to query single CR0/CR4 bits in a
> > separate thread[*].  No need to do anything on your end, I'll plan on applying
> > this patch first and will handle whatever conflicts arise.
> > 
> > [*] https://lore.kernel.org/all/ZAuRec2NkC3+4jvD@google.com
> 
> Unfortunately, not all users of kvm_read_cr*_bits() only want to read a
> single bit. There are a very few that read bit masks -- but you're
> probably fully aware of this.

Yeah, we won't be able to get rid of kvm_read_cr*_bits() entirely, the goal is
purely to make code that does query a single bit slightly more readable/obvious.
