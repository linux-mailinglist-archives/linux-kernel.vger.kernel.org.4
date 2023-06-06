Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B07723823
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjFFGuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjFFGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:50:25 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB1E40
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:50:24 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-463e368a74cso1096307e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686034223; x=1688626223;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6D8/A1EaMpr0fZI/q/93AmR2VPYJ65578K2QcmNIOO4=;
        b=Wfays52CAY5id1Tvb60S6cBe4OW7bTPCrqwUhOLQZCdBURdjyoDs4CKzv42NeTdTBA
         FCpdWsttL9AyZrImgWH3YaI+/r/3fL88i8VkQiYoGGxyPrJBl1gDMpJ1JzMWTnclt9ul
         QYe3R0itQEyVIffou7S6Ifu1AIKYIL7bgErmNQcPcsZCHQiD7Li0yadRRWxzT1T/OQy9
         5YbtvGaq/3TVhvdPPs7OXj7DspG3vISjb04JD/dHiedItdW+J8kVAymtfGOiqMMWx9Eh
         sOYpucn3QZPIdzPoepcHtxcPcU57s0WUZt+/0KaQQXkHm1GO5YYbpgTvIFhbnPGElwKK
         YZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034223; x=1688626223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D8/A1EaMpr0fZI/q/93AmR2VPYJ65578K2QcmNIOO4=;
        b=EGgZTZDwkTXSQHmvFTyDfjrRHqLdOZvTEI7Ur5sKF6pKt6ca7VbbmSh204+kMPnIsj
         e7zLy1h40/nrXi375CB/zeMO/h2m47mSklbk4RWaD833bh2QTJPkUU9muyac3CofIyCt
         Wyj//aGMJ6m0X6YbN0Lxbps28hoK10xxG91I/bCCbXfaw4Vsb+T8LzFMyGcjbAI7mB4U
         8CyuGebXrwLnz9W5O9Q7BcLU5NHoCF9L6UvYE2rXiiKDVGLjDwXM4ISH7uOSl3l6ABWB
         gRoQ92tlzsqVQ9lZXO3PpAxx6YnDb0c446G+F1EMf46iprLuDdzbu7PRZ5cOlWi8qOBE
         EESQ==
X-Gm-Message-State: AC+VfDw9wKMVCd4vNU+i0Thzx2lJvSt2zLzeeyzuG8mZVRv66XAkyoxa
        EciPQ9OWKNS0JM1T8419ZB/YjYiriajYzyOJWCU+GA==
X-Google-Smtp-Source: ACHHUZ77YD2qmuIEso1iXnD54IE8hSPoEpKABhPPf8kF3y/L1FcPQsBzBpPrIjvtxBwtrUbpd9YDRZJ3u5BfwyRGIZo=
X-Received: by 2002:a1f:c3c3:0:b0:43f:f4a3:7385 with SMTP id
 t186-20020a1fc3c3000000b0043ff4a37385mr407796vkf.7.1686034223556; Mon, 05 Jun
 2023 23:50:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jun 2023 12:19:32 +0530
Message-ID: <CA+G9fYtVYhyCtD-ExKj7tOJbj9nykxkBs7dxHKo5v_H+kqG1Gg@mail.gmail.com>
Subject: perf: arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus' undeclared
To:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        ravi.bangoria@amd.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following warnings and errors noticed while building perf x86_64,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
arch/x86/tests/amd-ibs-via-core-pmu.c: In function 'test__amd_ibs_via_core_pmu':
arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus' undeclared
(first use in this function)
   47 |         if (list_empty(&pmus))
      |                         ^~~~
arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: note: each undeclared
identifier is reported only once for each function it appears in
arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit
declaration of function 'perf_pmu__scan'; did you mean
'perf_pmus__scan'? [-Werror=implicit-function-declaration]
   48 |                 perf_pmu__scan(NULL);
      |                 ^~~~~~~~~~~~~~
      |                 perf_pmus__scan
arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit
declaration of function 'perf_pmu__find'; did you mean
'perf_pmus__find'? [-Werror=implicit-function-declaration]
   50 |         ibs_pmu = perf_pmu__find("ibs_op");
      |                   ^~~~~~~~~~~~~~
      |                   perf_pmus__find
arch/x86/tests/amd-ibs-via-core-pmu.c:50:17: error: assignment to
'struct perf_pmu *' from 'int' makes pointer from integer without a
cast [-Werror=int-conversion]
   50 |         ibs_pmu = perf_pmu__find("ibs_op");
      |                 ^
cc1: all warnings being treated as errors

Links:
======
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346999/suite/build/test/gcc-11-lkftconfig-perf/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346999/suite/build/test/gcc-11-lkftconfig-perf/history/


--
Linaro LKFT
https://lkft.linaro.org
