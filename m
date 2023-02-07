Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945F68DEEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBGRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjBGRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:30:11 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B57EC2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:30:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o187so19424703ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XM1oyJ1Xk37+9GYr1vds8MZHsHc1FKZ95GJ9oGmtxWY=;
        b=K0Zr8VVi+jFwfkvJYPKANRIg222mVBuPgaxu7uKvSq8HB2OboSpFdlIYeryEgNRArV
         P4fMq58foV8cI5QLItzuzSCYyVi6V071+POv73rVUbxMvvGQ2PZozP+gqxW++KChWNI6
         dUQ1TuF2CGIaWZqvNUWBLmKRQS4dI+xfnuDUYOfdEK0w8/lTYnooxNoVZC8bwUi++MEi
         4nzry92VK00zLyX7H+S1c6pE0KEer0fK0qNLw8vI1wCCU4CAyi9CXayV5kW495T807Yp
         Li/L8xF5I3zfIBVweQenCnTLGsmI9M3fwZ2+AfYkjZpDonRVdsYFxUG0RtvjM00K1ndZ
         3mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XM1oyJ1Xk37+9GYr1vds8MZHsHc1FKZ95GJ9oGmtxWY=;
        b=xNaQZ3zF9O7pB31cfI5HHOoyvm4tFSurhxZOsZYbNbE1+8EsBjC9mquaUdrPaphV2m
         5QaJsHLhTLvqhIOZp7d7jCHB+1p8uQxIh3RAZ0wnBzE4kFwIh8BaQFdVyGCeR7QuPZsc
         8UTJpz3l6jTlvaEMZWpV0lkO+GmZTnZVjcE5NZmJ1uA/Tv62gZTA/ko6B155Elot3fA/
         nSYxBi8lj47Vs7KUp9CB3mIOTrnkDykvgUVgIDgtKygWSZLsemNxlDNqfG9vQyKcPDse
         U6fzK9S27VGESAfRPavYpNGNHR/MvMD1XMzwzsyxkyr5aDZdL1gxhNkD0rL1sVwYikJz
         QW6w==
X-Gm-Message-State: AO0yUKXauM2Ej6Z/Ek5MpEat45k8cD1b6WOVuX0dFDXqDXwTm4AVe9Zz
        /gkZD9mKwl5Kl9NCosn1fyXKdVFmr973BQYMxbSvdw==
X-Google-Smtp-Source: AK7set+JikWPdGnJpFMxsCIKsCvblzLW2aRR7/MpG1e5FuSwv+T+/YcUHYSBHITiZBzt0bYpV5RsmXkQfj0J7RO5xsU=
X-Received: by 2002:a25:e907:0:b0:801:33b9:d9ac with SMTP id
 n7-20020a25e907000000b0080133b9d9acmr286026ybd.2.1675791009330; Tue, 07 Feb
 2023 09:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-3-vipinsh@google.com>
 <CANgfPd8en316O=iTijS5jseM8_eCYm822iwT2d-7Q+jhJBy+HQ@mail.gmail.com>
In-Reply-To: <CANgfPd8en316O=iTijS5jseM8_eCYm822iwT2d-7Q+jhJBy+HQ@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 09:29:33 -0800
Message-ID: <CAHVum0d8i=pyiT57a4UHuk33Z5UdKxxx3ApPAqFGxR-Mp3sn7Q@mail.gmail.com>
Subject: Re: [Patch v2 2/5] KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
To:     Ben Gardon <bgardon@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 6, 2023 at 2:06 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Fri, Feb 3, 2023 at 11:28 AM Vipin Sharma <vipinsh@google.com> wrote:
> > diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> > index 30a52e5e68de..21046b34f94e 100644
> > --- a/arch/x86/kvm/mmu/tdp_iter.h
> > +++ b/arch/x86/kvm/mmu/tdp_iter.h
> > @@ -121,4 +121,17 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
> >  void tdp_iter_next(struct tdp_iter *iter);
> >  void tdp_iter_restart(struct tdp_iter *iter);
> >
> > +static inline u64 kvm_tdp_mmu_clear_spte_bit(struct tdp_iter *iter, u64 mask)
> > +{
> > +       atomic64_t *sptep;
> > +
> > +       if (kvm_tdp_mmu_spte_has_volatile_bits(iter->old_spte, iter->level)) {
> > +               sptep = (atomic64_t *)rcu_dereference(iter->sptep);
> > +               return (u64)atomic64_fetch_and(~mask, sptep);
> > +       }
> > +
> > +       __kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte & ~mask);
> > +       return iter->old_spte;
> > +}
> > +
>
> If you do end up sending another version of the series and feel like
> breaking up this patch, you could probably split this part out since
> the change to how we set the SPTE and how we handle that change are
> somewhat independent. I like the switch to atomic64_fetch_and though.
> No idea if it's faster, but I would believe it could be.

David explained in his email why it is not independent.

>
> Totally optional, but there's currently no validation on the mask.
> Maybe we're only calling this in one place, but it might be worth
> clarifying the limits (if any) on what bits can be set in the mask. I
> don't think there necessarily need to be limits as of this commit, but
> the handling around this function where it's called here would
> obviously not be sufficient if the mask were -1UL or something.
>

I cannot think of any specific mask to be useful here. Let us keep it
as it is, we can revisit this API if there is a need to add a mask in
future. If someone sends -1UL then it will be on them on how they are
using the API.
