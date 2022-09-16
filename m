Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FBD5BB1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIPRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:48:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840DC9F8EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:47:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ge9so10237709pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QeuYamDYnD5m6TH4g/LNmXO9ta0c1WTylvYdfTPhYgI=;
        b=tFBhaF47yyJ13jIQPOKC8f9ISlg70H4BRvxVo5K/HlXpB5mUgy6P2O1Nj6DOvGtuOS
         ypGCdP703M+zRFaQ5ejtCBF7TiO8GUWplzZRDw8kAjRZFSX8nQXfiaHNHd4jFJcKXCVu
         uekb442kjq6FFUxnrIb683RecGs3MDZv88mezEjZhYmVeVURBI4tctydJpfUazTwv4ET
         7ILABWLFPG56AUh1BSwZglOYrwfjraBAp0Gnszvj3xdsITaH7AoTvd6a5QLj6MtXr6Et
         nOL1+d67QF5XZVG74R0+AEbqNw2yEBcqmGjHYjuAxlQds84+8T0y6ALM1+C5XVPIRBA5
         kL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QeuYamDYnD5m6TH4g/LNmXO9ta0c1WTylvYdfTPhYgI=;
        b=usyyN3EcBRlw7jEPXb6CYbyEEphX4Fh5HiiZOPHKoOFkw+EwXcy/Y0JNoXCnJrlenb
         PSgdf9v1xkXWNvRygLXkzTsLee9A4wFWSRBhxanbX7hi7w/asj0aJMoW09NCnzKoB2i+
         8f+Rqsk4iNyD2K4Fdh6GvcS7sUCMuF/WQsAi0MPPuGqd52MqATbfyfxg0IIe8MYF8APi
         5vMxQs8zJr3SRPhWp86BRlbU8HWInbpc9QNTP4JQ9hqNFb+lDAaH9NmMKgnRaBZ4L5+w
         Yj6OQ1PD+jVUB8SI1EqXhbzmRMUbEqYuxxPmMRTYJLFB9XStMbOb/vwwjctRi5ukJuNN
         tCuA==
X-Gm-Message-State: ACrzQf1hA+C7eTM1krvIhi6ItGBFdBeSFKp9/8Pa8w0gyxwnrBMJJJiA
        W2/7X852AtQq+hF6PbDdnozWF32CCEMOqw==
X-Google-Smtp-Source: AMsMyM51WIC7HrsXbizobMo/xE001myS1egr1Iv5FnVeKoLcLESyICbSVyzZzQVWukz5E93A8QBK+Q==
X-Received: by 2002:a17:902:ccc9:b0:174:de2b:b19a with SMTP id z9-20020a170902ccc900b00174de2bb19amr972872ple.100.1663350478964;
        Fri, 16 Sep 2022 10:47:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 75-20020a62174e000000b0054223a0185asm13398742pfx.161.2022.09.16.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:47:58 -0700 (PDT)
Date:   Fri, 16 Sep 2022 17:47:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 04/23] KVM: x86: Inhibit AVIC SPTEs if any vCPU
 enables x2APIC
Message-ID: <YyS2ymYa+yojnYGp@google.com>
References: <20220903002254.2411750-1-seanjc@google.com>
 <20220903002254.2411750-5-seanjc@google.com>
 <b6fcb487-56fc-12ea-6f67-b14b0b156ee0@amd.com>
 <YyGFGXsbgr6WV0B8@google.com>
 <951f2be3-9830-ad71-0140-e5bbf4b78f96@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951f2be3-9830-ad71-0140-e5bbf4b78f96@amd.com>
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

On Wed, Sep 14, 2022, Suthikulpanit, Suravee wrote:
> Sean
> 
> On 9/14/2022 2:39 AM, Sean Christopherson wrote:
> > > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > > index 38e9b8e5278c..d956cd37908e 100644
> > > > --- a/arch/x86/kvm/lapic.c
> > > > +++ b/arch/x86/kvm/lapic.c
> > > > @@ -2394,8 +2394,10 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
> > > >    		}
> > > >    	}
> > > > -	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE))
> > > > +	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE)) {
> > > >    		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
> > > > +		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_X2APIC);
> > > > +	}
> > > .... Here, since we do not want to inhibit APICV/AVIC on system that can
> > > support x2AVIC, this should be set in the vendor-specific call-back
> > > function, where appropriate checks can be made.
> > No, again the intent is to inhibit only the MMIO page.  The x2APIC inhibit is
> > ignored when determining whether or not APICv is inhibited, but is included when
> > checking if the memslot is inhibited.
> > 
> > bool kvm_apicv_memslot_activated(struct kvm *kvm)
> > {
> > 	return (READ_ONCE(kvm->arch.apicv_inhibit_reasons) == 0);
> > }
> > 
> > static unsigned long kvm_apicv_get_inhibit_reasons(struct kvm *kvm)
> > {
> > 	/*
> > 	 * x2APIC only needs to "inhibit" the MMIO region, all other aspects of
> > 	 * APICv can continue to be utilized.
> > 	 */
> > 	return READ_ONCE(kvm->arch.apicv_inhibit_reasons) & ~APICV_INHIBIT_REASON_X2APIC;
> 
> Also, this should be:
> 
> return READ_ONCE(kvm->arch.apicv_inhibit_reasons) & ~(1UL <<
> APICV_INHIBIT_REASON_X2APIC);

Ugh, I found and fixed this locally when testing, but lost the change when shuffling
code between systems.

Thanks!
