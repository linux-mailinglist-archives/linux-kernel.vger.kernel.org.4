Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712966A0060
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjBWBBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBWBBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:01:46 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE9457C2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:01:19 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 110FD3200948;
        Wed, 22 Feb 2023 20:00:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 Feb 2023 20:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677114045; x=1677200445; bh=Nr
        kYxP+fjba6kCqNMrKrFu1CZOowHerthzStVz2IYj0=; b=JwJ6ZCvUbr4RR63UHR
        3/rJXGBktlM9qQ2QkrU8/Db8q3EsbtW6oxyxo5xb5SnlaGkt5J2O3Dng0i1DTgdq
        7lX2Sw0aa5ZahLjQ73EmJ2WptM9HKxWd6xsknRrSP6x/kjC3RIS8m0Tet/Z5HcrI
        HSc2CYAH0ZujhrfXs0D/X30Xd8m8ZVltoCr9IZfkPNjpYHX7yAwXUzXcChUr3MV2
        jOQrFukpQDyTrv/NfZvqoiigqDZpdLHlL5NO3EuvHDJeTFR0lAyFXzUgvv63l0Nw
        dAwzKNJ80bKOgZPxDKlR5OKYi/KOxev2OHMPMRUuhsZ8IotewMqAZWtzMHO8kZ69
        z0dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677114045; x=1677200445; bh=NrkYxP+fjba6k
        CqNMrKrFu1CZOowHerthzStVz2IYj0=; b=AFzv55D4lmhQa4fKrASIO3ecTVosd
        sNM4H7+0/fZLALFJPPqwfPrlDD8zHw9EurFjY+ce0//LEqu04TilDmBulx0Ucykj
        ieGWDYe3CgAqfmErNXPftb5W1mH13NuXN2kfHw2hRlCttdg6v3PnbMDduCxlPjVl
        3LeBNuVkA+2uzItmfLKBsIqNNK7D6EtxAl3uNJUBqrse68aYrVax9cTBm+hwy/DF
        ljSE+0+3GeHKbT5ZHLt9D1jbUMtPVH1eXxIWh6rgl8nM1gPn2uAyl31mTEeq0bsH
        WK0a7LYdcCIaCQFfJX0PEVi0Od/9Oqs0j4vBt8/DGGDtqKnYFiztEvZtw==
X-ME-Sender: <xms:vbr2Y47jIUXiJ6cEYgG79GvPSzFRjHOxbWArZJqVuygsQF6JTGIqAg>
    <xme:vbr2Y56TvRTAl1WphclOd8znPho7vNk_YPmUehHBbqZ7Z8JHJI-_w-8OJrrKEo4mK
    mezQEssB3uSmM_hnBM>
X-ME-Received: <xmr:vbr2Y3cmYDifkCas5_GxUYJNhvGIqHa_cwkecdpmviIDHJJMF1d44zsl6ACeKs_70CELN1ei6QA_zyWeLvuEBco9KhYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpeehfeevieevuedtudeivefhjeekhefffeejfe
    etfeehvefgheetueekheefledvhfenucffohhmrghinhepohhpvghnghhrohhuphdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvse
    hvuggrrdhioh
X-ME-Proxy: <xmx:vbr2Y9K2FlAxGY3dTF184ntN2TubPVQqpXt7bWFn7PJimGcZUKvrng>
    <xmx:vbr2Y8JHyGPbPWn6SHXPEubrJIZ2YazyAtKaizJmTg8m5U3hdXjCjg>
    <xmx:vbr2Y-x1fVAi3V7jl9PXGmxX5OVONwTGO5DmIu8-vMslbLBCqU3-WQ>
    <xmx:vbr2Y2gKK2SvNLr2Z1-n6dPXYLn1_1NxDakok6me_ysG3hwWLX9ulQ>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 20:00:45 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v6 2/4] tools/nolibc: add integer types and integer limit macros
Date:   Wed, 22 Feb 2023 20:00:23 -0500
Message-Id: <20230223010025.11092-3-v@vda.io>
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

