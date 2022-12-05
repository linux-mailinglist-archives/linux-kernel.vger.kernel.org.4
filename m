Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD2642400
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiLEIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiLEID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:03:29 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED8E28C;
        Mon,  5 Dec 2022 00:03:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1B57B3200918;
        Mon,  5 Dec 2022 03:03:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Dec 2022 03:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670227402; x=1670313802; bh=2PeOQw77mZ
        Is4RmHtQcQO9RXZKB7n7lnwirONUp4eN4=; b=FGSiTdgTga/y5yzAwvfi6jpH6z
        AvxNlBFv2FbdCNOpUX198CwWkXG2zzEO5w+JS0Yq1008RTjNStzLh5ONIASvXC9+
        sW5wGlxkmot/uU1cZx4fskNCXaDSDhI6SGs1W5U3HRj7pzGp1IAA5TLw8sjwlTsq
        0H0cKY/7BuTnvE171Xv4dkjTScgNj2c/1H6Ff54av0ycxoemKUqyulZi/ark9COh
        hz9p9OUfU5i5JUPMtiCSX+690Y2gVOsIZtAvjUsHoIY67evUpL45BPgY9LAWWD+K
        dynjM3QwcJhXARtcUA8fm8QaknPJFPouifKMr8/IUdNKTyN/B+RnhqItySHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670227402; x=1670313802; bh=2PeOQw77mZIs4RmHtQcQO9RXZKB7
        n7lnwirONUp4eN4=; b=Q3/lQ5uvVUTK8HDPOhkfRo7XS2VQK/jdYOuMzokpYROV
        prGjlhSz5U3iLmHPTwLER9aCqYZU4HqW2v4k6LRU3wnrRwIHsuQ7lrxXjjVPpQc7
        nnYxCAfkp31tInDpFXwqeSoCUnIhFTl2gXwe23EV6/JOkWuXqF+Fv0Ek4AmImJu0
        XtEK26aHf3rO1GxkiGtFSesMS6S+EaSjdIy1CJS3NyXPAV52uchFflfBz2nVimSZ
        veeKuR4q5Z0bI+pIdW8797st38KGTsazgm7EKkw2gefnhZ/0ieLPvvsIwHZC5e88
        Xaq27l3EwplXpQn8PppYajspEjcgBzySgHYM8gMGsg==
X-ME-Sender: <xms:yaWNY3JLkBK_3AJwpNC7-pl6Gu5Ad1OmLRokp6BEBCYVpFWs_hacBg>
    <xme:yaWNY7KnRjz_mgDJ8x0e1npc908Qy0GCchvRcN9-42vYQGtGCBtLHvk-9PN9XsXKx
    Ya0Y14Wj6CvQQ>
X-ME-Received: <xmr:yaWNY_uqNxBsLDxYXma6wBbycs-_bEXanX3dGiM70gteLxVjGlB0BB8K4xMog4dVvFu_4pSx6WW-bCP22a4G8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:yaWNYwa7mHm321x4KGk7JGRoexQ_cYEWOqBre6laNfAkPRH5SvNRYw>
    <xmx:yaWNY-bJ2tduEeH6IDbsqIsimtc4p4fJIDdvAd9sGrq8-CvO2OOmow>
    <xmx:yaWNY0A3e45uiE5VNBK7wVtaurC9bQoJ2vFvRfTKkhhJnqXMEG-9KA>
    <xmx:yqWNYzNxT3I7paFVxIzF50fbiXkeCCaYU1q0S5lEgOGGkiWi1A46IA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 03:03:21 -0500 (EST)
Date:   Mon, 5 Dec 2022 09:03:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the driver-core tree with the block
 tree
Message-ID: <Y42lxp8WyoVAL2QX@kroah.com>
References: <20221205131152.26c49399@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205131152.26c49399@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:11:52PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   include/linux/blkdev.h
>   drivers/block/pktcdvd.c
> 
> between commits:
> 
>   f40eb99897af ("pktcdvd: remove driver.")
>   85d6ce58e493 ("block: remove devnode callback from struct block_device_operations")
> 
> from the block tree and commit:
> 
>   be7e8b917ead ("blkdev: make struct block_device_operations.devnode() take a const *")
> 
> from the driver-core tree.
> 
> I fixed it up (I removed pktcdvd.c and used blkdev.h from the former tree)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

As it was me who wrote all of the above patches, I knew this would
conflict, sorry about that :)

And thanks for the resolution, using the block tree's versions is
correct.

greg k-h
