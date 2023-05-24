Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A870F6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjEXMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEXMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:42:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626499E;
        Wed, 24 May 2023 05:42:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 953615C0115;
        Wed, 24 May 2023 08:42:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684932139; x=1685018539; bh=SF
        9JtV1APOsCbo27SIShQg4r+s7H+woBcWqX/y1Cbdo=; b=MPX0qIkeYUH3javcr4
        0T277eOhoLBvj5MGKRxXJIC40iN498Ia5AEtM3WBjzb1WA//1gxTFLvbdzApnw7d
        mRmcww6BJ2kmp/5HJfmi5V4VysoKZQOQkduOe+RT0ZKgAdsPnVCxGzDjaXcltVRP
        Iv+J8G/pSOpZTBJQ09PZE4pJTOw3Nh5GEPZrwK/x/Ji10UYampQOuumbfogMXTUH
        BbjRfAhyCvPbyU4JjPuLGMyu3OPs1L/XS7wah/8I1MneV0Xihice76gYF3MHnj17
        kEbKC9cjnMLJOI4wYLRWJ1K09hbY+kD4RR0+VStyUxM9S84S9sTGxPguFxt9+Gbq
        qMNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684932139; x=1685018539; bh=SF9JtV1APOsCb
        o27SIShQg4r+s7H+woBcWqX/y1Cbdo=; b=GEkYChRQYQjJZWyxPqzR0Gap0m3Ek
        P7uW5ACiQUPHjYZDN4BpnBHUTrx7LYVvnG/j/LnSMLu+n0cyjxlE9l3SWzyVmo0G
        cOO/pu0PAK7dFF1oluUJf7om+KUHjXFA1RwMFBLO/987q4+KdSdTVh+zXLAaGnnL
        iJjjqbG/EdcW3dosu6RlHPFvhjGLP5CGyYZRL2IA6idCHY62WLZeSbh4Iecm2svE
        bREMasYi5OCbVTZVDm2tFhj3YN6fA6zJ8wrJXzDXBXZ9iehzwyFpeaP6IPzR3EB8
        FOy3nRGEsEivNdxP2t+t3c5ya8XNnfKkJd9UlJssaPkyl6EnEcYi8WmqA==
X-ME-Sender: <xms:KQZuZGMDoRzsCX5aXsO-r725SY22BCoE8ATFudZ5DaJl7wynb3wZug>
    <xme:KQZuZE9_0xo0I4cJQiDdiw7TV9eLSIZnClXcQc-2S0YyZ1Bij6-jPvsGXyaCAKCe4
    5gv8zmxl2ZL5lVcuSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:KQZuZNSGokaxVGygwsbDOfBz_Bd3L9-Y3iQ4XDMxmb0N4YD9pmee2A>
    <xmx:KQZuZGtMqYDh5AwRAR7d7K03DN2KXEekKnKZMl4ThXvdwkiSH52fNg>
    <xmx:KQZuZOdvpVskFAY9an0bL1TPZKC9C3k13ZZDda7j9dBcyhc5qY_6aQ>
    <xmx:KwZuZOAXpeVP7LyUAtIRRQ1eqAR8Cew46tqPn6kSCUE2DV6S9PP5uA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 64F50B60086; Wed, 24 May 2023 08:42:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <787582a3-51a1-494e-bfd0-b51d1117432e@app.fastmail.com>
In-Reply-To: <20230523221132.64464-1-blarson@amd.com>
References: <bc5118f2-8982-46ff-bc75-d0c71475e909@app.fastmail.com>
 <20230523221132.64464-1-blarson@amd.com>
Date:   Wed, 24 May 2023 14:41:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <blarson@amd.com>
Cc:     "Adrian Hunter" <adrian.hunter@intel.com>, alcooperx@gmail.com,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "David Gow" <davidgow@google.com>, devicetree@vger.kernel.org,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Greg Ungerer" <gerg@linux-m68k.org>, gsomlo@gmail.com,
        "Hal Feng" <hal.feng@starfivetech.com>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Joel Stanley" <joel@jms.id.au>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Lee Jones" <lee.jones@linaro.org>, "Lee Jones" <lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Walker Chen" <walker.chen@starfivetech.com>,
        "Will Deacon" <will@kernel.org>, "Yinbo Zhu" <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
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

On Wed, May 24, 2023, at 00:11, Brad Larson wrote:
>> On Mon, May 15, 2023, at 20:16, Brad Larson wrote:
>
>> Also, can you explain why this needs a low-lever user interface
>> in the first place, rather than something that can be expressed
>> using high-level abstractions as you already do with the reset
>> control?
>>
>> All of the above should be part of the changelog text to get a
>> driver like this merged. I don't think we can get a quick
>> solution here though, so maybe you can start by removing the
>> ioctl side and having the rest of the driver in drivers/reset?
>
> In the original patchset I added a pensando compatible to spidev and that
> was nacked in review and reusing some random compatible that made it into 
> spidev was just wrong.  Further it was recommended this should be a system 
> specific driver and don't rely on a debug driver like spidev.  I changed 
> over to a platform specific driver and at that time I also needed to include 
> a reset controller (emmc reset only).  I put these in drivers/mfd and 
> drivers/reset.  Review of the device tree for this approach went back and 
> forth to _not_ have four child nodes on the spi device each with the same 
> compatible. Decision was to squash the child nodes into the parent and put 
> the reset-controller there also.  One driver and since its pensando
> specific its currently in drivers/soc/amd.
>
> There are five different user processes and some utilities that access the 
> functionality in the cpld/fpga.  You're correct, its passing messages that 
> are specific to the IP accessed via chip-select.  No Elba system will boot 
> without this driver providing ioctl access.

Thank you for the detailed summary. Moving away from spidev and
from mfd seems all reasonable here. I'm still a bit confused by
why you have multiple chipselects here that are for different
subdevices but ended with a single user interface for all of them,
but that's not a big deal.

The main bit that sticks out about this high-level design is how
it relies on user space utilities at all to understand the message
format. From what I understand about the actual functionality of
this device, it most closely resembles an embedded controller that
you might find in a laptop or server machine, and those usually
have kernel drivers in drivers/platform/ to interact with the
device.

Has anyone tried to do it like that? Maybe it would help
to see what the full protocol and the user space side looks
like, in order to move some or all of it into the kernel.

     Arnd
