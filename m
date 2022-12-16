Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA464F218
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiLPUEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLPUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:04:47 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA6E2E9EC;
        Fri, 16 Dec 2022 12:04:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EF755C006B;
        Fri, 16 Dec 2022 15:04:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 15:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671221082; x=1671307482; bh=O1rTibXsTD
        pKm1zwzgUrVX4eUO+lIv2U3Oy/pW2+Uvc=; b=kIOyZ7VcxLykcDYk6fmZlffUP0
        eq/C9CPSKulkOh7M4ACXPIGmhCGjBuffTTBPo0zaH7i4/VgE2Kp3x2QMwVQXCwgE
        8xSRy4dVQ5TL94+OhCAiFhuZrZnDGot2bFVg2m+ZGOk4gON7zKa8NB9sthJZzTdf
        4RZd0ZMZHFhREBQp9HudhBfSS8qSyjNL6C536YsVm41C0YzFRDzlzreybEX6+asD
        s+dLCINbGwBwv6p61SbitoWiiYaUo1c07UEe0Ib0YWWMeOf+E4LFTqiaNLm1HKZV
        FWKfHenFTjx9zI4YGD9e5CXupIIY35I+eUtbVzZHa2TfdqW8cCgHSC9HmxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671221082; x=1671307482; bh=O1rTibXsTDpKm1zwzgUrVX4eUO+l
        Iv2U3Oy/pW2+Uvc=; b=ECzPE/sRKsp+dG/HXK2fj9a5OjOT7apv6OkOg9HBdRKA
        QneB5lTYdtF3FKJXeSFXUNpow71RXR16v/YbBqkDq+3TH6FsYjewTOMxouPRxXfj
        nwnrXhZOEUlBiiPPbHSf4xmtsZNpy+hO5lu+872yPJVQxm/XTmMyB5NjwbsCg5Pr
        MmVL+iuHqssCz6qcnE9+/Avwn9XLOLW4rHKhz8x8sRQ+tefLtkPWPFZi3JQ4mQ+G
        f4l1BGL/FE6Bnkdg66KN6og7yeTM4weCsmzNr797uQgnyWRi2N/QBHHrQ8oVrh7F
        fKV2dIJXJeyxtlTMu7GE8AhxMVKqbWsIxvPEb5oNyw==
X-ME-Sender: <xms:WM-cYxzH1pECrTmU6XvKg7k8j2ay6GglsO1atwuXwxmYoxet6IDLVg>
    <xme:WM-cYxQLHC1r8btyqYSA58WDofl98UfPJdFNh90ljfGJBMREPXTBnO_b_9yrWNvDZ
    OM8hh7sfhB6gXgsGr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WM-cY7UHteybQrjytPJtkZA_vwiE9pzAnKQWkn13IR6MC7puFPCWVg>
    <xmx:WM-cYzhSwMPsxdNCNhcfkFAjy0JTsgxQzXw-Mly99qC-ntnOQrtd4A>
    <xmx:WM-cYzAWpbr6NmAUwADExpdfVO_pgv-F_FHki4ELlCeoxrjjN_6Wqg>
    <xmx:Ws-cY1zoSqh0WKzVatpi0rYh11AiO4ydNwr7O9CPoU9ZMHEmtQD25w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 943F7B60086; Fri, 16 Dec 2022 15:04:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <32cf0901-a4a0-48a7-bf42-f2cdb34d1ee7@app.fastmail.com>
In-Reply-To: <mhng-8b05b6cd-d8a1-4302-af24-2f64a4bf7c32@palmer-ri-x1c9a>
References: <mhng-8b05b6cd-d8a1-4302-af24-2f64a4bf7c32@palmer-ri-x1c9a>
Date:   Fri, 16 Dec 2022 21:04:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     linux-riscv@lists.infradead.org
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>, soc@kernel.org,
        "Conor Dooley" <conor@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Samuel Holland" <samuel@sholland.org>, guoren <guoren@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022, at 17:32, Palmer Dabbelt wrote:
> On Thu, 15 Dec 2022 23:02:58 PST (-0800), Christoph Hellwig wrote:
>> On Thu, Dec 15, 2022 at 01:40:30PM -0800, Palmer Dabbelt wrote:
>>> Given that we already moved the SiFive one out it seems sane to just start
>>> with the rest in drivers/soc/$VENDOR.  Looks like it was Christoph's idea to
>>> do the move, so I'm adding him in case he's got an opinion (and also the SOC
>>> alias, as that seems generally relevant).
>>
>> Well, it isn't an integral architecture feature, so it doesn't really
>> beloing into arch.  Even the irqchip and timer drivers that are more
>> less architectural are in drivers/ as they aren't really core
>> architecture code.
>
> That makes sense to me, it just looks like the SiFive ccache is the only 
> one that's in drivers/soc/$VENDOR, the rest are in arch.  It looks like 
> mostly older ports that have vendor-specific cache files in arch (ie, 
> arm has it but arm64 doesn't).  Maybe that's just because the newer 
> architectures sorted out standard ISA interfaces for these and thus 
> don't need the vendor-specific bits?  I think we're likely to end up 
> with quite a few of these vendor-specific cache management schemes on 
> RISC-V.
>
> I'm always happy to keep stuff out of arch/riscv, though.  So maybe we 
> just buck the trend here and stick to drivers/soc/$VENDOR like we did 
> for the first one?

I don't particularly like drivers/soc/ to become more of a dumping
ground for random drivers. If there are several SoCs that have the
same requirement to do a particular thing, the logical step would
be to put them into a proper subsystem, with a well-defined interface
to dma-mapping and virtualization frameworks.

The other things we have in drivers/soc/ are usually either
soc_device drivers for identifying the system, or they export
interfaces used by soc specific drivers.

     Arnd
