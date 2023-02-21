Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FDA69D95C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjBUDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBUDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:40:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF223318;
        Mon, 20 Feb 2023 19:40:36 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L0vqSC030155;
        Tue, 21 Feb 2023 03:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u3wDpkeXbTOvIr9CdQoo9K3zyUUaAGL5MZvQ9M7A0W0=;
 b=JxWasmwb/M78rYvjzf8BKziyQazrZkj2v9UNZ8sbHSn7/GxnrcZQER/n2DxiCcyXHXE8
 geMr21sO7yVMZSNAKmvz8qWtdNUjzl0cD6CFnC5pcx6jsBOISOCjbyFA/MulMoF/vhE5
 npO+OTvhpN6I2AcnufhY4+zBK6o2k3UHO3GJnzBI+uM9E7oT0z19b7nUhZW9SMoBiOAB
 m1EVdBkhYj1oWlogscTnnrpe5jYFl/0UO5owImF6rGd5h6Fe1NniOzEV7YGKtTeShwVD
 TE7BeRqyXoaLRlliIjNSk0Sj9pC4ydnn/b0Tpulf5SBA2lZ1AMj4FPSHGdG1tWyucthQ Pg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvkvktpdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:40:32 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L2ku2t015807;
        Tue, 21 Feb 2023 03:40:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6rmng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:40:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31L3eTQS11338378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 03:40:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFB5A58057;
        Tue, 21 Feb 2023 03:40:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 872DA58058;
        Tue, 21 Feb 2023 03:40:29 +0000 (GMT)
Received: from ltcden12-lp3.aus.stglabs.ibm.com (unknown [9.40.195.53])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 03:40:29 +0000 (GMT)
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: [RESEND PATCH v4 6/6] Update Kconfig and Makefile.
Date:   Mon, 20 Feb 2023 22:40:21 -0500
Message-Id: <20230221034021.15121-7-dtsen@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230221034021.15121-1-dtsen@linux.ibm.com>
References: <20230221034021.15121-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vq0Au3n5ltiwg_Mfmshpo_37RQB7YVxh
X-Proofpoint-ORIG-GUID: Vq0Au3n5ltiwg_Mfmshpo_37RQB7YVxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_19,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302210030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined CRYPTO_AES_GCM_P10 in Kconfig to support AES/GCM
stitched implementation for Power10 or later CPU.

Added a new module driver aes-gcm-p10-crypto.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/Kconfig  | 17 +++++++++++++++++
 arch/powerpc/crypto/Makefile | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index c1b964447401..1f8f02b494e1 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -94,4 +94,21 @@ config CRYPTO_AES_PPC_SPE
 	  architecture specific assembler implementations that work on 1KB
 	  tables or 256 bytes S-boxes.
 
+config CRYPTO_AES_GCM_P10
+	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
+	depends on PPC64 && POWER10_CPU && CPU_LITTLE_ENDIAN
+	select CRYPTO_LIB_AES
+	select CRYPTO_ALGAPI
+	select CRYPTO_AEAD
+	default m
+	help
+	  AEAD cipher: AES cipher algorithms (FIPS-197)
+	  GCM (Galois/Counter Mode) authenticated encryption mode (NIST SP800-38D)
+	  Architecture: powerpc64 using:
+	    - little-endian
+	    - Power10 or later features
+
+	  Support for cryptographic acceleration instructions on Power10 or
+	  later CPU. This module supports stitched acceleration for AES/GCM.
+
 endmenu
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 4808d97fede5..05c7486f42c5 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
 obj-$(CONFIG_CRYPTO_CRC32C_VPMSUM) += crc32c-vpmsum.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF_VPMSUM) += crct10dif-vpmsum.o
 obj-$(CONFIG_CRYPTO_VPMSUM_TESTER) += crc-vpmsum_test.o
+obj-$(CONFIG_CRYPTO_AES_GCM_P10) += aes-gcm-p10-crypto.o
 
 aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
 md5-ppc-y := md5-asm.o md5-glue.o
@@ -21,3 +22,15 @@ sha1-ppc-spe-y := sha1-spe-asm.o sha1-spe-glue.o
 sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
 crc32c-vpmsum-y := crc32c-vpmsum_asm.o crc32c-vpmsum_glue.o
 crct10dif-vpmsum-y := crct10dif-vpmsum_asm.o crct10dif-vpmsum_glue.o
+aes-gcm-p10-crypto-y := aes-gcm-p10-glue.o aes-gcm-p10.o ghashp8-ppc.o aesp8-ppc.o
+
+quiet_cmd_perl = PERL    $@
+      cmd_perl = $(PERL) $< $(if $(CONFIG_CPU_LITTLE_ENDIAN), linux-ppc64le, linux-ppc64) > $@
+
+targets += aesp8-ppc.S ghashp8-ppc.S
+
+$(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
+	$(call if_changed,perl)
+
+OBJECT_FILES_NON_STANDARD_aesp8-ppc.o := y
+OBJECT_FILES_NON_STANDARD_ghashp8-ppc.o := y
-- 
2.31.1

