Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D865124F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiLSS5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiLSS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:22 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9058264D;
        Mon, 19 Dec 2022 10:56:17 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJH3eE0014442;
        Mon, 19 Dec 2022 18:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=IJh7WEYxyt2LrgouyYo+ovdw+Y2aJpHTxe4DsSblkuA=;
 b=ku3eZm2llxIgEmCXQ88zUqgbZb7seweRnPVTJUBDolLhvz6sWBiOCIP4hRhhFdRgp6wS
 e4FXhEE5Va2mU2Ns1GBi3B4Tf1vL1lJ7N9qKpYZpJlUbQEZ3UAwt4bNhXw1m3fzd4ffT
 gEFNTNihIviVpQ74Z2R0Bpn3v3zn9Zob1rZANjg5OiQSRxqwlXYExWMg46bRVzKvfcQw
 EE0eTcdneUG26QKkpMsTqEbi2V224chXA3dy0tcfwjMyDV7FMH4mKLRqcv2h84pZjvSt
 qPtb1e9/rIlsam4oy7QQpdLfKB7qXJWU4gvzxoL2soH57NCepkrbNy7KoXnYpAM7Xb/b TQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjv170rvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:15 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BBDCF807122;
        Mon, 19 Dec 2022 18:56:14 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6AC358064AD;
        Mon, 19 Dec 2022 18:56:14 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 8/8] crypto: x86/chacha - add kernel-doc comments to assembly
Date:   Mon, 19 Dec 2022 12:55:55 -0600
Message-Id: <20221219185555.433233-9-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3a4WsJCDQ_jYkFaBiyCNr1VA5FUx6oIm
X-Proofpoint-GUID: 3a4WsJCDQ_jYkFaBiyCNr1VA5FUx6oIm
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

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/chacha-avx2-x86_64.S     | 90 +++++++++++++++--------
 arch/x86/crypto/chacha-avx512vl-x86_64.S | 94 +++++++++++++++---------
 arch/x86/crypto/chacha-ssse3-x86_64.S    | 75 ++++++++++++-------
 3 files changed, 170 insertions(+), 89 deletions(-)

diff --git a/arch/x86/crypto/chacha-avx2-x86_64.S b/arch/x86/crypto/chacha-avx2-x86_64.S
index f3d8fc018249..5ebced6f32c3 100644
--- a/arch/x86/crypto/chacha-avx2-x86_64.S
+++ b/arch/x86/crypto/chacha-avx2-x86_64.S
@@ -34,18 +34,26 @@ CTR4BL:	.octa 0x00000000000000000000000000000002
 
 .text
 
+/**
+ * chacha_2block_xor_avx2 - Encrypt 2 blocks using the x86 AVX2 feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 2 data blocks output, o (%rsi)
+ * @src:	address of up to 2 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts two ChaCha blocks by loading the state
+ * matrix twice across four AVX registers. It performs matrix operations
+ * on four words in each matrix in parallel, but requires shuffling to
+ * rearrange the words after each round.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_2block_xor_avx2(u32 *state, u8 *dst, const u8 *src,
+ *						       unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_2block_xor_avx2)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 2 data blocks output, o
-	# %rdx: up to 2 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts two ChaCha blocks by loading the state
-	# matrix twice across four AVX registers. It performs matrix operations
-	# on four words in each matrix in parallel, but requires shuffling to
-	# rearrange the words after each round.
-
 	vzeroupper
 
 	# x0..3[0-2] = s0..3
@@ -226,20 +234,28 @@ SYM_FUNC_START(chacha_2block_xor_avx2)
 
 SYM_FUNC_END(chacha_2block_xor_avx2)
 
+/**
+ * chacha_4block_xor_avx2 - Encrypt 4 blocks using the x86 AVX2 feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 4 data blocks output, o (%rsi)
+ * @src:	address of up to 4 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts four ChaCha blocks by loading the state
+ * matrix four times across eight AVX registers. It performs matrix
+ * operations on four words in two matrices in parallel, sequentially
+ * to the operations on the four words of the other two matrices. The
+ * required word shuffling has a rather high latency, we can do the
+ * arithmetic on two matrix-pairs without much slowdown.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_4block_xor_avx2(u32 *state, u8 *dst, const u8 *src,
+ *						       unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_4block_xor_avx2)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 4 data blocks output, o
-	# %rdx: up to 4 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts four ChaCha blocks by loading the state
-	# matrix four times across eight AVX registers. It performs matrix
-	# operations on four words in two matrices in parallel, sequentially
-	# to the operations on the four words of the other two matrices. The
-	# required word shuffling has a rather high latency, we can do the
-	# arithmetic on two matrix-pairs without much slowdown.
-
 	vzeroupper
 
 	# x0..3[0-4] = s0..3
@@ -531,12 +547,28 @@ SYM_FUNC_START(chacha_4block_xor_avx2)
 
 SYM_FUNC_END(chacha_4block_xor_avx2)
 
+/**
+ * chacha_8block_xor_avx2 - Encrypt 8 blocks using the x86 AVX2 feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 8 data blocks output, o (%rsi)
+ * @src:	address of up to 8 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts four ChaCha blocks by loading the state
+ * matrix four times across eight AVX registers. It performs matrix
+ * operations on four words in two matrices in parallel, sequentially
+ * to the operations on the four words of the other two matrices. The
+ * required word shuffling has a rather high latency, we can do the
+ * arithmetic on two matrix-pairs without much slowdown.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_8block_xor_avx2(u32 *state, u8 *dst, const u8 *src,
+ *						       unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_8block_xor_avx2)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 8 data blocks output, o
-	# %rdx: up to 8 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
 
 	# This function encrypts eight consecutive ChaCha blocks by loading
 	# the state matrix in AVX registers eight times. As we need some
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/crypto/chacha-avx512vl-x86_64.S
index 259383e1ad44..b4a85365e164 100644
--- a/arch/x86/crypto/chacha-avx512vl-x86_64.S
+++ b/arch/x86/crypto/chacha-avx512vl-x86_64.S
@@ -24,18 +24,26 @@ CTR8BL:	.octa 0x00000003000000020000000100000000
 
 .text
 
+/**
+ * chacha_2block_xor_avx512vl - Encrypt 2 blocks using the x86 AVX512VL feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 2 data blocks output, o (%rsi)
+ * @src:	address of up to 2 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts two ChaCha blocks by loading the state
+ * matrix twice across four AVX registers. It performs matrix operations
+ * on four words in each matrix in parallel, but requires shuffling to
+ * rearrange the words after each round.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_2block_xor_avx512vl(u32 *state, u8 *dst, const u8 *src,
+ *							   unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_2block_xor_avx512vl)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 2 data blocks output, o
-	# %rdx: up to 2 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts two ChaCha blocks by loading the state
-	# matrix twice across four AVX registers. It performs matrix operations
-	# on four words in each matrix in parallel, but requires shuffling to
-	# rearrange the words after each round.
-
 	vzeroupper
 
 	# x0..3[0-2] = s0..3
@@ -189,20 +197,28 @@ SYM_FUNC_START(chacha_2block_xor_avx512vl)
 
 SYM_FUNC_END(chacha_2block_xor_avx512vl)
 
+/**
+ * chacha_4block_xor_avx512vl - Encrypt 4 blocks using the x86 AVX512VL feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 4 data blocks output, o (%rsi)
+ * @src:	address of up to 4 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts four ChaCha blocks by loading the state
+ * matrix four times across eight AVX registers. It performs matrix
+ * operations on four words in two matrices in parallel, sequentially
+ * to the operations on the four words of the other two matrices. The
+ * required word shuffling has a rather high latency, we can do the
+ * arithmetic on two matrix-pairs without much slowdown.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_4block_xor_avx512vl(u32 *state, u8 *dst, const u8 *src,
+ *							   unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_4block_xor_avx512vl)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 4 data blocks output, o
-	# %rdx: up to 4 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts four ChaCha blocks by loading the state
-	# matrix four times across eight AVX registers. It performs matrix
-	# operations on four words in two matrices in parallel, sequentially
-	# to the operations on the four words of the other two matrices. The
-	# required word shuffling has a rather high latency, we can do the
-	# arithmetic on two matrix-pairs without much slowdown.
-
 	vzeroupper
 
 	# x0..3[0-4] = s0..3
@@ -455,18 +471,26 @@ SYM_FUNC_START(chacha_4block_xor_avx512vl)
 
 SYM_FUNC_END(chacha_4block_xor_avx512vl)
 
+/**
+ * chacha_8block_xor_avx512vl - Encrypt 8 blocks using the x86 AVX512VL feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 8 data blocks output, o (%rsi)
+ * @src:	address of up to 8 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts eight consecutive ChaCha blocks by loading
+ * the state matrix in AVX registers eight times. Compared to AVX2, this
+ * mostly benefits from the new rotate instructions in VL and the
+ * additional registers.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_8block_xor_avx512vl(u32 *state, u8 *dst, const u8 *src,
+ *							   unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_8block_xor_avx512vl)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 8 data blocks output, o
-	# %rdx: up to 8 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts eight consecutive ChaCha blocks by loading
-	# the state matrix in AVX registers eight times. Compared to AVX2, this
-	# mostly benefits from the new rotate instructions in VL and the
-	# additional registers.
-
 	vzeroupper
 
 	# x0..15[0-7] = s[0..15]
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/crypto/chacha-ssse3-x86_64.S
index 7111949cd5b9..6f5395ba54ab 100644
--- a/arch/x86/crypto/chacha-ssse3-x86_64.S
+++ b/arch/x86/crypto/chacha-ssse3-x86_64.S
@@ -34,7 +34,6 @@ CTRINC:	.octa 0x00000003000000020000000100000000
  * Clobbers: %r8d, %xmm4-%xmm7
  */
 SYM_FUNC_START_LOCAL(chacha_permute)
-
 	movdqa		ROT8(%rip),%xmm4
 	movdqa		ROT16(%rip),%xmm5
 
@@ -111,12 +110,21 @@ SYM_FUNC_START_LOCAL(chacha_permute)
 	RET
 SYM_FUNC_END(chacha_permute)
 
+/**
+ * chacha_block_xor_ssse3 - Encrypt 1 block using the x86 SSSE3 feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 1 data block output, o (%rsi)
+ * @src:	address of up to 1 data block input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
+ *						       unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_block_xor_ssse3)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 1 data block output, o
-	# %rdx: up to 1 data block input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
 	FRAME_BEGIN
 
 	# x0..3 = s0..3
@@ -199,10 +207,19 @@ SYM_FUNC_START(chacha_block_xor_ssse3)
 
 SYM_FUNC_END(chacha_block_xor_ssse3)
 
+/**
+ * hchacha_block_ssse3 - Encrypt 1 block using the x86 SSSE3 feature set
+ * @state:	address of input state matrix, s (%rdu)
+ * @out:	address of output (8 32-bit words)(%rsi)
+ * @nrounds:	number of rounds (%edx);
+ *		only uses lower 32 bits
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void hchacha_block_ssse3(const u32 *state, u32 *out, int nrounds);
+ */
 SYM_FUNC_START(hchacha_block_ssse3)
-	# %rdi: Input state matrix, s
-	# %rsi: output (8 32-bit words)
-	# %edx: nrounds
 	FRAME_BEGIN
 
 	movdqu		0x00(%rdi),%xmm0
@@ -220,23 +237,31 @@ SYM_FUNC_START(hchacha_block_ssse3)
 	RET
 SYM_FUNC_END(hchacha_block_ssse3)
 
+/**
+ * chacha_4block_xor_ssse3 - Encrypt 4 blocks using the x86 SSSE3 feature set
+ * @state:	address of input state matrix, s (%rdi)
+ * @dst:	address of up to 4 data blocks output, o (%rsi)
+ * @src:	address of up to 4 data blocks input, i (%rdx)
+ * @len:	input/output length in bytes (%rcx)
+ * @nrounds:	number of rounds (%r8d)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * This function encrypts four consecutive ChaCha blocks by loading the
+ * state matrix in SSE registers four times. As we need some scratch
+ * registers, we save the first four registers on the stack. The
+ * algorithm performs each operation on the corresponding word of each
+ * state matrix, hence requires no word shuffling. For final XORing step
+ * we transpose the matrix by interleaving 32- and then 64-bit words,
+ * which allows us to do XOR in SSE registers. 8/16-bit word rotation is
+ * done with the slightly better performing SSSE3 byte shuffling,
+ * 7/12-bit word rotation uses traditional shift+OR.
+ *
+ * Return:	none
+ * Prototype:	asmlinkage void chacha_4block_xor_ssse3(u32 *state, u8 *dst, const u8 *src,
+ *							unsigned int len, int nrounds);
+ */
 SYM_FUNC_START(chacha_4block_xor_ssse3)
-	# %rdi: Input state matrix, s
-	# %rsi: up to 4 data blocks output, o
-	# %rdx: up to 4 data blocks input, i
-	# %rcx: input/output length in bytes
-	# %r8d: nrounds
-
-	# This function encrypts four consecutive ChaCha blocks by loading the
-	# the state matrix in SSE registers four times. As we need some scratch
-	# registers, we save the first four registers on the stack. The
-	# algorithm performs each operation on the corresponding word of each
-	# state matrix, hence requires no word shuffling. For final XORing step
-	# we transpose the matrix by interleaving 32- and then 64-bit words,
-	# which allows us to do XOR in SSE registers. 8/16-bit word rotation is
-	# done with the slightly better performing SSSE3 byte shuffling,
-	# 7/12-bit word rotation uses traditional shift+OR.
-
 	lea		8(%rsp),%r10
 	sub		$0x80,%rsp
 	and		$~63,%rsp
-- 
2.38.1

