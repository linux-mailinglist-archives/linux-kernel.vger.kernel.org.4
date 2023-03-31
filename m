Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D576D23E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjCaPZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:25:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8E1CBBB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:25:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EAF185C00FB;
        Fri, 31 Mar 2023 11:25:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 11:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680276312; x=
        1680362712; bh=Ipz+M2Kmii1aq11vOWdBUVAGILuh07AcP4+oS2U+sCg=; b=I
        vxjrOl0Zn3hLpOF5K381+ACFnjhOAa3HBXf+M2Z56QIAxcocyryznTNpgnmui6vx
        OOSbGMfDG8XWMDUTf47hF2fcymwqHjndrsp4DUxd9yi9KuvBzDYOhDanNHo2cEDN
        CHFiUcvOq06MR4C7oF1A5x0S0dZyriqufm5arlR/ry+5bIES/7cxFnerd6H23tzI
        nY/U/mLAc7r0dh1y+bIdwyzeyTiZXfuQqWmugFs5RYddbsimNxjGgRsnw2KC0Qv6
        egvHt1nQZCMlc5mzUc+xyaAacPIEhH5tFn4Sv+78BzLa8ifkbx7d1e/4H8fUrAL7
        Ajhv4w7NJDqTsFr3ORMEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680276312; x=1680362712; bh=Ipz+M2Kmii1aq
        11vOWdBUVAGILuh07AcP4+oS2U+sCg=; b=Yy7gHDMJYXES2yz9A0QrW53IXmHRe
        OkQXA1uL87EIHlEbqY6s0u9XSlm+hkgp7GQW1XMQ1sfJF0d/7cIXTlmFMKLNaPbX
        6ByPO2SqdpOlga7HAWOafhZ8xlbhHYaC2vTdu5eDve9WnMlq+FnnF2FXu6p/kiFQ
        IIRFswHOoTvbUPCo5n+g1v4H4oRrUpLRySzehFwffv5mFXNRZg3Cu4Xz8iSRF1kH
        3TbjEg0fUMSrnNow+S0YC+X2x7SJTFGS9V2R+5HBgWbMv1C24qYOQp9M6jeMuk64
        xCO43j1c5kKp0OS6YJM72sgVZltkMmpMpmfvElvCo0hA370PkbevGjQfQ==
X-ME-Sender: <xms:V_smZHzxVf1lXhS5LP_dvOBP9jgTTrvALkC7brofp5MDmWgxaRAJBQ>
    <xme:V_smZPRV04J-ITgwtso7YHNeTvzAJLTHcpfGSF9LJiN-o3BcLFX2Q73alLoOVYx1y
    NzPYRRENG18cBBOoYw>
X-ME-Received: <xmr:V_smZBUphV89APh36-z790-CM2cvYm_oKMq7yv2LCx9AD6zLgY5SfS72R525rEsWQDPtAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeegjeeuuddvheeuffeuuddvueetheejuddtfeei
    lefhhfffvddviefhkeefvdegudenucffohhmrghinhepmhhmihhordhhmhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhh
    uhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:V_smZBjI2qiv-g8ioWodIkb7sL3pVFB86_e0xodnufMqGgyHCPniVw>
    <xmx:V_smZJCGUPfsfsNjJ5DrUNZ043lTJKZ0ULydVePAUUbomTYa8SHWpA>
    <xmx:V_smZKJH1RNhy1K9Jeo-IWs1DUjHVVAPXC6AtVBiWr_VjEs8HijIkg>
    <xmx:WPsmZNseEl2yAeArCmp5a6CucRoqVMQZnxjAM7AYV7FePxrgQ4hBoQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 11:25:10 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4E0B010A05E; Fri, 31 Mar 2023 18:25:08 +0300 (+03)
Date:   Fri, 31 Mar 2023 18:25:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wutu.xq2@linux.alibaba.com" <wutu.xq2@linux.alibaba.com>
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Message-ID: <20230331152508.s7phgif3iozbbpqn@box>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
 <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
 <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
 <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
 <20230331140916.ofb7ecrjpg7shaav@box>
 <e9c3019f-936f-8bcc-d20f-16220993ff1c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c3019f-936f-8bcc-d20f-16220993ff1c@amd.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:33:31AM -0500, Tom Lendacky wrote:
> 
> 
> On 3/31/23 09:09, Kirill A. Shutemov wrote:
> > On Fri, Mar 31, 2023 at 08:40:30AM -0500, Tom Lendacky wrote:
> > > On 3/31/23 05:06, Kirill A. Shutemov wrote:
> > > > On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
> > > > > From: Wu Zongyong
> > > > > > Sent: 31 March 2023 03:24
> > > > > > 
> > > > > > On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
> > > > > > > On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> > > > > > > > It seems MOVSXD which opcode is 0x63 is not handled, support
> > > > > > > > to decode it in insn_decode_mmio().
> > > > > > > 
> > > > > > > Do you have a particular user in mind?
> > > > > > To be honest, I don't find a specific user which uses the MOVSXD.
> > > > > > 
> > > > > > But both Intel and AMD's instructions reference contains MOVSXD and lots
> > > > > > of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
> > > > > > may be useful to support it in insn_decode_mmio().
> > > > > > 
> > > > > > Are there some special consideration about this instruction?
> > > > > 
> > > > > It is a sign-extending memory read (32bit to 64bit).
> > > > > You pretty much never want to do that to a device register.
> > > > > Also kernel code should be using readl() (etc) which do
> > > > > unsigned reads.
> > > > > So they should never happen for mmio.
> > > > > 
> > > > > Of course, if you mmap() PCIe space directly into a program's
> > > > > address space anything might happen ...
> > > > 
> > > > There are two users of the interface: TDX and SEV. TDX doesn't allow
> > > > userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.
> > > > 
> > > > Tom?
> > > 
> > > The insn_decode_mmio() function is only called by the SEV/TDX related code
> > > and is specifically MMIO oriented. As David said, this instruction is likely
> > > not being used for that in the kernel. If we come across a case where this
> > > is used, we can look at how it is being used in that situation and it can be
> > > addressed then.
> > 
> > I was asking if SEV supports userspace MMIO. And if yes, how do you make
> > it safe?
> > 
> 
> No, SEV doesn't support userspace MMIO.

But where do you filter out userspace MMIO? AFAICS, it goes straight from
from #VC to insn_decode_mmio(). Hm?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
