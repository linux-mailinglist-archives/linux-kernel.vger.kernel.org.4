Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EA67494A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjATCWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATCWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:22:20 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1889F3A2;
        Thu, 19 Jan 2023 18:22:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B750E5C0098;
        Thu, 19 Jan 2023 21:22:18 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 21:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674181338; x=1674267738; bh=tziaenBgZf
        HXo7o+JSgvpsIssnOOcpkmBFnl2VxkDts=; b=BpeqyBOTJh/85zUDp7G8ONolva
        JmAWtWXMaRakSKR/0fg7y9JLM16mUWhhv5Vut6Xgk0ahOWq+FGmrv793cT93ZTU3
        UNEFj9/r9UhAHkT6rpL/xY0/JTg3RkgaOJmAlubnANdC+/05L5pfhJMtQKlktbPb
        RnkfQp24zNV+ZshfXCcg8rd9/k/FTXfFhrhniKGREGJubK4hUX/B2xXd58JELm2I
        9DgvERSCbwTT61pb+cGSuzMZQ2pOtYGVqFB4j6FivcQKpd54tWZQbBR+kPF+LQrh
        691yc0uH1wKUJ++JylHE+vqQxlDmdxOHgrAK6SpWNAYY1/hohFh5cQ1sPWmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674181338; x=1674267738; bh=tziaenBgZfHXo7o+JSgvpsIssnOO
        cpkmBFnl2VxkDts=; b=HiGHG2Htaij2b0kSaad4LHPX8Ho4pxGB1Zq2TIOMMOLz
        f5WIMRkE0VpLXFzNkv42R05ilUEPqPx7DP1GbOOP8tE1VErvS+Og0HndM1ONQkWL
        28fvAiEUS4GV/5nsFMryCV4oQdSVy4YZ1WK9o5Xt833EbpaBXbgmytKucqnV7+iA
        el8ozZbf+WzRz/QEoeqOFUR40yz+PuqEsinlNd4tFxqnn8zmWyfEi8keF1mcgLqH
        EEq3iIBkfwvX2S8YTw2U7fEuTp8fQjkbowWShtipqWDI5FFBXqaLXaByr5QoRrGb
        WzIekC/0ko81HUJ8bOPbjRQCfYf5bJI+z9mYFZ9xrQ==
X-ME-Sender: <xms:2frJY_gJjMR3HtFS3jIZbFrsy3yHmg7tzIJpqMiuMp0o-riHTNQ6yg>
    <xme:2frJY8AqKwnv7gNrAxOU0GDuZNyrLYHVq-nLhvho8THfKDW9CuO2xluzmYMCsjyv-
    Jg84QFPOatugCXzEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudfftddvveekfffgteffffeuveegjeelgefhffejtdehtdfhlefgkeef
    hfefkeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:2frJY_ELKpBQTA3OJmVhRti6tBxHzWjOiPcWKDgJLp9LOeJtUM10Sw>
    <xmx:2frJY8QHsW2Zyyg9SkczDzPT62nyM5BqYzqS3LZupaeN1rUu6cGBrg>
    <xmx:2frJY8wqTh7Ibo-8ScquDcuXRRVuzjql4OPg4K2igyiflLx4fzlW9w>
    <xmx:2vrJY4eh512gab0pYBFER73nNcuTj-Q63tJUL8O6KdrpKRVdhpJRUg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF0861700089; Thu, 19 Jan 2023 21:22:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
In-Reply-To: <20230110042533.12894-1-clayc@hpe.com>
References: <20230110042533.12894-1-clayc@hpe.com>
Date:   Fri, 20 Jan 2023 12:51:54 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     clayc@hpe.com, linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 0/5] ARM: Add GXP SROM Support
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



On Tue, 10 Jan 2023, at 14:55, clayc@hpe.com wrote:
> From: Clay Chang <clayc@hpe.com>
>
> The GXP SROM control register can be used to configure LPC related
> legacy I/O registers. Currently only the SROM RAM Offset Register
> (vromoff) is exported.

What exact behaviour does vromoff influence? You mention I/O registers,
but RAM offset feels like it may be related to MEM or FWH LPC cycles
instead?

I'm trying to understand whether we can find some common ground with
controlling e.g. Aspeed's BMCs LPC peripherals based on Arnd's query[1],
but the description is a bit too vague right now for me to be able to do
that.

[1] https://lore.kernel.org/all/66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com/

Andrew
