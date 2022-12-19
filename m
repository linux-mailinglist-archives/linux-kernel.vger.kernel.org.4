Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9B65124A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiLSS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiLSS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:14 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6AE63;
        Mon, 19 Dec 2022 10:56:13 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJGxbCb027022;
        Mon, 19 Dec 2022 18:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=z0UViNR6jYf3HtKo8a5Oh8MTYtRH5CfajQaVG91Ish4=;
 b=fcPI4u4Sc3Y0hmSYfBU6YHJ4IIdh+2G4vbjZIFjZnLpylfHz4IFH4O52K1tKg2ZOmrHM
 56RkyhEvSdDoJ3BGX0WFq4oxJewb7qfHlKHj2yHcYSM5yMpXHoHfv3/64Uu2+Y2NxZuv
 u62tBTNrEitUYDJGwrzRRsnRg3Fk36SPP5+R8Yz3tyUCGGUv+fdixhAlewhyl3i+Xd7s
 M+RtaWrKTzU5+q+KmDAJj9UyNx0uJY7WTQGh2Dgbz0+SeUha51TWyLPM3tj/qMgsJE6y
 NpAbMQ7MnlM+Bqhv/ZjABC+IsESYpGPjgtGG+75fxyrXgO++XV8IwUYjktsT81sQSOKy 4g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjuy6gtwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1E7B33109E;
        Mon, 19 Dec 2022 18:56:11 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BA17680649E;
        Mon, 19 Dec 2022 18:56:10 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 5/8] crypto: x86/sm3 - add kernel-doc comments to assembly
Date:   Mon, 19 Dec 2022 12:55:52 -0600
Message-Id: <20221219185555.433233-6-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bgcFWIGC2gDpCTMeO1g4ehUtbfJjhtTI
X-Proofpoint-GUID: bgcFWIGC2gDpCTMeO1g4ehUtbfJjhtTI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc comments for assembly language functions exported to
C glue code.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sm3-avx-asm_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/sm3-avx-asm_64.S b/arch/x86/crypto/sm3-avx-asm_64.S
index 503bab450a91..30e51c681c07 100644
--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@ -322,18 +322,18 @@
 
 .text
 
-/*
- * Transform nblocks*64 bytes (nblocks*16 32-bit words) at DATA.
+/**
+ * sm3_transform_avx - Calculate SM3 hash using x86 AVX feature set
+ * @state:	address of 32-byte context (%rdi, RSTATE macro)
+ * @data:	address of data            (%rsi, RDATA macro);
+ *		must be at least 64 bytes and a multiple of 64 bytes
+ * @nblocks:	number of 64-byte blocks   (%rdx, RNBLKS macro);
+ *		must be >= 1
  *
- * void sm3_transform_avx(struct sm3_state *state,
- *                        const u8 *data, int nblocks);
+ * Return:	none. However, the @state buffer is updated.
+ * Prototype:	asmlinkage void sm3_transform_avx(u32 *state, const u8 *data, int nblocks);
  */
 SYM_TYPED_FUNC_START(sm3_transform_avx)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: data (64*nblks bytes)
-	 *	%rdx: nblocks
-	 */
 	vzeroupper;
 
 	pushq %rbp;
-- 
2.38.1

