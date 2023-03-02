Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB716A7A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBDwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:52:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12B32532
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:52:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCCF6124D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F92C4339B;
        Thu,  2 Mar 2023 03:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677729126;
        bh=s5Vq/wYHJA+zeaFjOEhQKu38pm6W1xLhaTbiAi2CJmk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=FdA/Gg6WGhOpg48Qps2k1ihFI5uaJVQXUG0TlVw32ePLSbCSG6+p72aLjeB/u4A5g
         qIa7WnlLt5HqI+2GPkU+YRnzCphMcIuVAfbnRLtAqWYsQtoE2Ioxqf1Bm+VbDybYSX
         1Yn9tws7PZf2QQRrZu8ENc+B/MPocVnKQ7ylBp8hmbuZbKjLxOBrF+qVJ31s3qz/Tr
         LbYpn6E0faEdwXnFZ0Er2rU4+nR5KUx6sfxcSSkSJ22DEfxBqxFDp+r57VhO85OsYI
         fh+UjNBZh62flWGZQat00aWRHXCpnFupN1fgrj/xHDzNy4QBqeUtiIDE8uRQcSsMrf
         FP8VgGMdZNI3Q==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F21C27C0054;
        Wed,  1 Mar 2023 22:52:05 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 01 Mar 2023 22:52:05 -0500
X-ME-Sender: <xms:ZB0AZLCWKl8Vdq-oOoVeycHzr7MceF7RQJkb37RcG6SkCUcWcg5YHw>
    <xme:ZB0AZBhluprdOMkj3Jeb3Kdj1x5vqgFchUi8ycnWkC78OqmFg0i1Ch9u067pF_k9r
    OMArXWvhA-MSnX-rRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeliedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepveffgfevhfeiteduueetgeevvdevudevteefveffudeiveefuddt
    leeitdeludfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:ZB0AZGnzsFFAJAFNjhTSeavCJGxLa5VfVsJ-0jxZfI5dQQ2AoTsSIg>
    <xmx:ZB0AZNxlt3qbkpCa5DPW7We25ulwvFsu3u-z_HxyslKr41h9wiUNxA>
    <xmx:ZB0AZATLrfBkXY0DNyIV9MaNA0Ta3SesYXYRFfqAVFZvrT2FXTxgAw>
    <xmx:ZR0AZLe03Yd5KvVPhocFZU9yh1Yc9DcfqBzSUxAFhyrdeH4CaPCRTg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB8CF31A0063; Wed,  1 Mar 2023 22:52:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
In-Reply-To: <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
Date:   Wed, 01 Mar 2023 19:51:43 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Mike Rapoport" <rppt@linux.ibm.com>,
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

On Thu, Jun 3, 2021, at 11:01 AM, tip-bot2 for Mike Rapoport wrote:
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     f1d4d47c5851b348b7713007e152bc68b94d728b
> Gitweb:        
> https://git.kernel.org/tip/f1d4d47c5851b348b7713007e152bc68b94d728b
> Author:        Mike Rapoport <rppt@linux.ibm.com>
> AuthorDate:    Tue, 01 Jun 2021 10:53:52 +03:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Thu, 03 Jun 2021 19:57:55 +02:00
>
> x86/setup: Always reserve the first 1M of RAM
>
> There are BIOSes that are known to corrupt the memory under 1M, or more
> precisely under 640K because the memory above 640K is anyway reserved
> for the EGA/VGA frame buffer and BIOS.
>
> To prevent usage of the memory that will be potentially clobbered by the
> kernel, the beginning of the memory is always reserved. The exact size
> of the reserved area is determined by CONFIG_X86_RESERVE_LOW build time
> and the "reservelow=" command line option. The reserved range may be
> from 4K to 640K with the default of 64K. There are also configurations
> that reserve the entire 1M range, like machines with SandyBridge graphic
> devices or systems that enable crash kernel.
>
> In addition to the potentially clobbered memory, EBDA of unknown size may
> be as low as 128K and the memory above that EBDA start is also reserved
> early.
>
> It would have been possible to reserve the entire range under 1M unless for
> the real mode trampoline that must reside in that area.
>
> To accommodate placement of the real mode trampoline and keep the memory
> safe from being clobbered by BIOS, reserve the first 64K of RAM before
> memory allocations are possible and then, after the real mode trampoline
> is allocated, reserve the entire range from 0 to 1M.
>
> Update trim_snb_memory() and reserve_real_mode() to avoid redundant
> reservations of the same memory range.
>
> Also make sure the memory under 1M is not getting freed by
> efi_free_boot_services().

This is quite broken.  The comments in the patch seem to understand that Linux tries twice to allocate the real mode trampoline, but the code has some issues.


First, it actively breaks the logic here:


+               /*
+                * Don't free memory under 1M for two reasons:
+                * - BIOS might clobber it
+                * - Crash kernel needs it to be reserved
+                */
+               if (start + size < SZ_1M)
+                       continue;
+               if (start < SZ_1M) {
+                       size -= (SZ_1M - start);
+                       start = SZ_1M;
+               }
+


The whole point is that, if we fail to allocate a trampoline, we free boot services and try again.  But if we can't free boot services below 1M, then we can't allocate a trampoline in boot services memory.  And then it does:


+       /*
+        * Unconditionally reserve the entire fisrt 1M, see comment in
+        * setup_arch().
+        */
+       memblock_reserve(0, SZ_1M);


But this runs even if we just failed to allocate a trampoline on the first try, again dooming the kernel to panic.


I real the commit message and the linked bug, and I'm having trouble finding evidence of anything actually fixed by this patch.  Can we just revert it?  If not, it would be nice to get a fixup patch that genuinely cleans this up -- the whole structure of the code (first, try to allocate trampoline, then free boot services, then try again) isn't really conducive to a model where we *don't* free boot services < 1M.


Discovered by my delightful laptop, which does not boot with this patch applied.


--Andy
