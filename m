Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E163D8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK3PHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiK3PHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:07:51 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECAD13F58;
        Wed, 30 Nov 2022 07:07:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 211863200918;
        Wed, 30 Nov 2022 10:07:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 10:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669820867; x=1669907267; bh=EYBohq7Wmj
        /uFHqGx3hCuQfFGuTEIDd6kMXNccH+gNw=; b=GDUdx+GjmEKduBDSilj+n1NSbq
        Ic269td72thVocWg+G4micCeNOnsNyYyY4jbe32JM9KaxP3/HY715S6euRzl+OHM
        vvP+p/DD8NJa2LIAXh9AAqgR9FWQsGlcFQ/cYyQ65Ew2hLxpbng8K+KpuGfucXDX
        KYCEjcOfukOVqfYxVtv+4UPg+4twU4BFjYlHZ1+4uTUodumLkwFmsUexfCE4NQ/E
        8rCZg7ulhiE6NT5uT7tuB8XRHYGJjApwLHWVw6nU2UZP4CcoKKH6ap82W4pSnHzR
        ndwDTRKc3SljqM6y98atShVleNRl8pjLcwXHwnriopbaLH/Qw3SX0EKfR2qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669820867; x=1669907267; bh=EYBohq7Wmj/uFHqGx3hCuQfFGuTE
        IDd6kMXNccH+gNw=; b=A1flL476eQAuzf8UkuooY5DxSucqSeE95cwMSYX0kTEg
        SzBwA2GK6ljdkdkwdorqSBZtoZ2TP4Zdo/4dGYiZkqZVuQeV5+DlSKCHwYl3UYA2
        56HApMp86ss11am5cqJ2xITBAz/pM4yqD1Bi8T21G9zU6FLRdHN2kITMFTNw1ncL
        kFchvmlT5D4pSQy4AVip1T4rQ7s1qiAwc5n2XQoHgcyq6+XzMGlXWjJXTLhmrQHo
        civsyuYklJ2Fth64UNKk7p1Q16WPCoA2ranGOgnKFi3KtITN3jxWxlmOWxrE7zBG
        ZAVExXIaQz0zXNQ1nMBytulZyJQiZhYXQ26NLP5QUg==
X-ME-Sender: <xms:w3GHYznk0rDeI1d3_ezT3PuosqDm49PneBdXT7kqegg27GA51_7w-w>
    <xme:w3GHY21-WN0M0ktSvUrnlV2_wKd8qizoZelh2yxP9qmePucvABqGheZkdfvEvdqdc
    BxehDAhSyM81eSd-4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:w3GHY5oaIMr9yh-DhE4M2HRagQXXaT6UehFnyz82n8LaUjkTttz3ag>
    <xmx:w3GHY7kbbT5sWTMIBbYCisB4q1n_KNaDONStIdU-MfpP0daRw_bc2A>
    <xmx:w3GHYx3ILNR7cN8vF6Dd1-qzbIOiZVGR88yyoUuw0rwwmuP2FsR1Uw>
    <xmx:w3GHY7yc1MCRzilAJXIF86WaJFSx6qgQaNZ2LVRjC2Os-_6jbbvjEQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A85BB60086; Wed, 30 Nov 2022 10:07:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <16ec2a7a-c469-4732-aeca-e74a9fb88d3e@app.fastmail.com>
In-Reply-To: <Y4dvz4d0dpFzJZ9L@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-4-Jason@zx2c4.com>
 <878rjs7mcx.fsf@oldenburg.str.redhat.com> <Y4dt1dLZMmogRlKa@zx2c4.com>
 <Y4dvz4d0dpFzJZ9L@zx2c4.com>
Date:   Wed, 30 Nov 2022 16:07:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Florian Weimer" <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022, at 15:59, Jason A. Donenfeld wrote:
> On Wed, Nov 30, 2022 at 03:51:01PM +0100, Jason A. Donenfeld wrote:
>> On Wed, Nov 30, 2022 at 11:44:30AM +0100, Florian Weimer wrote:
>> > 
>> >  * vdso_data will be accessed by 64 bit and compat code at the same time
>> >  * so we should be careful before modifying this structure.
>> > 
>> > So the ABI must be same for 32-bit and 64-bit mode, and long isn't.

> I'll do something like this:
>
> 
> +#ifdef CONFIG_64BIT
> +typedef u64 vdso_kernel_ulong;
> +#else
> +typedef u32 vdso_kernel_ulong;
> +#endif

This does not address the ABI concern: to allow 32-bit and 64-bit
tasks to share the same data page, it has to be the same width on
both, either u32 or 64, but not depending on a configuration
option.

> struct vdso_rng_data {
>	vdso_kernel_ulong	generation;
>	bool			is_ready;
> };

There is another problem with this: you have implicit padding
in the structure because the two members have different size
and alignment requirements. The easiest fix is to make them
both u64, or you could have a u32 is_ready and an explit u32
for the padding.

      Arnd
