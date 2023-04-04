Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB776D6B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjDDSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjDDSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:09:25 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C417FB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:09:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AC3073200A5A;
        Tue,  4 Apr 2023 14:09:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Apr 2023 14:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680631762; x=
        1680718162; bh=DPiGXZr79qdt9px8j10lq9M2tfr42mD5cB8K58kjvgc=; b=i
        u/eZA7JQzjYq1JpF2tlwz8MvDXq+wUJSG5JjW8AwKWhIq7Ff8Qq/hfvzz3cDtlhL
        qPK1hO889McgRjYc3OQ56pNvAzNV1hmS3+h/53RU2MGs1Kwj3liEBYs5D0tjLA7f
        1logVLlQHwHxm4kTBKIn6Y2vN7FDStvoBD9eLz5F+XswDnSAfP4deqbMhgybXc/T
        XuJVxdoyzIdRGepLUkSJNOAdxRZ+xW+h8AtT/k1r2RejViRJfmw/sUyRIaIxh119
        jH1KEKX6OTDG90JUcCn6b16mMMt8MHmjUS6zLHAy1jeoYfLSQCZezpvPVTDxibll
        nf0ZP9fju3Sg5tzUumpGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680631762; x=1680718162; bh=DPiGXZr79qdt9
        px8j10lq9M2tfr42mD5cB8K58kjvgc=; b=GXRPYbkpZuwI6kzrJXsXMAwonBPZh
        P9McVMivfu49B+HOl5z1kJfqeLQ1MEHtikyArRllufRJ13M4K0zcaOc3g3lvsXuU
        OpsAew0PYOXtzFycn4x2fx+CFixfKiKEsjsH+Vs7wGeh9Mro6dsO4F4kG9BaHnC9
        hPN1Lvjmg5QUxujchiV5itpf2e9FVyKT7aU9KWojBD85IyAuYRXLeN9BTjr6c2jn
        VIMyIZyU6p02cQPP5Vp/6Kth23xPY1yDgCCY4mF78eLfKar7TupQlLZl0uIO7nn0
        0cmvqPQ/v1+t7mXbNIxRZdrx/Ny2AMveSbJvAsYu2+SHhc56q75FGXDSA==
X-ME-Sender: <xms:0WcsZGDzZ-vkOiIKBPTw_xAla5RCqUvXfy3krjRhCaF9BgDH6Ob6JQ>
    <xme:0WcsZAj8YISREeG0m9ka-_fDq1FjxJyHDsxCwcyQQ-8hUHmibWfJNQVBd0OuKcZIU
    InwxS-B90HPG6gIQ3A>
X-ME-Received: <xmr:0WcsZJnXer4b4-GRYY3pEE5z-UVWcmH5BcSnanSd4x9lGdN-Fgv3VruGx9j2rJ729-kCcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:0WcsZEyu8CurV2uJ6QRw2KDM7PpJZIu6VC74Gdzm3auUw-QNCXClUg>
    <xmx:0WcsZLRCZsRPSwwC8hJC6IzLbTyC25Vz2S9ArTKSP_3Qc3YrT8h1aQ>
    <xmx:0WcsZPa6TpabB6d79iyjMskXo9eyXDUq1uQbS3PvDFu-BpbM2P6RTg>
    <xmx:0mcsZFm54eoz1klHfJy5IiVCwFYf-0b7VoEMNNgofzuQBcm0iNPgTQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 14:09:20 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4C2AE10C775; Tue,  4 Apr 2023 21:09:17 +0300 (+03)
Date:   Tue, 4 Apr 2023 21:09:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:57:52AM -0700, Dave Hansen wrote:
> On 4/4/23 10:45, Kirill A. Shutemov wrote:
> > I still think it is a bad idea.
> > 
> > As I asked before, please include my
> > 
> > Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > into the patch.
> 
> I was pretty opposed to this when I first saw it too.  But, Tom and
> company have worn down my opposition a bit.
> 
> The fact is that we have upstream kernels out there with SEV-SNP support
> that don't know anything about unaccepted memory.  They're either
> relegated to using the pre-accepted memory (4GB??) or _some_ entity
> needs to accept the memory.  That entity obviously can't be the kernel
> unless we backport unaccepted memory support.
> 
> This both lets the BIOS be the page-accepting entity _and_ allows the
> entity to delegate that to the kernel when it needs to.
> 
> As much as I want to nak this and pretend that that those existing
> kernel's don't exist, my powers of self-delusion do have their limits.
> 
> If our AMD friends don't do this, what is their alternative?

The alternative is coordination on the host side: VMM can load a BIOS that
pre-accepts all memory if the kernel is older.

I know that it is not convenient for VMM, but it is technically possible.

Introduce an ABI with an expiration date is much more ugly. And nobody
will care about the expiration date, until you will try to remove it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
