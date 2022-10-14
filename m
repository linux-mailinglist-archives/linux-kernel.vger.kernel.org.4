Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862445FF07B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJNOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJNOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:40:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928994A10D;
        Fri, 14 Oct 2022 07:40:12 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 187so4023614iov.10;
        Fri, 14 Oct 2022 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqNU3jyIKdP2LeNPDch6KlM75RQE0z3FFP6RVfvlhuM=;
        b=bOZwXqjmw7sX8px0+Lq1iBo8giDDyRK0xiJO9OwdoKqeV1HX0S+EZc16NmoDZ3CreO
         E3MsKXQNl8pOLt9wKYBMoUbK8LMoUsAhlVXPRyC3f/gN4Jhi9BrrjbNAspvqnLGhRNRi
         67pzpwb+iThnF6UR0j3G/qaIxYxN0kn8C80RC3s1jnu899Zj4TgbKzaQgAB9ReHmRjcP
         XrdIZgeVELwuXJEq7d9BEfq7PGtbOhbzc2+ObHITZOjbGju5C7nmlA5elNU1ObdBPamj
         StKKbp+pt2rm7wAgOIJKzscSzTIZgFDpxUDFoXX7coX+Hq/+qzDa8Ki3cZiAi5jKCYZk
         R5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqNU3jyIKdP2LeNPDch6KlM75RQE0z3FFP6RVfvlhuM=;
        b=T1A9zeMOVz3u8HlogQ7adtD5wdK91XpPFuyTcMO2Szx7AxLNDuXa9h5HTu+5D1McgK
         B7aaQTnuqQGzGywTy6nKgym7VLfA/a+/z4F2FVS6qqctdg64S9c8daXb6c1eTG/9RRN8
         xUIXxAHDZc9aK5wP+YIBvEWBlYPLrSdb1Z/sXLTwjS0Qc98Nkx8mg8GBN62OWy0zoDbc
         jcjuP/SXOURDZ5oEkzKwA/Dvte1x0W9tRUPYtIzqp6nalyGPeyXbMmhuDPGA8jkhKwB7
         gXoMLX/Q4pCxLzUlSVgxm3u968ZR1Tounq2CJoBayRFE2tlKyIsrjlLQWa39yraMiw8n
         yeEA==
X-Gm-Message-State: ACrzQf0IQDh7H/5zf0TLsl34D2cZza5MyxQjR2aYijiIbxDmDG15/Y3R
        snNDd8bCnTsv4oCb3/9umNFVwMMUw3NHkK91RvE=
X-Google-Smtp-Source: AMsMyM7FQagympQoF02w3NjUUBCYlwsxqfgUO0qOaLc+FgBJvwDwQYVryxvfwBHP7BeFHYosXU5c9eiwuRqFCvXiKUI=
X-Received: by 2002:a05:6602:1509:b0:69b:35ba:4720 with SMTP id
 g9-20020a056602150900b0069b35ba4720mr2422187iow.155.1665758411053; Fri, 14
 Oct 2022 07:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221011171427.58891-1-masahiroy@kernel.org>
In-Reply-To: <20221011171427.58891-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 16:39:59 +0200
Message-ID: <CANiq72kvaPGr=2S6J7q7gfEg_CauHUfhuLmABpktfUPfK+_Hvg@mail.gmail.com>
Subject: Re: [PATCH v2] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 7:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 898b3458b24a..9221302f6ae8 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -64,16 +64,10 @@
>   * compiler should see some alignment anyway, when the return value is
>   * massaged by 'flags = ptr & 3; ptr &= ~3;').
>   *
> - * Optional: not supported by icc
> - *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned
>   */
> -#if __has_attribute(__assume_aligned__)
> -# define __assume_aligned(a, ...)       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
> -#else
> -# define __assume_aligned(a, ...)
> -#endif
> +#define __assume_aligned(a, ...)        __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))

Thanks for cleaning the conditional inclusion here. I double-checked
it is indeed available for both GCC and Clang current minimum versions
just in case: https://godbolt.org/z/PxaqeEdcE.

> diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
> index f5a9c70a228a..c281a6430cd4 100644
> --- a/lib/zstd/common/compiler.h
> +++ b/lib/zstd/common/compiler.h
> @@ -116,7 +116,7 @@
>
>  /* vectorization
>   * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax */
> -#if !defined(__INTEL_COMPILER) && !defined(__clang__) && defined(__GNUC__)
> +#if !defined(__clang__) && defined(__GNUC__)
>  #  if (__GNUC__ == 4 && __GNUC_MINOR__ > 3) || (__GNUC__ >= 5)
>  #    define DONT_VECTORIZE __attribute__((optimize("no-tree-vectorize")))
>  #  else

These files come from upstream Zstandard -- should we keep those lines
to minimize divergence?
https://github.com/facebook/zstd/blob/v1.4.10/lib/common/compiler.h#L154.

Commit e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream zstd
version 1.4.10") is the latest upgrade, and says:

    This patch is 100% generated from upstream zstd commit 20821a46f412 [0].

    This patch is very large because it is transitioning from the custom
    kernel zstd to using upstream directly. The new zstd follows upstreams
    file structure which is different. Future update patches will be much
    smaller because they will only contain the changes from one upstream
    zstd release.

So I think Nick would prefer to keep the changes as minimal as
possible with respect to upstream.

Further reading seems to suggest this is the case, e.g. see this
commit upstream that introduces a space to match the kernel:
https://github.com/facebook/zstd/commit/b53da1f6f499f0d44c5f40795b080d967b24e5fa.

> diff --git a/lib/zstd/compress/zstd_fast.c b/lib/zstd/compress/zstd_fast.c
> index 96b7d48e2868..800f3865119f 100644
> --- a/lib/zstd/compress/zstd_fast.c
> +++ b/lib/zstd/compress/zstd_fast.c
> @@ -80,13 +80,6 @@ ZSTD_compressBlock_fast_generic(
>      }
>
>      /* Main Search Loop */
> -#ifdef __INTEL_COMPILER
> -    /* From intel 'The vector pragma indicates that the loop should be
> -     * vectorized if it is legal to do so'. Can be used together with
> -     * #pragma ivdep (but have opted to exclude that because intel
> -     * warns against using it).*/
> -    #pragma vector always
> -#endif
>      while (ip1 < ilimit) {   /* < instead of <=, because check at ip0+2 */
>          size_t mLength;
>          BYTE const* ip2 = ip0 + 2;

Ditto: https://github.com/facebook/zstd/blob/v1.4.10/lib/compress/zstd_fast.c#L83.

Apart from the zstd divergence which I am not sure about, everything
looks good to me!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
