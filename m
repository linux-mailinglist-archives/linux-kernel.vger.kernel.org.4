Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B03718512
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjEaOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEaOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:35:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67595
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:35:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97392066d04so880125666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685543747; x=1688135747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DNFX7Iv5BdsNcaX+SkOKz/qlMLAoGqACR2i1e7fx5Q=;
        b=gpS8KUUz0KCpJvaH9uJFLnVW0vlccxYFSznitA09vGqUbk92xEIK66b6VikU9+Q8za
         7pjMA7/nVUoJhFaLFsTyiDwNy4y6BsmovY9vVnjUbPOtQbM+OJmFWVdoRMOVoxsEsEUY
         7OK/DBtzLXIUOVe+RrEKnFT21uljzfDiZCFAOWGsIXzCH64efKfGtg7UWFi5GMcxLIgw
         x5U/QzZzZAQip+Qxki/lMkaMUO3wfJiplaCjArPWHtcIWpVCtORdFM2un2sic827D7L9
         ccqEbnU5gY04NTnHAY69o7i31x7rr02/i4LYWgYpoBVwz0cpKTU6GcGJfsuoU0rIuFYo
         iOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543747; x=1688135747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DNFX7Iv5BdsNcaX+SkOKz/qlMLAoGqACR2i1e7fx5Q=;
        b=ddFJIdtrz1hYOBxVMCWyZ+D02NQRBceawNS3pvQfp6EnrMjU2xYzQnLvmg3HVQzDHY
         JJ8faVgLEbZFxy6s49LzCm0U08U6luNvvQjcAY69m7BdFnNhzxvhv+8A1fAkI8f4b1UV
         Jhn9E6lYoCKzf5Q9BU4+ZybYbqDff7UzvuFmL1oGFlUMHJ32VbYyMNAG0j2DVb3jGW2h
         CPrTMZxBo9JZCG/lvt5C0wnCOSLU4PLfnmkwG3amTWpaw/sTblbtUZaqh38imV08d+ug
         DK3s+dPgwBbxgcR/X6LokheeldbUeON3AhEklINi9fMIGoPhce9Ma0HoZ75t5PEvHTNb
         mbcQ==
X-Gm-Message-State: AC+VfDzQzaXspNlu8IPEmkMdVprBdOsVGMCu+9Tg3c/DPYLPGDc1HlLl
        OmouEdC1rXLWJPLGbMfWQjPU2N0MDbiSTA==
X-Google-Smtp-Source: ACHHUZ5IhGVkVWFPusoqOBy9oBpYyaM7EwCDaWRhiHCLR2pnVvasl7mrt3O7DzhyuAwb7kJ18/uWZQ==
X-Received: by 2002:a17:907:3e1e:b0:94e:ed5d:c864 with SMTP id hp30-20020a1709073e1e00b0094eed5dc864mr6479045ejc.19.1685543746787;
        Wed, 31 May 2023 07:35:46 -0700 (PDT)
Received: from epleaning.kpn (2a02-a45b-7f00-1-8e29-3835-f9f4-1d36.fixed6.kpn.net. [2a02:a45b:7f00:1:8e29:3835:f9f4:1d36])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b0096f7500502csm9120650ejc.199.2023.05.31.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:35:46 -0700 (PDT)
From:   elisabeth <paniii94@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     elisabeth <paniii94@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] Subject: perf jit: Fix incorrect file name in DWARF line table
Date:   Wed, 31 May 2023 16:35:33 +0200
Message-Id: <20230531143533.196835-1-paniii94@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue where an incorrect file name was added in the DWARF line table
due to not checking the filename against the repeated name marker (/xff/0).
This can be seen with `objdump --dwarf=line` on the ELF file after perf inject.

Signed-off-by: elisabeth <paniii94@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/genelf_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index aa5dcc56b2ac..2928b59bb9a5 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -349,6 +349,7 @@ static void emit_lineno_info(struct buffer_ext *be,
 	 */
 
 	/* start state of the state machine we take care of */
+	char const repeated_name_marker[] = {'\xff', '\0'};
 	unsigned long last_vma = 0;
 	char const  *cur_filename = NULL;
 	unsigned long cur_file_idx = 0;
@@ -363,7 +364,8 @@ static void emit_lineno_info(struct buffer_ext *be,
 		/*
 		 * check if filename changed, if so add it
 		 */
-		if (!cur_filename || strcmp(cur_filename, ent->name)) {
+		if ((!cur_filename || strcmp(cur_filename, ent->name)) &&
+			memcmp(repeated_name_marker, ent->name, sizeof(repeated_name_marker)) != 0) {
 			emit_lne_define_filename(be, ent->name);
 			cur_filename = ent->name;
 			emit_set_file(be, ++cur_file_idx);
-- 
2.34.1

