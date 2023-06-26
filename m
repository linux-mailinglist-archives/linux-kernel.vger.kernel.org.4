Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFCA73E71F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFZSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFZSAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:00:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32753183
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:59:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5440e98616cso3103410a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687802398; x=1690394398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plGPnNmp3bHXDxY2xXZU/U5CRi6+Be1QmjShS9rwEWQ=;
        b=iunKlzH6ltsbsmTPGl7+XjaUEeYmmWTDy3TT6IP4xrB5aNlrVP9Vp1lZHxpk3o75a7
         qjwxuYV1sN3wCVZquQbLIxkIwdl4KzMBXc0rlXex8Cysclc7bpC8alLc7FQd836rfkLv
         j55f8FZweQGGNnoA0+QHljAApsDLS1U243VvAfkj/qfXEbfGJxAGF2sZhjXtGM3TkPgi
         Anm2DbbCLaxLqFjQrVVD4frgeIaYqLnE02wWHyJevds8dex9iGf7Um6Q3G1Tayxjnm0T
         SnJ8p8u4yl2NRftZHyAuVTpgV+QoxhjroYPHQuIO+pYOWUGTTcgBdbYr1kbvFLsPFcDh
         FC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802398; x=1690394398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plGPnNmp3bHXDxY2xXZU/U5CRi6+Be1QmjShS9rwEWQ=;
        b=lJd5AUG05li+ev9UOBHDG4x5R2L1OGys93t80TaSEZCSSMqSv+MpPByZUh+iO0Phkr
         5nyWn6MfDiyECTIY/xbkBhs9SERXsm9x7/XDKHveehQyWSTz57w+cvb0opEhTNTmICxt
         /Z0Rq3NDVg4XlznQKrKcjATZIS2mH1JYHUJ3WtM62htO9ONWrn2HwUlEAoN7BwwFoFkZ
         8i5tuihIDHuli828nWLbo5yYRpInvIVhmbv8ZgpsEEvyIsTidW0BckjP45xIpfFY3Kk3
         5JNE3/9joWJxDb5tE2xrcl7Qiu2cRcx2M0w92uTmYtvet3J5yavC0kJ4z6DRD1/7cMjK
         A8OA==
X-Gm-Message-State: AC+VfDzCbMLljJOVWPycjlxTzttqsIVjQyX7g6FLfK55Hm1G1Uouxuva
        /ZBfRXUUf9/H0V6lSdAao63eWw==
X-Google-Smtp-Source: ACHHUZ5jbABWq71//Y5hMCCaB8WfgqHnonyf6ZDBe1jLvP1W7eesLQPS1y1c5A7yuH9Av7TBQKQinw==
X-Received: by 2002:a17:90a:203:b0:262:c41e:1fcb with SMTP id c3-20020a17090a020300b00262c41e1fcbmr9873356pjc.14.1687802398488;
        Mon, 26 Jun 2023 10:59:58 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b0025dc5749b4csm3932240pjz.21.2023.06.26.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:59:57 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:59:54 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "bgardon@google.com" <bgardon@google.com>
Subject: Re: [PATCH 6/6] KVM: Documentation: Add the missing tdp_mmu_page
 into kvm_mmu_page
Message-ID: <ZJnSGrskpTjhZ3qV@google.com>
References: <20230618000856.1714902-1-mizhang@google.com>
 <20230618000856.1714902-7-mizhang@google.com>
 <4e2eae9ab23748ea32fe07d39a704d65d50a0973.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2eae9ab23748ea32fe07d39a704d65d50a0973.camel@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, Huang, Kai wrote:
> On Sun, 2023-06-18 at 00:08 +0000, Mingwei Zhang wrote:
> > Add tdp_mmu_page into kvm_mmu_page description. tdp_mmu_page is a field to
> > differentiate shadow pages from TDP MMU and non-TDP MMU. When TDP MMU is
> > enabled, sp->tdp_mmu_page=1 indicates a shadow page for L1, while
> > sp->tdp_mmu_page=0 indicates a shadow page for an L2. When TDP MMU is
> > disabled, sp->tdp_mmu_page is always 0. So update the doc to reflect the
> > information.
> > 
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  Documentation/virt/kvm/x86/mmu.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
> > index 0dbdb7fb8cc6..cbad49c37629 100644
> > --- a/Documentation/virt/kvm/x86/mmu.rst
> > +++ b/Documentation/virt/kvm/x86/mmu.rst
> > @@ -277,6 +277,10 @@ Shadow pages contain the following information:
> >      since the last time the page table was actually used; if emulation
> >      is triggered too frequently on this page, KVM will unmap the page
> >      to avoid emulation in the future.
> > +  tdp_mmu_page:
> > +    Is 1 if the shadow page is a TDP MMU page. When TDP MMU is disabled,
> > +    this field is always 0.
> > +
> > 
> 
> Hmm.. Again I think "TDP MMU is disabled" is a little bit confusing, but maybe
> it's only me having this impression.
> 
> I think you can just delete the second sentence.

It is not confusing but redundant in this case. I will delete it in next
version.
