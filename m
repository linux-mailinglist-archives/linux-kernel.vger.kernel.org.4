Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BB665D79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjAKOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjAKOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:15:07 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34918690
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:15:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 85C315C01BD;
        Wed, 11 Jan 2023 09:15:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jan 2023 09:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673446504; x=1673532904; bh=d7
        o3kj/Z/vK6V725jjEnUNSDO4G71V9PXMP9Obm3o9M=; b=BIBP0klkoRyawjatsO
        AHvzRWMjsOBzYHjzWRyVjft3peKFivD3em4OKL4nJEoaxnXIIesdzTdkklwCRqxz
        T2zX6osIT8LYDsp01viXrHe87sgNjGzIDB5HdZrkebdAbUX3rLjG7a5q8GTL+Hj1
        AT30h0moP6fGfucn/1cLOTQhaMxQiA2NdGk/sJKUpqR34Ccb1cAfQ90BBq0/9uMl
        ai96qkrUYfXEuZa2vy0pqD2FM2yoMJ+zmx1rCQ9pIZHmWrZl/lumbDVaVfE0Kxi7
        eowGxF9xS4yKTEAGFXTxWJmshrG5xt8rznCjQhD46sbXq5Y7L+i8hUZ3uDlXZ/HA
        3v1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673446504; x=1673532904; bh=d7o3kj/Z/vK6V725jjEnUNSDO4G7
        1V9PXMP9Obm3o9M=; b=WEISMpVytYlaMYfejIvTKo2aTBvvJmU+AG/y83yE7Vaa
        o74pBAens5T71FO91s9aqU3laRruA/dEFjBt8+RTMbY5pT6YzfPEW9jEmihGvkxQ
        xH2U7fLSoZd7AHf6UCIO+frsOZiuixWz6n2jtp5/vEE968vmHB3tNLqZBOEV50i6
        VDYlPepDCAKPjOjDuoGy5qNCltb2NW0O5G0oK9byTllLzjtBbPEROiZ8Lp+s1v30
        Wji/YCxQRDsEFCdZivBi6WHyg2y6k7jAmJRwrgwJbajrVAooDOJxxkJatvVGkT1a
        iw+/HL/9F7rvnOc8ztbhYLBxuj+TqU42dNnzmFqtjw==
X-ME-Sender: <xms:Z8S-Y8BFkLyeawxfGzdcjOuaiY4VW2h6y5zUgVeM7SbIsgp5GURO1w>
    <xme:Z8S-Y-hODv2bEDXI6KKogJqEiN0PB3pyx0xmQxt6ArUymoSQ5OV0f1BCbzis3IyWh
    DLVRCGYYUi1CuiqNE8>
X-ME-Received: <xmr:Z8S-Y_lgPH_xI1n1J6T-I7QIQKaBXkWImnXFJjK3CMZ7Ofjhpd1ChPKU0h9FmQp76oBrgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeggdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Z8S-YyxsRASlSmidm6QbWUFALubKU-39WaVW3LrHeKKUpqJ65tjbSA>
    <xmx:Z8S-YxRbJWf01dwhgDoMr0eYnYvl9ibTcrqTnR4EFrbpv7Aug48hHA>
    <xmx:Z8S-Y9ZbEkproRp37x8uNmgSruiDrXZ_PnjRdiAUKgSi_4O1YSsiOg>
    <xmx:aMS-YyL2VZT_qdgHeoHIme0XKOL7P75xhjTdc6FxnUc8rtSi3x9T2A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jan 2023 09:15:03 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A4689104377; Wed, 11 Jan 2023 17:14:59 +0300 (+03)
Date:   Wed, 11 Jan 2023 17:14:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv14 04/17] x86/mm: Handle LAM on context switch
Message-ID: <20230111141459.ah7ijfbm733c4g7m@box.shutemov.name>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-5-kirill.shutemov@linux.intel.com>
 <CAHk-=whb1_6qwb=BSpj1KkTfJiTiahAnvTBh_=fnGyrnKAW19A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whb1_6qwb=BSpj1KkTfJiTiahAnvTBh_=fnGyrnKAW19A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 07:49:30AM -0600, Linus Torvalds wrote:
> Sorry, I'm traveling, and right now only on mobile. So I'm reading patches
> on my phone, and answering on it too, so html garbage..
> 
> On Wed, Jan 11, 2023, 07:24 Kirill A. Shutemov <
> kirill.shutemov@linux.intel.com> wrote:
> 
> >
> > +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> > +{
> > +       return READ_ONCE(mm->context.lam_cr3_mask);
> > +}
> >
> 
> I mentioned this before - in the original version this needed (but didn't
> have, iirc) that READ_ONCE, but in the new non-thread situation I don't
> think that's true. There should be no concurrent changes that can interfere
> with the read, no?

It should be safe, yes. 

It is reachable from iommu_sva_bind_device(), but it only called with mm
== current->mm.

I will drop the READ_ONCE().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
