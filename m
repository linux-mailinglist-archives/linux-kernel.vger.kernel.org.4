Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354860809F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJUVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUVRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:17:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81313E21
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B677B82D61
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE209C433D6;
        Fri, 21 Oct 2022 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387066;
        bh=UQnTE8Wn0Aldai7CTjAH/rvclTxZzkWskgC4ckiWDD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVwvpSCSzs+NWY0R1dhgs7IyXMoUq4pmRVlylGO9wtsZczWFerQNg+EC6JaVjlU1/
         GSlDhj3IXadKemJYI3PaZsraXvf1pJLOPq/yVQsQVx2Xyif0cFd60BT4ui1nz0AhKx
         oG2ViC46US9e0JpZ21aFxidOt75e++B4fAFoXxfShB/JTItCtGuynRwdsNe37zeNf6
         ViJdkfYxmYXtX/WRYutl4+DhK4SLBgiTy1CsurB8cQW3CUK1f993fuRTjCVtnge7zG
         WSix/w1uvSt/kMEkHWINUe+5d94HcCizRARpHjdWYys+TkQKqeCjGe6AZCFkCI2Pzd
         5D95O8Wj5W7Wg==
Date:   Fri, 21 Oct 2022 14:17:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] compiler-gcc: be consistent with underscores use for
 `no_sanitize`
Message-ID: <Y1MMeH4sZCaqzdUA@dev-arch.thelio-3990X>
References: <20221021115956.9947-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-1-ojeda@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:52PM +0200, Miguel Ojeda wrote:
> Other macros that define shorthands for attributes in e.g.
> `compiler_attributes.h` and elsewhere use underscores.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f55a37efdb97..b9530d3515ac 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -83,25 +83,25 @@
>  #endif
>  
>  #if __has_attribute(__no_sanitize_address__)
> -#define __no_sanitize_address __attribute__((no_sanitize_address))
> +#define __no_sanitize_address __attribute__((__no_sanitize_address__))
>  #else
>  #define __no_sanitize_address
>  #endif
>  
>  #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
> -#define __no_sanitize_thread __attribute__((no_sanitize_thread))
> +#define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
>  #else
>  #define __no_sanitize_thread
>  #endif
>  
>  #if __has_attribute(__no_sanitize_undefined__)
> -#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
> +#define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
>  #else
>  #define __no_sanitize_undefined
>  #endif
>  
>  #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
> -#define __no_sanitize_coverage __attribute__((no_sanitize_coverage))
> +#define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
>  #else
>  #define __no_sanitize_coverage
>  #endif
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> -- 
> 2.38.1
> 
> 
