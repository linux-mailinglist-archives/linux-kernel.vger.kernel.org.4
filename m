Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E986E68AF29
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBEJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 04:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBEJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 04:56:07 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D21E292;
        Sun,  5 Feb 2023 01:56:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 019DA32000CC;
        Sun,  5 Feb 2023 04:55:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 05 Feb 2023 04:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675590958; x=1675677358; bh=IfnK616YIR
        qy87UD2TtxtShT/uMOi2eIt6iskw/90R4=; b=tlOrqmIIpcN0PiYS60DC7MHHeT
        J+uINRCytwTA8maMW6d0O4aha9DxnZ7f+f+wE45CPLJMb2gV1+Bn38IRH1c5GJB7
        vhssxsznyEe0FmuAbhSEP9xdpdPoLJIqtWmCgDUC5XPZliG0Tbk4E0dLtxpAj4RG
        wrwwyZwW07ZO5hZQOAMbgA7g05hiSic1og5Yrer5TByi7f76EnDtaWnD2pVHcn9g
        guaCNpk/jTJO5M7LNmOXIXzMTmKdYck5hkfPYCCkhlcB/vEMmGwHJxuapmOVD9y+
        SINI8MywCVcjE8gUyoWACPu+u0H5keB/XAUXdrKpsAoxzOcLH2hklGNdwdAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675590958; x=1675677358; bh=IfnK616YIRqy87UD2TtxtShT/uMO
        i2eIt6iskw/90R4=; b=MAMoCKgeBnHRLYyWdji9sY2G96cuh3YfoMVyfM00fv7D
        +QRQyGKp5ku7Mt6PRjRHSNSUAG1EMU2LTbrVzdc59+FyFb4yQcFqS0xGv1zc2wf3
        VxABmtk/ubMlDPeD4xYw7DzR+S6gGQSzya53SsZZFezNZbpXnVgv6EaKJn8R+eOV
        d945gz98yqHD3bH0IhXKOLjfKo/FyKZZosZyFaJCZ+CILh0Xb/nS5YhsZYCb02Kf
        /ms3J3UDd6PLP+4QfmU9NLHCTWErs+nYLx5B7yERaHX8VpOBzjvfn3EPvUH+t12E
        lAjZUI4E7ihsDOt31tio+mLa3D3r0Lq4dWNpbfPBKw==
X-ME-Sender: <xms:Ln3fY2u0-TX3YgzL3FNoonR-ZJiXJCSONy-jN3qscPg4Qep-6668ZQ>
    <xme:Ln3fY7cPBLgxeUaNBzfeS5len6gEIjPi2v-ACSY2wvzQlk_fOYIzLDqQ8Io64o9BE
    8nF7XETMtZ3JgIuEV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ln3fYxxz7SUxh5naEkC0KjeRwGyKWc5wngazzV-ocdvu9a4dInIjxw>
    <xmx:Ln3fYxOXOCbwi8VwEjfj8kjdKdft03KQp3SfL8kKaz8Di-0vW-H2MA>
    <xmx:Ln3fY28pmxncMZOvGNzbT4gvTVO9FJj0DdmZH7tZNVMSuUm1u824FA>
    <xmx:Ln3fY2wKuTPdaasxyGHzbU2OTtMxlMRz2UrAmKXBVkMVk1f_afwCMQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06039B60089; Sun,  5 Feb 2023 04:55:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <834254e6-a9c2-440c-9c67-fc5fa5ca43bc@app.fastmail.com>
In-Reply-To: <20230203190413.2559707-3-nphamcs@gmail.com>
References: <20230203190413.2559707-1-nphamcs@gmail.com>
 <20230203190413.2559707-3-nphamcs@gmail.com>
Date:   Sun, 05 Feb 2023 10:55:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nhat Pham" <nphamcs@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Johannes Weiner" <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        "Matthew Wilcox" <willy@infradead.org>, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v9 2/3] cachestat: implement cachestat syscall
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

On Fri, Feb 3, 2023, at 20:04, Nhat Pham wrote:

> +SYSCALL_DEFINE5(cachestat, unsigned int, fd, loff_t, off, size_t, len,
> +		struct cachestat __user *, cstat, unsigned int, flags)
> +{
> +	return ksys_cachestat(fd, off, len, cstat, flags);
> +}
> +
> +#ifdef CONFIG_COMPAT
> +COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, 
> compat_arg_u64_dual(off),
> +		size_t, len, struct cachestat __user *, cstat, unsigned int, flags)
> +{
> +	return ksys_cachestat(fd, compat_arg_u64_glue(off), len, cstat, 
> flags);
> +}

This still looks wrong to me, as this compat definition does not match
the native variant on architectures that require 64-bit arguments to
be passed in aligned register pairs, such as arm, mips or ppc, but
not x86, s390 or riscv.

     Arnd
