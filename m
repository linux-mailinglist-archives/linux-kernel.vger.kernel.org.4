Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C5749ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjGFORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:17:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B112A;
        Thu,  6 Jul 2023 07:17:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992dcae74e0so93768866b.3;
        Thu, 06 Jul 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688653055; x=1691245055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFf3EXInF/vw5mSDkGlm1RQPsDdmQJ8ogfM9wRRcu68=;
        b=HmvPfKDxPhT7mqDTOq0bYJevpex30h3Nups50JviKXsXX9OOh3F0c0IBfRfoJ26qfm
         yFdfsVND+HlqqAbz7KqDznyWW3o2rNmdFVX7I76bvkk1TGahvUuxukTvoFOjNVhrJhQk
         qwOhDeppaXsNNJWgpAjJWJup/jfb9052XrQPJrAPR0fcVTrHsM0AJZ0b536YbBlyq/2G
         a359e0ZaRrZz1ugx6UFybE8DGomTe+wsMjRPSKsJiAL2PMMSH3/+jxBuznOLr5MsMapz
         dhKk51p59x+FLquQx6tT5Ab0Y3Hrhf6nmCpibcaSDtY/fJmJWwxgC8ls+/R6pogdtPVG
         GveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653055; x=1691245055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFf3EXInF/vw5mSDkGlm1RQPsDdmQJ8ogfM9wRRcu68=;
        b=F9vy59pmGYl2ogMFuiivmNLFx/WyTUU/yn0szWNlQlNTEfPIXdLm0mTzgq/XXGacH/
         Yyd4TXiZKW0sgbEQvCiENESmk2nxKxkAgg+/4iR8cSQ2MBtGhvpqopGqwwIKopMaAWDI
         tMlHABm00roFtgqGh+YkLNFXCdpqyQkkTN/fYrWCa7Z56PHFX9rYKdf4Z7SAfHoBlOP5
         9ustY1n7cLrHPACIYSK8KPflWl35UAg2ZNiL+KkSeRCL2SEq9V+8ArcF1e/eSb4NP+eA
         uAhM1bzC7bBLDAI5GcU3LhaE6Rb8g362FDtbWMfVlUJwEVheq82FDowSCaTLOUMZtSp8
         1W7w==
X-Gm-Message-State: ABy/qLYuMdA+9x48gC+bpRkJrg7iJKePILg2E1QlQL+wXI2YyJPIU7sD
        BEoUWrfn0XENJVCSOgd+FpI=
X-Google-Smtp-Source: APBJJlH3Fj7e5qYXpje+jUyv6IsICJPf10+3Je55O2fvk4vxVCN2reICwTZwT9lsrVfY5XHCGBUxZw==
X-Received: by 2002:a17:906:1013:b0:961:a67:28d with SMTP id 19-20020a170906101300b009610a67028dmr1602283ejm.22.1688653055169;
        Thu, 06 Jul 2023 07:17:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id kj4-20020a170907764400b009929d998ab6sm872432ejc.131.2023.07.06.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:17:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] perf/x86: Use local64_try_cmpxchg
Date:   Thu,  6 Jul 2023 16:16:48 +0200
Message-ID: <20230706141720.2672-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc. "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/events/amd/ibs.c      |  4 ++--
 arch/x86/events/core.c         | 10 ++++------
 arch/x86/events/intel/cstate.c | 10 ++++------
 arch/x86/events/msr.c          |  8 +++-----
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 371014802191..b54db2138c16 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -156,8 +156,8 @@ perf_event_try_update(struct perf_event *event, u64 new_raw_count, int width)
 	 * count to the generic event atomically:
 	 */
 	prev_raw_count = local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					new_raw_count) != prev_raw_count)
+	if (!local64_try_cmpxchg(&hwc->prev_count,
+				 &prev_raw_count, new_raw_count))
 		return 0;
 
 	/*
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9d248703cbdd..23c96420dea1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -129,13 +129,11 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 * exchange a new raw count - then add that new-prev delta
 	 * count to the generic event atomically:
 	 */
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 835862c548cc..97035db68df2 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -365,13 +365,11 @@ static void cstate_pmu_event_update(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 prev_raw_count, new_raw_count;
 
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = cstate_pmu_read_counter(event);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		new_raw_count = cstate_pmu_read_counter(event);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	local64_add(new_raw_count - prev_raw_count, &event->count);
 }
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 0feaaa571303..61c59e0627d4 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -244,12 +244,10 @@ static void msr_event_update(struct perf_event *event)
 	s64 delta;
 
 	/* Careful, an NMI might modify the previous event value: */
-again:
 	prev = local64_read(&event->hw.prev_count);
-	now = msr_read_counter(event);
-
-	if (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev)
-		goto again;
+	do {
+		now = msr_read_counter(event);
+	} while (!local64_try_cmpxchg(&event->hw.prev_count, &prev, now));
 
 	delta = now - prev;
 	if (unlikely(event->hw.event_base == MSR_SMI_COUNT)) {
-- 
2.41.0

