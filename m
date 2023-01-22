Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B8676C36
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAVLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVLFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:05:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E311ABEB;
        Sun, 22 Jan 2023 03:05:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 208A45C003B;
        Sun, 22 Jan 2023 06:04:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 22 Jan 2023 06:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674385498; x=1674471898; bh=PIGBqayUKu
        ArKaRHZD7sCBO6FDrvE59LUQTAu0TlFio=; b=Lxhnxo7ujOLMNwhq5OGDK6ZKiL
        ghNTbYaudfk7815ZYCsm9Y8XKiRED3XjCvkKaGoOhc6hStAzvEga0xZmdKmIdkQk
        eTdcUdlj6D/6Gip2mhSxlQgikIE4PVx5pW1Bxs6amsP6rVcfJNgtgZmCf1Ucczzk
        HGa6TsBVuoBKjs6gMcSEEd5TvizRU4rIgSwqAh5Z4U8krTZM55xHrLNqAFC1jFxx
        fIpuiCj7iPve1Jg5gonO+nkTZLrj9YhAYZVaTwqGMNwUDeiN6mY6XOBMWQB2xljw
        iDxX8SgFksBLKM5kPYQctaINyRdpsDNJ9Z3iwWu71rTdRFGKQj2oB/pK1Oog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674385498; x=1674471898; bh=PIGBqayUKuArKaRHZD7sCBO6FDrv
        E59LUQTAu0TlFio=; b=mqfFVKoA8Wv1ISopmIUdhhQQTWCzmhNjBh4V0QvcSI52
        jVBJy4enEBRHiYs3E4RUFI4uSXG3Wvla1TWuNJyikr2oKpxkXKcZ8+O2y1VITn0t
        sSWihFf596BuYflkgy5PrJYKO+GSEVafTrwoyrwFR7JNMp9H2zvHIyBkfi8NXmzR
        jeTlPX4zf78x1nQy5dR1FzjdPSIEJCGqMmOW+n8rUDgTJHE5mW+gYd4yqVShrWTu
        taS3BwPSDyBwETYLTvxAy7CKQhrlGZGn1rXO+Y6wnu4v+bnv79UupEFpLFLsxP8D
        Hc+83GyL277N8Nv+HZyNn3wyU7TCjDUJx/anr66M5w==
X-ME-Sender: <xms:VxjNY36T4R5HGVjLfJYYtxqEyP2x1xgQWFlhq9kv5ZVO1jab6HlfdA>
    <xme:VxjNY84crVRmJ1FsB_mrWtWyEBdO0z94G1BzOvZGM8BWP_dz8OwZePtphyWUf_Xx8
    -tJ7B49vKTHCE_v4CM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VxjNY-ev3r7tllrk__vfVuUx_oxxs-Z3VcJ-TbGZFYn3l0cz-6D3Lg>
    <xmx:VxjNY4LbsRaaf_rI5MeI3xO06SBON4XZBQ_MJDU8jvhPNfDA9OcGoA>
    <xmx:VxjNY7IGDcm8IZxX9zZNq3WEI529JOboGOsxZTEqfwqtUmOYd_wjcA>
    <xmx:WhjNYzKNh_OdNAcQ_a_7Qa_0GJ9CByCeLG_1cpEGg4ZdkbaDjoWoGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D166BB60089; Sun, 22 Jan 2023 06:04:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <7ad668ba-d6f3-4ef9-9335-e42bfe8d4cce@app.fastmail.com>
In-Reply-To: <20230122072759.GA3703@lst.de>
References: <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
 <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
 <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
 <20230110070144.GG10289@lst.de>
 <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
 <20230113054807.GA23179@lst.de>
 <ea4cb121-97e9-4365-861a-b3635fd34721@app.fastmail.com>
 <20230121143733.GA7415@lst.de>
 <6a64b0b5-0ebc-43a5-a3d8-483a845a0b5e@app.fastmail.com>
 <20230122072759.GA3703@lst.de>
Date:   Sun, 22 Jan 2023 12:04:35 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Tsukasa OI" <research_trasio@irq.a4lg.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023, at 08:27, Christoph Hellwig wrote:
> On Sat, Jan 21, 2023 at 08:30:23PM +0100, Arnd Bergmann wrote:
>> I was thinking of using STATIC_CALL() as an optimization here, which
>> I find easier to read and understand than alternatives. One advantage
>> here is that this allows the actual cache operations to be declared
>> locally in the architecture without letting drivers call them,
>> but still update the common code to work without indirect branches.
>> 
>> The main downside is that this is currently only optimized on
>> powerpc and x86, both of which don't actually need CPU specific
>> callbacks. ARC, ARM, and MIPS on the other hand already
>> have indirect function pointers, RISC-V would likely benefit the
>> most from either alternatives or static_call, as it already
>> uses alternatives and has one implementation that is clearly
>> preferred over the others.
>
> For now I'd just keep doing direct calls into the arch code, just
> for the lower level invalidate, writeback, invalidate+writeback
> calls as that helps cementinc the logic of which of those to use
> in well documented core code.

Ok.

> And I'm not really sure I'd like to go beyond that - making it too
> easy pluggable will make people feel more comfortable doing stupid
> things here. 

I fear the bigger risk is still making the functions callable
from device driver code than it is to make the functions
globally settable.

You introduced the mips version in f8c55dc6e828 ("MIPS: use generic
dma noncoherent ops for simple noncoherent platforms"), which
was clearly meant as an implementation detail, yet we already
have a driver that slipped in with 3bdffa8ffb45 ("Input: Add
N64 controller driver") that just calls this directly rather
than using the dma-mapping interface.

On the other hand, the indirect function pointers for
per-cpu cache operations are not easily translated anyway:
with the three architectures that multiplex between
cpu specific operations, arc uses physical addresses,
mips uses virtual addresses (because of highmem), and
arm even uses both because of incompatible requirements
between l1 and l2 cache operations. arm32 also seems to
have the superset of all possible corner cases that
one might see elsewhere (prefetching vs in-order,
writethrough vs writeback, broken broadcast invalidation,
...).

> And yes, maybe that's personal because I've warned
> the RISC-V people years ago that they'll need architectural
> cache management instructions yesterday and the answer was that
> no one is going to use them on modern CPUs.  *sigh*

To be fair, from the ISA point of view, it really shouldn't
be necessary as long as you have a sane SoC design.
In practice there are always chips that are cutting corners,
or use the new CPU core as a drop-in for an existing
design. Arm SBSA tried to enforce the same thing and also
failed for pretty much the same reason.

      Arnd
