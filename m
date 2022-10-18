Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10CA60329D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJRSgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiJRSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:36:06 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47759C20C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:36:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3B62532001FF;
        Tue, 18 Oct 2022 14:35:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 14:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666118157; x=1666204557; bh=5a8BQYkg5n
        QpQl0T1/Lr36V3/KGyrlSGmYOCZyfCIjk=; b=fHV0kdo8M4KP2DVa+pamxxSTNd
        xR2HThITRWXoMhUWHCMeW3qi3fwbACTJR0pePYbqJ/XvAh8o/XWalvCQM8fJw4bE
        tN/se/n1EjVLlc2M2lWAAC7L0YZ+l+eChn/WHzVoAoJoKRrNv7YoMBZkeHHYVzEx
        oV5BCjaacz9lMm4BuhXQq1Q5hXNMHaHo+/ud4nrurj88aGu/6YSrrOCiD4h3tAeN
        6uhx10oszg9tmwOJCfR3A+ddR6N06zM3Zqih7ZY5QmkPLIoqz0R5n94VSQRNAnfx
        6AEVtVJ2l6hbgSFW+IS/iX+cYf9s9ab6LWxKXrf6TEUjnc1LVSVzb6kQdB4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666118157; x=1666204557; bh=5a8BQYkg5nQpQl0T1/Lr36V3/KGy
        rlSGmYOCZyfCIjk=; b=DLxownU8ofxWI+Ca8cDXFwEp0tb+CYGgv+178kpwFGby
        7dNVH7d4C7pL1V+4mfdyYGyFL0TNfOv7qtw8Uc6k+IjnFYc5WeMeoyMaL2ZSdaVd
        0UKg3NIrhQYwh7tEsshBI5iU1HRiMZiwW/KPXW9j9YQj6acyijmsu4H/Sb+yy0FF
        t8IUgKOER3dc15z0Sb5v9resWJjqiKY5xGP70DssLJI9vOdOY8RRUpv5GeEqe34K
        vaO8MDnd5f2rZjP5eTiAJJNPAmyJ7KGmnuxZVUYfPCsYEct6DK+F8PDZWzzL04ba
        KEypngrgj9SPtDvpfVzsrIuOwsQo4nVRsybkyXKZcg==
X-ME-Sender: <xms:DfJOY4kgY7eom6Y6v6Tp2aR6eYzKvjDRx71TjoSHXFCHDDNANYnYJA>
    <xme:DfJOY30MsjjMbVzNZvgl2RnI0CX3s23hmacCtMYaKhxybIxZ2h4rOS3jjWiSOzvjD
    XhUgOdUwCU20r--ClE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DfJOY2r3o_sgEAr-VF2DRhi_F238PBu2Nv6q0I5ECzMuqoxjgwdvDA>
    <xmx:DfJOY0kAtbtHJUZXgObJO7yWLBuerNNdudYSR1Jhep7p37vLCG6vNg>
    <xmx:DfJOY2154lf2gL-ZjKzkmglS8o-Cl8W0dZ71Bs5PAfqXjR_OocF2Vw>
    <xmx:DfJOYwq67R-ZtF5O8mE1omFjuYOck9UNJ0KKS5DpHVLF2i6Mooy9Ng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A168B60086; Tue, 18 Oct 2022 14:35:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <dc5a5c40-8e96-4f91-a3c6-5a1fc8b26ad1@app.fastmail.com>
In-Reply-To: <972a3be7-4522-b4f0-adfa-6b42be56c52f@benettiengineering.com>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
 <972a3be7-4522-b4f0-adfa-6b42be56c52f@benettiengineering.com>
Date:   Tue, 18 Oct 2022 20:35:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022, at 19:44, Giulio Benetti wrote:
> On 18/10/22 09:03, Arnd Bergmann wrote:
>> On Tue, Oct 18, 2022, at 1:37 AM, Giulio Benetti wrote:
>>> Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
>
>> It looks like we dropped the ball on this when it came up last.
>> I'm also not sure when we started requiring this, any idea?
>
> No to be honest. But in my case I've met ZERO_PAGE() calling in sdhci
> driver. And as stated on the ML link above:
> ```
> But I wonder if it's safe for noMMU architectures to go on without a
> working ZERO_PAGE(0).  It has uses scattered throughout the tree, in
> drivers, fs, crypto and more, and it's not at all obvious (to me) that
> they all depend on CONFIG_MMU.
> ```
> And I've found this driver that requires it and probably is not the last
> since imxrt support is not complete.
>
>> I can see that microblaze-nommu used BUG() in ZERO_PAGE(), so at
>> whenever microblaze last worked, we clearly did not call it.
>
> This probably means that microblaze-nommu doesn't use drivers or other
> subsystems that require ZERO_PAGE().

To clarify: microblaze-nommu support was removed two years ago,
and probably was already broken for a while before that.

>> In addition to your fix, I see that arm is the only architecture
>> that defines 'empty_zero_page' as a pointer to the page, when
>> everything else just makes it a pointer to the data itself,
>> or an 'extern char empty_zero_page[]' array, which we may want
>> to change for consistency.
>
> I was about doing it, but then I tought to move one piece at a time.

Right, it would definitely be a separate patch, but it
can be a series of two patches. We probably wouldn't need to
backport the second patch that turns it into a static allocation.

> But yes, I can modify accordingly. That way we also avoid the early
> allocation in pagint_init() since it would be a .bss array.

>> There are three references to empty_zero_page in architecture
>> independent code, and while we don't seem to use any of them
>> on Arm, they would clearly be wrong if we did:
>> 
>> drivers/acpi/scan.c:#define INVALID_ACPI_HANDLE ((acpi_handle)empty_zero_page)
>> drivers/spi/spi-fsl-cpm.c:      mspi->dma_dummy_tx = dma_map_single(dev, empty_zero_page, PAGE_SIZE,
>> include/linux/raid/pq.h:# define raid6_empty_zero_page empty_zero_page
>
> For them I can send patches to substitute with PAGE_ZERO(0) correctly 
> adapted.
>
> What do you think?

That sounds like a good idea as well.

     Arnd
