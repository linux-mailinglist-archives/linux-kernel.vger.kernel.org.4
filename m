Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750860C9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJYKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiJYKTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:19:16 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C0144099;
        Tue, 25 Oct 2022 03:14:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DD3355C0219;
        Tue, 25 Oct 2022 06:14:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 25 Oct 2022 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666692881; x=1666779281; bh=mbtl4BXNRq
        9JJk803nUONhImAHZ6xfcC6jtFjkVSL7M=; b=TGfzSgdccEs/oOLx2bESIEPDG0
        ptZDZynyxZm4KeHaXMmr3Mg413MHvhlg4BMhad3jleNuWm5QJ5+YUWIhNm9yrYfN
        9tiytTDOOtRaO/7Uj/qLJo/bzvY5kQo66DZ5xOm6VhV2KZTRExlFX9OvwzJts3Rn
        Khd33FOrNyzfnCI/VumruxwH1e+yyrgZ4+0hU1HX8shzpWla3wyogVtMs/o77ngk
        S6eoj1N7d0rrWL1sh8ZbSHoRS5zfdViJByOEKZIPWBirb2y32ExlDJ13B5RnNa1j
        0u1tGmVstfpFERrznLuxbHfFT0LUy5OcMbpy5ZtlUAmzZiM0m17K4apeS15g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666692881; x=1666779281; bh=mbtl4BXNRq9JJk803nUONhImAHZ6
        xfcC6jtFjkVSL7M=; b=AQF1oGrCmtkaZ1hRNlsKmaUvDA0DdicPWLqVKT6EqLmW
        sSVJa+/B5Sz5XRxCCz95mg6ZEmlrmxqVpeGodcDXkMrG2VYqo9BBMuigSajdkC7m
        FTaHWu+ev55OKL+8PstOUneCLItsPBDOnhIZBrUxiGaR5025PB1UKIRQ+KaLahNI
        EtJdAMX13h86bmNTAKys28gsJojCGrrJ7O3aPPYbRKaB3K3olFjy/V8PEWJDvUCs
        I9rS37KOFdOH/9tj3kcKnUh86J7rI+4w6jkD6jkjQWAu5zSN3S1uU3pgc+08V0LW
        w3zCV8+0zRVOoXVPDjV1fp1dinvtIePxf6rK8qc96A==
X-ME-Sender: <xms:EbdXY734aMHygivFFYRD9b4w55uMZ0Jzhnse3kT0_rsXzuwqaf-gIw>
    <xme:EbdXY6HSXSU_s5f6rRregsUVbWsVx7IM-Y6SKn14_60UzKi8oy3SEFjqnLY6D5IPc
    zPAB4gAcGWwnHbLBhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:EbdXY76s-_VrbBSoHpLWdlwHgBMsQavAQpnlSBFze4s4VTvR-XH7tA>
    <xmx:EbdXYw2tZiGmet-9VD-QmrQmDJvJ0hs_vy4YjwgUw6rWrjJ6deaPaw>
    <xmx:EbdXY-EgcYJlrHPsvoNNUfGJY11X9SVjPHOg9V0PMhy5ogS4i8Uodg>
    <xmx:EbdXYz4Hqi6tL-p_NZqEoqUF3nEXsxVs_y-BVNUc3HNnXqSnL4pg4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27918B60086; Tue, 25 Oct 2022 06:14:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <e21edff1-1f01-40d1-96a4-5b77a16dccb4@app.fastmail.com>
In-Reply-To: <Y1eeEQr/E59uIE3j@shell.armlinux.org.uk>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-5-arnd@kernel.org>
 <Y1eeEQr/E59uIE3j@shell.armlinux.org.uk>
Date:   Tue, 25 Oct 2022 12:14:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022, at 10:28, Russell King (Oracle) wrote:
> On Fri, Oct 21, 2022 at 05:49:34PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Commit 59a2e613d07f ("cpufreq: sa11x0: move cpufreq driver
>> to drivers/cpufreq") added an unnecessary reference to
>> mach/generic.h. Just remove it again after moving the code
>> into the corresponding driver.
>
> So how does arch/arm/mach-sa1100/clock.c get the MPLL rate with this
> change?

You are right, that's broken. It works for the defconfigs that
enable the cpufreq driver, but it seems I need to improve my
randconfig build testing to make sure I find problems like this
sooner.

I don't think anything depends on this patch, so I've dropped
it from my series now.

Thanks,

    Arnd
