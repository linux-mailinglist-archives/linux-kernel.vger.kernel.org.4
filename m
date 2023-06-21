Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7509739059
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFUTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:45:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFB1989;
        Wed, 21 Jun 2023 12:45:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668704a5b5bso3832656b3a.0;
        Wed, 21 Jun 2023 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376716; x=1689968716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4I/DeYAvJKL2tY/fK091H/iltwlg6WcLtPnIUo8ZacE=;
        b=jzMG6b2UkbNfHd1BFVwT6bgFtKIc/iOLTIjeja+SpT4LBEe2uFmQNUWTrj42yzIS7R
         GiF9uck2YJblOcusZCslOsmL2GXCJiTynCGfcjDiiA35bqCbI1XDJPPFGDtwqmtw2tiV
         GPyo3gtxdcXjWf4l2Rz3cDskyUIF0SPta4ZzvvSR01Go0w3v+ERlFsc1SaBQ0AohtUmS
         iCGfNC1PCqDsUIFRKi9gAqTqDJjsYdLHIBXehvAFPHjioC5wQ/uP/2o0Alg1wsrT28GF
         EKcvshBuQorbPymsTO5+eBHCN0NVktV/s5O6D9QA4g3OwnQ8P6oTwUngwt/dYfbnyvLf
         ve+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376716; x=1689968716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I/DeYAvJKL2tY/fK091H/iltwlg6WcLtPnIUo8ZacE=;
        b=R9eHDaKiXFoMPeaK23L3d1NKAnqJJpdcIOE5qbOQs6gp7eK2xbFyKghCYgqEGe6GzE
         5M3IpT7YnDRU1KiMfubGMEofwl+uGWexxzubtOWijjCp+bgbHAe6PI3bMRZqi4obwpmH
         cv6Wiy1SvNOaWFM19mDuIiN3Lmds24EAs6piGzUv8rv9EqKcZ6JNDTHFdGvH0JsHAzxc
         TMX//3JxJlcWtLle+21FwNGZjJBFRNJeViMxFssdclvMyBeG41MykU1MzrXSc1Awgk+2
         2HzBA5HsSNlJNke6ez0hWsnPR4Ld09CisimQdFTB1UnVCyhj4Cg2bSiAkkXJpReMcX3P
         2tMw==
X-Gm-Message-State: AC+VfDysCsIGIo1gnGPmSEqJaqrabs89eLM9wYb77VgqXsVaaP5aS/8n
        e54k4iUVXDAKFCJxypVvCdY=
X-Google-Smtp-Source: ACHHUZ5sLnOHTFrJfTOIFLkZtDxkM6DjmZPAKEOG41d2PxbrePFhaphUFbN1NOgmLdKR48CmAo0l3Q==
X-Received: by 2002:a05:6a00:14c1:b0:668:8493:2552 with SMTP id w1-20020a056a0014c100b0066884932552mr10230277pfu.18.1687376716226;
        Wed, 21 Jun 2023 12:45:16 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b006666699be98sm3267970pfo.34.2023.06.21.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:45:15 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:15:09 +0530
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
Subject: [PATCH 7/9] scripts: python: implement get or create frame function
Message-ID: <4d0ac80521ebd44322a360ac331ce2443a1f0f26.1687375189.git.anupnewsmail@gmail.com>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687375189.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CATEGORIES list and the USER_CATEGORY_INDEX and
KERNEL_CATEGORY_INDEX constants has been introduced.

The get_or_create_frame function is responsible for retrieving or
creating a frame based on the provided frameString. If the frame
corresponding to the frameString is found in the frameMap, it is
returned. Otherwise, a new frame is created by appending relevant
information to the frameTable's 'data' array and adding the
frameString to the stringTable.

The index of the newly created frame is added to the frameMap.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 30fc542cfdeb..866751e5d1ce 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -15,6 +15,13 @@ def isPerfScriptFormat(profile):
     firstLine = profile[:profile.index('\n')]
     return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
 
+CATEGORIES = [
+{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
+{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
+]
+USER_CATEGORY_INDEX = 0
+KERNEL_CATEGORY_INDEX = 1
+
 def convertPerfScriptProfile(profile):
     def _createtread(name, pid, tid):
         markers = {
@@ -70,6 +77,37 @@ def convertPerfScriptProfile(profile):
                 stackMap[key] = stack
             return stack
 
+        frameMap = dict()
+        def get_or_create_frame(frameString):
+            frame = frameMap.get(frameString)
+            if frame is None:
+                frame = len(frameTable['data'])
+                location = len(stringTable)
+                stringTable.append(frameString)
+            
+                category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 or frameString.find('/vmlinux') != -1 or frameString.endswith('.ko)') else USER_CATEGORY_INDEX
+                implementation = None
+                optimizations = None
+                line = None
+                relevantForJS = False
+                subcategory = None
+                innerWindowID = 0
+                column = None
+
+                frameTable['data'].append([
+                    location,
+                    relevantForJS,
+                    innerWindowID,
+                    implementation,
+                    optimizations,
+                    line,
+                    column,
+                    category,
+                    subcategory,
+                ])
+                frameMap[frameString] = frame
+            return frame
+
         def addSample(threadName, stackArray, time):
             nonlocal name
             if name != threadName:
-- 
2.34.1

