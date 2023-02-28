Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2616A50F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB1CMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjB1CL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:11:58 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC32943B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:11:55 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 06A0A32004E7;
        Mon, 27 Feb 2023 21:11:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Feb 2023 21:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677550314; x=
        1677636714; bh=pIQXNkttTrICd4hXmrTsC/gZHMU5+O3q8QxCTHataQc=; b=l
        aB7onMnp99YptB6kadodDKkc6VBWQRzLSW/9Vde0vuUyVilstgn8nHNRGR2cb40R
        ZTMTzyD0eSIrT+DZ3JU6gpTyb0ZdJ3ngh8lw4bSQikwP7KKLjy671RwERCRx7cll
        xHP1JvSJYLMd6Ynont8shh5FEXfDDA24xduKDa5ydeA3LghWdbPcF2G+ZBxyDTIO
        i7iGyhkJuFetU2yv93ke4rYHN66fA8qp7ASKAjLJ1mkPGtZ8JOBQVxAffyJ5jWRj
        83oCE/SR1JlGCWc0c3uWzmW6nVM6S4B1PrBnaTqwMTLhlZCP2ywpOZE4DhZCNRjB
        ZnHm9VYh1EsLja0Cp+qPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677550314; x=
        1677636714; bh=pIQXNkttTrICd4hXmrTsC/gZHMU5+O3q8QxCTHataQc=; b=i
        leBxMu45u4p2edJDLcoADZHz+GZ+XrbYB7OmiGJ47PqxOxSOj2k45N80hjn17UMV
        dAq9GVNU694ROltPozoi0SmS7j9m+nt2dYrvpwgzYER3Ui/ACs8sVff/N5PHWaJO
        GBohsaOBuHfwhPVDc3BCeUDGcI8wFBqBHo0w1qDuNL5Sm/O/2lq6EanlChY7JONQ
        4LFxAXfgUhPnQp0IvnAewI4phR59oXAHp9Euqf3c8WJT9uZ6UeZgs4fBruY52zVX
        /pCqzt1epzkhxBnRKWjmtwFkQEJaXaen80siuMOCk3+6w5KD7VMRR0rx1NXQbRCK
        f0Uq9rMnqoCNIUVdYzItQ==
X-ME-Sender: <xms:6mL9Y9dY0iB3KIvg-jycs73Ct0P4FS0AEWvHwu-s4IELox_qFkEB1w>
    <xme:6mL9Y7MZi5U5TDZ1WUBKhCZ0zna6ULhMo4SFckwUmWcvzbfuGOTRVO49ZD7IDO-FU
    L8Ooibao8ysuGJ1qNA>
X-ME-Received: <xmr:6mL9Y2gbtYfve3cRL6a1P0rK7ldMdxMX4jqlr5_I8XaX6qwwOX5UnQ0BS75A413_tEuH7HocwDOuUW8uGI0Qd3Th8xZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepgfekgfejjefftdeutdffgeeuleeuvdekve
    eugfeviedvjeehfeejhfefuefhheetnecuffhomhgrihhnpehophgvnhhgrhhouhhprdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:6mL9Y2-HfzeO0ZEiAiPf-9Ac5KVz6muUJzJ2IGCW1bq9km-2FO5QDw>
    <xmx:6mL9Y5soko1-u5xB3Zx6IN0dU35b1aHdc3DrJ_5XqmSmNSvHupkrzA>
    <xmx:6mL9Y1EogfHvycYglmxVzTrSwEjhvh26GmAsWGgPS7PdziSN2Ro_gg>
    <xmx:6mL9YxLnDWLoxry1OM8N-e4Hv5Qi4AbnhoFw8Pvng4JVGtxNiBElVw>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 21:11:54 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, thomas@t-8ch.de, Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v7 2/4] tools/nolibc: add integer types and integer limit macros
Date:   Mon, 27 Feb 2023 21:11:34 -0500
Message-Id: <20230228021136.13472-3-v@vda.io>
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

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

We rely on the compiler-defined __LONG_MAX__ to get the right limits for
size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler constant seem
to have been defined at least since GCC 4.1.2 and clang
3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to go with unsigned long on all platforms since
unsigned long == unsigned int on all the platforms we care about. Note
that the kernel uses either unsigned int or unsigned long in
linux/include/uapi/asm-generic/posix_types.h. These should be equivalent
for the plaforms we are targeting.

Also note that the 'fast*' flavor of the types have been chosen to be
always 1 byte for '*fast8*' and always long (a.k.a. intptr_t/uintptr_t) for
the other variants. I have never seen the 'fast*' types in use in the wild
but that seems to be what glibc does.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdint.h | 75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..c1ce4f5e0603 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -21,4 +21,79 @@ typedef unsigned long     uintptr_t;
 typedef   signed long      intptr_t;
 typedef   signed long     ptrdiff_t;
 
+typedef   int8_t       int_least8_t;
+typedef  uint8_t      uint_least8_t;
+typedef  int16_t      int_least16_t;
+typedef uint16_t     uint_least16_t;
+typedef  int32_t      int_least32_t;
+typedef uint32_t     uint_least32_t;
+typedef  int64_t      int_least64_t;
+typedef uint64_t     uint_least64_t;
+
+typedef   int8_t        int_fast8_t;
+typedef  uint8_t       uint_fast8_t;
+typedef  ssize_t       int_fast16_t;
+typedef   size_t      uint_fast16_t;
+typedef  ssize_t       int_fast32_t;
+typedef   size_t      uint_fast32_t;
+typedef  ssize_t       int_fast64_t;
+typedef   size_t      uint_fast64_t;
+
+typedef  int64_t           intmax_t;
+typedef uint64_t          uintmax_t;
+
+/* limits of integral types */
+
+#define        INT8_MIN  (-128)
+#define       INT16_MIN  (-32767-1)
+#define       INT32_MIN  (-2147483647-1)
+#define       INT64_MIN  (-9223372036854775807LL-1)
+
+#define        INT8_MAX  (127)
+#define       INT16_MAX  (32767)
+#define       INT32_MAX  (2147483647)
+#define       INT64_MAX  (9223372036854775807LL)
+
+#define       UINT8_MAX  (255)
+#define      UINT16_MAX  (65535)
+#define      UINT32_MAX  (4294967295U)
+#define      UINT64_MAX  (18446744073709551615ULL)
+
+#define  INT_LEAST8_MIN  INT8_MIN
+#define INT_LEAST16_MIN  INT16_MIN
+#define INT_LEAST32_MIN  INT32_MIN
+#define INT_LEAST64_MIN  INT64_MIN
+
+#define  INT_LEAST8_MAX  INT8_MAX
+#define INT_LEAST16_MAX  INT16_MAX
+#define INT_LEAST32_MAX  INT32_MAX
+#define INT_LEAST64_MAX  INT64_MAX
+
+#define  UINT_LEAST8_MAX UINT8_MAX
+#define UINT_LEAST16_MAX UINT16_MAX
+#define UINT_LEAST32_MAX UINT32_MAX
+#define UINT_LEAST64_MAX UINT64_MAX
+
+#define SIZE_MAX         ((size_t)(__LONG_MAX__) * 2 + 1)
+#define INTPTR_MIN       (-__LONG_MAX__ - 1)
+#define INTPTR_MAX       __LONG_MAX__
+#define PTRDIFF_MIN      INTPTR_MIN
+#define PTRDIFF_MAX      INTPTR_MAX
+#define UINTPTR_MAX      SIZE_MAX
+
+#define  INT_FAST8_MIN   INT8_MIN
+#define INT_FAST16_MIN   INTPTR_MIN
+#define INT_FAST32_MIN   INTPTR_MIN
+#define INT_FAST64_MIN   INTPTR_MIN
+
+#define  INT_FAST8_MAX   INT8_MAX
+#define INT_FAST16_MAX   INTPTR_MAX
+#define INT_FAST32_MAX   INTPTR_MAX
+#define INT_FAST64_MAX   INTPTR_MAX
+
+#define  UINT_FAST8_MAX  UINT8_MAX
+#define UINT_FAST16_MAX  SIZE_MAX
+#define UINT_FAST32_MAX  SIZE_MAX
+#define UINT_FAST64_MAX  SIZE_MAX
+
 #endif /* _NOLIBC_STDINT_H */
-- 
2.39.2

