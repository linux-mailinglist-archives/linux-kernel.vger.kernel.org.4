Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7516D220E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCaOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCaOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:09:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BD1D2E9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:09:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A6385C0134;
        Fri, 31 Mar 2023 10:09:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680271761; x=
        1680358161; bh=EaVflyvFJJS8OV3iRBiACwzm3hra/ZJRlkep6hNK0bk=; b=j
        pCOwpMi1UI56UEDD2hHgaG2SYy+bY77qUFLjTwp5rZXyaPqE+5WGBTSOp+TZzasy
        2NgXs8BMQFVGKKhGUOTUY3NZNF8ExGUU6kAWnzGz5v0ZDLib6j2/Z81fVxo5qw3q
        n5G5uJ/sPeik3HBOYJDRhZmsCmrXphwPQyd8WctGTeG+CUS1VGanKGpPKns1bTO+
        TTLt6x+VfmYAv7A3CEESSqghwPcI8PvUnloXFhoC2cLQS2rZzCQwA1dUC4lJU7tv
        iHZhyub4AgRXOYsYwwg2lZ3mn+9e55lZAuJ4iiTTjQOjIh0KzSZJerNjGVLnViEu
        6KUWNp0huV52oQGRbVr2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680271761; x=1680358161; bh=EaVflyvFJJS8O
        V3iRBiACwzm3hra/ZJRlkep6hNK0bk=; b=nnLMo5YyWHcMpqmVJGgD0lUQ55z9x
        KB6SjTTAqXqR4ULVDUnPozkGk41jRwyxOejIA0UQvC1u5x82g84G/vtpssLxbLhK
        +3RqarJdcBECY/s8wP1LLBdyRcQpeWUlCwlG7sS0V6k94tqtL31Axx7ifvkElTci
        p5VqZGsuc1DQWXm0Zz3AkRUlCmaJkC/ry0MDzU7bAjIWDFysLSXJiCld3aaKNDBb
        g/0RqdfqigWzUnp53s5UYulkDydMtKeHkdIMDObT45Q6xY5pEemZ9SvG37m8PRNZ
        loYh+r6b3qo2mImH+ADT047+1ZP8iTdOQmhEsgV0Y/Y9YlyGgNQFXKnpw==
X-ME-Sender: <xms:kOkmZPiMuOlV5aNAmA7dWjohWcp73zCNLdLz3j0i1qVts5UJwHxYpQ>
    <xme:kOkmZMDx0J67K-2fDcqZMwtH_g-iRj4AJzgDrzX4RGLjvE1B82ihtPnsbsTs7BRyv
    QfDD7tN_rHBPy9cVTo>
X-ME-Received: <xmr:kOkmZPHGiaxq4pL3yK9RLjxvh5VAwgcO2UgRVK08VZzWfTQRrfPH8dbLzYgkD1poyyetyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:kOkmZMSmdegpVP-lUH6V9z5lgfYALUaIP7Kdi45MjDZzYQ0N2kgJ7A>
    <xmx:kOkmZMzd356S80SE6boCGW2LlQlnp39v0rKcaVfDmbqaLglu9u-mAQ>
    <xmx:kOkmZC5Ujacwz3XOk7adi9MrdYDxjAY8EumqLLZgTwXveL3de9ORQQ>
    <xmx:kekmZIcAEh8A69vKa7e9k-yS588bwaf6O4DvOHOx5bh2SzwLUFvMzw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 10:09:19 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F156F10A05E; Fri, 31 Mar 2023 17:09:16 +0300 (+03)
Date:   Fri, 31 Mar 2023 17:09:16 +0300
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
Message-ID: <20230331140916.ofb7ecrjpg7shaav@box>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
 <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
 <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
 <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:40:30AM -0500, Tom Lendacky wrote:
> On 3/31/23 05:06, Kirill A. Shutemov wrote:
> > On Fri, Mar 31, 2023 at 08:49:48AM +0000, David Laight wrote:
> > > From: Wu Zongyong
> > > > Sent: 31 March 2023 03:24
> > > > 
> > > > On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
> > > > > On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> > > > > > It seems MOVSXD which opcode is 0x63 is not handled, support
> > > > > > to decode it in insn_decode_mmio().
> > > > > 
> > > > > Do you have a particular user in mind?
> > > > To be honest, I don't find a specific user which uses the MOVSXD.
> > > > 
> > > > But both Intel and AMD's instructions reference contains MOVSXD and lots
> > > > of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
> > > > may be useful to support it in insn_decode_mmio().
> > > > 
> > > > Are there some special consideration about this instruction?
> > > 
> > > It is a sign-extending memory read (32bit to 64bit).
> > > You pretty much never want to do that to a device register.
> > > Also kernel code should be using readl() (etc) which do
> > > unsigned reads.
> > > So they should never happen for mmio.
> > > 
> > > Of course, if you mmap() PCIe space directly into a program's
> > > address space anything might happen ...
> > 
> > There are two users of the interface: TDX and SEV. TDX doesn't allow
> > userspace MMIO. SEV *seems* allows it, but I am not sure how it is safe.
> > 
> > Tom?
> 
> The insn_decode_mmio() function is only called by the SEV/TDX related code
> and is specifically MMIO oriented. As David said, this instruction is likely
> not being used for that in the kernel. If we come across a case where this
> is used, we can look at how it is being used in that situation and it can be
> addressed then.

I was asking if SEV supports userspace MMIO. And if yes, how do you make
it safe?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
