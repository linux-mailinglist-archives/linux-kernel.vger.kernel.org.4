Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03710698165
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBOQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBOQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E457F93DF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C878B82300
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C574C4339E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676480086;
        bh=Jpo+ZEcj0NSECCBDI9/jza5/QvURZLfRVoS7tg9Ao3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UeVNlMrQBsL4hOUIYWc5/p+f/L/bJ4ebASbRBc5IUHKE/Wq4tSVvWHphWNjOxderY
         Z4N0FzQvYhZSA6BRl8Jt2bE25d2KzDwHddLoqFvj/zpyup/tp7dzTlkSP8kJgeovQa
         eMMLk6wD8ejWlqtzcScq0qLjAWtZNSDyehTVtZx1o6KiJuw4JM2+yy2hD5TvaRglUr
         2wUxduAD4LH1i6SotSNJ1lPadRjLlFDZz4ecsGAvyMJhbWs43hZZQS8ABwTr78xP1f
         O2cviNQsyNxAer9uC1/f+7aXHdwNxTyrRtsUvjp3Tm5E9hDdFPPhpcnizUtEI9TVUY
         6lvv1XgaeiFmA==
Received: by mail-oi1-f178.google.com with SMTP id r28so16337115oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:54:46 -0800 (PST)
X-Gm-Message-State: AO0yUKUCk59jnuC9k7jfBwVmEI9Y8WMx5PVvG4peWQ4fJH9L84aSNFG5
        SaF1k3BOsQE9TxxB8Qa5qE/qrOzkMjVKtlnYfzw=
X-Google-Smtp-Source: AK7set8MmwwI2C4toT2muII7ZPlAc/iS3t3AJUdN9A4D9EO7+jkuxmC7fxI8kj44q5UdiC/XqkeiI3qnO1r0ElkjIEg=
X-Received: by 2002:a05:6808:18a4:b0:37b:8b8e:5e71 with SMTP id
 bi36-20020a05680818a400b0037b8b8e5e71mr200486oib.194.1676480085203; Wed, 15
 Feb 2023 08:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20230215091706.1623070-1-arnd@kernel.org>
In-Reply-To: <20230215091706.1623070-1-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Feb 2023 01:54:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQVOjxP9dO45OQq_HzXV0VtbObZKcwJFt4Saczaob8gw@mail.gmail.com>
Message-ID: <CAK7LNATQVOjxP9dO45OQq_HzXV0VtbObZKcwJFt4Saczaob8gw@mail.gmail.com>
Subject: Re: [PATCH] x86: make 64-bit defconfig the default
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 6:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Running 'make ARCH=x86 defconfig' on anything other than an x86_64
> machine currently results in a 32-bit build, which is rarely what
> anyone wants these days.
>
> Change the default so that the 64-bit config gets used unless
> the user asks for i386_defconfig, uses ARCH=i386 or runs on
> a system that "uname -m" identifies as i386/i486/i586/i686.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index a27b27d1418d..cc7efb6e6e6b 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -3,10 +3,10 @@
>
>  # select defconfig based on actual architecture
>  ifeq ($(ARCH),x86)
> -  ifeq ($(shell uname -m),x86_64)
> -        KBUILD_DEFCONFIG := x86_64_defconfig
> -  else
> +  ifeq ($(shell uname -m | sed -e 's/i.86/i386/'),i386)


I did not test this, but I think

     ifneq ($(shell uname -m | grep 'i.86'),)

is simpler.




     ifneq ($(filter i%86, $(shell uname -m)),)


will also work with less process forks.






>          KBUILD_DEFCONFIG := i386_defconfig
> +  else
> +        KBUILD_DEFCONFIG := x86_64_defconfig
>    endif
>  else
>          KBUILD_DEFCONFIG := $(ARCH)_defconfig
> --
> 2.39.1
>


-- 
Best Regards
Masahiro Yamada
