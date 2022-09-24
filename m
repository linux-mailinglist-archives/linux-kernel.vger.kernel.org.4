Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7920F5E8EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiIXQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIXQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE2857E6;
        Sat, 24 Sep 2022 09:57:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e5so2910850pfl.2;
        Sat, 24 Sep 2022 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=1E0SmAG1zMtGpgd4usKXl/ulVKEy4vgx4ZMpo2BJm1w=;
        b=Xwx8u7YO9fr60zms/hLTGR+6VmKjqpn2hvEzCEJYp/5Ke8z5Ikwt8tFEJHLo2mZJ/8
         WgZu5fV6qaT0mjcK/beIB1d5Xnzw/bnwM0tC49mVBczh/Nv4T5KUQgpAT49gTCwDTHZQ
         qGPgyMglM31IozYzxdy0kvI71CTUrFS+vLWi7xgn5tBokk5SlvROgVMg8LDR+9eh0FKX
         jA+e6Kmg6hehhio2UcN6Hv7leyWSl0qNlfiBNrsFzCyKr9kWxZyknlUzyMyOGQ8ODgCs
         7Q/y6wiivrS1zvFb8iN2MpbQ96/CWvwH3RgEFhl7L/KHzNrovOEiCgyEF14yTSAmsed2
         +L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=1E0SmAG1zMtGpgd4usKXl/ulVKEy4vgx4ZMpo2BJm1w=;
        b=a5C3J8K/p6rqwslwQV1wp6naxbd1mmaxinZgSwzJ3E6mRfcZT5P0oqa1aXd3Rdp7KP
         XIhmPh8hJuw6NVn9VxioyEVM8Rj2PNyLe/coFMNmAPRGn+HSXRUr2JbY5ebr41e+SisB
         tUESFYbnSP6nP8strkYzmNRZgu+NY6DDTsz5ae0JhLk1jbrZU3NCd6JCQ1nPF1greQhS
         gqQ2yIHXDCY3FvMMeRqMVjxvxcOM7zF1x6mrs5UeFnOlQK3z3oIJ6M/lU6HdGZJqJcmh
         CLYFWax6ZqW7Xaxs3L17HMBbaVZc+CnxULejJ0SXUGH18F93xLlKg10eBGBebbBmgJr3
         AMRw==
X-Gm-Message-State: ACrzQf3hCKn1Y2bhZYtnFlxAlDGbnMLqxufXv+vDm6GEohQxcQt2L1n6
        KDq7jj4lLMOWJy2NApWufXg=
X-Google-Smtp-Source: AMsMyM5UlZQ8GK52njQnoPAnJhydxopgy3eoiO5mi1fbDmjevmmYffok0AWti0JmC+G/PrY8XJhFQA==
X-Received: by 2002:a05:6a00:170e:b0:550:dc52:4647 with SMTP id h14-20020a056a00170e00b00550dc524647mr14820870pfc.19.1664038659709;
        Sat, 24 Sep 2022 09:57:39 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:39 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/5] perf tools: Clean up cpu map handling for a system-wide evsel (v1)
Date:   Sat, 24 Sep 2022 09:57:32 -0700
Message-Id: <20220924165737.956428-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The system-wide evsel has a cpu map for all (online) cpus regardless
of user requested cpus.  But the cpu map handling code has some
special case for it and I think we can cleanup the code by making sure
that such a evsel has a proper cpu/thread maps from the beginning.
This patches should not cause any change in the behavior.

You can get the code from 'perf/cpumap-update-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
  
Thanks,
Namhyung


Namhyung Kim (5):
  libperf: Populate system-wide evsel maps
  libperf: Propagate maps only if necessary
  perf tools: Get rid of evlist__add_on_all_cpus()
  perf tools: Add evlist__add_sched_switch()
  perf tools: Remove special handling of system-wide evsel

 tools/lib/perf/evlist.c             | 23 ++++++++-------
 tools/lib/perf/evsel.c              |  3 --
 tools/perf/arch/x86/util/intel-pt.c | 15 ++++------
 tools/perf/builtin-script.c         |  3 --
 tools/perf/tests/switch-tracking.c  | 15 ++++------
 tools/perf/util/evlist.c            | 46 ++++++++++++-----------------
 tools/perf/util/evlist.h            |  1 +
 tools/perf/util/evsel.c             | 12 ++------
 tools/perf/util/stat.c              |  3 --
 9 files changed, 44 insertions(+), 77 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

