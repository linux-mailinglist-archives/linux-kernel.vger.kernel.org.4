Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2985678D00
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjAXAvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAXAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:51:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1B2B28C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:51:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EBF785C011A;
        Mon, 23 Jan 2023 19:51:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 19:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674521466; x=1674607866; bh=gH
        m0azAXGT7RjdRK8Bil/fSi4iBJaifuQeA4wZs2MKQ=; b=iXgxsDifC4s8fBzLPf
        Z8FuIxtq1ONjP3fEAKvc1aq/1hrIZKoRZpF/TGyZ7T0NwXEFYQEoAbq5duQqI3F7
        L4rtK/EJaSCKSd42Uj2Kvail7azMArNqQnl3K241rUVpw3I6xrs+JFWw3cktAH4p
        gE0e6f11G29jodVTcidFh10v8fbXRXlt0OkgXPtjPvxhyrI6Gdh59eEJyE1WXqpZ
        UphCt8kFeNFzQEhkOituWyToh/EXYmALhSKb3YsDBdmo0sv6AvHaDC5kHeh03o4J
        f1+IManKturkj6d9n6JPkyqRcVtZQ95zXPXtM5sm4Gz/3t6Mfj/i9asmtnUf2MLh
        OtyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674521466; x=1674607866; bh=gHm0azAXGT7RjdRK8Bil/fSi4iBJ
        aifuQeA4wZs2MKQ=; b=mxWnHgmm/tmnNwrpPu8f+EXOmS00hUrMXTLWn2NpkYG6
        ijelCe7Tl6E0+aIvKuTIip/QLyvx23mh9KDNZBE7rwl6mp7vHWgW5bnqy0HykMKS
        9fQuN05QeT80QukAc/vhxEqLWS2QIh0gdOJkFkr0+52ZA0zChLowAlNHY6vGypcU
        +jGM6z37fInyk8LUNHk9WwZ2upxc9shw+PmxwXn9fgvYpC5KbgcMzcHvtrbRXWwM
        y/uoS3KIygJ7Qfp1BpHORBl4r15+H3n9qeIpxvnG/kYTrg6N1DNN6Kme20csH6Im
        VkbTqUYmac4JgOrpnFEMBp4KcqbgpBU+KyXO42M+XQ==
X-ME-Sender: <xms:eivPYwzerMghZxiE-9utuELjQ1j-gGfBwM37dAnStUfGqF61GGWzDw>
    <xme:eivPY0RvHyRl5kgpxfxX6oFavlGIQHBkpj5OvqAdVkIur_4tiuWUOLMqO62Ar6UHE
    DURFwXxu1w4jL9tQVI>
X-ME-Received: <xmr:eivPYyXQaSGG8uogsrJypdznlz4rp-CwdUuLxqJ99aDryfJJ_7iITzuJ0T87DQfxQVy9kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeiteevtdevueeikefhjeevveffgeekkefhtdeg
    vdehgfetgeehudegjeejjeelhfenucffohhmrghinhepfhhluhhshhdruhhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:eivPY-hJDohwk8N7d4CrCJN71ZmzYrgVVlFkcHc34TIxN8xJA5LJNQ>
    <xmx:eivPYyCsn1Lf_birRjK0dig5tEq6XoVrOgoO6dUuaagQJo3owJT7bg>
    <xmx:eivPY_KlB5GDXsU0eUy5aGW0lGDjkeaZHhKkD2SyXnb4yo0Pbnv_Mg>
    <xmx:eivPY03efRbF2sX8aQBxHwhWEbZqrsCVE4SLroO_F9K5v9La0lvc9w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jan 2023 19:51:05 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F24B310942D; Tue, 24 Jan 2023 03:51:02 +0300 (+03)
Date:   Tue, 24 Jan 2023 03:51:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>, g@box.shutemov.name
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230124005102.ow33h7tfmj5eqyr3@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
 <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
 <CAG48ez2zeQ4+g1=B4eyrrvZRYMr1S1xKBh2_eAhCjVjhj7Lpfg@mail.gmail.com>
 <20230116123403.fiyv22esqgh7bzp3@box.shutemov.name>
 <5a7fdfa7-5b25-0ed4-2479-661d387b397b@redhat.com>
 <20230116134710.n4dgtrutt6rqif62@box.shutemov.name>
 <1b8696ec-e2be-7b7b-705c-e2dcabb2e8e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8696ec-e2be-7b7b-705c-e2dcabb2e8e5@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:07:05PM +0100, David Hildenbrand wrote:
> > > commit bedf03416913d88c796288f9dca109a53608c745
> > > Author: Yang Shi <shy828301@gmail.com>
> > > Date:   Wed Sep 7 11:01:44 2022 -0700
> > > 
> > >      powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush
> > >      The IPI broadcast is used to serialize against fast-GUP, but fast-GUP will
> > >      move to use RCU instead of disabling local interrupts in fast-GUP.  Using
> > >      an IPI is the old-styled way of serializing against fast-GUP although it
> > >      still works as expected now.
> > >      And fast-GUP now fixed the potential race with THP collapse by checking
> > >      whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
> > >      flush is not necessary anymore.  But it is still needed for hash TLB.
> > 
> > Okay. But I think tlb_remove_table_sync_one() belongs inside
> > pmdp_collapse_flush(). Collapsing pmd table into huge page without
> > serialization is a bug. They should not be separate.
> 
> Agreed. But I wonder if it should be moved into a generic
> pmdp_collapse_flush(), that calls an arch specific __pmdp_collapse_flush().

Um? There's no __pmdp_collapse_flush(). Architectural code overrides
pmdp_collapse_flush() altogether. It has know how to serialize properly
for the arch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
