Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF845B360E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiIILJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIILJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:09:31 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743BB62E1;
        Fri,  9 Sep 2022 04:09:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 1486F2B059B1;
        Fri,  9 Sep 2022 07:09:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 07:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662721765; x=1662725365; bh=wqSZnyFI/c
        l/mPByp5iGdJ8icj1uq3tpAsMYxesXc90=; b=JNCUOHygKHzw5ymEwgIx150ccZ
        kk3QcAxPZ+kBSPmdW6jFGXpxAjxmEeG0M6d57nMRbAoHaCqHoE+FBWHfNpOeLwBs
        /mPuqtbvd/1IPDbHrQuUxW5yCDGLAoB2om5QEevKLcUZVQYafKN1g6jZbmhwHLOu
        0HRA6C+WddeqcV+7yTAaDTKC7uE2YRZYNsPxH2KSdrzIovQgodn9vw1xR87nCG+W
        KPYRz8ti9cnn/qzN8glQRQibQH2l1HmUfIA2qVa5UgrX/L1qAkJdpn9gAKjxC3Ks
        SIdQUbZKUYYQjMI+lOUwNGQgo3vZPc4FYLNL3mkZQP6Adk+Ua83PVyjTJQyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662721765; x=1662725365; bh=wqSZnyFI/cl/mPByp5iGdJ8icj1u
        q3tpAsMYxesXc90=; b=NcnoBpow2qM+ovsG2uQ1UBwQb5Coksk8+GOfbMClmXg0
        FljMyHsOsV/d4c2jkdzcmMrS2dB9O4m2MafmQaN7+qU8HuJK7d2K++DLiICuLM2y
        AjcE4yKVEsPIlL52TJa57qkn2k9qeBsuhvHX5alkWuvvcLRv0wOUjJzb8d836EGo
        F/KD5NIL8QMwpvF5G6UbyM0UHVuQPX7ZmSljDoIFpGPeaKEsv8wxuVziYA/Mq6AL
        AUzrsvFBNWDvi84l76doHdoBRON5BMvjWLQKymPY0D6dPOHzwqS91ZBhGP94gs+3
        yWnpDzgYO8/dcTsXF9pcTpg4Ajh7Ere3cJRjMUriXA==
X-ME-Sender: <xms:5R4bY4GaqDmt3X-LJ-uV8Zcyr7ZBZR-NmmXwK3Kgf75UWFViN9SQ3g>
    <xme:5R4bYxXLe5wUEH8ByBurgfVYAMPzogSUu2s6bS8sgxCTXaY0NKVYElWrRz4Vw1bco
    W8mW2HX1LXeLyrxkTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5R4bYyKu5j3kSAt9BrZFBOj8MBqapEHrpfOZjwAiyNhZaKRGdpro4g>
    <xmx:5R4bY6Ec5uNpaboa5u0lOfhinRTwp9OIPIF7MMPIYGNvn2WkJnk6VA>
    <xmx:5R4bY-WaYgUrlM9_vLjYf5DX1sz3ev5uymLjtLvtFVpsaTXoPZPTDQ>
    <xmx:5R4bYwKi5QKMiJ_n2x8PmIi78ZHDXfR-pJPa3AoM33UYbxvq50eFoaVECX8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E194B60086; Fri,  9 Sep 2022 07:09:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
In-Reply-To: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
Date:   Fri, 09 Sep 2022 13:09:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of creating a
 PPC dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022, at 11:03 AM, Lukas Bulwahn wrote:
> Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
> PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
> that all architectures simply select this config when the architecture
> supports using the PATA_PLATFORM driver.
>
> This is properly implemented already for all architectures except for the
> powerpc architecture. Implement this for powerpc now.
>
> Adjust the config of the powerpc architecture to use the config
> HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
> any specific architecture anymore.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/ata/Kconfig  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 39d71d7701bd..2575e21b6e6b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -237,6 +237,7 @@ config PPC
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
>  	select HAVE_OPTPROBES
> +	select HAVE_PATA_PLATFORM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_EVENTS_NMI		if PPC64
>  	select HAVE_PERF_REGS

I don't see a single powerpc machine that creates a
 name="pata_platform" platform_device. I suspect this was
only needed bwfore 2007 commit 9cd55be4d223 ("[POWERPC] pasemi:
Move electra-ide to pata_of_platform"), so the "|| PPC"
bit should just get removed without adding the HAVE_PATA_PLATFORM
bit.

       Arnd
