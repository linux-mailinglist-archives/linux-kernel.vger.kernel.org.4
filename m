Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931E64D698
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:44:39 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A112A8;
        Wed, 14 Dec 2022 22:44:37 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF5WNe5008058;
        Thu, 15 Dec 2022 06:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=PYQN3ytuJn0dQs8DSKCI+fAfzyfGVN+yH55pFifcuh4=;
 b=UcfuOmwDUGXCSjZfPDC/5Ot/twdn7oFswRQKZ6wq7nR2Q8vV9jtavqjTmvQpG4iuomdV
 XyFHw87n9sCkNwpEeKHAOdOt4aibfEK1FclDtx2XZi6rB0bLqcRz2xKBCvn8niJOZy19
 bDHeg0kqDEwlhbIRVe1+YFc9PoCy8z7FHK7ZXK4SC7EgZdrt5TdLIxw2rARmSwouOsky
 zIuhrZiALXJm5ygBAPI3NMUMT1KY/Z5yPGZL9HBxanefdPExia+B3a0ayAwPwX7K/fRR
 I4HTt3NG3mbPdq/QLHQ/kp6SCM4jyQ5z0vS3EA7x55W0UVcN6arYHryIA7XIdwEtncfY vA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfvv2gp2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:44:32 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E8C73807135;
        Thu, 15 Dec 2022 06:39:31 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9820880D4AA;
        Thu, 15 Dec 2022 06:39:31 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 3/8] crypto: x86/sha - add kernel-doc comments to assembly
Date:   Thu, 15 Dec 2022 00:38:52 -0600
Message-Id: <20221215063857.161665-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215063857.161665-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: MHi7IOsgq4lX9TIhyrTP89kTrJAO2OdL
X-Proofpoint-GUID: MHi7IOsgq4lX9TIhyrTP89kTrJAO2OdL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_03,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=968 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150051
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

Remove .align directives that are overridden by SYM_FUNC_START
(which includes .align 4).

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/sha1_avx2_x86_64_asm.S | 32 +++++++++++------------
 arch/x86/crypto/sha1_ni_asm.S          | 22 +++++++++-------
 arch/x86/crypto/sha1_ssse3_asm.S       | 33 +++++++++++++++--------
 arch/x86/crypto/sha256-avx-asm.S       | 24 ++++++++++-------
 arch/x86/crypto/sha256-avx2-asm.S      | 25 +++++++++++-------
 arch/x86/crypto/sha256-ssse3-asm.S     | 26 +++++++++++--------
 arch/x86/crypto/sha256_ni_asm.S        | 25 +++++++++---------
 arch/x86/crypto/sha512-avx-asm.S       | 33 +++++++++++------------
 arch/x86/crypto/sha512-avx2-asm.S      | 34 ++++++++++++------------
 arch/x86/crypto/sha512-ssse3-asm.S     | 36 ++++++++++++--------------
 10 files changed, 161 insertions(+), 129 deletions(-)

diff --git a/arch/x86/crypto/sha1_avx2_x86_64_asm.S b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
index a96b2fd26dab..c3ee9334cb0f 100644
--- a/arch/x86/crypto/sha1_avx2_x86_64_asm.S
+++ b/arch/x86/crypto/sha1_avx2_x86_64_asm.S
@@ -62,11 +62,6 @@
  *Visit http://software.intel.com/en-us/articles/
  *and refer to improving-the-performance-of-the-secure-hash-algorithm-1/
  *
- *Updates 20-byte SHA-1 record at start of 'state', from 'input', for
- *even number of 'blocks' consecutive 64-byte blocks.
- *
- *extern "C" void sha1_transform_avx2(
- *	struct sha1_state *state, const u8* input, int blocks );
  */
 
 #include <linux/linkage.h>
@@ -629,13 +624,22 @@ _loop3:
 	_end:
 
 .endm
-/*
- * macro implements SHA-1 function's body for several 64-byte blocks
- * param: function's name
- */
-.macro SHA1_VECTOR_ASM  name
-	SYM_FUNC_START(\name)
 
+.text
+
+/**
+ * sha1_transform_avx2 - Calculate SHA1 hash using the x86 AVX2 feature set
+ * @digest:	address of current 20-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, BUF macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, CNT macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:    none
+ * Prototype: asmlinkage void sha1_transform_avx2(u32 *digest, const u8 *data, int blocks)
+ */
+SYM_FUNC_START(sha1_transform_avx2)
 	push	%rbx
 	push	%r12
 	push	%r13
@@ -675,9 +679,7 @@ _loop3:
 	pop	%rbx
 
 	RET
-
-	SYM_FUNC_END(\name)
-.endm
+SYM_FUNC_END(sha1_transform_avx2)
 
 .section .rodata
 
@@ -706,6 +708,4 @@ BSWAP_SHUFB_CTL:
 	.long 0x04050607
 	.long 0x08090a0b
 	.long 0x0c0d0e0f
-.text
 
-SHA1_VECTOR_ASM     sha1_transform_avx2
diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index 2f94ec0e763b..4aa8507b15b4 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -71,9 +71,16 @@
 #define MSG3		%xmm6
 #define SHUF_MASK	%xmm7
 
+.text
 
-/*
- * Intel SHA Extensions optimized implementation of a SHA-1 update function
+/**
+ * sha1_transform_ni - Calculate SHA1 hash using the x86 SHA-NI feature set
+ * @digest:	address of current 20-byte hash value (%rdi, DIGEST_PTR macro)
+ * @data:	address of data (%rsi, DATA_PTR macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
  *
  * The function takes a pointer to the current hash values, a pointer to the
  * input data, and a number of 64 byte blocks to process.  Once all blocks have
@@ -85,15 +92,10 @@
  * The indented lines in the loop are instructions related to rounds processing.
  * The non-indented lines are instructions related to the message schedule.
  *
- * void sha1_ni_transform(uint32_t *digest, const void *data,
-		uint32_t numBlocks)
- * digest : pointer to digest
- * data: pointer to input data
- * numBlocks: Number of blocks to process
+ * Return:    none
+ * Prototype: asmlinkage void sha1_transform_ni(u32 *digest, const u8 *data, int blocks)
  */
-.text
-.align 32
-SYM_FUNC_START(sha1_ni_transform)
+SYM_FUNC_START(sha1_transform_ni)
 	push		%rbp
 	mov		%rsp, %rbp
 	sub		$FRAME_SIZE, %rsp
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index 263f916362e0..8151a079ba6c 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -450,20 +450,24 @@ BSWAP_SHUFB_CTL:
 	.long 0x0c0d0e0f
 
 
-.section .text
-
 W_PRECALC_SSSE3
 .macro xmm_mov a, b
 	movdqu	\a,\b
 .endm
 
-/*
- * SSSE3 optimized implementation:
+.text
+
+/**
+ * sha1_transform_ssse3 - Calculate SHA1 hash using the x86 SSSE3 feature set
+ * @digest:	address of current 20-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, BUF macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, CNT macro)
  *
- * extern "C" void sha1_transform_ssse3(struct sha1_state *state,
- *					const u8 *data, int blocks);
+ * This function supports 64-bit CPUs.
  *
- * Note that struct sha1_state is assumed to begin with u32 state[5].
+ * Return:	none
+ * Prototype:	asmlinkage void sha1_transform_ssse3(u32 *digest, const u8 *data, int blocks)
  */
 SHA1_VECTOR_ASM     sha1_transform_ssse3
 
@@ -545,9 +549,16 @@ W_PRECALC_AVX
 	vmovdqu	\a,\b
 .endm
 
-
-/* AVX optimized implementation:
- *  extern "C" void sha1_transform_avx(struct sha1_state *state,
- *				       const u8 *data, int blocks);
+/**
+ * sha1_transform_avx - Calculate SHA1 hash using the x86 AVX feature set
+ * @digest:	address of current 20-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, BUF macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, CNT macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void sha1_transform_avx(u32 *digest, const u8 *data, int blocks)
  */
 SHA1_VECTOR_ASM     sha1_transform_avx
diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
index 3baa1ec39097..2a60af20a3ff 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -94,9 +94,9 @@ SHUF_00BA = %xmm10      # shuffle xBxA -> 00BA
 SHUF_DC00 = %xmm12      # shuffle xDxC -> DC00
 BYTE_FLIP_MASK = %xmm13
 
-NUM_BLKS = %rdx   # 3rd arg
-INP = %rsi        # 2nd arg
 CTX = %rdi        # 1st arg
+INP = %rsi        # 2nd arg
+NUM_BLKS = %rdx   # 3rd arg
 
 SRND = %rsi       # clobbers INP
 c = %ecx
@@ -339,15 +339,21 @@ a = TMP_
         ROTATE_ARGS
 .endm
 
-########################################################################
-## void sha256_transform_avx(state sha256_state *state, const u8 *data, int blocks)
-## arg 1 : pointer to state
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
-########################################################################
 .text
+
+/**
+ * sha256_transform_avx - Calculate SHA256 hash using the x86 AVX feature set
+ * @digest:	address of current 32-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, INP macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:    none
+ * Prototype: asmlinkage void sha256_transform_avx(u32 *digest, const u8 *data, int blocks)
+ */
 SYM_FUNC_START(sha256_transform_avx)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 9bcdbc47b8b4..2f2d332f41a4 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -89,9 +89,9 @@ BYTE_FLIP_MASK = %ymm13
 
 X_BYTE_FLIP_MASK = %xmm13 # XMM version of BYTE_FLIP_MASK
 
-NUM_BLKS = %rdx	# 3rd arg
-INP	= %rsi  # 2nd arg
 CTX	= %rdi	# 1st arg
+INP	= %rsi  # 2nd arg
+NUM_BLKS = %rdx	# 3rd arg
 c	= %ecx
 d	= %r8d
 e       = %edx	# clobbers NUM_BLKS
@@ -516,15 +516,22 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 
 .endm
 
-########################################################################
-## void sha256_transform_rorx(struct sha256_state *state, const u8 *data, int blocks)
-## arg 1 : pointer to state
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
-########################################################################
 .text
+
+/**
+ * sha256_transform_rorx - Calculate SHA512 hash using x86 AVX2 feature set
+ *	including the RORX (rotate right logical without affecting flags) instruction
+ * @digest:	address of current 32-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, INP macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void sha256_transform_rorx(u32 *digest, const u8 *data, int blocks)
+ */
 SYM_FUNC_START(sha256_transform_rorx)
-.align 32
 	pushq	%rbx
 	pushq	%r12
 	pushq	%r13
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index c4a5db612c32..087d03fb10e1 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -87,9 +87,9 @@ SHUF_00BA = %xmm10      # shuffle xBxA -> 00BA
 SHUF_DC00 = %xmm11      # shuffle xDxC -> DC00
 BYTE_FLIP_MASK = %xmm12
 
-NUM_BLKS = %rdx   # 3rd arg
-INP = %rsi        # 2nd arg
 CTX = %rdi        # 1st arg
+INP = %rsi        # 2nd arg
+NUM_BLKS = %rdx   # 3rd arg
 
 SRND = %rsi       # clobbers INP
 c = %ecx
@@ -346,17 +346,21 @@ a = TMP_
 	ROTATE_ARGS
 .endm
 
-########################################################################
-## void sha256_transform_ssse3(struct sha256_state *state, const u8 *data,
-##			       int blocks);
-## arg 1 : pointer to state
-##	   (struct sha256_state is assumed to begin with u32 state[8])
-## arg 2 : pointer to input data
-## arg 3 : Num blocks
-########################################################################
 .text
+
+/**
+ * sha256_transform_ssse3 - Calculate SHA256 hash using the x86 SSSE3 feature set
+ * @digest:	address of current 32-byte hash value (%rdi, CTX macro)
+ * @data:	address of data (%rsi, INP macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void sha256_transform_ssse3(u32 *digest, const u8 *data, int blocks)
+ */
 SYM_FUNC_START(sha256_transform_ssse3)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 94d50dd27cb5..a7b3f86cc127 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -75,8 +75,16 @@
 #define ABEF_SAVE	%xmm9
 #define CDGH_SAVE	%xmm10
 
-/*
- * Intel SHA Extensions optimized implementation of a SHA-256 update function
+.text
+
+/**
+ * sha256_transform_ni - Calculate SHA256 hash using the x86 SHA-NI feature set
+ * @digest:	address of current 32-byte hash value (%rdi, DIGEST_PTR macro)
+ * @data:	address of data (%rsi, DATA_PTR macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
  *
  * The function takes a pointer to the current hash values, a pointer to the
  * input data, and a number of 64 byte blocks to process.  Once all blocks have
@@ -88,17 +96,10 @@
  * The indented lines in the loop are instructions related to rounds processing.
  * The non-indented lines are instructions related to the message schedule.
  *
- * void sha256_ni_transform(uint32_t *digest, const void *data,
-		uint32_t numBlocks);
- * digest : pointer to digest
- * data: pointer to input data
- * numBlocks: Number of blocks to process
+ * Return:	none
+ * Prototype:	asmlinkage void sha256_transform_ni(u32 *digest, const u8 *data, int blocks)
  */
-
-.text
-.align 32
-SYM_FUNC_START(sha256_ni_transform)
-
+SYM_FUNC_START(sha256_transform_ni)
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
 	add		DATA_PTR, NUM_BLKS	/* pointer to end of data */
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index 1fefe6dd3a9e..145534a0c6f7 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -49,15 +49,10 @@
 
 #include <linux/linkage.h>
 
-.text
-
 # Virtual Registers
-# ARG1
-digest	= %rdi
-# ARG2
-msg	= %rsi
-# ARG3
-msglen	= %rdx
+digest	= %rdi	# ARG1
+msg	= %rsi	# ARG2
+msglen	= %rdx	# ARG3
 T1	= %rcx
 T2	= %r8
 a_64	= %r9
@@ -265,14 +260,20 @@ frame_size = frame_WK + WK_SIZE
 	RotateState
 .endm
 
-########################################################################
-# void sha512_transform_avx(sha512_state *state, const u8 *data, int blocks)
-# Purpose: Updates the SHA512 digest stored at "state" with the message
-# stored in "data".
-# The size of the message pointed to by "data" must be an integer multiple
-# of SHA512 message blocks.
-# "blocks" is the message length in SHA512 blocks
-########################################################################
+.text
+
+/**
+ * sha512_transform_avx - Calculate SHA512 hash using the x86 AVX feature set
+ * @digest:	address of current 64-byte hash value (%rdi, digest macro)
+ * @data:	address of data (%rsi, msg macro);
+ *		data must be a multiple of 128 bytes
+ * @blocks:	number of 128-byte blocks (%rdx, msglen macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:    none
+ * Prototype: asmlinkage void sha512_transform_avx(u32 *digest, const u8 *data, int blocks)
+ */
 SYM_FUNC_START(sha512_transform_avx)
 	test msglen, msglen
 	je nowork
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index 5cdaab7d6901..bd9e08c8643d 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -51,8 +51,6 @@
 
 #include <linux/linkage.h>
 
-.text
-
 # Virtual Registers
 Y_0 = %ymm4
 Y_1 = %ymm5
@@ -68,13 +66,10 @@ XFER  = YTMP0
 
 BYTE_FLIP_MASK  = %ymm9
 
-# 1st arg is %rdi, which is saved to the stack and accessed later via %r12
-CTX1        = %rdi
+CTX1        = %rdi	# 1st arg, which is saved to the stack and accessed later via %r12
 CTX2        = %r12
-# 2nd arg
-INP         = %rsi
-# 3rd arg
-NUM_BLKS    = %rdx
+INP         = %rsi	# 2nd arg
+NUM_BLKS    = %rdx	# 3rd arg
 
 c           = %rcx
 d           = %r8
@@ -557,14 +552,21 @@ frame_size = frame_CTX + CTX_SIZE
 
 .endm
 
-########################################################################
-# void sha512_transform_rorx(sha512_state *state, const u8 *data, int blocks)
-# Purpose: Updates the SHA512 digest stored at "state" with the message
-# stored in "data".
-# The size of the message pointed to by "data" must be an integer multiple
-# of SHA512 message blocks.
-# "blocks" is the message length in SHA512 blocks
-########################################################################
+.text
+
+/**
+ * sha512_transform_rorx - Calculate SHA512 hash using the x86 AVX2 feature set
+ *	including the RORX (rotate right logical without affecting flags) instruction
+ * @digest:	address of 64-byte hash value (%rdi, CTX1 macro)
+ * @data:	address of data (%rsi, INP macro);
+ *		data must be a multiple of 128 bytes
+ * @blocks:	number of 128-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:    none
+ * Prototype: asmlinkage void sha512_transform_rorx(u32 *digest, const u8 *data, int blocks)
+ */
 SYM_FUNC_START(sha512_transform_rorx)
 	# Save GPRs
 	push	%rbx
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index b84c22e06c5f..cd6a0455d548 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -49,15 +49,10 @@
 
 #include <linux/linkage.h>
 
-.text
-
 # Virtual Registers
-# ARG1
-digest =	%rdi
-# ARG2
-msg =		%rsi
-# ARG3
-msglen =	%rdx
+digest =	%rdi	# ARG1
+msg =		%rsi	# ARG2
+msglen =	%rdx	# ARG3
 T1 =		%rcx
 T2 =		%r8
 a_64 =		%r9
@@ -264,18 +259,21 @@ frame_size = frame_WK + WK_SIZE
 	RotateState
 .endm
 
-########################################################################
-## void sha512_transform_ssse3(struct sha512_state *state, const u8 *data,
-##			       int blocks);
-# (struct sha512_state is assumed to begin with u64 state[8])
-# Purpose: Updates the SHA512 digest stored at "state" with the message
-# stored in "data".
-# The size of the message pointed to by "data" must be an integer multiple
-# of SHA512 message blocks.
-# "blocks" is the message length in SHA512 blocks.
-########################################################################
-SYM_FUNC_START(sha512_transform_ssse3)
+.text
 
+/**
+ * sha512_transform_ssse3 - Calculate SHA512 hash using x86 SSSE3 feature set
+ * @digest:	address of current 64-byte hash value (%rdi, digest macro)
+ * @data:	address of data (%rsi, msg macro);
+ *		data size must be a multiple of 128 bytes
+ * @blocks:	number of 128-byte blocks (%rdx, msglen macro)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:    none
+ * Prototype: asmlinkage void sha512_transform_ssse3(u32 *digest, const u8 *data, int blocks)
+ */
+SYM_FUNC_START(sha512_transform_ssse3)
 	test msglen, msglen
 	je nowork
 
-- 
2.38.1

