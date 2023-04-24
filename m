Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44B6ED4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjDXSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjDXSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CFA6EB7;
        Mon, 24 Apr 2023 11:47:49 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OIbZsW011995;
        Mon, 24 Apr 2023 18:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9PrGG528GTcQxlCdN7mIPHt0tiYSjTjbp7FJM+r0+EY=;
 b=KHavrHKNZuxrkeRd/0tQtjDUHoKjpuhmZaGC/jrjAhPygFMwXyGM8csezjJAW+xChhQg
 TaFCJXHv8mVnMAmpEf6N9y59+P8lCbscrslfiv0X8QVdsXXyn7K2vsT+/E4t2QbGJVph
 V3LAeMzheGDM2/kQOt1m5g1xV48H6LG5/rBBwq55dklASKyfR4MVdg00b1doOvifHq9U
 HE6tXp30szesp4C12Fx3ScaIffk9OHo4O3YHU3XEur1ZifabR2X0vKlZcNP8XDwuPXWf
 M7j9EJtS1Hfuf76QjOpZidKHtTePii2V71aVpnpEAxzSNzfiWvVKhSunss6WQTxR8fZZ Iw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r7yytk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33OGffIi006092;
        Mon, 24 Apr 2023 18:47:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q4778qkeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:47:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OIlaN210552036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 18:47:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CF2E5805C;
        Mon, 24 Apr 2023 18:47:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D213558051;
        Mon, 24 Apr 2023 18:47:35 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 18:47:35 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: [PATCH 5/5] Update Kconfig and Makefile.
Date:   Mon, 24 Apr 2023 14:47:26 -0400
Message-Id: <20230424184726.2091-6-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230424184726.2091-1-dtsen@linux.ibm.com>
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -9QwshnhiWNwlVHUc2gWWmtYtLYBiaaT
X-Proofpoint-ORIG-GUID: -9QwshnhiWNwlVHUc2gWWmtYtLYBiaaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined CRYPTO_CHACHA20_P10 and CRYPTO POLY1305_P10 in Kconfig to
support optimized implementation for Power10 and later CPU.

Added new module driver chacha-p10-crypto and poly1305-p10-crypto.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/Kconfig  | 26 ++++++++++++++++++++++++++
 arch/powerpc/crypto/Makefile |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 7113f9355165..f74d9dd6574b 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -111,4 +111,30 @@ config CRYPTO_AES_GCM_P10
 	  Support for cryptographic acceleration instructions on Power10 or
 	  later CPU. This module supports stitched acceleration for AES/GCM.
 
+config CRYPTO_CHACHA20_P10
+	tristate "Ciphers: ChaCha20, XChacha20, XChacha12 (P10 or later)"
+	depends on PPC64 && CPU_LITTLE_ENDIAN
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
+	  stream cipher algorithms
+
+	  Architecture: PowerPC64
+	  - Power10 or later
+	  - Little-endian
+
+config CRYPTO_POLY1305_P10
+	tristate "Hash functions: Poly1305 (P10 or later)"
+	depends on PPC64 && CPU_LITTLE_ENDIAN
+	select CRYPTO_HASH
+	select CRYPTO_LIB_POLY1305_GENERIC
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Architecture: PowerPC64
+	  - Power10 or later
+	  - Little-endian
+
 endmenu
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 05c7486f42c5..cd5282eff451 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_CRYPTO_CRC32C_VPMSUM) += crc32c-vpmsum.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF_VPMSUM) += crct10dif-vpmsum.o
 obj-$(CONFIG_CRYPTO_VPMSUM_TESTER) += crc-vpmsum_test.o
 obj-$(CONFIG_CRYPTO_AES_GCM_P10) += aes-gcm-p10-crypto.o
+obj-$(CONFIG_CRYPTO_CHACHA20_P10) += chacha-p10-crypto.o
+obj-$(CONFIG_CRYPTO_POLY1305_P10) += poly1305-p10-crypto.o
 
 aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
 md5-ppc-y := md5-asm.o md5-glue.o
@@ -23,6 +25,8 @@ sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
 crc32c-vpmsum-y := crc32c-vpmsum_asm.o crc32c-vpmsum_glue.o
 crct10dif-vpmsum-y := crct10dif-vpmsum_asm.o crct10dif-vpmsum_glue.o
 aes-gcm-p10-crypto-y := aes-gcm-p10-glue.o aes-gcm-p10.o ghashp8-ppc.o aesp8-ppc.o
+chacha-p10-crypto-y := chacha-p10-glue.o chacha-p10le-8x.o
+poly1305-p10-crypto-y := poly1305-p10-glue.o poly1305-p10le_64.o
 
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $< $(if $(CONFIG_CPU_LITTLE_ENDIAN), linux-ppc64le, linux-ppc64) > $@
-- 
2.31.1

