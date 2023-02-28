Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810A6A5619
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB1Jpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjB1Jpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:45:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1952E81B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:45:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C4AC5C00D6;
        Tue, 28 Feb 2023 04:45:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Feb 2023 04:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677577514; x=1677663914; bh=LAIFPVQ3b3V1CGIuqJYt4SeAhAdB
        WyvM0W3e0hHUVfc=; b=fYJ7im/erM2dC90CAEtP0n0qFTRTGamkc73/6zDlvVxs
        bHx+Hoh1joHqNxhfE9PnwglDuh0CwrePBxOY7FOZVM1fpzq1PeWiv802n3PQ5K0I
        8R42FOqzWhjnMf7DTUgwLHcK0n52cdnwAEVW1/n4IigGatGdL/ysnaIcOfzqE5hV
        TO4Ge5WbjLtW2XE9ncF0vkLn7adRk1ZPf3OzwE38h4tAbxvKo3dvkU1Rmhb6hUmd
        JjRFTHbm9OOXdEImCkVMs9ojcs7sB5Exjt1gnv6fMs/fbwLLGplk0lse4PC+T4VG
        qp9nMpTvPqT7rmtYSlv2U7ZqRdiKN4auIoBuvZZSCw==
X-ME-Sender: <xms:Kc39YyuHi7dfzq8SqQ4bUCMYaNwHVAtKsO8EAIuZLPKSXdwL0GJYlw>
    <xme:Kc39Y3dLc68wYTetF62FFvL9Tun_mJxfBi-9GBJ0TKUDWBFno0g7212AKRgnKbpuF
    ubUK5y3LglQ0YNA1nk>
X-ME-Received: <xmr:Kc39Y9xj-AThbEX61r7Kj0NCumrAOtsgI2N_K7NNBsBFUZE__9plB0k02GM1LHJbLmvYm64FeBUO1SBg3YXhcJmeZLa8hbqNyz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Kc39Y9OYLWONhB-s6xXpPvdiQCzc8EJ1r0ix3MIFmtcP7eQaI_eWGg>
    <xmx:Kc39Yy9of0qEr4z8JjcPN9jrTDrM_hjyqeOVGyA0b0dDM_ucG7OFdQ>
    <xmx:Kc39Y1UyFH4Un0Cfsvr75ngB9_mZ9M6M7nSuY_jlHcPCtp7bJeQ7sQ>
    <xmx:Ks39Y5atzsLT5_ypXZhAknAnpgdpGc3qIm2N2K-NGEpp2laeRroOQA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 04:45:11 -0500 (EST)
Date:   Tue, 28 Feb 2023 20:47:43 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Mike Rapoport <rppt@kernel.org>, Stephen Walsh <vk3heg@vk3heg.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Move initrd phys_to_virt handling after
 paging_init()
In-Reply-To: <CAMuHMdXMWaCm7OGq7O9F5SWBxhreTppUr4K6K9FmZf1GpaAtVA@mail.gmail.com>
Message-ID: <a0d5eec7-bb5c-b719-5aa0-ee1ecd11478f@linux-m68k.org>
References: <dff216da09ab7a60217c3fc2147e671ae07d636f.1677528627.git.geert@linux-m68k.org> <f0877485-16df-1bda-c935-5ef56afacc8d@linux-m68k.org> <CAMuHMdXMWaCm7OGq7O9F5SWBxhreTppUr4K6K9FmZf1GpaAtVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Geert Uytterhoeven wrote:

> On Mon, Feb 27, 2023 at 11:46 PM Finn Thain <fthain@linux-m68k.org> wrote:
> > On Mon, 27 Feb 2023, Geert Uytterhoeven wrote:
> > > When booting with an initial ramdisk on platforms where physical memory
> > > does not start at address zero (e.g. on Amiga):
> > >
> > >     initrd: 0ef0602c - 0f800000
> > >     Zone ranges:
> > >       DMA      [mem 0x0000000008000000-0x000000f7ffffffff]
> > >       Normal   empty
> > >     Movable zone start for each node
> > >     Early memory node ranges
> > >       node   0: [mem 0x0000000008000000-0x000000000f7fffff]
> > >     Initmem setup node 0 [mem 0x0000000008000000-0x000000000f7fffff]
> > >     Unable to handle kernel access at virtual address (ptrval)
> > >     Oops: 00000000
> > >     Modules linked in:
> > >     PC: [<00201d3c>] memcmp+0x28/0x56
> > >
> > > As phys_to_virt() relies on m68k_memoffset and module_fixup(), it must
> > > not be called before paging_init().  Hence postpone the phys_to_virt
> > > handling for the initial ramdisk until after calling paging_init().
> >
> > Thanks for debugging this issue.
> 
> Np, you're welcome.
> 
> > > While at it, reduce #ifdef clutter by using IS_ENABLED() instead.
> > >
> > > Fixes: 376e3fdecb0dcae2 ("m68k: Enable memtest functionality")
> >
> > I apologise for the trouble caused by that patch.
> 
> Does that count as an Acked-by? ;-)
> 

Well, git log | grep suggested Mea-culpa-by and some others...

Acked-by: Finn Thain <fthain@linux-m68k.org>
