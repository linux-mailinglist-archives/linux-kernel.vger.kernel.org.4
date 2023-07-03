Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0103745601
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGCH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjGCH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:26:25 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3ECC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:26:13 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-443512ad63cso1119789137.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=DHzBol8NLJ+48zey6G6sAvkl6ZLmYaukks2MSceVz9eVvrtdUcyJ7mgcYSrSO0hTwW
         2iVMxffzSLK0S2/rPMgLtNkyJjYZUKmqi8+xlyXOlLQjLrlwi/Z83AwdtiZ5b7loS6dA
         9hhK9Sl0KSPoDlNfosKy43Jfeqn3agIJyzOHO9P4eyJIHAmCkk/HpC0YsAiF7G4UnTBv
         q2nXKbdUE9jZeWnadixu10OKXl3xbJWeJZAWfW2I/1enV/ofupc3gmNxVbhB+V+Wt8xe
         aqkGFYTgm1S8qtpKLatDn5ft4qkD7eWDUourxJc5SV8rSaXP0pKTeUIJngzgXv/QvbEM
         ubNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=CNBaRCcGjWUb4Z5fSU+TS1IkzH9UyBd0YpXwDTiOIAC6G/ATjnG+DbvXHAoOQ6Ysql
         BoUMfMJNUpeESZ2+Odiw/OFdJDWOA6fLsj5QlMDFS25bbp6U8ZR8vhDTkMQ6Qn8exic3
         q/4is7du56Z83Il1FWOMqxZlw7h3zJkHnV/QrXFX1dVmOGC74dkUKi7jHH/RhDdL0C3X
         hhoG9PBZ5lca57evfNXxZjmozqRovNtNKtDoj0meQOozeuBrMZL3073WyRG7Px1NnXyf
         03wfVfFova4/mreCnrnoMwxvwob2GIVidR59PP7bFfo5ACccoZP57AI0iRcskOQ0SIPY
         bGDg==
X-Gm-Message-State: ABy/qLbV98oq+TonEwFC5llXkhAlveFBehcs6Vz5BeZutT0ZJlNEgOaI
        VkoC2KL5Sj6dPsP0HvoWN4mT6vrHEpL1JB39ecFowNoBPFxCPhAN8SfMrw==
X-Google-Smtp-Source: APBJJlGau/9OizFSeLgMU/K7IoZbflIEWzaM5xflRF3SI1OEFTJw/gCMYBFgMESsm8IteNIYVawKBkXDI8mVc+q8tBM=
X-Received: by 2002:a67:f651:0:b0:443:51a7:b63d with SMTP id
 u17-20020a67f651000000b0044351a7b63dmr4037175vso.23.1688369171044; Mon, 03
 Jul 2023 00:26:11 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 3 Jul 2023 12:55:59 +0530
Message-ID: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
Subject: next: perf: 32-bit: bench/sched-seccomp-notify.c:139:24: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2 has
 type 'uint64_t'
To:     open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc:     Andrei Vagin <avagin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regressions noticed on Linux next-20230703.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on i386:

  - build/gcc-11-lkftconfig-perf

Regressions found on arm:

  - build/gcc-10-lkftconfig-perf
  - build/gcc-11-lkftconfig-perf

Build error:
=======
bench/sched-seccomp-notify.c: In function 'bench_sched_seccomp_notify':
bench/sched-seccomp-notify.c:139:24: error: format '%lu' expects
argument of type 'long unsigned int', but argument 2 has type
'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
  139 |   printf("# Executed %lu system calls\n\n",
      |                      ~~^
      |                        |
      |                        long unsigned int
      |                      %llu
  140 |    loops);
      |    ~~~~~
      |    |
      |    uint64_t {aka long long unsigned int}
cc1: all warnings being treated as errors
make[4]: *** [tools/build/Makefile.build:97:
/home/tuxbuild/.cache/tuxmake/builds/1/build/bench/sched-seccomp-notify.o]
Error 1

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230703/testrun/18069798/suite/build/test/gcc-10-lkftconfig-perf/history/


--
Linaro LKFT
https://lkft.linaro.org
