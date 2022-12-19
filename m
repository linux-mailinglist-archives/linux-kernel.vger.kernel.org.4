Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3264651248
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiLSS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLSS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:12 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18B116C;
        Mon, 19 Dec 2022 10:56:11 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJH3euU014446;
        Mon, 19 Dec 2022 18:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=8FA3FxXvzP85Tyc60clcbxamA7EKbj9xp+cOAvqH1Gk=;
 b=BPLigiVU8NBMFX0KpLG5BeBfcgnffivTVuqg2+8h2rmE5GjjZk0IUzXGNjdTz1ewIiH2
 NXx3ysbORClYp4NmhDQDJ52i20/t0b9KpWv7AgvksZXsUZ6z6+LlXtpHsmO+1DBUOJrP
 XoGCJ52omN8oC44qavS/H4/9X0Wcg4RkxO72o+5aIF0ZjqiOk/hx71tk71l6k95y1NyW
 FCyJItmoUgv06fnCmdmMiivkpgoNgQ5Qkau3M8fBoqTNIWH4u4Fv+mVyShf8Jq2ouU4T
 e6D5rYor8k8jWfxjw4UBJOImxXZ1UIbWFXrM/Ge3Xs+5s/+tNo6dFX9GNkgF92Ub+JMJ nQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjv170rv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:09 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8EFE3801716;
        Mon, 19 Dec 2022 18:56:08 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 3C8648064AD;
        Mon, 19 Dec 2022 18:56:08 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 3/8] crypto: x86/sha - add kernel-doc comments to assembly
Date:   Mon, 19 Dec 2022 12:55:50 -0600
Message-Id: <20221219185555.433233-4-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: ELYJj3z1ovArVi_fBVKcgkiPZqaxBw4v
X-Proofpoint-GUID: ELYJj3z1ovArVi_fBVKcgkiPZqaxBw4v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190168
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
 arch/x86/crypto/sha1_ni_asm.S          | 19 ++++++++------
 arch/x86/crypto/sha1_ssse3_asm.S       | 33 +++++++++++++++--------
 arch/x86/crypto/sha256-avx-asm.S       | 23 ++++++++++------
 arch/x86/crypto/sha256-avx2-asm.S      | 24 +++++++++++------
 arch/x86/crypto/sha256-ssse3-asm.S     | 25 +++++++++++-------
 arch/x86/crypto/sha256_ni_asm.S        | 22 +++++++++-------
 arch/x86/crypto/sha512-avx-asm.S       | 33 +++++++++++------------
 arch/x86/crypto/sha512-avx2-asm.S      | 34 ++++++++++++------------
 arch/x86/crypto/sha512-ssse3-asm.S     | 36 ++++++++++++--------------
 10 files changed, 159 insertions(+), 122 deletions(-)

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
index cade913d4882..a69595b033c8 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -72,9 +72,16 @@
 #define MSG3		%xmm6
 #define SHUF_MASK	%xmm7
 
+.text
 
-/*
- * Intel SHA Extensions optimized implementation of a SHA-1 update function
+/**
+ * sha1_ni_transform - Calculate SHA1 hash using the x86 SHA-NI feature set
+ * @digest:	address of current 20-byte hash value (%rdi, DIGEST_PTR macro)
+ * @data:	address of data (%rsi, DATA_PTR macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
  *
  * The function takes a pointer to the current hash values, a pointer to the
  * input data, and a number of 64 byte blocks to process.  Once all blocks have
@@ -86,13 +93,9 @@
  * The indented lines in the loop are instructions related to rounds processing.
  * The non-indented lines are instructions related to the message schedule.
  *
- * void sha1_ni_transform(uint32_t *digest, const void *data,
-		uint32_t numBlocks)
- * digest : pointer to digest
- * data: pointer to input data
- * numBlocks: Number of blocks to process
+ * Return:    none
+ * Prototype: asmlinkage void sha1_ni_transform(u32 *digest, const u8 *data, int blocks)
  */
-.text
 SYM_TYPED_FUNC_START(sha1_ni_transform)
 	push		%rbp
 	mov		%rsp, %rbp
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index f54988c80eb4..1472fe35dfae 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -451,20 +451,24 @@ BSWAP_SHUFB_CTL:
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
 
@@ -546,9 +550,16 @@ W_PRECALC_AVX
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
index 5555b5d5215a..73615c5bbb5f 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -95,9 +95,9 @@ SHUF_00BA = %xmm10      # shuffle xBxA -> 00BA
 SHUF_DC00 = %xmm12      # shuffle xDxC -> DC00
 BYTE_FLIP_MASK = %xmm13
 
-NUM_BLKS = %rdx   # 3rd arg
-INP = %rsi        # 2nd arg
 CTX = %rdi        # 1st arg
+INP = %rsi        # 2nd arg
+NUM_BLKS = %rdx   # 3rd arg
 
 SRND = %rsi       # clobbers INP
 c = %ecx
@@ -340,13 +340,20 @@ a = TMP_
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
 SYM_TYPED_FUNC_START(sha256_transform_avx)
 	pushq   %rbx
 	pushq   %r12
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 3eada9416852..73cbe0322e7d 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -90,9 +90,9 @@ BYTE_FLIP_MASK = %ymm13
 
 X_BYTE_FLIP_MASK = %xmm13 # XMM version of BYTE_FLIP_MASK
 
-NUM_BLKS = %rdx	# 3rd arg
-INP	= %rsi  # 2nd arg
 CTX	= %rdi	# 1st arg
+INP	= %rsi  # 2nd arg
+NUM_BLKS = %rdx	# 3rd arg
 c	= %ecx
 d	= %r8d
 e       = %edx	# clobbers NUM_BLKS
@@ -517,13 +517,21 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 
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
 SYM_TYPED_FUNC_START(sha256_transform_rorx)
 	pushq	%rbx
 	pushq	%r12
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index 959288eecc68..1b2a5bb405a7 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -88,9 +88,9 @@ SHUF_00BA = %xmm10      # shuffle xBxA -> 00BA
 SHUF_DC00 = %xmm11      # shuffle xDxC -> DC00
 BYTE_FLIP_MASK = %xmm12
 
-NUM_BLKS = %rdx   # 3rd arg
-INP = %rsi        # 2nd arg
 CTX = %rdi        # 1st arg
+INP = %rsi        # 2nd arg
+NUM_BLKS = %rdx   # 3rd arg
 
 SRND = %rsi       # clobbers INP
 c = %ecx
@@ -347,15 +347,20 @@ a = TMP_
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
 SYM_TYPED_FUNC_START(sha256_transform_ssse3)
 	pushq   %rbx
 	pushq   %r12
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 537b6dcd7ed8..e7a3b9939327 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -76,8 +76,16 @@
 #define ABEF_SAVE	%xmm9
 #define CDGH_SAVE	%xmm10
 
-/*
- * Intel SHA Extensions optimized implementation of a SHA-256 update function
+.text
+
+/**
+ * sha256_ni_transform - Calculate SHA256 hash using the x86 SHA-NI feature set
+ * @digest:	address of current 32-byte hash value (%rdi, DIGEST_PTR macro)
+ * @data:	address of data (%rsi, DATA_PTR macro);
+ *		data size must be a multiple of 64 bytes
+ * @blocks:	number of 64-byte blocks (%rdx, NUM_BLKS macro)
+ *
+ * This function supports 64-bit CPUs.
  *
  * The function takes a pointer to the current hash values, a pointer to the
  * input data, and a number of 64 byte blocks to process.  Once all blocks have
@@ -89,16 +97,10 @@
  * The indented lines in the loop are instructions related to rounds processing.
  * The non-indented lines are instructions related to the message schedule.
  *
- * void sha256_ni_transform(uint32_t *digest, const void *data,
-		uint32_t numBlocks);
- * digest : pointer to digest
- * data: pointer to input data
- * numBlocks: Number of blocks to process
+ * Return:	none
+ * Prototype:	asmlinkage void sha256_ni_transform(u32 *digest, const u8 *data, int blocks)
  */
-
-.text
 SYM_TYPED_FUNC_START(sha256_ni_transform)
-
 	shl		$6, NUM_BLKS		/*  convert to bytes */
 	jz		.Ldone_hash
 	add		DATA_PTR, NUM_BLKS	/* pointer to end of data */
diff --git a/arch/x86/crypto/sha512-avx-asm.S b/arch/x86/crypto/sha512-avx-asm.S
index b0984f19fdb4..958e355915d0 100644
--- a/arch/x86/crypto/sha512-avx-asm.S
+++ b/arch/x86/crypto/sha512-avx-asm.S
@@ -50,15 +50,10 @@
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
 
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
@@ -266,14 +261,20 @@ frame_size = frame_WK + WK_SIZE
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
 SYM_TYPED_FUNC_START(sha512_transform_avx)
 	test msglen, msglen
 	je nowork
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index b1ca99055ef9..e896b2f54120 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -52,8 +52,6 @@
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
 
-.text
-
 # Virtual Registers
 Y_0 = %ymm4
 Y_1 = %ymm5
@@ -69,13 +67,10 @@ XFER  = YTMP0
 
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
@@ -558,14 +553,21 @@ frame_size = frame_CTX + CTX_SIZE
 
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
 SYM_TYPED_FUNC_START(sha512_transform_rorx)
 	# Save GPRs
 	push	%rbx
diff --git a/arch/x86/crypto/sha512-ssse3-asm.S b/arch/x86/crypto/sha512-ssse3-asm.S
index c06afb5270e5..3bbf164e07fb 100644
--- a/arch/x86/crypto/sha512-ssse3-asm.S
+++ b/arch/x86/crypto/sha512-ssse3-asm.S
@@ -50,15 +50,10 @@
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
 
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
@@ -265,18 +260,21 @@ frame_size = frame_WK + WK_SIZE
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
-SYM_TYPED_FUNC_START(sha512_transform_ssse3)
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
+SYM_TYPED_FUNC_START(sha512_transform_ssse3)
 	test msglen, msglen
 	je nowork
 
-- 
2.38.1

