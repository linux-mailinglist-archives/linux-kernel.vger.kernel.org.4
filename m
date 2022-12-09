Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91F648A22
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLIVhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiLIVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:37:10 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096B21255
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:37:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 32E1A3200908;
        Fri,  9 Dec 2022 16:37:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 16:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670621825; x=1670708225; bh=igID9oeW3K
        Tis4A1TJRoXl5Xe0FKqlrdXnq1iT8Dp1M=; b=Bt87uZNrnGlLHI9gU0a3igmSUa
        ka0W3XoN/aoQZNHumo4WQfUkcaGtp+MQoqDhPhXydHCdtnCREmilgFq9jXBtqeAz
        l8P48Gq8/6kSzgmAfDJ6bL71C7xK6VSJeh7oQEy7pImP/X0aIg3sfhAOxS6JJJjw
        MH+OUJ679E9twxHmgcagbfx64iAWYRAQXKxfgbGQuNzOolHp6Bcc6VPDMnUo0YPD
        5NSgUBQXVSgUDXzxGJUC+0exbA/JC0kEIDdm39hsbm8pIVm1XdP9eQtfdUUPIotw
        U6CMWfX/MkAIGA4I3eZIt2++pdBMpmCzkXl++zgmr9O/ui62z+nzE683rBKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670621825; x=1670708225; bh=igID9oeW3KTis4A1TJRoXl5Xe0FK
        qlrdXnq1iT8Dp1M=; b=LBBvWYZRAx/9f45N5QsVk3n4gx/M4VKqNL1hn7aDSUrw
        TN1BdzXqBq+FP9JhznE1TlknRBb7U0syx9EcpNa6PycHqBDevJ0HE6KmFFox4KYb
        q2R8NSFJdAXVlz3sshTno2E7ulqowE578myZhMn83NL36d99G0I4mLvqTnnjcy88
        V9siP8bJGEg23m7dsiERFR6myHmLQ2eN7FEeWxBCntW2s+++r+IwT3bOejgal0XS
        ViAx2jqebsneCBUFl88OVwS8dh1B3F9Lh1XqwAr5+MPicX55wCSGKM5OnG2Dr9Xd
        he3jMn+H1grJVDslG/2qkqX37yqtKYxemIVYn56QHA==
X-ME-Sender: <xms:gKqTY44hGTa-VdL3pT_RegtrvGzgFCGPyjdTU0jf_ZihXuAmS4TbNQ>
    <xme:gKqTY575tve4M-VL3qFOAr2xKKDVJAcgBekLVOYgD_78xDDW_l82JDjMQLZ4pas3h
    lBw7Sh0eZJBuWHKPOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gKqTY3eUNPY_VcHP0cC9ebC0O2aw_jJKxtTjfKOhFktFLRlLAOVCGw>
    <xmx:gKqTY9KMXWaVuXNPgnErEldj3zaoKOXMpuei9oPVDvan-wHmBIjasA>
    <xmx:gKqTY8JlNczc315WpuWVega5QPEJgwoJ_h5NuqXnduu7GXl3DezHNQ>
    <xmx:gaqTYxGKuzJjKnT5P0vj8JVMCin-UGM_yUm3lErEN0iD4OwEXulsIQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0751B60086; Fri,  9 Dec 2022 16:37:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b050a5b5-ca13-4ae2-baa3-41a3118e5e8a@app.fastmail.com>
In-Reply-To: <Y5OCTseqVQ+AcMqm@shell.armlinux.org.uk>
References: <20221209182000.549179-1-sebastian.reichel@collabora.com>
 <Y5OCTseqVQ+AcMqm@shell.armlinux.org.uk>
Date:   Fri, 09 Dec 2022 22:36:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, "Tony Lindgren" <tony@atomide.com>,
        "Rob Herring" <robh@kernel.org>
Subject: Re: [RFC 1/1] ARM: Drop !ARCH_MULTIPLATFORM dependency from Cortex A8/9
 erratas
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022, at 19:45, Russell King (Oracle) wrote:
> On Fri, Dec 09, 2022 at 07:20:00PM +0100, Sebastian Reichel wrote:
>> All the erratas for more recent CPUs (Cortex A15/A12/A17) do not
>> require !ARCH_MULTIPLATFORM, since there is runtime detection of
>> effected CPUs in arch/arm/mm/proc-v7.S.
>> 
>> Errata config options for the older Cortex A8/A9 CPUs have the
>> !ARCH_MULTIPLATFORM dependency, but the CPUs are also runtime
>> detected. Since there is runtime detection, it should be fine
>> to enable the erratas for a multi platform kernel.
>> 
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>> For me the most likely explanation that this has not yet happened is
>> me missing an important detail, so I sent it as RFC. If you point it
>> out I will try to document the reason.
>
> IIRC, the reason these are marked with !ARCH_MULTIPLATFORM is for when
> the kernel is running in the non-secure world - the accessed registers
> may prevent platforms booting. However, it was a long time ago and I
> don't remember clearly now.

The git log confirms your memory, this is the description of
commit 62e4d357aae0 ("ARM: 7609/1: disable errata work-arounds
which access secure registers"):

    In order to support secure and non-secure platforms in multi-platform
    kernels, errata work-arounds that access secure only registers need to
    be disabled. Make all the errata options that fit in this category
    depend on !CONFIG_ARCH_MULTIPLATFORM.
    
    This will effectively remove the errata options as platforms are
    converted over to multi-platform.
    
    Signed-off-by: Rob Herring <rob.herring@calxeda.com>
    Acked-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

As far as I understand, these are all boot time chicken bits that
should already be set up by the boot loader before entering the
kernel. Sebastian, are you aware of any particular machines that
ship without the workaround code in the bootloader or in secure
world?

    Arnd
