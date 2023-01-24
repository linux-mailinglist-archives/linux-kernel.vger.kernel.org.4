Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5D6795F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjAXLCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjAXLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:02:09 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945F6A6A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:02:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3DCED32002F9;
        Tue, 24 Jan 2023 06:02:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 24 Jan 2023 06:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674558122; x=1674644522; bh=fv
        SQn9Hp7y3+3Sm9NAnFutWtiCWTR4CTLoKBj1d2PQE=; b=TumIdFq+4DxVoJJcEb
        aNVjFI4cPfA0yfiPNs7vLb8ICBNns8zP49oMJiW/K8Z+rtdOO4hzZkTCKL4G1QAY
        FINDGDeKBnH2YJakTwTAilX/fcgWFzrEnVFLGYC6XwflfQl0X3aoCeyGdiynupap
        jUAbmaA5x8o7ZtwJjyh+hQBuuHaPa+t8EHmzPuUXiWZrS7jUGevROt2gJ5q1+OMS
        q60k4P1Xj/qLECG3JAwZsbvVfTWKAocfmAUTkpiP6xXSbOYQmUcgtth4F0LG9wHS
        dsJ4S76mP6VTOyrwtMmCrunQvPZ0swnfEAWRr0BlTEJmJzwIQkMjRsEk6AYsNILp
        7kKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674558122; x=1674644522; bh=fvSQn9Hp7y3+3Sm9NAnFutWtiCWT
        R4CTLoKBj1d2PQE=; b=cSUGxWOtpQOoUODjim5LeHTYyt/Y4XBg+zNJHorRTZ5S
        HQQqfiDFlbXiYby7sDIbHnKWeKTL7JvNS5T3YPghmQnF9HwA6eNDiKMP2foBD4fP
        mbOI7xCf6pG1EqzrF4COO8ag1NXhamlGdw3PMaApnbkrALTAXE5cKZJRkqgoQPLz
        f0GhBQ0cHQHwaeX6jin2Yc+Htva4iweSczDq1pL2JJh0Qbk9g8+bsO4HZ6/M1TPb
        o9A68R3mQwLqkkjEPedDEDwMHdZUsEgVdW1Pl3NsdNRnKaDkc1gwba3C0xtZsxbR
        JyJK0GXT3IipT30Bv2Z4deq4XBxK3TiX85iTHGCc0Q==
X-ME-Sender: <xms:qrrPYwv84tnLrt_yPHbQ5vMoXLFT4s4qOAe_CVLouE0GR3rsCbrohQ>
    <xme:qrrPY9dOMeAglYlVEmWD9MglNg9opcaKrg-OYoCtF1fGnMVq-D6ZiiXxeGq9mnuN8
    BXRV22_pXAtpC-0SrU>
X-ME-Received: <xmr:qrrPY7wTaNlaAB-cm9_egyyFY6s-WQuPqwyXCGYcyshtXu36eBnkmzt9A-1FqsklSUsG6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:qrrPYzO7PpEz894Sr0DH_uvZf-XAX0BUJ31yepBK88gKzPTpOZZGyA>
    <xmx:qrrPYw9LLT1Z1kTAlpEAt8KI1LCtVNZ4nph3Vj1iCzBdaRKmJtUNUw>
    <xmx:qrrPY7ULc3KWpRlB22Mw3EFVlIZcC_FG3Ijmle2nkZ5CL3_BqZbcMw>
    <xmx:qrrPYz2XCREiI_Rd2hBHQM88PLwHThPz4_CA4d0_wWeHUZbJJYVeGw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 06:02:01 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B1F4810942D; Tue, 24 Jan 2023 14:01:58 +0300 (+03)
Date:   Tue, 24 Jan 2023 14:01:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv15 00/17] Linear Address Masking enabling
Message-ID: <20230124110158.bwqu3v2evoa3ffw6@box.shutemov.name>
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:07:20PM -0800, Linus Torvalds wrote:
> On Mon, Jan 23, 2023 at 2:05 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> >
> > The capability can be used for efficient address sanitizers (ASAN)
> > implementation and for optimizations in JITs and virtual machines.
> >
> > The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> > this time.
> 
> I didn't react to anything objectionable in the series.
> 
> My only reaction was actually to ask "when / what CPU cores are
> expected to support this feature"?
> 
> Maybe it was mentioned somewhere, and I'm just blind and not finding
> it.  But even the "Instruction Set Extensions and Future Features"
> paper seems to just be talking about the CPUID bits, not about any
> actual "this is when we expect it".

There's no announced CPUs that have the feature. And it is above my pay
grade to disclose anything beyond that.

But there's QEMU patch[1] if you want to play with the feature. The patch
is not upstreamable, but it works.

[1] https://lore.kernel.org/qemu-devel/20220407010107.34734-1-kirill.shutemov@linux.intel.com/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
