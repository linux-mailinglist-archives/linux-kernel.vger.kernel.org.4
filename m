Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4E5FCE02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLWC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJLWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:01:16 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3E71997;
        Wed, 12 Oct 2022 15:00:20 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CL6Inh011403;
        Wed, 12 Oct 2022 22:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pps0720;
 bh=vfe3JaXy5t1uPLNmSMs9D1BrEZcB/b63Kn1+U3AJmdI=;
 b=Oz8xN/q2X3vq6EDXxqiBUc4Xqu6bY4QmotP8gAhS52I4uz99gDtz+hl3wr9CajHLdoxN
 fP5r9Auacaxm9MJ2bafrCeOthd+M6hV9x2hVGQ0IWVNS/cDnrhH+8yKO4KK7uUZWrQJq
 h9hHlWWEAuGSAuO/n0glABkqIBQz3jhRTEAhIGuItvaXM5M7XAG9VGJzuoYgZdaeTsdj
 D9QYfWFyo+JHdLGiApKRVB95rQv3nA/qgSOmFmvO9Nmy/OiEfrs0O9yCTTA5SzBPDJ+l
 5KNX3WCUQZpbyuuTMZ2YMgY0DdOuFXxcOM1Ej+4zsEhyj9zOiqkhfy7VHxlfNPejQeCV 7A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6471rtrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:00:07 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id DFDEA13959;
        Wed, 12 Oct 2022 22:00:06 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 863EB8036BF;
        Wed, 12 Oct 2022 22:00:06 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 15/19] crypto: x86 - add pr_fmt to all modules
Date:   Wed, 12 Oct 2022 16:59:27 -0500
Message-Id: <20221012215931.3896-16-elliott@hpe.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012215931.3896-1-elliott@hpe.com>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dpqcuqi8bN92J1TWWdtx_xSR_XapDlNC
X-Proofpoint-ORIG-GUID: Dpqcuqi8bN92J1TWWdtx_xSR_XapDlNC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pr_fmt to all the modules so prints are prefixed by the Kconfig
system module name (which is usually similar to, but not an
exact match, for the runtime module name).

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      | 2 ++
 arch/x86/crypto/aesni-intel_glue.c         | 2 ++
 arch/x86/crypto/aria_aesni_avx_glue.c      | 2 ++
 arch/x86/crypto/blake2s-glue.c             | 2 ++
 arch/x86/crypto/blowfish_glue.c            | 2 ++
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 2 ++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 2 ++
 arch/x86/crypto/camellia_glue.c            | 3 +++
 arch/x86/crypto/cast5_avx_glue.c           | 2 ++
 arch/x86/crypto/cast6_avx_glue.c           | 2 ++
 arch/x86/crypto/chacha_glue.c              | 2 ++
 arch/x86/crypto/crc32-pclmul_glue.c        | 3 +++
 arch/x86/crypto/crc32c-intel_glue.c        | 3 +++
 arch/x86/crypto/crct10dif-pclmul_glue.c    | 2 ++
 arch/x86/crypto/curve25519-x86_64.c        | 2 ++
 arch/x86/crypto/des3_ede_glue.c            | 2 ++
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 2 ++
 arch/x86/crypto/nhpoly1305-avx2-glue.c     | 2 ++
 arch/x86/crypto/nhpoly1305-sse2-glue.c     | 2 ++
 arch/x86/crypto/poly1305_glue.c            | 2 ++
 arch/x86/crypto/polyval-clmulni_glue.c     | 2 ++
 arch/x86/crypto/serpent_avx2_glue.c        | 2 ++
 arch/x86/crypto/serpent_avx_glue.c         | 2 ++
 arch/x86/crypto/serpent_sse2_glue.c        | 2 ++
 arch/x86/crypto/sha256_ssse3_glue.c        | 1 -
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 2 ++
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 2 ++
 arch/x86/crypto/twofish_avx_glue.c         | 2 ++
 arch/x86/crypto/twofish_glue.c             | 2 ++
 arch/x86/crypto/twofish_glue_3way.c        | 2 ++
 30 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index 9e4ba031704d..122bfd04ee47 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/internal/aead.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 4a530a558436..df93cb44b4eb 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -15,6 +15,8 @@
  *    Copyright (c) 2010, Intel Corporation.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/hardirq.h>
 #include <linux/types.h>
 #include <linux/module.h>
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index c561ea4fefa5..589097728bd1 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2022 Taehee Yoo <ap420073@gmail.com>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/aria.h>
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index 5153bb423dbe..ac7fb7a9922b 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/internal/blake2s.h>
 
 #include <linux/types.h>
diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 4c0ead71b198..5cfcbb91c4ca 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -8,6 +8,8 @@
  *   Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/blowfish.h>
 #include <crypto/internal/skcipher.h>
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index 8e3ac5be7cf6..851f2a29963c 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -5,6 +5,8 @@
  * Copyright © 2013 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 54fcd86160ff..8846493c92fb 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -5,6 +5,8 @@
  * Copyright © 2012-2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index e21d2d5b68f9..3c14a904af00 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -8,6 +8,9 @@
  *  Copyright (C) 2006 NTT (Nippon Telegraph and Telephone Corporation)
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <asm/cpu_device_id.h>
 #include <asm/unaligned.h>
 #include <linux/crypto.h>
 #include <linux/init.h>
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index bdc3c763334c..fdeec0849ab5 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -6,6 +6,8 @@
  *     <Johannes.Goetzfried@informatik.stud.uni-erlangen.de>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/cast5.h>
 #include <crypto/internal/simd.h>
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index addca34b3511..9258082408eb 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -8,6 +8,8 @@
  * Copyright © 2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7275cae3380d..8e5cadc808b4 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2015 Martin Willi
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/chacha.h>
 #include <crypto/internal/simd.h>
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index d49a19dcee37..bc2b31b04e05 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -26,6 +26,9 @@
  *
  * Wrappers for kernel crypto shash api to pclmulqdq crc32 implementation.
  */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index 980c62929256..ebf530934a3e 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -11,6 +11,9 @@
  * Authors: Austin Zhang <austin_zhang@linux.intel.com>
  *          Kent Liu <kent.liu@intel.com>
  */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 3b8e9394c40d..03e35a1b7677 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/crc-t10dif.h>
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 7fe395dfa79d..f9a1adb0c183 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016-2020 INRIA, CMU and Microsoft Corporation
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/curve25519.h>
 #include <crypto/internal/kpp.h>
 
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index 168cac5c6ca6..83e686a6c2f3 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -8,6 +8,8 @@
  *   Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/des.h>
 #include <crypto/internal/skcipher.h>
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index 69945e41bc41..3ad55144da48 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -7,6 +7,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index a8046334ddca..40f49107e5a9 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -6,6 +6,8 @@
  * Copyright 2018 Google LLC
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
 #include <crypto/nhpoly1305.h>
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index cdbe5df00927..bb40fed92c92 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -6,6 +6,8 @@
  * Copyright 2018 Google LLC
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
 #include <crypto/nhpoly1305.h>
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 3e6ff505cd26..a2a7cb39cdec 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/poly1305.h>
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index 2502964afef6..5a345db20ca9 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -16,6 +16,8 @@
  * operations.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 24741d33edaf..5944bf5ead2e 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -5,6 +5,8 @@
  * Copyright © 2012-2013 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 0db18d99da50..45713c7a4cb9 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -8,6 +8,8 @@
  * Copyright © 2011-2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 5288441cc223..d8aa0d3fbf15 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -12,6 +12,8 @@
  *   Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 42e8cb1a6708..8a0fb308fbba 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -26,7 +26,6 @@
  * SOFTWARE.
  */
 
-
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <crypto/internal/hash.h>
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 2e9fe76056b8..3fe9e170b880 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -8,6 +8,8 @@
  * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index f730822f203a..14ae012948ae 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -8,6 +8,8 @@
  * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index 4657e6efc35d..044e4f92e2c0 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -8,6 +8,8 @@
  * Copyright © 2013 Jussi Kivilinna <jussi.kivilinna@iki.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index ade98aef3402..031ed290c755 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -38,6 +38,8 @@
  * Third Edition.
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/twofish.h>
 #include <linux/crypto.h>
 #include <linux/init.h>
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 790e5a59a9a7..7e2a18e3abe7 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2011 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
  */
 
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
 #include <crypto/algapi.h>
 #include <crypto/twofish.h>
 #include <linux/crypto.h>
-- 
2.37.3

