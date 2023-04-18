Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83D6E656F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjDRNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjDRNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:07:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FD61A2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:07:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-329627dabfbso32548725ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681823266; x=1684415266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXVmjV8MVgirfDn+CQoxVOKGwz3EOWGBSd7QdBjs3YU=;
        b=FEhqIjfUFBdpSfQagkw9jonNAUAscLxrsIh1vsdZq1hGcKFvhmQ4TLtVZIvuD3ZYv9
         /C8kcv4CIsY2w5UaWTjdhTDV+zNozyaypkg+d7+7uMrpetboBse7uVuWCaROwdkzspPV
         2IWdEubu+rBVJuEGM1mIksIZwhi+mm8KM6yeenH98npp/oZQUeSdw8rbeyFyOe/oUbM0
         XQoJybct5Ml8eLgf4JsmU0wbSs5FhU0ivKaAnx6QA1g0Jm0o+yjf7poWewPZMq3T4AG5
         EN+69mfKvvmpZTfXeh4F2eCd/HdLgfGBsKO11F67NyazW3Evlxc5ut1mcYHqdUwjsC5u
         EyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823266; x=1684415266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXVmjV8MVgirfDn+CQoxVOKGwz3EOWGBSd7QdBjs3YU=;
        b=XFVKH+B5tbnoHrfFQqwvC96sQpa8UPJOEpMkhsHDvZw0ZxNfsRrbvdRr4BqRJDMD85
         HgprKgSI5K93hcipV0HDNsvW5Z03rqg373QOCIm8n3FWYlr5+TFmXZ1XsZClO5G6WwJR
         IqiWVJSBPcSlUhFJQAArB36N+CIQ8b/2qk033QfmuY+a1doT6dGq081nNgnyGBGDwzvG
         7eKnkg3xGTnmHCz7lgyF5QyxBu2SVN5laBFLAoGjrBMAhim3fbNFhJFM6gw3TJKG3f4J
         dWMKfJZ2eZRRxdzaBgFHbwHm7r2VTIK6atP5I8ujgusFrk6JLX09uFREnMEOV6/OIpEe
         BHrg==
X-Gm-Message-State: AAQBX9ekr58eWCObgtBNY87pOUSukjqAg0SMMGpzc3yvxfMi0b7GsJuq
        8TqO9lTvARjM4VH5ChiIrUQCo6j16lw4vAgOZxyw+w==
X-Google-Smtp-Source: AKy350YY29Hcz4bDHqyw+MtMx0elQI8dDkrsoJtgWQJYOE4mHHXtRou3LfMvdZJd7dEUdkrM0A/U6XT+VqPnNMB0tjQ=
X-Received: by 2002:a5e:8607:0:b0:753:989:ebb5 with SMTP id
 z7-20020a5e8607000000b007530989ebb5mr1792769ioj.7.1681823265971; Tue, 18 Apr
 2023 06:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230418122350.1646391-1-arnd@kernel.org>
In-Reply-To: <20230418122350.1646391-1-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 15:07:09 +0200
Message-ID: <CANpmjNOSi32aN54_=WH1xb4jqzso+-riMomLxoqebO=AdbpHVA@mail.gmail.com>
Subject: Re: [PATCH] [v2] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1
 for clang-14
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        kasan-dev@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 at 14:24, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some unknown -mllvm options (i.e. those starting with the letter "h")
> don't cause an error to be returned by clang, so the cc-option helper
> adds the unknown hwasan-kernel-mem-intrinsic-prefix=1 flag to CFLAGS
> with compilers that are new enough for hwasan but too old for this option.
>
> This causes a rather unreadable build failure:
>
> fixdep: error opening file: scripts/mod/.empty.o.d: No such file or directory
> make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:252: scripts/mod/empty.o] Error 2
> fixdep: error opening file: scripts/mod/.devicetable-offsets.s.d: No such file or directory
> make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 2
>
> Add a version check to only allow this option with clang-15, gcc-13
> or later versions.
>
> Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
> Link: https://lore.kernel.org/all/CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
> v2: use one-line version check for both clang and gcc, clarify changelog text
> ---
>  scripts/Makefile.kasan | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index c186110ffa20..390658a2d5b7 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -69,7 +69,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>                 $(instrumentation_flags)
>
>  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> +ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
>  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> +endif
>
>  endif # CONFIG_KASAN_SW_TAGS
>
> --
> 2.39.2
>
>
