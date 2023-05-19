Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F9709B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjESPkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:40:51 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1B19F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:40:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53425d37fefso2030941a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684510850; x=1687102850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnWC4mQ/WMnZdD3b8JUdPNh8r1zjJNTS2dZ7JBLK+Wc=;
        b=jQL1RgzePRb6CE0wG/sVkfkt4rd8Wt2jrN77gaN9Htf9eQKNrA7qB2VPAxmi6pdSeg
         Su5u8NcwmRuwZx7bH1F9TmDvrwv+LISAqTOzpx5Qf8pRfXQxw0YiAhK1QcYrFztzcGmD
         wyJ+ZfzmhgFX33tO0WQdnj/AY9WDFrn/92ljHE9AX9bENwh/95skpiuqJV9wVOXhVs1i
         sb0fKjBpw5LA2Ck792zWmzLpLTaDjOtrm/fq7AYmIZO5ZRrt1AM3o4fW1Ir/9pKh9v7e
         5ejgJVZ6w07KYeFXkx4s1L32hmXMjmVFijle+uT7TuvSundmfzLB+7cCUo5p5yQUJA3f
         59LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510850; x=1687102850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnWC4mQ/WMnZdD3b8JUdPNh8r1zjJNTS2dZ7JBLK+Wc=;
        b=kss/R8+FOYevEVkRSueUAnS4hkNJ329dStz7csxyRR8X9u47bfwAkDx1FzDajMK9xV
         dVwvGAQIMVz/r/0Oe59lAl0gP9EAMfbmiKJwzsex2ywWd5RjsZTzIxZaCeVBL6iwlCf1
         7MU3SVDEfhys3u4xJbB0krqX1DMQ9p4jFzK/d+Y+lmaOIBXrh0mzYzYM7ywrlxiuCG6F
         yuA9Ngn/flXp2ZgdaeQ4A8bS768oB3j3wpsIP4o209nVkcvnCrA/aIkuy+NmP1KX59yA
         lFzaktK1OdZRFk3n53cqXmntkI/HgeHPEEKKSXJ+k+Da7p5JKK7hXDZrZ1tqW9vUXHua
         6C+Q==
X-Gm-Message-State: AC+VfDzNPcWT3henExQQ2VZfUXNMEKxtKSIwrGGNJvQINJ4v0+GxgMRT
        n4vJ7SIvlXP6ddU2OHsOtLc/V32inH0=
X-Google-Smtp-Source: ACHHUZ7VuSIVLy+nWtnXiTAGMOugz5axqsHZhuYhiKJAa7IHVutOk8mzE7pcpv8HAXmFLe9XB/ks3dGHHoY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:fa50:0:b0:530:70cb:6da9 with SMTP id
 g16-20020a63fa50000000b0053070cb6da9mr534975pgk.10.1684510850201; Fri, 19 May
 2023 08:40:50 -0700 (PDT)
Date:   Fri, 19 May 2023 08:40:48 -0700
In-Reply-To: <ZAn34D3hXR7dp8KC@kernel.org>
Mime-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
 <ZAn34D3hXR7dp8KC@kernel.org>
Message-ID: <ZGeYgKCFOkzP2fub@google.com>
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

On Thu, Mar 09, 2023, Mike Rapoport wrote:
> On Thu, Mar 09, 2023 at 01:59:00AM +0000, Edgecombe, Rick P wrote:
> > On Wed, 2023-03-08 at 11:41 +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > 
> > > Hi,
> > > 
> > > This is a third attempt to make page allocator aware of the direct
> > > map
> > > layout and allow grouping of the pages that must be unmapped from
> > > the direct map.
> > > 
> > > This a new implementation of __GFP_UNMAPPED, kinda a follow up for
> > > this set:
> > > 
> > > https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org
> > > 
> > > but instead of using a migrate type to cache the unmapped pages, the
> > > current implementation adds a dedicated cache to serve __GFP_UNMAPPED
> > > allocations.
> > 
> > It seems a downside to having a page allocator outside of _the_ page
> > allocator is you don't get all of the features that are baked in there.
> > For example does secretmem care about numa? I guess in this
> > implementation there is just one big cache for all nodes.
> > 
> > Probably most users would want __GFP_ZERO. Would secretmem care about
> > __GFP_ACCOUNT?
> 
> The intention was that the pages in cache are always zeroed, so __GFP_ZERO
> is always implicitly there, at least should have been.

Would it be possible to drop that assumption/requirement, i.e. allow allocation of
__GFP_UNMAPPED without __GFP_ZERO?  At a glance, __GFP_UNMAPPED looks like it would
be a great fit for backing guest memory, in particular for confidential VMs.  And
for some flavors of CoCo, i.e. TDX, the trusted intermediary is responsible for
zeroing/initializing guest memory as the untrusted host (kernel/KVM) doesn't have
access to the guest's encryption key.  In other words, zeroing in the kernel would
be unnecessary work.
