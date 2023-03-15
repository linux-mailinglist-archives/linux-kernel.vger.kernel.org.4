Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26956BBDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCOUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:33:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F75D8B9;
        Wed, 15 Mar 2023 13:33:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a2so21381369plm.4;
        Wed, 15 Mar 2023 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678912428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8JqHC7qwm53GybJV6K0SFbTeG4iS2ee+g+G7hhCZh4=;
        b=YmB5/24K1wXBvLkw+MOflFYKpdaL3KNeG68nEeZDG4vRStz9zxjftQpKyIvSNJv/v6
         ExcC6YaIsADw4O4g8ZS3dvsHojaV9npp42X4vRw9kh67CzgwWsSnVbobqQkWG5mt6eKr
         mvCgOP5EI4hvTqLgB8rFQzG0sK1wt+/vieaXkeMiaCa8s5linMBzZE880tcoeDUYaDs/
         2KlotuqZ2Ms6ShYGlKGn3HkWG9tFwPW9qR2d42j7z/DhCL8xzKBP3R5RcXvdPvtm/zMI
         TvL0U0yr4ogi2shTmbx56MfUN1lJIDN1mggfjokC8Vw/wvXkKJBtorZrcKHiDjZreuFX
         3A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678912428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8JqHC7qwm53GybJV6K0SFbTeG4iS2ee+g+G7hhCZh4=;
        b=DFjf/LaPegNejv5sVhC0nSYoVaHt4Jm6nIIDbYjq+SmzHayuoc9qE5hZnbDFrnEZTd
         3LOjo7taRMd3zSCnG2o67V10Uh0R2IB0F6SCRFG2qaTzVLi3juwzsaUNOkgjeyFxKdHW
         Dv/rsOjx0z/wIxp8xTH/kpScSOBkAH1AfhMX6ZmA8m4bSQTIKzA2yXNXvpNUpu/TjyDD
         Xn028Ioschf+UPuUY7+OGGsxsa7cy53m8SiZDbkHo+SZaI0EOYGJusdaFrTKnFdf5vvU
         VQ45W9X9P6OGOtK7RgymtJDfUYYRbwN0OHRqYcH5mSClVJKhRMkkA0okD4H74kbqBXcm
         WpXQ==
X-Gm-Message-State: AO0yUKVqcsHQ+ql17Gtuo/c7hfXTa1ksPAirt0BkloqtGSJvBI/2XxzB
        rCUdWYoyX9ZWJ+S+X+MPpbk=
X-Google-Smtp-Source: AK7set9dJL08JrZyKXPKBGbrQylWRsZPvIoEbfQqzxpf76AbJQ+XIdcJMA3n6RSB3FtyJKqMQWex/w==
X-Received: by 2002:a05:6a20:8b05:b0:d5:c0dc:6441 with SMTP id l5-20020a056a208b0500b000d5c0dc6441mr928240pzh.18.1678912427888;
        Wed, 15 Mar 2023 13:33:47 -0700 (PDT)
Received: from yoga ([202.131.132.11])
        by smtp.gmail.com with ESMTPSA id k2-20020aa792c2000000b0056bc5ad4862sm3934214pfa.28.2023.03.15.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:33:47 -0700 (PDT)
Date:   Thu, 16 Mar 2023 02:03:39 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, leo.yan@linaro.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anupnewsmail@gmail.com
Subject: [PATCH] perf: Fix indentation errors by removing extra spaces
Message-ID: <ZBIro7uDO/Mii3xF@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up tabstop related warning reported by checkpatch.pl script

WARNING: Statements should start on a tabstop

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/builtin-lock.c      |  2 +-
 tools/perf/builtin-trace.c     |  6 +++---
 tools/perf/jvmti/libjvmti.c    |  8 ++++----
 tools/perf/ui/browser.c        |  4 ++--
 tools/perf/ui/browsers/hists.c | 10 +++++-----
 tools/perf/util/symbol-elf.c   |  2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 054997edd98b..4a1d5a08c8d6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2094,7 +2094,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 			char buf[32];
 
 			if (strchr(tok, ':'))
-			    continue;
+				continue;
 
 			/* try :R and :W suffixes for rwlock, rwsem, ... */
 			scnprintf(buf, sizeof(buf), "%s:R", tok);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 610fb60b1c0d..155abfd07286 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1942,7 +1942,7 @@ static __maybe_unused bool trace__syscall_enabled(struct trace *trace, int id)
 				  trace->ev_qualifier_ids.nr, sizeof(int), intcmp) != NULL;
 
 	if (in_ev_qualifier)
-	       return !trace->not_ev_qualifier;
+		return !trace->not_ev_qualifier;
 
 	return trace->not_ev_qualifier;
 }
@@ -3363,10 +3363,10 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
 
 			if (is_pointer) {
-			       if (!candidate_is_pointer) {
+				if (!candidate_is_pointer) {
 					// The candidate just doesn't copies our pointer arg, might copy other pointers we want.
 					continue;
-			       }
+				}
 			} else {
 				if (candidate_is_pointer) {
 					// The candidate might copy a pointer we don't have, skip it.
diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index fcca275e5bf9..faf5925f7433 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -312,10 +312,10 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
 	free(line_tab);
 	while (line_file_names && (nr_lines > 0)) {
-	    if (line_file_names[nr_lines - 1]) {
-	        free(line_file_names[nr_lines - 1]);
-	    }
-	    nr_lines -= 1;
+		if (line_file_names[nr_lines - 1]) {
+			free(line_file_names[nr_lines - 1]);
+		}
+		nr_lines -= 1;
 	}
 	free(line_file_names);
 }
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 78fb01d6ad63..ba725ed5c86d 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -40,8 +40,8 @@ int ui_browser__set_color(struct ui_browser *browser, int color)
 void ui_browser__set_percent_color(struct ui_browser *browser,
 				   double percent, bool current)
 {
-	 int color = ui_browser__percent_color(browser, percent, current);
-	 ui_browser__set_color(browser, color);
+	int color = ui_browser__percent_color(browser, percent, current);
+	ui_browser__set_color(browser, color);
 }
 
 void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b72ee6822222..947f8023a140 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -402,7 +402,7 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 		return false;
 
 	if (ms == &he->ms)
-	       return he->has_children;
+		return he->has_children;
 
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
@@ -421,7 +421,7 @@ static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 		return false;
 
 	if (ms == &he->ms)
-	       return he->unfolded;
+		return he->unfolded;
 
 	return container_of(ms, struct callchain_list, ms)->unfolded;
 }
@@ -436,8 +436,8 @@ static char *hist_browser__selection_sym_name(struct hist_browser *browser, char
 		return NULL;
 
 	if (ms == &he->ms) {
-	       hist_entry__sym_snprintf(he, bf, size, 0);
-	       return bf + 4; // skip the level, e.g. '[k] '
+		hist_entry__sym_snprintf(he, bf, size, 0);
+		return bf + 4; // skip the level, e.g. '[k] '
 	}
 
 	callchain_entry = container_of(ms, struct callchain_list, ms);
@@ -3599,7 +3599,7 @@ static bool evlist__single_entry(struct evlist *evlist)
 	int nr_entries = evlist->core.nr_entries;
 
 	if (nr_entries == 1)
-	       return true;
+		return true;
 
 	if (nr_entries == 2) {
 		struct evsel *last = evlist__last(evlist);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 41882ae8452e..32bd70d7b712 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -304,7 +304,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	 * to it...
 	 */
 	if (!want_demangle(dso->kernel || kmodule))
-	    return demangled;
+		return demangled;
 
 	demangled = bfd_demangle(NULL, elf_name, demangle_flags);
 	if (demangled == NULL) {
-- 
2.34.1

