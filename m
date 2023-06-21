Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE93A739040
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFUTkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFUTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:40:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD761171C;
        Wed, 21 Jun 2023 12:40:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso3383602b3a.2;
        Wed, 21 Jun 2023 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376407; x=1689968407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZjCGZDhKpXUGSqDazPCwNKoB5sel2LSB5kjV5qg9hw=;
        b=hSz94Aifn14AVAIYgF5iOoW8O9wlFY3sDdn24bNFUxZ3IY3QI9JvwGSZYXI14w6sc3
         YF7rY1EzXKlv5p5oEqA0h6BdxSAbJPLLx4MHOiG/sdHW7YJ83NX/jXW2C4hhGet80cNz
         kidZdoUCnLA9ezjdiyep3GzL0pecbQDP/nXa3+azfB1cBB65qWOGEMH1znuJO8apC/TB
         9j/MVQjydoci7Tqo6h0pbMi91ckJPnuxu5zamPfKeetEsCTCPoz5MtgT7v1hCdnKxFHQ
         sg10NEhE04yytTis968A7OWOX0MalBCsg507wAshXChkShni3b7JZ+QUdcB1crJnWdOs
         lq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376407; x=1689968407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZjCGZDhKpXUGSqDazPCwNKoB5sel2LSB5kjV5qg9hw=;
        b=Y+4AuBgj3rGFazQ8jx3biPQMFv7jPLz/A+aIzkTRebiTSeE5UL4vB41L5iGG+Y1ZZb
         hHbrn9jGF2/ZwdB4p29CUH5bENhzwFbOHZvE95xAp2AUPFdmq2a0fm/Wnh69CxCKt8Qa
         EqWl6L4ij+ysbIa6IuNx5Qz85esejCYz225wtRg3bkPFD2B2Sr+YWsB69u3FMiiuWeIY
         pDE4wC3siK69pPdZGNk+RARp1xnQS1yRg3REt4PMYoTVLHM1Pu57PP7I6/19xJCHboNb
         hip0gT/gArGMqqXd0BAoEoEyxAbnxxRnnBoYMgwIWvq/iGVp3wadQVoAmuO9yduGLq43
         WyQA==
X-Gm-Message-State: AC+VfDw+Yzgz6tJ9wu6oyalBXJtCDFizQwIL7xcRPHmNg2dHy1fKBS7i
        jxkxV4QezYnsRmgBwZ1Y9Ek=
X-Google-Smtp-Source: ACHHUZ7iTsUHJjPKx60L97N/5zwVvocem2AFCJg82V3aKOYyAr6+WE8FgMwSi8V+EGANZnX1Vng+pA==
X-Received: by 2002:a05:6a00:a94:b0:666:8403:9f4 with SMTP id b20-20020a056a000a9400b00666840309f4mr17338320pfl.16.1687376407143;
        Wed, 21 Jun 2023 12:40:07 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id a20-20020aa780d4000000b0064d47cd117esm3265030pfn.39.2023.06.21.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:40:06 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:09:59 +0530
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
Subject: [PATCH 2/9] scripts: python: implement add sample function and
 return finish function
Message-ID: <4ded5c271261644c472562f31994830b6a0aefe1.1687375189.git.anupnewsmail@gmail.com>
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

The main convertPerfScriptProfile function returns a dictionary with
references to the addSample and finish functions, allowing external
code to utilize them for profile conversion. This function has few
more functions which will be added.

The addSample function appends a new entry to the 'samples' data structure.
It takes the thread name, stack array, and time as input parameters.
If the thread name differs from the current name, it updates the name.
The function utilizes the get_or_create_stack and get_or_create_frame
methods to construct the stack structure. Finally, it adds the stack,
time, and responsiveness values to the 'data' list within 'samples'.

The finish function generates a dictionary containing various profile information
such as 'tid', 'pid', 'name', 'markers', 'samples', 'frameTable', 'stackTable',
'stringTable', 'registerTime', 'unregisterTime', and 'processType'.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 73a431d0c7d1..2817d4a96269 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -13,3 +13,36 @@ def isPerfScriptFormat(profile):
 
     firstLine = profile[:profile.index('\n')]
     return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
+
+def convertPerfScriptProfile(profile): 
+
+        def addSample(threadName, stackArray, time):
+            nonlocal name
+            if name != threadName:
+                name = threadName
+            # TODO: 
+            # get_or_create_stack will create a new stack if it doesn't exist, or return the existing stack if it does.
+            # get_or_create_frame will create a new frame if it doesn't exist, or return the existing frame if it does.
+            stack = reduce(lambda prefix, stackFrame: get_or_create_stack(get_or_create_frame(stackFrame), prefix), stackArray, None)
+            responsiveness = 0
+            samples['data'].append([stack, time, responsiveness])
+
+        def finish():
+            return {
+                "tid": tid,
+                "pid": pid,
+                "name": name,
+                "markers": markers,
+                "samples": samples,
+                "frameTable": frameTable,
+                "stackTable": stackTable,
+                "stringTable": stringTable,
+                "registerTime": 0,
+                "unregisterTime": None,
+                "processType": 'default'
+            }
+
+        return {
+            "addSample": addSample,
+            "finish": finish
+        }
-- 
2.34.1

