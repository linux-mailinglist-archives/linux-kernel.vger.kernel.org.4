Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053BE61E1A6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKFKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiKFKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:37:25 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048536411;
        Sun,  6 Nov 2022 02:37:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 76E4F5C0094;
        Sun,  6 Nov 2022 05:37:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 06 Nov 2022 05:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667731041; x=1667817441; bh=iZKiEdnklv
        /cMgHcGgFsT32PDcRiV02bsGomPmRflXQ=; b=lhD4XUnlgMF2qasljxzE262L5m
        OCC9icbfveMNNfzaSDF9FvqFI1bb4bbE3GyXsW8agJr4qy7FkehvSC1ETElCIibO
        FPIKhvA5oQI5yHwhKbzdmRQrqUrSMPOVw8YjVjvG9l/+khtkSJStjoaC2uxHRSVR
        LPfOyEg3ncp5MBn/762fUNjYh+XnOd/glZVzD9K7Uw1ctAvcYpdw+OWQAoNBFq4I
        v4lySq7Z8f2HbsF9cY6dxeudewajS7LKFHMBOAzkLn86FQVDBMBrQUVDgbETcLwQ
        Ybg14LvLyFMQqQmZpXECks1+8WLAeVkz26u7GKMd/8l6W8enIwrndXCvZEiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667731041; x=1667817441; bh=iZKiEdnklv/cMgHcGgFsT32PDcRi
        V02bsGomPmRflXQ=; b=TXGYKE9krWTVoKoQxB42ORrFNVkjwBgury1I/zyF6l8/
        wnUEhdZtrHdRYm4ng4huV+4ekV2o3DhOm7/Sk5pQr8pQqLcs4c5WZEq96dPPfo8Y
        DORzukAYuPWdv4cw3sQQk8cT0a6+/cGpB9ZSRGODUFgCC//Qo8aMMm3Hr7mjt6jm
        5HgQ0zvbjGCvDhuVCzCVmmb7Go4MEztIC6cp7vbSOFRBtfSnvAqGpSAXFNCeydGm
        tIsQN08eCaydeBuDXSvZrv6sa2E9TCWCuR5DbdyfFDX/W8uHBeLXZykTwptlIagV
        o9FNndXvTn+fb5dSwjrA4b6uXYQHvIUa7uTtckf5dw==
X-ME-Sender: <xms:YI5nY9EGVtZTQ8zpXcYaH4PTh1rRLfVpEh5QfmGx5FoXbEcq2r6G5A>
    <xme:YI5nYyXJYlvDSrFR0H2HSQ1cGwn97PC0GFlzR7S2-d3tFJFHawmo_bzGiLyNpoon9
    b9EN8Xlk21eGSmIUFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YI5nY_I6QyVLSOq9VG3vXJTxw7J4ZtG5pSaltM76YaBoVT-1djyPng>
    <xmx:YI5nYzHxkLyzbSwLuR71Vk4hQxWD4402C9odtwrAF1mZuRXp58Ui8A>
    <xmx:YI5nYzV82JW0EkCPX5FtLlBIKQmsAcHmbejL_OqxWKGVP3kHlw1uag>
    <xmx:YY5nY1LCBjpapUAaPXUMfFEz3dvN5UBnYJ4OWORMKHjhbkMe3aarZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23153B603ED; Sun,  6 Nov 2022 05:37:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <ab965f39-94b7-4962-a53e-46b88fd6ecae@app.fastmail.com>
In-Reply-To: <Y2eLuf4SCrZ5X+ui@shell.armlinux.org.uk>
References: <20221106062536.26369-1-rdunlap@infradead.org>
 <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
 <Y2eLuf4SCrZ5X+ui@shell.armlinux.org.uk>
Date:   Sun, 06 Nov 2022 11:37:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Russell King" <linux@armlinux.org.uk>
Cc:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] ARM: omap1: set ARCH_OMAP1_ANY for ARCH_OMAP1
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

On Sun, Nov 6, 2022, at 11:26, Russell King (Oracle) wrote:
> On Sun, Nov 06, 2022 at 08:43:50AM +0100, Arnd Bergmann wrote:
>> --- a/arch/arm/mach-omap1/Kconfig
>> +++ b/arch/arm/mach-omap1/Kconfig
>> @@ -49,7 +49,7 @@ config ARCH_OMAP1_ANY
>>         select ARCH_OMAP
>>         def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
>>  
>> -config ARCH_OMAP
>> +config ARCH_OMAP1_ANY
>
> This patch can't be right - look at the first line of context above, you
> have symbols that select ARCH_OMAP and you've just removed the
> definition of ARCH_OMAP.

Right, I misread this, I thought this was an 'if ARCH_OMAP' block
instead of the Kconfig symbol. Part of the problem is now is
possibly that there are two symbols with that name now, I'll have
to try to reproduce the problem first and then see what caused it
originally.

      Arnd
