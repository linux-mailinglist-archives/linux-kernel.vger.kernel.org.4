Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBD5E786E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIWKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIWKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:32:18 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973412DEF2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:32:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2479F5809F0;
        Fri, 23 Sep 2022 06:32:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 06:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663929121; x=1663932721; bh=b5154p7+jw
        vVybTnV4XOC9aGotedUG0z1MsOq616Jbc=; b=k9bU0VORHmBJt7KPkKuBBTcZbY
        QA3kx10eWTFiwOmyoiCict9Dfk8o5uCUg3qg7VM9DFh2a5TbY1E/NMEcKfPsdZSc
        08hCSuiKnQSk2mlMKlCGY5V0cha/KM7i2u0FUL0hF2m39ZtESjfsw+Zk1GNUrGrD
        jGE8C5uaoADfLqRHFvjS0VvsNVu5nnfluIAVulHvjiPi1L8sQYmBpM2OXHANpbRu
        8qOBZJa5apfuB9HCwldF0TIz7aqYTg+9622/pHrPAtz1CjI/vG5o+emrNHB8srKk
        /EXqM/UzPPHcN0/3eLkCgry15A/ir2thuq9O7VKJA1g3YFnFmMU9T2aFuZjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663929121; x=1663932721; bh=b5154p7+jwvVybTnV4XOC9aGoted
        UG0z1MsOq616Jbc=; b=qtSqNLuwmRHY/7d2tD6A/zls1b51QbKDVrSpnj6LgJLJ
        yP6nPJ/bX37TyqwR/wUTqnO/WyV2lUOfe2JBYFJ4EV3kbY3bFCJH1dGVe0ylHbQD
        ZrETuI+61q9GeOlw6Y3ApLS6GZozoqkfezwgEj/RIzQzlSdtZSt+27vIrjIUncK3
        d3uji0RhRhRWiCo15BDKaRajgPoLofpKA6+JaHEzxK91RDoZYb0Rj3aER/xNwKWj
        r+mpfny7tZge0bCtyZLAoqEIq81WUoZNnlKEQP2M9p+ggckJi7YQBsasKbErDimC
        hx5jp1RBqh0zXgqJm3eBzXoeY0KKRCxO2hJblzYG4g==
X-ME-Sender: <xms:IIstY9sUvlU4LGEpHsO60t2j8bzIvfpizt1gpZrADxlA0boeu5IDdg>
    <xme:IIstY2e_hbRomLaiU1bsskRfqAB_Tm72UXf0JGxa-DPal27UefIwcglLK4DXf4ubl
    X5j-ZkcGs6WLLehi6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IIstYwxhPcMuGUXW7qVJXYJBn9sNAleJfrZ12mF9H_V6LE325F7Ojw>
    <xmx:IIstY0OGRmpCtguIu2St8OksJBodX7te27iq3KpW0ZDPwoE2AuMx3A>
    <xmx:IIstY98gr7gKPJOmpGam0XIWZ1ok448ttmYLpTz3WMaXBN64FQs_4w>
    <xmx:IYstY4beCZaACWxKPqm4oAXvgDG_RyzWzkuq7z9gO5m13ZcaiNU4tA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 851E9B60086; Fri, 23 Sep 2022 06:32:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <c4ee195a-cf1f-44f6-b3b6-241d04e01fb9@www.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk>
Date:   Fri, 23 Sep 2022 12:31:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Make port I/O string accessors actually work
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 11:56 PM, Maciej W. Rozycki wrote:
> Fix port I/O string accessors such as `insb', `outsb', etc. which use 
> the physical PCI port I/O address rather than the corresponding memory 
> mapping to get at the requested location, which in turn breaks at least 
> accesses made by our parport driver to a PCIe parallel port such as:
>
> PCI parallel port detected: 1415:c118, I/O at 0x1000(0x1008), IRQ 20
> parport0: PC-style at 0x1000 (0x1008), irq 20, using FIFO 
> [PCSPP,TRISTATE,COMPAT,EPP,ECP]

The patch looks correct to me, but I'm curious: Are you actually
using a parport device on your system, or just testing it to
make it work?

> +#define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), 
> buffer, count)
> +#define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), 
> buffer, count)
> +#define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), 
> buffer, count)
> 

I don't see anything actually risc-v specific in these definitions,
and it would be great to make the asm-generic version do the
right thing here. As far as I can tell, the only difference is
the barriers in the risc-v version, and we should really have the
same in the generic code anyway.

     Arnd
