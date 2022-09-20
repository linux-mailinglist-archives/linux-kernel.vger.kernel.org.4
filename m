Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9338C5BF016
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiITW23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiITW20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:28:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB15C363;
        Tue, 20 Sep 2022 15:28:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w10so2950245pll.11;
        Tue, 20 Sep 2022 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=OAF+5M+zn9/mtSEZLYYo6I02WGx/bZellJnkwpPK3QQ=;
        b=RwSV0YDDmv2mM909eS72Jc8/OyA6soVU5+Ifr9y3YNojBPpC9SMCiFCPhcZiQqk+zJ
         YI1XtAUAQus0qohiYqOlGV47JQk7s6ILe172yhzRTUPBO+Yk5glyxPL35DvwKpI37hkS
         1O0CYrxtWkJh00sq/+EIv/Jp50KsqoYmGIFhqZX7Q/mxb1Pa7cu83qP1E1CDDqKjDYwr
         Mn6JxkxgDVG3pYMv+5+QxzSQLkYP6QB/fohxs/D68vPUM7pBdEOrY0JgYAiR1UafXabI
         U07DyjptwNQznyPc+MRN6IRYEkc8CyIIMIKsSYIrPF16S0YgBiBkpOOtj2xAz6uC25iC
         4qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=OAF+5M+zn9/mtSEZLYYo6I02WGx/bZellJnkwpPK3QQ=;
        b=XnmDxU8anBgkXYFnMIxxpWyxawAfSlp5nT3eE2WLkznQab1C19bmjmi4aB74w2DiMV
         HWFJfXKoHKlw+cyHFTyMvnQO2Tz5e9IzYqOAnsHCaAq8CSnAMew7IDEHbUF5qKsg3ONe
         +SuWnSMEa0zDHKEc8az88LvlIKiwqQXdV1lQxZZf4Ix1fXcjXstoi+YdVxtrOg8fcdf3
         Xv54Xdfv6qNXhdQQPPhkgNyOJSobMmHJN3FVOIZv6X5CdBXroK17E0AlF4/8EJa4pkFm
         FPch+XS/Go+vNWso3FBp7M8Tu8C+i//BZZL9Zui9YGUL0Xi11dF/gz0KG3FsmxVA+0Qg
         blRw==
X-Gm-Message-State: ACrzQf0zERHH3GXMAU+tLq2THYRyDpOMvvHZgxrTliFmvW03glPoZ0J1
        wd47UsZKw/2xJGF49dwXkGA=
X-Google-Smtp-Source: AMsMyM7QKaO7PjaBS+1X+mqBjt/8qZ+kAIJfN+qqNl9O4h8g/p8i/UWsPhSdD7zJe8HfHeaOxsd4ew==
X-Received: by 2002:a17:90a:74c5:b0:200:2d89:ef13 with SMTP id p5-20020a17090a74c500b002002d89ef13mr6134415pjl.81.1663712905605;
        Tue, 20 Sep 2022 15:28:25 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:7c7c:fcc0:e49a:4079])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b0017680faa1a8sm413083plh.112.2022.09.20.15.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:28:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] perf tools: Honor namespace when synthesizing build-id
Date:   Tue, 20 Sep 2022 15:28:21 -0700
Message-Id: <20220920222822.2171056-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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

It needs to go into a namespace before reading a file.

Fixes: 4183a8d70a28 ("perf tools: Allow synthesizing the build id for kernel/modules/tasks in PERF_RECORD_MMAP2")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0ff57ca24577..289ea17ac5f7 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -367,13 +367,24 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 					     bool is_kernel)
 {
 	struct build_id bid;
+	struct nsinfo *nsi;
+	struct nscookie nc;
 	int rc;
 
-	if (is_kernel)
+	if (is_kernel) {
 		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
-	else
-		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+		goto out;
+	}
+
+	nsi = nsinfo__new(event->pid);
+	nsinfo__mountns_enter(nsi, &nc);
 
+	rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+
+	nsinfo__mountns_exit(&nc);
+	nsinfo__put(nsi);
+
+out:
 	if (rc == 0) {
 		memcpy(event->build_id, bid.data, sizeof(bid.data));
 		event->build_id_size = (u8) bid.size;
-- 
2.37.3.968.ga6b4b080e4-goog

