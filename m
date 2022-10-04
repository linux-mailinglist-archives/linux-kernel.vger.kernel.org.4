Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847165F4A05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJDUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJDUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:02:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252B6B17D;
        Tue,  4 Oct 2022 13:02:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f140so8780643pfa.1;
        Tue, 04 Oct 2022 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=2i0LEUdQcU0O58XSTK8jX7h6SIhzdD8FC2OFcWTsN74=;
        b=CtRST3LRPzU3/ZMRyhLqTaVsPz+zcNtyEu4Ii6wqIqM9NlxZd0xwpQHJ/UkI+76/aw
         07XrXSgQBb0K1X9VSQxvExVQprrgsWahn56oaSyN5y3PQCXl99I704a8rgj7eKJLXt2M
         O5GTrYNtyyuXfKxpn1rhayx6Bk6jnLcNO4ddV+EFVL3PMv+QHcGUKS4lhV3+3YkQE7LA
         mwqrHx7I7QRgIycNovGtaf/Gih6OAHBpgyIkoI7mxHQs0vX8D8YHRUMOpOcNLd9yQIss
         fFV2jJykXp4SG86ij/g1lci6WSEKdlH+6WrZ+Cf8+imPZ18XTHciO6GsHnZ7RpE9pVzX
         CNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=2i0LEUdQcU0O58XSTK8jX7h6SIhzdD8FC2OFcWTsN74=;
        b=v4VhZf2V42KCBwj1OxD5YrsQ1zmH2XfNTrxt18PzsKzDDhvNCMog1K3XvALNJvmBiX
         n17/3xiWSe+kKtCT+3kyzzxwsVFv/iUSj68zJDU7PwXsnEDVjzOXG0qtUf4XD4Tx4SQi
         wRYd7q4NZYbZJrVc//gu1wmAAC8YXoLtafVajL3EMnheO0/HAGOptlZnhbUfQIfFNiFo
         3nQelb5+AVs6ytkJHgzFDD4+stBFPZq+aGjBz/IaNBZpjIcTNjAG7Es/6WPdXKYpNOQg
         ocpHM2i2KbLetDORQOv6hIjhfh6mzL4F/HveV0OFrpwmXaPBOjVDNGF7SAZMkjYi4Qsw
         vD3Q==
X-Gm-Message-State: ACrzQf1VwnM9YFnP1msw+HYxHDo5hdoL74Zp0zO0agRrQClxjUlq0CsS
        llF1P6bo9a05jKGpBth8B80=
X-Google-Smtp-Source: AMsMyM4rhLYHx0x4fdgfnOQiyvQVraRm0VJy9e16VZXBkozauNp5pKYPnKkBIP0JR6t/nswtCEkwhw==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id p127-20020a622985000000b0054477d4f43bmr29410347pfp.9.1664913734567;
        Tue, 04 Oct 2022 13:02:14 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:3db9:2804:1207:4f07])
        by smtp.gmail.com with ESMTPSA id x187-20020a6231c4000000b00561e8bbfa3dsm974862pfx.98.2022.10.04.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 13:02:14 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf mem: Fix -C option behavior for perf mem record
Date:   Tue,  4 Oct 2022 13:02:11 -0700
Message-Id: <20221004200211.1444521-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

The -C/--cpu option was maily for report but it also affected record as
it ate the option.  So users needed to use "--" after perf mem record to
pass the info to the perf record properly.

Check if this option is set for record, and pass it to the actual perf
record.

Before)
  $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
  ...
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
  ...

After)
  $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
  ...
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7

Cc: Leo Yan <leo.yan@linaro.org>
Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9e435fd23503..02e7a5dbeb00 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -97,6 +97,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	else
 		rec_argc = argc + 9 * perf_pmu__hybrid_pmu_num();
 
+	if (mem->cpu_list)
+		rec_argc += 2;
+
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -1;
@@ -158,6 +161,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (all_kernel)
 		rec_argv[i++] = "--all-kernel";
 
+	if (mem->cpu_list) {
+		rec_argv[i++] = "-C";
+		rec_argv[i++] = mem->cpu_list;
+	}
+
 	for (j = 0; j < argc; j++, i++)
 		rec_argv[i] = argv[j];
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

