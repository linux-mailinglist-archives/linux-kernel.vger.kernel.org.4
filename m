Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6B74E1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGJXJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGJXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:09:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44CF9;
        Mon, 10 Jul 2023 16:09:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a38953c928so3827475b6e.1;
        Mon, 10 Jul 2023 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030553; x=1691622553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+MMk4Cs0oW3UJzQ6IJCCiJc/ywnbyZxE3/wgqbegso=;
        b=cB4U7RfmNBVjkzzjb+1bfAJYUV15wXNhZIG09IYSaeBolI6Fj1Hx4z6M0Y5C6DU3gl
         fu2zWxli88a2GBK36f3uBwreDdTZSgbCVbg/1+ovmmmBYgXDpB+reTwGik9NWmDo/tI8
         OV8NIkWHQdt1B9Fprg6Zr7wnNET5OLVBRLblUwonUk6WBwv6VNCyyt1ZdKYO6knyBqoE
         VFItMhMt60Pgh3Vcvpe3Qwrde2S18IW6ww0LrI0OVPRkYCHphhearXBQ4pFmYoxekGrr
         +BeKGyap7AyX+JX2DBOPstz2lJHmicSSkS+VPcO/Fd65YuU6tRlM80Y2qBDZzmscwpyg
         lrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030553; x=1691622553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+MMk4Cs0oW3UJzQ6IJCCiJc/ywnbyZxE3/wgqbegso=;
        b=THwO9kye7DLB7ykPRDWl633nDQ2SRjYbg+Ez+Vf5Pds2lc6+tPAwrnGyrlASpZEMup
         5pTt1HF4RWyoA/GdisjPPIk0FdBeYFmvnu4/GHEGmSQvaPbzeTVKu74sp1qbpKIgnpUd
         dqtNuz0w+NqSUbfbqDDksN5SPdd157ne5BOGnzesXcwuz001Nfnz/Fd0PV5eeroieVJC
         RimTNMbm43KQiEdQZcRi+o36AErhHcHnTMSwzt8oDalSvpA3hjAJETm5g9istZDLkwLm
         PsHfsR2GgXYt1syRXrOpizqPwhIGBfO/w6bJ9XSbRKsD8GbKm6CY/6sAWFksWj3VXUUu
         YYeQ==
X-Gm-Message-State: ABy/qLblgjkcomCud3oZflwWURqYLyibo5K81pMA3TTzv8wUR9yBnu6X
        gbmt/ibtk4uWt5KqSOqtZ6o=
X-Google-Smtp-Source: APBJJlHHaBsPSv7VGng3Q30kxCxCGK4lWOaBLxXha5lDvJ29ByAhHYAgmuQj7yqAtzhpyMNn/HJIbA==
X-Received: by 2002:a05:6358:7e06:b0:134:d026:42d2 with SMTP id o6-20020a0563587e0600b00134d02642d2mr9576902rwm.24.1689030553073;
        Mon, 10 Jul 2023 16:09:13 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id b125-20020a633483000000b0054fd46531a1sm236429pga.5.2023.07.10.16.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:09:12 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:39:04 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] scripts: python: Add initial script file with imports
Message-ID: <5d3727bacffa331cd81a059fc3122cfb3f43dabd.1689024635.git.anupnewsmail@gmail.com>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the necessary modules, including the Perf-Trace-Util
library, and defines the required functions and variables.
It leverages the perf_trace_context and Core modules for
tracing and processing events. Also added usage information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
new file mode 100644
index 000000000000..5b342641925c
--- /dev/null
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -0,0 +1,28 @@
+# firefox-gecko-converter.py - Convert perf record output to Firefox's gecko profile format
+# SPDX-License-Identifier: GPL-2.0
+#
+# The script converts perf.data to Gecko Profile Format,
+# which can be read by https://profiler.firefox.com/.
+#
+# Usage:
+#
+#     perf record -a -g -F 99 sleep 60
+#     perf script firefox-gecko-converter.py > output.json
+
+import os
+import sys
+import json
+from functools import reduce
+
+# Add the Perf-Trace-Util library to the Python path
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+def trace_end():
+	pass
+
+def process_event(param_dict):
+	pass
-- 
2.34.1

