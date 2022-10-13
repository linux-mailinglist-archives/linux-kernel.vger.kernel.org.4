Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6C5FDF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJMRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:45:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331263364
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:45:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so5598024pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZkeUyFWIjLvxMFg7brz1pr43wrdZfuQ/bNA+wt0kz0=;
        b=Oyl3aTOEOtogOBtfUuv1T7whUHgFt3/b5KjJ+KNujD3CVmO9CECkcsWeNZqm2l79Pj
         7c/GDjpcT7G8wiRhUBB7V0tkoB3v2eQ6bbAAcm3iRIBIivASknKeDN49CgJ1Cw2lmfdJ
         rLjngG7sy8WYzMgRqA1dphHW+q1jBqkQ1r67mZxIxu/0CZitoIpbTNM0nC/89yxK3S0a
         Ak+B7SszYIlKZFueImPugmAh1C3IuuKJuqWv/HpWMaQy3faF6gcaexP1r/s7u/xYm7ky
         VkVt57MuK1ONXSu/dh8cxswOhunxB1Yjz/u17N501OnLF71QurkyfGssa9XBijY5WUW+
         2FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZkeUyFWIjLvxMFg7brz1pr43wrdZfuQ/bNA+wt0kz0=;
        b=TKI4O700SZ21eLcvS31Ergwzjs/5oaBkNVEEU9KaStmfBBOx7pmpx1G8mQfsaEAnnf
         DZsXbtP8KAHkhXmIbOjDQCedTJmMwiyEmQL1Vn1NTiKXFPcm/L586CbhTccj0qgtPZ4Z
         k1NtqmDNjQkyb6MxZYVuOYqwEnk274vGqJrGiHKeagNf9Ai/v9qKq1X2GyNsTqxoWHek
         Xnk5zkMlOctSYKCOfaVmlG1eFs/EiiDvfmSBUx+b3jKX7ZtB4AipS+EDMy4fBXj1Sdoj
         DI/fUEyaEZxMVd9XUrdgmnG5XV7DZx33QxUtc29LBFwaXJTMYf5wW8Gh2uZIS4ysCw/p
         nZfw==
X-Gm-Message-State: ACrzQf17KtFD6WFBFaiyVsjbd/gxbvb48XnCVayIUsOJNUJqDln38LCb
        QyEoRGophe7h/FP+VJAdCJhWkZ8+mbKAJfJNN05cnA==
X-Google-Smtp-Source: AMsMyM48uQktZ+YTsNROG9cNsn/6MzYVYWhM8oCuC4mWFtmHh5UhmPWtU9OkeE0rTLc4j03w7LrjDZpeEoLncjJHAKc=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr12593187pjb.102.1665683120401; Thu, 13
 Oct 2022 10:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221012181841.333325-1-masahiroy@kernel.org>
In-Reply-To: <20221012181841.333325-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Oct 2022 10:45:09 -0700
Message-ID: <CAKwvOdn-0rp6NCVOrQM9Xe0zcTshKbyorpkx5WzQSTu1o45AcA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: raise minimum supported version of
 binutils to 2.25
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Binutils 2.23 was released in 2012. Almost 10 years old.
>
> We already require GCC 5.1, released in 2015.
>
> Bump the binutils version to 2.25, which was released one year before
> GCC 5.1.
>
> With this applied, some subsystems can start to clean up code.
> Examples:
>   arch/arm/Kconfig.assembler
>   arch/mips/vdso/Kconfig
>   arch/powerpc/Makefile
>   arch/x86/Kconfig.assembler

Thanks for the patch! Indeed, it looks like 2.25 is from 2014.
https://ftp.gnu.org/gnu/binutils/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Documentation/process/changes.rst | 4 ++--
>  scripts/min-tool-version.sh       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 9844ca3a71a6..ef540865ad22 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -35,7 +35,7 @@ Rust (optional)        1.62.0           rustc --version
>  bindgen (optional)     0.56.0           bindgen --version
>  GNU make               3.82             make --version
>  bash                   4.2              bash --version
> -binutils               2.23             ld -v
> +binutils               2.25             ld -v
>  flex                   2.5.35           flex --version
>  bison                  2.0              bison --version
>  pahole                 1.16             pahole --version
> @@ -119,7 +119,7 @@ Bash 4.2 or newer is needed.
>  Binutils
>  --------
>
> -Binutils 2.23 or newer is needed to build the kernel.
> +Binutils 2.25 or newer is needed to build the kernel.
>
>  pkg-config
>  ----------
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 8766e248ffbb..4e5b45d9b526 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -14,7 +14,7 @@ fi
>
>  case "$1" in
>  binutils)
> -       echo 2.23.0
> +       echo 2.25.0
>         ;;
>  gcc)
>         echo 5.1.0
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
