Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE169D4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBTUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBTUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:22:03 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADDA222C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:21:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 56E833200D03;
        Mon, 20 Feb 2023 15:20:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 20 Feb 2023 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676924428; x=1677010828; bh=jF
        ft7V1bg/A6TKoYmPm4MyWRLWXR2AhndDnwEaT8Npw=; b=UNqqNcg4O1BidmFIva
        ItxwR01ynfc5j3h4WZaMuZJ8GP1AlQ2FMtGb49QocfgUN7CvNY+RiuLhU7Q15J3t
        YngptvQbjY1IKHTaj71sWm4Gfx6QcPi7r60YOhrI7pVUIKrhTXwfjrwDjatQ5H6c
        0sjL8SVQoqq8gKsuv8Y8ZrtZqQKoSVcqXi3Uvf7XbEg6AM7cnFBDaJYqGPrrgc5d
        Hn6+V1k04VZpdfYYqHW2JdhHP3VnQz/3xDA3Zi/m3B5qrvaQpooEnL2qDRxQD4Ew
        bibaCXgSTr5T1mLk73rR7X2q+clklzXsisSluCKbClYS+uopzIjSqVvEjBXjRGme
        FAXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676924428; x=1677010828; bh=jFft7V1bg/A6T
        KoYmPm4MyWRLWXR2AhndDnwEaT8Npw=; b=bbdisZ5ENzQ9AclvHnLt3LYdXxGhW
        1hNkceuawC2NSFneVYOZlsAga/EqNLK8kdnmjKKbsHTKOEtisHZL+COsA+vckqIl
        deLoQ2/gc8W+hLYRFZFQ9+6a9ayaCxw4mr3rnVIVuuQuQgxlot8/aYJDYMDTQOHl
        XRNlneuNWZwrAM6o7D3WeG7ic0T7zPoeCOCCclqQbWCb7ihpWQaFFfgHdx9zgosR
        +cHBV8qpIhGkV7lMZ53stX7LnlzbZ2d7oTKM0aHyRx/066zwhiSAqebCdjEFOoGk
        D9zoqRZOynK50TzsL+HD7VsfxGEnKYonYzPEzoT2fUhLajyKgOeVH6ZkA==
X-ME-Sender: <xms:DNbzY5mBLXTiDwuZBUJmlPEAgwiJO5gCT-KjoaYoL8GDJAlTow5eGA>
    <xme:DNbzY03A0chKiop1Xi_EhcXFtm-OfgUqsfqrVSTDimwCAS_NANfdilQLVQd3rOLwu
    WpImPOBf9Vx887EFXY>
X-ME-Received: <xmr:DNbzY_pmcPgS55o92oRrj3Zga_OKOVuI8n3u9k9Oba-gf6fWxjo9iAivyL0tmt7miJatPuKudcJxdCqAdEbfdMs_kiVa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepheefveeiveeutdduieevhfejkeehffefje
    efteefheevgfehteeukeehfeelvdfhnecuffhomhgrihhnpehophgvnhhgrhhouhhprdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:DNbzY5ngu8MiP1XKazQSh1o3b3NUklaIeD_JLcY_K4RUnlXcQvmlrQ>
    <xmx:DNbzY33bFxosEKtnnvfEo9Br8DgapK-yDc_Yohzdh_X7WAjd7WUU4Q>
    <xmx:DNbzY4tefcnt24pghsX7EU-lAS76MJXIKKJ-rMo7ivYlx2XJ48ig3Q>
    <xmx:DNbzYw8GK4QUUP07P99e8HLd5ZM6Av2SKNitY7yn4vab1yipsCDtYA>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 15:20:28 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v5 2/4] tools/nolibc: add integer types and integer limit macros
Date:   Mon, 20 Feb 2023 15:20:08 -0500
Message-Id: <20230220202010.37475-3-v@vda.io>
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

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

We rely on the compiler-defined __LONG_MAX__ to get the right limits for
ssize_t, size_t, intptr_t, uintptr_t and ptrdiff_t. This compiler
constant seem to have been defined at least since GCC 4.1.2 and clang
3.0.0 on x86_64. It is also defined on ARM (32&64), mips and RISC-V.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to go with unsigned long on all platforms since
unsigned long == unsigned int on all the platforms we care about. Note
that the kernel uses either unsigned int or unsigned long in
linux/include/uapi/asm-generic/posix_types.h. These should be equivalent
for the plaforms we are targeting.

Also note that the 'fast*' flavor of the types have been chosen to be
always 1 byte for '*fast8*' and always long (a.k.a. size_t/ssize_t) for
the other variants. I have never seen the 'fast*' types in use in the wild
but that seems to be what glibc does.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdint.h | 77 +++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..f7179a583f61 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -21,4 +21,81 @@ typedef unsigned long     uintptr_t;
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
+#define SSIZE_MIN        (-__LONG_MAX__ - 1)
+#define SSIZE_MAX        __LONG_MAX__
+#define INTPTR_MIN       SSIZE_MIN
+#define INTPTR_MAX       SSIZE_MAX
+#define PTRDIFF_MIN      SSIZE_MIN
+#define PTRDIFF_MAX      SSIZE_MAX
+#define UINTPTR_MAX       SIZE_MAX
+
+#define  INT_FAST8_MIN  INT8_MIN
+#define INT_FAST16_MIN  SSIZE_MIN
+#define INT_FAST32_MIN  SSIZE_MIN
+#define INT_FAST64_MIN  SSIZE_MIN
+
+#define  INT_FAST8_MAX  INT8_MAX
+#define INT_FAST16_MAX  SSIZE_MAX
+#define INT_FAST32_MAX  SSIZE_MAX
+#define INT_FAST64_MAX  SSIZE_MAX
+
+#define  UINT_FAST8_MAX UINT8_MAX
+#define UINT_FAST16_MAX SIZE_MAX
+#define UINT_FAST32_MAX SIZE_MAX
+#define UINT_FAST64_MAX SIZE_MAX
+
 #endif /* _NOLIBC_STDINT_H */
-- 
2.39.2

