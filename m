Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63767E0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjA0Jrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjA0Jro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:47:44 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0B77529;
        Fri, 27 Jan 2023 01:47:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 27CB55C01E1;
        Fri, 27 Jan 2023 04:47:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 04:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674812839; x=1674899239; bh=tj4fUV0mbS
        BB8dPKYcWhph5CmlArCZpuWD2qlpLjjUM=; b=NqcZIWOMP02pFJUkQSy+jZGFSa
        AsLCaB7pvjhiMSRhEQqGuggVpaDVvwRJ9i3rqfGoFpkcyJbqxVo9DPQ10GCqLAEL
        UeWfkBwHanctycdsMJqxdTT9a5Zv9SOBPA8j5TwtYXlr3Ey+gteDoniAmytk6lDC
        Sgrw3e+AxKHqbPjC83DPKaRYILqPlDtEHCPZKvpSjLzLWF0Yl2aE1odmqthXZRFi
        KaCZPNhzNLzxaCvvI4W6A3LGM3zlX6q+7uFUzkwTyG1wOoHIdtJrWTZ0xgKiwo5m
        CwwwoniL/JaXW67QcOdM61eYGPXEiBi4pkeBIqu2ODg44g4tj3pYz45kxvHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674812839; x=1674899239; bh=tj4fUV0mbSBB8dPKYcWhph5CmlAr
        CZpuWD2qlpLjjUM=; b=RIy2/PFL9y+yYZljyekisVGaGB+Wgp131zaDczCJ2uSE
        lVtMovYYIc6Y/kUhdHiPfoOE+LhIzBkHIM/xDiE+Xb1BT2TxSaYqs6v2KTbRg15M
        ORCq6NBmulv1ldDOEUgogzFEJPH6iiN8nl3tvEPI1wFAGj4IpdQE73Wp/7L7XlDy
        Bakdd15ygYkUR8tdzQN5ISRkSzbEHKSAS69cI+r/jyr4bjrsLPkQEXdPTHSFMVvE
        fZoW14ZvfZ2Vo29oZz4mFRjiQxvHFk95gFCtfRrsjroMGMM309f3JjDMhfBS+l7h
        JTZnR+OSSEGW40V0WjTVm6rk3tGAld7Llfw8yQYGzg==
X-ME-Sender: <xms:pp3TY2nS_PQrvG9xrEoOGaSBSGxc3HFolVrxFgyWgofwCkJpezOIHA>
    <xme:pp3TY90IcsPoLVI8XW61gv2utoWYi-XezC3eTJHdm2-79E0qRp4ybFS9myTe6vq9o
    WdvDYA5dXNH83XSKow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p53TY0qsoHTJWGphgcEsWzpLMYGkXgrLA0e-k_6LepTt6CwfUgwkWg>
    <xmx:p53TY6lDT0hMf5Dg1bEqbiqE_HmP0m1qfQP-CLMaIsdYdRbRgFimYw>
    <xmx:p53TY01pmSrgZTWyn3St-jeLHFPH_DM55OHj-n0M1_87woexQh-oXA>
    <xmx:p53TY-qj15BRA_R24yUUZz8OPq7C2jkrRiDAbrrr1Z1w24Lk52JLvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E0922B60086; Fri, 27 Jan 2023 04:47:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <31ed5c19-af81-4665-b8e9-79112a4f88df@app.fastmail.com>
In-Reply-To: <CAMRc=McAAwdtCo9VCFtSuQm9hDRVWHZUQe+tMC9Fec=1YhJ+Ng@mail.gmail.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-9-arnd@kernel.org>
 <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
 <21657e6c-1101-4c56-91e3-6b2f6f9e10c9@app.fastmail.com>
 <Y9OQ9/3IuVIU8VK7@smile.fi.intel.com>
 <CAMRc=McAAwdtCo9VCFtSuQm9hDRVWHZUQe+tMC9Fec=1YhJ+Ng@mail.gmail.com>
Date:   Fri, 27 Jan 2023 10:46:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
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

On Fri, Jan 27, 2023, at 10:43, Bartosz Golaszewski wrote:
> On Fri, Jan 27, 2023 at 9:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Thu, Jan 26, 2023 at 03:47:42PM +0100, Arnd Bergmann wrote:
>> > On Thu, Jan 26, 2023, at 15:09, Andy Shevchenko wrote:
>> > > On Thu, Jan 26, 2023 at 02:28:01PM +0100, Arnd Bergmann wrote:
>> > >> From: Arnd Bergmann <arnd@arndb.de>
>> > >>
>> > >> There is no need for this in the header any more, it's just
>> > >> an implementation detail now.
>> > >
>> > > I have published
>> > > https://lore.kernel.org/r/20230112145140.67573-1-andriy.shevchenko@linux.intel.com
>> > > Can it be used?
>> >
>> > Sure, I added a Reviewed-by: on that now. Your patch will conflict
>> > with my patch 7/8, but we can work that out.
>>
>> Either Bart takes it independently or you may attach it into your series.
>> Bart?
>>
>
> I applied it to my for-next branch, is that fine?

That's fine, I'll make sure to rebase patch 7 on top of that before
I resend it. The two are functionally independent but touch adjacent
lines.

     Arnd
