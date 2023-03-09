Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF06B17B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCIALv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCIALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:11:33 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222CC93848
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:11:31 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1763e201bb4so655933fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 16:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678320691;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nTISrXpO300lpFWqqY1St1bGS5UZ70h7TsS28CdZuhA=;
        b=lU5xSvmlhAG3b54eH9/zfnEiAPfx7QvAHsSPdxlykPJsaaaYd1OYKDgFWAsIskGfVE
         5tT6P46oQF192NRv767GA7kUhio8TRgM5MrHM+zRHEXrvQDC8lLhCJKONo4p326w5uyP
         f30CspMb/hizzGnKnTRyTEI354UhNhP7nK3MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320691;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTISrXpO300lpFWqqY1St1bGS5UZ70h7TsS28CdZuhA=;
        b=c4NfFzMKanqVxEeVzyDzr5BjXbWZif6VVKn8bgEtZCOvOIAWWYQxcFEnShyJsC5SSL
         GPYeMTYWU+uQMaL9GJhJlM/JiO5B+FL5Zhk4H5Mdvvj0YrYR6IotFeGII/bNJlmDUhuh
         tW40mqEpnwcVcastNwpUIpCXXAWdehhipr14K/0jM+MjbUvdI2S02bBApp7dEv5D/tBC
         D1aaVijLGOTSfNkWSMwEAk5czzIeljmL5Wa8GA6NsWtDwPUmZUIHZDFHet+/E5Re2OP0
         Mr1sH6r3cAyimXMnB8XYddx9DJMnPULQEuwEGPpOttEfWnKru6+5DILKOQHs7YUH6WR2
         iINw==
X-Gm-Message-State: AO0yUKXjo1dahjx5GtEpcGzHVpBejyDz7pnuL1/wix3xsc8HP+oeDQlr
        4YIJOWdl+WIaD+BYEIi7BHoKUl53PVLiMBhGuC0=
X-Google-Smtp-Source: AK7set8ApWx6kr+SfAyfzkE3zoJmXnq6ygcwKo6GPYa61JZgMWxU/LDFmiGNI9zIm/KYlrc1vCUDPA==
X-Received: by 2002:a17:903:18d:b0:19a:eb93:6165 with SMTP id z13-20020a170903018d00b0019aeb936165mr27011036plg.22.1678320108014;
        Wed, 08 Mar 2023 16:01:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b00185402cfedesm10299288ply.246.2023.03.08.16.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:01:47 -0800 (PST)
Message-ID: <640921eb.170a0220.28e72.38c8@mx.google.com>
X-Google-Original-Message-ID: <202303081601.@keescook>
Date:   Wed, 8 Mar 2023 16:01:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: sigaltstack: fix -Wuninitialized
References: <20230308195933.806917-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308195933.806917-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:59:33AM -0800, Nick Desaulniers wrote:
> Building sigaltstack with clang via:
> $ ARCH=x86 make LLVM=1 -C tools/testing/selftests/sigaltstack/
> 
> produces the following warning:
>   warning: variable 'sp' is uninitialized when used here [-Wuninitialized]
>   if (sp < (unsigned long)sstack ||
>       ^~
> 
> Clang expects these to be declared at global scope; we've fixed this in
> the kernel proper by using the macro `current_stack_pointer`. This is
> defined in different headers for different target architectures, so just
> create a new header that defines the arch-specific register names for
> the stack pointer register, and define it for more targets (at least the
> ones that support current_stack_pointer/ARCH_HAS_CURRENT_STACK_POINTER).
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
