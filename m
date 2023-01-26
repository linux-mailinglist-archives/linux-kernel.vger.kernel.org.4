Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F367CF00
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjAZOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjAZOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:54:29 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DAE4;
        Thu, 26 Jan 2023 06:54:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DD5BC320094D;
        Thu, 26 Jan 2023 09:54:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674744867; x=1674831267; bh=O65c494cb3
        exhJTXkFN/i23AZGvt2EvCcOJToJAR7dw=; b=b0VSJuSxH+vNMSrXy1BMSovjo6
        s/ReTGShWA135o7NrieDIxYUV/wOvVBCQYvR0iNPtj6cK9nQHDBAmpbitbf6LfFu
        gdllSCcQYxuvoTLeqS1/pjJC6IaDS7zt74H/0gVjqL+E5pmp2QKC6JQNIoxjVWnR
        q57tXCB1c4YUXMrbOQLIqGk4UXQbW4TKPfjW/mzxV78qxJuQmH20k2z177/vzztt
        UtLJs1+hRKNUKSv2Vw2xLH+RmKezly7SXFSq6Q4ad1jNJ4uxal76ybG6QI98BvAc
        SrIUkhE3GQNftBVyZzGHy3IBRisbIgJcdBpgeX8cCL69kqGSxauoVrENZIiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674744867; x=1674831267; bh=O65c494cb3exhJTXkFN/i23AZGvt
        2EvCcOJToJAR7dw=; b=PHj0Fnbh3jRfff0EzC9TYbbdKKtVF8Dob6X8pf6kmfSH
        LiECumpSUVOaCIT0tslzyGA9N2kyS08AhWxVoEBn2aVVMZmN4UswVqUrKpicqHup
        ZLw74pidZ0aaDCNEfiFveN1ShGRSMP/DTgiP6KkKCeAD6Qjg16O6oyAeEOifIZzI
        g8O35qlP+ho9Nmb4685bnsTYIXezKikomgNnSzTPbJjijVTyNlCAetsAfRi4jB+q
        8uHArkl9lzqT1EK4VVQ/5k+4vu8zqHTPDd89k/u4jh3N4aOdvhy7dPonojjy0rG6
        lYDMiuxxzS90ESsXMmH8IKadO1lVWpf1W4AZ2LvaxQ==
X-ME-Sender: <xms:I5TSYzAdZLnSzlyCCH1Z7zKiEhWEk4NqMT58EKbw9L0Diwcl6fNGWQ>
    <xme:I5TSY5ipD7LVFiDdXK8yNXzE6am5fSn4N1oPl3TvHppf1SutO_Yp2xbaJU2_Ktvrx
    VQ9bh1sQvtrN-_5dr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:I5TSY-kdigId-qQ0IuTOmrZw0UOxR5OzyPrTJw_Sq9lXu0uXHrtZ4g>
    <xmx:I5TSY1x-XRHn4rWxrE9K8YijLwBWQWYXYhbYz_sUnQIYz6scBsWnTQ>
    <xmx:I5TSY4Q5aeUm_QRORILC9LcCPjjA0ZtOHQQVy2FAcmGsmasYUY02Cg>
    <xmx:I5TSY9JgRwfIHkguFKrHvKVjN_Y3_GkzQlTRP4fivJ0HfKL75Iitag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5289CB60086; Thu, 26 Jan 2023 09:54:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a181b2dc-5e58-42b2-b689-882f66e6a3b5@app.fastmail.com>
In-Reply-To: <Y9KJR7u+oskof2v0@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-8-arnd@kernel.org>
 <Y9KJR7u+oskof2v0@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 15:54:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] gpiolib: split of_mm_gpio_chip out of linux/of_gpio.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 15:08, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:28:00PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This is a rarely used feature that has nothing to do with the
>> client-side of_gpio.h.
>> 
>> Split it out with a separate header file and Kconfig option
>> so it can be removed on its own timeline aside from removing
>> the of_gpio consumer interfaces.
>
> One nit-pick below, otherwise
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

>>  
>> +config OF_GPIO_MM_GPIOCHIP
>> +	bool
>> +	help
>> +	  This adds support for the legacy 'struct of_mm_gpio_chip' interface
>> +	  from PowerPC. Existing drivers using this interface need to select
>> +	  this symbol, but new drivers should use the generic gpio-mmio
>
> gpio-regmap
>
> I would even not mention gpio-mmio.

Makes sense, thanks!

    Arnd
