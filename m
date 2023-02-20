Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09D69D4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjBTUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjBTUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:22:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EDB211F3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:21:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0EA083200D02;
        Mon, 20 Feb 2023 15:20:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 Feb 2023 15:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676924426; x=1677010826; bh=Xx
        4qBliVKsg1YlSBFtbTjWlGqegbiuzHynPZ7O9RbxU=; b=xYzCQ3XlxzAr8THnwZ
        AVvdyD0dFiq7PiOtn1UH6YUjQiIJ809QigbxbFSjt4oTOdZZlU/hONUC8OAvEs2g
        9Hl8GcDnQAxkn9qXxfk84CdCs0Mm7bG5PcMbzm0A8hXcG3eKcFvYbHBzQJAPjatJ
        cKQNJd5Z7/y7JuNZfhqRbFtuQ8sjWRJv+g/FkYnhKf/++xf1hH/WnqqcBfRo8eKh
        lGYQjDJJTBjPvzF+PWneGUzH8xVjao6PsFtUVNWsrl74K5/Qatwmbdn9fTxczy1w
        zIeKTASU4wbOT8giywrH0xvrp5TdpPW/WJV8m5zr8ief94qznWlEGU5FyUXSuEgb
        Zu/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676924426; x=1677010826; bh=Xx4qBliVKsg1Y
        lSBFtbTjWlGqegbiuzHynPZ7O9RbxU=; b=PXs9txMlCBQQoSayZcMU3GOr8f4cE
        7jQlIZr6nt3ySHppgtbgqMoDvZYnEwfTp+mgdAK83g6B8U1p+NXEbvKGC8UUHyGX
        SOrynWUn7+9YTwUpmHfJDvJ2SrR6OQ44sv8vwzrRkiZSS8SBgcCUflBYKRaAqh71
        0A8jwqaY5RmjrCoQHHfzRJ8OWdSVVWgcecmvCgDUMuQ+9GlkmdJMzB56+1oC1hKj
        S0aJc2GHVF/q6l8fEUhWvjx8fn/JFKrMZgtixR3q3XQ4zNItfw1aPifqC1YGuviI
        QHGVaiTkbPa1TsMANklcmy2DyW2QjkELxTCrbGvzPPf0WmUK9BJS6HYoQ==
X-ME-Sender: <xms:CtbzY6jWjPwq9KUIaZgND7sHxSVsFd5kVC0r61j8spHvQFyafL-duQ>
    <xme:CtbzY7BxqOtVkDUxamogUiroNgAqmU0XbqR55b00dw5o8BKFOfoeQN1qL0SinbNmx
    41_x8kJohT9aVM7qA8>
X-ME-Received: <xmr:CtbzYyHgfBJ_m_MC9tvM-tJB90cF73Jz6OJoutYOShAkB_I46GrR_2XVftJhOY9WBVDz75y5rt0AaDFjFrpMr2ARaKaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepudejtdeggfdtlefffeejgefggfeigfejve
    evtdejhfduvdelieduteeutdfffeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:CtbzYzSA2JGx0w_I-bEze0LjheB00KJeuyPR38y3uS1PgLQCGKT_aw>
    <xmx:CtbzY3wSkSCjalaSIZ8U5BnClUH7693mVEFD-PkCj0xEykuBORYmBg>
    <xmx:CtbzYx7jlkcctRaeKSAFc1DC9BfUhrtW6Txl51D92PzwEGRbwlL3kg>
    <xmx:CtbzYwreYzOt8ZsqhrI-QpjaYzO7gzWYRyNmHQitM3fvHPrBfl4lZw>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 15:20:26 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v5 1/4] tools/nolibc: add stdint.h
Date:   Mon, 20 Feb 2023 15:20:07 -0500
Message-Id: <20230220202010.37475-2-v@vda.io>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220202010.37475-1-v@vda.io>
References: <20230220202010.37475-1-v@vda.io>
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
Signed-off-by: Willy Tarreau <w@1wt.eu>
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
2.39.2

