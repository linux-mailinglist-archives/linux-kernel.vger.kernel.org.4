Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE367CEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjAZOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:48:08 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FB14EB3;
        Thu, 26 Jan 2023 06:48:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E0E4A3200913;
        Thu, 26 Jan 2023 09:48:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674744481; x=1674830881; bh=Ikfds1YMWM
        XfkYDKpZ0oyh7tgsn8rQnio3EI7WHo2RI=; b=ieZpph3I7QUd34QO5gtVM8HMSM
        vStuDzXUVmWNDTUshYyKKbD+X2lhom6BuU/OwgmEZ30f9ORYxhlvTqX4Pw9UEnVP
        0ZFOkKrH8X3ifHS3FbBAFFgTJw1emshGoDoLxpTabfzj9VjTLSpPNtSj+BubcBce
        y8b7dKrtl9ObOg8V3nFGicz7gicfnFmi0ORewBhXwrA8OMceRyV8jwUCNDY9XGGo
        isJ0nNKSUMZTBuTvznTQUwzYIGxhQtyZvSUVwVKIEQrHBULFnyPS/DQ/XokWmOtG
        LxG7CfOdCZ0GOZcWc5Z1h4AxirmKzH8sVPgB/7S0mxXLCGeQ73O11f0d5jWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674744481; x=1674830881; bh=Ikfds1YMWMXfkYDKpZ0oyh7tgsn8
        rQnio3EI7WHo2RI=; b=JoxW+bqzPshSCFFbE4BMnmQmltTl77+MqJC1JnGcaElo
        TSKj58FZi4uXwWaJgLBli9YE37OoWWavwI/nV8n6jKRq5Hoo/yAmlRVG2l40L6ha
        8l8nEPGWmdscB4J0aNvuuSrkTdgEQXzwfw60+qGHKPCubMMuiPsTkstDLMAW+BOo
        7MQYkjdMNDV+G0k6A8btX5+s636LdTcaUYKAPu3PVcFBNG24WCNdR9v+4+x+bRva
        wjkHTucA8yUEwc5D68ZkT9ppR25RRuoiQvaTVzPzwiy2ryNnWuKTelzixsP1rMHm
        q2ZO42Ycc4JAB2qY+h9QsHRC/8MTuy4k+ThOy6Smvw==
X-ME-Sender: <xms:oZLSYyAkE3LN1HSqBBluBB3_XgfBAySeeLIcNwdLxTKJSH0V0QlK_Q>
    <xme:oZLSY8g9ERpwM0zExkggZdDmnTWQNDfsqHMRiF9b7N-n0dbgg4OLubY1Fi2xRoCAa
    k7bh1uae-crmwj8MJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oZLSY1lWmfLRuU6dxLWBCE3hR3JkDZjVl6Q61Uy3yrUTk-X7Q1gX_g>
    <xmx:oZLSYwwmzRvJwKOcgKfMQX6J7IoCvIVHNLoSDMRIsO36lkxuoSiuQA>
    <xmx:oZLSY3S_290wzjVaAOG8No5wUT7aHzeBTx17VPG3xZIjVi0vBH4TyQ>
    <xmx:oZLSY4J5Ze1EGxDj30-kW-IVGepgpbknRYzjpqeFQwbtcT9PSBt7WA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D031B60086; Thu, 26 Jan 2023 09:48:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <21657e6c-1101-4c56-91e3-6b2f6f9e10c9@app.fastmail.com>
In-Reply-To: <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-9-arnd@kernel.org>
 <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
Date:   Thu, 26 Jan 2023 15:47:42 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 15:09, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 02:28:01PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> There is no need for this in the header any more, it's just
>> an implementation detail now.
>
> I have published
> https://lore.kernel.org/r/20230112145140.67573-1-andriy.shevchenko@linux.intel.com
> Can it be used?

Sure, I added a Reviewed-by: on that now. Your patch will conflict
with my patch 7/8, but we can work that out.

      Arnd
