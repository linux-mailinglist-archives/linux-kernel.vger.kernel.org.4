Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E2602F68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJRPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJRPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:16:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC02BC60E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:16:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-345528ceb87so140040357b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hC5+H9wThte8MY69gIx2xqsknF0ksS14sajV6ZapONA=;
        b=pEWnSzUOxXiPxOwCojbHt0Ql7Sdfg1xb/ShpS1y5GaG37LyQxCvdg73JJCCAvqEQNQ
         hwmA00zFIRl6uzKiAw+hTLFaEimqM7wHvuuwrrHiDliuekIv4avtOWHDMy4rK1AwmlWE
         xWHBGazzotTrsg8zHmb3joTQym6/9o7u6FCNFugQZIwv9U85JIJIFqVUKw/AFDfy/5LZ
         eKo3apEZNd1+OeRcvSYYeeHshtUltJXPxQBSVJHuyKUgkeu3z0+FVKz8njYW+CPJ6/pF
         eNB3Z/0zvNza+pGkkr7mC6ajLkZRlphMLN6EHw101qYsFgIC4WHfiJAc6JDjBi3yN204
         ryvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hC5+H9wThte8MY69gIx2xqsknF0ksS14sajV6ZapONA=;
        b=v+IwL36d8PWwhyfraG3m3kHOtkr191/7TQL44XaUtD8LVAPyO3FSxqwMSliWHVxa0D
         Tu0qghffXybnzf8xguR8K0Z5FFQyeCOO4yxuYQ2Ucxk9Ik2jY5m/6HLVHjgYjc6QbuKn
         i2Cc7n3wQTV3kwl+IcUX5jX9dLA6VsCdKuNvcN6yowiN2Ojp3xGSGqNmJatAXqqvKwKP
         pFQhnydHFMNOj5aLJ7h6QaRVK5q+CdVjgKSPd/XeloHHOlY7xmtIK9+OEyJZo8zvlDWA
         CAB4Kx1iIQ5xMvH9p0cdBQbehk/Xq02ivDDLCw5rAf09eqX1m1ek2/CuvUGM6M4ypS1k
         VUsA==
X-Gm-Message-State: ACrzQf3d2l6kO6SvEzUMIwgkXcDO9e67eFVGLGUwAUbpUMBAVJq8ngLX
        LDC9I4h6BMGAo2oUi6enBQLfAR89sObc5GkiygkBfg==
X-Google-Smtp-Source: AMsMyM7vPdBrkAZHpKMlIc3VWMGVfXuLYdDN8TIrNVr5iRJf0YmFPuPgclnEA3cx2SM+BAgy7G0g8I9KORfaqsqqxdc=
X-Received: by 2002:a81:984a:0:b0:360:daaa:1edf with SMTP id
 p71-20020a81984a000000b00360daaa1edfmr2897339ywg.238.1666106163327; Tue, 18
 Oct 2022 08:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221018102254.2424506-1-ryasuoka@redhat.com>
In-Reply-To: <20221018102254.2424506-1-ryasuoka@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Oct 2022 08:15:26 -0700
Message-ID: <CANpmjNMoZ6X-bPHg3pfWrnBfP-khpwXNvHxxrwXf2R27_PuSZA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Fix trivial typo in Kconfig help comments
To:     Ryosuke Yasuoka <ryasuoka@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     dvyukov@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 03:23, Ryosuke Yasuoka <ryasuoka@redhat.com> wrote:
>
> Fix trivial typo in Kconfig help comments in KCSAN_SKIP_WATCH and
> KCSAN_SKIP_WATCH_RANDOMIZE
>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks.

> ---
>  lib/Kconfig.kcsan | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 47a693c45864..375575a5a0e3 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -125,7 +125,7 @@ config KCSAN_SKIP_WATCH
>         default 4000
>         help
>           The number of per-CPU memory operations to skip, before another
> -         watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
> +         watchpoint is set up, i.e. one in KCSAN_SKIP_WATCH per-CPU
>           memory operations are used to set up a watchpoint. A smaller value
>           results in more aggressive race detection, whereas a larger value
>           improves system performance at the cost of missing some races.
> @@ -135,8 +135,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
>         default y
>         help
>           If instruction skip count should be randomized, where the maximum is
> -         KCSAN_WATCH_SKIP. If false, the chosen value is always
> -         KCSAN_WATCH_SKIP.
> +         KCSAN_SKIP_WATCH. If false, the chosen value is always
> +         KCSAN_SKIP_WATCH.
>
>  config KCSAN_INTERRUPT_WATCHER
>         bool "Interruptible watchers" if !KCSAN_STRICT
> --
> 2.37.3
>
