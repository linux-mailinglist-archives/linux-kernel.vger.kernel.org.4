Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5606278D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiKNJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiKNJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:17:16 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15DA64EB;
        Mon, 14 Nov 2022 01:17:15 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E4007320029B;
        Mon, 14 Nov 2022 04:17:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 04:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668417434; x=1668503834; bh=Nbszh6yKWt
        PS+eiCWoyZeWj6ob3Ps/hY4GNNusxcFgI=; b=OWN2i4uWyQhbTciMs9PbzmT/0L
        0LM5iETi8C2bWOYXtBYs1VScxZyhYFqiL/sXqLkeAVtTqnAtLZlLLv2nnT8Ldq0f
        TqxuHAIjjVdVRZ5zXEuI2RPJ5flVFhhVj0bc8R9qlsl93L1Yaq+/Nnj2fUTKXroB
        Q+tJbJXtuY4G2d2jXuAyHMoryNAXvbFsJHOG2+48hjYVvOAMQvFrZYIfxTUKN4XX
        iOyABUuvbW7IrvN9k9axNqvwKv6NKCMCB+ll1Lbn0IF1/SSY7kebUqBikUKmDt6m
        TW7AOyXGPJc5ZVbcjz/Q4ZxGTVKlx2H/kcU9wlih+OjyY7ZfZgaiz6T7R62w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668417434; x=1668503834; bh=Nbszh6yKWtPS+eiCWoyZeWj6ob3P
        s/hY4GNNusxcFgI=; b=nmufghBSWlgMbkFlPpJtmPplJcRoFHdTCD/kip6GyH0H
        yRV4Na5TOE79NAX3QKyWa14zgK6XLc/EXn7H4J9xN7ooDrmdo6Aa24Ho7geUSOEj
        NGT1INXcdDWX7/Gz1uwH7lbI90GFwoUJvWVX0aGoUf8AuarMXbqAL1GYbZyGijg7
        nZGUhycZHP05gNhvvM3r7dCtP2XDKTgPRTAk6vf3gc0utQSZP8ZJNm1vXs/g7Ln/
        9MiNVy8ZMGPdYmFMlZlpFc5AbOLM4Jfu4fG/EXHeABcKiStmM9k44t+1SL8aVHCW
        fYFNS4cm8YwrD4lkb+NNtD0QKUlez/nsG1KXqLmE3w==
X-ME-Sender: <xms:mQdyY8oZ9A7GuGZza6fNY-cUfJNN7GDXccqDpNGpL8rlIkCeW6bCwA>
    <xme:mQdyYyqTSOc4HKTS40L2zw01bf-EKCHj7vkUMzhYjxQJN8JOFrpb9tfF1RWXsyXeZ
    2fSQa6EKIsM3kydsWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mQdyYxO9NryolxJAg04Qm2kFejU4gE2Nkb9vBGOhqGYZyUyzM8DGDg>
    <xmx:mQdyYz7_lF1fCRiNdRS0x_qV_ghL5ImEoMEus8WjHePvku3jvhr0ew>
    <xmx:mQdyY74lLgP1NyH_dfogpslGaKnDqUqlEqapGNtwcE4EjLBYKjLxYw>
    <xmx:mgdyY9nWCpQfp9z6v6SeNWzCqenlc3GgEGkA4tyY0wTvai1hgNpzHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CEB17B60086; Mon, 14 Nov 2022 04:17:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <1481d53e-9fe3-4605-8776-587a44fdc0ce@app.fastmail.com>
In-Reply-To: <23be5d9c69ae758602b9de97d47f787fa104961d.camel@nxp.com>
References: <20221114181752.08a850f0@canb.auug.org.au>
 <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
 <23be5d9c69ae758602b9de97d47f787fa104961d.camel@nxp.com>
Date:   Mon, 14 Nov 2022 10:16:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Liu Ying" <victor.liu@nxp.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Greg KH" <greg@kroah.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the char-misc tree
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

On Mon, Nov 14, 2022, at 10:03, Liu Ying wrote:
> On Mon, 2022-11-14 at 08:33 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 14, 2022, at 08:17, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > After merging the char-misc tree, today's linux-next build (powerpc
>> > allnoconfig) produced these warnings:
>> > 
>> > drivers/bus/simple-pm-bus.c:96:12: warning: 
>> > 'simple_pm_bus_runtime_resume' defined but not used [-Wunused-function]
>> >    96 | static int simple_pm_bus_runtime_resume(struct device *dev)
>> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > drivers/bus/simple-pm-bus.c:87:12: warning: 
>> > 'simple_pm_bus_runtime_suspend' defined but not used [-Wunused-function]
>> >    87 | static int simple_pm_bus_runtime_suspend(struct device *dev)
>> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > 
>> > Introduced by commit
>> > 
>> >   882cf4c913d7 ("drivers: bus: simple-pm-bus: Use clocks")
>> 
>> I see that this is caused by the patch using the old-style
>> SET_RUNTIME_PM_OPS/SET_NOIRQ_SYSTEM_SLEEP_PM_OPS macros
>> instead of the correct SYSTEM_SLEEP_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS
>> versions.
>> 
>
> You meant RUNTIME_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS macros should be
> used, right?

Right, sorry for mixing up the runtime ones.

> Why not add __maybe_unused to the callbacks like below snippet instead?
> This way, the old-style macros may determine those callbacks are NULL
> or non-NULL according to CONFIG_PM_SLEEP and CONFIG_PM.

That was the old way of doing it before 1a3c7bb08826 ("PM: core: Add
new *_PM_OPS macros, deprecate old ones"), we are slowly moving to
the new ones instead to avoid having to add __maybe_unused annotations.

You may however want to use ".pm = pm_ptr(&simple_pm_bus_pm_ops)" if
you care about the space savings for configurations with CONFIG_PM
disabled.

      Arnd
