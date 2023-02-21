Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D969E099
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjBUMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBUMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:43:55 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB1166CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:43:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A1E035C00F3;
        Tue, 21 Feb 2023 07:43:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 21 Feb 2023 07:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676983431; x=1677069831; bh=OCmb1zkwyw
        fNBZnkPA5iNKc7USKRqt6TZ0HAIFKkI28=; b=EUKrtYHrg6TpzedLk8CPS0y4JY
        1wO+2pItgIlPLrYtgfn+LFvH566sFd8k7JolfSkXUE9BTZG0zMKCstHZ0agIjg0F
        xi10sjrNTKIrNeIgNVnriX0A0t/A6Z3N/4mY5zsgYC+0S+RsmSMIc3ObMbnQyx3a
        BJpiR7bx7n5SYgNo3/qN+8B2iFL7BsmBVVRfbsRMAFeCKbdaUM89Ve/wKawGDaZV
        hi6GHLUdGpJejF1eohD2c/GxRKV/qY/S34SaAHOJT+QZsTr126R/qT/txm1ufgOC
        AjOOa3M6HdyfFyHI716OqHqITVSpgsDC7LlcSJYBlgmJCcFGsBIDlbFeBlOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676983431; x=1677069831; bh=OCmb1zkwywfNBZnkPA5iNKc7USKR
        qt6TZ0HAIFKkI28=; b=Bd7bevbH8M7iko2LiurMUvMkEEOh3B75I1FDIf/q3oL7
        BpJG7lFKGdPLFXVZqp6SWQSpw9iVRU7MWsmq3QaDs+A6XsC4w6nuRCTqHCcDVQRe
        7Ly28p0hpyTqXlPTpGPdA1UvN+8FCJ6lPtNCjZKLwPDmd83ulwwYbPq/F+qSOktU
        zlx/TIo5o+y2RS5knkyMMlCpsVbH+/SsIGa2xeW8zQIbL9iOqVUTew6x58IuM8Qa
        osqxToxwB82ROsANLYU7qKAzEcLYe0/opaROa4jvY0oiRZGiyY97IjAFoKnilke7
        oDTa1uHep2zIKFoTdDElrHnFM65m07i34vbZLQk0CA==
X-ME-Sender: <xms:h7z0Y7c8UO27QRXOI9lar_Fy5FeYRm28Qe-XQ0P_0M_4wJZ-Kf03oQ>
    <xme:h7z0YxNgYBRThGTB0t5l8SGI3JyOrZHzhuYsNNl_nqUOxVmcR7399H45XxwVZtiNc
    z2w3T_mnL-uw7V0oNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:h7z0Y0hSPka87n6nXwyXW5lMivWuy1kSPmUnzmYDc84mYIvqBsYcJg>
    <xmx:h7z0Y88kuXXxDmYX8hkMsdVPR9_6vjTCQDm22vrQQ8qlGfmFXEEReA>
    <xmx:h7z0Y3tq_iOR690p-ZQ_u3PryDDpOeRNqJ05nvcqneSt0tw-UiGXAg>
    <xmx:h7z0Y3JfDldYXm_jeCqiieXCnZgLqwwi8cLyNzFodjXMzGsvn4WB_g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F992B60086; Tue, 21 Feb 2023 07:43:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com>
In-Reply-To: <63030af8-5849-34b3-10e6-b6ce32c3a5bf@kernel.org>
References: <20220919040701.GA302806@ubuntu>
 <63030af8-5849-34b3-10e6-b6ce32c3a5bf@kernel.org>
Date:   Tue, 21 Feb 2023 13:43:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Hyunwoo Kim" <imv4bel@gmail.com>,
        "Harald Welte" <laforge@gnumonks.org>
Cc:     linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] char: pcmcia: cm4000_cs: Fix use-after-free in cm4000_fops
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023, at 07:51, Jiri Slaby wrote:
> Ping -- what's the status of these?
>
> Should we mark cm4000_cs, cm4040_cs, and scr24x_cs as BROKEN instead?

A few bug fixes ago, I think we had all agreed that the drivers can
just be removed immediately, without a grace period or going through
drivers/staging [1]. We just need someone to send the corresponding
patches.

While looking for those, I see that Dominik also asked the
broader question about PCMCIA drivers in general [2] (sorry
I missed that thread at the time), and Linus just merged my
boardfile removal patches that ended up dropping half of the
(arm32) soc or board specific socket back end drivers.

Among the options that Dominik proposed in that email, I would
prefer we go ahead with b) and remove most of the drivers that
have no known users. I think we can be more aggressive though,
as most of the drivers that are listed as 'some activity in
2020/21/22' seem to only be done to fix the same issues that
were found in ISA or PCI drivers.

The two important use cases that I see for drivers/pcmcia are
cardbus devices on old laptops, which work with normal PCI
device drivers, and CF card storage for embedded systems.
If we can separate the two by moving native cardbus to
drivers/pci/hotplug but drop support for 16-bit PCMCIA
devices in cardbus slots, this will hopefully get a lot
easier.

      Arnd

[1] https://lore.kernel.org/all/YyLcG1hG5d6D4zNN@owl.dominikbrodowski.net/
[2] https://lore.kernel.org/all/Y07d7rMvd5++85BJ@owl.dominikbrodowski.net/
