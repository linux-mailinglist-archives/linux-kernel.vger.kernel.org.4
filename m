Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE367D038
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjAZPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAZPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:30:36 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B94237;
        Thu, 26 Jan 2023 07:30:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B6CFF3200A42;
        Thu, 26 Jan 2023 10:30:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 10:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674747032; x=1674833432; bh=qa/tB7wF18
        5XNn4m113fg18kkUi0fAWOfHcu8Yt9hZg=; b=i/XmVRv7jVbP6KCx0Q95L2glvb
        hTiWqVlpOKQIPPPZL9F6rUU48rSBe7fGjoHJ2TZI0lK8tkDEYbKSKe/3Gw4JQbpq
        QFXgiJsA2HXE6kiooXcCal3dZOlNYm+lEVDRmQ0QiXYN0SP7itz3PCOqekrdGrX8
        yMXoxH/rXObtRFy/M0DNOiq8T17d4sq84FRyWC1tqDBmalaUFYuLG2fQJSVBghKA
        c5uQEzDghd96xGbjw0LYWreRIaY9SmKdk4+tzo/uyLFWCriYz9WOy9szMDnBiHGP
        VHODF+ouNH6uYUf5Gv+zbNKiyuJATw+IJ/Wy0CRBrSURzRuxv5es+FCtQR8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674747032; x=1674833432; bh=qa/tB7wF185XNn4m113fg18kkUi0
        fAWOfHcu8Yt9hZg=; b=c/4r8sL0zFdTjWg5rlum5t6Zg/dUGBmIgr1i1cWYW5/F
        7x68u9CSz2H86NHd98cFNNlelFMeieEpB5N0u7rLg8Cd5hr267qsrmVxf3x3nWZE
        lu8brV9WbiF1chzzgWEnILthgZZhsUrStlKvevoBrW/p3Bgjzj5BxnK3JxZ8U9q1
        QTHZ23JpfY4o/TB7FvWTFIMBt7Bz7ZX67tUoGSWBf9VPyoWfS09pJn0uNQWfX2Zo
        XuVEJPXrKCMGbMp7a9W6flArtQ1YQcNhgrX/eXOOW/dTtakDVfgDBC0Vnix6pxvT
        tED7kpEaH8WT3Yq+kfN5oBSjTFAIycUw3daAbzwCvA==
X-ME-Sender: <xms:l5zSYxb3Ul49zgt8VC0luA1zk4atJc7ng_g39gTV9UB14vDAiSr35g>
    <xme:l5zSY4YUj9c9NLc7RnQOfmiaL1evfuTh-a9ZMxNOVRoyS2WYL6oOciu5WiojoCamI
    mE0eN9qZTBnOm4WkVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:l5zSYz95RGvW9bZQ7jEWmFZDoU51I65oPCjebWlIauOHNXlM6FrjPA>
    <xmx:l5zSY_qlDd5rnm37EmEvWJvI7NMAc_Hnzeai_Uy2RQWoRMknshsSpQ>
    <xmx:l5zSY8oLqtl-p8rRoO6mrDRzV-7dEPN1xwQj_6YIs2eJiYMxDq7CFw>
    <xmx:mJzSYxBWv4-L5BD9svArqbTrGffZFuhvDDsgy2NmMKMlvbFva6GbNw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B63E8B60086; Thu, 26 Jan 2023 10:30:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <3d7b86a3-ac70-4459-a6c3-24046e81be0e@app.fastmail.com>
In-Reply-To: <Y9KFENOgVGC2bUAj@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-5-arnd@kernel.org>
 <Y9KFENOgVGC2bUAj@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 16:30:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] gpiolib: remove gpio_set_debounce
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

On Thu, Jan 26, 2023, at 14:50, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:27:57PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> gpio_set_debounce() only has a single user, which is trivially
>> converted to gpiod_set_debounce().
>
> Also need to mention the gpio_cansleep() removal.

Indeed, I think that bit got lost in one of the rebases
after some of the other functions that I originally
removed here are already gone.

I've dropped the gpio_cansleep change for now, we can
revisit this later and possibly drop it at the same
time as gpio_{get,set}_value_cansleep that are still
used in a handful of places that could use gpiod
instead.

> P.S. Fun fact that I was yesterday thinking about the pretty much
> the same change, except intrusive conversion of the user.
>
> ...
>
>>  Documentation/driver-api/gpio/legacy.rst |  2 --
>
> Documentation/translations/zh_CN/driver-api/gpio/legacy.rst:222:        
>         gpio_set_debounce()
> Documentation/translations/zh_TW/gpio.txt:229:  gpio_set_debounce()

Fixed.

>>  drivers/input/touchscreen/ads7846.c      | 24 +++++++++++++-----------
>>  include/linux/gpio.h                     | 22 ----------------------
>
> ...
>
>>  #include <linux/of_gpio.h>
>
> Do we need this?

Dropped now.

>>  #include <linux/of_device.h>
>> +#include <linux/gpio/consumer.h>
>
>>  #include <linux/gpio.h>
>
> And this?

I think we still need both linux/gpio/consumer.h and linux/gpio.h
since there is still a call to devm_gpio_request_one() and
gpio_is_valid().

    Arnd
