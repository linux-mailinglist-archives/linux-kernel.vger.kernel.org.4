Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17E6A4EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0WrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB0WrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:47:14 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3124129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:46:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C2322320010B;
        Mon, 27 Feb 2023 17:46:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Feb 2023 17:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677537972; x=1677624372; bh=NQTwTZeJYIKblxJmGPxa/pVizrjh
        Ti57Otr+dFUOe54=; b=l88PS1gtPyP3u9yn2nZNLPFdDPHrU+H+3P/hiz1Ozj7D
        nNEFCJvHQ1WBzzzjlUATJ3qDz3bctd7v4EO2t5/Ve9auD44z1nl/r2ZCuGJpEsRJ
        4omJXjzcvBUY03z9X6IjsVkMWEtHIYYR/+wKPEWJNPv74mgsCCPJcBljzNUkWtaV
        G7Wv97NWEUHfwpf2NN/x/rldWafJ4A2BYaC1TRWZj3YWHcaYIYUxFz8SKpICmj4Q
        jGWFixcSaOaZQ0M5Q5zh1AIdBpGGtt0VtuqS7E5dea9yASH3isT4soWwyU+m50DS
        W56L+/8AS5KT9fLlUyI+HBMWgHeX4U4cRQiaCX4WhQ==
X-ME-Sender: <xms:szL9Y-Am4uKAZFO9-z7jc-3NB7x-Sk7Fo5aKjQjIBdkXTb9wh45TcA>
    <xme:szL9Y4jprSeHfHlvwjb3Fk6p_3ch-BrVR7SGIp_mScw8TUpC7iCJYqLSRQIbryr3h
    5nRHK24uN6ogoQZ9gY>
X-ME-Received: <xmr:szL9Yxn3nFV0XUc9SRahW5cQItjO5q4L0SJ7GblUBi4_xYTv2J1iaLYjI2gmH4lcjY8Xx5M4EC2s4wTHErlEQxnYf0n1qy6kGQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:szL9Y8wXxTeEWQwStipiIxPI_ijzBIyB4q2nuKLjPy5P4CYZ3QC1zw>
    <xmx:szL9YzQuoOYWc3KN9HZykdxyRRUZRyHJoq3TjGHypujcakSOz_AQRw>
    <xmx:szL9Y3YAjUy3DFBiEmpTsRv-y_0W-OZz5VuP6A1wQeiTE2B-nEqbEQ>
    <xmx:tDL9Y9e-LLK9lmUdMwKF00NMdXdfZK1bSqR0D1mQfF7GY7QxaLIfMQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 17:46:08 -0500 (EST)
Date:   Tue, 28 Feb 2023 09:48:41 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Walsh <vk3heg@vk3heg.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Move initrd phys_to_virt handling after
 paging_init()
In-Reply-To: <dff216da09ab7a60217c3fc2147e671ae07d636f.1677528627.git.geert@linux-m68k.org>
Message-ID: <f0877485-16df-1bda-c935-5ef56afacc8d@linux-m68k.org>
References: <dff216da09ab7a60217c3fc2147e671ae07d636f.1677528627.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023, Geert Uytterhoeven wrote:

> When booting with an initial ramdisk on platforms where physical memory
> does not start at address zero (e.g. on Amiga):
> 
>     initrd: 0ef0602c - 0f800000
>     Zone ranges:
>       DMA      [mem 0x0000000008000000-0x000000f7ffffffff]
>       Normal   empty
>     Movable zone start for each node
>     Early memory node ranges
>       node   0: [mem 0x0000000008000000-0x000000000f7fffff]
>     Initmem setup node 0 [mem 0x0000000008000000-0x000000000f7fffff]
>     Unable to handle kernel access at virtual address (ptrval)
>     Oops: 00000000
>     Modules linked in:
>     PC: [<00201d3c>] memcmp+0x28/0x56
> 
> As phys_to_virt() relies on m68k_memoffset and module_fixup(), it must
> not be called before paging_init().  Hence postpone the phys_to_virt
> handling for the initial ramdisk until after calling paging_init().
> 

Thanks for debugging this issue.

> While at it, reduce #ifdef clutter by using IS_ENABLED() instead.
> 
> Fixes: 376e3fdecb0dcae2 ("m68k: Enable memtest functionality")

I apologise for the trouble caused by that patch.
