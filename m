Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1A6612B3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 01:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAHAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 19:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 19:08:16 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F271EEE4;
        Sat,  7 Jan 2023 16:08:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D339E5C007D;
        Sat,  7 Jan 2023 19:08:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 07 Jan 2023 19:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673136490; x=1673222890; bh=w6+aDVc5tr
        2uIs4oPoROJd4fXpjR6GDvnU6vXcUl8+E=; b=cp64SsHubAH99xcKXc31E50owr
        wlsfwwUfDFasgRONy24xanJJNwofyBrCQqq9yrDSayVGnfvqKHD8N5J8mJ1zsjMk
        m2HbIOo0QgUqKJDUoekJs0ZvySSR8ZynasP6zia1kY5qGTsWYi1JD1ipfD3GP9Q/
        FAUQ1u9x7k/Ev1jVOG80iHbowRRMSeQkdpVvp22gh5e/69eW0NBGKFYS9V6+GHFJ
        C4hHjhy/3p80AYxUb/JFgEVxtQnRx6aCTDHQoILBz/NWhFRD/ho24bBB7lHGuVx/
        chuK/pREqTqrM15AI5vS8397gk/YVLPsKflFCTO7f8NC3xOOyyAbFK9TEEQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1673136490; x=1673222890; bh=w6+aDVc5tr2uIs4oPoROJd4fXpjR
        6GDvnU6vXcUl8+E=; b=SBqtoaNdbDoKgboEpLb+w8tienE1p0Z5u9EOif9FMYLL
        gjkQ2YAh+3v8zpK2Fksde3wHXh5Hnj6Z/dv/QEVXbG01tyV3ImVYSTr4DNa5ATnR
        4mFmhWKLEnYJ3Ce8XIItTkjRrbEgm05DJMfFqkpMWIcCxz6huTNffz9sl6zevzd0
        YyjqLKJHjVSAAxySj5Ow1OnicIN3aTVy2zu26qhvSGkh5bl5ggCloCCo+SCljGQs
        XvVbEv4ZuywZrF5TgOVlOWVQvtXX5aIvGkMhPmnWscQ/xV+0+lVyWd8pbUKt+B4R
        fdHYcpY/CSFVzOTPxnrNnrdR0IUtARA+w4kHIRbeDQ==
X-ME-Sender: <xms:aQm6Y4_ryqD8BpqAQQcuSQ21_xzOSl1ISNuu3-QA49AIm0uKE17rXw>
    <xme:aQm6Ywvi0jeQJcua8t31x9QB-B-Ay11huBm5prp4LPDMi0budjHGIXW26uRhfR_z9
    xMfU-MkOxStiwCYphQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aQm6Y-B4ZB89sZ7EKIiSHGOVdE1LqS9AHBXIbnwKxJBL0XaRlU7g2g>
    <xmx:aQm6Y4cjxJXsG45Fj_Mnht2OgohcwF5K28V9PvytOe8jqG87Ale0bQ>
    <xmx:aQm6Y9MuJgu2AOYLAsn9T38V5S1zGjUSIFfNYIl7CBmBrrlLvfVO1A>
    <xmx:agm6Y4FI8JHKzIIkHWeSYWwUhqj16ZmlP57-fZ_V5jzLUc3TuxOemg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3FA10B60086; Sat,  7 Jan 2023 19:08:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
In-Reply-To: <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
Date:   Sun, 08 Jan 2023 01:07:48 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
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
        "Mayuresh Chitale" <mchitale@ventanamicro.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023, at 23:10, Lad, Prabhakar wrote:

>> > +
>> > +     memset(&thead_cmo_ops, 0x0, sizeof(thead_cmo_ops));
>> > +     if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO)) {
>> > +             thead_cmo_ops.clean_range = &thead_cmo_clean_range;
>> > +             thead_cmo_ops.inv_range = &thead_cmo_inval_range;
>> > +             thead_cmo_ops.flush_range = &thead_cmo_flush_range;
>> > +             riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
>> > +     }
>>
>> The implementation here looks reasonable, just wonder whether
>> the classification as an 'errata' makes sense. I would probably
>> consider this a 'driver' at this point, but that's just
>> a question of personal preference.
>>
> zicbom is a CPU feature that doesn't have any DT node and hence no
> driver and similarly for T-HEAD SoC.

A driver does not have to be a 'struct platform_driver' that
matches to a device node, my point was more about what to
name it, regardless of how the code is entered.

> Also the arch_setup_dma_ops()
> happens quite early before driver probing due to which we get WARN()
> messages during bootup hence I have implemented it as errata; as
> errata patching happens quite early.

But there is no more patching here, just setting the
function pointers, right?

>> > +struct riscv_cache_ops {
>> > +     void (*clean_range)(unsigned long addr, unsigned long size);
>> > +     void (*inv_range)(unsigned long addr, unsigned long size);
>> > +     void (*flush_range)(unsigned long addr, unsigned long size);
>> > +     void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
>> > +                                           enum dma_data_direction dir,
>> > +                                           enum dma_noncoherent_ops ops);
>> > +};
>>
>> I don't quite see how the fourth operation is used here.
>> Are there cache controllers that need something beyond
>> clean/inv/flush?
>>
> This is for platforms that dont follow standard cache operations (like
> done in patch 5/6) and there drivers decide on the operations
> depending on the ops and dir.

My feeling is that the set of operations that get called should
not depend on the cache controller but at best the CPU. I tried to
enumerate how zicbom and ax45 differ here, and how that compares
to other architectures:

                  zicbom      ax45,mips,arc      arm           arm64
fromdevice      clean/flush   inval/inval   inval/inval   clean/inval
todevice        clean/-       clean/-       clean/-       clean/-
bidi            flush/flush   flush/inval   clean/inval   clean/inval

So everyone does the same operation for DMA_TO_DEVICE, but
they differ in the DMA_FROM_DEVICE handling, for reasons I
don't quite see:

Your ax45 code does the same as arc and mips. arm and
arm64 skip invalidating the cache before bidi mappings,
but arm has a FIXME comment about that. arm64 does a
'clean' instead of 'inval' when mapping a fromdevice
page, which seems valid but slower than necessary.

Could the zicbom operations be changed to do the same
things as the ax45/mips/arc ones, or are there specific
details in the zicbom spec that require this?

     Arnd
