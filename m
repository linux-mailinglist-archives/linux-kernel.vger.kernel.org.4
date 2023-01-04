Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9E65D6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjADPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbjADPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:07:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2362A45E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:07:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BF615C0056;
        Wed,  4 Jan 2023 10:07:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 10:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672844872; x=1672931272; bh=fpEUk44maK
        jVWbWBkP1VcRbhT1/QJjXgzws8WxvQnas=; b=kjFbpSLZ4aiGDC8SwW7cyJUo0m
        VkhuO28hYkRv4r54enNhKqXtMI4sTsoo4v8C85qtYhTLi+h+VhhCRNbawPKi/1q6
        JCjPTjAl2PhyFSHpnCkQftMWWTa0JlLDMa8USgnplPBsGf3cw34pkT9UPsmJdxDT
        31EMPB05pHIQWRBe7NtKqF/GcPrVOPPIlWWdwpzqv6F5O7GUWdtFfYrT05odq6Ug
        xfv6QT38pqqnporvQuYjWRe5Gsycb/pf1ITeAzkQbtZtOMCErvx+mqGXoEnMNurC
        xUgmlNONGitdhtC8skYWuB4Bjk4wxF2NAR0tlEOWp+7SfASAqW1c2M21f+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672844872; x=1672931272; bh=fpEUk44maKjVWbWBkP1VcRbhT1/Q
        JjXgzws8WxvQnas=; b=kKmqoWkREmn4Guq1hXTHOjJo9VU/KKT7GRkjxDJdRZnA
        zbgOuK12/SODkgJhh8eXGWNnuAVKz/lxw3r+kM28FrwDJTjVmY8S33AmY12hW4P2
        jScQsKTHuG5aRqnfRsdFlzQvR3RkV5nlPDlFNKHqe6Uf/kQ0d54OGkZw8YrqhSVV
        x5ihN0E9o1DYSFJKBKz1ruHtTlIPixNgFWanJkoFDOpNQBlPeSuu3X5CVGJciDao
        IQ3jsxono4YjPI4PzSGtijjoNn4j3GQ9B1qGLM73pNFx24jINQvJNwumZiX+v4Zm
        IWq3qCIhpW2l9pv6NNO1fsrd6FjTVXAWL40QwpKyTg==
X-ME-Sender: <xms:R5a1Y46BmGEFniTIqqjgg61jW_NcxHharAb1IFb4vTchiNwUwt7dKw>
    <xme:R5a1Y57ZMm3sxrlJEcuiq6HwSzQcTTsyySZApX4l4CSreSQPUQf6CLdNgqbJHBQns
    7kIXHymuxI6NEgkIl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:R5a1Y3f0MscuMcrvWQ4c94RqjTTJzBtWde5RkmiBdLyIgg5u9D37GA>
    <xmx:R5a1Y9Js7GwybUze4hWQOVor-GGbCG6u72jVmmUZ1tuxj3OMkbzidA>
    <xmx:R5a1Y8LFSnSWTg6pD7xnF7xgtYjkcF9yG1Hlb2Cxf_-dPFQ7oUKKTw>
    <xmx:SJa1YxVmHq045vFxaOIM_OY63OBrYOAdDXUelQeQkx7p0Axk9U-_oA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E44CB60086; Wed,  4 Jan 2023 10:07:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7c747897-bb5b-46b0-a342-aefe30079c06@app.fastmail.com>
In-Reply-To: <20230103164359.24347-13-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-13-ysionneau@kalray.eu>
Date:   Wed, 04 Jan 2023 16:07:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yann Sionneau" <ysionneau@kalray.eu>
Cc:     "Christian Brauner" <brauner@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Clement Leger" <clement.leger@bootlin.com>,
        "Guillaume Thouvenin" <gthouvenin@kalray.eu>,
        "Julian Vetter" <jvetter@kalray.eu>,
        "Julien Villette" <jvillette@kalray.eu>,
        "Marius Gligor" <mgligor@kalray.eu>
Subject: Re: [RFC PATCH 12/25] kvx: Add system call support
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

On Tue, Jan 3, 2023, at 17:43, Yann Sionneau wrote:

> +
> +/*
> + * Ensure that the range [addr, addr+size) is within the process's
> + * address space
> + */
> +static inline int __access_ok(unsigned long addr, unsigned long size)
> +{
> +	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
> +}

This is the same as the generic version, so just use that instead.

> +#define HAVE_GET_KERNEL_NOFAULT
> +
> +#define __get_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	long __kr_err;							\
> +									\
> +	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)

The wrapper around __get_user_nocheck/__put_user_nocheck
is not ideal here. Since I think you only support new
compilers anyway, you can use the asm-goto-with-output feature
to define the asm to branch to the label directly, and use
the same thing to build __get_user()/__put_user().

> +++ b/arch/kvx/include/uapi/asm/unistd.h
> @@ -0,0 +1,16 @@

> +
> +#define __ARCH_WANT_RENAMEAT
> +#define __ARCH_WANT_NEW_STAT
> +#define __ARCH_WANT_SET_GET_RLIMIT
> +#define __ARCH_WANT_SYS_CLONE3

It's good to have clone3() but the other three sets
of syscalls should no longer be defined for new architectures,
so please remove those.

      Arnd
