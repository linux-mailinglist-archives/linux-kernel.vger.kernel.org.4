Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876D67A184
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjAXSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjAXSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:42:03 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11E4A1FC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:41:33 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a2f8ad29d5so231177477b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+Yt0CkwIbd85GrAKd4j3/Yh/keaU+8k8lD2GhYWx/4=;
        b=Qj/2f56cIQtkvG/MpyWQOUzc3/ZKUreNHesFQxQLV+DnVdGnm+42u/0qqmpFLPGRdC
         s80K2ZJ7lwCbjEaUzKGExVpqx8PkeIM8+oXbjjXRGulfRNugNxHtI08TV807w2iq+CKx
         gOjg+oWG2leHE7rmty3wJL/jrZCKKkEmCeBgQ1WrLp8AtRPNua+pJsbyXGCwYncGTAvz
         SBbSYyWNxinelaZBawfVbACiHybTrnt8KSCVoh2VvLLsz4zTyEL4dhy12kF/6md+8yUB
         Kw6GqRYM6Y9qHrRvFue42kpJN0beJNa+fXu4gWnKbdE2XX71X52YE+Jmgl3moLjNvI9a
         2o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+Yt0CkwIbd85GrAKd4j3/Yh/keaU+8k8lD2GhYWx/4=;
        b=k9pS/gMNHtVQchYRbxS43rgL/BWmElBY0VLrmAO6040GDKTN1vwbaaa2Yp9CKssIQe
         8Fs0KlKtetrOGixk+DcYnHQAjMHJqwAn4dJezxyk3lea/YPewxvguaNEYPQGsfaID2Jo
         JBaxlkeDfWhNV9qHwQyXu/LP2WUMEeYQRlhEwpWbNU+z2vkORYiFBSGUR7GFbNmeNyF7
         K5NNWIObPH1CjVHlu2xFqUnGThHnWsVTgJ7JG8qjA4rVnfZbcgz24oGWHh97lOAseaVT
         nv43Z1PIkMfyDjMcy4gglnQChaGguv+SXE3ORNwRoZnLBOIdyeXSgFGgtgKYy8lCjlMB
         oDAg==
X-Gm-Message-State: AO0yUKVkk/Rd2fzh5yOYPF9GBiC3tN8wFehA2nIq9wARB1BqrST6swS5
        434181A6Uj3ku4/KRZxCyCJCrM5Cfuri0li0/eIGMg==
X-Google-Smtp-Source: AK7set8aFKOf38oFnpmTSPdGl1G8cr5qFyfz8v/QORpGf2yX6t1CqgotLO2f5rY6GZHrTpusOakxIIEbMeqZ0TpL5xw=
X-Received: by 2002:a0d:ea43:0:b0:506:38f1:918b with SMTP id
 t64-20020a0dea43000000b0050638f1918bmr553482ywe.255.1674585692103; Tue, 24
 Jan 2023 10:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20230124181655.16269-1-rdunlap@infradead.org>
In-Reply-To: <20230124181655.16269-1-rdunlap@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 24 Jan 2023 19:40:55 +0100
Message-ID: <CANpmjNOx9CmRc8=nri9cYk9+3mRvGqxawNOep4_OpF10_523UA@mail.gmail.com>
Subject: Re: [PATCH] lib: Kconfig: fix spellos
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kasan-dev@googlegroups.com
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

On Tue, 24 Jan 2023 at 19:17, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix spelling in lib/ Kconfig files.
> (reported by codespell)
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: kasan-dev@googlegroups.com
> ---
>  lib/Kconfig.debug |    2 +-
>  lib/Kconfig.kcsan |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/lib/Kconfig.debug b/lib/Kconfig.debug
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1876,7 +1876,7 @@ config FUNCTION_ERROR_INJECTION
>         help
>           Add fault injections into various functions that are annotated with
>           ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> -         value of theses functions. This is useful to test error paths of code.
> +         value of these functions. This is useful to test error paths of code.
>
>           If unsure, say N
>
> diff -- a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -194,7 +194,7 @@ config KCSAN_WEAK_MEMORY
>           Enable support for modeling a subset of weak memory, which allows
>           detecting a subset of data races due to missing memory barriers.
>
> -         Depends on KCSAN_STRICT, because the options strenghtening certain
> +         Depends on KCSAN_STRICT, because the options strengthening certain
>           plain accesses by default (depending on !KCSAN_STRICT) reduce the
>           ability to detect any data races invoving reordered accesses, in
>           particular reordered writes.

Reviewed-by: Marco Elver <elver@google.com>

Thanks!
