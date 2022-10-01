Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCA5F1A2A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJAGHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJAGHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:07:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C612DE8E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 189-20020a2516c6000000b006bbbcc3dd9bso5638704ybw.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=bfTcslBORHmMqSekKi2gjWfsm3Z8f0+vP6m/Q+2HzGQe0VLdY1agwgTIFb1BK5LmgK
         ZcGyQwGiyShODzDbGFrOktj28ZZf0VPjzN5EaEhvVGHhZpqaLsfJpvvcEDJZ1TA1aZLp
         DOSlhbBPhJd+gQ/lhcqA2cu9zdvPAwv68lKP8e6TB/Q+rB7fQk6WJ5xRrILQTvYWeNJ3
         +zZ8Suj+c9orXWMB/DpXceODpvg4iFlVNTRscm9ng3FFINYhb8LmGSnvierRNAoDuWo8
         h1w61zqyiutAuejU0AuDXURI80P7cvNldeUde2svNOP+xL4s5iiPQ8PhnMNJqJKQWyUn
         0+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=czWR7bH4LWjU0kpEXuCOxKjJOByOcqexLi7+pXDDQc0hu3cXOocyOEENrR5qKVSCzV
         rsu9BLBUFhbBL4eiRYva8T8pZxBto1IIJJhdGI/9FZhNP8ZcIyqMb+bouezhz9l4BHwX
         BsWdiW/UIcdahpaMaro0APnYjY/SBPrsJGnvdWuu31e717j9OUPUiWJ8n0oCboKRDCZ2
         KenBTPdnMRAAXN1lpFnNIOBxFalu/34jTp75Vr0Bw7rIfqUqfGokq7nPHd8u0DO1Y78g
         UKHaQ8Jf6nro/Va0eXR4eDtEwtZYKZ91dv1GWT4hFBzamGa/D75/M0nIl/bcOZ21l68u
         uyvw==
X-Gm-Message-State: ACrzQf3DXJucyveLYJ9DH8ojBiSio43PLXHuCFHzMh1C/qm4+G2lqoPP
        0G5XShOakbhKMDwCVBTqooBq5ge+W1me
X-Google-Smtp-Source: AMsMyM5soebaKlJtIPn5kSd66jsXA3m9JqT7Is4FdPDHTkMZfzu3LURGvVZwX9IMAnGMFuPYpYAG4JDRzstt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:9e51:0:b0:354:8aab:84ac with SMTP id
 n17-20020a819e51000000b003548aab84acmr11331117ywj.241.1664604426420; Fri, 30
 Sep 2022 23:07:06 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:23 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-10-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 09/22] perf vendor events: Update elkhartlake cpuids
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index bc873a1e84e1..6c8188404db8 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,7 +5,7 @@ GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
-GenuineIntel-6-96,v1.03,elkhartlake,core
+GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-- 
2.38.0.rc1.362.ged0d419d3c-goog

