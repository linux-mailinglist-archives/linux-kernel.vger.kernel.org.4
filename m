Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82766B391
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAOTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAOTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:07:05 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6223A8D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:07:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C33D632008FF;
        Sun, 15 Jan 2023 14:07:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Jan 2023 14:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673809620; x=1673896020; bh=vs
        0/04K1GIos3EULc9wcvjYIMqUKIQ9jTNF2u67vRqc=; b=KIkUMx5nLlUKpDJhC6
        +lhg0WierY3fIs1gAvNbRzY/0BNYGiR151XpaM1usQNjRaRr/s2iNCTST7Dduw9G
        oNrL9zztciY4PMeXma1IuhfQd0MsnivFtI4TTQS8ZPwUJ/50R8r8t9VZwTXhkfiW
        G9U41x6Dpt9cOriISUjpP/Qcqu1HummU8KcDUfRFMN16ZCmzkhcvh+lwlvSbcz1u
        HIM+uYzDrn48VF0Hy7E8h97YV+0hBpK5l+tZEJVJ2oAivM0hblG2ewfjrRDVSxqI
        wf77Mva9C27/nE8M1qH55vV+Y+y8xs4rrxbxJcBeQH8o/Rin5Gwm4I9bKAlpDnkH
        jFyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673809620; x=1673896020; bh=vs0/04K1GIos3EULc9wcvjYIMqUK
        IQ9jTNF2u67vRqc=; b=jxXle1w6tDVLVVtZUsl47klynlSdhnEwIHy9LAW6zGtT
        1xEbJ+j+cZHlcrvdyAiiRJpDY8o9jhMqCuHfn7dgXzbUwbFI9PTymN2qP4ySGa9u
        cw5xCdVpfZqczjjKzlw9fEbZ9foAtyRO0MI7iXsKUdfu28e77Le2W+at6oNIw35Y
        ZL5wCWxdvRMzKTcaLwaM1RVi3ZbxXM8aCBAd8SLCZs1MEYS++q2Wm9MgXqrYcugv
        mdSDHVyevE7PrWi2775h3ZoI8bdF6WLeGDegKqEd62ArYk/clr6nLatmw+s8ynSU
        66Od2/zxrY9Pui30ASw4XaUI8vJggAcPvq2ybSB8Wg==
X-ME-Sender: <xms:007EY8_aoeCzDZuCzSODc0weg4zIpwjMaVoO2oUWWg1-XL8hX1mzKg>
    <xme:007EY0tASpD7GWM2HXXu2i72woJRDu8O7tH-r3N65CvIkGJjmLY-7JzYKd0jec_Fn
    QZKW_-UOmDleu8bkiU>
X-ME-Received: <xmr:007EYyAa5WsvJu7sE_yVqrNWV1M0Y7LowneW2VhSz2jCkGBz-SnSgmjjr82U4bbz_5fkrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:007EY8dLaOC0rsm-Jj_um9OMBUj67r5EKqTdRAuin_Ja_FuOqEQ7-A>
    <xmx:007EYxPSNOr23vXkAs-jEhBcRnU6522Nx_6lgse9KDnxHhGx1uDsSw>
    <xmx:007EY2kgpdGBq1R0p5lskD8f1L9kZzqXmVhKkURSke1ommmQJsv5Mg>
    <xmx:1E7EY9CRB77OGAjS8zd99uawDtXe6fdgtY_e-ILqfF3zPZG1LBwFxQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jan 2023 14:06:59 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 04B5B102D59; Sun, 15 Jan 2023 22:06:55 +0300 (+03)
Date:   Sun, 15 Jan 2023 22:06:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230115190654.mehtlyz2rxtg34sl@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:28:59PM +0100, Jann Horn wrote:
> No, that lockdep assert has to be there. Page table traversal is
> allowed under any one of the mmap lock, the anon_vma lock (if the VMA
> is associated with an anon_vma), and the mapping lock (if the VMA is
> associated with a mapping); and so to be able to remove page tables,
> we must hold all three of them.

Okay, that's fair. I agree with the patch now. Maybe adjust the commit
message a bit?

Anyway:

Acked-by: Kirill A. Shutemov <kirill.shutemov@intel.linux.com>

BTW, I've noticied that you recently added tlb_remove_table_sync_one().
I'm not sure why it is needed. Why IPI in pmdp_collapse_flush() in not
good enough to serialize against GUP fast?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
