Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9D5E646B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiIVN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIVN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:57:16 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2341E94129
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:57:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E1B2580B6C;
        Thu, 22 Sep 2022 09:57:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663855032; x=1663858632; bh=xquEvF32oZ
        eAy+4+ZGxnweXGIHjmVmhHF1L4vIqjJ0Y=; b=UoOo/s4wMqQWmtf7QYMPz3NuV8
        hNEU/xh3YLEuueCw1HJ51Gppzjl2NeGUjm4OE+DdOq6u15Uwi3uiM8g9wbgMqy9X
        Y8uxHUXPFUF1P16YmPOBcKNk1zVRipJnEu5o8NKU6Xb1aM9p+Z31u6AWNBKn4xLg
        5meNYWA5BrBgyRfPy4pv5irc7agJ4OqHHrl88pv/Wk8tG7FZeSNUr3M9jJV0ZDuP
        W8ylB3jZZ+h6t1gvS8nY27IupkKVAx8N0zcd/LJVan1flx0Q3sL7DCSuPzeZQix/
        VK3vXYAL1nZSNSPCDHqwRn0RguZ4WNY1GVpdaJwrskZfRdo/KfUik4Pvg0/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663855032; x=1663858632; bh=xquEvF32oZeAy+4+ZGxnweXGIHjm
        VmhHF1L4vIqjJ0Y=; b=TqCt7hVW0SqiylQqk5CErjpjo6XuZ3ppZ8Sbht4ZghDC
        5d4dvPEFVVkRabin5Hczpcdpl8QJw6xTugUfNWyg05XtIQIkUmPEPt4HwQknYSGD
        6mSSBffriLsBraY994pKXuMJLEHnSleB5MPEhaj+T2KJENyNK0Yt9no1IaK0/9qe
        JaIYxl3+4LzgD8mtsvbh7nTlOewXit1p7eXxb/Se3vnzADBz+vqzfKSDsduXVLPS
        0weLpelPz3SyVHn9k0NFOZE/DnYStvRGmRNu5AKfZ9s39Py2bjIQJ+kDWCNlbfMz
        DS2qprC+YwNPeHMXQAeQUaD+u2UmBAhd7CJTW+7JRg==
X-ME-Sender: <xms:t2ksY3D0eRzI5mI5wnUDzvbJ_YYUYw1NSb5k4wh5hBKJ6XP3UACJ0A>
    <xme:t2ksY9jPv3DYlWnBmi6MyKIVOipMiJXBqQRe6W3nshV6JcX-R6cmbAxeTlajD1Oj6
    ovbJ7FUO94fUNKA45c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:t2ksYynn5zj-Cx4M7oYfCLCWtyl_Fl9JzPwBqb5ERhzmGQzhD575Dg>
    <xmx:t2ksY5yuG4FU3FZYnpYlp_Dse46l3Wh6vJ3p3ba9Md7zDMLQwBILvw>
    <xmx:t2ksY8REvVM4GiauEXF18iXKFg-Ybkp7j1pRq7h2tEYn9I4oTdZETg>
    <xmx:uGksYxKd4n-KmJ_AvZe_8mW4iw-_VIGKFnNHBYMxyOb1ijSc7J1W3w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5C45B60086; Thu, 22 Sep 2022 09:57:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <51275e33-c791-4593-84d1-eedad27d7fd6@www.fastmail.com>
In-Reply-To: <20220917234918.8b94d2690b8533bd47cf64e0@samsung.com>
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
 <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
 <20220917072356.2255620-2-jiho.chu@samsung.com>
 <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
 <20220917234918.8b94d2690b8533bd47cf64e0@samsung.com>
Date:   Thu, 22 Sep 2022 15:56:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiho Chu" <jiho.chu@samsung.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ogabbay@kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022, at 4:49 PM, Jiho Chu wrote:
> On Sat, 17 Sep 2022 09:41:13 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>> 
>> If you have the need to manage multiple devices here, maybe use
>> a dynamic major number and have the chardev code allocate the
>> minor numbers, instead of using multiple misc devices and
>> doing that yourself.
>> 
>
> I'm little confusing. It means that managing own char devices is proper,
> not using misc device? But, it's still under misc dir.

There is no strict connection between miscdevices and drivers/misc.

The former is for drivers that tend to have only one instance
in a system, while the latter is for drivers that do not have
a separate subsystem.

     Arnd
