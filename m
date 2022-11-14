Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAD627670
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiKNHeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiKNHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:34:04 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12C2ACF;
        Sun, 13 Nov 2022 23:34:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 996C8320090C;
        Mon, 14 Nov 2022 02:34:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 02:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668411242; x=1668497642; bh=tg5u0gr/GF
        HeI84as/hj5YvgUNQOQ5UK5W+kE67Zre4=; b=YP8E2ZwJSSGN0rUdiTQ+Kdr4lZ
        NQygbLTRMlYT+QohBzqNeDfU53BoaWEO9x45BicXoU8kl4Q6/26Wa4T26/dQgjvb
        vG78n820nnyje7eNM1Xv76OzB3O4MF6YkB7FtPlISDubhMLiXfL6p050QWohjIiE
        FiwPPkv18h6w1rRTcg9awUZHt9t70xNZ9P1omA3Qpxm0ReRsDG5fEeCmLBgkTYHe
        p8sO4gD095+nMEmVJS+IjvaS+5rMyi+ZBizOA0fQrXRWLyLFSaOaS1+h2m9NAR4+
        0FjaFtxA0ZEkf3h4+JKJlf80LRzK+G6miISPQhxKe7OmjWbHh5e7q/d0fK7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668411242; x=1668497642; bh=tg5u0gr/GFHeI84as/hj5YvgUNQO
        Q5UK5W+kE67Zre4=; b=C1yMFrux8xuyGuUlY/gjSlHDztT4/Vdccn0ZLI2v3TJq
        z4pDe68yfFfl7t0WLWTyceNy28VPbAe13Mv3iAFkxcTXv9xCCfiSaZOtqieEGxGl
        dRrg5kiyF2ZxjQAZLH1g5Jjpw+V3AT1oJie72zk0sCZXqVUekc0notrOI9x5UsO5
        00QXMx2kS0gskD4N8QAtK69wpnMiS8gMTCsXIuCnrD9nqJyMz9b+TD07nnKEI4na
        sqSVyqAZRYUBkWNQBiH1B+dTqNVlRp3hYEIIBjFLlKEDEPfsjmDWD1TFZ2jk5/hZ
        dh2D90kMz0wq6b8KWpz1G6KJlS0zUzloD1rONc9a/w==
X-ME-Sender: <xms:ae9xY-lzcX8B1p-DuG0avR6MGl2-tLaad-QOBLBIFXdwAe3d74ryCw>
    <xme:ae9xY13MM2LizqU5iFZNiciEcSGFp2-px8PYxsazXZPtULx_Us3baT1laWj8IaH2c
    WfF4VjCCeaQXiS4umg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ae9xY8rpxVwLm422m8eBnyqQqJiAvYHBknGngwh9Ne8fbly0Nerf1A>
    <xmx:ae9xYylza0dDketpbSNvhSqAPIofsraBxfHJ17zYrz-48zMpBD1RnQ>
    <xmx:ae9xY82iRubFENNzfSKg78qmKvELr8M8mMohFj-edc39y6XJNBupzg>
    <xmx:au9xY5w5suR1IEIUyCclwSFp3l2bD4y3b44zi5JYLMsHpzR5abq_dw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0299B60086; Mon, 14 Nov 2022 02:34:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
In-Reply-To: <20221114181752.08a850f0@canb.auug.org.au>
References: <20221114181752.08a850f0@canb.auug.org.au>
Date:   Mon, 14 Nov 2022 08:33:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Greg KH" <greg@kroah.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Liu Ying" <victor.liu@nxp.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the char-misc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022, at 08:17, Stephen Rothwell wrote:
> Hi all,
>
> After merging the char-misc tree, today's linux-next build (powerpc
> allnoconfig) produced these warnings:
>
> drivers/bus/simple-pm-bus.c:96:12: warning: 
> 'simple_pm_bus_runtime_resume' defined but not used [-Wunused-function]
>    96 | static int simple_pm_bus_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bus/simple-pm-bus.c:87:12: warning: 
> 'simple_pm_bus_runtime_suspend' defined but not used [-Wunused-function]
>    87 | static int simple_pm_bus_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   882cf4c913d7 ("drivers: bus: simple-pm-bus: Use clocks")

I see that this is caused by the patch using the old-style
SET_RUNTIME_PM_OPS/SET_NOIRQ_SYSTEM_SLEEP_PM_OPS macros
instead of the correct SYSTEM_SLEEP_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS
versions.

     Arnd
