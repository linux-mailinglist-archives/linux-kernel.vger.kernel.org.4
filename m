Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D5720241
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjFBMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjFBMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:38:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39121AE;
        Fri,  2 Jun 2023 05:38:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-97448470403so274267666b.1;
        Fri, 02 Jun 2023 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685709519; x=1688301519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh+0N7gAaajlUQA9Pn27BgVBINuOBcCyPpKtQHaHnrE=;
        b=iTJt9d04Vot5XFIg18UMJRaIBs2Wduoabj56wOgaCPtALfWNud3uLrafoJUUEcVrlX
         7Kfrmn2Qm98+LBZfNKGnAq7HcA2wQD8Vlsz4GWowDYKfeRnspE+U/2O7zYNNffa7KpBr
         GDZ8HVrGwYkhK6lgdAWffSz+JwVh55BbwTblwC2QeBWWGyypf+LTKXR+h1wDp7UO3HWh
         CqaEbX3DltujTEEIKdDfHVFny0RACA7JblEBBlqS7JmhKnECX9E1u7QNAnCekkKSmYNN
         I6qRwfOZRU281wMatz/vuQDTa4nI21L0M9/cR57seaBOYrD4NEu0A8nsL4/kaI5Erdi9
         Gazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709519; x=1688301519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh+0N7gAaajlUQA9Pn27BgVBINuOBcCyPpKtQHaHnrE=;
        b=QhbOIjKd7PC3HGoeVs4trpdwKmZpmbIRAUhanoFekSBBA6gOCzpDETgIZHyEeExtxB
         Vxcky04chBN4skx3bMv4i3UEC1TUNnoTin+aUgRNbNFKeq1PDm8ncPDhPMXLOCtSkjBp
         lUeugbAHep+dbJig0k6NZgDw7rBeDmgsTEMxf+Hdqi6QfbYwVWpuAHo+H1FCsf+QQMBQ
         Zbm+xvKhXtreUZcc3bagz4Kt+r63tPSSMPd6iYrENCCQp5Pvgs4q3TZKohY6dH1HB2g1
         0JnQHBGH182cmnYfdT3+5K8U+g8UOcWE7dLV/0PjGzK0i2L3lu4FSBl2YDmzoLXtzQFu
         BJOQ==
X-Gm-Message-State: AC+VfDxemhfq3o0a63Dxb98RS7FroKMw3lh9+A5wJD++P4o119I+T2yF
        F5f9/VEkGFJ2Vrd1h5cuQAY=
X-Google-Smtp-Source: ACHHUZ4RgXaxLPrfCQ3pJR2tdNW31uo0QjsRM7VK35mZ7ia6GjBzjfGPVCPD/WSzuCKhzsR7bCf8gQ==
X-Received: by 2002:a17:907:a426:b0:96f:c988:93b with SMTP id sg38-20020a170907a42600b0096fc988093bmr11351938ejc.35.1685709518815;
        Fri, 02 Jun 2023 05:38:38 -0700 (PDT)
Received: from epleaning.kpn (2a02-a45b-7f00-1-8367-a07d-b687-2141.fixed6.kpn.net. [2a02:a45b:7f00:1:8367:a07d:b687:2141])
        by smtp.gmail.com with ESMTPSA id ot12-20020a170906cccc00b0096f4c9ce526sm706249ejb.225.2023.06.02.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:38:38 -0700 (PDT)
From:   Elisabeth <paniii94@gmail.com>
To:     namhyung@kernel.org
Cc:     elisabeth <paniii94@gmail.com>,
        Elisabeth Panholzer <elisabeth@leaningtech.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2] Subject: perf jit: Fix incorrect file name in DWARF line table
Date:   Fri,  2 Jun 2023 14:38:15 +0200
Message-Id: <20230602123815.255001-1-paniii94@gmail.com>
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

From: elisabeth <paniii94@gmail.com>

Fixes an issue where an incorrect filename was added in the DWARF line table of
an ELF object file when calling 'perf inject --jit' due to not checking the
filename of a debug entry against the repeated name marker (/xff/0).
The marker is mentioned in the tools/perf/util/jitdump.h header, which describes
the jitdump binary format, and indicitates that the filename in a debug entry
is the same as the previous enrty.
In the function emit_lineno_info(), in the file tools/perf/util/genelf-debug.c,
the debug entry filename gets compared to the previous entry filename. If they
are not the same, a new filename is added to the DWARF line table. However,
since there is no check against '\xff\0', in some cases '\xff\0' is inserted
as the filename into the DWARF line table.
This can be seen with `objdump --dwarf=line` on the ELF file after `perf inject --jit`.
It also makes no source code information show up in 'perf annotate'.

Signed-off-by: Elisabeth Panholzer <elisabeth@leaningtech.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
Changes in v2:
	- Made the commit message more descriptive
	- Added a comment that mentions the jitdump format
	- Changed memcmp() to strcmp()

 tools/perf/util/genelf_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index aa5dcc56b2ac..138fdf87eaa2 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -337,6 +337,9 @@ static void emit_lineno_info(struct buffer_ext *be,
 {
 	size_t i;
 
+	/* as described in the jitdump format */
+	const char repeated_name_marker[] = {'\xff', '\0'}; 
+
 	/*
 	 * Machine state at start of a statement program
 	 * address = 0
@@ -363,7 +366,8 @@ static void emit_lineno_info(struct buffer_ext *be,
 		/*
 		 * check if filename changed, if so add it
 		 */
-		if (!cur_filename || strcmp(cur_filename, ent->name)) {
+		if ((!cur_filename || strcmp(cur_filename, ent->name)) &&
+			strcmp(repeated_name_marker, ent->name)) {
 			emit_lne_define_filename(be, ent->name);
 			cur_filename = ent->name;
 			emit_set_file(be, ++cur_file_idx);
-- 
2.34.1

