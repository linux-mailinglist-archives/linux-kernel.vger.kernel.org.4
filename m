Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E3694ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBMPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBMPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:17:04 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62AD1E9F3;
        Mon, 13 Feb 2023 07:16:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B3175C00C2;
        Mon, 13 Feb 2023 10:16:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 10:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676301373; x=1676387773; bh=Kf21iTfnOc
        0+gof5tcdtuyQ6cwJSyn5AiREfLstk/+8=; b=WsrWRYLFY3iXtoXKqkfDMKVSZM
        AlXa9zzZUyEE2yK+voeMWWtDDtJ6S9JiVVwnPJJ1Kjiz0yprUva3qnuqPHllP9lD
        bolY1/aE79/OfRtsMOo+Ke+9bbzR3qc/Jzvx6bWbZ4yULDYKaM6ZD9oGdMjyJQOc
        euLYlfE/G3nJb5e6bixh5L/8JvxtKBTvHOVaFoBx4agY58VBqT5w40kizVLnyVjz
        qzMqve59ehaaLoL+Bq9Y+I2lPm+16e+X/XfWIbZJTZHS//bNjfzJhH7GkYc8ZoCK
        IPglYQFp5EHPVDOq/JtHPxPUGc2SOaSxfingjdaAvd8VHM+esHch7pSQgfiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676301373; x=1676387773; bh=Kf21iTfnOc0+gof5tcdtuyQ6cwJS
        yn5AiREfLstk/+8=; b=YL9VlNLu8+grsInifr7V85mTyOxIn8EP3VcMHQdgGKaZ
        2egufunr0fxxGhA/OCTAleBbghyPyLagzaeWZi0iSHflGcs8AGCsvjFcL9u8pQiy
        BWurJTJUNkmRAgQWRVzjcn5m7NM99Fk97h+Xn+apZB6IMPgZJF2T8f+fiA65IvG7
        WkYb9CsA+8KKy21tYQvaua32dezc4MD0vCOZUO55IPGlTCxx9h5gUwYqb2Gq+oYF
        +PLOsH2e4ytTrjj/yPbz1BxWvNTwSobx/3O2npHAsLsY6/wHnSRT+3V733nlBY7y
        kMysgo5eu3qGMeGo7++ODEoEhaTzKsIs3t6M7x1fkw==
X-ME-Sender: <xms:OlTqY6nOVMUPNtnOyIqMhfqaKSvPNZxK14yqpv57AzvPr_gMiI9l0w>
    <xme:OlTqYx3wiZANxaPMnNbOM40iA5eg-mE0ZWQQMJPdm0ZZ_GPUkJkB8woCcyt3GOBxY
    XcxC8hi7KGNUOLTXYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OlTqY4qikfA7yh-ZrjhYk84ukOtBH-js5gY0C8goxMd_uQmsoHSTlg>
    <xmx:OlTqY-mcJQ7MjiMieLE36JproXG-dHJ3avycCQJI3vO40k5Melhi-A>
    <xmx:OlTqY43pDMJZtFCwCIpTKxbfA8oQkW4mX_ioafzp1iKOM1IFxNiyZA>
    <xmx:PVTqYxv5ZKNvZy1gJC6oPZkADJZnlVXagBgxNRVRacpiL-_MY8r38Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C9FF5B60086; Mon, 13 Feb 2023 10:16:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <467e7a7f-1703-4f13-8604-6d582e4f9b3e@app.fastmail.com>
In-Reply-To: <CAK7LNASRz-apG_pNwvNOqxXy+-tp+WGHV--g6yYU-UQnZx5tgA@mail.gmail.com>
References: <20230203-arm64-defconfigs-v1-0-cd0694a05f13@kernel.org>
 <20230203-arm64-defconfigs-v1-3-cd0694a05f13@kernel.org>
 <CAK7LNASRz-apG_pNwvNOqxXy+-tp+WGHV--g6yYU-UQnZx5tgA@mail.gmail.com>
Date:   Mon, 13 Feb 2023 16:15:52 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>, soc@kernel.org,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: configs: Add virtconfig
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023, at 08:37, Masahiro Yamada wrote:
> On Sat, Feb 11, 2023 at 4:54 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> Provide a slimline configuration intended to be booted on virtual
>> machines, with the goal of providing a light configuration which will
>> boot on and enable features available in mach-virt.  This is defined in
>> terms of the standard defconfig, with an additional virt.config fragment
>> which disables options unneeded in a virtual configuration.
>>
>> As a first step we just disable all the ARCH_ configuration options,
>> disabling the build of all the SoC specific drivers.  This results in a
>> kernel that builds about 25% faster in my testing, if this approach
>> works for people we can add further options.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>  arch/arm64/Makefile            |  6 ++++++
>>  arch/arm64/configs/virt.config | 39 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)

I like this a lot, I think that is very helpful and we can always build on
top of it later with other fragments.

We could still combine this with another Kconfig option that
just hides all the real SoC options, which would turn this fragment
into a one-line file and avoid having to update it whenever platforms
get added.

> Yeah, I have a _local_ script to apply
> a similar config fragragment.
>
> When I run QEMU, I disable unneeded CONFIG_ARCH_*,
> and also disable unneeded sub-systems.
>
> Not only me, many people are doing similar in their local env,
> I guess.
>
>
> Of course, I will not upstream my set of CONFIG options
> since it is just my preference.
> After all, this depends on people in my opinion.

Do you have an opinion on the other two patches? If those
look good to you, maybe I can just merge all three through the
soc/defconfig branch for 6.3.

      Arnd
