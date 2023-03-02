Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B86A85F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCBQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:14:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4518231ED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800E5615E6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14CC4339E;
        Thu,  2 Mar 2023 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677773668;
        bh=qkdMJ8bdUny5MwAHvbgjqEigN/ztwDrbYRTB1sHQUdM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=gVkPzKUgfFlkldVAHZfC7I9AoxhWZm1PZEuHHOmTPcV1ikpddRYZYplNbtbHq9mw8
         JpoCD395tb3gTge5QLQimBHYNqYAoCom/A0+IaraWSCiQpYddQDY+ArhpONIxynasQ
         GCfaZZM9SPpwtn9mmwtpiacMRzeMlCPY9XIMG58wJfJLUyGZZyB1j1jxlg6+DcZOBi
         Pmt26sVUGLKA3zpqQTjQ7nr6bl5I395+pCULGT6+i9jtnIstaQK+UUvUlPfGllXiUv
         36mo9pRtQdn2mE9Px8s6hpTx7XwRji12Pur8J8Zn8Uc6/wdfPcCHo79qxubI6VoHtH
         Kmjnzml3kSLRw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7337527C0054;
        Thu,  2 Mar 2023 11:14:27 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 02 Mar 2023 11:14:27 -0500
X-ME-Sender: <xms:Y8sAZODw9fvRPBLU4X1QFU6CBwrhJTtdU9ocEwLTAHnnw-htX-08Vw>
    <xme:Y8sAZIjrltS_m9kRaUFw5GRSr8i-MuMmyxixLQ43vT3olwU5thfACj2FDE2gpMrdo
    qAicNkjZCI4Dq6GHTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeljedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:Y8sAZBnRniSQqSjXFmEZo_CCvYvnD4dDnKAYPkC21jO0aFb3CNXuZw>
    <xmx:Y8sAZMzpav39QIvXittmwdHnaXBpGVseLCfKHYkf6gzmrtekC2lDlA>
    <xmx:Y8sAZDSY5qCPHOqviy9mcjijbvr2FNgvt5ThUDZQ9lZ56WGy328EJA>
    <xmx:Y8sAZCFOQbbzQEzR_02qpmwLb7uZInMyFTmVow4E3-Tqj3RngUZ53g>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3C8831A0063; Thu,  2 Mar 2023 11:14:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <51e60223-0d5d-428e-9126-2754020f19a1@app.fastmail.com>
In-Reply-To: <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic> <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Thu, 02 Mar 2023 08:14:06 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Michael Kelley" <mikelley@microsoft.com>,
        "James Morris" <jmorris@namei.org>,
        "Sasha Levin" <sashal@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Borislav Petkov" <bp@alien8.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "James Morris" <James.Morris@microsoft.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021, at 10:53 AM, Michael Kelley wrote:
> From: James Morris <jmorris@namei.org> Sent: Monday, June 7, 2021 11:47 AM
>> 
>> On Sun, 6 Jun 2021, Sasha Levin wrote:
>> 
>> > >
>> > >Let's see if Sasha can dig out something... CCed.
>> > >
>> > >@Sasha, can you figure out who we can talk to whether Windoze reserves
>> > >the first megabyte of memory unconditionally?
>> >
>> > That's a great question, but I can't help there anymore :)
>> >
>> > Adding James Morris...
>> 
>> Adding Michael Kelley.
>> 
>
> I checked with the Windows team.  Peter Anvin's statement from 11
> years ago is true.  On Intel and AMD processors, Windows unconditionally
> reserves the 1st megabyte of memory, minus one page used for real
> mode startup.   This is done to work around BIOS bugs.

Sorry to dredge up old skeletons.  Do you know *where* Windows allocates that one page used for real mode startup?  The current code in Linux has some bugs allocating that page, and it would be nice to sort it out.
