Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D164D687
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLOGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLOGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:39:39 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3CD123;
        Wed, 14 Dec 2022 22:39:38 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF4lmth005669;
        Thu, 15 Dec 2022 06:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=f/yAIGZAl21ry5fdIJ+NNAxc3LjIthVSt9fLofKZrdA=;
 b=LfcETOlnoqNV4NHzoin+u5/iCWsMjeyOoObuz17nxHUDHztMIQ8GL3KoccXPqTXD8SJD
 sbu/Aye2Af5j3A3DlIqQU8qZu7jYXso2AZWsk6bOyp8BpPxjgb/aQU4R2f+QuCUDM+tx
 luXRKtQnSlnarwe+9eBBocm3qxL/adH1BzY5y4j27sF4zUwZ/S7//4wnZ6NZhyjvIaCn
 XWUoOcUQXmIeqq20i6/qxQ4e0GTt4EIwJMrB7/uoqfvZ689r1xLjNKdZP9Qnreelmr8Q
 3ZIOgP1YjjNRHDnnY7lZKvFfDaRN7jJelizaHkpeHo4mhTap7PDGL5mh35YwnbEa9vRB nQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfvv2gn1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:39:34 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 938C53DE14;
        Thu, 15 Dec 2022 06:39:33 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 445CC80BE0E;
        Thu, 15 Dec 2022 06:39:33 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 4/8] crypto: x86/crc - add kernel-doc comments to assembly
Date:   Thu, 15 Dec 2022 00:38:53 -0600
Message-Id: <20221215063857.161665-5-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215063857.161665-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AtKHbVl5kjAU14wxznI4BJ2vyVmgfE42
X-Proofpoint-GUID: AtKHbVl5kjAU14wxznI4BJ2vyVmgfE42
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
 arch/x86/crypto/crc32-pclmul_asm.S        | 24 ++++++++++---------
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 29 ++++++++++++++---------
 arch/x86/crypto/crct10dif-pcl-asm_64.S    | 24 +++++++++++++------
 3 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index ca53e96996ac..f704b2067a80 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -17,7 +17,6 @@
 
 #include <linux/linkage.h>
 
-
 .section .rodata
 .align 16
 /*
@@ -67,19 +66,22 @@
 #define CRC     %ecx
 #endif
 
-
-
 .text
 /**
- *      Calculate crc32
- *      BUF - buffer (16 bytes aligned)
- *      LEN - sizeof buffer (16 bytes aligned), LEN should be grater than 63
- *      CRC - initial crc32
- *      return %eax crc32
- *      uint crc32_pclmul_le_16(unsigned char const *buffer,
- *	                     size_t len, uint crc32)
+ * crc32_pclmul_le_16 - Calculate CRC32 using x86 PCLMULQDQ instructions
+ * @buffer:	address of data (32-bit %eax/64-bit %rdi, BUF macro);
+ *		must be aligned to a multiple of 16
+ * @len:	data size (32-bit %edx/64 bit %rsi, LEN macro);
+ *		must be a multiple of 16 and greater than 63
+ * @crc32:	initial CRC32 value (32-bit %ecx/64-bit $edx, CRC macro)
+ *		only uses lower 32 bits
+ *
+ * This function supports both 32-bit and 64-bit CPUs.
+ * It requires data to be aligned and a minimum size.
+ *
+ * Return:	(32-bit %eax/64-bit %rax) CRC32 value (in lower 32 bits)
+ * Prototype:	asmlinkage u32 crc32_pclmul_le_16(const u8 *buffer, size_t len, u32 crc32);
  */
-
 SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
 	movdqa  (BUF), %xmm1
 	movdqa  0x10(BUF), %xmm2
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index ec35915f0901..3d646011d84b 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -70,22 +70,30 @@
 .error "SMALL_ SIZE must be < 256"
 .endif
 
-# unsigned int crc_pcl(u8 *buffer, int len, unsigned int crc_init);
-
 .text
+/**
+ * crc_pcl - Calculate CRC32C using x86 CRC32 and PCLMULQDQ instructions
+ * @buffer:	address of data (%rdi, bufp macro)
+ * @len:	data size (%rsi, len macro)
+ * @crc_init:	initial CRC32C value (%rdx, crc_init_arg macro);
+ *		only using lower 32 bits
+ *
+ * This function supports 64-bit CPUs.
+ * It loops on 8-byte aligned QWORDs, but also supports unaligned
+ * addresses and all length values.
+ *
+ * Return:	CRC32C value (upper 32 bits zero)(%rax)
+ * Prototype:	asmlinkage unsigned int crc_pcl(const u8 *buffer, unsigned int len,
+						unsigned int crc_init);
+ */
 SYM_FUNC_START(crc_pcl)
 #define    bufp		rdi
-#define    bufp_dw	%edi
-#define    bufp_w	%di
-#define    bufp_b	%dil
 #define    bufptmp	%rcx
 #define    block_0	%rcx
 #define    block_1	%rdx
 #define    block_2	%r11
 #define    len		%rsi
 #define    len_dw	%esi
-#define    len_w	%si
-#define    len_b	%sil
 #define    crc_init_arg %rdx
 #define    tmp		%rbx
 #define    crc_init	%r8
@@ -97,7 +105,7 @@ SYM_FUNC_START(crc_pcl)
 	pushq   %rdi
 	pushq   %rsi
 
-	## Move crc_init for Linux to a different
+	## Move crc_init for Linux to a different register
 	mov     crc_init_arg, crc_init
 
 	################################################################
@@ -216,7 +224,7 @@ LABEL crc_ %i
 	## 4) Combine three results:
 	################################################################
 
-	lea	(K_table-8)(%rip), %bufp		# first entry is for idx 1
+	lea	(K_table-8)(%rip), %bufp	# first entry is for idx 1
 	shlq    $3, %rax			# rax *= 8
 	pmovzxdq (%bufp,%rax), %xmm0		# 2 consts: K1:K2
 	leal	(%eax,%eax,2), %eax		# rax *= 3 (total *24)
@@ -326,10 +334,9 @@ JMPTBL_ENTRY %i
 	i=i+1
 .endr
 
-
 	################################################################
 	## PCLMULQDQ tables
-	## Table is 128 entries x 2 words (8 bytes) each
+	## Table is 128 entries x 8 bytes each
 	################################################################
 .align 8
 K_table:
diff --git a/arch/x86/crypto/crct10dif-pcl-asm_64.S b/arch/x86/crypto/crct10dif-pcl-asm_64.S
index 721474abfb71..88af572703b2 100644
--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -52,8 +52,6 @@
 
 #include <linux/linkage.h>
 
-.text
-
 #define		init_crc	%edi
 #define		buf		%rsi
 #define		len		%rdx
@@ -89,11 +87,23 @@
 	xorps	\src_reg, \dst_reg
 .endm
 
-#
-# u16 crc_t10dif_pcl(u16 init_crc, const *u8 buf, size_t len);
-#
-# Assumes len >= 16.
-#
+.text
+/**
+ * crc_t10dif_pcl - Calculate CRC16 per T10 DIF (data integrity format)
+ *		    using x86 PCLMULQDQ instructions
+ * @init_crc:	initial CRC16 value (%rdi, init_crc macro);
+ *		only uses lower 16 bits
+ * @buf:	address of data (%rsi, buf macro);
+ *		data buffer must be at least 16 bytes
+ * @len:	data size (%rdx, len macro);
+ *		must be >= 16
+ *
+ * This function supports 64-bit CPUs.
+ * It allows data to be at any offset.
+ *
+ * Return:	(%rax) CRC16 value (upper 48 bits zero)
+ * Prototype:	asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const *u8 buf, size_t len);
+ */
 .align 16
 SYM_FUNC_START(crc_t10dif_pcl)
 
-- 
2.38.1

