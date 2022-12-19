Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71765123E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiLSS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiLSS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:12 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DFFE63;
        Mon, 19 Dec 2022 10:56:09 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJH00AA028051;
        Mon, 19 Dec 2022 18:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=MJlOfE47OEK7Nr+TCmJks+g4mTnzxIIzTO+0fssVP0Q=;
 b=ZXJAvgordKbg3K5Tb3c2PNC2/vRj81pS7iZB+/HT66g+BuOyiIEN2ZttI/r/wBGuTPPr
 KM/Q/g+HBZpOcUDSss+zyVCXEXmO8Wf1L95XQLkf34SVNlRMUjCHaA+1lmAueApbF03x
 VYEp+T/ZXFPuN6FNtrLbIJgAGKX+niiMpv414XpIFqF0agM52dxAqswaPH94qa0r9hi2
 gmMDDWQwoTRr40trnsVBM0o5t4qb6a0rvVe7/2KuvAgXK7SGdoZoELVrhnl3MtRDXRLe
 agvmtQMAWQQ7ecmKFVjERjPVQ0Dsyi4IaIPMrR86IC3oMpyUTDHgUEJyiI4sAxGKTWus Fg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mjuy6gtw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:06 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 36B393DE38;
        Mon, 19 Dec 2022 18:56:06 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id DC0FE80576E;
        Mon, 19 Dec 2022 18:56:05 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 1/8] crypto: clean up kernel-doc headers
Date:   Mon, 19 Dec 2022 12:55:48 -0600
Message-Id: <20221219185555.433233-2-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LmiWIBayCUGeBLZKt55bA_vs9ga5R1b6
X-Proofpoint-GUID: LmiWIBayCUGeBLZKt55bA_vs9ga5R1b6
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

Fix these problems in the kernel-doc function header comments, as
reported by running:
	scripts/kernel-doc -man \
		$(git grep -l '/\*\*' -- :^Documentation :^tools) \
		| scripts/split-man.pl /tmp/man 2> err.log
	cat err.log | grep crypto | grep -v drivers

arch/mips/cavium-octeon/crypto/octeon-crypto.c:18: warning: This comment starts with '/**', but isn't a kernel-doc comment.
arch/mips/cavium-octeon/crypto/octeon-crypto.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment.
arch/mips/cavium-octeon/crypto/octeon-crypto.c:60: warning: Function parameter or member 'crypto_flags' not described in 'octeon_crypto_disable'
arch/mips/cavium-octeon/crypto/octeon-crypto.c:60: warning: Excess function parameter 'flags' description in 'octeon_crypto_disable'

crypto/asymmetric_keys/verify_pefile.c:420: warning: Function parameter or member 'trusted_keys' not described in 'verify_pefile_signature'
crypto/asymmetric_keys/verify_pefile.c:420: warning: Excess function parameter 'trust_keys' description in 'verify_pefile_signature'

crypto/async_tx/async_pq.c:19: warning: cannot understand function prototype: 'struct page *pq_scribble_page; '
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'chan' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'scfs' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'disks' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'unmap' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'dma_flags' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:40: warning: Function parameter or member 'submit' not described in 'do_async_gen_syndrome'
crypto/async_tx/async_pq.c:109: warning: Function parameter or member 'blocks' not described in 'do_sync_gen_syndrome'
crypto/async_tx/async_pq.c:109: warning: Function parameter or member 'offsets' not described in 'do_sync_gen_syndrome'
crypto/async_tx/async_pq.c:109: warning: Function parameter or member 'disks' not described in 'do_sync_gen_syndrome'
crypto/async_tx/async_pq.c:109: warning: Function parameter or member 'len' not described in 'do_sync_gen_syndrome'
crypto/async_tx/async_pq.c:109: warning: Function parameter or member 'submit' not described in 'do_sync_gen_syndrome'
crypto/async_tx/async_pq.c:302: warning: Excess function parameter 'offset' description in 'async_syndrome_val'

crypto/async_tx/async_tx.c:137: warning: cannot understand function prototype: 'enum submit_disposition '
crypto/async_tx/async_tx.c:265: warning: Function parameter or member 'tx' not described in 'async_tx_quiesce'

crypto/crypto_engine.c:514: warning: Excess function parameter 'engine' description in 'crypto_engine_alloc_init_and_set'

include/crypto/acompress.h:219: warning: Function parameter or member 'cmpl' not described in 'acomp_request_set_callback'
include/crypto/acompress.h:219: warning: Excess function parameter 'cmlp' description in 'acomp_request_set_callback'

include/crypto/des.h:43: warning: Function parameter or member 'keylen' not described in 'des_expand_key'
include/crypto/des.h:43: warning: Excess function parameter 'len' description in 'des_expand_key'
include/crypto/des.h:56: warning: Function parameter or member 'keylen' not described in 'des3_ede_expand_key'
include/crypto/des.h:56: warning: Excess function parameter 'len' description in 'des3_ede_expand_key'

include/crypto/if_alg.h:160: warning: Function parameter or member 'wait' not described in 'af_alg_ctx'
include/crypto/if_alg.h:178: warning: This comment starts with '/**', but isn't a kernel-doc comment.
include/crypto/if_alg.h:193: warning: This comment starts with '/**', but isn't a kernel-doc comment.
include/crypto/if_alg.h:204: warning: This comment starts with '/**', but isn't a kernel-doc comment.
include/crypto/if_alg.h:219: warning: This comment starts with '/**', but isn't a kernel-doc comment.
include/crypto/if_alg.h:184: warning: Function parameter or member 'sk' not described in 'af_alg_sndbuf'
include/crypto/if_alg.h:199: warning: Function parameter or member 'sk' not described in 'af_alg_writable'
include/crypto/if_alg.h:210: warning: Function parameter or member 'sk' not described in 'af_alg_rcvbuf'
include/crypto/if_alg.h:225: warning: Function parameter or member 'sk' not described in 'af_alg_readable'

include/crypto/internal/ecc.h:85: warning: Function parameter or member 'privkey' not described in 'ecc_gen_privkey'
include/crypto/internal/ecc.h:85: warning: Excess function parameter 'private_key' description in 'ecc_gen_privkey'
include/crypto/internal/ecc.h:184: warning: Function parameter or member 'right' not described in 'vli_sub'
include/crypto/internal/ecc.h:246: warning: expecting prototype for ecc_aloc_point(). Prototype was for ecc_alloc_point() instead
include/crypto/internal/ecc.h:262: warning: Function parameter or member 'point' not described in 'ecc_point_is_zero'
include/crypto/internal/ecc.h:262: warning: Excess function parameter 'p' description in 'ecc_point_is_zero'

include/crypto/internal/rsa.h:32: warning: cannot understand function prototype: 'struct rsa_key '

include/crypto/kdf_sp800108.h:34: warning: Function parameter or member 'kmd' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:34: warning: Function parameter or member 'info' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:34: warning: Function parameter or member 'info_nvec' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:34: warning: Function parameter or member 'dst' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:34: warning: Function parameter or member 'dlen' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:34: warning: expecting prototype for Counter KDF generate operation according to SP800(). Prototype was for crypto_kdf108_ctr_generate() instead
include/crypto/kdf_sp800108.h:37: warning: This comment starts with '/**', but isn't a kernel-doc comment.
include/crypto/kdf_sp800108.h:37: warning: Function parameter or member 'info_nvec' not described in 'crypto_kdf108_ctr_generate'
include/crypto/kdf_sp800108.h:37: warning: Excess function parameter 'info_vec' description in 'crypto_kdf108_ctr_generate'

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 .../mips/cavium-octeon/crypto/octeon-crypto.c | 19 ++++-----
 crypto/asymmetric_keys/verify_pefile.c        |  2 +-
 crypto/async_tx/async_pq.c                    | 11 +++---
 crypto/async_tx/async_tx.c                    |  4 +-
 crypto/crypto_engine.c                        |  2 +-
 include/crypto/acompress.h                    |  2 +-
 include/crypto/des.h                          |  4 +-
 include/crypto/if_alg.h                       | 26 ++++++-------
 include/crypto/internal/ecc.h                 |  8 ++--
 include/crypto/internal/rsa.h                 |  2 +-
 include/crypto/kdf_sp800108.h                 | 39 +++++++++++--------
 11 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
index cfb4a146cf17..c4badbf756b5 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -14,10 +14,11 @@
 #include "octeon-crypto.h"
 
 /**
- * Enable access to Octeon's COP2 crypto hardware for kernel use. Wrap any
- * crypto operations in calls to octeon_crypto_enable/disable in order to make
- * sure the state of COP2 isn't corrupted if userspace is also performing
- * hardware crypto operations. Allocate the state parameter on the stack.
+ * octeon_crypto_enable - Enable access to Octeon's COP2 crypto hardware for kernel use.
+ * Wrap any crypto operations in calls to octeon_crypto_enable/disable
+ * in order to make sure the state of COP2 isn't corrupted if userspace
+ * is also performing hardware crypto operations.
+ * Allocate the state parameter on the stack.
  * Returns with preemption disabled.
  *
  * @state: Pointer to state structure to store current COP2 state in.
@@ -46,12 +47,12 @@ unsigned long octeon_crypto_enable(struct octeon_cop2_state *state)
 EXPORT_SYMBOL_GPL(octeon_crypto_enable);
 
 /**
- * Disable access to Octeon's COP2 crypto hardware in the kernel. This must be
- * called after an octeon_crypto_enable() before any context switch or return to
- * userspace.
+ * octeon_crypto_disable - Disable access to Octeon's COP2 crypto hardware in the kernel.
+ * This must be called after an octeon_crypto_enable() before any
+ * context switch or return to userspace.
  *
- * @state:	Pointer to COP2 state to restore
- * @flags:	Return value from octeon_crypto_enable()
+ * @state:		Pointer to COP2 state to restore
+ * @crypto_flags:	Return value from octeon_crypto_enable()
  */
 void octeon_crypto_disable(struct octeon_cop2_state *state,
 			   unsigned long crypto_flags)
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 7553ab18db89..148cad70fe79 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -387,7 +387,7 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
  * verify_pefile_signature - Verify the signature on a PE binary image
  * @pebuf: Buffer containing the PE binary image
  * @pelen: Length of the binary image
- * @trust_keys: Signing certificate(s) to use as starting points
+ * @trusted_keys: Signing certificate(s) to use as starting points
  * @usage: The use to which the key is being put.
  *
  * Validate that the certificate chain inside the PKCS#7 message inside the PE
diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
index f9cdc5e91664..c95908d70f7e 100644
--- a/crypto/async_tx/async_pq.c
+++ b/crypto/async_tx/async_pq.c
@@ -11,9 +11,8 @@
 #include <linux/async_tx.h>
 #include <linux/gfp.h>
 
-/**
- * pq_scribble_page - space to hold throwaway P or Q buffer for
- * synchronous gen_syndrome
+/*
+ * space to hold throwaway P or Q buffer for synchronous gen_syndrome
  */
 static struct page *pq_scribble_page;
 
@@ -28,7 +27,7 @@ static struct page *pq_scribble_page;
 
 #define MAX_DISKS 255
 
-/**
+/*
  * do_async_gen_syndrome - asynchronously calculate P and/or Q
  */
 static __async_inline struct dma_async_tx_descriptor *
@@ -100,7 +99,7 @@ do_async_gen_syndrome(struct dma_chan *chan,
 	return tx;
 }
 
-/**
+/*
  * do_sync_gen_syndrome - synchronously calculate a raid6 syndrome
  */
 static void
@@ -281,7 +280,7 @@ pq_val_chan(struct async_submit_ctl *submit, struct page **blocks, int disks, si
 /**
  * async_syndrome_val - asynchronously validate a raid6 syndrome
  * @blocks: source blocks from idx 0..disks-3, P @ disks-2 and Q @ disks-1
- * @offset: common offset into each block (src and dest) to start transaction
+ * @offsets: common offset into each block (src and dest) to start transaction
  * @disks: number of blocks (including missing P or Q, see below)
  * @len: length of operation in bytes
  * @pqres: on val failure SUM_CHECK_P_RESULT and/or SUM_CHECK_Q_RESULT are set
diff --git a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
index 9256934312d7..ad72057a5e0d 100644
--- a/crypto/async_tx/async_tx.c
+++ b/crypto/async_tx/async_tx.c
@@ -124,7 +124,7 @@ async_tx_channel_switch(struct dma_async_tx_descriptor *depend_tx,
 
 
 /**
- * submit_disposition - flags for routing an incoming operation
+ * enum submit_disposition - flags for routing an incoming operation
  * @ASYNC_TX_SUBMITTED: we were able to append the new operation under the lock
  * @ASYNC_TX_CHANNEL_SWITCH: when the lock is dropped schedule a channel switch
  * @ASYNC_TX_DIRECT_SUBMIT: when the lock is dropped submit directly
@@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(async_trigger_callback);
 
 /**
  * async_tx_quiesce - ensure tx is complete and freeable upon return
- * @tx - transaction to quiesce
+ * @tx: transaction to quiesce
  */
 void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
 {
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index bb8e77077f02..64dc9aa3ca24 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -499,7 +499,7 @@ EXPORT_SYMBOL_GPL(crypto_engine_stop);
  *                This has the form:
  *                callback(struct crypto_engine *engine)
  *                where:
- *                @engine: the crypto engine structure.
+ *                engine: the crypto engine structure.
  * @rt: whether this queue is set to run as a realtime task
  * @qlen: maximum size of the crypto-engine queue
  *
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index e4bc96528902..77870c3aeec5 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -209,7 +209,7 @@ void acomp_request_free(struct acomp_req *req);
  *
  * @req:	request that the callback will be set for
  * @flgs:	specify for instance if the operation may backlog
- * @cmlp:	callback which will be called
+ * @cmpl:	callback which will be called
  * @data:	private data used by the caller
  */
 static inline void acomp_request_set_callback(struct acomp_req *req,
diff --git a/include/crypto/des.h b/include/crypto/des.h
index 7812b4331ae4..2fcc72988843 100644
--- a/include/crypto/des.h
+++ b/include/crypto/des.h
@@ -34,7 +34,7 @@ void des3_ede_decrypt(const struct des3_ede_ctx *dctx, u8 *dst, const u8 *src);
  * des_expand_key - Expand a DES input key into a key schedule
  * @ctx: the key schedule
  * @key: buffer containing the input key
- * @len: size of the buffer contents
+ * @keylen: size of the buffer contents
  *
  * Returns 0 on success, -EINVAL if the input key is rejected and -ENOKEY if
  * the key is accepted but has been found to be weak.
@@ -45,7 +45,7 @@ int des_expand_key(struct des_ctx *ctx, const u8 *key, unsigned int keylen);
  * des3_ede_expand_key - Expand a triple DES input key into a key schedule
  * @ctx: the key schedule
  * @key: buffer containing the input key
- * @len: size of the buffer contents
+ * @keylen: size of the buffer contents
  *
  * Returns 0 on success, -EINVAL if the input key is rejected and -ENOKEY if
  * the key is accepted but has been found to be weak. Note that weak keys will
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index a5db86670bdf..da66314d9bc7 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -124,7 +124,7 @@ struct af_alg_async_req {
  * @tsgl_list:		Link to TX SGL
  * @iv:			IV for cipher operation
  * @aead_assoclen:	Length of AAD for AEAD cipher operations
- * @completion:		Work queue for synchronous operation
+ * @wait:		helper structure for async operation
  * @used:		TX bytes sent to kernel. This variable is used to
  *			ensure that user space cannot cause the kernel
  *			to allocate too much memory in sendmsg operation.
@@ -174,10 +174,10 @@ static inline struct alg_sock *alg_sk(struct sock *sk)
 }
 
 /**
- * Size of available buffer for sending data from user space to kernel.
+ * af_alg_sndbuf - Size of available buffer for sending data from user space to kernel.
  *
- * @sk socket of connection to user space
- * @return number of bytes still available
+ * @sk: socket of connection to user space
+ * @return: number of bytes still available
  */
 static inline int af_alg_sndbuf(struct sock *sk)
 {
@@ -189,10 +189,10 @@ static inline int af_alg_sndbuf(struct sock *sk)
 }
 
 /**
- * Can the send buffer still be written to?
+ * af_alg_writable - Can the send buffer still be written to?
  *
- * @sk socket of connection to user space
- * @return true => writable, false => not writable
+ * @sk: socket of connection to user space
+ * @return: true => writable, false => not writable
  */
 static inline bool af_alg_writable(struct sock *sk)
 {
@@ -200,10 +200,10 @@ static inline bool af_alg_writable(struct sock *sk)
 }
 
 /**
- * Size of available buffer used by kernel for the RX user space operation.
+ * af_alg_rcvbuf - Size of available buffer used by kernel for the RX user space operation.
  *
- * @sk socket of connection to user space
- * @return number of bytes still available
+ * @sk: socket of connection to user space
+ * @return: number of bytes still available
  */
 static inline int af_alg_rcvbuf(struct sock *sk)
 {
@@ -215,10 +215,10 @@ static inline int af_alg_rcvbuf(struct sock *sk)
 }
 
 /**
- * Can the RX buffer still be written to?
+ * af_alg_readable - Can the RX buffer still be written to?
  *
- * @sk socket of connection to user space
- * @return true => writable, false => not writable
+ * @sk: socket of connection to user space
+ * @return: true => writable, false => not writable
  */
 static inline bool af_alg_readable(struct sock *sk)
 {
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4f6c1a68882f..4b8155fea03c 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -76,7 +76,7 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
  * point G.
  * @curve_id:		id representing the curve to use
  * @ndigits:		curve number of digits
- * @private_key:	buffer for storing the generated private key
+ * @privkey:		buffer for storing the generated private key
  *
  * Returns 0 if the private key was generated successfully, a negative value
  * if an error occurred.
@@ -172,7 +172,7 @@ int vli_cmp(const u64 *left, const u64 *right, unsigned int ndigits);
  *
  * @result:		where to write result
  * @left:		vli
- * @right		vli
+ * @right:		vli
  * @ndigits:		length of all vlis
  *
  * Note: can modify in-place.
@@ -236,7 +236,7 @@ void vli_mod_mult_slow(u64 *result, const u64 *left, const u64 *right,
 unsigned int vli_num_bits(const u64 *vli, unsigned int ndigits);
 
 /**
- * ecc_aloc_point() - Allocate ECC point.
+ * ecc_alloc_point() - Allocate ECC point.
  *
  * @ndigits:		Length of vlis in u64 qwords.
  *
@@ -254,7 +254,7 @@ void ecc_free_point(struct ecc_point *p);
 /**
  * ecc_point_is_zero() - Check if point is zero.
  *
- * @p:			Point to check for zero.
+ * @point:		Point to check for zero.
  *
  * Return: true if point is the point at infinity, false otherwise.
  */
diff --git a/include/crypto/internal/rsa.h b/include/crypto/internal/rsa.h
index e870133f4b77..78a7544aaa11 100644
--- a/include/crypto/internal/rsa.h
+++ b/include/crypto/internal/rsa.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 /**
- * rsa_key - RSA key structure
+ * struct rsa_key - RSA key structure
  * @n           : RSA modulus raw byte stream
  * @e           : RSA public exponent raw byte stream
  * @d           : RSA private exponent raw byte stream
diff --git a/include/crypto/kdf_sp800108.h b/include/crypto/kdf_sp800108.h
index b7b20a778fb7..1c16343cd3fd 100644
--- a/include/crypto/kdf_sp800108.h
+++ b/include/crypto/kdf_sp800108.h
@@ -11,17 +11,20 @@
 #include <linux/uio.h>
 
 /**
- * Counter KDF generate operation according to SP800-108 section 5.1
- * as well as SP800-56A section 5.8.1 (Single-step KDF).
+ * crypto_kdf108_ctr_generate - Counter KDF generate operation
+ *				according to SP800-108 section 5.1
+ *				as well as SP800-56A section 5.8.1
+ *				(Single-step KDF).
  *
- * @kmd Keyed message digest whose key was set with crypto_kdf108_setkey or
- *	unkeyed message digest
- * @info optional context and application specific information - this may be
- *	 NULL
- * @info_vec number of optional context/application specific information entries
- * @dst destination buffer that the caller already allocated
- * @dlen length of the destination buffer - the KDF derives that amount of
- *	 bytes.
+ * @kmd:	Keyed message digest whose key was set with
+ *		crypto_kdf108_setkey or unkeyed message digest
+ * @info:	optional context and application specific information -
+ *		this may be NULL
+ * @info_nvec:	number of optional context/application specific
+ *		information entries
+ * @dst:	destination buffer that the caller already allocated
+ * @dlen:	length of the destination buffer -
+ *		the KDF derives that amount of bytes.
  *
  * To comply with SP800-108, the caller must provide Label || 0x00 || Context
  * in the info parameter.
@@ -33,14 +36,16 @@ int crypto_kdf108_ctr_generate(struct crypto_shash *kmd,
 			       u8 *dst, unsigned int dlen);
 
 /**
- * Counter KDF setkey operation
+ * crypto_kdf108_setkey - Counter KDF setkey operation
  *
- * @kmd Keyed message digest allocated by the caller. The key should not have
- *	been set.
- * @key Seed key to be used to initialize the keyed message digest context.
- * @keylen This length of the key buffer.
- * @ikm The SP800-108 KDF does not support IKM - this parameter must be NULL
- * @ikmlen This parameter must be 0.
+ * @kmd:	Keyed message digest allocated by the caller.
+ *		The key should not have been set.
+ * @key:	Seed key to be used to initialize the
+ *		keyed message digest context.
+ * @keylen:	This length of the key buffer.
+ * @ikm:	The SP800-108 KDF does not support IKM -
+ *		this parameter must be NULL
+ * @ikmlen:	This parameter must be 0.
  *
  * According to SP800-108 section 7.2, the seed key must be at least as large as
  * the message digest size of the used keyed message digest. This limitation
-- 
2.38.1

