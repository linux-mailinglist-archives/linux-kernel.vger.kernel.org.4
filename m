Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB77218CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjFDRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:19:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A7D3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 10:19:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5E3FD320090B;
        Sun,  4 Jun 2023 13:19:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 13:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685899183; x=1685985583; bh=wS
        OEKEurWAF+VcZsiiHB+3LhvZ5bUw8O1z/roOZuKHE=; b=dqtTpx6+WgkKZ8Jima
        8A5b48rRsD/cTDKekar08ZRznEP6n1GwtVDfWPG0Ycv+6rx3XI10v4+U0VyY9Uu9
        DZ/UJqtqh/uvsFjnUk11H4Y3IQDNp1ClbwekHHgSHmjG9f6uXH119Jz6BMMPUV3S
        3AwrAWT/slmwsd2PRU0E0hJEyIcd101DcNmK2lP81cDFQ73dflSVlFWrO1VOjeFk
        2Qlgo9o52GZBTU4K2ul6PAUxVBLbuQQqjWhXhbqTcx3VCyzNH3Qf+loaarJbgPix
        zMbJq7gjEZJCSj9FH6nAzULtxeEX8RTdLhB5WrTLduTdX6bQCEDNPjTQT0Gr/NkX
        HPcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685899183; x=1685985583; bh=wSOEKEurWAF+V
        cZsiiHB+3LhvZ5bUw8O1z/roOZuKHE=; b=ddeGSA5R5RmWO8z19FXXzrDZ10iXG
        PI6IdRcU6nCMWLa0kLaUF/Ol2Ty+qNpSY14+mqphu0pah87TXt+nYp9G6VWn7tuP
        JRt6eLyIvoFmkhD5tarjcEM0T0/SMxD+/maVX0dyBIodxAlKs3mvay0ZbY65G+YY
        vuMWnOMfTL7ayey349+/gVUvhkaMiCReV654avuztH2n7vGb4p5lsENV14Sq5ogl
        FulL0QtV7LU3h0zk+C0vRjTzkSOB05zF1htwxIFZIk4TTTxjLF0WJhOOEoydcAJH
        53CxCVb/QTZ1CYdEalSOY4DGQfEUf4FMkXSjHF7q0ilpriE7YVL6Y0Ibg==
X-ME-Sender: <xms:r8d8ZAOgYIZYDHsOGqB-vW_Jw8C_nQnsiwqeyRGFSplkr_zhGfTWeQ>
    <xme:r8d8ZG_voGvIzCWODolFtbbg-OEAg_YAH8LoURIsBEWUUGxNAPzzbMEYKkYD8sKzQ
    jKnz6pr2cnEr_hSSgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeljedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:r8d8ZHQEWF7iHY6nj72nkkixv16dDo7EZ0IVERdOGCt1In90a-YxKQ>
    <xmx:r8d8ZIuJTTeEDud66hnZVbLhNMfTJZJNd-PXBndsM4oOI0ynZWf0vA>
    <xmx:r8d8ZIc2_sfL6xy02j720vpFsjk4MuTZZoZAWH0XyRgODamOXHZuuw>
    <xmx:r8d8ZAQMkiyj5El1ukVSV7sTQHA_dRKbbEdWftfDw_OcQ27M024QZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3189BB60086; Sun,  4 Jun 2023 13:19:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <44c969a1-8dda-425b-acf3-9a80dfa60e79@app.fastmail.com>
In-Reply-To: <ZHudRkB1YcMD_DaQ@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me>
 <ZHudRkB1YcMD_DaQ@surfacebook>
Date:   Sun, 04 Jun 2023 19:19:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Nikita Shubin" <nikita.shubin@maquefel.me>
Cc:     "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Michael Peters" <mpeters@embeddedts.com>,
        "Kris Bahnsen" <kris@embeddedts.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 3, 2023, at 22:06, andy.shevchenko@gmail.com wrote:
> Thu, Jun 01, 2023 at 08:34:00AM +0300, Nikita Shubin kirjoitti:
>> This us a rewrite of EP93xx timer driver in
>> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
>> the device tree way:
>> 
>> - Make every IO-access relative to a base address and dynamic
>>   so we can do a dynamic ioremap and get going.
>> - Find register range and interrupt from the device tree.
>
> ...
>
>> +config EP93XX_TIMER
>> +	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
>
> This is strange. What do you gain with this "if COMPILE_TEST"?

This ensures the driver is compiled in an x86 allmodconfig,
like most other clocksource drivers, but it's hidden on
all other configs without EP93xx support.

As long as the platform selects it, this is the normal
way to add a clocksource driver.

     Arnd
