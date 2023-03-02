Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6106A84EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCBPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCBPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:06:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5506C55072
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:06:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D839E615F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF997C433A1;
        Thu,  2 Mar 2023 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677769594;
        bh=FdJDrtgvO+zazRZyI/ANj+54LorzkRO9vTG33XftdBc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Xkgd+P4X22UqIdrQRfjP6APYKx49gMV6gtd9XZM13QSdO5jBK3Na/LetFYAO9YcKp
         t9q9Z6RAC7Hbv6a7+KYBm5F38FeVB8XLEliWhAWXvRW3s2hdhvbuwNna4f5X5DMsuk
         3USIvYsF2LVjASIRUt/QjrPWyWJemlnPPFHNVEbB0fkw2g7m/UlrzbYh3+QRG34g2o
         U9/tzia6M4IuA+/1Ws2PtXF7RiLSoruSBCt4aKKEfDGu/k2mSjGa8V5HjMNq6e1fIc
         QE4L+J2deLAPwcMgBpGPDnOmYL9CBWLv0eoWXA4ij8ryjybqTT+TfXaqinIUkLg+5t
         X80DoqGhNnGmQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CB72B27C0054;
        Thu,  2 Mar 2023 10:06:32 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 02 Mar 2023 10:06:32 -0500
X-ME-Sender: <xms:eLsAZE-qQDzCbrpsyM4U0d3X7KDbBAVP4tK0ph4wjJuA7HCdpTFwZg>
    <xme:eLsAZMuZVYtg1iRWCcJgzBKzUfIaN1Q-D19Uhr1oWRYXNkjJxwLbFBXlJHP2e4vjI
    sB1LskPvVQl_1xalFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeljedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepveffgfevhfeiteduueetgeevvdevudevteefveffudeiveefuddt
    leeitdeludfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:eLsAZKA1IwRoJ0fiCagLCdLL2GpG_N-sIMppDO_d5PHjXEiGTpT9mA>
    <xmx:eLsAZEcBj9l8chUf6ddnub-0IpYEM9KjEvuHKg0CoulnZx5LX_NdjA>
    <xmx:eLsAZJMZwRgqg5Cjj3unkIUeXe3wwfw5ZcEQ0wnn_NbCTVCl0YZu6g>
    <xmx:eLsAZCam0NvcafK4tTtrLWeHYZjsxYfrX2j2M1l8nSExG2rct2EtYg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54A4F31A0064; Thu,  2 Mar 2023 10:06:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <840dcfd4-0d6c-400a-9cf7-8fe56d55ac7f@app.fastmail.com>
In-Reply-To: <ZAB/b+FjHjuRqe/S@zn.tnic>
References: <20210601075354.5149-2-rppt@kernel.org>
 <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
 <7d344756-aec4-4df2-9427-da742ef9ce6b@app.fastmail.com>
 <ZAB/b+FjHjuRqe/S@zn.tnic>
Date:   Thu, 02 Mar 2023 07:06:11 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Hugh Dickins" <hughd@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Mar 2, 2023, at 2:50 AM, Borislav Petkov wrote:
> On Wed, Mar 01, 2023 at 07:51:43PM -0800, Andy Lutomirski wrote:
>> This is quite broken.  The comments in the patch seem to understand
>> that Linux tries twice to allocate the real mode trampoline, but the
>> code has some issues.
>> 
>> First, it actively breaks the logic here:
>> 
>> +               /*
>> +                * Don't free memory under 1M for two reasons:
>> +                * - BIOS might clobber it
>> +                * - Crash kernel needs it to be reserved
>> +                */
>> +               if (start + size < SZ_1M)
>> +                       continue;
>> +               if (start < SZ_1M) {
>> +                       size -= (SZ_1M - start);
>> +                       start = SZ_1M;
>> +               }
>> +
>
> Are you refering, per-chance, here to your comment in that same function
> a bit higher?
>
> Introduced by this thing here:
>
> 5bc653b73182 ("x86/efi: Allocate a trampoline if needed in 
> efi_free_boot_services()")
>
> ?

Yes.

>
> Also, it looks like Mike did pay attention to your commit:
>
> https://lore.kernel.org/all/YLZsEaimyAe0x6b3@kernel.org/

He definitely did.  But I'm still pretty sure the patch in question broke it :-/

>
> And then there's the whole deal with kdump kernel needing lowmem. The
> function which became obsolete and got removed by:
>
> 23721c8e92f7 ("x86/crash: Remove crash_reserve_low_1M()")
>
> So, considering how yours is the only report that breaks booting and
> this reservation of <=1M has been out there for ~2 years without any
> complaints, I'm thinking what we should do now is fix that logic.
>
> Btw, this whole effort started with
>
>   a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
>
> Also see this:
>
> ec35d1d93bf8 ("x86/setup: Document that Windows reserves the first MiB")
>
> and with shit like that, we're "piggybacking" on Windoze since there
> certification happens at least.
>
> Which begs the question: how does your laptop even boot on windoze if
> windoze reserves that 1M too?!

I haven't booted Windoze on this thing in years.  But...

There is no possible way that Windoze genuinely reserves the first 1M. It does SMP, and x86 needs <1M memory for SMP, so Windoze uses <1M memory.  QED :)

>
>> I real the commit message and the linked bug, and I'm having trouble
>> finding evidence of anything actually fixed by this patch.  Can we
>> just revert it?  If not, it would be nice to get a fixup patch that
>> genuinely cleans this up -- the whole structure of the code (first,
>> try to allocate trampoline, then free boot services, then try again)
>> isn't really conducive to a model where we *don't* free boot services
>> < 1M.
>
> Yes, I think this makes most sense. And that whole area is a minefield
> so the less we upset the current universe, the better.

I'll send a revert patch.

Thinking about this a bit more, if we actually want to "reserve" <1M, we should implement it completely differently by treating <1M as its very own special thing and teaching the memblock allocator to refuse to allocate <1M unless specifically requested.  There's only a very small number of allocations that need it (crashkernel for some reason?), and there are at least two spurious users of memblock_phys_alloc_range that curently may use <1M but have no business doing so (ramdisk code and the NUMA distance table).  But let's only do that if there's an actual problem to solve.

>
>> Discovered by my delightful laptop, which does not boot with this patch applied.
>
> How come your laptop hasn't booted new Linux since then?!? Tztztztz

Honestly, no clue.  Looking at the logs, I'm pretty sure I *did* boot an affected (6.0) kernel.  The actual problematic memory map on this laptop seems to show up a bit inconsistently as some horrible combination of firmware settings (especially SGX) and who-knows-what else.  My best guess is that a GRUB update I installed yesterday caused some tiny memory map change that triggered it.

I did install a new kernel yesterday too, but the *previous* kernel stopped booting too.

>
> Thx.
>
> -- 
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
