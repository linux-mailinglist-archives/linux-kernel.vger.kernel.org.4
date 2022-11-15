Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85EB629FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKORGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKORGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:06:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E505332
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:06:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l14so25381895wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyT/8fJ4yfKTDab/otE01avOS0d0fuM7jCcw1ooP8lI=;
        b=Co/m2/Lk9ouGbXKpmj/KC8y8bf5h3Z7BG0o2VyoYlsDnEHAd1S3FHIj/3XLsIMwMD5
         JCvYdVQhqYwYvxpyoe7LIfNPESiEAtBPukwzJWVyxwK9T3B+1kIdGKTU9GVUpmLumboO
         gkoLDhfJZZCGloK0V+1I8g6YESBuk/iKzR5avhGCdgSsFMKfrKAeqI83Myob0ln39iQ3
         ADTeOKL06bk4bryoMv+zWC5RsCYDoxO9MtFRmjEbiA8A5LziUULRpDPkC8A/LsuXanNf
         JN4sm0o7haSBSOHCIGsQTuWtfzOnAe7VLlKpIt5so1Oo4tR6uVA7ZrijI8YON446I1y6
         0oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyT/8fJ4yfKTDab/otE01avOS0d0fuM7jCcw1ooP8lI=;
        b=o7QFyrD1erX83GHfX6EvastG7Gom3NMITthq0A4eOctG27xXoUPixp/giH5g+h6Qzv
         ooGMqxXitP+pguAPfG+4LiwDVw2UttL4Pd8K78CFyG5Iv7yqLhsHu6uawODkwlwVLAF2
         cvzk0/kdCbwtfdq9kMWYoOhopsqIbHOYiz+NzCMXvM+CZQb7rtVMGKn83RYgM63wDeyX
         xgRK56wK1/zXafQ9/e+CCZmX2nMHYMPEoD0AKNqK3yBEacyanhaJa26atk1tCdKaWEeQ
         2vnghpNWfgBnd/79rn3+qT//vOF5mlFJd2SJIhYBSOKekIFUZ2Rmv7HxarzLbwlnnRXB
         b3ag==
X-Gm-Message-State: ANoB5pmvjumt2fZYS6QqZ0rrXVTz9ClOgcaBKxMWXo5a+2V8og5cRkIZ
        Fk6nVbBEtDScc9dO/GOG/fiW9+l5bTDk2PTTd/pn5Q==
X-Google-Smtp-Source: AA0mqf7JJSHpQROJ1YvYYKU7lm3OwMk18+5sIi/8vdN9XfuYDSxOvlftTB+nN3z6d48yPdZoFuO8ClOOAMDBUWYwtPw=
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id
 j1-20020a056000124100b00236d8f8b87dmr11033347wrx.343.1668532004688; Tue, 15
 Nov 2022 09:06:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvOGH92jByQYcFDGBKMQzFma=k=JLuaOOnHDq2FS1vWjQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvOGH92jByQYcFDGBKMQzFma=k=JLuaOOnHDq2FS1vWjQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 09:06:32 -0800
Message-ID: <CAP-5=fW+_rSpxDABw7EVxVaMOr6pMOiU7WUSMUkbGWppTej+Yg@mail.gmail.com>
Subject: Re: perf: gcc-12: tests/builtin-test.c:242:66: error: array subscript
 1 is outside array bounds of 'struct test_suite *[1]' [-Werror=array-bounds] ^
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Tue, Nov 15, 2022 at 4:14 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> You might be aware of the following perf build fails with gcc-12 for
> 32bit arm and i386.
> Whereas gcc-11 builds passed.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> -----------
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/block-info.o
> In function '__cmd_test',
>     inlined from 'cmd_test' at tests/builtin-test.c:522:9:
> tests/builtin-test.c:242:66: error: array subscript 1 is outside array
> bounds of 'struct test_suite *[1]' [-Werror=array-bounds]
>   242 |                 for (k = 0, t = tests[j][k]; tests[j][k]; k++,
> t = tests[j][k])
>       |                                                                  ^
> tests/builtin-test.c:351:9: note: in expansion of macro 'for_each_test'
>   351 |         for_each_test(j, k, t) {
>       |         ^~~~~~~~~~~~~
> tests/builtin-test.c: In function 'cmd_test':
> tests/builtin-test.c:35:27: note: at offset 4 into object 'arch_tests' of size 4
>    35 | struct test_suite *__weak arch_tests[] = {
>       |                           ^~~~~~~~~~
> cc1: all warnings being treated as errors
>
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/expr.o
> In function 'parse_events_term__num',
>     inlined from 'parse_events_multi_pmu_add' at util/parse-events.c:1594:6:
> util/parse-events.c:2638:64: error: array subscript 'YYLTYPE[0]' is
> partly outside array bounds of 'char[4]' [-Werror=array-bounds]
>  2638 |                 .err_term  = loc_term ? loc_term->first_column : 0,
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> util/parse-events.c: In function 'parse_events_multi_pmu_add':
> util/parse-events.c:1579:15: note: object 'config' of size 4
>  1579 |         char *config;
>       |               ^~~~~~
> cc1: all warnings being treated as errors
>
> build log link,
> https://builds.tuxbuild.com/2HXiqb3LCKg451GckF052odBiPY/
>
> Please refer following links for perf build results comparison between
> gcc-11 and gcc-12
>
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.8-191-gf8896c3ebbcf/testrun/13003574/suite/build/test/gcc-11-lkftconfig-perf/history/
>
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.0.y/build/v6.0.8-191-gf8896c3ebbcf/testrun/13003574/suite/build/test/gcc-12-lkftconfig-perf/history/

I wonder if this is a GCC bug. There shouldn't be any difference 32 vs
64-bit, the arrays of tests are NULL terminated. Perhaps the weak
symbol (weak symbols are outside the C specification) is the issue and
defeats the analysis but only for 32-bit.

Thanks,
Ian

> --
> Linaro LKFT
> https://lkft.linaro.org
