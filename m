Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8A709F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjESSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:25:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D3E1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:25:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8696637a7so6861071276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684520755; x=1687112755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkvqDfyMOLrjy8YMY1wwRgMIQfqQZGbB8xX3NIFQuJ8=;
        b=EHWVv93HNkwFD6Rzv38Ipc2B9rPBD1UDSNb25aEyGm9tgrL4HAfKR3FhP4mF0gDZ8o
         5akGYCEZHakPY7q+34PKZr+wjUxJKbOWkHSdmCIF9EthXaS0GE1aeTDaAYg74+n8LxZv
         NrNY0cT19gsI9F6xDoZFfVqJL3/PXEZm7iHMz8EEbdrZb3BVlRolZpZs2icBr5OUNum5
         NS6M57Pod3yr/sG/iNpxrle6ypJpM2UH+leYpSYYesmxJnETM/FgFp+u2mEeUpZlkVpR
         gVvuRxOcV30/Oziq9eKB/d6UWnrG6nSzoKyR8Y2BOsFA/g06gQPoCPP9LQW1NpKMIWBr
         bE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684520755; x=1687112755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkvqDfyMOLrjy8YMY1wwRgMIQfqQZGbB8xX3NIFQuJ8=;
        b=MAikf9SOX62Yv3JNURu3oUUEG31NBadlQfQUZ9fcZRpIrI6fl9gv/9kT571ogzz92N
         wxo/O7rnKRQ6E9G0uLa5y0aUtUm3Ij2LyWtDXfaN3ewX4GGa5L36C9aaW430be0XF/GQ
         gyeqUzDs5NK00YVGOaTyiIJpW19LcSUe6B1FyXWNp/RZNX7N4QdIjqaJBJJdS3Vy5Y+i
         vZsWlALmnAokMQvQ1bklQTQ7XrXC0gF4BRG270VzV2YNoAB4Uzu/hDoxPnnra9S22b3C
         bW/ABDpQu9SG3A4nFHs2cDfsp7dj+joQjerdRILN4btVJjnKB2dDPFiJBo/vHvMXFJ2z
         W9wg==
X-Gm-Message-State: AC+VfDyZQ1FVm5Tfjf9BKSD5nIR2xTkZ79CfC1gmcd2/ZzEjql95Jaa3
        AXGTXN7LPBesC/kG5MHeRPeMIhCiWjs=
X-Google-Smtp-Source: ACHHUZ78HIA/K1sflsbUYSUjC6gecUrhcvhYYTntQ6SB2UFg6TeL234xl9KHrlPWo8SNMaksMPK95sULPeI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8402:0:b0:ba8:797c:9bc7 with SMTP id
 u2-20020a258402000000b00ba8797c9bc7mr1655166ybk.11.1684520755427; Fri, 19 May
 2023 11:25:55 -0700 (PDT)
Date:   Fri, 19 May 2023 11:25:53 -0700
In-Reply-To: <20230519162432.GG4967@kernel.org>
Mime-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
 <ZAn34D3hXR7dp8KC@kernel.org> <ZGeYgKCFOkzP2fub@google.com> <20230519162432.GG4967@kernel.org>
Message-ID: <ZGe/Md3FXb1ihXwe@google.com>
Subject: Re: [RFC PATCH 0/5] Prototype for direct map awareness in page allocator
From:   Sean Christopherson <seanjc@google.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, Mike Rapoport wrote:
> On Fri, May 19, 2023 at 08:40:48AM -0700, Sean Christopherson wrote:
> > On Thu, Mar 09, 2023, Mike Rapoport wrote:
> > > On Thu, Mar 09, 2023 at 01:59:00AM +0000, Edgecombe, Rick P wrote:
> > > > On Wed, 2023-03-08 at 11:41 +0200, Mike Rapoport wrote:
> > > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > This is a third attempt to make page allocator aware of the direct
> > > > > map
> > > > > layout and allow grouping of the pages that must be unmapped from
> > > > > the direct map.
> > > > > 
> > > > > This a new implementation of __GFP_UNMAPPED, kinda a follow up for
> > > > > this set:
> > > > > 
> > > > > https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org
> > > > > 
> > > > > but instead of using a migrate type to cache the unmapped pages, the
> > > > > current implementation adds a dedicated cache to serve __GFP_UNMAPPED
> > > > > allocations.
> > > > 
> > > > It seems a downside to having a page allocator outside of _the_ page
> > > > allocator is you don't get all of the features that are baked in there.
> > > > For example does secretmem care about numa? I guess in this
> > > > implementation there is just one big cache for all nodes.
> > > > 
> > > > Probably most users would want __GFP_ZERO. Would secretmem care about
> > > > __GFP_ACCOUNT?
> > > 
> > > The intention was that the pages in cache are always zeroed, so __GFP_ZERO
> > > is always implicitly there, at least should have been.
> > 
> > Would it be possible to drop that assumption/requirement, i.e. allow allocation of
> > __GFP_UNMAPPED without __GFP_ZERO?  At a glance, __GFP_UNMAPPED looks like it would
> > be a great fit for backing guest memory, in particular for confidential VMs.  And
> > for some flavors of CoCo, i.e. TDX, the trusted intermediary is responsible for
> > zeroing/initializing guest memory as the untrusted host (kernel/KVM) doesn't have
> > access to the guest's encryption key.  In other words, zeroing in the kernel would
> > be unnecessary work.
> 
> Making and unmapped allocation without __GFP_ZERO shouldn't be a problem. 
> 
> However, using a gfp flag and hooking up into the free path in page
> allocator have issues and preferably should be avoided.
> 
> Will something like unmapped_alloc() and unmapped_free() work for your
> usecase?

Yep, I'm leaning more and more towards having KVM implement its own ioctl() for
managing this type of memory.  Wiring that up to use dedicated APIs should be no
problem.

Thanks!
