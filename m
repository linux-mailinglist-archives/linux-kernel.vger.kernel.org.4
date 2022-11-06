Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACA61E1DC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 12:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiKFLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 06:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKFLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 06:32:54 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF760FF;
        Sun,  6 Nov 2022 03:32:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E10B35C00A7;
        Sun,  6 Nov 2022 06:32:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 06 Nov 2022 06:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667734372; x=1667820772; bh=6K0BZfyujf
        PvdESd1MNR55uYVKBC/EjiiOjPL9t318M=; b=eCva6IXGFYWLkOq1nPPfb+0iSo
        N3am0kneMy6ZrfVDBf6ZR/mhAmJnJD/U+WZwyE1SX9dvFTt8VeviXPK3/qBQ65il
        rt9wY5k5S/UDgF8km5juupldtL3qtU7JauZp03WwoE+qIgUGRMgrn5CEAzf267vd
        yYHKylKKDj/ed1inIRQ/1MQuCztxgsVn3JqO1tWvhbmDa8BdrbhuJEmOPVXFS0Zm
        4LJIqAmybUIaugMvKHfSSsVKLGj0Cu6c5WcAdZQwpVIVnxq6lRwSNDwoa6lJyony
        MyR7SbdjSF0cfvhtwikS2XyQGln4t7Qe8DNxfHZLak6ipJCQg7zGA/Y70p0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667734372; x=1667820772; bh=6K0BZfyujfPvdESd1MNR55uYVKBC
        /EjiiOjPL9t318M=; b=uAVmre9CnWD//kUvLxf7OYvOxd131jHlr4xSEEa8cH7B
        Y3Tz0JS5DK2yFbYJRWVcxWeT1DZwgzVk33bHwJ6qufgCTuUT8LBbOADL4Wr3bLMC
        dfMtMsYFnCNxeiofK7WAIxGhnszF+9gxdhfbkDx2HTW+61iCKHq937oBcw7bLwU+
        51jQm/2oo4ycAhUsK7lTz7rY+gQFih6runMQ9+xbAgqr8D8sbdbKimEqBa6UwB4M
        1HWSfjgpZPgN6rlayt8loCFiUJbNPcZlfy9wq57fEl00qnNTucvLfZb8cUhRSJno
        ukIUTdOCr7NJS5Y3yoDX/UZDIQnou/lAVesfSyR+Fw==
X-ME-Sender: <xms:Y5tnY7jPxwNpns1UF46fQnwZRbvBgJa8OHAS7ZVpj3xq8UVXMgp2vg>
    <xme:Y5tnY4DdSHYTzinI1SbTb_70aayy4DmHkQp80qRYBmbzhdOGQgkcDLdPctGf8oBOx
    C3hYjLSQDXXzGP_o_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Y5tnY7GnZ_2FpOOp9-VNBVhhVRJ9QfqunHGZGKy0JBHIGa4xJLzWQg>
    <xmx:Y5tnY4TY2l9bIxlJDIkA9W1mV1G9iwr0Nq4D6zDj1EFgV3k51Cmf-Q>
    <xmx:Y5tnY4yMqLzrtEVFypa9nLyak-pCxY0L-ihIh6wFdIt24XNjCt16-g>
    <xmx:ZJtnY_mSKFCovXAr9Nu9BdTHDtBo1oPm-nEuaO8nCEnV5KF_GdkSqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DF47FB603ED; Sun,  6 Nov 2022 06:32:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <b764ed1f-263a-47f4-962c-286fcf38fc32@app.fastmail.com>
In-Reply-To: <ab965f39-94b7-4962-a53e-46b88fd6ecae@app.fastmail.com>
References: <20221106062536.26369-1-rdunlap@infradead.org>
 <62f5b747-4c65-46a6-b04d-1d0fcbadf5c9@app.fastmail.com>
 <Y2eLuf4SCrZ5X+ui@shell.armlinux.org.uk>
 <ab965f39-94b7-4962-a53e-46b88fd6ecae@app.fastmail.com>
Date:   Sun, 06 Nov 2022 12:32:36 +0100
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

On Sun, Nov 6, 2022, at 11:37, Arnd Bergmann wrote:
> On Sun, Nov 6, 2022, at 11:26, Russell King (Oracle) wrote:
>> On Sun, Nov 06, 2022 at 08:43:50AM +0100, Arnd Bergmann wrote:
>>> --- a/arch/arm/mach-omap1/Kconfig
>>> +++ b/arch/arm/mach-omap1/Kconfig
>>> @@ -49,7 +49,7 @@ config ARCH_OMAP1_ANY
>>>         select ARCH_OMAP
>>>         def_bool ARCH_OMAP730 || ARCH_OMAP850 || ARCH_OMAP15XX || ARCH_OMAP16XX
>>>  
>>> -config ARCH_OMAP
>>> +config ARCH_OMAP1_ANY
>>
>> This patch can't be right - look at the first line of context above, you
>> have symbols that select ARCH_OMAP and you've just removed the
>> definition of ARCH_OMAP.
>
> Right, I misread this, I thought this was an 'if ARCH_OMAP' block
> instead of the Kconfig symbol. Part of the problem is now is
> possibly that there are two symbols with that name now, I'll have
> to try to reproduce the problem first and then see what caused it
> originally.

It seems the root cause was actually 804f7f19c2e2 ("fbdev: omap:
avoid using mach/*.h files"), where I started allowing building with
CONFIG_COMPILE_TEST, but this fails when ARCH_OMAP1_ANY is disabled,
as Randy correctly found.

We could tighten this gain by adding something like

     depends on ARCH_OMAP1_ANY || !OMAP_MUX

to still allow compile-testing but specifically avoiding the
broken case. I think we have the same problem in the pcmcia and
spi-uwire drivers, so maybe something like this would be
a better approach:

--- a/include/linux/soc/ti/omap1-mux.h
+++ b/include/linux/soc/ti/omap1-mux.h
@@ -302,7 +302,7 @@ enum omap1xxx_index {
 
 };
 
-#ifdef CONFIG_OMAP_MUX
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_ARCH_OMAP1_ANY)
 extern int omap_cfg_reg(unsigned long reg_cfg);
 #else
 static inline int omap_cfg_reg(unsigned long reg_cfg) { return 0; }


      Arnd
