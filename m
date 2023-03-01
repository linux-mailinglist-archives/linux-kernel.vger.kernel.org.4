Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919596A6D37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCANlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCANlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:41:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6923E09C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:41:44 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q6so5387462iot.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq5OR9hoC260+bemchGBNuQjrNOZhrK9iuZRCuifkTs=;
        b=RNGjW0fKHBPVSu32cnLyQ80bXdFmMDWGyWr8DyQlkX0JakbZI256w+r+tZD8H5sgLv
         Mv93XNX6nbqefYx/euZAMec/fMtwLa6mGSn4k3ROmTxw2u0ojuqabJH+jtV4tzRPAMKB
         Sf4KhzQY2gByZpvCMeUGD+L6zbuVQ94yycdGRyqLMeZsxotjVaKc1YYEOfw+n4dN1ZvQ
         Fgf2sYQftnkmbDAqBSJbZxAR34gndmTIaEgKOwgBjqv+i0tZaPptUnvevGUMUG3iHXCh
         bev3NxJ2B5iVDweZuR2h4Wenct2gS8Uo/P9mjYJ37PUqnG+cmME2c1cqJdMTE6E2Xg2W
         lHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kq5OR9hoC260+bemchGBNuQjrNOZhrK9iuZRCuifkTs=;
        b=nm8JYU1x3RMt+tD8EJcXVBbSkLasME1AeTD2CawxOeXuyk+taZyanY13Rqw1KGhEjl
         kRPwRXzbDx29ixZXkQmg2uW5T2TYlvUfJaTomveYvsR/VISK54JhV+AiCMFANVeRqnP2
         gkTAEhRilTtLEzX9i3b4q0jaw65fcYiIJy5vMHgOCtLQw19MNSoEeyikw4W/kQDIiV8/
         0/JsdBJV/saujNo1B9IyIVnmZIdEvbOuke96aWkwnwyWGa/G8Y0nerzjUqUFDndBysAP
         rKOgPZ6UYX+nX7H0HLFig9SJyEDrpx1pjYPagVI273is85iG52BkJqUcHSztS+JBaNtX
         q1nA==
X-Gm-Message-State: AO0yUKVQtBzuquismMoThGWhyVJxJcHd7y6LNTw2ZWirpUtg0Bd7PyO/
        GW/6/Jlzn13BE2ZYOzSyh/OHvvSY3arLWIvfnvfCyg==
X-Google-Smtp-Source: AK7set+BWIITMwStn5iOknYU9Ytckv0R80OlViWQC7TNRL095p3FTuT9mKhGhMd4MFbc9GXISWxJtJVx+O7r52M/2LM=
X-Received: by 2002:a02:85cb:0:b0:3c5:b47:539a with SMTP id
 d69-20020a0285cb000000b003c50b47539amr2818912jai.5.1677678103307; Wed, 01 Mar
 2023 05:41:43 -0800 (PST)
MIME-Version: 1.0
References: <cad03d25-0ea0-32c4-8173-fd1895314bce@I-love.SAKURA.ne.jp>
 <CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com>
 <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
 <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
 <Y7a6XkCNTkxxGMNC@phenom.ffwll.local> <032386fc-fffb-1f17-8cfd-94b35b6947ee@I-love.SAKURA.ne.jp>
In-Reply-To: <032386fc-fffb-1f17-8cfd-94b35b6947ee@I-love.SAKURA.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 1 Mar 2023 14:41:06 +0100
Message-ID: <CAG_fn=V4-zzo+6HFG+wCbJRYHRh+Xx=r1weyCBJG-afpaG4Hag@mail.gmail.com>
Subject: Re: [PATCH] fbcon: Use kzalloc() in fbcon_prepare_logo()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
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

>
> I'd like to avoid touching per-arch asm/string.h files if possible.
>
> Can't we do like below (i.e. keep asm implementations as-is, but
> automatically redirect to __msan_memset()) ? If yes, we could move all
> __msan_*() redirection from per-arch asm/string.h files to the common
> linux/string.h file?
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index c062c581a98b..403813b04e00 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -360,4 +360,15 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>         return strncmp(str, prefix, len) == 0 ? len : 0;
>  }
>
> +#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
> +#undef memset
> +#define memset(dest, src, count) __msan_memset((dest), (src), (count))
> +#undef memset16
> +#define memset16(dest, src, count) __msan_memset((dest), (src), (count) << 1)
> +#undef memset32
> +#define memset32(dest, src, count) __msan_memset((dest), (src), (count) << 2)
> +#undef memset64
> +#define memset64(dest, src, count) __msan_memset((dest), (src), (count) << 3)
> +#endif

The problem with this approach is that it can only work for
memset/memcpy/memmove, whereas any function that is implemented in
lib/string.c may require undefining the respective __HAVE_ARCH_FNAME
so that KMSAN can instrument it.
