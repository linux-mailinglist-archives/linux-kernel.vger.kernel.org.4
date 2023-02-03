Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCBD68A032
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjBCRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjBCRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:24:49 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AE25E38;
        Fri,  3 Feb 2023 09:24:48 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id r9so4698389oig.12;
        Fri, 03 Feb 2023 09:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FN82DGNXcvlnZ81poKIJxG9Xk/mwZRUCAdIqtBC+Iks=;
        b=hRDEP48h+9MCGueSX8xCW8UM56FAiZgBXNm0zBPeRUKx5F/lgArfUDR4l1gKa1sCcp
         evmKXTfHZu6fA/c5X8F+v7GCxz4D+JBylnA/zkAtI0lXe6lPKcjVqpVmfv/xeLVQFxnJ
         W7yq/OKsSgBHfvPKQvaxkMGzrDGlIrXwKqxr2tRypjrSIgE/s5Zh5kglzBWZCKZQkBdH
         i5TbOw9wvLr0JRmmzNgQdqQYOCXP8OiP+i5/ZCatkeIthImr7BFvKiKkBfCIB+x6s/p+
         VXVbzGUep1XYreIRVEzRh0zce5BPZPkksXdjyjH6guPshMESfyMt8gNU77KlRk/L3cgG
         jFHw==
X-Gm-Message-State: AO0yUKWFDfH8hWTfc8zz8unF698aEwU3OpwGVIuWB3ssYaV+kpcf9Wxg
        YqeP8hIw2ch+bqX5eq0gsDRIXWehxw==
X-Google-Smtp-Source: AK7set/Gz34X3w9DjduLqsxc/DN/1TvZhNcPxI4RCjP+HRyku00Rm9Jzpri+oSjh4YNRMI3rMFi1CA==
X-Received: by 2002:a54:4792:0:b0:364:862d:29c5 with SMTP id o18-20020a544792000000b00364862d29c5mr5123147oic.26.1675445086466;
        Fri, 03 Feb 2023 09:24:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b0037887ca2150sm1015853oih.22.2023.02.03.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:24:46 -0800 (PST)
Received: (nullmailer pid 477258 invoked by uid 1000);
        Fri, 03 Feb 2023 17:24:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/dtc: Update to upstream version v1.6.1-66-gabbd523bae6e
Date:   Fri,  3 Feb 2023 11:24:29 -0600
Message-Id: <20230203172430.474431-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the following commits from upstream:

abbd523bae6e pylibfdt: Work-around SWIG limitations with flexible arrays
a41509bea3e7 libfdt: Replace deprecated 0-length arrays with proper flexible arrays
2cd89f862cdb dtc: Warning rather than error on possible truncation of cell values

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/dtc-parser.y  | 11 ++++++++---
 scripts/dtc/libfdt/fdt.h  |  4 ++--
 scripts/dtc/version_gen.h |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
index 46457d4bc0aa..bff1337ec266 100644
--- a/scripts/dtc/dtc-parser.y
+++ b/scripts/dtc/dtc-parser.y
@@ -404,9 +404,14 @@ arrayprefix:
 				 * within the mask to one (i.e. | in the
 				 * mask), all bits are one.
 				 */
-				if (($2 > mask) && (($2 | mask) != -1ULL))
-					ERROR(&@2, "Value out of range for"
-					      " %d-bit array element", $1.bits);
+				if (($2 > mask) && (($2 | mask) != -1ULL)) {
+					char *loc = srcpos_string(&@2);
+					fprintf(stderr,
+						"WARNING: %s: Value 0x%016" PRIx64
+						" truncated to 0x%0*" PRIx64 "\n",
+						loc, $2, $1.bits / 4, ($2 & mask));
+					free(loc);
+				}
 			}
 
 			$$.data = data_append_integer($1.data, $2, $1.bits);
diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index f2e68807f277..0c91aa7f67b5 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -35,14 +35,14 @@ struct fdt_reserve_entry {
 
 struct fdt_node_header {
 	fdt32_t tag;
-	char name[0];
+	char name[];
 };
 
 struct fdt_property {
 	fdt32_t tag;
 	fdt32_t len;
 	fdt32_t nameoff;
-	char data[0];
+	char data[];
 };
 
 #endif /* !__ASSEMBLY */
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index 0f303087b043..99614ec1a289 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.6.1-g55778a03"
+#define DTC_VERSION "DTC 1.6.1-gabbd523b"
-- 
2.39.0

