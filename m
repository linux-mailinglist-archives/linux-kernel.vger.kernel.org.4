Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06A7076A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjEQXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEQXy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:54:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB784EF8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:54:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d1bdc1708so35917b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684367660; x=1686959660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJkvtlIShL7hTT2Aa3+8Z/JimWO9rp0EQhzVci6L5s8=;
        b=KPPVpTXpvUyqnMeAe6og9yUz5RHzcUuM8kElmrTfkJrCfZLS+xLZn+FQlWm8Q9WA/u
         lrHxR++52HxywkFqwnWYBjND1JL420AJqt5GCsiWSMP9Lin7Dl4RZxzTzuzacy7bHp2s
         04gdj3cs/6kKkqxXDmvlDA+YiTa/zI4JOHCTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367660; x=1686959660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJkvtlIShL7hTT2Aa3+8Z/JimWO9rp0EQhzVci6L5s8=;
        b=HWjm2jcjOjkbjPzw2eF7lDYWXfQ6ShWfC4whkp1635s6oC71Imu4p8Zl6t7d8ClI16
         +rOE1WPHRwiZbKrz/jEJS0i90tiKEdtSjA9HPnPJOUDZG3+nCmpUfmVqJ3Qfjrt1vnQZ
         /0YAmf+yHLmO+5Kgwyuf9tNCv8kndx162oPfNQW9JfXBestSXhTssBMuBnp6TpBtvmrI
         2ziyQNRJY7bAToMIGoIbg1mwvFoYv0vIuyRxBv19FLRiYSYBSD7EfjhGBF1EOgcNyEFi
         hOZNhvasUzU8cPff8VDDXV4dxjX44mLtVrX7pYjCwdHT+5T/tQTHShxBtxVNAhLVPoFi
         6gYQ==
X-Gm-Message-State: AC+VfDwTJvI9v29L61ijSc3Od/Y5PK0RPUdzTfWNXNUjM5P9xb8sBuKb
        mg+RGOXN5foIQZ9+hyiuBvlu2w==
X-Google-Smtp-Source: ACHHUZ604gn1TJitZOABGGG3lTS8APjKkQTKdVkjTCVrhRPcqWdQrqZ2XIvNaJ2+tk8EfvOowysy3g==
X-Received: by 2002:a05:6a00:2351:b0:646:b944:4e1d with SMTP id j17-20020a056a00235100b00646b9444e1dmr1861371pfj.32.1684367660586;
        Wed, 17 May 2023 16:54:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78d09000000b0062ddaa823bfsm68836pfe.185.2023.05.17.16.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:54:19 -0700 (PDT)
Date:   Wed, 17 May 2023 16:54:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sam James <sam@gentoo.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Enable -fstrict-flex-arrays=3
Message-ID: <202305171653.8A5393C6@keescook>
References: <20230517232801.never.262-kees@kernel.org>
 <87lehmh647.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lehmh647.fsf@gentoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:47:41AM +0100, Sam James wrote:
> 
> Kees Cook <keescook@chromium.org> writes:
> 
> > The -fstrict-flex-arrays=3 option is now available with the release
> > of GCC 13[1] and Clang 16[2]. This feature instructs the compiler to
> > treat only C99 flexible arrays as dynamically sized for the purposes of
> > object size calculations. In other words, the ancient practice of using
> > 1-element arrays, or the GNU extension of using 0-sized arrays, as a
> > dynamically sized array is disabled. This allows CONFIG_UBSAN_BOUNDS,
> > CONFIG_FORTIFY_SOURCE, and other object-size aware features to behave
> > unambiguously in the face of trailing arrays: only C99 flexible arrays
> > are considered to be dynamically sized.
> >
> > Enabling this will help track down any outstanding cases of fake
> > flexible arrays that need attention in kernel code.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#index-fstrict-flex-arrays
> > [2] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-fstrict-flex-arrays
> >
> 
> Maybe link to https://people.kernel.org/kees/bounded-flexible-arrays-in-c as well 
> just in case some confused soul ends up bisecting to this but doesn't
> get the problem?
> 
> Not really required though, just a thought I had.

Ah yeah, good idea! :)

-- 
Kees Cook
