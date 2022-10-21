Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F46080B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJUVVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJUVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C265399C0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495D161F74
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA4AC433D6;
        Fri, 21 Oct 2022 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387215;
        bh=xbASSWRTZAT5oZ6zyMyNGJoQui7kFORg6AV0oZzxO1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4Kh+i0exoHNXiUVE0VtZOJYh+6lXn+Wd9wmiyA44mD9pseuoUfMBIHPs0QduU6Y1
         boJHWIS6MbC3fsiSZoM0VP/t11uKHQU5e8N31vXGpsPxh9N1TuzfypRnXAq0FFY8R2
         J0TceastVjnNj4N1tHhTw5kQsBQCr9/4Gh5/NAT4fmTPy4NjZrcBfheCUxzQ48fBlM
         jzAFgpIK7+B8jPyGcT9WsB6eD3oD9rjAFhq3NUqOoYDPN4jL4E1eGS6qaOunzWUXTd
         wZKC3DaWcTW7o3V6KCUHNSBBYwGnyTRYRLH6xmuRBVcLnGeT0C2wailY4BESieX0k7
         eDFPOQjhNIA7w==
Date:   Fri, 21 Oct 2022 14:20:13 -0700
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
Subject: Re: [PATCH 5/5] compiler-gcc: document minimum version for
 `__no_sanitize_coverage__`
Message-ID: <Y1MNDU8zX4apv3E+@dev-arch.thelio-3990X>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-5-ojeda@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:56PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 12.1.
> 
> This will simplify future cleanups, and is closer to what we do
> in `compiler_attributes.h`.
> 
> Link: https://godbolt.org/z/MGbT76j6G
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 7f2c2bb73815..7af9e34ec261 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -92,6 +92,9 @@
>  
>  #define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
>  
> +/*
> + * Only supported since gcc >= 12
> + */
>  #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
>  #define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
>  #else
> -- 
> 2.38.1
> 
> 
