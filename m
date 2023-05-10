Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D66FDF57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjEJN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjEJN5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:57:42 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E220DD8C;
        Wed, 10 May 2023 06:57:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A03F58041D;
        Wed, 10 May 2023 09:57:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 10 May 2023 09:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683727025; x=1683734225; bh=Bd
        Z5AYdOL3hiZeP22cj7y6sMOqTLcEFohvUNaaYxf1o=; b=iufmgR0Lrc0QG7VcSv
        /uU2wMtCacOya8buTieXWP70gf2h5oskJ86emeal2ei+hdZPmBo4n8EUXgiOcZW/
        zS5x4EbMe306IdJBcJJHwbQK3UcQdEsdpBi60IwKlfGS7bsJrYcvTF3nhQNFxNt2
        YE0gCKxnAsXThTCsC/3eXmHiF27ECEjSTy4mFWOS6x5V7Gq+Dco2tHgFNtDfBCW5
        IGkUfleFEe6nPsPoV2OYS/NAn8YHrtI3m6BUCByiQN+2aTW0r2nPwZsV0pGV9fXE
        hRzcDOq1hvztdqGAP9/dcS1HPVFR1gIB/PPAsK7/zKE5iDjU0acLfkFP/k4v0ac6
        4YOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683727025; x=1683734225; bh=BdZ5AYdOL3hiZ
        eP22cj7y6sMOqTLcEFohvUNaaYxf1o=; b=BHa4FQpMZSx5rMjKx3JZk+WdUVJsS
        30GqRm6FknVvz4Fs66D65X4JMhqHKkQ/THbCAE/YmSZw/NqR1vWn9lOotY1mcziP
        mdna4xMtBLGSITtBwvtuEgO7rzPlaE/8+4VEPRDT2/SzotkzYdQERMKF3pxjJfuc
        Oe9lDZt1lBmpuQg4Cm23P6GC4IDQrIcqt2Vn7x7xUai6D0rKwSChIYQ4tf7GHDHm
        3r7vT18Tof0fvQVMgewHzGFW6qiYUryRZ/SVabqfKWDCE4Y5vtj8dsajjT7ES6SK
        s0BW6+NtSaxKYrhjBzF6hUAE9rVASy0ogTDoGZJBudaji48yogros/7Hg==
X-ME-Sender: <xms:sKJbZP9O_QdU608GQ0rauzkUq9XQuOWf45Bg71azErX_7pE8KGffbw>
    <xme:sKJbZLvY3Ti20n-cm31JrvVKKGvgEvwWGkVgsswuN8gnmIOHnlR24CWpbEvDViLtV
    JHn3LTXbho_OwjqI0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sKJbZNCh8XSN6a36J-wNq1JY-djtUDID_1d23PffNfAn0co78hzjrw>
    <xmx:sKJbZLcx5rI_7WWQc8OZlhUzL69HC-LTYEgS0PidElq8k-w1fEKYdQ>
    <xmx:sKJbZENZpb_fxhcEroBdE_s3CKgxuPcLcdTXdppuBfTfzjMCXxj6Hg>
    <xmx:saJbZC0BBdE3_Z5vg5Y_UG4jippgyXxMAyJG6FAvzTdsng4sX2ntrQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9B933B60086; Wed, 10 May 2023 09:57:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <c6966111-cea0-4547-8463-46f9f767c20f@app.fastmail.com>
In-Reply-To: <CAMuHMdUg0gk3QUmC+OiBDQuZAWdJ2cbPpwaDX+TGoq1EPO1v-A@mail.gmail.com>
References: <cover.1683722688.git.geert+renesas@glider.be>
 <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
 <02ce0541-08cf-4e14-a9b1-c53efea85178@app.fastmail.com>
 <CAMuHMdUg0gk3QUmC+OiBDQuZAWdJ2cbPpwaDX+TGoq1EPO1v-A@mail.gmail.com>
Date:   Wed, 10 May 2023 15:56:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Stephen Boyd" <sboyd@kernel.org>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Will Deacon" <will@kernel.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "Dejin Zheng" <zhengdejin5@gmail.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "John Stultz" <jstultz@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Tero Kristo" <tero.kristo@linux.intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iopoll: Do not use timekeeping in
 read_poll_timeout_atomic()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023, at 15:46, Geert Uytterhoeven wrote:
> I first ran into it when converting open-coded loops to
> read*_poll_timeout_atomic().
> Later, I also saw the issue with the existing
> read*_poll_timeout_atomic() calls in the R-Car SYSC driver, but only
> after applying additional patches from the BSP that impact the moment
> PM Domains are powered during s2ram.

Ok

> The various pointers to existing mitigations in the cover letter should
> give you other suggestions for how to reproduce...

I see the cover letter now, I thought I had looked for it earlier but
didn't notice it.

     Arnd
