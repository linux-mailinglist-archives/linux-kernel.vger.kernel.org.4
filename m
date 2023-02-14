Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A1695967
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjBNGqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBNGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:46:44 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9111CAE0;
        Mon, 13 Feb 2023 22:46:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 86DCC5C01D2;
        Tue, 14 Feb 2023 01:46:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Feb 2023 01:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676357191; x=1676443591; bh=oTqAQN5NSQ
        pjgNMlEppUGUw99RRxNTXywoGrVeMjO5o=; b=eUU1y23uKryL/wUxcIk2f5IM8/
        fgvqjCu9kIFCEWCnY2tw7ClSypEaX7mAztk5Ezv9H2X1PgaRr8t6ojb+xJjvIWhH
        NROuMGRTqf9SX1a2Ea2/LYytRtYUhV1lH/mA4h93G2lEPdEIgLDCgtmfzVPUrWtO
        bcjPO3PMj0AHj2DgD1j6pgJabC7DMlT92IJAyc7BQfO5gqtztQK2UhZLwNTIx8Bf
        BfNrN8KG/pnJ9dVrF2SW47n06nuxmme4eKPaaZnVE5astCkUjseVuf6J02EMoreu
        uMrMplZwr8GJHYvKMZj0q03mTUBkc9w3ixpu4Jv1KQn040ujsBG8vo4l557A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676357191; x=1676443591; bh=oTqAQN5NSQpjgNMlEppUGUw99RRx
        NTXywoGrVeMjO5o=; b=TgfNb8KJY82PRxdSGXxRIki60v67o1uxYgtN+zhZkp2q
        EKwAt3yu8S/qnzo2p4O4ItINfRXFlwgMNvQA23/UNGsVbp+g6ZNyZ8B18PeycXZG
        bTNAcbRD8CeT2QpwhsgXnQXMBvzl1bEua8HyAQEAtKp/ke8VLbGL/ktpG7Apj0c2
        BKBZjAeVPeYoEJkKtmbU3lLp6DDtyEQhn98BFbxajJpzWqunG9YgFfm1Wa4M3cod
        EtDqY1oOLwheCmlzkQgw6E6MggaxQquO0PoTiALukSfqn/gKiCfd6jjA0XI4H+7M
        ynmDgnbsb5evy4g8Zr6OAcRM9+y+jBj85GqmHwVugQ==
X-ME-Sender: <xms:Ry7rY3zq3u0PsToX5SqenJywW4PKy8j7sD0jWqkXBZef-D9ZCiKJ1Q>
    <xme:Ry7rY_Ra24gZpTjitFEKMxnrcbdUA94qfwBt12jqEBetDFUzy-4tiUy8ThR_7jAl-
    7Mfa5U87aK93w>
X-ME-Received: <xmr:Ry7rYxVKbcG8ISy7vGzSJ9VaDDpFY-9u-HlIckR2kIYsPcq2ssYGS8pHTTsZoqz8UYnwubwPvDP1AcijYUHq4ZdZV7D0rH80wIt0xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Ry7rYxjVVlIXsMs0mm7cuZbJ9j7ZwLB2B8nuG1i2CRWvXe1rrx6A4A>
    <xmx:Ry7rY5AP0JCHM7uigjzPxpldBYEvnh7XTeZyIADEidlwTwrrHcSlrw>
    <xmx:Ry7rY6KcOFC0Y81CJ0tEXzhoALSCpxzedYucyUIZE9ujbvcqHfw87A>
    <xmx:Ry7rY93hhqC-ZSC_nJAQe8dEL36RW0FLKpa1L34S6eKnU6CEsoH4sQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 01:46:30 -0500 (EST)
Date:   Tue, 14 Feb 2023 07:46:29 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <Y+suRQBtzCWx+mjo@kroah.com>
References: <20230214125700.606a89d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214125700.606a89d7@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:57:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the pm tree as a different commit (but
> the same patch):
> 
>   a0bc3f78d0ff ("kernel/power/energy_model.c: fix memory leak with using debugfs_lookup()")
> 
> This is commit
> 
>   a0e8c13ccd6a ("PM: EM: fix memory leak with using debugfs_lookup()")
> 
> in the pm tree.

That will be fine, thanks for the warning.

greg k-h
