Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1C6024EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJRHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJRHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:03:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF12A3F62
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:03:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 312663200893;
        Tue, 18 Oct 2022 03:03:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 03:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666076602; x=1666163002; bh=p83bT/t9dY
        dIjirJ4X6tXwroEW+PJkE+3Ptvk+Zsny4=; b=Dg0xT/m3F5j4DV8ZcG3prmiZlc
        vq5YYDQqmup1B4rAlOcZl3Josd0kRzHqoYF40jmz2ZQqcvJ9jBDZpPjlX0FTFecs
        sXQFSkLsZ7PbFy5ZyK9cIpBRn53C9vLSd/kD6PV8Ahr4+kl9yAJMnuW9OLLcKasU
        T5Wkl3t5FGdj9JlyEeqciZfoxanNSZU5GdTvVcyeZt58GtquB/35b9or5ecztJO9
        quJq8NymqfrIzkNDzb/whYz8xo7vqL2Ib9cFoXv2Q8tPx7VTWp5wu99FQCPoxQhc
        G6v8u9IZksUjSSoVdA927Phge/0Osdamee0EATLLV/eV8Gn6zqqxpUZqDVoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666076602; x=1666163002; bh=p83bT/t9dYdIjirJ4X6tXwroEW+P
        JkE+3Ptvk+Zsny4=; b=FDeqYWXFTI/Rl/LY3fflR4CEXaGAHdBfQ+AMKRPKxn3D
        +3mX0bJLAS1RdQB43/bkqpSCiiw6uVxwZjUMiYVovs06wLqttHauC52UWjB+w3u+
        LmXm3SOQ3AAc3uNhz2OHi0qwOiCdNn8MxfDoATGanGTbgMgm1KHSgRqSJq4Iq1sw
        l0DnxnuAvmtndROWYq4H4jU/uLvgN2EnP1aTsMxwpq9Um+NVuzbwh5UrOQhiGlEH
        uSkEmm+M9gtxmZJMFNsfiCCwDaDGIHQ8GvGiNpLi4fv8VqiR8oGI4DWbYrYW/PuB
        YVFJI5/50w0f+YTgAb0+h0TBj+QAvMrQKFDJbBYc+Q==
X-ME-Sender: <xms:uk9OYwOmkp7F012UiCtm3HCMwwQL12R_wyJOp1TVbauM7JWgoEtxxw>
    <xme:uk9OY299UTKSxk-XgSA0MUX37BlQDDrUhS_YTB9ssFXqmpJhzgkaH3G8wZ-bvYj2P
    Y0lkmTwYUzrroa6yAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uk9OY3R6GH8lIaDyzJ4HnenKgr4Ka0jkT0OZEv1h3OrBp3CbmYeDEg>
    <xmx:uk9OY4vHQ9v5Ke4jpbsXMM70vmWfIi3rwoy3czue1M3zsfnMYJnybA>
    <xmx:uk9OY4ecivtr73_L1rYJd2g457sCYFxn6rA2p06PdHUzLx4O4I6uzA>
    <xmx:uk9OYwSSUW2BpHrFnaJ0NQCaicJfFcmQEDR1t1-6gyYReTwz5F4laA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 476FBB60083; Tue, 18 Oct 2022 03:03:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
In-Reply-To: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
Date:   Tue, 18 Oct 2022 09:03:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
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

On Tue, Oct 18, 2022, at 1:37 AM, Giulio Benetti wrote:
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
> empty_zero_page' the same way mmu.c does. Then let's move ZERO_PAGE()
> definition to the top of pgtable.h to be in common between mmu.c and
> nommu.c.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Maybe mention commit dc068f462179 ("m68knommu: set ZERO_PAGE() to the
allocated zeroed page") for the commit that fixed this first,
as well as the previous discussion at
https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#m1266ceb63ad140743174d6b3070364d3c9a5179b

It looks like we dropped the ball on this when it came up last.
I'm also not sure when we started requiring this, any idea?
I can see that microblaze-nommu used BUG() in ZERO_PAGE(), so at
whenever microblaze last worked, we clearly did not call it.

> +#ifndef __ASSEMBLY__
> +/*
> + * ZERO_PAGE is a global shared page that is always zero: used
> + * for zero-mapped memory areas etc..
> + */
> +extern struct page *empty_zero_page;
> +#define ZERO_PAGE(vaddr)	(empty_zero_page)
> +#endif

In addition to your fix, I see that arm is the only architecture
that defines 'empty_zero_page' as a pointer to the page, when
everything else just makes it a pointer to the data itself,
or an 'extern char empty_zero_page[]' array, which we may want
to change for consistency.

There are three references to empty_zero_page in architecture
independent code, and while we don't seem to use any of them
on Arm, they would clearly be wrong if we did:

drivers/acpi/scan.c:#define INVALID_ACPI_HANDLE ((acpi_handle)empty_zero_page)
drivers/spi/spi-fsl-cpm.c:      mspi->dma_dummy_tx = dma_map_single(dev, empty_zero_page, PAGE_SIZE,
include/linux/raid/pq.h:# define raid6_empty_zero_page empty_zero_page

     Arnd
