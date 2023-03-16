Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF36BCE33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCPLaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCPLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:30:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49316B78B6;
        Thu, 16 Mar 2023 04:30:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 22A555C0121;
        Thu, 16 Mar 2023 07:30:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678966206; x=1679052606; bh=OY
        lavnWqoA5P30TlUOqzAKcU6nmTHtWjKSta9ojFhs4=; b=GxWZ7pBs0uzumAjxw4
        JE0ujAL0NjBjwdM2nrCpc4PHTgj4I4jsqscG6cf63wZPCvjw1DuNlSSxjoROm6N/
        C4RjmHAES8C0T2jsX5RmBobAWZkpJgl/V1d5SrqfLXmYvZ3qjkDRdgosbYj2ieo3
        NorlGyW8Ih8zzqfOoXmLjqMQ70hZKtRByTOj4ZfF3tZ+X6UyxSzNobiS2isnQK7U
        rJYkhoClItL5mcqbA8E5Awpbz9AcSQZH+LTWMFQdWpM2cRDr3nf4aLXirS+9RUF6
        FOWj93w2K3eTBSeNJVKu8vV6g34tyR/OnTb+C93lW50KAl+3okOivJ6kelewZraO
        l62Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678966206; x=1679052606; bh=OYlavnWqoA5P3
        0TlUOqzAKcU6nmTHtWjKSta9ojFhs4=; b=EBLn+svO2LjqZvaiqME5IPe7TVl3u
        i0z1bwyH/RBn8FORXafPof9fqSbFKvVyjl3q0OWhWzmrU9cW1tV6wO6Go/R8OBMe
        TG11SRPItVY/MycF1YSn+CS7UrB1V6Za4abda0qpIzu/kAGPVMvsmXEZgoKU4Xu2
        kqO3w0QtufP7C/2sT/vVmt2yzows6F8pKVA7lWBoZftCzlpnKpt3GHphX7WZAY6/
        XJGNHEFVKiCkyUzSwL8x8HnV7K/umhYrBaP5qDks9s6Vl9mdM6F/MsZKUeSAfCjK
        yP8U3tl8vnfoQptZjdtjRjoR6kC0SZjiRzhuGzB011P2h3C0zVYTjvxkA==
X-ME-Sender: <xms:vf0SZCtoQzcX8ev-l5qiDca1DS2q9ce3ZI-RJNAgvC8Xt6x0nuj7hQ>
    <xme:vf0SZHcY5LBbEJxGNk0I8Gb1NDnliPEKGD9Dpf2hmStc3hxZYFHtAwT2fBtoIt4YO
    _rB-TKCF8NHblv40qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vf0SZNysLfZx7rt65LGFMJh3HzICAqlJA1j7yRpSmRKgugET8z1P_g>
    <xmx:vf0SZNOtc0K5Rly1w6ZjhJAFPVZD0N4xQbINTjCVYSiFCkMeabpauw>
    <xmx:vf0SZC9ZNK5okppGsCAB7UIe9JfMOVVeIX0yEgmhJcHqMgnm3bNGSg>
    <xmx:vv0SZEK9ucnnG6vSWLW9zt3f4iolI-1mc043tDNYdm9IF0cHvJsS9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2913B60086; Thu, 16 Mar 2023 07:30:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <ad11a961-d355-4780-ad08-f73e9b40a1cc@app.fastmail.com>
In-Reply-To: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
References: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
Date:   Thu, 16 Mar 2023 12:29:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove obsolete config BLOCK_COMPAT
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

On Thu, Mar 16, 2023, at 12:16, Lukas Bulwahn wrote:
> Before commit bdc1ddad3e5f ("compat_ioctl: block: move
> blkdev_compat_ioctl() into ioctl.c"), the config BLOCK_COMPAT was used to
> include compat_ioctl.c into the kernel build. With this commit, the code
> is moved into ioctl.c and included with the config COMPAT. So, since then,
> the config BLOCK_COMPAT has no effect and any further purpose.
>
> Remove this obsolete config BLOCK_COMPAT.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for spotting this,

Acked-by: Arnd Bergmann <arnd@arndb.de>
