Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361FD739051
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjFUToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFUToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:44:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B01735;
        Wed, 21 Jun 2023 12:43:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25edb50c3acso3606459a91.1;
        Wed, 21 Jun 2023 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376639; x=1689968639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIku/vKknpxMbgecYJtwrcoNOyOjrqW+/Ub58y9LPOY=;
        b=MDXMbwHs8SucUzVGA66AedfSlwZGbOqK4Cu9DoOxAiLj6K9y2xTdCTTkpnU5VEcjFw
         KfNU58CV+ulE0B89+TW7PQUCNrL3xBXDyLO8OgJW9atW/glff6+ARyo/Yt5jnjLOJ+PO
         xJixT3BngqBE5gOf/dsu+dwmypmCS9YUVVRnoN7i/mWON95jbPnTDLGU5zIc+YumeTQH
         s4iAsYKrVNFuwei51KmqN81hOlQBpySFbxQ0Fu2zquvGCdoIGiWcghhxtXmHpGFpwesT
         /K+sF3RgJ2k43wnwr42tOchoOMjNeLEaD75ItWd6AxWtbczUXh4ZIe9OasYbY0nkD3ZT
         ZWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376639; x=1689968639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIku/vKknpxMbgecYJtwrcoNOyOjrqW+/Ub58y9LPOY=;
        b=YGD7zOwxYVts+UfxXebgvgWuJGiOA9ebbJRzGy4PLSgkLgMaLd3rSU69PTCbxgtvgx
         +ywmQm1IJ39I5yO3J8TZWp3VfWxNvbG+QTBShFO6O+uBJGmFOH/RxbG9/6mZPlSZ94U5
         TeIxHVRXSlCMJOLqsqwm79KBHnBHpOZ66s7LglXio96sEm2RJByaZ9O5PqGyYZrl4CtQ
         DX/CAEmJe8aAA/rgFwqQpfdQGM61twrorhAZ8BkvLgKF6AlVTzUjFsANpSVLW2s/kwAG
         vLNwLsKYGhJOlIGzCJN500XXjlAzFb4utWaBf3J+E7Uelf4frss7uElvPHSdexQIPcFa
         1SZg==
X-Gm-Message-State: AC+VfDxPfW6BGyiNGHN0yuGuxTnDnkqG+ffhdaR44F3fMkHCNkGqcfRi
        AYIrXDEQzt8gefgrZ+9kbcA=
X-Google-Smtp-Source: ACHHUZ5+vKJCMkCp0bbH1rb9wWxJ3NZVNadztHCnKN0qIzFBRRtufhorUidXiEOh2qiJa79OXgDkSg==
X-Received: by 2002:a17:90b:a46:b0:25c:2a5d:e06b with SMTP id gw6-20020a17090b0a4600b0025c2a5de06bmr16639436pjb.2.1687376638905;
        Wed, 21 Jun 2023 12:43:58 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b0024749e7321bsm3561426pjw.6.2023.06.21.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:43:58 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:13:50 +0530
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
Subject: [PATCH 5/9] scripts: python: implement function for thread creation
Message-ID: <ea95605b1f23de6d986b6fa80b2207fb8d9a7389.1687375189.git.anupnewsmail@gmail.com>
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

Create a thread with the specified name, process ID (pid),
and thread ID (tid). The function initializes markers,
samples, frameTable, and stackTable structures for the thread.

The markers structure defines the schema and data for thread
markers, including fields such as 'name', 'startTime',
'endTime', 'phase', 'category', and 'data'.

The samples structure defines the schema and data for thread
samples, including fields such as 'stack', 'time', and 'responsiveness'.

The frameTable structure defines the schema and data for frame
information, including fields such as 'location', 'relevantForJS',
'innerWindowID', 'implementation', 'optimizations', 'line',
'column', 'category', and 'subcategory'.

The purpose of this function is to create a new thread structure
with the necessary data schemas and initial data arrays. These
structures provide a framework for storing and organizing information
related to thread markers, samples, frame details, and stack information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index e5bc7a11c3e6..cdd7f901c13f 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -16,6 +16,47 @@ def isPerfScriptFormat(profile):
     return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
 
 def convertPerfScriptProfile(profile):
+    def _createtread(name, pid, tid):
+        markers = {
+            'schema': {
+                'name': 0,
+                'startTime': 1,
+                'endTime': 2,
+                'phase': 3,
+                'category': 4,
+                'data': 5,
+            },
+            'data': [],
+        }
+        samples = {
+            'schema': {
+                'stack': 0,
+                'time': 1,
+                'responsiveness': 2,
+                },
+            'data': [],
+        }
+        frameTable = {
+            'schema': {
+                'location': 0,
+                'relevantForJS': 1,
+                'innerWindowID': 2,
+                'implementation': 3,
+                'optimizations': 4,
+                'line': 5,
+                'column': 6,
+                'category': 7,
+                'subcategory': 8,
+            },
+            'data': [],
+        }
+        stackTable = {
+            'schema': {
+                'prefix': 0,
+                'frame': 1,
+            },
+            'data': [],
+        }
 
         def addSample(threadName, stackArray, time):
             nonlocal name
-- 
2.34.1

