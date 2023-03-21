Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE06C2DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCUJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCUJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:30:52 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B230F8;
        Tue, 21 Mar 2023 02:30:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DE6B53200B6C;
        Tue, 21 Mar 2023 05:30:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 21 Mar 2023 05:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679391042; x=1679477442; bh=+E
        ypSQsK60sfT/bFJ/jrHrCRBSgL7jrmaK2N/Q19Plo=; b=KCo5tMqSoan+ASkjyf
        MzAsfV1mcekU9j4T3uzsD9rJFZUu0oM4C3lLYkADQKB7YFwyZAaeJlK1d9mFtCiw
        RPi2FZ7o0ZTu/bqMvMtM3SGkdSH63NdboLl6baFh4+BoNDzgqcDH+ik7n/OGjT9P
        ycU+sXfvLUDVJpn3+G43XWHV3f/SC4QPZvqiA5cPUXH5MpCM9a5qUe25yv7cw3Qe
        ajY/8A8rQttSlrzEZqG+4f2xvR/zKBEKrs6ngetRuHzeWFP+hpFGrsmQ4Gqqqst2
        5RgMiHZzTLZnQjvRw+kdLdBritgMGMozuKK9bVY9Zan/q8Lm6pX9j6eMPawciAo6
        pM5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679391042; x=1679477442; bh=+EypSQsK60sfT
        /bFJ/jrHrCRBSgL7jrmaK2N/Q19Plo=; b=T9N9qT610m60k7w9/Hx+v2y+hUyHa
        EtQCht93ZrhO85hiI7dZ0cH6djJZBX73LAsHKdxvXrr2R4V0F/+aO8A1ffJ2z2Ly
        BcOFHNHBX9EXnifsH+OuM5nzwQBguBuEQehngX+JAPHYD/TBroYD+LmSzTqjhaLJ
        FQERaHN8mENDQIVUd/UCPMJAMCioD0ZAxm+SkHEx0FIP17LqyrtMZhsgVhGcVJso
        hrFSrwbx++K4mSa6Qnmc0VYuOaGGQnne1s/tLJ5NV4+svmt4vQ/fonfzlzsQAro+
        WAY3cvgiJmutKxqDnyarApud2jjZCk/Ymk2L/hDEBIJSJolrXk4Gwg0yg==
X-ME-Sender: <xms:QnkZZMkrYMhumZnlOiLzLdNZdGKLgRgPdKQonSkMtO-UrXSyvP3r3w>
    <xme:QnkZZL1Wi6tph5D9I4fXiq9IS6tbNqqeoZ6g0vcWInn-mjz7QZIF5QtGOmOXC5oSN
    RVAdxX8Z0HZqSixf1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QnkZZKoU3g3J3iUBK7QuIDx4XjZhAwRLUzT4wtecFJgjxWpoBDLFbA>
    <xmx:QnkZZIn0uisGvHanxlLmoZuMvdJ5rHr433-8aMF0PCgMbYcNyyNP6Q>
    <xmx:QnkZZK343A7b9Z_xQNMphaQzwKKhXidSgkmtAv2KiV8ZluvEc1_BXQ>
    <xmx:QnkZZG-PB7USSheHECWfpCPN8ST5Doo474bz5UoPFgL5xv4-iOIacg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1FAB4B60086; Tue, 21 Mar 2023 05:30:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <59c05b36-3370-4d7b-b8cc-39d6dc36cdd0@app.fastmail.com>
In-Reply-To: <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com>
References: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
 <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com>
Date:   Tue, 21 Mar 2023 10:30:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daniel Palmer" <daniel@thingy.jp>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Romain Perier" <romain.perier@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023, at 09:33, Daniel Palmer wrote:
> Hi Lukas
>
> On Tue, 21 Mar 2023 at 12:38, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Commit 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7
>> SoCs") adds the config MACH_INFINITY and MACH_MERCURY. The MACH_INFINITY
>> config is used in the gpio-msc313 driver, but the MACH_MERCURY config is
>> never used to configure anything in the kernel tree.
>>
>> Remove the unused config MACH_MERCURY.
>
> Because work is still on going to push that stuff.
>
> nak from me.

The symbol has been unused three year though, and will
show up every time someone runs a script to look for
orphaned Kconfig entries.

I'd still prefer removing it now and only bringing it
back when you actually add the code for it.

     Arnd
