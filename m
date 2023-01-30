Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F068050A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjA3Edk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3Edi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:33:38 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E381AB;
        Sun, 29 Jan 2023 20:33:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 154963200988;
        Sun, 29 Jan 2023 23:33:35 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Sun, 29 Jan 2023 23:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1675053215; x=1675139615; bh=GKe/s222U3
        vhZPpA2bjaG3/g7LC6X493Rq+JpuLEb/s=; b=rideqGucVqU9+ISCq1qjg/TOVa
        YIeI1nCSG2a51Z+bkOgCncmysDlaMVPHzckj3SpSnrdfvNGJ0BO+QuwdfWm69ti8
        YRQGcSmrBQSTADNwnOwoSaTH5LKTQFfGaNIa4jV9wev4J29WdBfyk3qK9QGvbyKN
        BvMVlSMRBoBzecSDF6fzku+OocDFRaxJTgfbzk+QmX1nNvsXVlNWQqPUxpDWX+og
        Etnwk+FRCr9DC1IiDfEwJEXRH/ZAi1i9vNQ4czuy32PZD5Y2+X5lhjgB+pmPK+dp
        U8cuz9NKMXt16fA1HUtnIv8H3tN0O52aw+w/IzGXEN6TFkbFLAVzyJRQDuoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675053215; x=1675139615; bh=GKe/s222U3vhZPpA2bjaG3/g7LC6
        X493Rq+JpuLEb/s=; b=Sv0dun/8c+A4fA1/5Y0T1+jOq7qanTLe6W+XY8/ewUNi
        gTX8rE50Wo9UAiGrJRiv8k6xoABZ6Ws8TRrMeupzYM3niMtUylMZK6CXO0caRngD
        GPfKbHW9S3zPqvVyPyKgm6RPpS4+MEgfIIHnxg+ZqgKuiruPcl3PEkc/SnUCPh6I
        yghOoyRveZ9rtH6RhM6Mn+LeGIT964rfKvwWs7p1uum45pp8510GMKXzd6JhjYKR
        vmMrS5nStvh4kQ4T/aEulcF346wHRcWUG6lYm1GrEPbrx6Wznri03GpVhmH2SdEF
        9dOHNxmk1n1qlrgzq+qQGxZVG/fdRx8rxqPQlqgqkw==
X-ME-Sender: <xms:n0jXY_4CcZPM1xjPFTQPyB8zDCu4rZw7ZiffjK10pSKpva84tQecYQ>
    <xme:n0jXY06W7J1C2Zgx3NS0_LxbHANTA7pM47Lhvx2kTRXipTUYFKYMfZTIJRfXg2RGZ
    ksHL0ecdeMHNws5vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefuddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:n0jXY2drDvgDR_a8M0wUPdxCBMKe6cDuVPzDqs1RdFn7Gh03xVqB9Q>
    <xmx:n0jXYwKxeSyQwAZy1ctNhbs9B_AhGtI3RWnVv_P7zBe2DiUrJNlLXg>
    <xmx:n0jXYzLu82pChH6yMic68slIVodPaUiSSfHLbuBCwHT6djKeq7WRZg>
    <xmx:n0jXY5jyI4WHyXtTWrmFoUoilsrc5PX1q7hEI7XRCfzh5M_C89zTug>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5E2F81700089; Sun, 29 Jan 2023 23:33:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <2fe78085-2ae1-42dc-ad96-b16703ca3abd@app.fastmail.com>
In-Reply-To: <CACPK8XcL-T_zv0aoeM5DJzGirp6dqD9UOn6=enSZDLao6hg2bg@mail.gmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
 <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
 <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
 <CACPK8XcL-T_zv0aoeM5DJzGirp6dqD9UOn6=enSZDLao6hg2bg@mail.gmail.com>
Date:   Mon, 30 Jan 2023 15:03:15 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Jan 2023, at 13:36, Joel Stanley wrote:
> On Fri, 27 Jan 2023 at 12:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Thu, Jan 19, 2023 at 2:54 AM Joel Stanley <joel@jms.id.au> wrote:
>>
>> > As foreseen by Andrew, this caused a regression. On the Romulus
>> > machine the device tree contains a gpio hog for GPIO S7. With the
>> > patch applied:
>>
>> OK shall I just revert the patch?
>
> Yep! I was going to send a revert but I thought I should write up a
> commit message. If you're happy just putting a revert in with a note
> that it caused a regression that's enough for me.

Agree, let's revert this one for now.

Andrew
