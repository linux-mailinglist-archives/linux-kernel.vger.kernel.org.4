Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804446A0062
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjBWBB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjBWBBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:01:48 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB27457D5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:01:20 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 11D0132007F0;
        Wed, 22 Feb 2023 20:00:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Feb 2023 20:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677114049; x=1677200449; bh=ab
        KT3aTwwrOGXGyKonoz3HOOpk6mN9cZoM6FNVaole8=; b=n/7cJt+iVTi5905niG
        0YMev/hWcBijHkU+jUhtxb36kuz8Lu1jN7mkCfRkZYUruVfMuKLjhO+nCfwlGcQH
        jkjoSs17/La8SHQ1MIDlxyKEi4DCM1Coep4kSCBYdG/oJtUwPQsd/smJXsu19w60
        5MndWjzZHlGjZLH+QQJskEesL6ePOKn3n4ui6u27LQVnkSH1QXuYQjDYFvoVFLwx
        VEPUJaOx4IGLciypk7uaWsb0MKO6Xfdwyp7lV29h5jQ+9fQnJc3Oajzemsci22tm
        Nrf9UFlHR7yDRrUzcOPHYb+xgMMSH/7it/xVKOH3Au5EY5xsmfNVIVNHiDVQTFLx
        BhNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677114049; x=1677200449; bh=abKT3aTwwrOGX
        GyKonoz3HOOpk6mN9cZoM6FNVaole8=; b=GPcZ0GfzyziZ/3lFCbBYQIiTF03D9
        0YJc76RVe+I0YiANyps7cr+pyhBxW+JN8YzudTho6qP37kf8E3X/+Usbf2w7Wn8l
        GJgu6Q7SJt+Gw2/jvnUlt9vuSaiZmZCVfE83GQCoI7lqb1/a+pB42rpqOGlZridB
        Br5eMU+0bB1rrqwTRECi5qOfXrXacLNSyjAz9R6iuAg5zt6pv0rk6FYJ2g7etmvb
        F6tpePBq1JQVPC3S+5Ylbwlns/2h0ZZZyIXyVhkTySXZlM07nVz0eZrXgGnLinCH
        49Xeugp5jcOYS1Ip7t1AoNetExznX6M6u5lKsscpHMX6Y1xyte18Q0L8w==
X-ME-Sender: <xms:wbr2Y_sh6tK68un3Spn38cIw-HhqdU5DXdKWPbmhvhXGFqmYdoUw4g>
    <xme:wbr2YwcWkm2Gp_ikhuTtdLhwP_RUmhL-pj8bll3y7e5_ga-jR7rd2hXZkdh-c1BTO
    TATHFKqVJUaLh5qcfc>
X-ME-Received: <xmr:wbr2YywD0j6n77LIhMsHXaZMFvt1j8Q0YC1zAKwWPDhBEAyG7UOzcbq3S6pfLkd_VCKNcxedQEcD_OMtCCDts8jhEfCz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpedujedtgefgtdelffefjeeggffgiefgjeevve
    dtjefhuddvleeiudetuedtffefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:wbr2Y-NNuMfMdYvrvqZ0btoPInuDuJYNpxXM3Cx7gnIBvnDLRtla6Q>
    <xmx:wbr2Y__f-oJSIbaNrs1RbG1UuKVXa4YMfag3BxWSr_j9kkwaCZ_5Dw>
    <xmx:wbr2Y-UVC0w45syUywPfLwESvK0NB38zRdLdyDT3PtF_vxxfx4veUg>
    <xmx:wbr2Y5kSSJHnYjMJSAdoIJeyFMousocrGw6YtrwLoA-sS02dGRFPnQ>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 20:00:49 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v6 4/4] tools/nolibc: add tests for the integer limits in stdint.h
Date:   Wed, 22 Feb 2023 20:00:25 -0500
Message-Id: <20230223010025.11092-5-v@vda.io>
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

This commit adds tests for the limits added in a previous commit. The
limits are defined in decimal in stdint.h and as hexadecimal in the
tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some of the
most egregious mistakes.

As we rely on the compiler to provide __SIZEOF_LONG__, we also test
whether it is defined.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 882140508d56..d6886f900e79 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -561,6 +561,59 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,         (int8_t)          0x7f); break;
+		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,         (int8_t)          0x80); break;
+		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,        (uint8_t)         0xff); break;
+		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,        (int16_t)         0x7fff); break;
+		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,        (int16_t)         0x8000); break;
+		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX,       (uint16_t)        0xffff); break;
+		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,        (int32_t)         0x7fffffff); break;
+		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,        (int32_t)         0x80000000); break;
+		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX,       (uint32_t)        0xffffffff); break;
+		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,        (int64_t)         0x7fffffffffffffff); break;
+		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,        (int64_t)         0x8000000000000000); break;
+		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX,       (uint64_t)        0xffffffffffffffff); break;
+		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
+		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
+		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
+		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
+		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
+		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
+		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
+		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
+		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
+		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX,    (int_fast8_t)     0x7f); break;
+		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN,    (int_fast8_t)     0x80); break;
+		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,   (uint_fast8_t)    0xff); break;
+		CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINTPTR_MAX); break;
+#if __SIZEOF_LONG__ == 8
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffffffffffULL); break;
+#elif __SIZEOF_LONG__ == 4
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x80000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffff); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffU); break;
+#else
+# warning "__SIZEOF_LONG__ is undefined"
+#endif /* __SIZEOF_LONG__ */
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.39.2

