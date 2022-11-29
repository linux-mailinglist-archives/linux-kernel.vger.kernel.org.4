Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006C63BF76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiK2Lyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiK2Lyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:54:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D554B3B;
        Tue, 29 Nov 2022 03:54:44 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATBIOht022888;
        Tue, 29 Nov 2022 11:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=DDN8rVl+bpX39wsMmtBu4zAD3/8mE0dKx+jGxLGVP0k=;
 b=PBAlmsi/4t7//jurN6Y3sIGU+iNFiS2anqgZIQMDndU+Mz+aIrrdzaSHdF7O1YWdSxZe
 7JeDu08Kn2eMIeOGjXnfjdPM+IoZg6sZy3cfZs4WXqpHRnERvXx98lR9fU7rNXaPdH0e
 GPQEI4b55iW0or9GwIJ1/MF6QriiQM4vouX9g8AIyDR+13v3KN/wMzlvVXwd9cx0sLrw
 7Qsd3WdIdeDJmNJwAU7kZRcikd5vk5fmbuarB4OvExZDQb5ocEl+b4oattho2cg2+7zY
 PNhSMRLF+4vJcDPw5oAv3QGj4uRDUye/HJTc9TlNmAzEJBgboL5egEaCQ8N/7NrhifQW 8w== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5h3f0qep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:53:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATBpfEr028674;
        Tue, 29 Nov 2022 11:53:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3m3ae9c9yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 11:53:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATBrUY633161624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 11:53:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEFF25805D;
        Tue, 29 Nov 2022 11:53:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A85B58057;
        Tue, 29 Nov 2022 11:53:27 +0000 (GMT)
Received: from Dannys-MacBook-Pro.local (unknown [9.211.123.96])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Nov 2022 11:53:27 +0000 (GMT)
Date:   Tue, 29 Nov 2022 19:53:19 +0800
From:   Danny Tsen <dtsen@linux.ibm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@linux.ibm.com
Subject: [PATCH 1/6] crypto: Update Kconfig and Makefile.
Message-ID: <Y4XyrwXxv225exkb@Dannys-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PcO-8zCP8g_Y0bkd7N4fwmzjIA0492yK
X-Proofpoint-ORIG-GUID: PcO-8zCP8g_Y0bkd7N4fwmzjIA0492yK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined CRYPTO_P10_AES_GCM in Kconfig to support AES/GCM
stitched implementation for Power10+ CPU.

Added a new module driver p10-aes-gcm-crypto.

Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
---
 arch/powerpc/crypto/Kconfig  | 11 +++++++++++
 arch/powerpc/crypto/Makefile | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index c1b964447401..db7d99383993 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -94,4 +94,15 @@ config CRYPTO_AES_PPC_SPE
 	  architecture specific assembler implementations that work on 1KB
 	  tables or 256 bytes S-boxes.
 
+config CRYPTO_P10_AES_GCM
+	tristate "Stitched AES/GCM acceleration support on P10+ CPU (PPC)"
+	depends on PPC64
+	select CRYPTO_LIB_AES
+	select CRYPTO_ALGAPI
+	select CRYPTO_AEAD
+	default m
+	help
+	  Support for cryptographic acceleration instructions on Power10+ CPU.
+	    This module supports stitched acceleration for AES/GCM in hardware.
+
 endmenu
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 4808d97fede5..5b8252013abd 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
 obj-$(CONFIG_CRYPTO_CRC32C_VPMSUM) += crc32c-vpmsum.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF_VPMSUM) += crct10dif-vpmsum.o
 obj-$(CONFIG_CRYPTO_VPMSUM_TESTER) += crc-vpmsum_test.o
+obj-$(CONFIG_CRYPTO_P10_AES_GCM) += p10-aes-gcm-crypto.o
 
 aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
 md5-ppc-y := md5-asm.o md5-glue.o
@@ -21,3 +22,12 @@ sha1-ppc-spe-y := sha1-spe-asm.o sha1-spe-glue.o
 sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
 crc32c-vpmsum-y := crc32c-vpmsum_asm.o crc32c-vpmsum_glue.o
 crct10dif-vpmsum-y := crct10dif-vpmsum_asm.o crct10dif-vpmsum_glue.o
+p10-aes-gcm-crypto-y := p10-aes-gcm-glue.o p10_aes_gcm.o ghashp8-ppc.o aesp8-ppc.o
+
+quiet_cmd_perl = PERL    $@
+      cmd_perl = $(PERL) $< $(if $(CONFIG_CPU_LITTLE_ENDIAN), linux-ppc64le, linux-ppc64) > $@
+
+targets += aesp8-ppc.S ghashp8-ppc.S
+
+$(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
+	$(call if_changed,perl)
-- 
2.31.1


