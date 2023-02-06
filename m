Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8168B3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBFBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBFBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:33:36 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA841ADC4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:33:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 775225C012E;
        Sun,  5 Feb 2023 20:33:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 05 Feb 2023 20:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675647212; x=1675733612; bh=2M
        /FZOrWxjfHGOTs/u+tXzvp2U//Imf0DNiIU0PoXIE=; b=G7B4JVYDbn9/G0BGz1
        lI3bpMwjZM9fDtFhM/tR9rBovCAyh887cWTmkBs85AyY7IP90sPpQtBZCp4ndZXd
        GtdZ35XnQyBcQGJb6HhfNJJimbzmSPCh8AwXb+NGAAkU35wiYU+6U1GVZYiiS/tW
        QuKanGqXq9t3F2EZ6lnuPVY8V7igmRCpG+wvmgHw5r9KiVGdST8fR8UmaFyQKy3/
        du70RBav0JKXYRBmLDnnPXEYTj6XoiLUkbBlxm63hoUflUbAUlRDmqcLra+qzTwD
        xVu0QsxEkjv/+kMJ/rE5WAZwflVGersnQxWfW7/dBUMcVHa5XsluteavPxdxZAwx
        YIPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675647212; x=1675733612; bh=2M/FZOrWxjfHG
        OTs/u+tXzvp2U//Imf0DNiIU0PoXIE=; b=b/W96titouLSfFt0MUQ2NLU82sTWh
        aXDVOJPo9KchAmarEwSXTxYsuVWO+fPt+HyIqmxCOm45mYcithETWhoFmSr9L1Y5
        4gQey+xdNdNu/pOM4zsHrXyUbyGZXVdErO2uvsyRjOQwy3WXVl611zsb/CFkmFem
        KGS6EUXhQmb6OzuVubcTRgS8t8ElNAvdbhtXrOu83ROx5kLx+a5ytCanJwSPuZgF
        jVDAaLLVkMR4Yso9/Eqafot1U94y1HDEG0xw7VYOb47gBqWHavJBDeoT2AANhUuy
        Oib7lWUIY9YarrJKw2aAT7MmmjoEbwmwK4PWcyKLtI4+q43hYbtiJq4mQ==
X-ME-Sender: <xms:7FjgY7f9R56XoK_ds_TuDW_oQS9LWcw125fuhJNfQzMDmQNMvRVlbA>
    <xme:7FjgYxONQ_E4WRrdN1JxGncGjUBy9zYS8JjFnQ6J0zb4HyrXUVM4ZbFW1otrD4GzY
    u1apb6im-3TkNXrmF4>
X-ME-Received: <xmr:7FjgY0h7ZumBToEtimS1X2-etYWFhLcGct98i3o2iBvWQBblX1-v58JPAEwwQfXewK2nBN2qMdTpH_ZadjBVLUGCzFDp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeghedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpeehfeevieevuedtudeivefhjeekhefffeejfe
    etfeehvefgheetueekheefledvhfenucffohhmrghinhepohhpvghnghhrohhuphdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvse
    hvuggrrdhioh
X-ME-Proxy: <xmx:7FjgY8-ZqM7rtMH2XxbLlcKhoTwEjlCqPlaB2qcExGcJxvvqetFkqw>
    <xmx:7FjgY3s7EQGonzQjtsc-HlDza3dQBLgsSRoS1r265UdBM-JvXAXcHA>
    <xmx:7FjgY7FxEfCwJTX6ekC0Cz7X-VPbQ3-MOgIqF3PQZyKUYtmrp2vTvQ>
    <xmx:7FjgYwVwhUJ34k4OrI-YIFkwOrA4sTWf0UblO56H8DLSZf9och2M_Q>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Feb 2023 20:33:31 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v3 2/4] tools/nolibc: Adding integer types and integer limit macros
Date:   Sun,  5 Feb 2023 20:32:47 -0500
Message-Id: <20230206013248.471664-3-v@vda.io>
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

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to stick with what the kernel uses in
linux/include/uapi/asm-generic/posix_types.h: unsigned int on 32bits and
unsigned long on 64bits.
---
 tools/include/nolibc/stdint.h | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..e676254d896f 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -21,4 +21,64 @@ typedef unsigned long     uintptr_t;
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
+#define         SIZE_MAX UINT64_MAX
+
+#if __WORDSIZE == 64
+  #define       INTPTR_MIN  INT64_MIN
+  #define       INTPTR_MAX  INT64_MAX
+  #define      UINTPTR_MAX  UINT64_MAX
+  #define      PTRDIFF_MIN  INT64_MIN
+  #define      PTRDIFF_MAX  INT64_MAX
+#else
+  #define       INTPTR_MIN  INT32_MIN
+  #define       INTPTR_MAX  INT32_MAX
+  #define      UINTPTR_MAX  UINT32_MAX
+  #define      PTRDIFF_MIN  INT32_MIN
+  #define      PTRDIFF_MAX  INT32_MAX
+#endif /* __WORDSIZE == 64 */
+
 #endif /* _NOLIBC_STDINT_H */
-- 
2.39.1

