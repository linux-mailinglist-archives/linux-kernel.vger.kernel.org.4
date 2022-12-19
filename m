Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7FB65124B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiLSS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiLSS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:16 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF825FD;
        Mon, 19 Dec 2022 10:56:15 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJH9e4u024684;
        Mon, 19 Dec 2022 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EheRUOzM1/FbUVSQp3nOUSZfGhhTVB7Lvia97WJ2X5Q=;
 b=Eut2YUfb20FY3aIS5HKoYDoWQ45Hj3l0HcSPW3NeunA/JbTKWFIYj2F4ItsS1d88tUT7
 D+ZKbQ6/1jh34PQbibU3DC4U+FbmtORoCF595eXc/gu+rm68M8eVjtRGjMmL78tVFB4z
 HmgsFVX06wmp9VJPNiJTBG/EtvlNZJKPba6pmO0KSUkuGm1FpcFAbwtHIIfeZ0jRQhgy
 c3mjp7d1tRPFeN82jYE6d9F/E9G7cWJgb52EEoCSr9PhBFV338S3mUbfS/+KNqZbtkQj
 dsshrH+ylw8vs4b3lbzEMuhuw72e9IXzIznT4BQ+y8QTtcFR2qZvFsvnjPI4ijshvxxP 4A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjv420q9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 711BA80712F;
        Mon, 19 Dec 2022 18:56:13 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1EB2380576E;
        Mon, 19 Dec 2022 18:56:13 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 7/8] crypto: x86/blake2s - add kernel-doc comments to assembly
Date:   Mon, 19 Dec 2022 12:55:54 -0600
Message-Id: <20221219185555.433233-8-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p1Np6PD6r4ylubU3hGhqhv2rXeFRDAbK
X-Proofpoint-GUID: p1Np6PD6r4ylubU3hGhqhv2rXeFRDAbK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 arch/x86/crypto/blake2s-core.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/crypto/blake2s-core.S
index b50b35ff1fdb..7605e7d94fd2 100644
--- a/arch/x86/crypto/blake2s-core.S
+++ b/arch/x86/crypto/blake2s-core.S
@@ -46,6 +46,19 @@ SIGMA2:
 #endif /* CONFIG_AS_AVX512 */
 
 .text
+/**
+ * blake2s_compress_ssse3 - Calculate BLAKE2s hash using the x86 SSSE3 feature set
+ * @state:	pointer to 48-byte state (%rdi)
+ * @data:	pointer to data (%rsi)
+ * @nblocks:	number of 64-byte blocks of data (%rdx)
+ * @inc:	counter increment value (%rcx)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none (but modifies state)
+ * Prototype:	asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state, const u8 *data,
+ *						       unsigned int nblocks, u32 inc);
+ */
 SYM_FUNC_START(blake2s_compress_ssse3)
 	testq		%rdx,%rdx
 	je		.Lendofloop
@@ -175,6 +188,19 @@ SYM_FUNC_START(blake2s_compress_ssse3)
 SYM_FUNC_END(blake2s_compress_ssse3)
 
 #ifdef CONFIG_AS_AVX512
+/**
+ * blake2s_compress_avx512 - Calculate BLAKE2s hash using the x86 AVX-512VL feature set
+ * @state:	address of 48-byte state (%rdi)
+ * @data:	address of data (%rsi)
+ * @nblocks:	number of 64-byte blocks of data (%rdx)
+ * @inc:	counter increment value (%rcx)
+ *
+ * This function supports 64-bit CPUs.
+ *
+ * Return:	none (but modifies state)
+ * Prototype:	asmlinkage void blake2s_compress_avx512(struct blake2s_state *state, const u8 *data,
+ *							unsigned int nblocks, u32 inc);
+ */
 SYM_FUNC_START(blake2s_compress_avx512)
 	vmovdqu		(%rdi),%xmm0
 	vmovdqu		0x10(%rdi),%xmm1
-- 
2.38.1

