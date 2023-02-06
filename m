Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F568B3DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBFBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBFBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:33:31 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FF1ABF4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:33:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B03CF5C0095;
        Sun,  5 Feb 2023 20:33:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 05 Feb 2023 20:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675647209; x=1675733609; bh=fV
        X1dx//6BL4WmVFCPIKJBAFS5M6Tn6T+JrR5oaXwfA=; b=TVmE5BM51339xZSqh3
        rllB+kqqIjNQEA7s/hAQyA9KOD3JM2ahyZRWUWeZuCFDodJelqkXNKHfuLZwFNLM
        +gYgJsKky8ZY4aoBh3AQIMsspgkm5ctiHcBXbY+yZrRTlLDw5WiJ7Z8CipDi73Rg
        22/NI7d867Idri/km/SSh+7GB/Nwp77xds7diK33V36vXSNisGjDxLdK3z2ePvC7
        h9wsRamE7o/AWEAerOe0AyACjo5YTWiLqYscafrvzGoTGXHaiX/i8MCEy4rdR7zX
        5YJURttVBoyRmU7OMAFDv4JVlbIHSH2BWjGAuF5o3zkOAq8DFKfN9KyXZxWkIMR9
        N7mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675647209; x=1675733609; bh=fVX1dx//6BL4W
        mVFCPIKJBAFS5M6Tn6T+JrR5oaXwfA=; b=D+MA7O4hghsnoKVXx6h3lUkn7Hg78
        dDXmP0YrSQh+jCaJ0+8+b3WRui5HN931m99M9G+vFJgPC96+x8ntz1CLQyEhhanF
        ie0nRCJo8Dm6D3U1a25+WMt5W3SYyXRvJWq44DUvoP9Laedml7NGf7WQn6/9g+40
        MIEk+ndMBzM+3jAqHOWG9EVcN1xQM7lHsOOuOKzjEjb961SioeyVWWggIY8mJQAp
        eCO/83Ehx2aJwMI4g2ehKZuequDYwAiWLvQH32FzZA+MJ57qgEes06O63x+jTDjL
        LtCV3arbRN3ps5gYjTe5GLxYNBjoNk6O5Zz/MF6SfOmOElW+1SF1QRvAw==
X-ME-Sender: <xms:6VjgY1bOERZJMYyFzwNOGarhUkWdA78kGBqc0QLeMLr3aQ9NacAYxg>
    <xme:6VjgY8Y6NHgpRVvJfs2941eDsDY7f6rGaMVhX8VrzMjegtbIwC7nbn8CB9fE6HcZx
    l0-lqvZ3Mg8dougInw>
X-ME-Received: <xmr:6VjgY39C8_SmptP63LhM6GSzFvVxLDYCritHI5TeM2MDLG9J8WyqRFHm_o4NcjmpO0fmFClI9uXBEAdMEFdG7zDPE8jl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeghedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpedujedtgefgtdelffefjeeggffgiefgjeevve
    dtjefhuddvleeiudetuedtffefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:6VjgYzrWSI3jWAbbFwz6hueBRC5wW0ZxiUvuoXo4mE0DDdVl7DY0CA>
    <xmx:6VjgYwoXN56MWmIw5EbDZC0TnxjmWlEop1aJi2S_ix9n5_p3aU2lrw>
    <xmx:6VjgY5RnRkbbLro35eiGC7e0FRpHp6CujLUYypfvBV9IwhAOAtkNeg>
    <xmx:6VjgY9CuKotxtsaoc2cR0rkG86mHAxMLaHliwnZV2nIon3WtEJCREA>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Feb 2023 20:33:29 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v3 1/4] tools/nolibc: Adding stdint.h
Date:   Sun,  5 Feb 2023 20:32:46 -0500
Message-Id: <20230206013248.471664-2-v@vda.io>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206013248.471664-1-v@vda.io>
References: <20230206013248.471664-1-v@vda.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nolibc works fine for small and limited program however most program
expect integer types to be defined in stdint.h rather than std.h.

This is a quick fix that moves the existing integer definitions in std.h
to stdint.h.
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

