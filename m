Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5D748E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjGETt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjGETtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:49:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23890E3;
        Wed,  5 Jul 2023 12:49:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b895a06484so18482905ad.1;
        Wed, 05 Jul 2023 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586562; x=1691178562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwp8fA2qpy452CipUIAT5AcsUa4bLXq9Z9L1naFewyg=;
        b=AH2xCWzJyQrh3RwBnsTSDzNuG04w+HjuNr1vKGp1Q3oiaKhXGYhefX7K75Q/TkYe6B
         BFN6d+A9sDXrKTkD68wNZPLnuYkkfBfpqMPWDIA4qgDTgwx/qqdOnd+lZZR4OuEaUpeq
         zqFWjhES/f2nWWF97kyhFafsDHxW/r4Wks0FY3UxCa1kLnVdd4VnBQTWjk3WSRKIA7kK
         BjKzsLAuDRCrlA+IBXi6UHTtj3hKGeB86lnwVw9QdHvJiQAlaVDMsxeWOBlLSCclgucj
         /oMKLRzNSm2XeqkQ568W69PhOu2thyMN1Jufo8wR2nAcmdwpoXty3bDXA2iMBWQfyluh
         oj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586562; x=1691178562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwp8fA2qpy452CipUIAT5AcsUa4bLXq9Z9L1naFewyg=;
        b=NWUznAubtEtvciU4RCtj8hlw0rHNhVaOWTj6eWSrQxTvIpeps44DWomlpNALwTKgha
         TGMoj8NfNn8IXhbQba50ET6m/HPhWW42MSdMyWfm+xIZCKuiAOHKm/OohsfSMdjuAuzj
         ARTAa6/0L3rRov4rFCTMg4uyb7/oxWv9fohaj0ALBMu49Rb/gJQdSV3lF9CwOKWtfwTX
         6Fa1zxKQ0zrJ7ypHFtb8KuKBuFzTnaHlfLDS1//RNimN1qHOk+Nl2CsB5Up27vkVRgHa
         rpLUv76tU7FkgrzZ5zyDCn7eqz4uUPq9km3Nx1+TbMCA1AbOcutgMAjP9scRtQ5eAnCk
         SJJw==
X-Gm-Message-State: ABy/qLYHu5w10TrFwO95hV3XE3dFC+Xh0EmQfzCNgDWMcQe9Amyr/AHL
        pzzCbajnJZzyhalo1UCtSwc=
X-Google-Smtp-Source: APBJJlFPwzvYIzNEY+bAyj+fX3xFQcHUHiPP3qHW3xU7+OplVAcUuNMEJjLTCT58P9FDJEdfbDGkmA==
X-Received: by 2002:a17:903:2281:b0:1b6:6b90:7c2f with SMTP id b1-20020a170903228100b001b66b907c2fmr16773053plh.55.1688586562475;
        Wed, 05 Jul 2023 12:49:22 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001b86f410341sm9812547plg.189.2023.07.05.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:49:22 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:19:13 +0530
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
Subject: [PATCH v2 6/7] scripts: python: implement add sample function and
 return finish
Message-ID: <d464d96e2559c42cfeb568fdf67056db297d3dd0.1688585597.git.anupnewsmail@gmail.com>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688585597.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addSample function appends a new entry to the 'samples' data structure.
It takes the thread name, stack array, and time as input parameters and
if the thread name differs from the current name, it updates the name.
The function utilizes the get_or_create_stack and get_or_create_frame
methods to construct the stack structure. Finally, it adds the stack,
time, and responsiveness values to the 'data' list within 'samples'.

The finish function generates a dictionary containing various profile
information such as 'tid', 'pid', 'name', 'markers', 'samples',
'frameTable', 'stackTable', 'stringTable', 'registerTime',
'unregisterTime', and 'processType'.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index d5b9fb16e520..910e598c743f 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -110,6 +110,35 @@ def process_event(param_dict):
 				frameMap[frameString] = frame
 			return frame
 
+		def addSample(threadName, stackArray, time):
+			nonlocal name
+			if name != threadName:
+				name = threadName
+			stack = reduce(lambda prefix, stackFrame: get_or_create_stack
+					(get_or_create_frame(stackFrame), prefix), stackArray, None)
+			responsiveness = 0
+			samples['data'].append([stack, time, responsiveness])
+
+		def finish():
+			return {
+				"tid": tid,
+				"pid": pid,
+				"name": name,
+				"markers": markers,
+				"samples": samples,
+				"frameTable": frameTable,
+				"stackTable": stackTable,
+				"stringTable": stringTable,
+				"registerTime": 0,
+				"unregisterTime": None,
+				"processType": 'default'
+			}
+
+		return {
+			"addSample": addSample,
+			"finish": finish
+		}
+
 	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
 		thread = thread_map.get(tid)
 		if not thread:
-- 
2.34.1

