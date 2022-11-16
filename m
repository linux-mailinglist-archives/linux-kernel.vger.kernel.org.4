Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F462B3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKPHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiKPHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:01:38 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0C19027;
        Tue, 15 Nov 2022 23:01:36 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 106C95C05D1;
        Wed, 16 Nov 2022 02:01:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 02:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668582093; x=1668668493; bh=nzD5q2NnrY
        heETr7ybMU8uZJqqWF9hEOlEN7kCuh2Zk=; b=jdPkzlc0/jRhxtJ3E+u4UUofIs
        y435r/VMELOxBMnPwSkLc1kZ2NOXdHqcG1LlTPNCkmN/FYk/VDIqsP0iHn9Mz4Fu
        jvzo4NSBGs64pS9lwYOinRKt4rNZdYT3OFfBOv3dLKktid//naNKY6A4VISGw852
        +cOfpC7wVTAefno+1MIfDfYRK8rE+gPdue/ZhzMjnG7/+hiZLqEwvbF17DWuzxda
        MRK/ugXP1Yyv9CfYaBLiQm0DCfwkC5zC8UxANXGcCQsmKyrFWx4Sxd7INXURsBRb
        OZK1xIKyDfLIxxLve0MBMxaqmWp1w0ga0WZDzOEVcUL7tkR1SL4g8iiH/avg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668582093; x=1668668493; bh=nzD5q2NnrYheETr7ybMU8uZJqqWF
        9hEOlEN7kCuh2Zk=; b=IzCFC7O9CQh2be5i5obyABQrbraUlKyKuX94VgmdsN5N
        mAe7/5Q0dqrx3MIAARa5/CsNte+ZhWzx7vn8XU6xFG92WzLoO7tHUT6oKFlxZOwV
        uZDvketZxVnsrBVuncr9EqINIzLZxRMRQ0lHUilvvlK0ph+iK8kKfEZL1GQ+rLq7
        x8hCpm6SBNCsCU4iH2or/xetFOgbl/oK8WDQ4gj09ncnx+qerunILn/ODMO+VxrK
        05Al8fU/kkLlaxxzlheoO4K/OQWzROrAK5SPMrxV68LB+3O8WJS8I1uQiHKhRV4K
        v7EU0VO6ebkAKv7n8SRim1wcNXvinUOggatnb75l2A==
X-ME-Sender: <xms:y4p0Y4GsaKA0STNDhEtqJjFGDkhuFWS_U0oTy5kQofCIjP-9aTkQ_g>
    <xme:y4p0YxV1b4Rnrc59f-SiSH63Pu0QpfhmRe-x-EFfP3waCdrDAXKsmdMG6YHhajfRv
    sfqT1a-9flDaISmTUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:y4p0YyIQYqM87982VXIGCGCPgsP1T2fBjWcznpaJv9Y2TZbNerV2YQ>
    <xmx:y4p0Y6HWekv9srmPb3_Fw3ntugUT5gJOvzQjH73MfYdsWoSaFlC-_Q>
    <xmx:y4p0Y-XM0TbuR2_UczrcFYrkAHdC2dvs8CKf_vQ2y1gwWaAoLZsGDA>
    <xmx:zYp0YwdWtWWwd73Z6vkzv9o_1T9iK3CB0wHTbHXut5ZX1ptvj5rb0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB79EB60086; Wed, 16 Nov 2022 02:01:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <c5e8ab50-aacb-4651-8893-a6dd9edcd155@app.fastmail.com>
In-Reply-To: <Y3QNzvAYo9y+yyTf@mail.local>
References: <20220908115337.1604277-1-arnd@kernel.org>
 <Y3QNzvAYo9y+yyTf@mail.local>
Date:   Wed, 16 Nov 2022 08:01:00 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Alessandro Zummo" <a.zummo@towertech.it>,
        "Reinier Kuipers" <kuipers.reinier@gmail.com>,
        linux-rtc@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
        "Yang Yingliang" <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rtc: y2038: remove broken RTC_HCTOSYS workaround
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

On Tue, Nov 15, 2022, at 23:08, Alexandre Belloni wrote:
> Hello,
>
> I'm fine with the patch and I'll probably take it, 

Ok, thanks!

> I a an observation though:
>
> On 08/09/2022 13:53:20+0200, Arnd Bergmann wrote:
>> +	 *
>> +	 * Since the kernel has no way of knowing what user space it runs,
>> +	 * warn here whenever the kernel is able to run it.
>> +	 * When CONFIG_COMPAT_32BIT_TIME is disabled, we know that the
>> +	 * system is safe, but unfortunately this this is currently not
>> +	 * supported by musl-1.2.x or most glibc based user space.
>
> I was under the impression that musl never had a 32bit time_t nor used
> the 32bit time APIs so it would not be affected by the bug.
> So I guess the only affected userspace is glibc without _TIME_BITS=64

It's actually the opposite: while new versions of musl only allow
building applications against the time64 interfaces, musl itself
uses a mix of the time32 and time64 system calls, and the musl
maintainer considers turning CONFIG_COMPAT_32BIT_TIME off a
misfeature of the kernel that he does not want to support.

      Arnd
