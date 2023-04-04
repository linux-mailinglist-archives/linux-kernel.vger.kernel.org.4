Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6055B6D6DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjDDUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDDUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:24:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036846BF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:24:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5B6783200952;
        Tue,  4 Apr 2023 16:24:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Apr 2023 16:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680639889; x=
        1680726289; bh=yAP5JQyaROv72dfxTuIX3EHF8NlvyOuNvEZn4uFoTG8=; b=A
        6/TRdHMk99ZtXR8iLfcdS9o3xIt4w6zMvl3VTdaRPoj/wEiJyjWp0POXIYShU1M3
        L8pT5tDCO3yllfSDsv7HAIRokO0aJP66oHG3ny1SJjLOXzHk7uzEcMERsN9gvCkO
        N1WETvPfqg+nnkKLTbGE185PeBnFqWUxkPfDhf79flbdX9nRbNAINy0+LpNAiNWn
        JJfiKGJ7v06/OhnH0qTu1aS6D8xV1d6k4QrngAE3QYKOJUj4DEW7PK+gAkgqQs45
        x4cSgdwQmRag5w+Me1Nh807IHUQgSBeAr6MW/Fh1n3EX+noXBimgl58wlsvffhKi
        N2c5A2FaWIKsb8xyYtPng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680639889; x=1680726289; bh=yAP5JQyaROv72
        dfxTuIX3EHF8NlvyOuNvEZn4uFoTG8=; b=dL43dxgRjcY/IrpJpkEs/eUTFyn+A
        syvWtGObNaz5sJZVeK9J9ep8QB9zBwdqfAY9B5rfMxVOXMRNoy/MVjFd8KojaXiD
        alI/kSsJzDiqPn103ae4OSFoB9NO8MWA89WNZTh5a008Qv+6j98FUU5dGjV/V1iu
        lvzpitTp/ErjnRaQ6D4OLyqqVWBcjd39JcURWjyu+8vfvAAwXIPnHMHywGlWYiDa
        NCvBSQFleAMxPtzIpynyA2b0WlDdmqMf62RUoFFkl9A3U6Ixqew5YE+jB+QZYR1j
        oJUnQ0EDnvg9Ynrq9WrxO8mfoUi51M3PRgDcXObthtam/hQhOjy0nPDfw==
X-ME-Sender: <xms:kIcsZJw5qTYG24tHymp6dfO8kP07lYers6kLYvTpyH6sG67EtFxoaQ>
    <xme:kIcsZJTLlfsjnCFHXgEN1j_4poIahVfBwJQlFXx7GqNmBGbi_Z_Clq3-GwR9MpvoP
    t9jx7Ulw3RHtiMgle0>
X-ME-Received: <xmr:kIcsZDX-fq-1uX7tNxZomkPsKSCdDdbcqDpSqmln-2hLDij-8xp4mBhVIet8-tw-x3u_wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:kIcsZLhGNWWdWhAPjerMsNAXwKpgb002nkMX9ZZ6-Xzb_eMbrys24w>
    <xmx:kIcsZLAwHPNtaPc9p2uXVY93iXYpDA5KpCILqVDJW1GwUCx8wEQw-g>
    <xmx:kIcsZEJ35dl-xLIq-dqVSyY-ck0kJL77vvY2syI6iNQUgUzwP1R4tQ>
    <xmx:kYcsZCU-AS6pc4-omuA2gtL1H-5ZWG2BZXVagr6h7I956xLyhJwZ1A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 16:24:47 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0CE03109AFC; Tue,  4 Apr 2023 23:24:45 +0300 (+03)
Date:   Tue, 4 Apr 2023 23:24:45 +0300
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
Message-ID: <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:49:52PM +0200, Ard Biesheuvel wrote:
> On Tue, 4 Apr 2023 at 20:09, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> > > On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > > > I still think it is a bad idea.
> > > >
> > > > As I asked before, please include my
> > > >
> > > > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > >
> > > > into the patch.
> > >
> > > I was pretty opposed to this when I first saw it too.  But, Tom and
> > > company have worn down my opposition a bit.
> > >
> > > The fact is that we have upstream kernels out there with SEV-SNP support
> > > that don't know anything about unaccepted memory.  They're either
> > > relegated to using the pre-accepted memory (4GB??) or _some_ entity
> > > needs to accept the memory.  That entity obviously can't be the kernel
> > > unless we backport unaccepted memory support.
> > >
> > > This both lets the BIOS be the page-accepting entity _and_ allows the
> > > entity to delegate that to the kernel when it needs to.
> > >
> > > As much as I want to nak this and pretend that that those existing
> > > kernel's don't exist, my powers of self-delusion do have their limits.
> > >
> > > If our AMD friends don't do this, what is their alternative?
> >
> > The alternative is coordination on the host side: VMM can load a BIOS that
> > pre-accepts all memory if the kernel is older.
> >
> 
> And how does one identify such a kernel? How does the VMM know which
> kernel the guest is going to load after it boots?

VMM has to know what it is running. Yes, it is cumbersome. But enabling
phase for a feature is often rough. It will get smoother overtime.

> > I know that it is not convenient for VMM, but it is technically possible.
> >
> > Introduce an ABI with an expiration date is much more ugly. And nobody
> > will care about the expiration date, until you will try to remove it.
> >
> 
> None of us are thrilled about this, but the simple reality is that
> there are kernels that do not understand unaccepted memory.

How is it different from any other feature the kernel is not [yet] aware
of?

Like if we boot a legacy kernel on machine with persistent memory or
memory attached over CLX, it will not see it as conventional memory.

> EFI being
> an extensible, generic, protocol based programmatic interface, the
> best way of informing the loader that a kernel does understand it is
> /not/ by adding some flag to some highly arch and OS specific header,
> but to discover a protocol and call it.
> 
> We're past arguing that a legitimate need exists for a solution to
> this problem. So what solution are you proposing?

I described the solution multiple times. You just don't like it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
