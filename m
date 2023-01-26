Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8E67CEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjAZOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjAZOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:46:53 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932368693;
        Thu, 26 Jan 2023 06:46:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 736203200948;
        Thu, 26 Jan 2023 09:46:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 09:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674744411; x=1674830811; bh=TF9eEYC8Cj
        kJdjJaoevmWAn17FfCvobcfWO0g5/qFzA=; b=qzYfU2WcyIUM8tBKeigQuzxf9d
        N1onZu/J4+fJVhaPsA6Xkq8gmW7Yply2+0xSzRIMtcuNP+DDdc/pOgme8Cg2dagn
        Gm9DAlfybbmfjlyB8Grh39c6cCMSORvZgenazF0Qb54XUwf8i5CP9xwaEENIAdmY
        rFthBYjSsJi10SGujm2svLWsP1iLpwpAtj2/n8kdGw10e/Vo2eZWVWYqevxOMjlv
        aFOUdbwpHkfw0zCKwbSf21LW5eZaJSk7DZBdrM4oyimueTiW6GbLsEFYDSRyE4O+
        7tX799UkIR64ByovEUmWqJXIdcygizAp3oQsp7GjNCi3sFo+FaBCRrGegVag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674744411; x=1674830811; bh=TF9eEYC8CjkJdjJaoevmWAn17FfC
        vobcfWO0g5/qFzA=; b=Izh48JijjIcqry9gdX1IgMt8QKReX12XAi+tojaBGJjk
        POBMQEa+ujw3hhDMVoJI3zOYYGy2MWYRfoNR8tO1+VPmpJDUJS5HHG2YS8rOG+Wv
        +lK2L/8ViHPX3Bc1rfCTJYcsanN09pvaBCzSqYUjQvReuSitLKdFjvqIEq+HDLjv
        9gPcI6p3m+uJ3q5iXqPqZrZ+BES1nSycbWg0eTVZFeRXW6PPFtk8eCfN260ylL9c
        jOqDf2/M1zbbeakttZc18n2F9dr2Slu+IC48rQafi2v79SKgtiQ+N/vHeJKPd+E8
        zVTgapj5hw1OObibE6+SmMEH9AFE/JU2SfOyr/IYHA==
X-ME-Sender: <xms:WpLSYziJfwp3f-MAft_eyvX4My_TEQ2UBC6x5XChxRBcb9KGDsCL7A>
    <xme:WpLSYwDZK2WxWfC84ZhLXY4n6c9seMgXMik3XxPpDmRyIgDghMBOO5MwVSvDDfYHk
    pZImlmllyazIg0WyX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WpLSYzG9AXy3jEo2LYYEc_XaaGD-4R-iEfKAqhZ0SPclqS3XXGSOyw>
    <xmx:WpLSYwQAx4jPWLF6bQDQzo0efYKIbwdHPgw35jzQXy2RhVsMYOb6VQ>
    <xmx:WpLSYwxesr5opPwr8Cce0xfcyYP8QBTRJivkbrwAwpUS1R2GpbbBnA>
    <xmx:W5LSYzyjPU6TLeWOUl82eyxPHDn5CTl-v5LdQ0OAmFawLoMFxm3tSw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A45B8B60086; Thu, 26 Jan 2023 09:46:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <0805b351-1661-4c90-89e1-2fea2fc98867@app.fastmail.com>
In-Reply-To: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
Date:   Thu, 26 Jan 2023 15:46:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only user
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 15:51, Andy Shevchenko wrote:
> GPIO library for OF is the only user for enum of_gpio_flags.
> Move it there.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I made the same patch independently, but you sent it first, so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
