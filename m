Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0036A50F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjB1CL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjB1CLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:11:54 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278529163
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:11:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 60AA5320055E;
        Mon, 27 Feb 2023 21:11:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Feb 2023 21:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677550311; x=
        1677636711; bh=spe221j0DFgvCEewZaLWqqkbO2tAWxrToJBpwLW1A7Y=; b=P
        bjdhNh7/3My0mcyHzkOyJmp+L/mXOydmcfdR37FTgrK1lPMb2pxa9806F+gvgbrj
        alJ8uPJG47Y3SExDmMmSRgnT9J/zKXmnk1Cz9L8BsPJlHpuFowPAkG5otmLE3awD
        6wrZ76reMEv6jCbPX2izLd91l5ZzSkFcpiqwHPIKiJGxn5SzqqHgkL0h0lZ75XPW
        ks0+NwmEQ6UxgTVh1/9eaVJsDRjKyOjj6O1YBOCltddS1eVcvvfmLgGWATEVi0go
        OHV21IdVTMO4AmcOicZ8nRzpbY77EU7cZY2xu7nV6EostLI4BK7K81QhNKeAQiO5
        qtu2miOu33mVmho9O2kSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677550311; x=
        1677636711; bh=spe221j0DFgvCEewZaLWqqkbO2tAWxrToJBpwLW1A7Y=; b=M
        EjcTDxzM0UYpKI6yAzDkL9e34POs9DuegJE7DLyHQTBxKlHwn7sO3rY76PTshCzH
        hJNQG0nQQ6J566DUNYwvIfbx5hEvNhXOEetFvAP3iZotxVkNpAETsjABBXzFOOJG
        zIHMmbnNhQoe5MFInEfB9RtHw+RCBlnfQHuYq0slxYuIvzmi0m5bfYRBWkXjHidZ
        dnY7J1MIlShoAMRzldiI3I+q4jaBHO++L424a49/+H5iLkRWeZRSkhJMH0UhNFP3
        Az2I4Ck6x92WLZeiAjdqRI3Kg2WYvCbyKdVA5fu+D2xKecM3ytlBGc/emJw5tWtb
        XBnWF/yHYEBBzitKokJ7w==
X-ME-Sender: <xms:52L9Y1arSniHd_BFYyX0Q8jWNwO0Kc_1N4PjqRF_doacks23q4A7MQ>
    <xme:52L9Y8ZT-BycmA19vTYx9Yj_zAGUxZ0y8v7fDOFnmJfZtUyuKvOqcDDc23RiffX0v
    TkC3Y6wWLzabbs3Cnk>
X-ME-Received: <xmr:52L9Y3_n51YL1wnAObkDUTEInDXeVZ-AKGo-6fRuAz78hqsv9yTNkou_SXSrzONEGuqSPaRuNv8Z1e1PKwXVuov3duat>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepheehleelhedvteegtdeiteejleeigfelvd
    eigfetueegjeevteevudeivdekhfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:52L9YzoXsSqvG7ONoPthm9OdikGFN03ppEs8jKaBjceAr44NISnWbg>
    <xmx:52L9YwrEADqsT9xrkt5biTI-dX3fZlj_GPWescATFCiNez2j-ibFUQ>
    <xmx:52L9Y5QQk0hF11xPrLBY35WjVr5q5ZMnrdITdDvcdT94jqvm47j4yA>
    <xmx:52L9Y7V0TelZ1udSu4BalHEE9kNVnNaQCLmim6UB-F-exNbePar5JA>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 21:11:51 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, thomas@t-8ch.de, Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v7 1/4] tools/nolibc: add stdint.h
Date:   Mon, 27 Feb 2023 21:11:33 -0500
Message-Id: <20230228021136.13472-2-v@vda.io>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228021136.13472-1-v@vda.io>
References: <20230228021136.13472-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
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

