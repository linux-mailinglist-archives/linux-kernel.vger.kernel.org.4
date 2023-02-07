Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18968DAAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBGO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBGO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:26:27 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6743D90E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:26:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 616C55C02DF;
        Tue,  7 Feb 2023 09:26:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 09:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675779969; x=1675866369; bh=GhYRTFcPkf
        kHCsDjuLPAT3Wdu59Amal0psNeUeaUzMY=; b=BqwWk03AzONkEOldoqd1BI9Qbr
        NKpyGWGtqZQJtEaAtcK+/mcvEptGn2CQsESJkj9Gw+dSnGvttKpaHvxahjDnNcHI
        IEZRjpBQgftXWcKHY+FmFeINGT7DK96PZfsLt5E4jjUvTdloDxUreUMS8sdNVujv
        x0n+kE5rSRNgV88zx14EYh7/LRyYnLaiekX6CHFxfgz7GTkVI2Q1HTwjC/Od2qwu
        1kIU/H0uS0ShfyjbdCmVE0OWMw3BlpXC8nfh6W/cUJ4OY8q2Xn4og1hqwA//yL90
        02VRYwyO6EXofL7JmiIeOgc2IznI/zCa9KewXJay+HqRdCUTqjmdBSarEqpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675779969; x=1675866369; bh=GhYRTFcPkfkHCsDjuLPAT3Wdu59A
        mal0psNeUeaUzMY=; b=btGKhLi9V4kv8+j14bC/hMLpp9zTmUZ3y0zDetqjORGU
        WqH6LZci90+RPJ6NWUcxVHPBSCH7IISLpMveTC188YSEPrOzZP+gh3Xzmmt9XlAz
        yWisDdb708EMDoBE+lvA1C5mF2AHAkPzBCHZv4NMK5Kl7AxuEbg0wZnECXb71kTn
        ZvHKl33+EfYPF4D1R9OcXegfr4fDOaNmztE/+sa1ZAq/acD4zAdWvU0iv7BA3q2S
        PrNOn1tsZjxtVpOU6BYoOLOUyvEm/JpCPyJlwkQUXewcD6fQ/RtdRB3+nmhQmvO8
        Tb+SgbGZwW4SaCNMbutJ16rfkn0zTa2z5BHP98L19A==
X-ME-Sender: <xms:gF_iY4ZvBiqDx9yUNcVxqN0_aHYNs3ct7lQutdc9WslqyY3j8YUNaQ>
    <xme:gF_iYzb8bfhWpYBZ2PbLDpZo4NcOgCvL_B-9HryRrWBLzlj_mlN8ZZEyLmOoyNav6
    CavqzpJniQUvLrJegk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gF_iYy8_leT63bqo9eA-c-aJgN7UUnPRb1obGhoX0AYc0gB9SSBriA>
    <xmx:gF_iYyqNh7CluPMD9AHxzhTjUQZNqvFH7tS9op93VQAwUenfNTnnEA>
    <xmx:gF_iYzqbhr2u5yPtUCThnpescloKubITMhvGsBUsIvhxMk4d_hyfig>
    <xmx:gV_iY0CWa_eYynXdf0d3r0_9x7IyJn6JzP53ezKRPZoAvcThOiMZSg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9E04FB60086; Tue,  7 Feb 2023 09:26:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <1570009a-ca62-474d-b678-e6632b5b119e@app.fastmail.com>
In-Reply-To: <612947724da74327edb5e774de73d6d2a96d1648.1675734681.git.chenfeiyang@loongson.cn>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <612947724da74327edb5e774de73d6d2a96d1648.1675734681.git.chenfeiyang@loongson.cn>
Date:   Tue, 07 Feb 2023 15:25:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     chris.chenfeiyang@gmail.com, w@1wt.eu,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Feiyang Chen" <chenfeiyang@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nolibc: Add support for LoongArch
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

On Tue, Feb 7, 2023, at 03:09, chris.chenfeiyang@gmail.com wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>
> Add support for LoongArch (32 and 64 bit) to nolibc.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
> +
> +struct sys_stat_struct {
> +	unsigned long	st_dev;		/* Device.  */
> +	unsigned long	st_ino;		/* File serial number.  */
> +	unsigned int	st_mode;	/* File mode.  */
> +	unsigned int	st_nlink;	/* Link count.  */
> +	unsigned int	st_uid;		/* User ID of the file's owner.  */
> +	unsigned int	st_gid;		/* Group ID of the file's group. */
> +	unsigned long	st_rdev;	/* Device number, if device.  */
> +	unsigned long	__pad1;
> +	long		st_size;	/* Size of file, in bytes.  */
> +	int		st_blksize;	/* Optimal block size for I/O.  */
> +	int		__pad2;
> +	long		st_blocks;	/* Number 512-byte blocks allocated. */
> +	long		st_atime;	/* Time of last access.  */
> +	unsigned long	st_atime_nsec;
> +	long		st_mtime;	/* Time of last modification.  */
> +	unsigned long	st_mtime_nsec;
> +	long		st_ctime;	/* Time of last status change.  */
> +	unsigned long	st_ctime_nsec;
> +	unsigned int	__unused4;
> +	unsigned int	__unused5;
> +};

This definition should not be used after patch 1, I think you
should drop it.

      Arnd
