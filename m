Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97068DBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBGOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjBGOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:45:53 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81D1BD3;
        Tue,  7 Feb 2023 06:45:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D8E45C0196;
        Tue,  7 Feb 2023 09:34:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675780469; x=1675866869; bh=AVCUu1MGS8
        jO+7PBj7/h/6q0QIji1++TygwsCvCXgFA=; b=Ohn5a44HCVWZixV9/E2k2oqAbo
        PaqllPYG63xXI2UeWsfdIUgRN/SP8xSmNthGhW7dOutxSSc5uhxMiv4kbPPqClMI
        dyc2ILYQRSQhSD3cgxUc8QmSIVlj3tj9CstZhZXqal/+0pxvF43I974bbB+/HTjd
        ad3Y6OZmlBLWeva7Ri8TnI1b/6sOboklYD0Zl9enJ+9KZT5nTwv++ULMp6I7UC/e
        N6fra/2AuKq65R6F1hgepGPxZqTgVsk8TBmB8fS/twgw8xeGEDMpaEXyr63mC63o
        ijSid+KMOo35M7OEau1ppNY+jL1u0WdzyWPS+E4oJ8A/LMVg3P7YNORy6A8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675780469; x=1675866869; bh=AVCUu1MGS8jO+7PBj7/h/6q0QIji
        1++TygwsCvCXgFA=; b=itoDtjY6+ry+GHdfHAGYuaRGyQ8h3i6PWeWFrKDeCPsM
        HKULM/SZ16GfzaUmNp7oGfBA2cSamCtJ83Cj34DLNNbKB4G8pea4dx4b2qyxeIxN
        NLIstfsepEdhu36phnto21uFCBzeGQf66X5MgibGpX5Ym3mImw/JLeO7n80cfS5f
        pR/Sp8TaYYJeeEzyPF+Zm/IpjF+sSVQnZCk03Tz65PydcVpyTsijL7f05mQxvlwC
        SOpy0Y+/c1jjJug1QC5/ryXqtQjvei+1pQG6Jq9HQEKSBLjEg3IyAGN7DuSN1WFY
        G6UWT0233+dq1A2J3pYeQbvim7Lie6lxlv09EmTX+g==
X-ME-Sender: <xms:dGHiY-uRNR-cKvzVBEHQJj2HtWilXm_u5c2TMJtqS3sWtcfW4w5Fsw>
    <xme:dGHiYzdfggGuTImtQAiCbW39Hm4_EcAirl6MIXBOIXs5fHNmh_6rec-kcU38RoCs6
    IKg3aIuqbaEA-b-qNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dWHiY5xMIjaeIG45LwPnmGKEpD14PL7cJ8QZxyJXKa24zsLHRpH6Vg>
    <xmx:dWHiY5MyIgp4SKed-gxDMjEtixZCjLyRGJp4pjA7r27TgY_nqUVHwA>
    <xmx:dWHiY-9ex18D_l2oN-nLz0ON3SKEKLgUe3hUhIGeuP_iZB7hgznZkA>
    <xmx:dWHiY1mPYutPxqSRXdBx0FFglmFEw4jnIdDHE5Mrd21Vs6xiKTyXoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EBC62B60086; Tue,  7 Feb 2023 09:34:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <7974a715-db69-4693-b8c8-543c5828775f@app.fastmail.com>
In-Reply-To: <Y+I1Orh74wR5Sese@smile.fi.intel.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-5-arnd@kernel.org> <Y9n8P1rP+cYyoNIH@google.com>
 <Y9qwJtOaKrgB5n+T@smile.fi.intel.com> <Y9q4d50lSdPn8myb@google.com>
 <Y+I1Orh74wR5Sese@smile.fi.intel.com>
Date:   Tue, 07 Feb 2023 15:34:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] gpiolib: remove gpio_set_debounce
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

On Tue, Feb 7, 2023, at 12:25, Andy Shevchenko wrote:
> On Wed, Feb 01, 2023 at 11:07:35AM -0800, Dmitry Torokhov wrote:
>> On Wed, Feb 01, 2023 at 08:32:06PM +0200, Andy Shevchenko wrote:
>> > On Tue, Jan 31, 2023 at 09:44:31PM -0800, Dmitry Torokhov wrote:
>> > > On Fri, Jan 27, 2023 at 11:11:46AM +0100, Arnd Bergmann wrote:
>
> ...
>
>> > > > -	return !gpio_get_value(ts->gpio_pendown);
>> > > > +	return !gpiod_get_value(ts->gpio_pendown);
>> > > 
>> > > No, we can not blindly do that without checking annotations on GPIOs.
>> > 
>> > But this is easy to fix, i.e. use raw API, no?
>> 
>> I'd rather not (I hope I can make this driver respect declared polarity
>> at some point), so for debounce we could do:
>> 
>> 	gpiod_set_debounce(gpio_to_gpiod(), ...);
>> 
>> in ads7846 for now, and get rid of gpio_set_debounce() as a publc API.
>
> This will work and we can keep it for a while (gpio_to_desc(), I believe you
> meant this one, is part of the new API to keep this bridge for the cases like
> this).
>
> Arnd, are you going to send a v3? It would be really nice to have less
> collisions next cycle if your series is applied.

I was planning to, but I see you beat me to it already, sorry for
dropping the ball here and thanks for picking it up!

      Arnd
