Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A225BFD67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIUL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiIUL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:58:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D408990E;
        Wed, 21 Sep 2022 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663761490; x=1695297490;
  h=from:to:cc:subject:date:message-id;
  bh=2bJGnHUJfaobfAgKoqb02TA2znrcQYe9ntdHUUjDVIE=;
  b=RGWEGavJIFDPMkUn7hVZgzx24kRMeZOJyOUee9Xula1I9LTHMS8lSnbI
   vD2FwLXlR+uIb90TyWIowHNeEXBDTJ4DMPdZPQ2FccZU9xyn/z9tIOuik
   B2/aEmTgq9s06srSEgfaQ1g9SSqPHrOCT3CKBWwoz6rR/q1CFwwP/FECG
   9OHYDnw87zBeZHc07ZwpgX5QdRmD/B1PlNpmAy1FVxrgsOCHcoUUQxXzc
   WWCv5ZUcj3U7yYS7hyandfzpVgN+rSTyu8mO1CWazsePJ/K18jkMjzVCD
   EVN4vsCGC3HvwruiilXjDwLdZcuNqMM+0d4Yj3y8UGWE8ixrNhKYnvb1R
   A==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="217086021"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 19:58:10 +0800
IronPort-SDR: 2aoHHjpSqELSIDlmRrcDH67X0srwgmHXuCOkgwx/Q2BgmbRau61FoYOmbvedsMTahxQHIHo5C7
 U9QWi7Zi6C5cKut2RvI+PSilRTEPBNDxPNex4yd/YvssA18MsI+3DzVuqnuZYtEqTL7tOI3KSd
 nZG9MmYglFnNCqXtZ1yFX2ig6A+T1iVcT4hpYK57irjtCUSoPmVtk1f2G1j2V1ZHrMfCiOoIYu
 d2/rfMttOl8cX1NiGmuqXHHuRQWQJ4XmnBepzsdUArjufFou1xtfl5TkBjWwQ2EEUcdPiHIkAy
 WuymkWQ4o2hAb7t2xYDypRV2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 04:12:45 -0700
IronPort-SDR: nSFiIRDyYFAN9/vvxxeJNSpo30SxjZK7lCVRG1DWR3g9y0QpL1w9M74t9nj1rT43lFZcWdmhyo
 oaGHjmIAvToE9JPi3mDtn9AYKxpsC3V7soW3qZcnoFgRU0IAeHhNwgGT5pNOHjNvRf4E0i5RDg
 /WyBx86u+UiIJAcUpsRd9wbG2jOi0j9pCJ+TxG3ETzNoOief9AB6eIo7cD10d9z++JztyQPOlA
 5crQpzu346pasEpZw+ZduoGcCNIHIXJf5YrKJMrTksgBOQJpLH0JY2dy1SlFl6mwwiZwCYYZI9
 o3s=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Sep 2022 04:58:09 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     -cc=avri.altman@wdc.com, Avi.Shchislowski@wdc.com,
        beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2] scsi: ufs: Remove redundant function definitions from ufshcd.h
Date:   Wed, 21 Sep 2022 14:58:05 +0300
Message-Id: <1663761485-2532-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Remove redundant comment, modify commit message

This patch removes Query-Request API functions declaration from
include/ufs/ufshcd.h. Those declarations solely to
ufs core private header.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd-priv.h |  5 +++++
 include/ufs/ufshcd.h           | 20 --------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d00dba1..f68ca33 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -42,6 +42,11 @@ static inline void ufs_hwmon_remove(struct ufs_hba *hba) {}
 static inline void ufs_hwmon_notify_event(struct ufs_hba *hba, u8 ee_mask) {}
 #endif
 
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
+				  enum query_opcode opcode,
+				  enum desc_idn idn, u8 index,
+				  u8 selector,
+				  u8 *desc_buf, int *buf_len);
 int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 24c97e0..9f28349 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1175,26 +1175,6 @@ static inline int ufshcd_disable_host_tx_lcc(struct ufs_hba *hba)
 	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
 }
 
-/* Expose Query-Request API */
-int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
-				  enum query_opcode opcode,
-				  enum desc_idn idn, u8 index,
-				  u8 selector,
-				  u8 *desc_buf, int *buf_len);
-int ufshcd_read_desc_param(struct ufs_hba *hba,
-			   enum desc_idn desc_id,
-			   int desc_index,
-			   u8 param_offset,
-			   u8 *param_read_buf,
-			   u8 param_size);
-int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
-			    enum attr_idn idn, u8 index, u8 selector,
-			    u32 *attr_val);
-int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
-		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
-int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-	enum flag_idn idn, u8 index, bool *flag_res);
-
 void ufshcd_auto_hibern8_enable(struct ufs_hba *hba);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
-- 
2.7.4

