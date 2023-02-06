Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5168B3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBFBdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBFBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:33:41 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A847166C9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:33:36 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 875245C0140;
        Sun,  5 Feb 2023 20:33:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 05 Feb 2023 20:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1675647215; x=1675733615; bh=f9
        sG/L1Not5Vf7PbM7l/y4GQBIOVSUACvYMrutDp8/M=; b=L4nycn0yByTVXGcoR/
        FDDgfIw9GI9Zg+rlMBZ+8PLHXmkXhPyuhVW9scT63/u5Z5H3JlGZatRn6YC1zhsi
        jEMGviZ1427NeimeJGDaey1pxcS7PE+M56ONUnhgDRbMYYSEnNGhlN/jwSFbHKWS
        DOQftX5XuwB/r2YFTajzujyY7ZyxPh4bkQqpCceHZl/K+aJ1CpoFHnkrZOkZ5QAB
        Jc1dtBjXGXybHDCovNK3h+lJjsZC9azQBlTjnENvnV+wexim7XI/GZ7mDZ+J4hbg
        4rVKgqY/h2P60LBt+wHLg5vPWBDFht3ulGgBH1d9Rq3nv2xhuFRlsnX7RU1HJ0Zp
        uPsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675647215; x=1675733615; bh=f9sG/L1Not5Vf
        7PbM7l/y4GQBIOVSUACvYMrutDp8/M=; b=Ln6cH8PLdWTboeO+LSAJaNsMlUhgl
        QyTpTJ0wTWggtXe5Py1rHdVNydaJE7USJ3VtLm+pxt2KMy2EGe6XLtLAstX15ELT
        aMqN2MgObWvZcUn9wzMKnODKiUbk24ElslgijMSyUrO8LMLRj6hBit6vrcX/L2Tn
        HpMT6mmhlYTN2NKJevUQoVoic6P5QuXadARZYPnBGr5QnQQaIUQgm8nKZu9tW1bJ
        Z8O+fFv3acRdjJ1bvxRNeqUrJaGtwOg5oLQ+bt7KITkp0nvuzqOf6czTB6DwkIJa
        jN/sZcP7JmNe2hcOf9r2x81kXEmZbYtuIW7lst/Ck5oStt84nMNLEJVyw==
X-ME-Sender: <xms:71jgY1DEiev3RxdInRNwLYZyDMZ6yhLSWdE2twox-7GWY8st9SulXw>
    <xme:71jgYziSvrEILas7sqJDREfIHG_VJyKT4GSUqL8qjzKpc_wDKMK8_Eizw2dhkvjaf
    qMu7e4ZKldxz36jljo>
X-ME-Received: <xmr:71jgYwnqgjjlsZXwCr8LHboLj0lUw7jWI2rI_3Fih5oQFqWO6NpsHAIf1zS1qqywgfoOcFWzo8obXIV42E3AMgXrJiR5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeghedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeggihhntggvnhhtucffrghgohhnnhgvrghuuceovhesvhgu
    rgdrihhoqeenucggtffrrghtthgvrhhnpedujedtgefgtdelffefjeeggffgiefgjeevve
    dtjefhuddvleeiudetuedtffefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:71jgY_wnMYFZ8OqnIKzC8rtHno5xqUAShQp-AtA3oIMSM9DPphKMfQ>
    <xmx:71jgY6QybsxgOjNjvg5I6VrB-RbQSnAr4DuL0tzrvOeM2rCWnlpeZg>
    <xmx:71jgYyaEgXTjzjpzMv4O5DWKT51lTqGDN6zyzs266-C8gZUACsCnVQ>
    <xmx:71jgY9K27pXUrFN1NJcN9N1pZUOdqF93cKX1C3HRboIkLZ-LjqriSg>
Feedback-ID: ic7094478:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Feb 2023 20:33:35 -0500 (EST)
From:   Vincent Dagonneau <v@vda.io>
To:     linux-kernel@vger.kernel.org
Cc:     w@1wt.eu, Vincent Dagonneau <v@vda.io>
Subject: [PATCH v3 4/4] tools/nolibc: Adding tests for the integer limits in stdint.h
Date:   Sun,  5 Feb 2023 20:32:49 -0500
Message-Id: <20230206013248.471664-5-v@vda.io>
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

---
 tools/testing/selftests/nolibc/nolibc-test.c | 39 +++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 725ee66d059c..f43c451c8ca2 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -531,7 +531,44 @@ int run_syscall(int min, int max)
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
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
+#if __WORDSIZE == 64
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
+#else
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+#endif /* __WORDSIZE == 64 */
+			case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
 		}
-- 
2.39.1

