Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242C64A9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiLLWAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiLLWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6A11831
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:00:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76D37B80E7A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D7C433F1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670882436;
        bh=onh7CdjcFHxpf+vLDBDqzBOh5a7yM6UTeLlCroJcPew=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Vz/m8pQ0sTJ1Ve2IvKM3/wgptu4djHfq8mtQLDCllc4zrnXmoGIoJnWIAQPGzNYF7
         2oXJRsqlVIEBW85GRr2iGDDWvDr2k1buPLp9ZxKGdUuiMdiRxrqQYZXrzsYfbZl7A0
         4dJRkKRUKCF+MmeW2kY9lCm0EPeKhnETpD+/KhPs1bv2nexlQCCnj8xMcC5Cpi5+Ud
         rDchoBpGOqm7NN9dSZQQzF1szWuA+MaxlyueEIyNTWcwepE87DsZPeIHTR2Jxp2JDG
         XMVwpICwFL9F1vriWJeSOmZnqhxL4/RQL5BjwtrGNBHVefMXQ/get/5LeRre+ijYvq
         ria/iGWLEf84Q==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id EE5A427C0054;
        Mon, 12 Dec 2022 17:00:34 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 12 Dec 2022 17:00:34 -0500
X-ME-Sender: <xms:gqSXYyPcAyx1mDXsLpkIjIqfeFep8xH7K_WQ_rmVLbiNT5n7jyBKcg>
    <xme:gqSXYw9Jpsf54TrLgWli-NW2ItbvWDvYFnhSD0StnDZjUW0Waa3LB9vWHazFqPmAH
    drS4aGM2LwQmr3Tw48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:gqSXY5TtpLpZLJzMt_3h6zwbRKvD3fXp0gOxTA75kNF_qaw7LKlwpQ>
    <xmx:gqSXYyuM_0Yc27h8W_EzkyPppANAl9f73_JplTfrzSc9svTHSrlN9Q>
    <xmx:gqSXY6cUpZBpYPCWJp0YUyAOMTh3q6jYgVMnT6sCu7P6it78j3neZg>
    <xmx:gqSXYympgukJ2-zGs_xAnEsL47HzXJjqrezGQgcKEkXXLiIJbLjrRQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ACC0A31A0063; Mon, 12 Dec 2022 17:00:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b2896f0c-5e0d-43c9-8ead-487bf1572168@app.fastmail.com>
In-Reply-To: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
Date:   Mon, 12 Dec 2022 13:59:47 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     stsp <stsp2@yandex.ru>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     linux-x86_64@vger.kernel.org
Subject: Re: strange behavior with sigreturn() to 32bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022, at 1:08 AM, stsp wrote:
> Hi.
>
> I am playing with 32bit compatibility segments,
> and I am observing something very strange.
> To demonstrate the problem, I did the change
> to the kernel sigreturn test-case, and it is attached.
> The change just moves the magic value to EAX
> and calls an interrupt that produces a SIGSEGV.
> The SIGSEGV handler prints the needed regs.
> This patch intentionally adds 0x100000000 to
> the RIP register, because AFAIK the high part
> or 64bit regs are irrelevant in compatibility mode.
> Now with high part of RIP non-zero, we see this:
> $ ./sigreturn_64
> err=0 trapno=d ax=0 ip=100000003
>
> OK, obviously our asm code didn't execute -
> why is so? How does the high part of RIP
> affect compatibility mode?
> Then lets start the same example under gdb:
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000403008 in int31 ()
> (gdb)
> Continuing.
> err=18a trapno=d ax=a5f3 ip=403008
>
> Wow! Much better now: error code is correct,
> ax is correct, but ip is invalid.

I generally distrust gdb when mixed modes are involved -- it's fundamentally intensely buggy.  Now maybe you're not hitting the bugs I know of, but still...

Anyway, the behavior I expect (not that I've tested this, but based on my memory of how this is all supposed to work) is that an attempt to return to user mode will fail with #GP because the full value of RIP is compared to the segment limit, which is 2^32-1.  And #GP is 0xd, so your non-gdb outputs look broadly correct...
