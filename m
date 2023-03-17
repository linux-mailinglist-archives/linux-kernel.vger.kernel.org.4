Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE16BED57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCQPwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCQPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE2457C4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E832E60A48
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0280EC433EF;
        Fri, 17 Mar 2023 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679068346;
        bh=zbml9Ax+BPYhanZ2Ux03Lm6k/z3XDmnQdAr1qifQ7/c=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=WZY3HbBrYxvI9VpcjD5s351/yYSfj/935cw1n5pOU2/WcrPLUFuNICtgiXwRUVcb3
         9hvi9ZQnmQTdCqhZodY6DewetjvE/V7sdmLpKhbI+vzr+nebakTjBBvxP9RgpjpilU
         wG0RX7CJp9P4sMzmln2wmq2/cP1Y7V56xbbf7GyJZi6NnHxQX0Flqsgap0S3KKIgji
         qM6vz254jH+E4bgyJEvr0bQ8TzOnTsjDzS0Lpa2tZp4Kgmeym6U92ryULzYbshe/Xc
         c7kPVBMM8qqaBu+NQguVNnLaFRvxqNdBEfZAI8GOBHvTobj/ldNvXbe3NEb+aOAZ3n
         R1PLi7Yyd/q/A==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id DDDB327C0060;
        Fri, 17 Mar 2023 11:52:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Mar 2023 11:52:24 -0400
X-ME-Sender: <xms:uIwUZIW-8_lyXEJB54faoT91WvaNFkHtpRuezsqFIuexvKV0pr-mHw>
    <xme:uIwUZMm4haoxg70aJ6VRmtvM5RFGcC4wjaPBsBtsrdUu2RxRYsKUx4poFUCzd-WcZ
    F86SM1AYqJKemZWTqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:uIwUZMaboF0xRTxHzzZDckNcqo5yw-KMlmWh0fEQaysgQg0htZ7OjQ>
    <xmx:uIwUZHWjwbxNvfQD9kfj3BhS6J6w1cqzdlLEExwDnK36IcNkzXpokQ>
    <xmx:uIwUZCl7bbkdHBgk3Gxf6g7lH8-FAMoEbq1bFyUvF63vYiW4jv62cQ>
    <xmx:uIwUZDAgoaUgUVo4Kguw7Izae0XwqCLvQrh9qnomUoPNlganyzfDTg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E499B60086; Fri, 17 Mar 2023 11:52:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <ed327f8d-ac9f-454c-a005-0edb400be165@app.fastmail.com>
In-Reply-To: <20230317154411.3727514-1-jeremy@jeremypeper.com>
References: <20230317154411.3727514-1-jeremy@jeremypeper.com>
Date:   Fri, 17 Mar 2023 16:52:04 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Jeremy J. Peper" <jeremy@jeremypeper.com>,
        linux-kernel@vger.kernel.org
Cc:     "Andrew Lunn" <andrew@lunn.ch>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Russell King" <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] adjust init logic for ts-wxl to reflect single core dev
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023, at 16:43, Jeremy J. Peper wrote:
> Original code was largely copy-pasted from the reference board code, 
> adjust pcie initialiazation to reflect the TS-WXL using the single-core 
> variant of this SoC.
> Correct pcie_port_size to be a power of 2 as required.
>
> Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>

All four patches look good to me in this version,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Andrew/Sebastian/Gregory, please let me know if you have any comments
on this, and if you want to pick it up in the mvebu tree or I should
just apply them directly in the soc tree to save you the work.

If I apply them directly, I'd probably take patches 1, 2 and 4 as
bugfixes for 6.3, but leave patch 3 for the 6.4 merge window, unless
you have a different preference.

      Arnd
