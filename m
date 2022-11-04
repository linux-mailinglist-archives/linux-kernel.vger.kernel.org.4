Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFA61A20A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKDUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKDUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:42 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D83E45EF1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C4C78320090B;
        Fri,  4 Nov 2022 16:16:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 16:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667592996; x=1667679396; bh=/ntc2/D9mT
        7L0/DAoc2JoKaev1YiM8U6WZGz5MRuYtg=; b=DzQtORUGtQknQZyEk1Y4fbKGyE
        t5cjp7vjvCno5MZRnXnUOAyolM8e3XR/Zpl/BFCK0Ffirg1/JulBHsUkvCiy7q7T
        EGejNCiROLdTNs4NIvQdfX5A5Z4gWEgQWD89wJxZgqZrtCq3a4CC4Qh1VuViAZe7
        AEl9VMiswe4sMzRFvhljZtGH4LWrJTCUikuWBDR4skb61V+9TXPh5f4w76BEu+AR
        CukgAdvc25zXcjqwlQ4O63vLLxWuXGGefqX0YuHaKk7EUzYn7yVJnHxR1RFK1avN
        DEk2WplzM59wcymj3vb0mzJr+ww72Ze4g4K8nXwmnEx0PIXKAzRLJQo0rmEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667592996; x=1667679396; bh=/ntc2/D9mT7L0/DAoc2JoKaev1Yi
        M8U6WZGz5MRuYtg=; b=mfH+gcgK4+Tob++4rzl5oZNIQF14Xj/8TisWrwqZjLTP
        B5PsCxl8sfcPUx+/Wtm4mJiX5QSk70XBkWE4SNKCx1IB9C3pNlkoT5j8eequFsH5
        GiK0UArW/DbPc6YvYwdrjU5fknboE+NzeGZzz6koamtLC4F+cM8w1/glsQ+NIWgY
        vS4kAAavWavooKcZQqbi6oIFgfuIVi+WUERtIUWlUEnUPXe5OT5sMQBFsRCG19om
        qNUQF4wkc2kKglTAKzmNbZclQgvPXYAJUpAn7ipvTLfvgSFZt/JKZY4ZMKt+UL4I
        /J2tGqs5CE7pxINXEK3idpcyVyhImH04lQgniChqRw==
X-ME-Sender: <xms:I3NlYzhCpmCwp3EI6bl8ULZ8JUBjpl4o49xg6ET3LiPspNDp3w1KKQ>
    <xme:I3NlYwCe3mlyST1lwxuio_z8vRIf8ytcvqnbMnQb7GLe-yIlshF3EnZ0jgxAKA1qa
    S8XmeUCs0y5A2AUg9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:I3NlYzGeHbXJH0Sy0E2aXbO0ucTrSxjbhUD-tirAMyV6dj1Lt1LIrg>
    <xmx:I3NlYwTNy1G5X9Vb2MjJh3BM8Z2lKXMJIq5rHPpVjcWuv8mkzzkEzg>
    <xmx:I3NlYwyn66GN_ggSutoQMU3EvLDu6MBG6dhZZ1paJJnb9XkCs3Zw_g>
    <xmx:JHNlY3mliIOMpihj5vydNHpP1k7ZMqjxF9KU6JDze6mV6l3GO4WIzQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ADECCB603ED; Fri,  4 Nov 2022 16:16:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <c22886e4-d6b0-4f57-8fdb-91814dd8b8c9@app.fastmail.com>
In-Reply-To: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
Date:   Fri, 04 Nov 2022 21:16:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022, at 00:25, Giulio Benetti wrote:
> Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
> ```
> virt_to_page(0)
> ```
> that in order expands to:
> ```
> pfn_to_page(virt_to_pfn(0))
> ```
> and then virt_to_pfn(0) to:
> ```
> #define virt_to_pfn(0) \
> 	((((unsigned long)(0) - PAGE_OFFSET) >> PAGE_SHIFT) + \
> 	 PHYS_PFN_OFFSET)
> ```
> where PAGE_OFFSET and PHYS_PFN_OFFSET are the DRAM offset(0x80000000) and
> PAGE_SHIFT is 12. This way we obtain 16MB(0x01000000) summed to the base of
> DRAM(0x80000000).
> When ZERO_PAGE(0) is then used, for example in bio_add_page(), the page
> gets an address that is out of DRAM bounds.
> So instead of using fake virtual page 0 let's allocate a dedicated
> zero_page during paging_init() and assign it to a global 'struct page *
> empty_zero_page' the same way mmu.c does and it's the same approach used
> in m68k with commit dc068f462179 as discussed here[0]. Then let's move
> ZERO_PAGE() definition to the top of pgtable.h to be in common between
> mmu.c and nommu.c.
>
> [0]: 
> https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#m1266ceb63ad140743174d6b3070364d3c9a5179b
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
