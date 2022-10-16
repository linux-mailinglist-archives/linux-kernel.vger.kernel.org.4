Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEF6002DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJPSYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJPSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:23:57 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C94507B;
        Sun, 16 Oct 2022 11:23:54 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 29GINb2O032674;
        Mon, 17 Oct 2022 03:23:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 29GINb2O032674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665944617;
        bh=fRz3ySy23/ffC+gMEN6Ix4ccsH+L67FX85AWDvOKFP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dG5x6oSvzyK0jY6Po8VHkVul8Z73cqvvfY0uq5MqnGBTyn4mcxQsRBOqM32iRIbqc
         qIhzU+wy7U+WDgq3TgN6zrbhbufMe8cpTwoS3UkVWnTe8+Qa5sHfSJ6K6OwzptCfWf
         5Zj4YyHI4AswPvS6Lw1MFT2FfqGwfN5XbeFHvjT6ldbIQe/CCcTvuEc0caKueYhGsp
         2Y6zSpyS9QRYyEM0FHxISxXUL1bp9WtvKW6N6UQj0f7A2Lk3AMmECRE56r8PNN+dMg
         Ic/CTfVobJxsDJVZj3sSVZJHrKlO+BrHh6nFQBgjBvke9IffduQ6fgQPQcFCHGrUk7
         69r8WkeJ9UhyQ==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-134072c15c1so11293026fac.2;
        Sun, 16 Oct 2022 11:23:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf14KkT1z9z4Z37Zubp/3lDY2k/yizLdnrAdqy2ITuJH+3lJ4zHU
        BMxyyqtQREV+U6ciOdoq/kpePnx0IfT99zli9D0=
X-Google-Smtp-Source: AMsMyM6GRvVgXtI3ayO2vjiuPBvoDA4IVEzkiYVV0tBwypOIIW4e6YoM8Or3yA24icDQL2VRQQfGQFrPBzAw0kD++Z4=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr13479026oaq.194.1665944616376; Sun, 16
 Oct 2022 11:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221011171427.58891-1-masahiroy@kernel.org> <CANiq72kvaPGr=2S6J7q7gfEg_CauHUfhuLmABpktfUPfK+_Hvg@mail.gmail.com>
In-Reply-To: <CANiq72kvaPGr=2S6J7q7gfEg_CauHUfhuLmABpktfUPfK+_Hvg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 17 Oct 2022 03:22:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkSbH-Gw3sgMzxHyA9pSf3gLVvbCLg3yvbO43_vi5=YA@mail.gmail.com>
Message-ID: <CAK7LNAQkSbH-Gw3sgMzxHyA9pSf3gLVvbCLg3yvbO43_vi5=YA@mail.gmail.com>
Subject: Re: [PATCH v2] Remove Intel compiler support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:40 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 11, 2022 at 7:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> > index 898b3458b24a..9221302f6ae8 100644
> > --- a/include/linux/compiler_attributes.h
> > +++ b/include/linux/compiler_attributes.h
> > @@ -64,16 +64,10 @@
> >   * compiler should see some alignment anyway, when the return value is
> >   * massaged by 'flags = ptr & 3; ptr &= ~3;').
> >   *
> > - * Optional: not supported by icc
> > - *
> >   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
> >   * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned
> >   */
> > -#if __has_attribute(__assume_aligned__)
> > -# define __assume_aligned(a, ...)       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
> > -#else
> > -# define __assume_aligned(a, ...)
> > -#endif
> > +#define __assume_aligned(a, ...)        __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
>
> Thanks for cleaning the conditional inclusion here. I double-checked
> it is indeed available for both GCC and Clang current minimum versions
> just in case: https://godbolt.org/z/PxaqeEdcE.
>
> > diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
> > index f5a9c70a228a..c281a6430cd4 100644
> > --- a/lib/zstd/common/compiler.h
> > +++ b/lib/zstd/common/compiler.h
> > @@ -116,7 +116,7 @@
> >
> >  /* vectorization
> >   * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax */
> > -#if !defined(__INTEL_COMPILER) && !defined(__clang__) && defined(__GNUC__)
> > +#if !defined(__clang__) && defined(__GNUC__)
> >  #  if (__GNUC__ == 4 && __GNUC_MINOR__ > 3) || (__GNUC__ >= 5)
> >  #    define DONT_VECTORIZE __attribute__((optimize("no-tree-vectorize")))
> >  #  else
>
> These files come from upstream Zstandard -- should we keep those lines
> to minimize divergence?
> https://github.com/facebook/zstd/blob/v1.4.10/lib/common/compiler.h#L154.
>
> Commit e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream zstd
> version 1.4.10") is the latest upgrade, and says:
>
>     This patch is 100% generated from upstream zstd commit 20821a46f412 [0].
>
>     This patch is very large because it is transitioning from the custom
>     kernel zstd to using upstream directly. The new zstd follows upstreams
>     file structure which is different. Future update patches will be much
>     smaller because they will only contain the changes from one upstream
>     zstd release.
>
> So I think Nick would prefer to keep the changes as minimal as
> possible with respect to upstream.
>
> Further reading seems to suggest this is the case, e.g. see this
> commit upstream that introduces a space to match the kernel:
> https://github.com/facebook/zstd/commit/b53da1f6f499f0d44c5f40795b080d967b24e5fa.
>
> > diff --git a/lib/zstd/compress/zstd_fast.c b/lib/zstd/compress/zstd_fast.c
> > index 96b7d48e2868..800f3865119f 100644
> > --- a/lib/zstd/compress/zstd_fast.c
> > +++ b/lib/zstd/compress/zstd_fast.c
> > @@ -80,13 +80,6 @@ ZSTD_compressBlock_fast_generic(
> >      }
> >
> >      /* Main Search Loop */
> > -#ifdef __INTEL_COMPILER
> > -    /* From intel 'The vector pragma indicates that the loop should be
> > -     * vectorized if it is legal to do so'. Can be used together with
> > -     * #pragma ivdep (but have opted to exclude that because intel
> > -     * warns against using it).*/
> > -    #pragma vector always
> > -#endif
> >      while (ip1 < ilimit) {   /* < instead of <=, because check at ip0+2 */
> >          size_t mLength;
> >          BYTE const* ip2 = ip0 + 2;
>
> Ditto: https://github.com/facebook/zstd/blob/v1.4.10/lib/compress/zstd_fast.c#L83.
>
> Apart from the zstd divergence which I am not sure about, everything
> looks good to me!
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel


Thanks for your close review.

I will drop zstd changes and send v3.



-- 
Best Regards
Masahiro Yamada
