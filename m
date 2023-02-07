Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFEA68DBDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBGOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBGOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:42:10 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5957AD21
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:40:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D88415C02DD;
        Tue,  7 Feb 2023 09:31:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Feb 2023 09:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675780276; x=1675866676; bh=q4bwqb0741
        Nxs8yme56AsN58DFJO2o+WSJEKXnecRdw=; b=APRykVVbxg5J3AkpQLEqM2g8AT
        GzIb5/PJrhBz9Jecig1hGuS9R1hJM9fq2eY+qM22Uih8+1aLARY7OaOXvqhtG7hd
        8XVCwg2Q0DLwImOZaPZxv6E8MMf4EGYijfQcRONHj0dyZ1ECGw3FvsPjWd94TOW2
        FhWUaz5t3LLuGCbdzD6EDo1kb0BqxehueKUlvzaN6jMTwzjn5y3S6CPOjcPHY16y
        aq7aS1L3JrOy/EwcroIIjhq87UOHfAd2MtkcAhznMYGXznCaTunWM1NGgEDqK8jA
        JWrvlivLfq+1X1kQfN5FwICm/a97hPXveEwaHxiyhmHUND6yWM6zOqcX8U5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675780276; x=1675866676; bh=q4bwqb0741Nxs8yme56AsN58DFJO
        2o+WSJEKXnecRdw=; b=aMG5CeMrqdCxK9mta/KaSJq00gLJiR2dlXfwPST2OhwI
        K1HXdYYVtzgK5RmTPQoas1NsEAGQWKO5h+RhuBsrsMbyoJ/7SuY2nZRmCrYVi633
        2ox9TjrJG5Px8fEA5NTGbR/AedLgHmNHRC8vbBZn/lWgNxQ7Giz4sfd8Mvf+R1Gr
        2COHOyyKmMucpdzV1q7Waa/qS9tXUgzWafN608MxKRg7veoRFxAARDbp95NfN0rh
        TPoxDcYlQ1RrBK1NVG+jIYJiHZ9+WGl26L09UpfDMcT7lQCvtQTWIQHwyjx7L7L3
        wGIJt3eRFAUUYke/znnmH4zboozNwMwiwEbv8vAzoA==
X-ME-Sender: <xms:tGDiY7Bq0Od3YdcxjOSAtr83v-Sg-f7kswnJzceluGuNZEK6a3KIKw>
    <xme:tGDiYxipzTUkOZe7LxqnL8UbuypN9YubmK364gJnrae6vOmsWmGwiaDRG24pb8C0V
    woxT1XAI2yZJBLNrD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tGDiY2nn_FcWMm9MywEM76rhrvcKmsLxlm-IH5yNEBE9pKQJNy_7KA>
    <xmx:tGDiY9xJRlbftfGrkkeaQ596MvRI09VBAqB5yf4nTbT9O3B_rQp7sw>
    <xmx:tGDiYwTfXP2MF3UdY1zD9GBmQumUejihfjFpJmv6ZWuQQb8YueinQg>
    <xmx:tGDiY1JULuG883TKXmsmspQp9C-QW8i3Neqxt_nm-1vxitrg--CR9A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 92DB5B60086; Tue,  7 Feb 2023 09:31:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com>
In-Reply-To: <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
Date:   Tue, 07 Feb 2023 15:30:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "chris.chenfeiyang" <chris.chenfeiyang@gmail.com>, w@1wt.eu,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Feiyang Chen" <chenfeiyang@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
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
> Neither __NR_newfstatat nor __NR_stat is defined on new architecture
> like LoongArch, but we can use statx() to implement sys_stat().
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>

This looks nice, it should also help on 32-bit architectures that
only have stat64 but not newfstatat or stat.

> +#if defined(__NR_newfstatat) || defined(__NR_stat)
>  static __attribute__((unused))
>  int sys_stat(const char *path, struct stat *buf)
...
> +#else
> +#error None of __NR_newfstatat, __NR_stat, nor __NR_statx defined, 
> cannot implement sys_stat()
> +#endif

Given that all architectures implement statx the same way, I wonder
if we can't just kill off the old function here and always use statx.

That would also allow removing the architecture specific
sys_stat_struct definitions in all arch-*.h files.

> +struct statx_timestamp {
> +	__s64	tv_sec;
> +	__u32	tv_nsec;
> +	__s32	__reserved;
> +};
> +
> +struct statx {
> +	/* 0x00 */
> +	__u32	stx_mask;	/* What results were written [uncond] */
> +	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
> +	__u64	stx_attributes;	/* Flags conveying information about the file 
> [uncond] */
> +	/* 0x10 */
> +	__u32	stx_nlink;	/* Number of hard links */
> +	__u32	stx_uid;	/* User ID of owner */
> +	__u32	stx_gid;	/* Group ID of owner */
> +	__u16	stx_mode;	/* File mode */
> +	__u16	__spare0[1];
> +	/* 0x20 */
> +	__u64	stx_ino;	/* Inode number */
> +	__u64	stx_size;	/* File size */
> +	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
> +	__u64	stx_attributes_mask; /* Mask to show what's supported in 
> stx_attributes */
> +	/* 0x40 */
> +	struct statx_timestamp	stx_atime;	/* Last access time */
> +	struct statx_timestamp	stx_btime;	/* File creation time */
> +	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
> +	struct statx_timestamp	stx_mtime;	/* Last data modification time */
> +	/* 0x80 */
> +	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
> +	__u32	stx_rdev_minor;
> +	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
> +	__u32	stx_dev_minor;
> +	/* 0x90 */
> +	__u64	stx_mnt_id;
> +	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +	/* 0xa0 */
> +	__u64	__spare3[12];	/* Spare space for future expansion */
> +	/* 0x100 */
> +};

Can't we just #include <linux/stat.h> here to avoid having to maintain
a duplicate copy?

    Arnd
