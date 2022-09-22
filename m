Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363785E57F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIVBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIVBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:24:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2DA13EA0;
        Wed, 21 Sep 2022 18:24:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l65so7749052pfl.8;
        Wed, 21 Sep 2022 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eitMca5v08DGJKXGk6Eie4VZvig2Che+hd3EJ8Ad36k=;
        b=O9Wb4+wEw/WSzn4T1/6mf6Et4LZNxow/J1zklbW2jwZ6KE/tMweEn2yMCHqQqnSqJE
         TB3QetKlBGI+YoIT6jI5zayI7JYXDmyoVxDwck1V2jfdGOr2rwkdjUMMiUp0ZrfALV5N
         ns2Tzqe0kFszx/FApiM/9kZ1Oc2E1pUHSxu4TLMsdllCzV5DtL08Khp1Fq2V2ftJbewQ
         TuSV0SHIs66s15Paw1S/4d3pUJCWsjh0/7zQ2fUdrmCULmeo18eLSL6qnNMvWyv7nPU0
         QGVgZ0/rcKqLibzNgM/EQ5iP9kCc5RsGv5sVEPn5vz3vNwJAjg3VDm9I8DJBTHVnDtqA
         BYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eitMca5v08DGJKXGk6Eie4VZvig2Che+hd3EJ8Ad36k=;
        b=ClkVpKMl7VXnhIGoZbIDYJM9HtEXR0P8y1TQnGTvFNqPPT5YF0ztoApBjIhM7TruA0
         qM2H5J8pC4pTlBKneXyeGSVGhguqr7AGzpV8EBLRvHF5mu5/iMTsAzRI20/3+iarHI0p
         cSt1KPhhGc1/yXY6ok7VxP4WqYJ9k1VkSEgGaNvjW0Fx2S62JHbQSuF6+/e4vRDMyKi4
         T5GZ1mLE/Mx05f5rSrt7nB407jfRHucirKOz58Wu3mWX0n0Qp16Upn6NmAU+HqdNv9wz
         7Jo6h2QJWyECaKR8OQur8MpskcaC7BHIRmrFiEWs81XyBaWQ3fN6m6p/88t1x/M1Sh9B
         Z/QQ==
X-Gm-Message-State: ACrzQf2SwIoUM8m6UW+MSS2zGSZ/dG6H9oFg9a9MdDIgbzwHs1OAkjVo
        nULaS3FaM5NrHEDd1vabU58=
X-Google-Smtp-Source: AMsMyM6Xesv2IhmBefq/cC3T2tFPF2XuTJoeG1Fh02XJKPzcjTZF3LfpddKr2W6IVPJQu4qqNkNE4A==
X-Received: by 2002:a63:1954:0:b0:438:79da:7849 with SMTP id 20-20020a631954000000b0043879da7849mr858065pgz.527.1663809876937;
        Wed, 21 Sep 2022 18:24:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a474e00b001fd803f057bsm2511343pjg.33.2022.09.21.18.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:24:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        adrian.hunter@intel.com, davemarchevsky@fb.com, wcohen@redhat.com,
        andres@anarazel.de, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf annotate: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:24:31 +0000
Message-Id: <20220922012431.232372-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5bc63c9e0324..e2b038b14ff6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1702,7 +1702,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 			char *new_name = filename_with_chroot(dso->nsinfo->pid,
 							      filename);
 			if (new_name) {
-				strlcpy(filename, new_name, filename_size);
+				strscpy(filename, new_name, filename_size);
 				free(new_name);
 			}
 		}
@@ -2002,7 +2002,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		kce.len = sym->end - sym->start;
 		if (!kcore_extract__create(&kce)) {
 			delete_extract = true;
-			strlcpy(symfs_filename, kce.extract_filename,
+			strscpy(symfs_filename, kce.extract_filename,
 				sizeof(symfs_filename));
 		}
 	} else if (dso__needs_decompress(dso)) {
-- 
2.25.1
