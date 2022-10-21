Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C166079FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJUO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJUO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:56:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD215996C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:56:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-368edbc2c18so25752697b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iHbnAVY1q0WJqCdF8rOY5VgMHAfL2MADGJ5qi1O0cbw=;
        b=EhCtYRk6hMrMay08hjn+ITEgKCrTIhd9DwbeLg4asVGQSdRdh+S/OnL0LNiML5CkWw
         d1BRhTM1S7uJlRERLopjjpNxfaQYTuOp2Q9MR4Cpsg8y+O2mIdVo8NxBWcgjZwxry67P
         BigfB5HWXNSnIB2Lz0T56YmldE5OiYSerYPGQprGIySNzRZ3lNDpF6lrqHqD4NqNfBGp
         aroUIOAS+vOHroqJsIeUNg6nFWj75pFJuBNUJP/1nLDLaWhSCfoypKXyjV91qk46Ky1E
         up08fFK1yoNwAVCHitDd46SrWGSXKsDmB4MgU9gZYeCpMAbzBYP/k6J9AFOTPdujG0r6
         8q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHbnAVY1q0WJqCdF8rOY5VgMHAfL2MADGJ5qi1O0cbw=;
        b=cm1C2cFK0dSQQMLzt5VN0UTB4eWvfZB1tNvWOD7GUmhlMcYOtMybVat4bpQ66IpjTW
         UymBFz01HeB7tbCCsgaz7YP0mMtNU6p9O924gwJCXGdy2oXHDC8LrfQCRsx8zRBxUzMs
         +vEQ96ENVxWy5//r1Z2CczffhkSq/sjQRgxVPvn2syQpP+w3T2QDqoN7HIMbXApiF5Vv
         9HKe9s1WS0Zk5Wc1y39MR45yRG5MJvMDiqdYuirQmOYETRNFjhvsmy5S4w6vJSc7AGh1
         3g4YSoSYv7RgvQuV8Of/edvL5QKeXDX43GDyPGsSDsGMsJxtUug0GJnltuyumU09Zea1
         /0UA==
X-Gm-Message-State: ACrzQf1wxgjR+ALSCfzlIj5ko/zp9HOG+7Bc8EO5K1M8T4wXE0OI0Xmc
        j/zgZw+MS/qOZAD95/i/Fri65vE9hWotI3Wo5n5c/Q==
X-Google-Smtp-Source: AMsMyM7QW21TJcrPbpfYd6a2e5TNfTuJYUDxcrYJ/nLRlp5KCDeMKnEymHpEXdDWKgm3RaawE0D6mKfS6HqRXGFk1zo=
X-Received: by 2002:a81:1c07:0:b0:358:6e7d:5118 with SMTP id
 c7-20020a811c07000000b003586e7d5118mr18216462ywc.255.1666364170592; Fri, 21
 Oct 2022 07:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221021115956.9947-1-ojeda@kernel.org> <20221021115956.9947-5-ojeda@kernel.org>
In-Reply-To: <20221021115956.9947-5-ojeda@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Oct 2022 07:55:34 -0700
Message-ID: <CANpmjNO=kZ2K0-8gSqnDSPpYcUr63BnEKhRPdmCQBY64qi9c3A@mail.gmail.com>
Subject: Re: [PATCH 5/5] compiler-gcc: document minimum version for `__no_sanitize_coverage__`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 at 05:00, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The attribute was added in GCC 12.1.
>
> This will simplify future cleanups, and is closer to what we do
> in `compiler_attributes.h`.
>
> Link: https://godbolt.org/z/MGbT76j6G
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Marco Elver <elver@google.com>

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
