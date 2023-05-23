Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E470DC13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjEWMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjEWMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:15:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67C109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:15:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 19DE95C0067;
        Tue, 23 May 2023 08:15:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 23 May 2023 08:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684844106; x=1684930506; bh=kA
        Ht+x8T70GQYnDSilrxwAJfF+iMwu+ILOsuFlWX27k=; b=deLIeor9mA+9amW33f
        LaNq3Uiu0xp+FUf1hZdSkFIRcPBUtbIsfchH0AydLqLdoO2ctMhAmFaCmDnLxxB5
        EeMzSuJPZic4ghBaYZQHCFy0x7janEbDESDGPmcacHdoLNVwPrMfcLswdu6rRx3W
        Qbcjp1tPGLq9TpikHCwma6ZceEaY6n37Km2aTq0gS3AZXADrq9ERsHWQQaMth0eK
        8SJ+ggMEJRoc5ygZb3BZGxNLfZ63AVTqsSGhWmgAYNOQrC5UFBemSDyKQmZwWsCG
        35k7evKNcjNlJsGTJQwz59GArwjDYSge9a32hMOssx1eBgziy1ki+J6+HqD40lHD
        x0VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684844106; x=1684930506; bh=kAHt+x8T70GQY
        nDSilrxwAJfF+iMwu+ILOsuFlWX27k=; b=J/X0Rp5vSLHvL02D95wXQVdpyufk4
        fPZqG90TzuBX+ls/kl0eOMjQqmIm9/BcAfskIOILBZc0PjscaPOJMbjR4JmgNtl9
        qiMfKeYqJfEOA5SmHvy2DK7I8uvCqiZTZhCIK5SZR+8sg37SljFNYR3kBfULLiGY
        M/UMdDHURRcsVS4L1BT43v9BfupXZ5RdZGw5+XGlNIwpfM5LpDmGUn+IbA8cRXbs
        htB1LANzq/nTDXUQsACGnK/8q1M/btmR6PmZ6JdludD1s1S28otDREPeUYHcXC4n
        +Mpgy5sr4/9jldOgnh/Zr2cxay/eOcO/2noaQ1lW3JOVNqym740SjwemQ==
X-ME-Sender: <xms:Sa5sZLms-AerBjtHcDsFovCAxL1bnO_DEBtDWD0o_C9NZFJdm6AjtA>
    <xme:Sa5sZO3ckcCcLQ6axu3pVpQx31YJ-OUgU8ndwMp9b7CS1uyFXv2u8k_ul7WwGK1uz
    HDKhB_BuDK3dVMtj2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Sa5sZBpXdDJgpmhr-SxGBtktcWW4AN4ltXRJ5YmnBTKWRGoKk_gCwg>
    <xmx:Sa5sZDnepR50fV5yc4DEpnFI7-XV0HJVupo0wl8rMwzukkFyIqiJVg>
    <xmx:Sa5sZJ2YFplueT419rIsYwfqgpJKdJihAtq6bQb2xJfSPx3i6lTViA>
    <xmx:Sq5sZEQ7vMTV343nx7kcUSnmGN1N32jAeNmvX9WvwMMdY42q0iTTkw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 69D27B60089; Tue, 23 May 2023 08:15:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <688172c5-fedf-42bb-9fcc-5ec28e83b164@app.fastmail.com>
In-Reply-To: <20230522174635.7acfb42c@xps-13>
References: <20230417205654.1982368-1-arnd@kernel.org>
 <20230522174635.7acfb42c@xps-13>
Date:   Tue, 23 May 2023 14:14:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: mark bits of ioctl handler noinline
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023, at 17:46, Miquel Raynal wrote:
>
> I am about to take this as part of my next fixes PR, should we Cc:
> stable? What is the current policy wrt gcc version issues?

I think in general we do want stable kernels to work with the latest
gcc, so please add the Cc:stable annotation.

      Arnd
