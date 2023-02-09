Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645C68FD35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjBIClU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjBIClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:41:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7387D29405
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:41:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CBFBE320069B;
        Wed,  8 Feb 2023 21:41:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 08 Feb 2023 21:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675910467; x=1675996867; bh=gT
        +nXSzpTrk398bfmLTs8NvceS80Cfg6kc1rubDPw4s=; b=bK9C0xqIk6S88QO/d2
        zUaXoBjAQh2DQClI/XChdA5N7AyFiT5AGQDoqoA/i6T6oHQJe2Z+qlQeRDxAKaN5
        o4/GurkDKDrkVo2kR8smT44O2eomGjuDUisslZzhFv+ZQQzyQjW5IMYS69XbG9Ik
        LGYE5IOFe2UAutpN0H0DlaEeJvI7kwCzkgmJI8wIwtAV+uRbXgzgFCdWxJea7J7g
        sn27eJ6DIQxZe4EUcCzoc/hvGlJP8bvnn4wVw5Yjk0nGkwszCr0STBAWDUD/zrJs
        IPbOB4egxXrmDSOlWXD4u1uX/CMWvr+zg1sXqHnEBWJ2nj0Uo+Gh5QNngSl3I+vi
        HZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1675910467; x=1675996867; bh=gT+nXSzpTrk39
        8bfmLTs8NvceS80Cfg6kc1rubDPw4s=; b=lq14KSlugkFJKCMSsbu6QRME9ip+I
        etbRfQO7eDr7GDow26Zew4CxFtsHDxK1mAcKikocGMdmtEMaLb56JDhMxCSffSM1
        UAjkA7Dj3EehPxgibyI+yQoBvM4DqmUmg3o98+IJPpIHDL2KviWiMGn7Z7Y6KsP7
        QIKG1aiHEb8ybAI3PtMXtldPFaNejNyNccUzEZg3ERZVKqX+a9wq7qTfeuR3pgfU
        OGJZ4jGMjQBzs5HEvScKTUSDe9lb48Ey6WolNmaYh+nQoAM7QuyUeL+d79J8sK84
        u3kRR00jqRbZtrfvT5OD6ckQVLdr4zlw/rWX3WFCFqU6ibsg0EHstf/2w==
X-ME-Sender: <xms:Q13kYyj73I-0B7LgdguUnuC4uoJxTmJziYPwRLmAcoOm4S-eUyk8zA>
    <xme:Q13kYzD8kku983t6Au8jU-_9XdrkS2qd0IEBur3sZj4Rb0ScsPaLjwZMABSOPHH3S
    40ACEhN8PyLvgzNuT4>
X-ME-Received: <xmr:Q13kY6HYyE9OzfS6eRuMVDqtcQWHsRMHrUNINHVbIsgAmKi_OCOq--sY7uX9Y7emAQpySsY3xeKrnVsZnsPwhsut2RXO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepheefveeiveeutdduieevhfejkeehffefje
    efteefheevgfehteeukeehfeelvdfhnecuffhomhgrihhnpehophgvnhhgrhhouhhprdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:Q13kY7ROdAJ-EPS6b0TM3IVk3w_0rDrwpoorSRuW2GnPrhd9d_fvuw>
    <xmx:Q13kY_z-bmxQ2rHB0cXLUqp5kK9juTeinHVczaCZeG7ZFiXnIDB7Ew>
    <xmx:Q13kY56Vj_3xXrRp5oLvKz2mVChKJf9FDH7CKV6NYVHB7tjOlt_Qxw>
    <xmx:Q13kY4r8OtXdzYf-9LusrWtu6XKh0pxBIMWLepzfFEGA0p10Y69q3w>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 21:41:06 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 2/4] tools/nolibc: Adding integer types and integer limit macros
Date:   Wed,  8 Feb 2023 21:40:42 -0500
Message-Id: <20230209024044.13127-3-v@vda.io>
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

This commit adds some of the missing integer types to stdint.h and adds
limit macros (e.g. INTN_{MIN,MAX}).

The reference used for adding these types is
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html.

Note that the maximum size of size_t is implementation-defined (>65535),
in this case I chose to stick with what the kernel uses in
linux/include/uapi/asm-generic/posix_types.h: unsigned int on 32bits and
unsigned long on 64bits.

Signed-off-by: Vincent Dagonneau <v@vda.io>
---
 tools/include/nolibc/stdint.h | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 4ba264031df9..6a7683de09ec 100644
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
+#if __WORDSIZE == 64
+  #define         SIZE_MAX  UINT64_MAX
+  #define       INTPTR_MIN  INT64_MIN
+  #define       INTPTR_MAX  INT64_MAX
+  #define      UINTPTR_MAX  UINT64_MAX
+  #define      PTRDIFF_MIN  INT64_MIN
+  #define      PTRDIFF_MAX  INT64_MAX
+#else
+  #define         SIZE_MAX  UINT32_MAX
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

