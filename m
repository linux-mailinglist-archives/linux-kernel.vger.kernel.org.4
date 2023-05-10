Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F56FDEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbjEJNgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjEJNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:35:59 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0298;
        Wed, 10 May 2023 06:35:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id A1D425803F9;
        Wed, 10 May 2023 09:35:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 10 May 2023 09:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683725756; x=1683732956; bh=Ot
        QRh15NAW2fKN6rYhRVoaA9NIjXRriGi0juhcP02Nk=; b=Fei60N3N1IRxNekLDz
        LlNakjV6mxlgcp+mcjsPCqDoGkhdYbgZAhm4AALdN30Rod8nRMpHC0cNU5jXYuyK
        UG8hF4Rt60A2eKOivls83Axn1EallgBdvgo48zEtswWI2Qnao/3GLCf9eV5U+5Ok
        MSYBCjVB0OAItrUDOt3jTvymHnf9qu40cf1TvL7VQgQSpYqD3eaiovc6KdjxPFx/
        ZbcuBOKpDa547E+GgpylHyouViTgpOUCBkBNBVyeqgfu+awEM+UV8riMIEnypIcX
        gLY9fA2wp3HIDkXP3lLk8/XO+L1kwXadHUjrNyRH4uTwUNxibzEmKTQtT8kBx8lM
        8vjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683725756; x=1683732956; bh=OtQRh15NAW2fK
        N6rYhRVoaA9NIjXRriGi0juhcP02Nk=; b=az8ZNx2lXpcCEt9HJiIiSMtLujspS
        zL+7doBWdbPbYzFHretQkcpDdjKlIVnLafTQEuEVeKIRK3tVvgsbZj14J7LbGSao
        Shwfx5FhCtTgoSxt+Ge4ZcFA4cwWGKfzIS2/N1CBSmIuLwrO87hlSOYxecVaE5un
        NUdNaWMwYbqFQvO2vZ5oIxTe4g24VJly6SDNDJYRmW8fPviILc8YapMJcDl0iiw3
        ME1oq4u02A3x9OCr+MXxDMhGrl4WwibcMq3qP5+aJv4Yi135vec2p9873HFJlXrC
        L5jHY4//HIF18PkL8CS+nPVtg+8ec31Kym8IP9/JI1QW6p5mC8Ee6svzQ==
X-ME-Sender: <xms:u51bZEC1mqpxG3NfJIKjLtexI_Odbousdgu_Pqys5U6DJa98HkbLkA>
    <xme:u51bZGjIrIFp1rBTRgvjrlUaycqSZ2oM9V5ZRBbqoaaO_xha1PAzRbwruUrm44Orj
    lu6eGtd_53MXmtYPlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:u51bZHkc31ns5dYrPTasRmjl4bhobgb9wZWBI9T-ijbtqcVFgPhqOg>
    <xmx:u51bZKxBAypEvGab2_acadu6LfLHlfOxIz0Exgiy2mXjngFS8LSTBQ>
    <xmx:u51bZJRCN78u3OKzWITTd3Xg6zMi_ROCD7FLAB2RWEImjCn6l3IJyQ>
    <xmx:vJ1bZFJi68EsJLW6hltzVHGaxr-i1Wx0vzUbgc8kgsZa4XKXmgv7RQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 254FCB60086; Wed, 10 May 2023 09:35:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <02ce0541-08cf-4e14-a9b1-c53efea85178@app.fastmail.com>
In-Reply-To: <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
References: <cover.1683722688.git.geert+renesas@glider.be>
 <8db63020d18fc22e137e4a8f0aa15e6b9949a6f6.1683722688.git.geert+renesas@glider.be>
Date:   Wed, 10 May 2023 15:35:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Stephen Boyd" <sboyd@kernel.org>,
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
        "Vincent Guittot" <vincent.guittot@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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

On Wed, May 10, 2023, at 15:23, Geert Uytterhoeven wrote:
> read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> feature, just like its non-atomic counterpart.  However, there are
> several issues with this, due to its use in atomic contexts:
>
>   1. When called in the s2ram path (as typically done by clock or PM
>      domain drivers), timekeeping may be suspended, triggering the
>      WARN_ON(timekeeping_suspended) in ktime_get():
>
> 	WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_get+0x28/0x78
>
>      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
>      rid of that warning.  However, that would break timeout handling,
>      as (at least on systems with an ARM architectured timer), the time
>      returned by ktime_get_mono_fast_ns() does not advance while
>      timekeeping is suspended.
>      Interestingly, (on the same ARM systems) the time returned by
>      ktime_get() does advance while timekeeping is suspended, despite
>      the warning.
>
>   2. Depending on the actual clock source, and especially before a
>      high-resolution clocksource (e.g. the ARM architectured timer)
>      becomes available, time may not advance in atomic contexts, thus
>      breaking timeout handling.
>
> Fix this by abandoning the idea that one can rely on timekeeping to
> implement timeout handling in all atomic contexts, and switch from a
> global time-based to a locally-estimated timeout handling.  In most
> (all?) cases the timeout condition is exceptional and an error
> condition, hence any additional delays due to underestimating wall clock
> time are irrelevant.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This looks reasonable to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you sent this because you ran into the bug on a
particular driver. It might help to be more specific about
how this can be reproduced.

> ---
> Alternatively, one could use a mixed approach (use both
> ktime_get_mono_fast_ns() and a local (under)estimate, and timeout on the
> earliest occasion), but I think that would complicate things without
> much gain.

Agreed.

     Arnd
