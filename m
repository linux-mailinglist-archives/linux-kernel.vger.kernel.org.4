Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5D60432E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiJSL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiJSL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:29:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E11B6CAF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:03:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 02DCA5C009F;
        Wed, 19 Oct 2022 05:32:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 05:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666171965; x=1666258365; bh=qV9lZ2aH+8
        Gf4ZXXwoIECQyW0k3j1ZOHMSQvMpw3uCo=; b=nZbj7uURlyDhe3KWlMJ5vMfoxQ
        uRCFfIv449lE1p4BjiPmc522K9BkPE3Yex4799UjZT8lExnBRgcC1NtfL8UcioUg
        lzTJFfF9BRi+H4H9XOfwiTYlPPf3U+IZgCbcwi3Bl4TqFU8Da7SVcp73S4Km1c0M
        5VL7kCIk3ljMKIuvmG52LX87UZpah8dwqGFjCU/LGZmf1MaLo5Bn9ccPCs3iYvs2
        CGdCGoAU2rJ8wDo8hVdvOB0W5gQKIidEo++n7AISmBty6r0theqd8TZzzuTXFq/G
        2IREZfG0KasmmLlDm0BIS+Raj6Oeq8SJcQR7FEd9HJGFrIDm3vRx8azL5F0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666171965; x=1666258365; bh=qV9lZ2aH+8Gf4ZXXwoIECQyW0k3j
        1ZOHMSQvMpw3uCo=; b=duAtabXo4h3js24n9SWPyq0sEeMTmApDQxpCPfZq01YG
        W7XSLR979i5uVt5uNatW+h3hYKerIjta1Efztr5AcoY+tTUGcscLj5mvPEkAEm4N
        98xzj1aTOqndrWBSSITzhcgh0VIgowy/6nn+y0b4ajPh1f28Q1KW9lU6I22EbJ4c
        y5yPEIYM2Uh5iWEDJ7Ri9TG4tIEqMRyJPfXGXm6GDlXAJh49ms60Cx3qudRSU6J8
        MQx2g7bGttdama+fk0kOB6uaAQJrhoPtkZRac4VvVqM70N/XlKZbGWAAJbLQfRER
        0pfBEuf+sTr0ckPDOHFS77X5L080BHeN9DRsO2pPjQ==
X-ME-Sender: <xms:PcRPY9ZEgqeMs3HKpvaQhciJKb9wEhmmxyxZ_DD2eYQUVOm9VvgRbw>
    <xme:PcRPY0avja1xtv3lC3hbxrHyZ4_bbk2OByOwMpA6bPAc1bNcZ5NZsPSmLiMi4edMS
    deTCaBWg60OAXMBNuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PcRPY__ctHBqnxXXxrfIiUnuII_VatI8AWL0oHii-1TAtlw4yiQyZw>
    <xmx:PcRPY7qehp0zH-JwsD2UAckZHRdh8PoLFKq-TPDBge-_sO-v5LvNwA>
    <xmx:PcRPY4p1qOBTnx-yGC9N22Ffstdj1daJQjARYN14M0M4nSsJuwnyNw>
    <xmx:PcRPY9DyAuq09GrC4OF2YS1m3SyRqppcyMQeC2dwB2KM1WwwUhPhXQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 364FBB60086; Wed, 19 Oct 2022 05:32:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <6d454246-578f-4a25-bddf-2f68f32d2213@app.fastmail.com>
In-Reply-To: <Y0++52o7QSaDvqpM@shell.armlinux.org.uk>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
 <Y0++52o7QSaDvqpM@shell.armlinux.org.uk>
Date:   Wed, 19 Oct 2022 11:32:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>
Cc:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
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

On Wed, Oct 19, 2022, at 11:09, Russell King (Oracle) wrote:

> When the only users in the kernel _were_ ZERO_PAGE() for this, which
> is defined to return a struct page pointer, there was no need to make
> "empty_zero_page" anything but a struct page pointer, rather than a
> runtime translation from an address to a struct page.

Fair enough.

> IMHO, we should _not_ be exposing empty_zero_page to devices - we
> certainly do not want the DMA API performing cache maintenance on
> this page since the primary purpose of this page is to fill in
> userspace BSS pages that have not been written.

It should be easy enough to not expose it by renaming the
symbol to something other than empty_zero_page. That way,
any incorrect users that may come up in the future would
at least result in a build failure instead of runtime
data corruption.

> So, the only one that needs fixing is the SPI usage, which IMHO
> is wrong. ARM being different finds what I consider a driver bug.
> Good for 32-bit ARM. :)

The SPI driver is powerpc specific, so it's also not going to
get hit. 

    Arnd
