Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A3746339
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGCTRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGCTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:17:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9879E52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:16:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so965959a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688411816; x=1691003816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmfYPyzMN3TrxeJJNRGqcc1V78+Dvq57QM07q24THxo=;
        b=cBXXw1BX/YQS5OhV4wyvCMLEJtw2faKDUqVuqbWKxU8/5yCELOp1tCfXiXtEv52L9k
         Yug4x5JvummwpTGtDjxJFlx12KJExacvZghztwNbjKCtREYW/fbFvq3eUtxNKLV+zRXg
         QTsAuM4NQEoG6QGtlMfRxMY7t78OQSQoth/0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411816; x=1691003816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmfYPyzMN3TrxeJJNRGqcc1V78+Dvq57QM07q24THxo=;
        b=IO6B48WhsiaAdX31MxMuxwj86NYCGXBBFrETTCDdrDukzDTyLtfTOgTQiDDUWLWVqS
         YydbbCscul0TRPZP7L8jegi1QgN8nJU7kncklc7E1I1nFo1L8AtLI3H9OwoR5ldEp2b9
         fJ8m9HNFBs4S7MQv5rCB7Q4Esq8sjmB3sJkr937KtJU6hUspaGyPD7YvzpyVJuupo/fj
         1CW2j4j/IQrgD9B2f0748o7zLG6WkVQDZz5Kgclu06F4eRN5OGp3MOGuNxKgl7jRkJOP
         flumwfLLnJi6tzmwSvYhyDH4YoZr6JNcxDN8UhdfE0LZX4dhiYERzs/ZulA0FU6MH90d
         /InQ==
X-Gm-Message-State: ABy/qLZHprp0c/qpc9sralXHNcDTZ0GzvdDZdURQLseSXWqPlOj1EO7p
        FT3UUaFF2Amf5su0lw3wzvGAxQ==
X-Google-Smtp-Source: APBJJlHAwULPXSe6lmSlODSHADBgzpaDcCSBPzHCTRoQEzG85Wo3jO6XKklJK6hdUmff3Yl9O+EZ7g==
X-Received: by 2002:a05:6a20:2595:b0:126:3528:5a13 with SMTP id k21-20020a056a20259500b0012635285a13mr13907284pzd.53.1688411816317;
        Mon, 03 Jul 2023 12:16:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i11-20020aa78b4b000000b0066a6ba123eesm14325571pfd.51.2023.07.03.12.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:16:55 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:16:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrei Vagin <avagin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: next: perf: 32-bit: bench/sched-seccomp-notify.c:139:24: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2
 has type 'uint64_t'
Message-ID: <202307031216.171373CD3@keescook>
References: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:55:59PM +0530, Naresh Kamboju wrote:
> Following build regressions noticed on Linux next-20230703.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on i386:
> 
>   - build/gcc-11-lkftconfig-perf
> 
> Regressions found on arm:
> 
>   - build/gcc-10-lkftconfig-perf
>   - build/gcc-11-lkftconfig-perf
> 
> Build error:
> =======
> bench/sched-seccomp-notify.c: In function 'bench_sched_seccomp_notify':
> bench/sched-seccomp-notify.c:139:24: error: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
>   139 |   printf("# Executed %lu system calls\n\n",
>       |                      ~~^
>       |                        |
>       |                        long unsigned int
>       |                      %llu
>   140 |    loops);
>       |    ~~~~~
>       |    |
>       |    uint64_t {aka long long unsigned int}
> cc1: all warnings being treated as errors
> make[4]: *** [tools/build/Makefile.build:97:
> /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/sched-seccomp-notify.o]
> Error 1

Thanks! I've updated the format string to use "%"PRIu64 now.

-Kees

> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230703/testrun/18069798/suite/build/test/gcc-10-lkftconfig-perf/history/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Kees Cook
