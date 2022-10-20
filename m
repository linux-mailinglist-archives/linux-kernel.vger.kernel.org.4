Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB56066F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJTR0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00A2A971;
        Thu, 20 Oct 2022 10:26:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p6-20020a17090a748600b002103d1ef63aso223535pjk.1;
        Thu, 20 Oct 2022 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FSWnRxtqE96/g59wuJmgIQrOE2XEcx+NdrwZOCesEeY=;
        b=Lc3/Qqy0FWXejyUn2ZGcudk75Sb5MrnTavlEcsFv+zx5wsK3El2aW6ggg8B/BhU77J
         SNTm6ObFWwRa1ssCp0ju1iUQKQlQt/iP3hD9AvY7PSFoEWsGKQ5tFvqY37j0BZa/ZZ/C
         EAZvNK13xlD5jcB7nXnKlt5n0I4CXX4neqpT4TZOlEkyokwe9zYQbfW1nmKJk0RffMQJ
         pmlw4gufyUYiDh7EwxdIvh4RpQOMV+XWKYZPQtRf8b0mRWZLrtHm5yHl/9snjuWAPVsp
         un4NgZUzBh6NRpljNfBphrH73MQltXfCK6WgGo8VfDuZAD7q/W9Dzf4LHt06CJ1hMQ+l
         vm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSWnRxtqE96/g59wuJmgIQrOE2XEcx+NdrwZOCesEeY=;
        b=HL0Iz3nScNNMPO8Ift/c+AOb2Mk+SPmcNU4z8ubOsnvmCAqzWMCRWI+QE7OG8oDP0+
         KWPrku9N+Wqao0Vddj+paaOT+VST9K3KsdA97T5EnVvA8/0W9lXM9o6mzbK086cXJdN3
         kL6e0EXAN/TOxISsCPNROQVHc7aVmGneLQq6aC34jKUSfhIpgnGhQjyu1XA3ZiGIY6x+
         JywBAnHKoekqFzJnbUeQbbYcAe65Fqpp1bR/pGOZItxnygZIHt3QNDe67zgle4plvSN5
         DCX8tKJYBsDlwjUERb2ZkVAyr1LwxIYvF5vgRmLKSINUFxaPOEWJOe1XxvEG0cws2G0+
         ytGQ==
X-Gm-Message-State: ACrzQf3UXZTprZTqCRxhXVaUKT5qrSQDjGS2zzwXKwpd2dt/ielReJ1V
        roabQdinlfyjVdGoqYK9zknroqGikhQ=
X-Google-Smtp-Source: AMsMyM6qgSpZKhOE+HrZHAp2sTf+//3IsfuB9TQ7IKy4Hu7JpZE5Hp3lEQrhI97MCwpEe6ncpBhFvQ==
X-Received: by 2002:a17:90b:2691:b0:20c:d655:c67d with SMTP id pl17-20020a17090b269100b0020cd655c67dmr53307076pjb.36.1666286806758;
        Thu, 20 Oct 2022 10:26:46 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/8] perf test: Improve perf record tests (v2)
Date:   Thu, 20 Oct 2022 10:26:35 -0700
Message-Id: <20221020172643.3458767-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset improves the perf record tests to check more cases so that it
can find problems early.  The motivation was a failure per-thread mmap with
multi-threaded targets which Adrian is working on the fix.

Changes in v2)
 * fix shellcheck issues
 * drop unsupported --per-thread and --threads combination
 * do not use initial delay (-D option); instead it runs the target
   and wait for it separately using the recent waiting.sh library
 * add Adrian's Reviewed-by tags

I added a custom test program and more combinations like system-wide and
command line workload (in per-process mode) testing with multi-threaded
recording mode.

Currently it succeeds every tests when running as root!

  $ sudo ./perf test -v 91
   91: perf record tests                                               :
  --- start ---
  test child forked, pid 108975
  Build a test program
  Basic --per-thread mode test
  Basic --per-thread mode test [Success]
  Register capture test
  Register capture test [Success]
  Basic --system-wide mode test
  Basic --system-wide mode test [Success]
  Basic target workload test
  Basic target workload test [Success]
  test child finished with 0
  ---- end ----
  perf record tests: Ok

You can find it in 'perf/record-test-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf test: Do not use instructions:u explicitly
  perf test: Fix shellcheck issues in the record test
  perf test: Use a test program in perf record tests
  perf test: Wait for a new thread when testing --per-thread record
  perf test: Add system-wide mode in perf record tests
  perf test: Add target workload test in perf record tests
  perf test: Test record with --threads option
  perf test: Do not set TEST_SKIP for record subtests

 tools/perf/tests/shell/record.sh | 180 +++++++++++++++++++++++++++----
 1 file changed, 158 insertions(+), 22 deletions(-)


base-commit: a3a365655a28f12f07eddf4f3fd596987b175e1d
-- 
2.38.0.135.g90850a2211-goog

