Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC696883A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBBQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjBBQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:04:38 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28568ACF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:04:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8CA5F3200488;
        Thu,  2 Feb 2023 11:04:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 Feb 2023 11:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1675353873; x=1675440273; bh=fPMUagweHBbVyfH14G8PdZBkK
        cUxF349AZ7jhefIG2k=; b=jfZbERYQN6HgYy4MiUpq0CGLKLE6/oeFvGtMntOZq
        DYrj7QDFG6Dbs5ecpUU/uSQgNYPK0sI4skJfH3LtkbRcCr5s1otaYER7PV8aiedl
        8yaLUkSIrN4x5e2p20FArwlpfaegJsV0mXBM0/9RsIwcfYIIAS63meF9lVzk+uxu
        AZCGqr3V2XA3+PxReuUtPjo2zYu/xjCr4sgkbPuIfACpOJnFq4oIjnJKH5OXD8nP
        9KkHDzF3IrOMssYC0PMQOlQ9c4dmFby+dnZWFgrYFfS1iTqyaorTCcmbInMjHhPR
        PjjqdsYYUpkwqIXn9MgNcURsFjFNuC67I1UlF7ayjQbzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1675353873; x=1675440273; bh=fPMUagweHBbVyfH14G8PdZBkKcUxF349AZ7
        jhefIG2k=; b=flMzm0Iq4vLFjhksZUgViI/2wCOFE2FfPryZL8JEplhn7CaLlmK
        fzU4BH2BsyisD+VYowmAxdy63oSBvYLYK/SEMwIN1r4RNmHO3h1s+UStXUx/3GsI
        NpfN3YOjeP81UyCFbySyhVCmVx0QKHKacBXkj2eqFAZJ8h2qduNs5Q2PZhNIaKAo
        Ip7fRillu6UQq32/4m85+53F62pWCYk0/ELfbODzPdbdDXR24MTY+7yi1M8GIMbN
        iy5pqTXgy9UBsLCWXgug8OtaDpI8wJnN9cxiRjcLZm99D/6OB36YJBBsPdcKqIdB
        s/q2qtenMzIR/uoVRa2Mp8KH3EUWH3oB4MA==
X-ME-Sender: <xms:EN_bYzImusq_0GDIEPj3puEvPY1fBb0B4aYalwdWT5GEo_KXqXdjFg>
    <xme:EN_bY3JLoWnxMuYZzGTNSOJyaHiKilRBPjcBQEi9NnxUjwRFFFy6evtyrgBMogR-G
    jJrQfI_st297iuGQOQ>
X-ME-Received: <xmr:EN_bY7vj7UO2FLg1laCiIDPSYEdxETdz2zPCTClyFoF2B-Bk88J7YlBAL8tDZJ3Lwb17cwL4PTMOr69mA-ujWvHHSpFX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgurgdr
    ihhoqeenucggtffrrghtthgvrhhnpeeifefhieeiudeuffeukefhtedtffegveelkeefff
    dthfefkedthefgjeeuledutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:EN_bY8ZkKwZJzqm6oyrkERBi_M1FerMwCvkl6virvHrvkVrti9nspg>
    <xmx:EN_bY6aQz3Mtwsaoogutf21y2fIrIQUEl6jjHx5zuz2_RHCuegx_6g>
    <xmx:EN_bYwBXRJnSGQbAePa7aTKv2upUOKB-7bAZqZ659IfyrEItDOUe4A>
    <xmx:Ed_bY9wCJGVgdK-hiPk-EWwfb7LIH7IMBcJGreJxlpXjo7uxpngq-A>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Feb 2023 11:04:31 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH] tools/nolibc: Add stdint.h
Date:   Thu,  2 Feb 2023 11:02:37 -0500
Message-Id: <20230202160236.25342-1-v@vda.io>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was testing out nolibc with some simple programs originally linked
against glibc. I noticed a quick fix for some of them was to have an
stdint.h with limits macros.

Here are the changes I made. I've got a couple more ideas for fleshing
out nolibc, let me know if you are interested in contributions.

Add stdint.h and moved the relevant definitions from std.h. Also added
macros for limits and *_least_* types.

---
 tools/include/nolibc/std.h    | 15 +------
 tools/include/nolibc/stdint.h | 77 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 14 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..c65ddf2e4db1 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -18,20 +18,7 @@
 #define NULL ((void *)0)
 #endif
 
-/* stdint types */
-typedef unsigned char       uint8_t;
-typedef   signed char        int8_t;
-typedef unsigned short     uint16_t;
-typedef   signed short      int16_t;
-typedef unsigned int       uint32_t;
-typedef   signed int        int32_t;
-typedef unsigned long long uint64_t;
-typedef   signed long long  int64_t;
-typedef unsigned long        size_t;
-typedef   signed long       ssize_t;
-typedef unsigned long     uintptr_t;
-typedef   signed long      intptr_t;
-typedef   signed long     ptrdiff_t;
+#include <stdint.h>
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
new file mode 100644
index 000000000000..1f11fffe2119
--- /dev/null
+++ b/tools/include/nolibc/stdint.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Standard definitions and types for NOLIBC
+ * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
+ */
+
+#ifndef _NOLIBC_STDINT_H
+#define _NOLIBC_STDINT_H
+
+typedef unsigned char       uint8_t;
+typedef   signed char        int8_t;
+typedef unsigned short     uint16_t;
+typedef   signed short      int16_t;
+typedef unsigned int       uint32_t;
+typedef   signed int        int32_t;
+typedef unsigned long long uint64_t;
+typedef   signed long long  int64_t;
+typedef unsigned long        size_t;
+typedef   signed long       ssize_t;
+typedef unsigned long     uintptr_t;
+typedef   signed long      intptr_t;
+typedef   signed long     ptrdiff_t;
+
+typedef   int8_t       int_least8_t;
+typedef  uint8_t      uint_least8_t;
+typedef  int16_t      int_least16_t;
+typedef uint16_t     uint_least16_t;
+typedef  int32_t      int_least32_t;
+typedef uint32_t     uint_least32_t;
+typedef  int64_t      int_least64_t;
+typedef uint64_t     uint_least64_t;
+
+typedef  int64_t           intmax_t;
+typedef uint64_t          uintmax_t;
+
+/* limits of integral types */
+
+#define        INT8_MIN  (-128)
+#define       INT16_MIN  (-32767-1)
+#define       INT32_MIN  (-2147483647-1)
+#define       INT64_MIN  (-9223372036854775807-1)
+
+#define        INT8_MAX  (127)
+#define       INT16_MAX  (32767)
+#define       INT32_MAX  (2147483647)
+#define       INT64_MAX  (9223372036854775807)
+
+#define       UINT8_MAX  (255)
+#define      UINT16_MAX  (65535)
+#define      UINT32_MAX  (4294967295U)
+#define      UINT64_MAX  (18446744073709551615)
+
+#define  INT_LEAST8_MIN  (-128)
+#define INT_LEAST16_MIN  (-32767-1)
+#define INT_LEAST32_MIN  (-2147483647-1)
+#define INT_LEAST64_MIN  (-9223372036854775807-1)
+
+#define  INT_LEAST8_MAX  (127)
+#define INT_LEAST16_MAX  (32767)
+#define INT_LEAST32_MAX  (2147483647)
+#define INT_LEAST64_MAX  (9223372036854775807)
+
+#define  UINT_LEAST8_MAX  (255)
+#define UINT_LEAST16_MAX  (65535)
+#define UINT_LEAST32_MAX  (4294967295U)
+#define UINT_LEAST64_MAX  (18446744073709551615)
+
+#define         SIZE_MAX  (18446744073709551615UL)
+
+#define       INTPTR_MIN  (-9223372036854775807L-1)
+#define       INTPTR_MAX  (9223372036854775807L)
+#define      UINTPTR_MAX  (18446744073709551615UL)
+
+#define      PTRDIFF_MIN  (-9223372036854775807L-1)
+#define      PTRDIFF_MAX  (9223372036854775807L)
+
+#endif /* _NOLIBC_STDINT_H */
-- 
2.39.1

