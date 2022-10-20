Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096B6066FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJTR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJTR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:26:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7171A1B01;
        Thu, 20 Oct 2022 10:26:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k9so20474769pll.11;
        Thu, 20 Oct 2022 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH0g+SRm+dkCNaIciH1RdMRbmhrFmdajvY8xociCPdQ=;
        b=L4AhiqLscNtbMUNvjtXn237HAUbTRwwvcT2SyM7nA64Vng9WA6lcrXaMqGt4+MITFP
         fqx9GLLV/YN8HfZWeVaVTavPxjd4UaJrhkdPRd97yrJY0D1n0meMhmMlP6WRuluflecO
         EVM1LqI1Ya/EqcECbaHAt8TRvlJ+zcpFEWxd8U7f5apMy15Xth17x6EFh2MsCUV9aXNL
         rQhWOmxdUm9ZPKrmLnNXioYJo/6o3ZGzjqzitL4NMpKLWXUs48/i1KaP/VMbbwKuEOjF
         p91D9cqAHhXQPC/lSjU+AWA7S+YAfO9KG6QLUxri5eKjFAClqliOI9rOijGtlFlRopzr
         cdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PH0g+SRm+dkCNaIciH1RdMRbmhrFmdajvY8xociCPdQ=;
        b=tDUklj8JRf3scEm+bDrXFkPb4LMNX5vVhUN6YuNpKrd0kZ3vJSPpCrviHMguwEg3WO
         BbIIU4BsBmmBuqtodyd2yeNYI9arWWuhyaiZmmHltZik8TwUXczTiZDmH16+No5yk0XZ
         ZC2khdlmdp2GFSB/+BYUIkythUgnWqJfAR/HUjU97CvzQEfEBrgdYR9jxCqz7q8I2Np4
         vR+qcftXv9yplI6TPILKmukiHZiVcZqxZlt4Q48pKg7MclN9b5VACIN4NjSEPdhOGmg+
         HklXKCZOYjLcUi6VN66/4HSS4BrGBc1fDwiaZbmpKZhZkHZhfNUiftsk8D0ckbJrQI4X
         92SA==
X-Gm-Message-State: ACrzQf04RoraxGY4qIdzM/jp2SIs04+EvHIjyF/lT2nQR1/zaLmJr+ZL
        tKSJDwrETjeBwJLVvjEARRA=
X-Google-Smtp-Source: AMsMyM4l7pGyusHbrGGaOew0gC/CQDiLaQSVzhF6DMOXYWcO5BAsp7Attt80gnRgKrnrgHU8jT84aQ==
X-Received: by 2002:a17:902:720a:b0:181:150c:fcc4 with SMTP id ba10-20020a170902720a00b00181150cfcc4mr15153685plb.109.1666286810012;
        Thu, 20 Oct 2022 10:26:50 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:49 -0700 (PDT)
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
Subject: [PATCH 3/8] perf test: Use a test program in perf record tests
Date:   Thu, 20 Oct 2022 10:26:38 -0700
Message-Id: <20221020172643.3458767-4-namhyung@kernel.org>
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

If the system has cc it could build a test program with two threads
and then use it for more detailed testing.  Also it accepts an option
to run a thread forever to ensure multi-thread runs.

If cc is not found, it falls back to use the default value 'true'.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 64 ++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 464071462809..952981481239 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -6,10 +6,17 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
+testsym="test_loop"
 
 cleanup() {
   rm -f "${perfdata}"
   rm -f "${perfdata}".old
+
+  if [ "${testprog}" != "true" ]; then
+    rm -f "${testprog}"
+  fi
+
   trap - EXIT TERM INT
 }
 
@@ -19,9 +26,56 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+build_test_program() {
+  if ! [ -x "$(command -v cc)" ]; then
+    # No CC found. Fall back to 'true'
+    testprog=true
+    testsym=true
+    return
+  fi
+
+  echo "Build a test program"
+  cat <<EOF | cc -o ${testprog} -xc - -pthread
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+
+void test_loop(void) {
+  volatile int count = 1000000;
+
+  while (count--)
+    continue;
+}
+
+void *thfunc(void *arg) {
+  int forever = *(int *)arg;
+
+  do {
+    test_loop();
+  } while (forever);
+
+  return NULL;
+}
+
+int main(int argc, char *argv[]) {
+  pthread_t th;
+  int forever = 0;
+
+  if (argc > 1)
+    forever = atoi(argv[1]);
+
+  pthread_create(&th, NULL, thfunc, &forever);
+  test_loop();
+  pthread_join(th, NULL);
+
+  return 0;
+}
+EOF
+}
+
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf record -o /dev/null --quiet true 2> /dev/null
+  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Skipped event not supported]"
     if [ $err -ne 1 ]
@@ -30,13 +84,13 @@ test_per_thread() {
     fi
     return
   fi
-  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
+  if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Failed record]"
     err=1
     return
   fi
-  if ! perf report -i "${perfdata}" -q | grep -q true
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
   then
     echo "Per-thread record [Failed missing output]"
     err=1
@@ -62,7 +116,7 @@ test_register_capture() {
     return
   fi
   if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
-    -c 1000 --per-thread true 2> /dev/null \
+    -c 1000 --per-thread ${testprog} 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
     | grep -q "DI:"
   then
@@ -73,6 +127,8 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+build_test_program
+
 test_per_thread
 test_register_capture
 
-- 
2.38.0.135.g90850a2211-goog

