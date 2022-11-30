Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279363D3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiK3KwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiK3KwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:52:14 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527373B82;
        Wed, 30 Nov 2022 02:52:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 011583200786;
        Wed, 30 Nov 2022 05:52:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 05:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669805529; x=1669891929; bh=o1DkuhAhSV
        UYghUYsQqa95FE6Gcp6cGFMkQrur8iW/w=; b=QXATCZvEh6vbwmKYWi5UK7R8oA
        vlWar2N2a/AnFtZ4EngEkUGW+EP8h20S4ziAO2m1s5Rdv24CJOGpSJTmYp1A3e9X
        USdR6jKE4Bwsk29I9Mga4Lgp5eLsxXtMpABVIiDK/cJ/52a12XF1fzBPk1n6LVQh
        lY3K/gjkmZWUE5Uj5W71qaGToB9GRYN031xvSL9R7Zf+lbRYshjme3tWdU8tzXXR
        7Gy4noAJcSoTNzsDyg6gr3bgIOKufDq984qhhTcke46Zvx/U44e/tDcp6Etkwb4O
        eXGmfxHO8ejrh/Y5XOMQVJMQF4lI5mHnAd/G65L2nIse90agch29Dm8adE2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669805529; x=1669891929; bh=o1DkuhAhSVUYghUYsQqa95FE6Gcp
        6cGFMkQrur8iW/w=; b=pi/LT+Xyeq+wogK0ln9KlGRLTjyUYeW/C7HLbA6l6jBd
        qghRJU0wJv/S7fWHhqyhhiu3UmODo8aR1C2o/zdO/vJejSbBm2wd5PYeIs/ZRNLZ
        4auOXPBB20Zbvboms9yteRXE5e5+FM2k0hXkDoEC3xN8+KvIObaql75ngg7IMe2J
        ZNar2sUNyYIS/+kZtbL4/II0SdQHfRPVpOXIh7G/2TqWNS9+D3peJQi08kZFWkFH
        qROjOL00xkaFGpRQ9u6o5krO+d620Vx64yTxkhCG8LMUbqZBKaHL4gCisDjC//m7
        B2HZc2KbM5nkee+dV3hINLoBp0F6SRnM5I92G5z0Hw==
X-ME-Sender: <xms:2TWHYyI8ofnWx-g-sHCRjpIa-oE4MqwkLCwXo1nKQwjeybBdaDO4KQ>
    <xme:2TWHY6JC-1hMxXYINWvBUoFY2Prwl8cGCSbYEbGeZ2kHl3zP3Omefw4pF1Q1If1AY
    W0koEUuQX6Y_Q>
X-ME-Received: <xmr:2TWHYytDkYGiIg5TVQueRLPZpo2N63ngTsvyjW5z0tGG0W5vtmB5IabcN1-8leCmdaFBqkA-lzWB74A25RN7Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:2TWHY3anuSffMV5H4d4BTcHsspPg__NIeJISM-BIZ3eHDd1dqpwUBA>
    <xmx:2TWHY5YVjKeHiulTPG938fCiBPK-FxPwTEOB9NDrRAP5eNWKy-ogCg>
    <xmx:2TWHYzCROK2pCnbAPfCYhEkwTeJb3-VeIfN65ZTZGEV91zYsbv-p6A>
    <xmx:2TWHY-PtPU_FnoSiok7cbFzp5MRPl1N0R30DnSKrcG-5sF2Yrm_loQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 05:52:08 -0500 (EST)
Date:   Wed, 30 Nov 2022 11:52:05 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <Y4c11VtMQ64W1U+i@kroah.com>
References: <20221130131854.35b58b16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130131854.35b58b16@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:18:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/xen/unpopulated-alloc.c:17:21: error: 'list_count' redeclared as different kind of symbol
>    17 | static unsigned int list_count;
>       |                     ^~~~~~~~~~
> In file included from include/linux/preempt.h:11,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from drivers/xen/unpopulated-alloc.c:3:
> include/linux/list.h:662:22: note: previous definition of 'list_count' with type 'size_t(struct list_head *)' {aka 'long unsigned int(struct list_head *)'}
>   662 | static inline size_t list_count(struct list_head *head)
>       |                      ^~~~~~~~~~
> 
> Caused by commit
> 
>   a9efc04cfd05 ("i915: Move list_count() to list.h for broader use")
> 
> I have used the usb tree from next-20221129 for today.

Odd, there is also one in the z2ram.c code but that isn't breaking :(

Andy, I'm going to revert this series from the USB tree now, please fix
it up and resend.

thanks,

greg k-h
