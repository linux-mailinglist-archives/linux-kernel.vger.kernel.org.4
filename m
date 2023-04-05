Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E16D7DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjDENmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjDENmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:42:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F091FE0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:42:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D9F0F5C00D3;
        Wed,  5 Apr 2023 09:42:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 09:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680702151; x=
        1680788551; bh=FZGH5Oe7v8drJWg0YjWA6GRDzpcW267pyOqwWY55WMg=; b=M
        3nlr1G+xVsldJNzVhrZwfgKKeuvQaqnOZH6nDdi0Wclau3pIecVGaTKglQ3601bt
        WM4XCddZRFRO1e3RXCRsToD/uY1Cji2uP7XlPF9XE6MmQBNYhiYemGui1DUsP+c/
        3lTGDdAvgzcxGMJ4ZpoltjS+RT/Hu1V+oARbqF1RrpQvCOaVlVG2ldiCcVLXWCSI
        seICNxBK2CMmnkFE7ybVtKcoQRhxKvvui7sNabHM+zDQtwhnfeI6z1f9iLaL7Ppj
        vQw52uQPKfdMBm4/T4R/KnPs6bjBSSoYb9qx2en1VVQxc7XsczYF6O+tOkgubbPl
        oq/tJ2oe1We+1BcdJOY6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680702151; x=1680788551; bh=FZGH5Oe7v8drJ
        Wg0YjWA6GRDzpcW267pyOqwWY55WMg=; b=mxpaTGTpZ6faV+4oGCQWgilzrMMWV
        q1QRAkA1R7mZEqiNUBrdOP/0cK/Y9lC63jS2pNTqlvDe2H0TEWg2lF3QFLW7W4yt
        +mYtC1vgw/Co+3qviRyMckpCoQWDCKKfaiEJt1ZLA2q/xRMsUU8tlGg2dR9hUt9i
        FoKH/mp+IcyUPuhb7IwujoFZfh6I2AlKiT8NiufWoYoIpX7FY6lUcBymWB3ggQGd
        sgzfAQnsOBLXeqkLz+SFF1qIQAEZOrJlM08SSzPbCiKPGppMqu/SNYymVX8IEqkM
        gZUBqea1S71CG/CCzEYMJvR49lYQQ2YIQq+68iq+T41EZ/XjOvFjP6Oig==
X-ME-Sender: <xms:x3otZNVLjDz_yzE7kbfDES8ZoQXoJfxVfTnSEz1E1XIcZaxYwLUXdg>
    <xme:x3otZNnDL7oJGnbFNCVPdJO5aAlQNpGtG4EHHl3fCo9rF2hn94TAVk_0Iq2OchfNv
    MEChmzSy4wrPEmHSQg>
X-ME-Received: <xmr:x3otZJaxt-Hiinz1Y28byVEHB1d4RsoE6Wr8vblUsbE47i0A8UH_cDI34BP6Jx1MLFP7GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:x3otZAXN7jNFwjcHuUYr2rGG8UDlGRAtFzI1Ujd85-NK-CgFnnAexA>
    <xmx:x3otZHmNvzuUlR1MuN2-whKMrO4-ntCTf_WsD0wN1gkxx4sugQ0N_g>
    <xmx:x3otZNeOHGTqECNwZq02qzJ47coDMIJiEXnc9FFUQz9mioICKJfUSw>
    <xmx:x3otZJqKnUnktgKTy04gcXcv4BM0gclmI0z9r_PNcj32yCY5T7R2tA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 09:42:30 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 74A80102846; Wed,  5 Apr 2023 16:42:26 +0300 (+03)
Date:   Wed, 5 Apr 2023 16:42:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230405134226.2ptk3rd7mfin3wlm@box.shutemov.name>
References: <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
 <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:46:59AM +0200, Ard Biesheuvel wrote:
> On Tue, 4 Apr 2023 at 23:02, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, Apr 04, 2023 at 10:41:02PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 4 Apr 2023 at 22:24, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Tue, Apr 04, 2023 at 09:49:52PM +0200, Ard Biesheuvel wrote:
> > > > > On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > > >
> > > > > > On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > > > > > > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > > > > > > I still think it is a bad idea.
> > > > > > > >
> > > > > > > > As I asked before, please include my
> > > > > > > >
> > > > > > > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > > >
> > > > > > > > into the patch.
> > > > > > >
> > > > > > > I was pretty opposed to this when I first saw it too.  But, Tom and
> > > > > > > company have worn down my opposition a bit.
> > > > > > >
> > > > > > > The fact is that we have upstream kernels out there with SEV-SNP support
> > > > > > > that don't know anything about unaccepted memory.  They're either
> > > > > > > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > > > > > > needs to accept the memory.  That entity obviously can't be the kernel
> > > > > > > unless we backport unaccepted memory support.
> > > > > > >
> > > > > > > This both lets the BIOS be the page-accepting entity _and_ allows the
> > > > > > > entity to delegate that to the kernel when it needs to.
> > > > > > >
> > > > > > > As much as I want to nak this and pretend that that those existing
> > > > > > > kernel's don't exist, my powers of self-delusion do have their limits.
> > > > > > >
> > > > > > > If our AMD friends don't do this, what is their alternative?
> > > > > >
> > > > > > The alternative is coordination on the host side: VMM can load a BIOS that
> > > > > > pre-accepts all memory if the kernel is older.
> > > > > >
> > > > >
> > > > > And how does one identify such a kernel? How does the VMM know which
> > > > > kernel the guest is going to load after it boots?
> > > >
> > > > VMM has to know what it is running. Yes, it is cumbersome. But enabling
> > > > phase for a feature is often rough. It will get smoother overtime.
> > > >
> > >
> > > So how does the VMM get informed about what it is running? How does it
> > > distinguish between kernels that support unaccepted memory and ones
> > > that don't? And how does it predict which kernel a guest is going to
> > > load?
> >
> > User will specify if it wants unaccepted memory or not for the VM. And if
> > it does it is his responsibility to have kernel that supports it.
> >
> > And you have not addressed my question:
> >
> >         How is it different from any other feature the kernel is not [yet] aware
> >         of?
> >
> 
> It is the same problem, but this is just a better solution.

Okay, we at least agree that there are more then one solution to the
problem.

> Having a BIOS menu option (or similar) to choose between unaccepted
> memory or not (or to expose CXL memory via the EFI memory map, which is
> another hack I have seen) is just unnecessary complication, if the
> kernel can simply inform the loader about what it supports. We do this
> all the time with things like OsIndications.

It assumes that kernel calls ExitBootServices() which is not always true.
A bootloader in between will make impossible for kernel to use any of
futures exposed this way.

But we talked about this before.

BTW, can we at least acknowledge the limitation in the commit message?

> We can phase out the protocol implementation from the firmware once we
> no longer need it, at which point the LocateProtocol() call just
> becomes a NOP (we do the same thing for UGA support, which has
> disappeared a long time ago, but we still look for the protocol in the
> EFI stub).
> 
> Once the firmware stops exposing this protocol (and ceases to accept
> memory on the OS's behalf), we can phase it out from the kernel as
> well.

It is unlikely to ever happen. In few year everybody will forget about
this conversation. Regardless of what is written in commit message.

Everything works, why bother?

> The only other potential solution I see is exposing the unaccepted
> memory as coldplugged ACPI memory objects, and implementing the accept
> calls via PRM methods. But PRM has had very little test coverage, so
> it is anybody's guess whether it works for the stable kernels that we
> need to support with this. It would also mean that the new unaccepted
> memory logic would need to be updated and cross reference these memory
> regions with EFI unaccepted memory regions and avoid claiming them
> both.

Nah. That is a lot of complexity for no particular reason.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
