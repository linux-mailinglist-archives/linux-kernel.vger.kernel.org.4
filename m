Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8F62B245
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKPERM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiKPEPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:15:04 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F089326E0;
        Tue, 15 Nov 2022 20:14:32 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3d5HG008268;
        Wed, 16 Nov 2022 04:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pps0720;
 bh=UQxbDx6IIdceogmBqO1UQxXhra12osc0rpf/5otoIoo=;
 b=JuiV6+repaWTvE6Oc8gih82ztv7a+wPeUX/MiERlVvA+4kV+U3fJHxmA3i3FxNKdIroy
 DNSuZsxdmHVH21Fd+o3GS6qDHEFwA7C8Gx7InIGxja+WvU7f6UPCiRlujuXuNNR4RBQl
 OlAq3mepHuMzpANMhnIsXjsgakfNYLe2tmueFk5yNHhX9ogdhE29UMTaqZZKqCGDoqoc
 kuAWWEvfb4F2rOOom9V9fkHUUqOV5RzCIzdlmiRbvpa565myotqi0iFwJsErIUabtxcP
 K9+FaJdEX3ShOj8ir0vIExTTocTkXtic3t2EddrgezxdReHW39sqcn2PIiJFgoA15woO cQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kvr5486ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:23 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A4C00295AF;
        Wed, 16 Nov 2022 04:14:22 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 340848058DE;
        Wed, 16 Nov 2022 04:14:22 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 24/24] crypto: x86 - standarize module descriptions
Date:   Tue, 15 Nov 2022 22:13:42 -0600
Message-Id: <20221116041342.3841-25-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wMrNsQqPPYHlmk88iOocarT2UTYp9ERN
X-Proofpoint-GUID: wMrNsQqPPYHlmk88iOocarT2UTYp9ERN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the module descriptions for the x86 optimized crypto modules match
the descriptions of the generic modules and the names in Kconfig.

End each description with "with <feature name>" listing the features
used for module matching.
    "-- accelerated for x86 with AVX2"

Mention any other required CPU features:
    "(also required: AES-NI)"

Mention any CPU features that are not required but enable additional
acceleration:
    "(optional: GF-NI)"

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/aegis128-aesni-glue.c      | 2 +-
 arch/x86/crypto/aesni-intel_glue.c         | 2 +-
 arch/x86/crypto/aria_aesni_avx_glue.c      | 2 +-
 arch/x86/crypto/blake2s-glue.c             | 1 +
 arch/x86/crypto/blowfish_glue.c            | 2 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 2 +-
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 2 +-
 arch/x86/crypto/camellia_glue.c            | 2 +-
 arch/x86/crypto/cast5_avx_glue.c           | 2 +-
 arch/x86/crypto/cast6_avx_glue.c           | 2 +-
 arch/x86/crypto/chacha_glue.c              | 2 +-
 arch/x86/crypto/crc32-pclmul_glue.c        | 2 +-
 arch/x86/crypto/crc32c-intel_glue.c        | 2 +-
 arch/x86/crypto/crct10dif-pclmul_glue.c    | 2 +-
 arch/x86/crypto/curve25519-x86_64.c        | 1 +
 arch/x86/crypto/des3_ede_glue.c            | 2 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 2 +-
 arch/x86/crypto/nhpoly1305-avx2-glue.c     | 2 +-
 arch/x86/crypto/nhpoly1305-sse2-glue.c     | 2 +-
 arch/x86/crypto/poly1305_glue.c            | 2 +-
 arch/x86/crypto/polyval-clmulni_glue.c     | 2 +-
 arch/x86/crypto/serpent_avx2_glue.c        | 2 +-
 arch/x86/crypto/serpent_avx_glue.c         | 2 +-
 arch/x86/crypto/serpent_sse2_glue.c        | 2 +-
 arch/x86/crypto/sha1_ssse3_glue.c          | 2 +-
 arch/x86/crypto/sha256_ssse3_glue.c        | 2 +-
 arch/x86/crypto/sha512_ssse3_glue.c        | 2 +-
 arch/x86/crypto/sm3_avx_glue.c             | 2 +-
 arch/x86/crypto/sm4_aesni_avx2_glue.c      | 2 +-
 arch/x86/crypto/sm4_aesni_avx_glue.c       | 2 +-
 arch/x86/crypto/twofish_avx_glue.c         | 2 +-
 arch/x86/crypto/twofish_glue.c             | 2 +-
 arch/x86/crypto/twofish_glue_3way.c        | 2 +-
 crypto/aes_ti.c                            | 2 +-
 crypto/blake2b_generic.c                   | 2 +-
 crypto/blowfish_common.c                   | 2 +-
 crypto/crct10dif_generic.c                 | 2 +-
 crypto/curve25519-generic.c                | 1 +
 crypto/sha256_generic.c                    | 2 +-
 crypto/sha512_generic.c                    | 2 +-
 crypto/sm3.c                               | 2 +-
 crypto/sm4.c                               | 2 +-
 crypto/twofish_common.c                    | 2 +-
 crypto/twofish_generic.c                   | 2 +-
 44 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-glue.c b/arch/x86/crypto/aegis128-aesni-glue.c
index e0312ecf34a8..e72ae7ba5f12 100644
--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -322,6 +322,6 @@ module_exit(crypto_aegis128_aesni_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ondrej Mosnacek <omosnacek@gmail.com>");
-MODULE_DESCRIPTION("AEGIS-128 AEAD algorithm -- AESNI+SSE2 implementation");
+MODULE_DESCRIPTION("AEGIS-128 AEAD algorithm -- accelerated for x86 with AES-NI (also required: SEE2)");
 MODULE_ALIAS_CRYPTO("aegis128");
 MODULE_ALIAS_CRYPTO("aegis128-aesni");
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 80dbf98c53fd..3d8508598e76 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1311,6 +1311,6 @@ static void __exit aesni_exit(void)
 late_initcall(aesni_init);
 module_exit(aesni_exit);
 
-MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm, Intel AES-NI instructions optimized");
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm -- accelerated for x86 with AES-NI (optional: AVX, AVX2)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("aes");
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aesni_avx_glue.c
index ebb9760967b5..1d23c7ef7aef 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -227,6 +227,6 @@ module_exit(aria_avx_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Taehee Yoo <ap420073@gmail.com>");
-MODULE_DESCRIPTION("ARIA Cipher Algorithm, AVX/AES-NI/GFNI optimized");
+MODULE_DESCRIPTION("ARIA Cipher Algorithm -- accelerated for x86 with AVX (also required: AES-NI, OSXSAVE)(optional: GF-NI)");
 MODULE_ALIAS_CRYPTO("aria");
 MODULE_ALIAS_CRYPTO("aria-aesni-avx");
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index 781cf9471cb6..0618f0d31fae 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -90,3 +90,4 @@ static int __init blake2s_mod_init(void)
 module_init(blake2s_mod_init);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BLAKE2s hash algorithm -- accelerated for x86 with SSSE3 or AVX-512VL");
diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index 8e4de7859e34..67f7562d2d02 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -353,6 +353,6 @@ module_init(blowfish_init);
 module_exit(blowfish_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Blowfish Cipher Algorithm, asm optimized");
+MODULE_DESCRIPTION("Blowfish Cipher Algorithm -- accelerated for x86");
 MODULE_ALIAS_CRYPTO("blowfish");
 MODULE_ALIAS_CRYPTO("blowfish-asm");
diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index e8ae1e1a801d..da89fef184d2 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -147,6 +147,6 @@ module_init(camellia_aesni_init);
 module_exit(camellia_aesni_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Camellia Cipher Algorithm, AES-NI/AVX2 optimized");
+MODULE_DESCRIPTION("Camellia Cipher Algorithm -- accelerated for x86 with AVX2 (also required: AES-NI, AVX, OSXSAVE)");
 MODULE_ALIAS_CRYPTO("camellia");
 MODULE_ALIAS_CRYPTO("camellia-asm");
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index 6784d631575c..0eebb56bc440 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -146,6 +146,6 @@ module_init(camellia_aesni_init);
 module_exit(camellia_aesni_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Camellia Cipher Algorithm, AES-NI/AVX optimized");
+MODULE_DESCRIPTION("Camellia Cipher Algorithm -- accelerated for x86 with AVX (also required: AES-NI, OSXSAVE)");
 MODULE_ALIAS_CRYPTO("camellia");
 MODULE_ALIAS_CRYPTO("camellia-asm");
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 2cb9b24d9437..b8cad1655c66 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1427,6 +1427,6 @@ module_init(camellia_init);
 module_exit(camellia_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Camellia Cipher Algorithm, asm optimized");
+MODULE_DESCRIPTION("Camellia Cipher Algorithm -- accelerated for x86");
 MODULE_ALIAS_CRYPTO("camellia");
 MODULE_ALIAS_CRYPTO("camellia-asm");
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_glue.c
index 34ef032bb8d0..4a11d3ea9838 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -133,6 +133,6 @@ static void __exit cast5_exit(void)
 module_init(cast5_init);
 module_exit(cast5_exit);
 
-MODULE_DESCRIPTION("Cast5 Cipher Algorithm, AVX optimized");
+MODULE_DESCRIPTION("Cast5 Cipher Algorithm -- accelerated for x86 with AVX");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("cast5");
diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index 71559fd3ea87..53a92999a234 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -133,6 +133,6 @@ static void __exit cast6_exit(void)
 module_init(cast6_init);
 module_exit(cast6_exit);
 
-MODULE_DESCRIPTION("Cast6 Cipher Algorithm, AVX optimized");
+MODULE_DESCRIPTION("Cast6 Cipher Algorithm -- accelerated for x86 with AVX");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("cast6");
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index ec7461412c5e..563546d0bc2a 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -320,7 +320,7 @@ module_exit(chacha_simd_mod_fini);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Martin Willi <martin@strongswan.org>");
-MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (x64 SIMD accelerated)");
+MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers -- accelerated for x86 with SSSE3 (optional: AVX, AVX2, AVX-512VL and AVX-512BW)");
 MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-simd");
 MODULE_ALIAS_CRYPTO("xchacha20");
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index d5e889c24bea..1c297fae5d39 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -207,6 +207,6 @@ module_exit(crc32_pclmul_mod_fini);
 
 MODULE_AUTHOR("Alexander Boyko <alexander_boyko@xyratex.com>");
 MODULE_LICENSE("GPL");
-
+MODULE_DESCRIPTION("CRC32 -- accelerated for x86 with PCLMULQDQ");
 MODULE_ALIAS_CRYPTO("crc32");
 MODULE_ALIAS_CRYPTO("crc32-pclmul");
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index 3c2bf7032667..ba7899d04bb1 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -275,7 +275,7 @@ module_init(crc32c_intel_mod_init);
 module_exit(crc32c_intel_mod_fini);
 
 MODULE_AUTHOR("Austin Zhang <austin.zhang@intel.com>, Kent Liu <kent.liu@intel.com>");
-MODULE_DESCRIPTION("CRC32c (Castagnoli) optimization using Intel Hardware.");
+MODULE_DESCRIPTION("CRC32c (Castagnoli) -- accelerated for x86 with SSE4.2 (optional: PCLMULQDQ)");
 MODULE_LICENSE("GPL");
 
 MODULE_ALIAS_CRYPTO("crc32c");
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index a26dbd27da96..df9f81ee97a3 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -162,7 +162,7 @@ module_init(crct10dif_intel_mod_init);
 module_exit(crct10dif_intel_mod_fini);
 
 MODULE_AUTHOR("Tim Chen <tim.c.chen@linux.intel.com>");
-MODULE_DESCRIPTION("T10 DIF CRC calculation accelerated with PCLMULQDQ.");
+MODULE_DESCRIPTION("T10 DIF CRC -- accelerated for x86 with PCLMULQDQ");
 MODULE_LICENSE("GPL");
 
 MODULE_ALIAS_CRYPTO("crct10dif");
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 74672351e534..078508f53ff0 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1742,3 +1742,4 @@ MODULE_ALIAS_CRYPTO("curve25519");
 MODULE_ALIAS_CRYPTO("curve25519-x86");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
+MODULE_DESCRIPTION("Curve25519 algorithm -- accelerated for x86 with ADX (also requires BMI2)");
diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index a4cac5129148..fc90c0a076e3 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -404,7 +404,7 @@ module_init(des3_ede_x86_init);
 module_exit(des3_ede_x86_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Triple DES EDE Cipher Algorithm, asm optimized");
+MODULE_DESCRIPTION("Triple DES EDE Cipher Algorithm -- accelerated for x86");
 MODULE_ALIAS_CRYPTO("des3_ede");
 MODULE_ALIAS_CRYPTO("des3_ede-asm");
 MODULE_AUTHOR("Jussi Kivilinna <jussi.kivilinna@iki.fi>");
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index d19a8e9b34a6..30f4966df4de 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -363,5 +363,5 @@ module_init(ghash_pclmulqdqni_mod_init);
 module_exit(ghash_pclmulqdqni_mod_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("GHASH hash function, accelerated by PCLMULQDQ-NI");
+MODULE_DESCRIPTION("GHASH hash function -- accelerated for x86 with PCLMULQDQ");
 MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/x86/crypto/nhpoly1305-avx2-glue.c b/arch/x86/crypto/nhpoly1305-avx2-glue.c
index 2e63947bc9fa..ed6209f027e7 100644
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -94,7 +94,7 @@ static void __exit nhpoly1305_mod_exit(void)
 module_init(nhpoly1305_mod_init);
 module_exit(nhpoly1305_mod_exit);
 
-MODULE_DESCRIPTION("NHPoly1305 ε-almost-∆-universal hash function (AVX2-accelerated)");
+MODULE_DESCRIPTION("NHPoly1305 ε-almost-∆-universal hash function -- accelerated for x86 with AVX2 (also required: OSXSAVE)");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Eric Biggers <ebiggers@google.com>");
 MODULE_ALIAS_CRYPTO("nhpoly1305");
diff --git a/arch/x86/crypto/nhpoly1305-sse2-glue.c b/arch/x86/crypto/nhpoly1305-sse2-glue.c
index c47765e46236..d09156e702dd 100644
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -83,7 +83,7 @@ static void __exit nhpoly1305_mod_exit(void)
 module_init(nhpoly1305_mod_init);
 module_exit(nhpoly1305_mod_exit);
 
-MODULE_DESCRIPTION("NHPoly1305 ε-almost-∆-universal hash function (SSE2-accelerated)");
+MODULE_DESCRIPTION("NHPoly1305 ε-almost-∆-universal hash function -- accelerated for x86 with SSE2");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Eric Biggers <ebiggers@google.com>");
 MODULE_ALIAS_CRYPTO("nhpoly1305");
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index d3c0d5b335ea..78f88be4a22a 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -313,6 +313,6 @@ module_exit(poly1305_simd_mod_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-MODULE_DESCRIPTION("Poly1305 authenticator");
+MODULE_DESCRIPTION("Poly1305 authenticator -- accelerated for x86 (optional: AVX, AVX2, AVX-512F)");
 MODULE_ALIAS_CRYPTO("poly1305");
 MODULE_ALIAS_CRYPTO("poly1305-simd");
diff --git a/arch/x86/crypto/polyval-clmulni_glue.c b/arch/x86/crypto/polyval-clmulni_glue.c
index 20d4a68ec1d7..447f0f219759 100644
--- a/arch/x86/crypto/polyval-clmulni_glue.c
+++ b/arch/x86/crypto/polyval-clmulni_glue.c
@@ -211,6 +211,6 @@ module_init(polyval_clmulni_mod_init);
 module_exit(polyval_clmulni_mod_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("POLYVAL hash function accelerated by PCLMULQDQ-NI");
+MODULE_DESCRIPTION("POLYVAL hash function - accelerated for x86 with PCLMULQDQ (also required: AVX)");
 MODULE_ALIAS_CRYPTO("polyval");
 MODULE_ALIAS_CRYPTO("polyval-clmulni");
diff --git a/arch/x86/crypto/serpent_avx2_glue.c b/arch/x86/crypto/serpent_avx2_glue.c
index 2aa62c93a16f..0a57779a7559 100644
--- a/arch/x86/crypto/serpent_avx2_glue.c
+++ b/arch/x86/crypto/serpent_avx2_glue.c
@@ -139,6 +139,6 @@ module_init(serpent_avx2_init);
 module_exit(serpent_avx2_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Serpent Cipher Algorithm, AVX2 optimized");
+MODULE_DESCRIPTION("Serpent Cipher Algorithm -- accelerated for x86 with AVX2 (also required: OSXSAVE)");
 MODULE_ALIAS_CRYPTO("serpent");
 MODULE_ALIAS_CRYPTO("serpent-asm");
diff --git a/arch/x86/crypto/serpent_avx_glue.c b/arch/x86/crypto/serpent_avx_glue.c
index 28ee9717df49..9d03fb25537f 100644
--- a/arch/x86/crypto/serpent_avx_glue.c
+++ b/arch/x86/crypto/serpent_avx_glue.c
@@ -141,6 +141,6 @@ static void __exit serpent_exit(void)
 module_init(serpent_init);
 module_exit(serpent_exit);
 
-MODULE_DESCRIPTION("Serpent Cipher Algorithm, AVX optimized");
+MODULE_DESCRIPTION("Serpent Cipher Algorithm -- accelerated for x86 with AVX");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("serpent");
diff --git a/arch/x86/crypto/serpent_sse2_glue.c b/arch/x86/crypto/serpent_sse2_glue.c
index 74f0c89f55ef..287b19527105 100644
--- a/arch/x86/crypto/serpent_sse2_glue.c
+++ b/arch/x86/crypto/serpent_sse2_glue.c
@@ -131,6 +131,6 @@ static void __exit serpent_sse2_exit(void)
 module_init(serpent_sse2_init);
 module_exit(serpent_sse2_exit);
 
-MODULE_DESCRIPTION("Serpent Cipher Algorithm, SSE2 optimized");
+MODULE_DESCRIPTION("Serpent Cipher Algorithm -- accelerated for x86 with SSE2");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("serpent");
diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 405af5e14b67..113756544d4e 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -433,7 +433,7 @@ module_init(sha1_ssse3_mod_init);
 module_exit(sha1_ssse3_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm, Supplemental SSE3 accelerated");
+MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm -- accelerated for x86 with SSSE3, AVX, AVX2, or SHA-NI");
 
 MODULE_ALIAS_CRYPTO("sha1");
 MODULE_ALIAS_CRYPTO("sha1-ssse3");
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 293cf7085dd3..78fa25d2e4ba 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -498,7 +498,7 @@ module_init(sha256_ssse3_mod_init);
 module_exit(sha256_ssse3_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm, Supplemental SSE3 accelerated");
+MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithms -- accelerated for x86 with SSSE3, AVX, AVX2, or SHA-NI");
 
 MODULE_ALIAS_CRYPTO("sha256");
 MODULE_ALIAS_CRYPTO("sha256-ssse3");
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 9f13baf7dda9..2fa951069604 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -396,7 +396,7 @@ module_init(sha512_ssse3_mod_init);
 module_exit(sha512_ssse3_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA512 Secure Hash Algorithm, Supplemental SSE3 accelerated");
+MODULE_DESCRIPTION("SHA-384 and SHA-512 Secure Hash Algorithms -- accelerated for x86 with SSSE3, AVX, or AVX2");
 
 MODULE_ALIAS_CRYPTO("sha512");
 MODULE_ALIAS_CRYPTO("sha512-ssse3");
diff --git a/arch/x86/crypto/sm3_avx_glue.c b/arch/x86/crypto/sm3_avx_glue.c
index 169ba6a2c806..9e1177fbf032 100644
--- a/arch/x86/crypto/sm3_avx_glue.c
+++ b/arch/x86/crypto/sm3_avx_glue.c
@@ -161,6 +161,6 @@ module_exit(sm3_avx_mod_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
-MODULE_DESCRIPTION("SM3 Secure Hash Algorithm, AVX assembler accelerated");
+MODULE_DESCRIPTION("SM3 Secure Hash Algorithm -- accelerated for x86 with AVX (also required: BMI2)");
 MODULE_ALIAS_CRYPTO("sm3");
 MODULE_ALIAS_CRYPTO("sm3-avx");
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
index 6bcf78231888..b497a6006c8d 100644
--- a/arch/x86/crypto/sm4_aesni_avx2_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -177,6 +177,6 @@ module_exit(sm4_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
-MODULE_DESCRIPTION("SM4 Cipher Algorithm, AES-NI/AVX2 optimized");
+MODULE_DESCRIPTION("SM4 Cipher Algorithm -- accelerated for x86 with AVX2 (also required: AES-NI, AVX, OSXSAVE)");
 MODULE_ALIAS_CRYPTO("sm4");
 MODULE_ALIAS_CRYPTO("sm4-aesni-avx2");
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
index 03775b1079dc..e583ee0948af 100644
--- a/arch/x86/crypto/sm4_aesni_avx_glue.c
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -495,6 +495,6 @@ module_exit(sm4_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
-MODULE_DESCRIPTION("SM4 Cipher Algorithm, AES-NI/AVX optimized");
+MODULE_DESCRIPTION("SM4 Cipher Algorithm -- accelerated for x86 with AVX (also required: AES-NI, OSXSAVE)");
 MODULE_ALIAS_CRYPTO("sm4");
 MODULE_ALIAS_CRYPTO("sm4-aesni-avx");
diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index ae3cc4ad6f4f..7b405c66d5fa 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -143,6 +143,6 @@ static void __exit twofish_exit(void)
 module_init(twofish_init);
 module_exit(twofish_exit);
 
-MODULE_DESCRIPTION("Twofish Cipher Algorithm, AVX optimized");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm -- accelerated for x86 with AVX");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("twofish");
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index ade98aef3402..10729675e79c 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -105,6 +105,6 @@ module_init(twofish_glue_init);
 module_exit(twofish_glue_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION ("Twofish Cipher Algorithm, asm optimized");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm -- accelerated for x86");
 MODULE_ALIAS_CRYPTO("twofish");
 MODULE_ALIAS_CRYPTO("twofish-asm");
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 8db2f23b3056..43f428b59684 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -177,6 +177,6 @@ module_init(twofish_3way_init);
 module_exit(twofish_3way_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Twofish Cipher Algorithm, 3-way parallel asm optimized");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm -- accelerated for x86 (3-way parallel)");
 MODULE_ALIAS_CRYPTO("twofish");
 MODULE_ALIAS_CRYPTO("twofish-asm");
diff --git a/crypto/aes_ti.c b/crypto/aes_ti.c
index 205c2c257d49..3cff553495ad 100644
--- a/crypto/aes_ti.c
+++ b/crypto/aes_ti.c
@@ -78,6 +78,6 @@ static void __exit aes_fini(void)
 module_init(aes_init);
 module_exit(aes_fini);
 
-MODULE_DESCRIPTION("Generic fixed time AES");
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm -- generic fixed time");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 6704c0355889..ee53f25ff254 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -175,7 +175,7 @@ subsys_initcall(blake2b_mod_init);
 module_exit(blake2b_mod_fini);
 
 MODULE_AUTHOR("David Sterba <kdave@kernel.org>");
-MODULE_DESCRIPTION("BLAKE2b generic implementation");
+MODULE_DESCRIPTION("BLAKE2b hash algorithm");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("blake2b-160");
 MODULE_ALIAS_CRYPTO("blake2b-160-generic");
diff --git a/crypto/blowfish_common.c b/crypto/blowfish_common.c
index 1c072012baff..8c75fdfcd09c 100644
--- a/crypto/blowfish_common.c
+++ b/crypto/blowfish_common.c
@@ -394,4 +394,4 @@ int blowfish_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 EXPORT_SYMBOL_GPL(blowfish_setkey);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Blowfish Cipher common functions");
+MODULE_DESCRIPTION("Blowfish Cipher Algorithm common functions");
diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index e843982073bb..81c131c8ccd0 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -116,7 +116,7 @@ subsys_initcall(crct10dif_mod_init);
 module_exit(crct10dif_mod_fini);
 
 MODULE_AUTHOR("Tim Chen <tim.c.chen@linux.intel.com>");
-MODULE_DESCRIPTION("T10 DIF CRC calculation.");
+MODULE_DESCRIPTION("T10 DIF CRC calculation");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("crct10dif");
 MODULE_ALIAS_CRYPTO("crct10dif-generic");
diff --git a/crypto/curve25519-generic.c b/crypto/curve25519-generic.c
index d055b0784c77..4f96583b31dd 100644
--- a/crypto/curve25519-generic.c
+++ b/crypto/curve25519-generic.c
@@ -88,3 +88,4 @@ module_exit(curve25519_exit);
 MODULE_ALIAS_CRYPTO("curve25519");
 MODULE_ALIAS_CRYPTO("curve25519-generic");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Curve25519 algorithm");
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index bf147b01e313..141430c25e15 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -102,7 +102,7 @@ subsys_initcall(sha256_generic_mod_init);
 module_exit(sha256_generic_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithm");
+MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithms");
 
 MODULE_ALIAS_CRYPTO("sha224");
 MODULE_ALIAS_CRYPTO("sha224-generic");
diff --git a/crypto/sha512_generic.c b/crypto/sha512_generic.c
index be70e76d6d86..63c5616ec770 100644
--- a/crypto/sha512_generic.c
+++ b/crypto/sha512_generic.c
@@ -219,7 +219,7 @@ subsys_initcall(sha512_generic_mod_init);
 module_exit(sha512_generic_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA-512 and SHA-384 Secure Hash Algorithms");
+MODULE_DESCRIPTION("SHA-384 and SHA-512 Secure Hash Algorithms");
 
 MODULE_ALIAS_CRYPTO("sha384");
 MODULE_ALIAS_CRYPTO("sha384-generic");
diff --git a/crypto/sm3.c b/crypto/sm3.c
index d473e358a873..2a400eb69e66 100644
--- a/crypto/sm3.c
+++ b/crypto/sm3.c
@@ -242,5 +242,5 @@ void sm3_final(struct sm3_state *sctx, u8 *out)
 }
 EXPORT_SYMBOL_GPL(sm3_final);
 
-MODULE_DESCRIPTION("Generic SM3 library");
+MODULE_DESCRIPTION("SM3 Secure Hash Algorithm generic library");
 MODULE_LICENSE("GPL v2");
diff --git a/crypto/sm4.c b/crypto/sm4.c
index 2c44193bc27e..d46b598b41cd 100644
--- a/crypto/sm4.c
+++ b/crypto/sm4.c
@@ -180,5 +180,5 @@ void sm4_crypt_block(const u32 *rk, u8 *out, const u8 *in)
 }
 EXPORT_SYMBOL_GPL(sm4_crypt_block);
 
-MODULE_DESCRIPTION("Generic SM4 library");
+MODULE_DESCRIPTION("SM4 Cipher Algorithm generic library");
 MODULE_LICENSE("GPL v2");
diff --git a/crypto/twofish_common.c b/crypto/twofish_common.c
index f921f30334f4..daa28045069d 100644
--- a/crypto/twofish_common.c
+++ b/crypto/twofish_common.c
@@ -690,4 +690,4 @@ int twofish_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key_len)
 EXPORT_SYMBOL_GPL(twofish_setkey);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Twofish cipher common functions");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm common functions");
diff --git a/crypto/twofish_generic.c b/crypto/twofish_generic.c
index 86b2f067a416..4fe42b4ac82d 100644
--- a/crypto/twofish_generic.c
+++ b/crypto/twofish_generic.c
@@ -191,6 +191,6 @@ subsys_initcall(twofish_mod_init);
 module_exit(twofish_mod_fini);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION ("Twofish Cipher Algorithm");
+MODULE_DESCRIPTION("Twofish Cipher Algorithm");
 MODULE_ALIAS_CRYPTO("twofish");
 MODULE_ALIAS_CRYPTO("twofish-generic");
-- 
2.38.1

