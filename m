Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8898069508A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBMTWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjBMTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:22:53 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8F4EC1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:22:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7F86C320076F;
        Mon, 13 Feb 2023 14:22:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 14:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676316167; x=1676402567; bh=BL5FodN++K
        TbDK9wvPiZgDMeyaOd6mLCQejb8JmIqo8=; b=ByDTqqTzE0jYpZnzvYZt02rnAX
        HBZ0RHZ7WAXdvYuH/a1Go5xa4zuD549uu0CKjsKfQE0O/GKIVaXNzvwQNTVI8qAp
        DGATr8MPT1bUSpMhyeuk4jW8C0Q5lODpF/U7XJmQZ1kF/lglYUut9DYOrNTcTx2+
        iBGQClnPgITSL7zxjR5c0ZfiZYP623FuC/miNOIXj3yIizqXcaxQRv3r+HEBqgcc
        c0o2ZKSxXJdt85VC6roavN0Y6Xx/YP6uyO6I/j/8/wt8/7GiORCzhLYLP/UPmRoV
        Hk6obGljFI5Qg5oEHr92Hxk8wwbgkll/PIjCj1TaxxQ+iK3p1ban7aWnUI4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676316167; x=1676402567; bh=BL5FodN++KTbDK9wvPiZgDMeyaOd
        6mLCQejb8JmIqo8=; b=mCQSIf7Bfrkdmc4+Kjz9sqbpV2yarclg1pDVHoPEO6FQ
        kG963IFw2YZjKHtr3W+xYy7nPv+I6TnffX39Y9W7AChq+Y/zOOySIs6WMvTDneAY
        39iGg6mfl8UW7gYL7ENdo9My6GMD/mGR33rQwsaaObqbA6kDF6tmfeHaIgZvnXN0
        3R/sgQ5UKfmBmSnNnlanI/eWHzi8R6hw2+EWzsH6dzhPk1Tg0PTTtNU0v0RJftKN
        EAZ9seedqKe2+k5lneJrSXe9b/VEXSiooCamxgJqTecYbM0yI16GHtZJRqg0mEJ2
        k6Qu/zfNMUXj+pwjP3khDLRczTcyfFKOnsD/pllGYQ==
X-ME-Sender: <xms:Bo7qYze-_NC7wKcLtHxLOaW2YLHCHKzeui1aUWsYODphEHoJzT9pfQ>
    <xme:Bo7qY5ODLGPKj4COXYDawrlKH_zSgtLDMZCy9jKlngzP09LVT40yXRfsAlIIOMpHR
    gyYtC9vMwjuJFwU1os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Bo7qY8hvDvWYrMHI6Vh-w6_IeIGBKsHwFcvw09_zz4qY_qSiXduvnA>
    <xmx:Bo7qY0-01hAZuWAcp9IWVU8unlz97NsTe0wrIli1UZeeL7ZEHosJfw>
    <xmx:Bo7qY_uDgQiQQyk_RgPZGF5gKuf7xpQ7HNwozzorM8wmjTbz9xfEeA>
    <xmx:B47qY1UkeF7egjDy5YZ6ZvCMsTPTuaS4uTvrBlEVYAZNPa6TBCVHQA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32E90B60089; Mon, 13 Feb 2023 14:22:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <2c8a8539-649c-47d2-b416-6d607cba5956@app.fastmail.com>
In-Reply-To: <CAOgh=FzCOvv86HG=AhCBDW6cUHDnzq8UPBgmYPR12PNNMRNx0w@mail.gmail.com>
References: <20230211091302.4576-1-lina@asahilina.net>
 <CAOgh=FzCOvv86HG=AhCBDW6cUHDnzq8UPBgmYPR12PNNMRNx0w@mail.gmail.com>
Date:   Mon, 13 Feb 2023 20:22:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eric Curtin" <ecurtin@redhat.com>,
        "Asahi Lina" <lina@asahilina.net>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Do not copy the reg state structure to the
 stack
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023, at 18:15, Eric Curtin wrote:
> On Sat, 11 Feb 2023 at 09:21, Asahi Lina <lina@asahilina.net> wrote:
>>
>> The register state struct is 848 bytes, which ends up bloating the
>> apple_rtkit_crashlog_dump_regs stack frame beyond 1024 on some
>> 32-bit platforms, triggering compile warnings.
>>
>> This doesn't matter for 64BIT/ARM64, but there's also no good reason to
>> copy the structure to the stack in this case. We can use __packed to
>> avoid alignment issues, there are no double-read hazards, and this is a
>> fatal error path so performance does not matter.
>>
>> Fixes: 22991d8d5725 ("soc: apple: rtkit: Add register dump decoding to crashlog")
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Merged now, thanks a lot for the fix!

     Arnd
