Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA636619E7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjAHVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAHVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:21:20 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8514E00A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:21:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9F3A43200034;
        Sun,  8 Jan 2023 16:21:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 08 Jan 2023 16:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1673212876; x=
        1673299276; bh=ZeFov28lEub7mZ5pYUsWFjtk3T4pDigrhvJlK0Umr70=; b=c
        z0IjIePHJkOIsYPUzRvCGFajitWXAEimQAIK8gLuIYKLsp+OWW85yqsJjtaz3Yi6
        iK1F9g5bLQNTyLkD85vvRuq/Vza/+7eIYhATrzotBRMEJlHrvXVFpfTSQG3In9z3
        EE7DrUew3XZWklL4PsK6fdyAjWuVp1qKlWniwoTidS198C2mEY3klYn3yQA82Wq2
        SCbBVfS9SyjZ0e7llMb+9BdNBB2JkHaVjvaArcKL+szsCWsPw0hmspbFIh4nCUN/
        xICd5/zlFx/ZznpiLnt6CGR6sR1mdLVzVvbshlGDQXjSDAik+mMWzR1tufHQTLsY
        JbFVbUdgTFA6hr3xp/JYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673212876; x=
        1673299276; bh=ZeFov28lEub7mZ5pYUsWFjtk3T4pDigrhvJlK0Umr70=; b=e
        0Q94dGW596tfWCa7LjODoe88Y5mUHaewW7NKglzno2iaaMyujB5OE6RxxHDTb5wM
        jPmqAv0uzE1IT6xyEqo9gAAnZ2sdaAtP5Y6vkE+1+ZAQdUZew45ekAKKh7Exqwzg
        2rUgRfTC2KghgERFWETsXyt/MCkj7dFC0yGJ0lZnbV/rLXzQhbP21PVf+CGEfAaw
        H/M/4jGO9hGiRFOSVOR/MDrhJdyWBkyW6IVwKf03WOysTZ3mCJTlew+LhgxB3NA0
        +OcCnZJTRImk6A9snu+DR5DYfF2zJaUj25Dim26U43iODULj3yrn5UL0VV6T6TfT
        M4aONRzGVFWbp5eVgUU4g==
X-ME-Sender: <xms:yzO7Y2W9uV50Qz7UA4CfXUdvIZcW-ObxJ4nFLRVlpLpfZ9Gc4q-4Zg>
    <xme:yzO7Yyl-UKz3N-ltMNEX3hoCmO16uIlUneA_4tycCDSDN_6HSQ6Tlkm05xnWD5KXw
    gN62kzC0dvLpXikb24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yzO7Y6blyoIpkalCUhzR3oSX-F8fS1kKg5i8dd9GO0qAmbk0HPxCwg>
    <xmx:yzO7Y9VXouiEkOeW7xKxNf-hOxjMdZLJAp_Q4Fysb2G66OZv12xQBg>
    <xmx:yzO7YwmIqNITfFpfc-RZgb49FGMQpZQI5Dw0Zuoa6puX6swi9ZnyYA>
    <xmx:zDO7Y2sY66u5NermH-mvFeQUGS_zDOPxm6z3WDQNH-p68zO3XC-jRA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3DB4BB60089; Sun,  8 Jan 2023 16:21:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <e10a1b03-9dc3-4c1e-865b-a47b26438c8b@app.fastmail.com>
In-Reply-To: <CALT56yOu=Kxxc=xUYvRpy5bD5XGB01cky_ppK8LbS4AC_ra5Bw@mail.gmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
 <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
 <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
 <7a57b319-a774-4f97-af06-fe1a637a45ce@app.fastmail.com>
 <CALT56yOu=Kxxc=xUYvRpy5bD5XGB01cky_ppK8LbS4AC_ra5Bw@mail.gmail.com>
Date:   Sun, 08 Jan 2023 22:20:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Baryshkov" <dbaryshkov@gmail.com>
Cc:     "Richard Purdie" <richard.purdie@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ales Bardorfer" <ales@i-tech.si>,
        "Ales Snuparek" <snuparek@atlas.cz>,
        "Alex Osborne" <ato@meshy.org>,
        "Alex Osborne" <bobofdoom@gmail.com>,
        "Dirk Opfer" <dirk@opfer-online.de>, "Ian Molton" <spyro@f2s.com>,
        "Lennert Buytenhek" <kernel@wantstofly.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Michael Petchkovsky" <mkpetch@internode.on.net>,
        "Nick Bane" <nick@cecomputing.co.uk>,
        "Paul Parsons" <lost.distance@yahoo.com>,
        "Philipp Zabel" <philipp.zabel@gmail.com>,
        "Sergey Lapin" <slapin@ossfans.org>,
        "Tomas Cech" <sleep_walker@suse.cz>,
        "Linus Walleij" <linusw@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023, at 22:12, Dmitry Baryshkov wrote:
> =D0=B2=D1=81, 8 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 23:05, Arnd Be=
rgmann <arnd@arndb.de>:
>>
>> At least locomo and sa1111 are both private to mach-sa1100
>> now and no longer shared with pxa, so this should get
>> a little easier. When I had last looking into cleaning up
>> sa1100, my impression was that the main work would be converting
>> most of the drivers to use dynamic resources instead of
>> hardcoded addresses and interrupts. Looking at locomo again,
>> my feeling is that this could remain largely unchanged,
>> as the locomo downstream drivers (led, keyboard, lcd)
>> are already abstracted enough and locomo itself can
>> just be an mfd or soc driver.
>
> locomo has been used on Sharp Poodle, if I'm not mistaken. And sa1111
> is used on the lubbock, one of the crazy devkits.

Right, and both of these are on the way out.

      Arnd
