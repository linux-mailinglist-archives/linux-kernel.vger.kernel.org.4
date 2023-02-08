Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4758168E8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBHHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:30:11 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C917162
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:30:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 13406320051E;
        Wed,  8 Feb 2023 02:30:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 02:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675841408; x=1675927808; bh=HoqvZX70Yt
        h8x4215VzvDeECL+DtSnZZQRsGLrfFrlU=; b=Op1Xtgv7aXeuYBfdV9tiN7eOcs
        9e6Sr5zA0nbZWkaBdPvYrx1yrQvI5xEKrT8sD10LftZ0YNaNpy4tAHZUgu7uBb7Y
        BxMV8XTYOJk4wzNt5/A/UT8yRdSi96H6LXhzJaVMQ3Wu9xfgkHYF109t8zIDFdCQ
        7WS5T6Y1XQVjaY8j2YBsKnqhF6gvxrOnQwUwYZfgH/LlIaeVkD5G+zx6MWjEn1u1
        PBtSxVYPpfV3UeyHS4bHK8Uf38zuJPHU7lvJ2wfPZ0uyhdhJQYohUA7lnPwUZeOj
        z6yjzqziXKLzQrxaql8G1Yfkq7G08p4OyK5/PAH5ZGg0wtBG5zssAWEoDyuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675841408; x=1675927808; bh=HoqvZX70Yth8x4215VzvDeECL+Dt
        SnZZQRsGLrfFrlU=; b=RrdZGDZbvT5ggMmVsTTAq6zgSJSAdli9PQ3y6s2XclQ+
        +Dtyl6i6WXx8HtIGEOPzZTu5M0Jd/tzp19ErRy83VX6ywgMhz5iIRudHeFVX7kex
        7012XlMQYs+6t5UbLhoTsmAocdn4Xc3vJemeBEumo0DFtNu1z133G8yGhdGRPZk5
        iaJPPMLV95NkRiCZp10zbkGkWtzDuNvF/CWlS/tiguafXVLcD3KzIntFtWpAUUcK
        yBNhG1FNs1UpF4HYgPHO5C3Wk1q95xRL2dNWeI+n2NR2IvRPYJWHGXJzXHTa7k+p
        sS/IDZQe8ef6aIAqCPTT38CvOebrNQFgMwdmLwLPoQ==
X-ME-Sender: <xms:f0_jY5PGmweNK-mQBRvDafGozsTFW6AtYWOFmoiX1PtzqXXduTEjFw>
    <xme:f0_jY7-6NQMQBYvb3R0qL5Q8yaHvoT1OlLKsTK1iud-iJBXL6igCjLgeWX8-hzmwg
    tQhoT7MWkV0IIeL6Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegledguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f0_jY4R1HGXemXEP35icekwxCeo_JoKLIqVBbS-4yltaQ_-P6eZuPQ>
    <xmx:f0_jY1sNRrGzqmGn4O5BcZOv1Uwi63hwAx0hVHyAANEPArwlSvmiLw>
    <xmx:f0_jYxc2--DWrQtbGU7IIJCdob83qv4AHpPzBiADaed1HzC9Ub29tQ>
    <xmx:gE_jY6HvwaYVBtXnXc55zc9qj5NzRTWQJuQ48gICPppecV1cF2ijng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE21DB60089; Wed,  8 Feb 2023 02:30:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <17740a63-624f-47da-a701-dd218f95f9da@app.fastmail.com>
In-Reply-To: <Y+MXk9A+gB1W6T/n@1wt.eu>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
 <1af05c1441e9f96870be1cc20b1162e3f5043b2e.1675734681.git.chenfeiyang@loongson.cn>
 <1e7da4e7-392d-4a9e-aa95-0599a0c84419@app.fastmail.com>
 <CACWXhK==yVZGZbY+3DUAuxL34=gKwQv20Cw3y1+QKir0D2F3EQ@mail.gmail.com>
 <Y+MXk9A+gB1W6T/n@1wt.eu>
Date:   Wed, 08 Feb 2023 08:29:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Willy Tarreau" <w@1wt.eu>,
        "chris.chenfeiyang" <chris.chenfeiyang@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Feiyang Chen" <chenfeiyang@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nolibc: Add statx() support to implement sys_stat()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023, at 04:31, Willy Tarreau wrote:
> On Wed, Feb 08, 2023 at 10:09:48AM +0800, Feiyang Chen wrote:
>> On Tue, 7 Feb 2023 at 22:31, Arnd Bergmann <arnd@arndb.de> wrote:
> (...)
>> > Given that all architectures implement statx the same way, I wonder
>> > if we can't just kill off the old function here and always use statx.
>> >
>> > That would also allow removing the architecture specific
>> > sys_stat_struct definitions in all arch-*.h files.
>> >
>> 
>> Hi, Arnd,
>> 
>> I'd really like to make all architectures use sys_statx() instead
>> of sys_stat(). I just fear we might get dragged into a long discussion.
>> Can I send a patch series to do this later?
>
> I generally agree with the Arnd's points overall and I'm fine with the
> rest of your series. On this specific point, I'm fine with your proposal,
> let's just start with sys_statx() only on this arch, please add a comment
> about this possibility in the commit message that brings statx(),
> indicating that other archs are likely to benefit from it as well, and
> let's see after this if we can migrate all archs to statx.

Ok, makes sense. Just change the description then to note that this
will also fix riscv32 (which has only statx) as well as arc, hexagon,
nios2 and openrisc (which have statx and stat64 but not stat or newstat).

   Arnd
