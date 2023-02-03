Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2936B68A49B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjBCVXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBCVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:23:37 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D2CA4291;
        Fri,  3 Feb 2023 13:23:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 519B03200A32;
        Fri,  3 Feb 2023 16:23:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Feb 2023 16:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675459412; x=1675545812; bh=2tzzoGJ9eW
        nbElxFwdnPJhJylsfRsTkZVGSNGIwIJxc=; b=Y8KAJ8O3KdHmu2unJQfeL9qwqH
        brn7Ap2vcQjv4vAdHUobxFYeR2vy4R12zrIWv6hH5exJvGOsMr6Mpre5Uo0JQYeb
        JkH60rVfeAZc7iL335VeLa0ffuC2CFw28kLla3XaR9jja8Du/x2tT7Ax8apBIc1K
        U2RfnbED0QcZerICTIbwIPzNAWjiAm5obZqkydFPglVp1ePvG49adglZd3EjSR4j
        cJZ6NjrEE3jXdUqyPJCvMID2shcsF4VXdM8HLz1Yhxz8aRuN188ZjQu07XoXxXSo
        hfFirex3Oz9W5lEPi/AQTa686XGdNGq3b0V7EwG9ciPjjeQ5HMo+DFcwczvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675459412; x=1675545812; bh=2tzzoGJ9eWnbElxFwdnPJhJylsfR
        sTkZVGSNGIwIJxc=; b=gH6knMbbgtgoFUQVAXwhm/0MoSywBc3fmlR5kjbw0ErV
        ekZoBA6Zhzrcx6XDU+bYQkqxGeBkDKzfefGWRmApBjV7mEUjVHYyPo2DIGIS8tzD
        F2GUddS4WZSSimoeeQf9q9uHrlG2efOGKN+BZFC/QJEuwR5o0gJshcBys1K1Oqn7
        eLBEhhR/xM7orTSe9r0ZbsvEevW+4Q1LY9yNZ/Q1hT8bndVrGtibg1JE74Q20+QW
        r34nbA0FWBLXnZVYGuk+1zLXP5IJSg0g9HX+M5s1LyM61xKrJ92F9Rwx+TXRthks
        xvQ0GPhGQ8bOjkSOIdk4/FXHvTMGJzPGja46QbaP+g==
X-ME-Sender: <xms:VHvdY38Ygqr-b_4Hji-X0y59i5vFcFrS0k5TAqO5w54iseJKuuQ7Bw>
    <xme:VHvdYzukcHpcc_foZsUhHkMMJlGCK6j3ZcTuS5jRMCHKS2D-k413TtBBFoX4nYCq5
    iitUwcWe12hEDzDgOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegtddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VHvdY1BHR92MQ3DEAHCpnn9C4ItohwkDZbbfqNrXlTpi3I04_EsbEQ>
    <xmx:VHvdYzepDqS5tWgNdjhojwmjOaVXq-M7cuisVlUATdFvuvlT89BAeA>
    <xmx:VHvdY8M6PfOz0oVaVTU6dwdNpRg6U8sUpFmemcTIEfg71uzsKpAmDQ>
    <xmx:VHvdY4l1siqCiq1c8OtS3K54HrmLIiLfW89_I5AVnEx5uBgKwqlIaA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2815FB6044F; Fri,  3 Feb 2023 16:23:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
In-Reply-To: <20230203193523.never.667-kees@kernel.org>
References: <20230203193523.never.667-kees@kernel.org>
Date:   Fri, 03 Feb 2023 22:23:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Aleksa Sarai" <cyphar@cyphar.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
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

On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
> While there is logic about the difference between ksize and usize,
> copy_struct_from_user() didn't check the size of the destination buffer
> (when it was known) against ksize. Add this check so there is an upper
> bounds check on the possible memset() call, otherwise lower bounds
> checks made by callers will trigger bounds warnings under -Warray-bounds.
> Seen under GCC 13:
>
> In function 'copy_struct_from_user',
>     inlined from 'iommufd_fops_ioctl' at
> ../drivers/iommu/iommufd/main.c:333:8:
> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' 
> offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' 
> with type 'union ucmd_buffer' [-Warray-bounds=]
>    59 | #define __underlying_memset     __builtin_memset
>       |                                 ^
> ../include/linux/fortify-string.h:453:9: note: in expansion of macro 
> '__underlying_memset'
>   453 |         __underlying_memset(p, c, __fortify_size); \
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/fortify-string.h:461:25: note: in expansion of macro 
> '__fortify_memset_chk'
>   461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
>       |                         ^~~~~~~~~~~~~~~~~~~~
> ../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
>   334 |                 memset(dst + size, 0, rest);
>       |                 ^~~~~~
> ../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
> ../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
>   311 |         union ucmd_buffer buf;
>       |                           ^~~
>

Hi Kees,

I started building with gcc-13.0.1 myself but ran into a lot of
other -Warray-bounds warnings in randconfig builds, so I ended up
turning it off once more with CONFIG_CC_NO_ARRAY_BOUNDS in order
to keep building without warnings.

Is there anything else I need to do to get to the point of
just addressing actual issues instead of false positives?
Do you already have a patch series for fixing the others?

> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index afb18f198843..ab9728138ad6 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize, 
> const void __user *src,
>  	size_t size = min(ksize, usize);
>  	size_t rest = max(ksize, usize) - size;
> 
> +	/* Double check if ksize is larger than a known object size. */
> +	if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> +		return -E2BIG;
> +

WARN_ON_ONCE() may be a little expensive since that adds two
comparisons and a static variable to each copy, but it's probably
fine. 

      Arnd
