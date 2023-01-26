Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6967D7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAZVga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjAZVgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:36:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371FA74A7F;
        Thu, 26 Jan 2023 13:36:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be8so3076608plb.7;
        Thu, 26 Jan 2023 13:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jUJI1fdtuav4Cmxfz+SpScnfmvuJBA2rMIfNnsJ9wTg=;
        b=faNLmwoGlghGB/uwCA7ZXvD7dxUT4E53sDMJuugItaNjKqfGxziBpusCjGhdu5vo/V
         k4FLy+OSddKvuhjIIMRzbtZ9CWH54g5HPQ4ezpK4XrBBRKzmkwru2PDOD1wgc0dLdtO+
         QUUnkuJzYYcTZKhiY2826e+lKZbyamSK+lfD2/bMr9bjtq/lc6D29SItbrhTTt4iyDti
         DLLeMq2SwYV8PkzVC0HLLPUGPqMh3u5a/8UdYWwQYCEwx8el9j06USj8ldFStl7Ynz9z
         448mm16GWdlZRGueL2umT5EpQg8qfPyibzy/gSTLUs9AywF2Pyak9M641k1WWloxS7hq
         YuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUJI1fdtuav4Cmxfz+SpScnfmvuJBA2rMIfNnsJ9wTg=;
        b=YFvB5ddl/9AqIZXTg+ilsMWN9CHrmS2GQJGh4RDdIvvy+F4/o0K88+3IgEaSEjZbrT
         x/Esdd7mb9e4pOhundnaLQ5UsNJ507Bw9qAHjdcrXhWIzkNPBWkriDrB1z4m7wDubS8G
         x84wfXpyg1HhfCOskwIFNRQQY0Wef2Hu4FKvFT0eoJDkGbY2ir6NDcM1MBkARRojqIPO
         gbeWBQC4RsIwloJYuIJQ/C45q7FjKKRQpfnsWz1phlxvoyNSW9tueQdezjm9JpmG/1Ul
         MqftAaBi9BZ241JtDsa5LW8XF1RFPRIX7pWxUrCROMJ/kJEJTke7CedkBuqFqwHc4eyW
         g7Nw==
X-Gm-Message-State: AO0yUKUgB1ncVvCTUOKoS1RXgrIHZMLBAAtbXueVmUjapaniebBDc2Kl
        CxJi7hOZ8As0XiUB5qSdyFA=
X-Google-Smtp-Source: AK7set+KmAOan9mCekLClAkc8E/YBsQCkMbAbS9uvdM1BPM9sV9Fsvhwo5HGUWUiue2IDQVEE5Rtmg==
X-Received: by 2002:a17:902:d4c3:b0:196:349f:4df3 with SMTP id o3-20020a170902d4c300b00196349f4df3mr7211943plg.50.1674768973506;
        Thu, 26 Jan 2023 13:36:13 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00172fad607b3sm1408075plg.207.2023.01.26.13.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:36:12 -0800 (PST)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH v2] perf script: Add 'cgroup' field for output
Date:   Thu, 26 Jan 2023 13:36:10 -0800
Message-Id: <20230126213610.3381147-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no field for the cgroup, let's add one.  To do that, users need to
specify --all-cgroup option for perf record to capture the cgroup info.

  $ perf record --all-cgroups -- true

  $ perf script -F comm,pid,cgroup
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...

If it's recorded without the --all-cgroups, it'd complain.

  $ perf script -F comm,pid,cgroup
  Samples for 'cycles:u' event do not have CGROUP attribute set. Cannot print 'cgroup' field.
  Hint: run 'perf record --all-cgroups ...'

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  5 ++++-
 tools/perf/builtin-script.c              | 22 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 8d77182fbf31..a2ebadc9d948 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -134,7 +134,7 @@ OPTIONS
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu.
+        machine_pid, vcpu, cgroup.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
@@ -231,6 +231,9 @@ OPTIONS
 	perf inject to insert a perf.data file recorded inside a virtual machine into
 	a perf.data file recorded on the host at the same time.
 
+	The cgroup fields requires sample having the cgroup id which is saved
+	when "--all-cgroups" option is passed to 'perf record'.
+
 	Finally, a user may not set fields to none for all event types.
 	i.e., -F "" is not allowed.
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..731821fd0d3e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -59,6 +59,7 @@
 #include "util/dlfilter.h"
 #include "util/record.h"
 #include "util/util.h"
+#include "util/cgroup.h"
 #include "perf.h"
 
 #include <linux/ctype.h>
@@ -130,6 +131,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
 	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
+	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 };
 
 struct perf_script {
@@ -200,6 +202,7 @@ struct output_option {
 	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
 	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
 	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
+	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
 };
 
 enum {
@@ -542,6 +545,12 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_INS_LAT))
 		return -EINVAL;
 
+	if (PRINT_FIELD(CGROUP) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_CGROUP, "CGROUP", PERF_OUTPUT_CGROUP)) {
+		pr_err("Hint: run 'perf record --all-cgroups ...'\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2220,6 +2229,17 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(CODE_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
 
+	if (PRINT_FIELD(CGROUP)) {
+		const char *cgrp_name;
+		struct cgroup *cgrp = cgroup__find(machine->env,
+						   sample->cgroup);
+		if (cgrp != NULL)
+			cgrp_name = cgrp->name;
+		else
+			cgrp_name = "unknown";
+		fprintf(fp, " %s", cgrp_name);
+	}
+
 	perf_sample__fprintf_ipc(sample, attr, fp);
 
 	fprintf(fp, "\n");
@@ -3856,7 +3876,7 @@ int cmd_script(int argc, const char **argv)
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
-		     "code_page_size,ins_lat",
+		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.39.1.456.gfc5497dd1b-goog

