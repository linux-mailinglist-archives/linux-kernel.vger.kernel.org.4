Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81962553D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKKI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiKKI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:28:08 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA77C8D1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668155272;
        bh=440tdOgRvZWc41z+APw8pzc/1fxq4KZk2Kq9gja1stY=;
        h=From:To:Cc:Subject:Date;
        b=hCeKz1wPmOjqdJYQeqUudEW1mrT2/zE7qUxXVewuebIff+S9l7ZGkw7mc9OLRuhZ4
         JP/Prk9xQsTI7dMWD2ausOgJJsql7pZM0lFmM8L2uCM6vXE7Zsqk7m4496eTRcA05s
         vLgmOy96wH1gb6dCqlS2TKZ/FTA+KEM474muYhps=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id 6F1AFAD3; Fri, 11 Nov 2022 16:27:49 +0800
X-QQ-mid: xmsmtpt1668155269tn3jlflf6
Message-ID: <tencent_4ADFD1244465037D21D3AC9F4B0295E0D707@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7ZCpxOMXQCCpq4teOVedac8szQldECuI6sly4QamEyUkfidFM3tw
         fokrHqUTlarLM2aRUPfVQHIxh7uPR5+Q08PkOZifKM0uKwe77DxX8xHFWIvD+V8R9H5sq5F0+pmt
         iddUCAs0mE49NrILXJzlPMBtuM7zJG8JwvCWpaBaxnq7j+riydyOlcF02vOIuqsh4SqDoDXlFw95
         1nw+KLHiS8f68Njeb0g7Tqw2hgDTbydPhTdTEPWduvo+EQUMMlYNNiYYYotXbRiUB38KO5VIJ22R
         Lz51qQj6dvFVei0Oqpz1i8vuoePu2V0GA5CgC5FyWLO5/2P+hPLzigVr57dYYpii0wYUnbYvb6eU
         qhfTfD3nMrlwU54hr44S/oFie8BcOnOVmOAsLaWHhoCHF0JgcavV06rf3p6M4P27wNlH0lMNvfiK
         yJ4ouPIqppB2ePLEzoQWWK4r7wZh3dXp1VCuvPOXb+TX8SohY3hXGUIRInIVu9agLTCQdo2py4Zf
         rDUWqSavmVdyj1y+iGe/ffHEUKB5ZzhYHKRjf4+kHh5haVHGG0wTUj1TiuUkYCOHxg0cy1jyk3jJ
         dp5M+tbkMEnKwco64AeKPG6l/EKDQ3HxCTOJ87RzobgppIH4g8uz6GhNIeIdDl7KjXqoVliq4smJ
         aoXlD1lDcWclrC7/wumX3lXvSTHCyFvTV9pRSIInJg6wxFjqs7z0ci0crv7J9ExAjGrb+rX4TEad
         u0VUREl0NOwqukZVu2kSkSpA6u9mLPCGQw217BKC5/fEipjpfIv9v+nVIwQeESqiBJJjbonKGR9H
         0oOFsxHowWFlc17XSaaBeXXz9oDtD23KP5BxGb3sFz75gXL3WMfHUA/iYNI43qzX5gb704HDzrOt
         FJaeGFeO8tqa1qcL8bXILi1CD+5U0TivRd88HVQzH4wFZSzusOCCFGwqkunEYqj400oFEomZOU3h
         FnjlYhz8sUQ4klFEyFxmEJ1zcz40aZzVCXYWa1gMU4ufmDocjyBA==
From:   Rong Tao <rtoax@foxmail.com>
To:     alexs@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs/zh_CN: Update zh_CN/arm64/elf_hwcaps.rst
Date:   Fri, 11 Nov 2022 16:27:47 +0800
X-OQ-MSGID: <20221111082747.450696-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Add updates from the Documentation/arm64/elf_hwcaps.rst, and synchronize
the changes of commit 5d8505fd039c("arm64: Fix the documented event stream
frequency").

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../translations/zh_CN/arm64/elf_hwcaps.rst   | 80 ++++++++++++++-----
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst b/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
index 9aa4637eac97..e34fab15deb2 100644
--- a/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_CN/arm64/elf_hwcaps.rst
@@ -2,7 +2,15 @@
 
 :Original: :ref:`Documentation/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
 
-Translator: Bailu Lin <bailu.lin@vivo.com>
+:Translator:
+
+ Bailu Lin <bailu.lin@vivo.com>
+
+:校译:
+
+ 荣涛 Rong Tao <rongtao@cestc.cn>
+
+.. _cn_elf_hwcaps_index:
 
 ================
 ARM64 ELF hwcaps
@@ -65,7 +73,7 @@ HWCAP_ASIMD
     ID_AA64PFR0_EL1.AdvSIMD == 0b0000 表示有此功能。
 
 HWCAP_EVTSTRM
-    通用计时器频率配置为大约100KHz以生成事件。
+    通用计时器频率配置为大约10KHz以生成事件。
 
 HWCAP_AES
     ID_AA64ISAR0_EL1.AES == 0b0001 表示有此功能。
@@ -162,77 +170,109 @@ HWCAP_PACG
     表示有此功能。
 
 HWCAP2_DCPODP
-
     ID_AA64ISAR1_EL1.DPB == 0b0010 表示有此功能。
 
 HWCAP2_SVE2
-
     ID_AA64ZFR0_EL1.SVEVer == 0b0001 表示有此功能。
 
 HWCAP2_SVEAES
-
     ID_AA64ZFR0_EL1.AES == 0b0001 表示有此功能。
 
 HWCAP2_SVEPMULL
-
     ID_AA64ZFR0_EL1.AES == 0b0010 表示有此功能。
 
 HWCAP2_SVEBITPERM
-
     ID_AA64ZFR0_EL1.BitPerm == 0b0001 表示有此功能。
 
 HWCAP2_SVESHA3
-
     ID_AA64ZFR0_EL1.SHA3 == 0b0001 表示有此功能。
 
 HWCAP2_SVESM4
-
     ID_AA64ZFR0_EL1.SM4 == 0b0001 表示有此功能。
 
 HWCAP2_FLAGM2
-
     ID_AA64ISAR0_EL1.TS == 0b0010 表示有此功能。
 
 HWCAP2_FRINT
-
     ID_AA64ISAR1_EL1.FRINTTS == 0b0001 表示有此功能。
 
 HWCAP2_SVEI8MM
-
     ID_AA64ZFR0_EL1.I8MM == 0b0001 表示有此功能。
 
 HWCAP2_SVEF32MM
-
     ID_AA64ZFR0_EL1.F32MM == 0b0001 表示有此功能。
 
 HWCAP2_SVEF64MM
-
     ID_AA64ZFR0_EL1.F64MM == 0b0001 表示有此功能。
 
 HWCAP2_SVEBF16
-
     ID_AA64ZFR0_EL1.BF16 == 0b0001 表示有此功能。
 
 HWCAP2_I8MM
-
     ID_AA64ISAR1_EL1.I8MM == 0b0001 表示有此功能。
 
 HWCAP2_BF16
-
     ID_AA64ISAR1_EL1.BF16 == 0b0001 表示有此功能。
 
 HWCAP2_DGH
-
     ID_AA64ISAR1_EL1.DGH == 0b0001 表示有此功能。
 
 HWCAP2_RNG
-
     ID_AA64ISAR0_EL1.RNDR == 0b0001 表示有此功能。
 
 HWCAP2_BTI
-
     ID_AA64PFR0_EL1.BT == 0b0001 表示有此功能。
 
+HWCAP2_MTE
+    ID_AA64PFR1_EL1.MTE == 0b0010 表示有此功能，如
+    Documentation/arm64/memory-tagging-extension.rst 所描述。
+
+HWCAP2_ECV
+    ID_AA64MMFR0_EL1.ECV == 0b0001 表示有此功能。
+
+HWCAP2_AFP
+    ID_AA64MFR1_EL1.AFP == 0b0001 表示有此功能。
+
+HWCAP2_RPRES
+    ID_AA64ISAR2_EL1.RPRES == 0b0001 表示有此功能。
+
+HWCAP2_MTE3
+    ID_AA64PFR1_EL1.MTE == 0b0011 表示有此功能，如
+    Documentation/arm64/memory-tagging-extension.rst 所描述。
+
+HWCAP2_SME
+    ID_AA64PFR1_EL1.SME == 0b0001 表示有此功能，如
+    Documentation/arm64/sme.rst 所描述。
+
+HWCAP2_SME_I16I64
+    ID_AA64SMFR0_EL1.I16I64 == 0b1111 表示有此功能。
+
+HWCAP2_SME_F64F64
+    ID_AA64SMFR0_EL1.F64F64 == 0b1 表示有此功能。
+
+HWCAP2_SME_I8I32
+    ID_AA64SMFR0_EL1.I8I32 == 0b1111 表示有此功能。
+
+HWCAP2_SME_F16F32
+    ID_AA64SMFR0_EL1.F16F32 == 0b1 表示有此功能。
+
+HWCAP2_SME_B16F32
+    ID_AA64SMFR0_EL1.B16F32 == 0b1 表示有此功能。
+
+HWCAP2_SME_F32F32
+    ID_AA64SMFR0_EL1.F32F32 == 0b1 表示有此功能。
+
+HWCAP2_SME_FA64
+    ID_AA64SMFR0_EL1.FA64 == 0b1 表示有此功能。
+
+HWCAP2_WFXT
+    ID_AA64ISAR2_EL1.WFXT == 0b0010 表示有此功能。
+
+HWCAP2_EBF16
+    ID_AA64ISAR1_EL1.BF16 == 0b0010 表示有此功能。
+
+HWCAP2_SVE_EBF16
+    ID_AA64ZFR0_EL1.BF16 == 0b0010 表示有此功能。
 
 4. 未使用的 AT_HWCAP 位
 -----------------------
-- 
2.31.1

