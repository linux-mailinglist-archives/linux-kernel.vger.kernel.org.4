Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BC697A82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjBOLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjBOLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:15:44 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B722A24;
        Wed, 15 Feb 2023 03:15:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C1D5D3200920;
        Wed, 15 Feb 2023 06:15:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 06:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676459741; x=1676546141; bh=NuTkQV0e8+
        yxV4WjDL8EFdkun0PggnWdbE3vS2mdeYk=; b=XSQ10jBGCyy//uwDjFC0Af9Axu
        AhV55yyc1rb3YGN2KCuZRPdfdM7C56ikjcrbH7nQrMdCEBLTmTGW9knrk+yi/6gT
        Lq+WX7D/PnEM1R954rURuYNt6iQYyi289UbDOqFFZ/LxCOE7FY2FGWxFK0Yty4dc
        yK5Dsf88bqItGj0BxkzvtdpPB0DvBsSBcRM+uUDE5VrlVxiqnOvJQ8MXPCZsIULV
        nitU51TUjUfvq4nHg+Zc0o/ciGEFzqIcggNKU/wbfaUfwx9hYWmNqJqWK8yqeIfq
        xry3g4fWzYi6t3FXSErSYSKxRw2psZXEnXUG/Eu2obIr/gn0mEjII6L1GpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676459741; x=1676546141; bh=NuTkQV0e8+yxV4WjDL8EFdkun0Pg
        gnWdbE3vS2mdeYk=; b=CQ1BkJfp36FTrZsKmBGmunUXkxkeDU2Xb58+DjHfPYdX
        SdgrsKHRXFXUkVgBvinH+cKmQPcajuI74nTEpPmqnU8EU/oGiH7a0AircFd45CFn
        8tfA287xkK/mXctXW0Bi2d0IqVWae5vmevh6yBqaQpxxNAh8wUiQfxZDbEfqbr8P
        JB90yqpiGBwtkelXe9hTYAxI39/CPcn6UaAGvO8k3y/hjeUfInEwOsTv6+eSfP2D
        ZzTLCCockkZ6ZlwDdPrjlEgmAAR5uTQfgk/nLkehM489wF96PZEx5xcfp8RIHkkC
        Cfgwj/t8GsF0THeA5j8SM1StBVqY6/HgA3kwAMcSRw==
X-ME-Sender: <xms:3L7sYzok_-KkiOdF3XqAhdEqApT_-bfb5bLDBJuA9JQoSLvLbcb4Gw>
    <xme:3L7sY9qknNqvrT9fYABQmOeKj0BVIFwMT_38UUU0vSoVtiSttFY1Z3Evu3nbHVuc6
    rGdOodVcFckeTIUglI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3L7sYwNlJs28QGNv6n3bf7a6kFlNxxicStNugRHWrcVukjpcBhAPAw>
    <xmx:3L7sY24gwdXwJf0bW655SgYHjk7daJnbxtiaDt1tGOzd7MwhW1orHw>
    <xmx:3L7sYy5nCQzPBpYOLoamZnTiLcuq_S0LMOCRRZVFP8oo-ZMqgjZCnA>
    <xmx:3b7sY0uUlIDoEofP4QVJJ2sr9YeogJubwIYqsXVsYl0R6DXnZwyWnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D112FB60086; Wed, 15 Feb 2023 06:15:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <62e7ab37-1148-4cf1-8d6a-3da440fa623f@app.fastmail.com>
In-Reply-To: <ea12dd12-db17-44a8-8c29-6b0a129f355d@app.fastmail.com>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <20230215100008.2565237-3-ardb@kernel.org>
 <ea12dd12-db17-44a8-8c29-6b0a129f355d@app.fastmail.com>
Date:   Wed, 15 Feb 2023 12:13:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ard Biesheuvel" <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] kernel: Drop IA64 support from sig_fault handlers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 11:19, Arnd Bergmann wrote:
>
> I can probably do the same recursive check for removed Kconfig
> options that I used for finding dead code after the boardfile
> removal.

FWIW, here is the list from a bit of scripting. Symbols that
are only defined in arch/ia64 but are referenced elsewhere are:

CONFIG_IA64
CONFIG_IA64_PAGE_SIZE_64KB
CONFIG_IA64_SGI_UV
CONFIG_IA64_DEBUG_CMPXCHG
CONFIG_MSPEC

Kconfig symbols that are only selected in arch/ia64 but
defined elsewhere are

CONFIG_ARCH_HAS_DMA_MARK_CLEAN
CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
CONFIG_ARCH_TASK_STRUCT_ON_STACK
CONFIG_ARCH_THREAD_STACK_ALLOCATOR
CONFIG_GENERIC_IRQ_LEGACY

plus a few that have only one or two other places selecting them:

CONFIG_ARCH_CLOCKSOURCE_DATA (sparc64)
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC (x86)
CONFIG_ATA_NONSTANDARD (powerpc-maple)
CONFIG_FUNCTION_ALIGNMENT_32B (i386)
CONFIG_HUGETLB_PAGE_SIZE_VARIABLE (powerpc64)
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT (x86, loongarch)
CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS (arm64, arch/um 32-bit)
CONFIG_HAVE_FUNCTION_DESCRIPTORS (ppc64be, parisc64)
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (parisc, x86)
CONFIG_HAVE_VIRT_CPU_ACCOUNTING (powerpc, s390)
CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN (arc, loongarch)

      Arnd
