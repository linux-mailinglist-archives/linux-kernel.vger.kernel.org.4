Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301B6A005F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjBWBBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBWBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:01:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0C2DE54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:01:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E180D3200975;
        Wed, 22 Feb 2023 20:00:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Feb 2023 20:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677114043; x=1677200443; bh=Xx
        4qBliVKsg1YlSBFtbTjWlGqegbiuzHynPZ7O9RbxU=; b=xGHuZzpxQemgKxMqrg
        lb2u/Zp/SDzaQD44yn/EOkK7hhkRV1pix+t10ApoO9FiIftN8wmq++w9SGJ3jUX4
        JA5iKCbttheLFJIfyyGyo6GPifk7UUHza+Uzo8EUjpVtN+t2BOLLRYRa1x3A+w2Q
        GWR+3kZreEMklCdtGds+ujn+wvIaoyMXJwvxNlmOKsJ/vxKCBpIgHDBg9qTjmQp1
        bgsw7IxYVnEFOI/Fg1VT4EL5EJROmlClBcPr/4YBMTQvP732FgOFAKlZOJBT0NCc
        0YlhW0JMN+IRxrQhcT7Sf7amrG3qh+jGDomTzlIWf5E6fO3zChNfEzs93UiFqZCO
        q13g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677114043; x=1677200443; bh=Xx4qBliVKsg1Y
        lSBFtbTjWlGqegbiuzHynPZ7O9RbxU=; b=KwjkRXG4rAbxmhvodbWoDGjAZpTgD
        it+3dLNeEXreZDzB6lEGdw/4Rv3io4eGVtMVUWlJn7Lo7RbgAGrSnOB/wQ/RPkru
        9RWFQed2erZLkrfHn5AZxgi2okdni4Ke0jfCcAd7FHIpyfeAI897BHsIYSa8fkp7
        lgCwKyeNu3p7rH+ipRQUieKZ9JttOyIne1a9WTZ2z4cF2ypBkSx0lJYf60oupI3p
        /RMwXTD1ynJDnjpl3zvPaJl5JY+3S0Q/GBH3VilPJJwEohkXaXivxeDCt6T/s1Wj
        jdSSytDzYw42e9yUBWdIQ+ccf2ooE1j3McvgxFVXRPiN70UJ9dNBbZEdg==
X-ME-Sender: <xms:u7r2YxvG3XbHnDNkmjMREkIBGkUHElYP__-D461UqVClQp4IwzoWZA>
    <xme:u7r2Y6e3Qy-ZACjx7TLzli7RWXywg7WgyOPhmb3I2P8bmlwIO4TIVhZvUrXoUMqC5
    1-H4JnHEXB441yckio>
X-ME-Received: <xmr:u7r2Y0yUKQ5AMO1UreH6i1SKLbNyHc1cwjYatCXKmA4VGkVYrBHcq5wOEQH2DQ2gfUF3EqYPKIVpctEv3WVNEPDVqhM9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpedujedtgefgtdelffefjeeggffgiefgjeevve
    dtjefhuddvleeiudetuedtffefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:u7r2Y4PY40UtJj1IAIKAC71E2VDSWfvhl3EaPc2jdn4l4RM3_kBQdw>
    <xmx:u7r2Yx-mkOU4eajB8WmLRMTPZ2bYh97Fp-F2FV5J34qNa8kDCGMMpg>
    <xmx:u7r2Y4UxUTvz1mWy7tvTrclqt5re8nuwi0mTrAFB7geDK-0qTC45wA>
    <xmx:u7r2YzlRHklC_EuUhI1lOW3Zxlc9LO_Y97yo-b87epw5EGyFWKk0xg>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 20:00:43 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v6 1/4] tools/nolibc: add stdint.h
Date:   Wed, 22 Feb 2023 20:00:22 -0500
Message-Id: <20230223010025.11092-2-v@vda.io>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223010025.11092-1-v@vda.io>
References: <20230223010025.11092-1-v@vda.io>
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

