Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0F5FF221
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJNQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:17:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7B1D0D65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:17:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so5168579pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmoTank4ciPVTTOzFggPZZfwZehLALhhGxl6jeia+oY=;
        b=lfAoyqEBqqc1Ch0aSdhfK7SMt7I0b5VlJTO/iZJXDqNT0qLDOtRmqQYN+n5uuubVbE
         dSiBj+4/GntUoJz7qG4GgeF+NDJzslNCfoH3clEpm/TtDzz/7hihrsAIVADm52DL0hNL
         8285eO4B2H0WW3wSz70kpBna3wD2rTmsk9rTsQVpht42S2a6p/XqA1li2CdKXjCco3Hp
         YneCWfB+DsuxZ0ZXs7sS7TMPulcQrCtu2NCpvkwPyIUCRaLK+SBNiGSTp4U5/m+cZXtV
         vIIC4Dq6J3iCt9jnpapdY4JljBjuhzE1jJ/QPjpGEQqP5VoAvhXB5coDle8wYp5SGDSu
         S+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmoTank4ciPVTTOzFggPZZfwZehLALhhGxl6jeia+oY=;
        b=REAQHPtnT+gGXaL2VyOfz/fVzUqRwshrTjpz1QZDCl2T6QGtcUZ2XpbXN70kYNBw4q
         F27UhuMhfSZspOnAf1UDbdfBQ12O/+UvoKDOu1d31orSJfmjEDpDhu97I/cN/tsndEWg
         IzbdkfUIRnDnD01zqCAC7/3zJP7klFL7XATSs9lfENzWm/8XEG3CYjgHjeGJ21ASYbIZ
         aqovJinW1nl60gVKN+ueoh8y/RGQmmKO4UhQhAQk2pnXOkJGOL5qRqMf5SHstpnKQ7DI
         S+hPgj5Tu49n5a7YQuB3J+PWK+jtZottFlg6pgBbA5dV9/FzhDY5Mn7bJgfo7I0AOahy
         fOXw==
X-Gm-Message-State: ACrzQf22aYqMZy4l6z3D0V6ixGr9N7HZnU6Me6/kWe6ZjcIXI2weGOft
        LOflocLdyOC7TWpQ2ruRJ01XWQ==
X-Google-Smtp-Source: AMsMyM6IjJWtye9KgXbQltHSJhKNO/l21mXMYXRKPY70Aa625miIx06KvhJYDoo6WtJxOMUEm2ZfUw==
X-Received: by 2002:a17:90b:1197:b0:20a:97e9:b20d with SMTP id gk23-20020a17090b119700b0020a97e9b20dmr17906803pjb.65.1665764240367;
        Fri, 14 Oct 2022 09:17:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 8-20020a630308000000b0043c80e53c74sm1649213pgd.28.2022.10.14.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:17:19 -0700 (PDT)
Date:   Fri, 14 Oct 2022 16:17:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: x86/pmu: Add PEBS support for SPR and future
 non-hybird models
Message-ID: <Y0mLi5KRnzSiAXPk@google.com>
References: <20220922051929.89484-1-likexu@tencent.com>
 <20220922051929.89484-2-likexu@tencent.com>
 <Y0W/YR6gXhunJYry@google.com>
 <e1003a0c-7388-9dce-3fc2-8a1f9288e23f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1003a0c-7388-9dce-3fc2-8a1f9288e23f@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022, Like Xu wrote:
> On 12/10/2022 3:09 am, Sean Christopherson wrote:
> > > @@ -181,11 +200,11 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
> > >   		 * the accuracy of the PEBS profiling result, because the "event IP"
> > >   		 * in the PEBS record is calibrated on the guest side.
> > >   		 *
> > > -		 * On Icelake everything is fine. Other hardware (GLC+, TNT+) that
> > > +		 * On Icelake everything is fine. Other hardware (TNT+) that
> > >   		 * could possibly care here is unsupported and needs changes.
> > 
> > This part of the comment is still somewhat stale, and for me at least it's not at
> > all helpful.
> 
> SPR has GLC core, and this patch adds this support and removes the
> unsupported statements.

It's stale in the sense that it says "Icelake is fine", which implies that SPR is
NOT fine.

> Not sure how else I may help you.

Write comments that don't require the reader to have in-depth knowledge of the PMU's
magic numbers.  Explain what "unsupported" means.  Explain what changes might need
to be made.  Use search-friendly words, e.g. I assume TNT means Tremont, but Googling
for "Intel TNT" doesn't yield anything useful.

The above comment essentially says "Icelake is good, Tremont is broken", but that
doesn't help the reader understand what this code actually does.

> > >   		attr.precise_ip = 1;
> > > -		if (x86_match_cpu(vmx_icl_pebs_cpu) && pmc->idx == 32)
> > > +		if (need_max_precise(pmc))
> > >   			attr.precise_ip = 3;
> > 
> > What about writing this as:
> > 
> > 		attr.precise_ip = pmc_get_pebs_precision(pmc);
> > 
> > (or whatever name is appropriate for "pebs_precision").
> 
> The comment says, "the difference in the software precision levels of guest and
> host PEBS events will not affect the accuracy of the PEBS profiling result".
> 
> > 
> > Then in the helper, add comments to explaint the magic numbers and the interaction
> > with PDIST and PDIR.  Bonus points if #defines for the the magic numbers can be
> > added somewher
> 
> KVM just uses "precision_ip = 3" to request hw pdit/pdir counters from host perf,
> It only works at 3. For 1 or 2, there is no difference.

What only works at 3?  Are 0..3 architectural PMU values, or are they arbitrary
numbers perf uses?

> > 
> > 				 *  0 - SAMPLE_IP can have arbitrary skid
> > 				 *  1 - SAMPLE_IP must have constant skid
> > 				 *  2 - SAMPLE_IP requested to have 0 skid
> > 				 *  3 - SAMPLE_IP must have 0 skid
> > 
> > static u64 pmc_get_pebs_precision(struct kvm_pmc *pmc)
> > {
> > 	/* Comment that explains why PDIST/PDIR require 0 skid? */
> > 	if ((pmc->idx == 0 && x86_match_cpu(vmx_pebs_pdist_cpu)) ||
> > 	    (pmc->idx == 32 && x86_match_cpu(vmx_pebs_pdir_cpu)))
> > 		return 3;
> > 
> > 	/* Comment about constant skid? */
> > 	return 1;
> > }
> , therefore 0 or constant skid makes no difference.

Then why '1'?  

> > > diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> > > index c5e5dfef69c7..4dc4bbe18821 100644
> > > --- a/arch/x86/kvm/vmx/capabilities.h
> > > +++ b/arch/x86/kvm/vmx/capabilities.h
> > > @@ -398,7 +398,9 @@ static inline bool vmx_pt_mode_is_host_guest(void)
> > >   static inline bool vmx_pebs_supported(void)
> > >   {
> > > -	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
> > > +	return boot_cpu_has(X86_FEATURE_PEBS) &&
> > > +		!boot_cpu_has(X86_FEATURE_HYBRID_CPU) &&
> > 
> > This belongs in a separate patch, and it should be ordered before patch 1 so that
> > there's no window where KVM can see pebs_ept==1 on a hybrid CPU.
> > 
> > Actually, shouldn't everything in this patch land before core enabling?
> 
> Perf core enabling about SPR is already upstreamed.

I'm referring to patch 1, "perf/x86/intel: Expose EPT-friendly PEBS for SPR and
future models".  Before that patch, x86_pmu.pebs_ept will be set only for Icelake,
i.e. PEBS for KVM is effecitively not enabled in the core perf code until patch 1.
KVM should get all its support lined up, and then enable PEBS support for SPR and
beyond in core perf.  E.g. if someone applied only patch 1, they would be able to
use KVM PEBS on any CPU with PEBS v5, even if it were a hybrid CPU.
