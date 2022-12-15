Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC364D68A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLOGj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLOGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:39:48 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A95C0C5;
        Wed, 14 Dec 2022 22:39:41 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF4liaK005564;
        Thu, 15 Dec 2022 06:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ZN1A0HrLhC7gE2Ru6uZ8/h4BTeTYU2pCBcMg8Fdbf1M=;
 b=VTvgA5///FHbX9uxTomxhIv5j3irVk3UnS9mVaICLnm44RO+06kvOuUfyLcp3Vc6YQsz
 cQGNiIyaq6x53eCi+1enbn4MqNil7FvudgV26RHznPSL+07dXj4qo/GiEf2GK14JhIGs
 lKyRbeEyJ64IGeIwy5uChp8PMNHFUw/ciXyU8MjSRQB5+JT5lutZ4XxK6OXbGq2En60j
 AHF+KU6DZVw8g0HEyQovX0JvJGPrPw86RjELTurVHzBK9FvyOO0uRuA7ohZQLmuo18JX
 8xVQejvx9rAG130bAKNVT15T+4bymV60Z5AZyAdTcmOQrMJtJn3nzJlN6HNAoOPG0o+2 4A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfvv2gn25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:39:37 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 629EC3DE16;
        Thu, 15 Dec 2022 06:39:36 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 12C6480D280;
        Thu, 15 Dec 2022 06:39:36 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 6/8] crypto: x86/ghash - add kernel-doc comments to assembly
Date:   Thu, 15 Dec 2022 00:38:55 -0600
Message-Id: <20221215063857.161665-7-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215063857.161665-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AniEaMKdIXDfrnRpbu1eRNK-tvRSfTxb
X-Proofpoint-GUID: AniEaMKdIXDfrnRpbu1eRNK-tvRSfTxb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150050
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

