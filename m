Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF16AD360
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCGAdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCGAdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:33:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFA725E1A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:33:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E376CE17E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDDC4339B;
        Tue,  7 Mar 2023 00:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678149219;
        bh=CQyIIQ48jrKQnJU6vpZckUaiFwZea9y+X7afskhGcU8=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=owMys9rR0NiUedicRb9HSulV+t7EDtKToYsEJR23tXOTteGA4Y6sxnVvK5ha2gZTI
         gURGWzj35nNq1kHdEK/mxhG8wWpBTtp6s7u/gz7R4wTr5OBNytY12q6ZTww/FgUKa7
         +cT3kVBxLruL/jHs4y51UwcUhOMv9Flu3gS0Hir1Nkg2mPCPFzjtOPenpQMFeGWLgy
         rT8cDzU4l3jNoHWbk4P3S5nDzS2y5iYO6EclB/jn9t0PBTzp1OGLzSsYEw29oiZb6i
         twz8SsQ6Q/RCtLiOJuBP2V/tZHUzna3VvLK0KZO2MPDGmYPqqFIjmTQ0uPhD3+dyKM
         7hGA/xBLc5p5Q==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 41B7327C0054;
        Mon,  6 Mar 2023 19:33:38 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 06 Mar 2023 19:33:38 -0500
X-ME-Sender: <xms:YYYGZM7f2OhIUJVnDAJX3e5KC7vltxWnS_gUYRr1tu1B2wduzHpyVg>
    <xme:YYYGZN56SDuMdUDS1ezU8_U64Ha1sn3Sv-QutbNr6yvCC9jlLtC9oRKGlzJd_pOxN
    rZF2GNerctwOWO_ASU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:YoYGZLccSBxI88JnYpHDX2b6WdWa_E0ye2KKvpzixDqxbaB8Y-YRMg>
    <xmx:YoYGZBIQGESdlImi8Erj_tRTCnNZVQDqC6QVqxs9RGuQC87XHqsUhA>
    <xmx:YoYGZALIikUyF4s-hVVf9E1ZL-Hr6Oo6G6iYhL1GclDCaaBso6a9cw>
    <xmx:YoYGZHUTMgxZt34V01FwDNQZxHP6h1zr07eYMuwa8tItF_ehBnRpYw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E33EC31A0063; Mon,  6 Mar 2023 19:33:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <5454ba91-c7f8-49fc-af76-ebb85d20742a@app.fastmail.com>
In-Reply-To: <ZAG5fvRl4Z+3vGfS@linux.ibm.com>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
 <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
 <ZAG5fvRl4Z+3vGfS@linux.ibm.com>
Date:   Mon, 06 Mar 2023 16:33:16 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Mike Rapoport" <rppt@linux.ibm.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>, "Hugh Dickins" <hughd@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023, at 1:10 AM, Mike Rapoport wrote:
> Hi Andy,
>
> On Wed, Mar 01, 2023 at 07:51:43PM -0800, Andy Lutomirski wrote:
>> On Thu, Jun 3, 2021, at 11:01 AM, tip-bot2 for Mike Rapoport wrote:
>> >
>> > x86/setup: Always reserve the first 1M of RAM
>> >
>
> ...
>
>> +       /*
>> +        * Unconditionally reserve the entire fisrt 1M, see comment in
>> +        * setup_arch().
>> +        */
>> +       memblock_reserve(0, SZ_1M);
>> 
>> 
>> But this runs even if we just failed to allocate a trampoline on the
>> first try, again dooming the kernel to panic.
>> 
>> I real the commit message and the linked bug, and I'm having trouble
>> finding evidence of anything actually fixed by this patch.  Can we just
>> revert it?  If not, it would be nice to get a fixup patch that genuinely
>> cleans this up -- the whole structure of the code (first, try to allocate
>> trampoline, then free boot services, then try again) isn't really
>> conducive to a model where we *don't* free boot services < 1M.
> 
> Currently, the second attempt to set_real_mode_mem() in
> efi_free_boot_services() does not allocate from memblock anyway but reuses
> memory freed from EFI services. Could be that failure to boot caused by
> another failing reservation?

I'm not actually sure what's wrong per se.  Certainly efi=debug will utterly break my quirk, but other than that, I would have expected it to still work on a more careful reading.

Anyway, I have a fixup series that works in a VM that i'll test in a bit.

> 
>> Discovered by my delightful laptop, which does not boot with this patch applied.
>
> Do you have early_printk() visible? 

Yes, but I haven't found a smoking gun yet.

> 
>> --Andy
>
> -- 
> Sincerely yours,
> Mike.
