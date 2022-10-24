Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621E60BD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiJXWN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiJXWMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:12:52 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E230501E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:28:42 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id m18so2112932vka.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtjfA87GphDJcI4Vb9iAM+chCBCFrIrn+2UzKfCSzkM=;
        b=k4bz2u0erMG2lsu2Psoe5/usHLFPMqhFmHnRrJe0M+hB86PaLpQ7eCFfAzFmdzz1Qv
         q7ZZnGR1H6LfaNjZ/JrHA77mttFZoADtt6TAJK0F9q6u5z66+75iRGMyo+8GHDPT9p4P
         mFbGQjjLg/uKEg8zJpOSxyXDw2AJWwwea8IGNnaBLli3KvHu8L1bLPvbltmjMRVxTpXD
         3y6RGGHjtq6aFJSiYUHIGPZ7cMF3d6d7RyrWfuHcH1+8p4JuWM4Pz4qzFjJo2GrtB1qm
         5oweYcc5sy5AtXjxueMZPMQLluXjjp3PVWMS8Zp9AY9c10z2DxBq3O+uA5RJ6HvXyKOj
         Kmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtjfA87GphDJcI4Vb9iAM+chCBCFrIrn+2UzKfCSzkM=;
        b=dFRjmZ0+Yyq7Zcir/HvAC7lcTlEBfAvyeUdcQKk3BjfdEncYnq3QbG/abegoIi8R0L
         QEU+hOuwiL8BlvCEA6JWC5cRCpBMed6SWitBh9wQG2KoNIsW1y6iwZNZClLC+Q11c4jV
         8cJfpFYWCshbcdBcDMJJFTbxAUGEduirz9+tx/9mq83mI8xEY7ACKmWBrZ0xQ/yR77ml
         zVCP4uK486vOkhK0nErX/GR9p2vzwWCQQ3zNIeXTa/p6hrBBqztFbXmhYuEiWsPvbWWa
         Wz1wxSnmarU3q+uQ/kScqVbyL56SxjgOlI33OrtnqJYYHk5Xjzf7HidcnXF5DYdDT55O
         SMpQ==
X-Gm-Message-State: ACrzQf2uJqxV6LC9eU7sPerx3iXnqoJdVm9l4k0gdpoqBQHyp5qKVTvb
        1oq+Axs1Qyu+Q8UXlEVL7UYtSm+dp7Q=
X-Google-Smtp-Source: AMsMyM5LGD+kKoUy+UyXdcaHRMuZb+H9htNgOT9oSVdgZ1XZ1DqfomlJfGo6OT3w8iAWsBX5oQp0ww==
X-Received: by 2002:a17:902:ce0e:b0:17d:a730:3835 with SMTP id k14-20020a170902ce0e00b0017da7303835mr36674422plg.131.1666642613053;
        Mon, 24 Oct 2022 13:16:53 -0700 (PDT)
Received: from localhost.localdomain (c-98-35-160-214.hsd1.ca.comcast.net. [98.35.160.214])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7972e000000b0056bb4dc8164sm173518pfg.193.2022.10.24.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:16:52 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sam Hardeman <natrox@outlook.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: [PATCH 1/2] zstd: Move zstd-common module exports to zstd_common_module.c
Date:   Mon, 24 Oct 2022 13:26:05 -0700
Message-Id: <20221024202606.404049-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024202606.404049-1-nickrterrell@gmail.com>
References: <20221024202606.404049-1-nickrterrell@gmail.com>
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

From: Nick Terrell <terrelln@fb.com>

The zstd codebase is imported from the upstream zstd repo, and is over-written on
every update. Upstream keeps the kernel specific code separate from the main
library. So the module definition is moved into the zstd_common_module.c file.
This matches the pattern followed by the zstd-compress and zstd-decompress files.

I've done build and boot testing on x86-64, i386, and aarch64. I've
verified that zstd built both as modules and built-in build and boot.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/Makefile                |  1 +
 lib/zstd/common/entropy_common.c |  4 ----
 lib/zstd/common/zstd_common.c    | 10 ----------
 lib/zstd/zstd_common_module.c    | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 14 deletions(-)
 create mode 100644 lib/zstd/zstd_common_module.c

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index 440bd0007ae2..20f08c644b71 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -35,6 +35,7 @@ zstd_decompress-y := \
 		decompress/zstd_decompress_block.o \
 
 zstd_common-y := \
+		zstd_common_module.o \
 		common/debug.o \
 		common/entropy_common.o \
 		common/error_private.o \
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
index a311808c0d56..6353249de614 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -15,7 +15,6 @@
 /* *************************************
 *  Dependencies
 ***************************************/
-#include <linux/module.h>
 #include "mem.h"
 #include "error_private.h"       /* ERR_*, ERROR */
 #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
@@ -240,7 +239,6 @@ size_t FSE_readNCount(
 {
     return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
 }
-EXPORT_SYMBOL_GPL(FSE_readNCount);
 
 /*! HUF_readStats() :
     Read compact Huffman tree, saved by HUF_writeCTable().
@@ -256,7 +254,6 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
     U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
     return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
 }
-EXPORT_SYMBOL_GPL(HUF_readStats);
 
 FORCE_INLINE_TEMPLATE size_t
 HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
@@ -357,4 +354,3 @@ size_t HUF_readStats_wksp(BYTE* huffWeight, size_t hwSize, U32* rankStats,
     (void)bmi2;
     return HUF_readStats_body_default(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, workSpace, wkspSize);
 }
-EXPORT_SYMBOL_GPL(HUF_readStats_wksp);
diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
index 0f1f63be25d9..3d7e35b309b5 100644
--- a/lib/zstd/common/zstd_common.c
+++ b/lib/zstd/common/zstd_common.c
@@ -13,7 +13,6 @@
 /*-*************************************
 *  Dependencies
 ***************************************/
-#include <linux/module.h>
 #define ZSTD_DEPS_NEED_MALLOC
 #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
 #include "error_private.h"
@@ -36,17 +35,14 @@ const char* ZSTD_versionString(void) { return ZSTD_VERSION_STRING; }
  *  tells if a return value is an error code
  *  symbol is required for external callers */
 unsigned ZSTD_isError(size_t code) { return ERR_isError(code); }
-EXPORT_SYMBOL_GPL(ZSTD_isError);
 
 /*! ZSTD_getErrorName() :
  *  provides error code string from function result (useful for debugging) */
 const char* ZSTD_getErrorName(size_t code) { return ERR_getErrorName(code); }
-EXPORT_SYMBOL_GPL(ZSTD_getErrorName);
 
 /*! ZSTD_getError() :
  *  convert a `size_t` function result into a proper ZSTD_errorCode enum */
 ZSTD_ErrorCode ZSTD_getErrorCode(size_t code) { return ERR_getErrorCode(code); }
-EXPORT_SYMBOL_GPL(ZSTD_getErrorCode);
 
 /*! ZSTD_getErrorString() :
  *  provides error code string from enum */
@@ -63,7 +59,6 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
         return customMem.customAlloc(customMem.opaque, size);
     return ZSTD_malloc(size);
 }
-EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
 
 void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
 {
@@ -76,7 +71,6 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
     }
     return ZSTD_calloc(1, size);
 }
-EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
 
 void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
 {
@@ -87,7 +81,3 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
             ZSTD_free(ptr);
     }
 }
-EXPORT_SYMBOL_GPL(ZSTD_customFree);
-
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("Zstd Common");
diff --git a/lib/zstd/zstd_common_module.c b/lib/zstd/zstd_common_module.c
new file mode 100644
index 000000000000..22686e367e6f
--- /dev/null
+++ b/lib/zstd/zstd_common_module.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * Copyright (c) Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+#include <linux/module.h>
+
+#include "common/huf.h"
+#include "common/fse.h"
+#include "common/zstd_internal.h"
+
+// Export symbols shared by compress and decompress into a common module
+
+#undef ZSTD_isError   /* defined within zstd_internal.h */
+EXPORT_SYMBOL_GPL(FSE_readNCount);
+EXPORT_SYMBOL_GPL(HUF_readStats);
+EXPORT_SYMBOL_GPL(HUF_readStats_wksp);
+EXPORT_SYMBOL_GPL(ZSTD_isError);
+EXPORT_SYMBOL_GPL(ZSTD_getErrorName);
+EXPORT_SYMBOL_GPL(ZSTD_getErrorCode);
+EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
+EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
+EXPORT_SYMBOL_GPL(ZSTD_customFree);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Zstd Common");
-- 
2.38.1

