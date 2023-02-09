Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6B68FD39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjBIClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjBIClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:41:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB628237
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:41:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A2637320070D;
        Wed,  8 Feb 2023 21:41:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Feb 2023 21:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675910465; x=1675996865; bh=8X
        YshcktQKtbg7u6Sz06kaSBP+Y6wfJhgkxAyymxnPg=; b=ZkUHZxv2uCRcWMBn7h
        d61Q9DMtApRwKDiJzGz+LDnGJ7j6W0eAwcw21L/fI9mE4euH46P/ROpPwtZubnTW
        GK5zuivk3LMC3Z2Tg+axDYgOGPYAMGuvjb4wC/6+9/zLaOzmEJdEyw6Nsu2O1w4h
        B+0Hi661hex3dGFitJ0ogs1eaPxKThvV6n+HIxA4ikapIlh2cSvkTi77Fk0sdK44
        liZGTgTUzSWRXn9RZTRclShm9FvndhLF7lVF1iO0/dCjlEPMNgc5+5fp2s3i3Vk9
        4y5NWN8qcRusfKgB7qslApUQsrm6XYz6JJSq1Yx+bnxUzQREnS57pDdiEQPiIVZ7
        4TaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1675910465; x=1675996865; bh=8XYshcktQKtbg
        7u6Sz06kaSBP+Y6wfJhgkxAyymxnPg=; b=QygVMxEBMcfqVF8RHhvk53/KVpc+C
        A0gGjI1xNDMuP/IMN4iL7a8EMF/xNwScn9946CsEAk/wUvxAqUK01GhNKBdr8F9T
        3H4AiBgZH0jekxg5ATfb+VmZboYh+zxk/pmcGNPCz4Aw34t1xMUwz2D3tMCC8gvi
        TCoSnpIxDi+UojRqlLwdgVPUfHF+EqPdXuv6QQ0w9LYI8sSCLS7lqdJkcT0fF8bj
        bqNhtWYJ4A9AWfdS+AgP3sCZrCLt45ZcNhzICOKOgI8OxRSuEhlD4dX3ZEdHOgEO
        9pqGeUQMPvLj0+IFLFh4xP2glIukYqteptQ6BfigKsLxkUWscCxfY8dmQ==
X-ME-Sender: <xms:QV3kY0TIpswqlCT6ShrMX03y0aEJeomQ0DcIW1f07u5ApZ1sSW1R9Q>
    <xme:QV3kYxx5ltkc_B776WfI9WD9fpjH0jq0jGuDYXzZkkZNix6p9hwVACi1YhORJeDGP
    549mmO-lre-H47s49U>
X-ME-Received: <xmr:QV3kYx0REbtrEfnFdi5yIZEnck8vFjC5_o7rXD9eYdRasgTi41BZilrWkxMjmvcix-PwdS1Lsxzkpu6B1K2EUd19cnUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepudejtdeggfdtlefffeejgefggfeigfejve
    evtdejhfduvdelieduteeutdfffeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:QV3kY4DDQy1YucLfd2rSEOgFm9k6Wc4BV_fw1WBGPTZTxM9X_1brEg>
    <xmx:QV3kY9gBw51ud6Wt-zCMdI-ldgF_a4vN5HfbSQpdCrgG6lSgivrSfQ>
    <xmx:QV3kY0p1tuNOw6dyMMBKQ70N830ZBun04Iui9R5JcSqzoNSQuxB9yg>
    <xmx:QV3kY9a-_8j6757V067SRewSchCbgGL7bk4O5RE4X26FrkNHbOV1LQ>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 21:41:04 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 1/4] tools/nolibc: Adding stdint.h
Date:   Wed,  8 Feb 2023 21:40:41 -0500
Message-Id: <20230209024044.13127-2-v@vda.io>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209024044.13127-1-v@vda.io>
References: <20230209024044.13127-1-v@vda.io>
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

Nolibc works fine for small and limited program however most program
expect integer types to be defined in stdint.h rather than std.h.

This is a quick fix that moves the existing integer definitions in std.h
to stdint.h.

Signed-off-by: Vincent Dagonneau <v@vda.io>
---
 tools/include/nolibc/Makefile |  4 ++--
 tools/include/nolibc/std.h    | 15 +--------------
 tools/include/nolibc/stdint.h | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 16 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index cfd06764b5ae..ec57d3932506 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
-             sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
+             string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 1747ae125392..933bc0be7e1c 100644
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
+#include "stdint.h"
 
 /* those are commonly provided by sys/types.h */
 typedef unsigned int          dev_t;
diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
new file mode 100644
index 000000000000..4ba264031df9
--- /dev/null
+++ b/tools/include/nolibc/stdint.h
@@ -0,0 +1,24 @@
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
+#endif /* _NOLIBC_STDINT_H */
-- 
2.39.1

