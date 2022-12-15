Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2664D689
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLOGj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLOGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:39:48 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5B5C0E0;
        Wed, 14 Dec 2022 22:39:40 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEKpAtj006924;
        Thu, 15 Dec 2022 06:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ylh/zALagFBHwYaj1f0ik/+huRR6zZZQb0z/uboNC4I=;
 b=AeYqoYG+MLlXB4EXd4bSHZIGX2PwDNXKnk8PRo06iVBU836XxkqUpGBx/lKI39LqpHC1
 YnE4MDqFDF0xwQC4b+QgC2g6xJ03m5GjbrPsWnpSGouuI7KbZfAf3mm2YMuepvcshFeF
 fm3kKnME5cn4APYvUHp9yjQ42OPgujhWidr32VYyvxrquySpoD0O+24rIb3j9UxHk7ya
 H2hwXsTxCoOKLReWRlE/od8iGfrgy9SWx3kS4R9oBd3oX3YzVXqPXFHQvBjhuzm/4c4z
 Hu8B2/tCvJ3x9qAjIQt6OHYA7tGbP7whyZpRfbVHTp7k/7m9IkLjetVDRUhPk4LzycAa ZA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mfgse5s5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 06:39:35 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EED5F801732;
        Thu, 15 Dec 2022 06:39:34 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8F5B380E124;
        Thu, 15 Dec 2022 06:39:34 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH 5/8] crypto: x86/sm3 - add kernel-doc comments to assembly
Date:   Thu, 15 Dec 2022 00:38:54 -0600
Message-Id: <20221215063857.161665-6-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215063857.161665-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V4QltgjAiA9PAh10A0ALcq26LrW86FXl
X-Proofpoint-GUID: V4QltgjAiA9PAh10A0ALcq26LrW86FXl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212150050
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
index b12b9efb5ec5..d02ebe5e0bb5 100644
--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@ -321,19 +321,19 @@
 
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
 .align 16
 SYM_FUNC_START(sm3_transform_avx)
-	/* input:
-	 *	%rdi: ctx, CTX
-	 *	%rsi: data (64*nblks bytes)
-	 *	%rdx: nblocks
-	 */
 	vzeroupper;
 
 	pushq %rbp;
-- 
2.38.1

