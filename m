Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76267E7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjA0OH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjA0OHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:07:25 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E330CD;
        Fri, 27 Jan 2023 06:07:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FFB55C03FA;
        Fri, 27 Jan 2023 09:07:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 09:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674828444; x=1674914844; bh=tmFRvlKVvX
        DK9iy2Pc8KgmZTSRXrarsd78EnwvIZO4Y=; b=NOtYL68bWQPKMRjr4X7bpnbbxz
        7eSWvJQzxTv8J8AdzG9IcB7B+Jw7UQ+xdJ0Mobfll4DzZj3owFqI/VhbP7PofLQ5
        36GLBxIXeCkDeiwo8qd8W+fjWd3amKerM1ZmlE4z9qw3s+2E6y+hmEfgWQhfKEO0
        3VciIznrSHHSNuH6bNCdHRKrO67DnzxX6+i/Y7P2Fx4F/3sWRTA7nfizaeWkyW7J
        jVg0wkUh2ZNZhlD1ZQuGHGpW7FzhPqyDXNYnunLoF1i4DWtMlXxxlKPab2XiBDEw
        QUOJwQd/JtcbR5P69IZoq3c8I9ekLmbta6s/INr+BcNJikUkkYCeWmLT0kng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674828444; x=1674914844; bh=tmFRvlKVvXDK9iy2Pc8KgmZTSRXr
        arsd78EnwvIZO4Y=; b=FN3ast6dbSwkvPmNhF3nBjkyVcryjx2FY4iIo20ELF0J
        EfvZqE8TP7/siXO2K7jBbHYA2ki2UUhCuORZq9KiVIiBKJkF8arsuTWbSdDn7LEn
        MsR7Yp3nL7gIwYsdpKmo5ejLqWdlqqqq81ddjaFgHQ1BbVdpkRFa9yaxIDbsCdaN
        3KNZxrN/fsrtJqRNB+GAbAHmx5stST1UB1G2C5q+L6seQYvqf6Us0hG6hpHRb0fV
        Fbz0jFs+8PvOTf+e0AM6G5+yBv0XSSdpFMc5g2FJkV9P0GrsZHcA/I+k1XjbHsNQ
        HzEQ86aD95W0CQT6rMOqNkE7PBYqVWxLcjhGCvxy2g==
X-ME-Sender: <xms:m9rTY8FKaB4Xpf4We-V4MeXKRupaSyB7FHHOFxU8H9qf3IJyjNFMyw>
    <xme:m9rTY1VWczUnMFWi7NFzuGJHZJZQhVsoxbsxQKLoZjreM_jypfI6DjJl7CjXbLLb9
    J0Ai_sZZAsKh8MT788>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:m9rTY2J4aKVshpDMSvJHowbnPtJuXJJHIoklfy2zUI80FnWDDCBEzA>
    <xmx:m9rTY-G53oR5P5JpEDgd538rIQRYQmw0UJ_GY4amcvxPXN87piliDg>
    <xmx:m9rTYyUPhWNsOGOtpRVSQH5vGUA0G2yBQZOMM-vN5yF1s8ZucNCsPg>
    <xmx:nNrTY0fVd0D0JNmtfcg_uXjKp-Jgbr-wcu5yN-rlJtIcbyapir72Jg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B634DB60086; Fri, 27 Jan 2023 09:07:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <44479469-3079-4654-a08b-aeb0e45cb1b4@app.fastmail.com>
In-Reply-To: <CACRpkdZDm2enFM=0AoDre=GmF+NHv+ZX9=9LdZ_KAcUJ5ta64A@mail.gmail.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-7-arnd@kernel.org>
 <CACRpkdZDm2enFM=0AoDre=GmF+NHv+ZX9=9LdZ_KAcUJ5ta64A@mail.gmail.com>
Date:   Fri, 27 Jan 2023 15:07:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] gpiolib: split linux/gpio/driver.h out of linux/gpio.h
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

On Fri, Jan 27, 2023, at 14:39, Linus Walleij wrote:
> On Fri, Jan 27, 2023 at 11:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Almost all gpio drivers include linux/gpio/driver.h, and other
>> files should not rely on includes from this header.
>>
>> Remove the indirect include from here and include the correct
>> headers directly from where they are used.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> As mentioned on v1 you will need two additional patches to
> avoid build errors from the bots, perhaps Bartosz can cherry-pick
> them?

Yes, that would be ideal.

> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=gpiochip-no-driver-h&id=73ca8058a7b2075c993040bdc92b6a82f57d4316
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=gpiochip-no-driver-h&id=89f4f9cc70c686303679e57bdc3ac86507979fe3
>
> (Maybe the Viper cf adapter is deleted in the PXA boardfile removal so
> it's not an issue. The HTE file needs patching through.)
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Indeed, the viper support is gone in linux-next, which is why that
change was gone from my series after rebasing. I have the same
HTE file change in my tree that you have, but misclassified it
as an existing bug rather than one caused by my patch. The maintainer
said they would apply my patch directly, but it has not shown
up in linux-next yet.

I agree that for both patches the best way is if Bartosz
applies your version before my series.

    Arnd

[1] https://lore.kernel.org/all/38f2d681-80a8-dc97-e5ed-4886e5e3bf7c@nvidia.com/
