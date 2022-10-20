Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAB6066FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJTR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJTR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262841A6506;
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so155373pfp.13;
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QCC/hdBkmsmNSi05vln5MGpdORWqDfmRTbH31VLiIs=;
        b=TgPCmmevrMWHslwgpZzGN+0wgNFE0L7vmF6++6i6B9O49LJAdSoJRq2D1L0D+TajHL
         nVqiaH9YmHLpiwfRrSkFSy6/d0GAtzWFBcMZ5TNpVHVJhlVeXmq9RKLWjbL96ieJirfm
         ItpL82zGk7gQnC2E68AkYoxM691rbbR5kCPgD4YAfEQUJVwG6s7dkWcknYUZ1fL4/L0I
         0Q5IDDR0pdtlbhFJ6qTNM3h/h/fVddJlHsmP4QlLNvu2AMQHbsSuNMjTAbI6TsGAdadK
         ZYI1uzumhb1HWvhr4i4iMhMbdmLqRdMZRbobfFDRWTNpYhEpBxksMnv28F6bVX4tIX20
         S+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QCC/hdBkmsmNSi05vln5MGpdORWqDfmRTbH31VLiIs=;
        b=m5/gtlWla5iwsvnwHqCQAQdnFmTOBbhwX4WBhiVecwiKY9RSh2IiqW3bgVoO9fS1f2
         KXhfGnClQ7nzv5c82GhsA+weQlcOHAFk/YIG2ybA2HbADjyfU+KUN8kWIf+P70uqvKRq
         y5PmSAnAC3nmeidCKh73hRvGPQw+f51eMX/QEvkmnKbsiJuGM0xDyb/IJjjytwvpwEfI
         vzT/d66VwNF7QMEDDClauMOxRAznhlnfUypHTWVz6CrLfdXJAbzFv9+uX1K17Di9e+6/
         6LIrhZJ6fOwDeaZyk1mgozfYMnpNTay6jNim+Jlh+XlCtAbHo4QuJCOryQbg6ZEn90BC
         c30g==
X-Gm-Message-State: ACrzQf3NZyaWGMMt5oxRyNiUuj7CVhOABZOcDgNzbh2GGn/m0pHDOizn
        /WCHiimTtz4o3gFXIjwxYwM=
X-Google-Smtp-Source: AMsMyM4iikqB70voM419n4XPBuvwHEY2AEQWgrNLV8rf3t50M9zCUUAF9i08gnEY6bjzbOMCMQ9fGQ==
X-Received: by 2002:a62:ce8b:0:b0:562:9e5c:bb5 with SMTP id y133-20020a62ce8b000000b005629e5c0bb5mr15168542pfg.45.1666286811217;
        Thu, 20 Oct 2022 10:26:51 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:50 -0700 (PDT)
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
Subject: [PATCH 4/8] perf test: Wait for a new thread when testing --per-thread record
Date:   Thu, 20 Oct 2022 10:26:39 -0700
Message-Id: <20221020172643.3458767-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221020172643.3458767-1-namhyung@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
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

Just running the target program is not enough to test multi-thread
target because it'd be racy perf vs target startup.  I used the
initial delay but it cannot guarantee for perf to see the thread.

Instead, use wait_for_threads helper from shell/lib/waiting.sh to make
sure it starts the sibling thread first.  Then perf record can use -p
option to profile the target process.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 952981481239..d1640d1daf2e 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -4,6 +4,9 @@
 
 set -e
 
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/waiting.sh
+
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
@@ -96,6 +99,30 @@ test_per_thread() {
     err=1
     return
   fi
+
+  # run the test program in background (forever)
+  ${testprog} 1 &
+  TESTPID=$!
+
+  rm -f "${perfdata}"
+
+  wait_for_threads ${TESTPID} 2
+  perf record -p "${TESTPID}" --per-thread -o "${perfdata}" sleep 1 2> /dev/null
+  kill ${TESTPID}
+
+  if [ ! -e "${perfdata}" ]
+  then
+    echo "Per-thread record [Failed record -p]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Per-thread record [Failed -p missing output]"
+    err=1
+    return
+  fi
+
   echo "Basic --per-thread mode test [Success]"
 }
 
-- 
2.38.0.135.g90850a2211-goog

