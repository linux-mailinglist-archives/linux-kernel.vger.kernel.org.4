Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBF65124C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiLSS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLSS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:15 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA53625EC;
        Mon, 19 Dec 2022 10:56:14 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJGxnRS027794;
        Mon, 19 Dec 2022 18:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ZN1A0HrLhC7gE2Ru6uZ8/h4BTeTYU2pCBcMg8Fdbf1M=;
 b=l6ztqoicFD/PlYjFoJORxDAR6qC1TmBfzqu/zKpWlV08ffvwExohhNfIV1WWaD2yllJZ
 IoJm/Fo4FfpDTc18EA9IIomh/KhdBaZlrdannE4IV/4BAXKaZjrmuUG0EJfosZLTMnBn
 0ACjSs5UXPX4Fk3sV3xtZ5wZPlOiZL8DdFzuGVkgLkqbVoWVfhf/t4ps20QlPej+sIi3
 KlF4sqqwmTWahr86rKmBQ9xOy38+s9aM8zUaZz/32/s5HnRtzemoUklASSJfccpEyHEm
 QKQrydHm+A2uJ+IXKLdoRFSeGHqJL5dYxb81w1wXaUgKzxBJQ+wBaFGiaMDxr4/VeUSC xw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjuy6gtws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 565643DE30;
        Mon, 19 Dec 2022 18:56:12 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 01EAE8064B6;
        Mon, 19 Dec 2022 18:56:11 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 6/8] crypto: x86/ghash - add kernel-doc comments to assembly
Date:   Mon, 19 Dec 2022 12:55:53 -0600
Message-Id: <20221219185555.433233-7-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZW_p1P_dZ9RqgBr2QXcGnvHbNYeIYPej
X-Proofpoint-GUID: ZW_p1P_dZ9RqgBr2QXcGnvHbNYeIYPej
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
 arch/x86/crypto/ghash-clmulni-intel_asm.S | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 2bf871899920..09cf9271b83a 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -88,7 +88,16 @@ SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	RET
 SYM_FUNC_END(__clmul_gf128mul_ble)
 
-/* void clmul_ghash_mul(char *dst, const u128 *shash) */
+/**
+ * clmul_ghash_mul - Calculate GHASH final multiplication using x86 PCLMULQDQ instructions
+ * @dst:	address of hash value to update (%rdi)
+ * @shash:	address of hash context (%rsi)
+ *
+ * This supports 64-bit CPUs.
+ *
+ * Return:	none (but @dst is updated)
+ * Prototype:	asmlinkage void clmul_ghash_mul(char *dst, const u128 *shash)
+ */
 SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
@@ -102,9 +111,19 @@ SYM_FUNC_START(clmul_ghash_mul)
 	RET
 SYM_FUNC_END(clmul_ghash_mul)
 
-/*
- * void clmul_ghash_update(char *dst, const char *src, unsigned int srclen,
- *			   const u128 *shash);
+/**
+ * clmul_ghash_update - Calculate GHASH using x86 PCLMULQDQ instructions
+ * @dst:	address of hash value to update (%rdi)
+ * @src:	address of data to hash (%rsi)
+ * @srclen:	number of bytes in data buffer (%rdx);
+ *		function does nothing and returns if below 16
+ * @shash:	address of hash context (%rcx)
+ *
+ * This supports 64-bit CPUs.
+ *
+ * Return:	none (but @dst is updated)
+ * Prototype:	asmlinkage clmul_ghash_update(char *dst, const char *src,
+ *					      unsigned int srclen, const u128 *shash);
  */
 SYM_FUNC_START(clmul_ghash_update)
 	FRAME_BEGIN
-- 
2.38.1

