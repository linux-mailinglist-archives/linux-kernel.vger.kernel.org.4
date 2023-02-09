Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2800368FD3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBIClx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjBIClO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:41:14 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEFF21281
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:41:12 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 39F8E32008C3;
        Wed,  8 Feb 2023 21:41:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Feb 2023 21:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675910471; x=1675996871; bh=IW
        DKlKAM5eHYv1H7n1SgCgH/XR1le5l+AGXB0eyH/SA=; b=NmDLx946RamSAKB4vc
        joCBab/yF6Gmv6Xa6+/jnrYcg7abXCWOOd/JxOr+wCbSXPMIpRvS4gnn0D9XZBpH
        T8jJaV905ElP8q6I4ejynA4Bfx4OYzIqScUy14JKfXiADz8HzkedPN3FK3g0BC7p
        0NoygOFk2H3NnF38OZ8vNMHkgv/DHyWcCBAHIZ9h6pi7lvAoLwE4rh6GkzmraKj6
        85ETf9T0OhW7ldrF522Ud1vsW8LdQBNrcjNJyuduvyhb/25GzEGccvCS3pV+fBWt
        V6FGgWKuZYG6OThLR5P370JFQHeZbAlncr1h/7wIpYHY9+W/h7MQ/iLDGFIaNF3K
        wbGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1675910471; x=1675996871; bh=IWDKlKAM5eHYv
        1H7n1SgCgH/XR1le5l+AGXB0eyH/SA=; b=Jx6R4xMo2TkIMUqTvzEhweEhpc8m2
        2p9/1RCofVX8nDeOhkWybpyvWeO4XTxB8mFlbUf/ehIXW0MkjypRQaFIzDhPMdzQ
        FCzC5TV/dAmISsAQxZiT80o8+61eSbxnzv40+cHfPIuf4SXLWUStiTInwOSRkQPX
        fG5OxbNHJ6eq5CqQxiCF5vFckg/RZ0Ot8MbP75lKMiURRJssuPRxBl7Kja6+QvjH
        F+uKXZk14M3T3s4bw2okQ3urUfVVKPIvifFB13pBxcIJNKd1lghddVZKBjM8DgAi
        vdTIR4JLTqENBDusGa8nvHf1BdiUilVC3PNoyRVlqVq9t/tqVZLJGUNyA==
X-ME-Sender: <xms:R13kY0ieZB1bkOroMed8kM5ZU8XiOTBsEXko5v06RrRSA322zt1jGA>
    <xme:R13kY9AwYoyLqzLmRfrgehbD5LHDVxyJNafpLNzApWsjc0ZFMb02txdSzY4Rx5-ai
    cylHeZ5vqLT8jRoavA>
X-ME-Received: <xmr:R13kY8EAylQMYa3-fU3FzpY1aWDymbnT4V4E0LuEzL3xZVv6g4pUjbCcWZNiM4HczQseV7Sxb1Yd2ALifaSDTcxSEpsq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepgghinhgtvghnthcuffgrghhonhhnvggruhcuoehvsehv
    uggrrdhioheqnecuggftrfgrthhtvghrnhepudejtdeggfdtlefffeejgefggfeigfejve
    evtdejhfduvdelieduteeutdfffeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepvhesvhgurgdrihho
X-ME-Proxy: <xmx:R13kY1Qkf-u1RZKMU2wqNvEGwNLbM-_W68QRs8O_X05FNdUPGLatwQ>
    <xmx:R13kYxy0eRHAl3n1T9BWUQis5xHa43SnIwd91EBS4dv0nvcNLLKTKg>
    <xmx:R13kYz50WZsTO1a_3py4xAo1fqMGhoZYqG7WkCwVDvrx4w0lU0qJ9w>
    <xmx:R13kYyrmbtqFCF5ZpSEMEdTzs14busZPZCgRAMRZafJAlKb7XbWf2g>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 21:41:11 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v4 4/4] tools/nolibc: Adds tests for the integer limits in stdint.h
Date:   Wed,  8 Feb 2023 21:40:44 -0500
Message-Id: <20230209024044.13127-5-v@vda.io>
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

This commit adds tests for the limits added in a previous commit. The
limits are defined in decimal in stdint.h and as hexadecimal in the
tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some o the
most egregious mistakes.

Signed-off-by: Vincent Dagonneau <v@vda.io>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 43 +++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 725ee66d059c..bcd0a4012a17 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -531,7 +531,48 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
-		case __LINE__:
+		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8_t)   0x7f); break;
+		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8_t)   0x80); break;
+		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint8_t)  0xff); break;
+		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int16_t)  0x7fff); break;
+		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int16_t)  0x8000); break;
+		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint16_t) 0xffff); break;
+		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int32_t)  0x7fffffff); break;
+		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int32_t)  0x80000000); break;
+		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint32_t) 0xffffffff); break;
+		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int64_t)  0x7fffffffffffffff); break;
+		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int64_t)  0x8000000000000000); break;
+		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint64_t) 0xffffffffffffffff); break;
+		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
+		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
+		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
+		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
+		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
+		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
+		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
+		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
+		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
+#if __WORDSIZE == 64
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
+#else
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
+#endif /* __WORDSIZE == 64 */
+			case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
 		}
-- 
2.39.1

