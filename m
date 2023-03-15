Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019626BBD32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjCOTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjCOTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:23:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296776F486
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:23:22 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q68-20020a632a47000000b004f74bc0c71fso4752122pgq.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678908201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CO8t+zxtFwLc3yJ6bJQPj8GStgQChto9AhidRXWbvKE=;
        b=AFfpyBBgddR4r+3JtnHbvcqmXuTkhpDMyp586u8nVhbO1w8OEZcY5uo/OF9V598ZLI
         4rHyH46ovKyA7lnhJHFG6xBBVxETLjL+X9IjtJQHUydXqo4ZUQ7Y5WwNClIPQ1Eh5lQZ
         zA5Knux19o9U5vhp9sOPU9amPjsWqVXPs766BYzKn+IlghB7VhRAkzLGqDz4B65bhhoA
         YNqCkknXtoi31iyHYeoVPj0mO+0gmInMgO4IEC2gwezvk4+y57uPy1bVDX0g88G2Wp9I
         7MVEgckhtqsD0i2BAz6dAWMWBZXBSPIf8Br/5Y4kjpfV2xKcxN6RAqv5yqcr4S5tRhFQ
         fCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CO8t+zxtFwLc3yJ6bJQPj8GStgQChto9AhidRXWbvKE=;
        b=GQN0tsJWEF1mSZ64jm0MUISFXc1eUr5NrXDcZCahrAZdOsIRK6BSqidW5dbjBJA2T3
         rSAErfJpOR2R2alrEscAYOiK4JePAsVbvqXDok2DKGaPrBC8ytyxl1LgzOruMHxV6nUR
         IlnbFqZ8xEnT1IEbw7eEHiy9AW7yO6wtXRSoq9O02WZ7KaYtfS3cra2cesrUrePz0q/E
         CEy3gnifXF+c4OZbxzuE/jJKIWAwXQmwNVRWeDtracNWMk2EUbMjAT12HwkbFRyh+7bk
         0EsUoKxxc3YN8M7DosUTCjXfoz7k4kulzX6/G8ooBu9Vem/jDZPMsKncbNIZntN+Aqi6
         cydQ==
X-Gm-Message-State: AO0yUKUtanw9G7wpm82vyq3gnY8xNbGo6dav5BvSRiQ09oGqSPjSfePn
        GE9pBN5VYvVz2oh+zDqMlojFtwO/rxg=
X-Google-Smtp-Source: AK7set/JY+rzlbShnVBele6OwSOSpHpEbwghpOgoGyd4CaLNRbbg6Pm7bxlVeohGsEhXPHXSQ02jqVfN9X8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f547:b0:19f:2164:9b3b with SMTP id
 h7-20020a170902f54700b0019f21649b3bmr261241plf.13.1678908201457; Wed, 15 Mar
 2023 12:23:21 -0700 (PDT)
Date:   Wed, 15 Mar 2023 12:23:20 -0700
In-Reply-To: <871f7c8b-0f54-7e9c-4253-b3878b010bbf@intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-2-seanjc@google.com>
 <DS0PR11MB63733BCF5AEBBF5F38FD2C01DCB99@DS0PR11MB6373.namprd11.prod.outlook.com>
 <871f7c8b-0f54-7e9c-4253-b3878b010bbf@intel.com>
Message-ID: <ZBIQ1vxLs10UFi3R@google.com>
Subject: Re: [Intel-gfx] [PATCH v2 01/27] drm/i915/gvt: Verify pfn is "valid"
 before dereferencing "struct page"
From:   Sean Christopherson <seanjc@google.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>
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

On Wed, Mar 15, 2023, Andrzej Hajda wrote:
> On 13.03.2023 16:37, Wang, Wei W wrote:
> > On Saturday, March 11, 2023 8:23 AM, Sean Christopherson wrote:
> > > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> > > index 4ec85308379a..58b9b316ae46 100644
> > > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > > @@ -1183,6 +1183,10 @@ static int is_2MB_gtt_possible(struct intel_vgpu
> > > *vgpu,
> > >   	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
> > >   	if (is_error_noslot_pfn(pfn))
> > >   		return -EINVAL;
> > > +
> > > +	if (!pfn_valid(pfn))
> > > +		return -EINVAL;
> > > +
> > 
> > Merge the two errors in one "if" to have less LOC?
> > i.e.
> > if (is_error_noslot_pfn(pfn) || !pfn_valid(pfn))
> >      return -EINVAL;
> 
> you can just replace "if (is_error_noslot_pfn(pfn))" with "if
> (!pfn_valid(pfn))", it covers both cases.

Technically, yes, but the two checks are for very different things.  Practically
speaking, there can never be false negatives without KVM breaking horribly as
overlap between struct page pfns and KVM's error/noslot would prevent mapping
legal memory into a KVM guest.  But I'd rather not hide the "did KVM find a valid
mapping" in the "is this pfn backed by struct page" check, especially since this
code goes away entirely by the end of the series.
