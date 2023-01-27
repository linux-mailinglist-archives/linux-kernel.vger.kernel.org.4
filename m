Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275867E65E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjA0NQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjA0NPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:15:51 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337481B18;
        Fri, 27 Jan 2023 05:15:29 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8400F5C02EA;
        Fri, 27 Jan 2023 08:14:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 08:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674825269; x=1674911669; bh=YsbkWPxS5n
        /e7xTzfTjTdFRooB2Q2tkvCNwV6c8mUQY=; b=LqLKnUPwOzIIwe3ayM2KbeX+6Y
        UvhDIi222jXGbhb/DT3xNZlHlzcuGTANAU0S3xAzo65Gda5LK8O9ju1lUwzQFuHf
        PhRO0K/R92EHzi5CJtaJHWKnQGQ/Nnn8QLWseTc+OpkFudAbKhOlJ2gD3+lP3N+t
        i3mRERh3W6cBSFXE4a3J2WC9zydloAWYh/c1lHi7JfRDycpiOSdgskWxaizPdUBp
        qvroX5dRKTLYPwjfWeZeVj9B2cjFFIH++lnYEbaWukcxOOWeyvVaMEnKyhHdkVK3
        Pf4zrAEOVK/i9wAs8BA5tKHGS7zu/nznQ0vC7XQYa7a62W8+GxPxjSMX0coQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674825269; x=1674911669; bh=YsbkWPxS5n/e7xTzfTjTdFRooB2Q
        2tkvCNwV6c8mUQY=; b=hulkg/Js69eCHWpToZ2uitSh+RjACGihKCaStwvoiztV
        twqsOYLZCjsenlLc04Xbr6zhMbXE2SGOJT7/msrYcWvIG95FDZaGHNi1g8FBR795
        l1aCglGtxo7jwPQJeoFG1SMCVKvVlacuK+k+1L2dV35/rI2fknFeaXC9Fxv15cFs
        wqSDCyQ4n+RsmlmKHbd0MVGzUWmTZfco0fHjPY9Q4kmfICfi9yKiSE6JQYAm8XCq
        Qpl5922KdWqgIgc4XCOY+EKRU26wBuyEWnhn4cPIMNlgtADdzdqE0GZPMvWXiviy
        HoNEUwyZ4guGHVmRIHbK8gNh3BPSMJ8eCkoWhyhLaA==
X-ME-Sender: <xms:Nc7TY-lJFtghO8bZYrQ5-Wmzm9ZGdFZBXSg1MZEV6IIUJEBplKRdTQ>
    <xme:Nc7TY13qpoADvi5ckfUK5m0_CDZhX1S4Vad0_AHPZLJLsSohUyZ7u4uD0mmTSv9Tq
    rVMIovZPAy38avR4Do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Nc7TY8qvvWhU697a38xZNHgnyts6sctKQjfOrdVM5h5tIt7qBr2VJg>
    <xmx:Nc7TYynBzoMF6XjbBCXIrVScRwPmAqB9EMAncBdIWmjfoxIgB4g9Hg>
    <xmx:Nc7TY83Yorx7WqcRsXStPtKkEyNknfM39WjR4nt0PBff3bHvN3uXOg>
    <xmx:Nc7TYw-6E2ousRK6Gtz8ypU_ia4vWIxpAsl7VXG3A-cYevmnrsjo1w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21D59B60086; Fri, 27 Jan 2023 08:14:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <9472cdcf-bf15-4fef-98d4-15a338baada1@app.fastmail.com>
In-Reply-To: <CACRpkdbt4+BzLcf3aOe_cfGzNTPtnzc34hE8GSGFa4-anzu9nA@mail.gmail.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-4-arnd@kernel.org>
 <CACRpkdbt4+BzLcf3aOe_cfGzNTPtnzc34hE8GSGFa4-anzu9nA@mail.gmail.com>
Date:   Fri, 27 Jan 2023 14:14:09 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] gpiolib: remove asm-generic/gpio.h
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

On Fri, Jan 27, 2023, at 14:07, Linus Walleij wrote:
> On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The asm-generic/gpio.h file is now always included when
>> using gpiolib, so just move its contents into linux/gpio.h
>> with a few minor simplifications.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> After fixing the nits pointed out by Andy:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'm very happy to see this go, maybe you can send a pull request
> to Bartosz with these patches and also pull the same to the arch
> tree if need be?

I already sent a v2 series that should address all the comments.
I don't expect any conflicts against either the soc tree or the
asm-generic tree, so Bartosz can just pick it up from there.

If it helps, I'm also happy to send a pull request of course.

   Arnd
